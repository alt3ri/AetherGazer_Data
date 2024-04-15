slot0 = class("BackHomeCricketBattleResuleView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleResultPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scoreList = {}

	for slot4, slot5 in ipairs(BackHomeCricketConst.SCORE_LIST) do
		slot0.scoreList[slot4] = BackHomeCricketBattleResuleItem.New(slot0["scoreItem_" .. slot4])
	end

	slot0.resultController_ = slot0.mainControllerEx_:GetController("result")
	slot0.typeController_ = slot0.mainControllerEx_:GetController("type")
	slot0.likeController_ = slot0.mainControllerEx_:GetController("like")
	slot0.addfriendController_ = slot0.mainControllerEx_:GetController("addfriend")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.reviewBtn_, nil, function ()
		slot0 = DanceGame.GetInstance()
		slot1 = BackHomeCricketBattleData:GetSingleBattleData()

		if uv0.enemyID then
			slot1.settleType = BackHomeCricketConst.ROOM_TYPE.Video
		end

		slot0:Restart(slot1)
		JumpTools.OpenPageByJump("/backHomeCricketBattleView")
	end)
	slot0:AddBtnListener(slot0.addfriendBtn_, nil, function ()
		if uv0.enemyID then
			FriendsAction:TryToRequestToFriend(uv0.enemyID, FriendConst.ADD_FRIEND_SOURCE.IDOL_DANCE_GAME)
			uv0.addfriendController_:SetSelectedState("off")
		end
	end)
	slot0:AddBtnListener(slot0.likeBtn_, nil, function ()
		if uv0.enemyID then
			if table.indexof(PlayerData:GetTodaySendLikeList(), uv0.enemyID) or GameSetting.profile_like_limitation.value[1] <= #slot0 then
				ShowTips("PROFILE_LIKE_REPEAT_PROMPT")

				return
			end

			PlayerAction.SendLike(uv0.enemyID, PlayerAction.SendLikeSrc.IdolDanceGame)
			uv0.likeController_:SetSelectedState("on")
		end
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		BackHomeCricketBattleData:SetDanceBackCB()
		BackHomeTools:GotoBackHomeRoom(nil, true)
	end)
	slot0:AddBtnListener(slot0.retryBtn_, nil, function ()
		if uv0.enemyID then
			BackHomeCricketAction:AskPvPBattleData(uv0.enemyID, BackHomeCricketBattleData:GetSingleBattleData().battleType, IdolTraineeData:GetCurPVPStage())
		else
			BackHomeCricketAction:AskPvEBattleData(BackHomeCricketBattleData:GetSingleBattleData().stageID)
		end
	end)
	slot0:AddBtnListener(slot0.enemyHeadBtn, nil, function ()
		if uv0.enemyID then
			ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.enemyID, true)
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.data = slot0.params_.data

	slot0:InitResultData()
	slot0:RefreshPlayerInfo()
	slot0:RefreshScoreList()
end

function slot0.OnTop(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.RefreshPlayerInfo(slot0)
	if PlayerData:GetPlayerInfo() then
		slot0.myIcon.sprite = ItemTools.getItemSprite(slot1.portrait)
		slot0.myName.text = slot1.nick
		slot0.myFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.icon_frame)
	end

	if not BackHomeCricketBattleData:GetSingleBattleData() then
		return
	end

	if slot2.enemyID then
		slot0.typeController_:SetSelectedState("game")

		slot0.enemyID = slot2.enemyID
		slot3 = IdolTraineeTools:GetEnemyUserData(slot0.enemyID)
		slot0.enemyIcon.sprite = ItemTools.getItemSprite(slot3.icon)
		slot0.enemyName.text = slot3.nick
		slot0.enemyFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot3.icon_frame)

		slot0.addfriendController_:SetSelectedState(FriendsData:IsFriend(slot0.enemyID) and "off" or "on")

		if table.indexof(PlayerData:GetTodaySendLikeList(), slot0.enemyID) then
			slot0.likeController_:SetSelectedState("on")
		else
			slot0.likeController_:SetSelectedState("off")
		end
	elseif slot2.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		slot0.typeController_:SetSelectedState("replay")

		slot3 = IdolTraineeData:GetHistoryBattleData()[slot2.battleID]
		slot0.enemyID = slot3.userID
		slot0.enemyIcon.sprite = ItemTools.getItemSprite(slot3.icon)
		slot0.enemyName.text = slot3.nick
		slot0.enemyFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot3.icon_frame)
		slot0.enemyID = slot3.userID

		slot0.addfriendController_:SetSelectedState(FriendsData:IsFriend(slot0.enemyID) and "off" or "on")

		if table.indexof(PlayerData:GetTodaySendLikeList(), slot0.enemyID) then
			slot0.likeController_:SetSelectedState("on")
		else
			slot0.likeController_:SetSelectedState("off")
		end
	else
		slot0.typeController_:SetSelectedState("pve")
	end
end

function slot0.RefreshScoreList(slot0)
	if slot0.scoreList then
		for slot4, slot5 in ipairs(slot0.scoreList) do
			slot5:RefreshUI({
				type = BackHomeCricketConst.SCORE_LIST[slot4],
				attackData = slot0.attackData,
				defendData = slot0.defendData
			})
		end
	end
end

function slot0.InitResultData(slot0)
	slot0.result = slot0.data.battle_result
	slot0.attackData = BackHomeCricketAction:ParseCricketSettle(slot0.data.attacker_data)
	slot0.defendData = BackHomeCricketAction:ParseCricketSettle(slot0.data.defender_data)

	if slot0.result == 1 then
		slot0.resultController_:SetSelectedState("success")
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo", "")
	elseif slot0.result == 2 then
		slot0.resultController_:SetSelectedState("fail")
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail", "")
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error", "")
	end
end

function slot0.Dispose(slot0)
	if slot0.scoreList then
		for slot4, slot5 in pairs(slot0.scoreList) do
			slot5:Dispose()
		end

		slot0.scoreList = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
