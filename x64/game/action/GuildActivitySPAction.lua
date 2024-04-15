slot1, slot2 = nil

manager.net:Bind(70001, function (slot0)
	GuildActivitySPData:InitActivityID(slot0.activity_id)
	GuildActivitySPData:InitMainDataFromServer(slot0)
	uv0.UpdateRedPoint()
	uv0.UpdataOutActivityAffix()
end)
manager.net:Bind(70003, function (slot0)
	GuildActivitySPData:InitActivityID(slot0.activity_id)
	GuildActivitySPData:UpdateGridsDataFromServer(slot0.grid_status)
	uv0.UpdateRedPoint()
end)
manager.net:Bind(70005, function (slot0)
	GuildActivitySPData:InitActivityID(slot0.activity_id)
	GuildActivitySPData:UpdateGuildActivityHeroes(slot0.hero_list)

	slot1 = GuildActivitySPData:GetCurMainActivityID()

	uv0.UpdateOnFightNotFullRedPoint(slot1)
	uv0.UpdateOnHeroFightFullRedPoint(slot1)
end)
manager.net:Bind(70007, function (slot0)
	GuildActivitySPData:InitActivityID(slot0.activity_id)
	GuildActivitySPData:UpdateSelfGridDataFromServer(slot0)
	uv0.UpdateRedPoint()
end)
manager.net:Bind(70009, function (slot0)
	GuildActivitySPData:InitActivityID(slot0.activity_id)
	GuildActivitySPData:SetIsSignFromServer(slot0.is_sign)
	uv0.UpdateRedPoint()
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function ()
	uv0.UpdateOnFightNotFullRedPoint(GuildActivitySPData:GetCurRunActivityID())
end)
manager.notify:RegistListener(HISTORY_UPDATE, function ()
	uv0.UpdataImmediatelyRedPoint()
end)

