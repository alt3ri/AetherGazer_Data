slot1 = nil
slot2 = nil

return {
	TryToCheckForeignDetailInfo = function (slot0, slot1, slot2)
		if slot1 == tostring(PlayerData:GetPlayerInfo().userID) then
			OpenPageUntilLoaded("/userinfo", {
				maskScene = slot2
			}, ViewConst.SYSTEM_ID.PLAYER_INFO)

			return
		end

		if FriendsData:GetInfoByID(slot1) and slot3.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
			ShowTips("BLACKLIST_TIP")

			return
		end

		uv0 = slot2

		manager.net:SendWithLoadingNew(32018, {
			user_id = slot1
		}, 32019, handler(slot0, slot0.OnTryToCheckForeignDetailInfo))
	end,
	OnTryToCheckForeignDetailInfo = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ForeignInfoData:SetCurForeignDetailInfo(slot1)
			OpenPageUntilLoaded("/playerinfo", {
				isForeign = true,
				maskScene = uv0
			})
			manager.notify:CallUpdateFunc(CHECK_FOREIGN_INFO, {
				isForeign = true
			})

			uv0 = nil
		else
			ShowTips(slot1.result)
		end
	end,
	TryToCheckForeignHeroInfo = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(32020, {
			user_id = slot1,
			type = slot3 or 1
		}, 32021, function (slot0, slot1)
			if isSuccess(slot0.result) then
				ForeignInfoData:SetForeignHeroInfo(slot0.hero_list or {})

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetSimpleForeignInfo = function (slot0, slot1)
		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot1
		}, 32037, handler(slot0, slot0.OnGetSimpleForeignInfo))
	end,
	OnGetSimpleForeignInfo = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			manager.notify:CallUpdateFunc(GET_SIMPLE_FOREIGN_INFO, slot1.user_brief_list)
		else
			ShowTips(slot1.result)
		end
	end,
	SearchGuildInfo = function (slot0, slot1, slot2)
		uv0 = slot2

		manager.net:SendWithLoadingNew(31028, {
			id = slot1
		}, 31029, handler(slot0, slot0.OnSearchGuildInfo))
	end,
	OnSearchGuildInfo = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			GuildData:SetCacheGuildInfo(slot1.club_base_info)
			JumpTools.OpenPageByJump("guildInfo", {
				guildID = slot2.id,
				source = uv0
			})

			uv0 = nil
		else
			ShowTips(slot1.result)
		end
	end
}
