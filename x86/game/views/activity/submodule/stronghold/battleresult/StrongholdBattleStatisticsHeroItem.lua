slot0 = class("StrongholdBattleStatisticsHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveHeroController = ControllerUtil.GetController(slot0.gameObject_.transform, "haveHero")
	slot0.reportController = ControllerUtil.GetController(slot0.gameObject_.transform, "report")
	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.friendController = ControllerUtil.GetController(slot0.m_addFriendBtn.transform, "state")
	slot0.showThumbController = ControllerUtil.GetController(slot0.gameObject_.transform, "showThumb")

	slot0.reportController:SetSelectedIndex(0)

	slot0.isThumbsUp = false
	slot0.isReport = false
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_reportBtn, nil, function ()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_STRONGHOLD_CONFIRM_REPORT_TIPS"),
			OkCallback = function ()
				uv0.isReport = true

				uv0.reportController:SetSelectedIndex(2)
				CooperationAction.CooperationReport(uv0.player_id, BattleFieldData:GetServerBattleID())
			end
		})
	end)
	slot0:AddBtnListener(slot0.m_addFriendBtn, nil, function ()
		uv0.isAddFriend = true
		uv0.m_addFriendBtn.interactable = false

		uv0.friendController:SetSelectedIndex(1)
		FriendsAction:TryToRequestToFriend(uv0.player_id, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_RESULT)
	end)
	slot0:AddBtnListener(slot0.m_thumbsUpBtn, nil, function ()
		uv0.isThumbsUp = true

		CooperationAction.ThumbsUp(uv0.player_id)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if slot1 and slot2 then
		slot0.battleCountDamageNum_.text = tostring(slot2.damage)
		slot0.battleCountCureNum_.text = tostring(slot2.cure)
		slot0.battleCountDamageImg_.enabled = int64.equals(slot3.damage, slot2.damage) and int64.zero < slot3.damage
		slot0.battleCountCureNumImg_.enabled = int64.equals(slot3.cure, slot2.cure) and int64.zero < slot3.cure
		slot4 = slot1.playerID
		slot0.player_id = slot4

		if StrongholdData:GetStrongholdResultData(slot4) then
			slot7 = slot5.select_effect_num
			slot0.battleCountEffectNum_.text = slot7
			slot0.battleCountEffectImg_.enabled = slot7 == StrongholdData:GetStrongholdResultMaxEffectNum() and slot7 > 0
		else
			slot0.battleCountEffectNum_.text = "0"
			slot0.battleCountEffectImg_.enabled = false
		end

		slot7 = "--/--"

		if BattleFieldData:GetBattleResultData().battle_record_dir and slot8[slot4] then
			slot0.m_defenseTime1.text = slot9[51] and manager.time:DescCdTime2(slot10) or slot7
			slot0.m_defenseTime2.text = slot9[52] and manager.time:DescCdTime2(slot10) or slot7
			slot0.m_defenseTime3.text = slot9[53] and manager.time:DescCdTime2(slot10) or slot7

			slot0.haveHeroController:SetSelectedIndex(2)
		else
			slot0.m_defenseTime1.text = slot7
			slot0.m_defenseTime2.text = slot7
			slot0.m_defenseTime3.text = slot7

			slot0.haveHeroController:SetSelectedIndex(1)
		end

		slot10 = slot1.heroList[1]
		slot0.m_name.text = slot1.nick
		slot0.m_lvLab.text = slot10.level
		slot0.m_heroIcon.sprite = getSpriteViaConfig("HeroIcon", SkinCfg[slot10.skin == 0 and slot10.id or slot10.skin].picture_id)
	else
		slot0.haveHeroController:SetSelectedIndex(0)
	end

	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	if PlayerData:GetPlayerInfo().userID == slot0.player_id then
		slot0.reportController:SetSelectedIndex(0)
		slot0.stateController:SetSelectedIndex(0)
	else
		if slot0.isAddFriend then
			slot0.m_addFriendBtn.interactable = false

			slot0.friendController:SetSelectedIndex(1)
		elseif table.indexof(FriendsData:GetList(1), tostring(slot0.player_id)) then
			slot0.m_addFriendLab.text = GetTips("COOPERATION_ALREADY_FRIEND")
			slot0.m_addFriendBtn.interactable = false

			slot0.friendController:SetSelectedIndex(2)
		else
			slot0.m_addFriendLab.text = GetTips("COOPERATION_ADD_FRIEND")
			slot0.m_addFriendBtn.interactable = true

			slot0.friendController:SetSelectedIndex(0)
		end

		if slot0.isThumbsUp then
			slot0.stateController:SetSelectedIndex(1)
		else
			slot0.stateController:SetSelectedIndex(2)
		end

		if slot0.isReport then
			slot0.reportController:SetSelectedIndex(2)
		else
			slot0.reportController:SetSelectedIndex(1)
		end
	end

	slot0:RefreshThumb()
end

function slot0.RefreshThumb(slot0)
	slot3 = PlayerData:GetPlayerInfo().userID == slot0.player_id

	if CooperationData:GetRoomData() then
		if #(slot1:GetBeLikedPlayerIds(slot0.player_id) or {}) > 0 then
			for slot9, slot10 in ipairs(slot4) do
				if slot1:GetRoomPlayerData(slot10) then
					slot5 = (nil ~= nil or slot11.nick) and slot11.nick .. "," .. slot11.nick
				end
			end

			slot0.m_thumbsUpLab.text = slot5 or ""

			if slot3 or slot0.isThumbsUp then
				slot0.showThumbController:SetSelectedIndex(1)
			else
				slot0.showThumbController:SetSelectedIndex(0)
			end
		else
			slot0.showThumbController:SetSelectedIndex(0)
		end
	else
		slot0.showThumbController:SetSelectedIndex(0)
	end
end

return slot0
