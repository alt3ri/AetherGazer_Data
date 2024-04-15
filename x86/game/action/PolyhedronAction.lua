manager.net:Bind(18001, function (slot0)
	slot1 = {}

	if PolyhedronData:GetPolyhedronInfo() ~= nil then
		slot1 = PolyhedronData:GetPolyhedronInfo():GetFightHeroList()
	end

	PolyhedronData:InitPolyhedronGameData(slot0)
	manager.notify:CallUpdateFunc(POLYHEDRON_GAME_UPDATE)

	if #slot1 ~= #PolyhedronData:GetPolyhedronInfo():GetFightHeroList() then
		slot3 = ComboSkillTools.GetRecommendSkillID(slot2, true)

		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), slot3)
		manager.notify:Invoke(COMBO_SKILL_SELECT, slot3)
	elseif not SkillTools.CanUseComboSkill(slot0.game.progress.cooperate_unique_skill_id, slot2) then
		slot4 = ComboSkillTools.GetRecommendSkillID(slot2, true)

		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), slot4)
		manager.notify:Invoke(COMBO_SKILL_SELECT, slot4)
	elseif BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID()) ~= slot3 then
		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), slot3)
		manager.notify:Invoke(COMBO_SKILL_SELECT, slot3)
	end

	uv0.RefreshPolicyRedPoint()
	uv0.CheckBeaconRedPoint()
	uv0.CheckTerminalRedPoint()
	uv0:RefreshHeroesRedPoint()
	uv0.CheckNewRed()
end)
manager.net:Bind(18003, function (slot0)
	PolyhedronData:UpdatePolyhedronProcess(slot0)
	manager.notify:CallUpdateFunc(POLYHEDRON_PROCESS_UPDATE)
end)
manager.net:Bind(18005, function (slot0)
	PolyhedronData:UpdatePolyhedronSettlement(slot0)
	uv0.RefreshPolicyRedPoint()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_POLYHEDRON_TERMINAL_EXP then
		PolyhedronData:UpdateTerminalLevel()

		if PolyhedronData:GetTerminalLevel() ~= PolyhedronData:GetTerminalLevel() then
			uv0.CheckTerminalRedPoint()
		end
	end

	if slot0 == CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS then
		uv0:RefreshHeroesRedPoint()
	end
end)
manager.notify:RegistListener(NEW_DAY, function ()
	PolyhedronData.ResetAlreadyChallengeTimes()
end)
manager.notify:RegistListener(SYSTEM_OPEN_OR_LOCK, function ()
	uv0:CheckNewRed()
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function ()
	uv0:RefreshHeroesRedPoint()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0:RefreshHeroesRedPoint()
	uv0:CheckBeaconRedPoint()
end)

slot1 = nil
slot2 = PolyhedronConst.RANK_TYPE.ALL
slot3 = PolyhedronConst.RANK_SUB_TYPE.SCORE
slot4 = nil

