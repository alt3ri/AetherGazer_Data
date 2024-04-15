slot0 = class("XH3rdFlipCardGameView", ReduxView)
GameStatus = {
	GameOver = 4,
	MidPaused = 3,
	Paused = 0,
	Observing = 1,
	Flipping = 2
}

function slot0.UIName(slot0)
	return XH3rdFlipCardTool:GetGameUI()
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.lastGameStatu = nil
	slot0.statusController = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.endController = ControllerUtil.GetController(slot0.transform_, "end")

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		if XH3rdFlipCardTool:GetGameState() == GameStatus.Paused then
			uv0:Back()
			uv0:UnLoadFlipCardScene()
		else
			XH3rdFlipCardTool:ChangeStatus(GameStatus.MidPaused)
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_FLIP_CARD_ABANDON"),
				OkCallback = function ()
					uv0:Back()
					XH3rdFlipCardAction:sendSettleFlipCardGameRequest(uv0.activityId, false, XH3rdFlipCardTool:GetUseTime(), XH3rdFlipCardTool:GetFlipCardCount())
					uv0:UnLoadFlipCardScene()
				end,
				CancelCallback = function ()
					XH3rdFlipCardTool:ChangeStatus(uv0)
				end,
				MaskCallback = function ()
					XH3rdFlipCardTool:ChangeStatus(uv0)
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.fastStartBtn_, nil, function ()
		XH3rdFlipCardTool:StopObservingCard()
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if uv0.hasSendStartRequest then
			return
		end

		uv0.hasSendStartRequest = true

		XH3rdFlipCardAction:sendStartFlipCardGameRequest(uv0.activityId)
	end)
	slot0:AddBtnListener(slot0.giveUpBtn_, nil, function ()
		if XH3rdFlipCardTool:GetGameState() == GameStatus.GameOver then
			return
		end

		XH3rdFlipCardTool:ChangeStatus(GameStatus.MidPaused)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_FLIP_CARD_ABANDON"),
			OkCallback = function ()
				XH3rdFlipCardTool:GiveUp()
			end,
			CancelCallback = function ()
				XH3rdFlipCardTool:ChangeStatus(uv0)
			end,
			MaskCallback = function ()
				XH3rdFlipCardTool:ChangeStatus(uv0)
			end
		})
	end)
	slot0:AddBtnListener(slot0.clueBtn_, nil, function ()
		JumpTools.OpenPageByJump("xH3rdFlipCardClue", {
			activityID = uv0.activityId
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("xH3rdFlipCardReward", {
			activityID = uv0.activityId
		})
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		XH3rdFlipCardTool:ResetGame()

		if XH3rdFlipCardTool:GetIsSuccess() then
			uv0:ResetAnimator(uv0.successAni_, "Fx_success_cx")
		else
			uv0:ResetAnimator(uv0.failAni_, "Fx_fail_cx")
		end
	end)
	slot0:AddBtnListener(slot0.tokenBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			FlipCardCfg[uv0.activityId].cost_id,
			0
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = slot0.params_.activityId
	slot0.hasSendStartRequest = false
	slot1 = ActivityData:GetActivityData(slot0.activityId)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	XH3rdFlipCardTool:LoadScene(slot0.activityId, uv0:OnSceneLoaded())
	slot0:RefreshPausedStateUI()
	slot0:AddTimer()

	slot0.refreshHandler_ = handler(slot0, slot0.RefreshGameOverStateUI)

	slot0:SetUIText()
	manager.notify:RegistListener(FLIP_CARD_GAME_RESULT, slot0.refreshHandler_)
	manager.notify:RegistListener(FLIP_CARD_START_GAME_RESULT, function ()
		uv0.hasSendStartRequest = false
	end)
	manager.redPoint:bindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0.activityId))
	manager.redPoint:bindUIandKey(slot0.clueBtnTrans_, string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0.activityId))
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.stateTimer_ = Timer.New(function ()
		uv0:CheckGameStatus()
	end, 0.1, -1, true)

	slot0.stateTimer_:Start()

	slot0.remainTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			return
		end

		uv0.remainTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(uv0.stopTime_, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.stateTimer_ then
		slot0.stateTimer_:Stop()

		slot0.stateTimer_ = nil
	end
end

function slot0.ResetAnimator(slot0, slot1, slot2)
	slot1:Play(slot2, 0, 0)
	slot1:Update(0)

	slot1.enabled = false
end

function slot0.OnSceneLoaded(slot0)
	slot0.sceneLoaded_ = true
end

function slot0.SetUIText(slot0)
	if XH3rdFlipCardTool:GetGameState() == GameStatus.Observing then
		slot0.timeTitleText_.text = GetTips("ACTIVITY_FLIP_CARD_TIME_NAME_1")
	elseif slot1 == GameStatus.Flipping then
		slot0.timeTitleText_.text = GetTips("ACTIVITY_FLIP_CARD_TIME_NAME_2")
	end
end

function slot0.CheckGameStatus(slot0)
	if XH3rdFlipCardTool:GetGameState() ~= GameStatus.Observing and slot0.startTimeTimer then
		slot0.startTimeTimer:Stop()

		slot0.startTimeTimer = nil
	end

	if slot1 == GameStatus.Observing then
		slot0.leftTimeText_.text = XH3rdFlipCardTool:GetObservingLeftTime()
	elseif slot1 == GameStatus.Flipping then
		if not slot0.isShowStartTips then
			SetActive(slot0.startPopImg_, true)
			manager.audio.PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_start_auto")

			slot0.isShowStartTips = true
			slot0.showTimer = Timer.New(function ()
				SetActive(uv0.startPopImg_, false)

				uv0.showTimer = nil
			end, 0.6, 1, true)

			slot0.showTimer:Start()
		end

		slot0.leftTimeText_.text = XH3rdFlipCardTool:GetFlippingLeftTime()
	end

	if slot0.lastGameStatu ~= slot1 then
		if slot1 == GameStatus.GameOver then
			XH3rdFlipCardAction:sendSettleFlipCardGameRequest(slot0.activityId, XH3rdFlipCardTool.GetIsSuccess(), XH3rdFlipCardTool:GetUseTime(), XH3rdFlipCardTool:GetFlipCardCount())
		elseif slot1 == GameStatus.Observing then
			slot0.startTimeTimer = Timer.New(function ()
				slot0 = XH3rdFlipCardTool:GetObservingLeftTime()

				if XH3rdFlipCardTool:GetGameState() ~= GameStatus.Observing then
					uv0.startTimeTimer:Stop()

					uv0.startTimeTimer = nil

					return
				end

				if slot0 >= 1 then
					manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_time01")
				elseif slot0 < 1 then
					manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_time02")
					uv0.startTimeTimer:Stop()

					uv0.startTimeTimer = nil
				end
			end, 1, -1, true)

			slot0.startTimeTimer:Start()
		elseif slot1 == GameStatus.Paused then
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			slot0:RefreshPausedStateUI()

			slot0.isShowStartTips = false
		elseif slot1 == GameStatus.Flipping then
			-- Nothing
		end

		slot0:SetUIText()
		slot0.statusController:SetSelectedIndex(slot1)

		slot0.lastGameStatu = slot1
	end
end

function slot0.RefreshPausedStateUI(slot0)
	slot0.clueText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_CLUE_COLLECTION_PROGRESS"), #XH3rdFlipCardData:GetClueList(slot0.activityId), #FlipCardCfg[slot0.activityId].details)
	slot4 = FlipCardCfg[slot0.activityId].cost_id
	slot0.tokenImg_.sprite = ItemTools.getItemSprite(slot4)
	slot0.startItemImg_.sprite = ItemTools.getItemSprite(slot4)
	slot0.tokenNumberText_.text = ItemTools.getItemNum(slot4)

	SetActive(slot0.successGo_, false)
	SetActive(slot0.failGo_, false)
end

function slot0.RefreshGameOverStateUI(slot0, slot1)
	if XH3rdFlipCardTool.GetIsSuccess() then
		slot0.successContentText_.text = GetTips("ACTIVITY_FLIP_CARD_SUCCESS_TIPS_1")
		slot0.successClueText_.text = GetTips("ACTIVITY_FLIP_CARD_SUCCESS_TIPS_2")
		slot0.useTimeText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_TIME_COST"), XH3rdFlipCardTool:GetUseTime())
		slot0.successAni_.enabled = true

		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_success")

		if slot1 ~= 0 then
			SetActive(slot0.successGo_, true)
			SetActive(slot0.successClueGo_, true)
		else
			SetActive(slot0.successGo_, true)
			SetActive(slot0.successClueGo_, false)
		end
	else
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail")

		slot0.loseContentText_.text = GetTips("ACTIVITY_FLIP_CARD_FAIL_TIPS")
		slot0.failAni_.enabled = true

		SetActive(slot0.failGo_, true)
	end
end

function slot0.UnLoadFlipCardScene(slot0)
	slot0.sceneLoaded_ = false

	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	XH3rdFlipCardTool:UnLoadScene()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.notify:RemoveListener(FLIP_CARD_GAME_RESULT, slot0.refreshHandler_)
	manager.notify:RemoveListener(FLIP_CARD_START_GAME_RESULT, function ()
		uv0.hasSendStartRequest = false
	end)

	if slot0.startTimeTimer then
		slot0.startTimeTimer:Stop()

		slot0.startTimeTimer = nil
	end

	slot0.refreshHandler_ = nil

	manager.redPoint:unbindUIandKey(slot0.rewardBtnTrans_, string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0.activityId))
	manager.redPoint:unbindUIandKey(slot0.clueBtnTrans_, string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, slot0.activityId))
end

return slot0