return {
	Init = function ()
		uv0 = false
		uv1 = false
	end,
	UpdateRedPoint = function ()
		if GuildActivitySPData:GetCurMainActivityID() and ActivityData:GetActivityIsOpen(slot0) then
			slot1 = GuildActivitySPTools.GetCurActivityIDInfo(slot0).start

			if ActivityData:GetActivityIsOpen(GuildActivitySPTools.GetCurActivityIDInfo(slot0).register) then
				uv0.UpdateUnregisterRedPoint()
			end

			if ActivityData:GetActivityIsOpen(slot0) then
				uv0.UpdateUnregisterRedPoint()
				uv0.UpdateCoinRedPoint()
				uv0.UpdataImmediatelyRedPoint()
			end
		end
	end,
	UpdataImmediatelyRedPoint = function ()
		if ActivityData:GetActivityIsOpen(GuildActivitySPData:GetCurMainActivityID()) then
			uv0.UpdateOnFightNotFullRedPoint()
			uv0.UpdateOnHeroFightFullRedPoint()
			uv0.UpdataHadAwardRedPoint()
		end
	end,
	UpdateUnregisterRedPoint = function ()
		slot0 = true

		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			slot0 = false
		end

		manager.redPoint:setTip(RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER, slot0 and not uv0.GetUnRegisterRedPointClicked() and not GuildActivitySPData:HaveRegister() and ActivityData:GetActivityIsOpen(GuildActivitySPData:GetCurMainActivityID()) and 1 or 0)
	end,
	UpdateCoinRedPoint = function ()
		if not GuildActivitySPData:GetCurRunActivityID() or not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		slot1 = true

		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			slot1 = false
		end

		slot2 = GuildActivitySPData:IsAllAffixMax(slot0)
		slot4 = false

		if GameSetting.activity_club_sp_red_dot_need.value[1] <= GuildActivitySPData:GetTotalCoinToGet() then
			slot4 = true
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_UNGET_COIN, slot0), slot1 and not slot2 and ActivityData:GetActivityIsOpen(slot0) and not uv0.GetCoinRedPointClicked() and slot4 and 1 or 0)
	end,
	UpdateOnFightNotFullRedPoint = function ()
		if not GuildActivitySPData:GetCurRunActivityID() or not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		slot1 = true

		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			slot1 = false
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, slot0), slot1 and ActivityData:GetActivityIsOpen(slot0) and GuildActivitySPData:HaveRegister() and not (math.min(GuildActivitySPData:CanTakeOnFightNum(), HeroData:GetHeroNum()) <= GuildActivitySPData:HaveTakeOnFightNum()) and 1 or 0)
	end,
	UpdataOutActivityAffix = function ()
		if not GuildActivitySPData:GetCurRunActivityID() or not ActivityData:GetActivityIsOpen(slot0) then
			if not slot0 then
				return
			end

			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, slot0), 0)

			return
		end

		if GuildActivitySPData:RefreshAffixRedPoint() then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, slot0), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, slot0), 0)
		end
	end,
	UpdataHadAwardRedPoint = function ()
		if not GuildActivitySPData:GetCurRunActivityID() or not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		for slot6, slot7 in ipairs(GuildActivitySPData:GetSortedRateIDList(slot0)) do
			if not (table.keyof(GuildActivitySPData:GetReceivedList(), ActivityClubSPLevelSettingCfg[slot7].user_level) ~= nil) and ActivityClubSPLevelSettingCfg[slot7].user_level <= ActivityClubSPLevelSettingCfg[GuildActivitySPData:GetCurRateID(slot0)].user_level then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_BONUS, slot0), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_BONUS, slot0), 0)
	end,
	UpdateOnHeroFightFullRedPoint = function ()
		if not GuildActivitySPData:GetCurRunActivityID() or not ActivityData:GetActivityIsOpen(slot0) then
			return
		end

		slot1 = ActivityData:GetActivityIsOpen(slot0)
		slot2 = GuildActivitySPData:CheckHeroFightIsFull()
		slot4 = false

		if GuildActivitySPData:GetCurRateID(slot0) == ActivityClubSPLevelSettingCfg.all[#ActivityClubSPLevelSettingCfg.all] then
			slot4 = true
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_HERO_FIGHT, slot0), slot1 and GuildActivitySPData:HaveRegister() and slot2 and not slot4 and 1 or 0)
	end,
	SetUnRegisterRedPointClicked = function (slot0)
		uv0 = slot0

		uv1.UpdateUnregisterRedPoint()
	end,
	GetUnRegisterRedPointClicked = function ()
		return uv0
	end,
	SetCoinRedPointClicked = function (slot0, slot1)
		uv0 = slot0

		uv1.UpdateCoinRedPoint()
	end,
	GetCoinRedPointClicked = function ()
		return uv0
	end,
	Register = function (slot0)
		manager.net:SendWithLoadingNew(70010, {}, 70011, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ShowTips("ACTIVITY_CLUB_REGISTER_SUCCESS")
				GuildActivitySPData:SignUpSuccess()
				uv0()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	EnterGuildWarField = function (slot0)
		manager.net:SendWithLoadingNew(70012, {}, 70013, function (slot0, slot1)
			if isSuccess(slot0.result) then
				GuildActivitySPData:InitGridsDataFromServer(slot0.grid_status)
				uv0()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	ExitGuildWarField = function (slot0)
		manager.net:SendWithLoadingNew(70014, {}, 70015, function (slot0, slot1)
			if isSuccess(slot0.result) then
				uv0()
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	GetFightRecord = function (slot0, slot1)
		manager.net:SendWithLoadingNew(70020, {
			id = slot0
		}, 70021, function (slot0, slot1)
			if isSuccess(slot0.result) then
				slot2 = {}

				for slot6, slot7 in ipairs(slot0.records) do
					table.insert(slot2, {
						uid = slot7.uid,
						icon = slot7.base_info.icon,
						icon_frame = slot7.base_info.icon_frame,
						name = slot7.base_info.nick,
						damage = slot7.damage,
						hero_list = slot7.hero_list,
						timestamp = slot7.timestamp
					})
				end

				table.sort(slot2, function (slot0, slot1)
					return slot1.damage < slot0.damage
				end)
				uv0(slot2)
			else
				ShowTips(GetTips(slot0.result))
			end
		end)
	end,
	SetFightMember = function (slot0, slot1)
		manager.net:SendWithLoadingNew(70022, {
			up_hero_id_list = slot0,
			down_hero_id_list = slot1
		}, 70023, uv0.OnSetFightMemberCallback)
	end,
	OnSetFightMemberCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivitySPData:OnSetFightMember()
			uv0.UpdateOnFightNotFullRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	UpgradeAffix = function (slot0, slot1)
		manager.net:SendWithLoadingNew(70024, {
			id = slot0
		}, 70025, function (slot0, slot1)
			if uv0 ~= nil then
				uv0(slot0, slot1)
			end
		end)
	end,
	RequireReceive = function (slot0, slot1)
		manager.net:SendWithLoadingNew(70036, {
			level = ActivityClubSPLevelSettingCfg[slot0].user_level
		}, 70037, slot1)
	end,
	QueryRankList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(70032, {
			id = slot0
		}, 70033, function (slot0, slot1)
			if isSuccess(slot0.result) then
				GuildActivitySPData:SetRankData(slot0)
				uv0()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GiveUpNode = function (slot0)
		manager.net:SendWithLoadingNew(70030, {
			id = slot0
		}, 70031, uv0.OnGiveUpNodeCallback)
	end,
	OnGiveUpNodeCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivitySPData:OnGridGiveUp(slot1.id)

			if itemNum and itemNum > 0 then
				uv0.UpdataOutActivityAffix()
			end

			GuildActivitySPData:RefreshAffixRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	EnterNext = function (slot0)
		manager.net:SendWithLoadingNew(70028, {
			id = slot0
		}, 70029, uv0.OnEnterNextCallback)
	end,
	OnEnterNextCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_ENTER_NEW_LEVEL)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SaveEliteCombatResult = function (slot0)
		manager.net:SendWithLoadingNew(70026, {
			is_save = slot0
		}, 70027, uv0.OnSaveEliteCombatResultCallback)
	end,
	OnSaveEliteCombatResultCallback = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetCoin = function ()
		manager.net:SendWithLoadingNew(70034, {}, 70035, uv0.OnGetCoinCallback)
	end,
	OnGetCoinCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivitySPData:OnGetCoin(slot0.last_receive_time)
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_CHECK_RATE_UPGRADE)
			manager.notify:Invoke(GUILD_ACTIVITY_SP_COIN_GET_FINISH, {})
			GuildActivitySPData:RefreshAffixRedPoint()

			if itemNum and itemNum > 0 then
				uv0.UpdataOutActivityAffix()
			end
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ExitGuildActivity = function ()
		manager.windowBar:ClearWhereTag()
		manager.net:SendWithLoadingNew(70014, {}, 70015, uv0.OnExitGuildActivityCallback)
	end,
	OnExitGuildActivityCallback = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(GetTips(slot0.result))
		end
	end,
	OnLogout = function ()
		if whereami == "guildActivitySP" then
			SceneManager.UnloadSceneAsync("guildActivitySP")
		end
	end,
	Dispatch = function (slot0, slot1)
		manager.net:SendWithLoadingNew(70016, {
			id = slot0,
			cat_id = slot1
		}, 70017, uv0.OnDispatchCallback)
	end,
	OnDispatchCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivitySPData:OnDispatch(slot1.id, slot1.cat_id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	CancelDispatch = function (slot0)
		manager.net:SendWithLoadingNew(70018, {
			id = slot0
		}, 70019, uv0.OnCancelDispatchCallback)
	end,
	OnCancelDispatchCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			GuildActivitySPData:OnCancelDispatch(slot1.id)
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