return {
	UpdatePolyhedronNewRed = function ()
		if PolyhedronData:GetIsNewRed() then
			manager.net:SendWithLoadingNew(18034, {}, 18035, uv0.UpdatePolyhedronNewRedBack)
		end
	end,
	UpdatePolyhedronNewRedBack = function (slot0)
		if isSuccess(slot0.result) then
			PolyhedronData:SetNewRedValue(0)
			uv0.CheckNewRed()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryStartPolyhedron = function (slot0, slot1, slot2)
		slot3, slot4 = pcall(function ()
			manager.net:SendWithLoadingNew(18010, {
				hero_id_list = uv0,
				beacon_id_list = uv1,
				difficulty = uv2
			}, 18011, uv3.StartPolyhedronCallBack)
		end)

		if slot4 then
			slot5 = ""

			if slot0 ~= nil then
				for slot9, slot10 in ipairs(slot0) do
					if slot9 ~= #slot0 then
						slot5 = slot5 .. slot0[slot9] .. ","
					end
				end
			else
				slot5 = "nil"
			end

			slot6 = ""

			if slot1 ~= nil then
				for slot10, slot11 in ipairs(slot1) do
					if slot10 ~= #slot1 then
						slot6 = slot6 .. slot1[slot10] .. ","
					end
				end
			else
				slot5 = "nil"
			end

			error(string.format("发给服务端的数据错误：hero_id_list = {%s}, beacon_id_list = {%s}, difficulty = %s", slot5, slot6, tostring(slot2)))
		end
	end,
	StartPolyhedronCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			uv0.LaunchPolyhedronBattle()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRewardPolyhedron = function (slot0)
		manager.net:SendWithLoadingNew(18012, {
			index = slot0
		}, 18013, uv0.RewardPolyhedronCallBack)
	end,
	RewardPolyhedronCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if PolyhedronConst.SAVE_POINT_TYPE.REWARD == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
				gameContext:Go("polyhedronReward")
			else
				JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle")
				DoPolyhedronNextTrigger()
			end
		else
			if PolyhedronConst.SAVE_POINT_TYPE.UNDEFINED == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end

			ShowTips(slot0.result)
		end
	end,
	QueryResetRewardPolyhedron = function ()
		manager.net:SendWithLoadingNew(18030, {}, 18031, uv0.ResetRewardPolyhedronCallBack)
	end,
	ResetRewardPolyhedronCallBack = function (slot0)
		if isSuccess(slot0.result) then
			gameContext:Go("polyhedronReward")
		else
			ShowTips(slot0.result)
		end
	end,
	QuerySelectStagePolyhedron = function (slot0)
		manager.net:SendWithLoadingNew(18014, {
			index = slot0
		}, 18015, uv0.SelectStagePolyhedronCallBack)
	end,
	SelectStagePolyhedronCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			uv0.LaunchPolyhedronBattle()
		else
			if PolyhedronConst.SAVE_POINT_TYPE.UNDEFINED == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end

			ShowTips(slot0.result)
		end
	end,
	QueryUnlockHero = function (slot0)
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) > 0 then
			manager.net:SendWithLoadingNew(66036, {
				hero_id = slot0
			}, 66037, uv0.UnlockHeroCallBack)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
		end
	end,
	UnlockHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:UnlockHero(slot1.hero_id)
			uv0:RefreshHeroesRedPoint()
			manager.notify:CallUpdateFunc(POLYHEDRON_HERO_UNLOCK)
		else
			ShowTips(slot0.result)
		end
	end,
	QueryPolyhedronReset = function ()
		manager.net:SendWithLoadingNew(18016, {}, 18017, uv0.PolyhedronResetCallBack)
	end,
	PolyhedronResetCallBack = function (slot0)
		if isSuccess(slot0.result) then
			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, 0)
			manager.notify:Invoke(COMBO_SKILL_SELECT, 0)
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		else
			ShowTips(slot0.result)
		end
	end,
	QueryPolyhedronGiveUp = function (slot0)
		manager.net:SendWithLoadingNew(18018, {}, 18019, slot0)
	end,
	QueryEnlistHero = function (slot0)
		uv0 = slot0.enlist_type

		manager.net:SendWithLoadingNew(18020, {
			hero_id = slot0.heroId
		}, 18021, uv1.EnlistHeroCallBack)
	end,
	EnlistHeroCallBack = function (slot0)
		if isSuccess(slot0.result) then
			if uv0 == PolyhedronConst.ENLIST_TYPE.BATTLE then
				DoPolyhedronNextBattleTrigger()
			else
				DoPolyhedronNextTrigger()
			end

			gameContext:Go("/polyhedronBlank")
		else
			ShowTips(slot0.result)
		end
	end,
	QueryBuyShopItem = function (slot0)
		manager.net:SendWithLoadingNew(18022, {
			index = slot0
		}, 18023, uv0.BuyShopItemCallBack)
	end,
	BuyShopItemCallBack = function (slot0)
		if isSuccess(slot0.result) then
			ShowTips("TRANSACTION_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end,
	QueryRefreshShop = function ()
		slot0 = PolyhedronData:GetPolyhedronInfo()
		slot3 = slot0:GetShopFressRefreshTimes()

		if slot0:GetShopRefreshTimes() < slot0:GetShopMaxRefreshTimes() then
			if slot3 <= slot1 then
				if slot0:GetCoinCount() < slot0:GetShopRefreshCost(slot1 - slot3 + 1) then
					ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

					return
				end

				manager.net:SendWithLoadingNew(18024, {}, 18025, uv0.RefreshShopCallBack)
			else
				manager.net:SendWithLoadingNew(18024, {}, 18025, uv0.RefreshShopCallBack)
			end
		end
	end,
	RefreshShopCallBack = function (slot0)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	QueryShopBloodReturn = function ()
		manager.net:SendWithLoadingNew(18026, {}, 18027, uv0.ShopBloodReturnCallBack)
	end,
	ShopBloodReturnCallBack = function (slot0)
		if isSuccess(slot0.result) then
			UpdatePolyhedronBattleHpUI()
		else
			ShowTips(slot0.result)
		end
	end,
	QuerySwitchTeamHero = function (slot0)
		manager.net:SendWithLoadingNew(18028, {
			fight_id_list = slot0
		}, 18029, uv0.SwitchTeamHeroCallBack)
	end,
	SwitchTeamHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = ComboSkillTools.GetRecommendSkillID(slot1.fight_id_list, true)

			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, slot2)
			manager.notify:Invoke(COMBO_SKILL_SELECT, slot2)
			manager.notify:CallUpdateFunc(POLYHEDRON_SWITCH_HERO)
		else
			ShowTips(slot0.result)
		end
	end,
	LaunchPolyhedronBattle = function ()
		JumpTools.OpenPageByJump("/polyhedronBlank")
		BattleController.GetInstance():LaunchBattle(BattlePolyhedronStageTemplate.New(PolyhedronData:GetPolyhedronInfo():GetStageId()))
	end,
	QuerySetTerminal = function (slot0)
		manager.net:SendWithLoadingNew(18032, {
			upgrade_id_list = slot0
		}, 18033, uv0.SetTerminalCallBack)
	end,
	SetTerminalCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:SetTerminalGift(slot1.upgrade_id_list)
			uv0.CheckTerminalRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	QueryUnlockBeacon = function (slot0)
		manager.net:SendWithLoadingNew(66034, {
			beacon_id = slot0
		}, 66035, uv0.UnlockBeaconCallBack)
	end,
	UnlockBeaconCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:AddUnlockBeacon(slot1.beacon_id)
			manager.notify:CallUpdateFunc(POLYHEDRON_BEACON_UNLOCK)
			ShowTips(GetTips("POLYHEDRON_BEACON_UNLOCK_SUCCESS"))
			uv0.CheckBeaconRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	CheckBeaconRedPoint = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

			return
		end

		if not ActivityData:GetActivityIsOpen(PolyhedronData:GetActivityID()) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

			return
		end

		for slot6, slot7 in ipairs(PolyhedronBeaconCfg.all) do
			if PolyhedronData:GetBeaconIsLock(slot7) and PolyhedronTools.GetBeaconIsUnlockCondition(slot7) then
				manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)
	end,
	CheckTerminalRedPoint = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

			return false
		end

		if not ActivityData:GetActivityIsOpen(PolyhedronData:GetActivityID()) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

			return
		end

		for slot7, slot8 in pairs(PolyhedronData:GetTerminalGift()) do
			slot3 = 0 + PolyhedronTerminalCfg[slot8].cost
		end

		if PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point - slot3 <= 0 then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

			return false
		end

		for slot10, slot11 in ipairs(PolyhedronTerminalCfg.all) do
			if not table.indexof(slot2, slot11) then
				for slot17, slot18 in ipairs(PolyhedronTerminalCfg[slot11].pre_id_list) do
					if (slot18 == 0 or table.indexof(slot2, slot18)) and slot12.cost <= slot6 then
						manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 1)

						return
					end
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return false
	end,
	RefreshHeroesRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(PolyhedronData:GetActivityID()) or JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, 0)

			return
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, uv0:GetPolyhedronHeroesRedPointCount())
	end,
	GetPolyhedronHeroesRedPointCount = function (slot0)
		if not PolyhedronData.GetHeroIDList() then
			return 0
		end

		for slot5, slot6 in ipairs(slot1) do
			if uv0:GetPolyhedronHeroRedPointCount(slot6) > 0 then
				return 1
			end
		end

		return 0
	end,
	GetPolyhedronHeroRedPointCount = function (slot0, slot1)
		if not HeroTools.GetHeroIsUnlock(slot1) then
			return 0
		end

		if PolyhedronData:GetPolyhedronHeroUnlock(slot1) then
			return 0
		end

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) < 1 then
			return 0
		end

		return PolyhedronData:GetHeroClicked(slot1) and 0 or 1
	end,
	QueryPolicyReward = function (slot0, slot1)
		if slot0 == 2 then
			-- Nothing
		end

		manager.net:SendWithLoadingNew(66000, {
			type = slot0,
			level = slot1
		}, 66001, uv0.QueryPolicyRewardCallBack)
	end,
	QueryPolicyRewardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			sortMergeGetReward(slot0.reward_list)

			slot2 = {}

			if slot1.type == 1 then
				slot3, slot4 = PolyhedronTools.PolyhedronPolicyExpToLevel()

				for slot9 = 1, slot3 do
					if PolyhedronData:GetPolicyApplyList()[slot9] == nil then
						slot2[#slot2 + 1] = slot9
					end
				end
			else
				slot2[#slot2 + 1] = slot1.level
			end

			PolyhedronData:SetPolicyApplyList(slot2)
			manager.notify:CallUpdateFunc(POLYHEDRON_POLICY_REWARD_RECEIVE)
			uv0.RefreshPolicyRedPoint()
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshPolicyRedPoint = function ()
		if not ActivityData:GetActivityIsOpen(PolyhedronData:GetActivityID()) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 0)

			return
		end

		slot1, slot2 = PolyhedronTools.PolyhedronPolicyExpToLevel()

		for slot7 = 1, slot1 do
			if PolyhedronData:GetPolicyApplyList()[slot7] == nil then
				manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 0)
	end,
	ResetRankCache = function ()
		uv0 = PolyhedronConst.RANK_TYPE.ALL
		uv1 = PolyhedronConst.RANK_SUB_TYPE.SCORE
		uv2 = nil
	end,
	QueryCurRank = function (slot0, slot1)
		slot2 = nil

		RankAction.QueryOwnCommonRank(RankConst.RANK_ID.POLYHERON, (slot0 ~= PolyhedronConst.RANK_SUB_TYPE.HERO or PolyhedronData.GetHeroIDList()) and {
			0
		}, slot1)
	end,
	QueryOpenRankView = function ()
		if GuildData:GetGuildInfo() == nil or slot0.id == nil then
			uv0 = PolyhedronConst.RANK_TYPE.ALL
		end

		if PolyhedronConst.RANK_TYPE.GUILD == uv0 then
			uv1.QueryGuildRankList(uv2, uv3)
		else
			uv1.QueryRankList(uv2, uv3)
		end
	end,
	QueryRankList = function (slot0, slot1)
		slot2 = 0

		RankAction.QueryCommonRank(RankConst.RANK_ID.POLYHERON, slot0 == PolyhedronConst.RANK_SUB_TYPE.HERO and slot1 or 0, function ()
			uv0 = PolyhedronConst.RANK_TYPE.ALL
			uv1 = uv2
			uv3 = uv4

			JumpTools.OpenPageByJump("/polyhedronRank", {
				type = uv0,
				subType = uv1,
				heroID = uv3
			})
		end)
	end,
	QueryGuildRankList = function (slot0, slot1)
		slot2 = 0

		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.POLYHERON, slot0 == PolyhedronConst.RANK_SUB_TYPE.HERO and slot1 or 0, function ()
			uv0 = PolyhedronConst.RANK_TYPE.GUILD
			uv1 = uv2
			uv3 = uv4

			JumpTools.OpenPageByJump("/polyhedronRank", {
				type = uv0,
				subType = uv1,
				heroID = uv3
			})
		end)
	end,
	ResetTerminal = function ()
		manager.net:SendWithLoadingNew(66002, {}, 66003, uv0.OnResetTerminalCallback)
	end,
	OnResetTerminalCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:ResetTerminalCallback()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	AstrolabeEquip = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(PolyhedronData:GetUseAstrolabe(slot0)) do
			table.insert(slot3, slot8)
		end

		table.insert(slot3, slot1)
		manager.net:SendWithLoadingNew(66004, {
			hero_id = slot0,
			astrolabe_id_list = slot3
		}, 66005, uv0.OnAstrolabeEquip)
	end,
	OnAstrolabeEquip = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:SetUseAstrolabe(slot1.hero_id, slot1.astrolabe_id_list)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, slot0, slot1)
	end,
	AstrolabeEquipAll = function (slot0, slot1)
		manager.net:SendWithLoadingNew(66004, {
			hero_id = slot0,
			astrolabe_id_list = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1]
		}, 66005, uv0.OnAstrolabeEquipAll)
	end,
	OnAstrolabeEquipAll = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:SetUseAstrolabe(slot1.hero_id, slot1.astrolabe_id_list)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, slot0, slot1)
	end,
	AstrolabeUnload = function (slot0, slot1)
		slot3 = {}

		for slot8, slot9 in ipairs(PolyhedronData:GetUseAstrolabe(slot0)) do
			if HeroAstrolabeCfg[slot9].hero_astrolabe_suit_id ~= HeroAstrolabeCfg[slot1].hero_astrolabe_suit_id or slot9 < slot1 then
				table.insert(slot3, slot9)
			end
		end

		manager.net:SendWithLoadingNew(66004, {
			hero_id = slot0,
			astrolabe_id_list = slot3
		}, 66005, uv0.OnAstrolabeUnload)
	end,
	OnAstrolabeUnload = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:SetUseAstrolabe(slot1.hero_id, slot1.astrolabe_id_list)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, slot0, slot1)
	end,
	AstrolabeUnloadAll = function (slot0)
		manager.net:SendWithLoadingNew(66004, {
			hero_id = slot0,
			astrolabe_id_list = {}
		}, 66005, uv0.OnAstrolabeUnloadAll)
	end,
	OnAstrolabeUnloadAll = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PolyhedronData:SetUseAstrolabe(slot1.hero_id, slot1.astrolabe_id_list)
		end

		manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, slot0, slot1)
	end,
	CheckNewRed = function (slot0)
		if not SystemData:ServerSystemIsLocked(ViewConst.SYSTEM_ID.MATRIX) and PolyhedronData:GetIsNewRed() then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_NEW_SECTION, 1, RedPointStyle.SHOW_NEW_TAG)
		else
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_NEW_SECTION, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end
}
