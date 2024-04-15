slot1 = class("SailFishingGameView", import("game.views.activity.Submodule.Fishing.Game.FishingGameView"))

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.hookBtn_, nil, function ()
		if uv0.hook_ then
			uv0.hook_:StartHooking()
		end
	end)
	FishGameManager.GetInstance():SetPauseHandler(handler(slot0, slot0.OnPause))
	FishGameManager.GetInstance():SetContinueHandler(handler(slot0, slot0.OnContinue))
	FishGameManager.GetInstance():SetScoreChangeHandler(handler(slot0, slot0.OnScoreChange))
	FishGameManager.GetInstance():SetScoreAddHandler(handler(slot0, slot0.OnScoreAdd))
	FishGameManager.GetInstance():AddBuffHandler(handler(slot0, slot0.OnBuffChange))
	slot0:AddBtnListener(slot0.pauseBtn_, nil, function ()
		FishGameManager.GetInstance():Pause()
	end)
	slot0:AddBtnListener(slot0.continueBtn_, nil, function ()
		FishGameManager.GetInstance():Continue()
	end)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		uv0.tempScore_ = FishGameManager.GetInstance():GetScore()

		SailGameAction.EventOperate(uv0.params_.activityID, SailGameData:GetCurGameData(uv0.params_.activityID).curStageIndex, nil, uv0.tempScore_)
	end)

	slot0.onAnimationCompleteHandler_ = handler(slot0, slot0.OnAnimationComplete)
	slot0.roleSpine_.AnimationState.Complete = slot0.roleSpine_.AnimationState.Complete + slot0.onAnimationCompleteHandler_
end

function slot1.Update(slot0)
	if slot0.end_ then
		slot0.roleSpine_.AnimationState.TimeScale = 0
		slot0.waterSpine_.AnimationState.TimeScale = 0

		return
	end

	if FishGameManager.GetInstance():GetStatus() == "cast" then
		if animationStatus == "notPlayed" then
			slot0:PlayRoleAnimation("PushButton", false)

			animationStatus = "playing"
		end
	elseif slot1 == "catch" then
		animationStatus = "notPlayed"

		slot0:PlayRoleAnimation("Happy", true)
	elseif slot1 == "fail" then
		animationStatus = "notPlayed"

		slot0:PlayRoleAnimation("Sad", true)
	elseif slot1 == "idle" then
		animationStatus = "notPlayed"

		slot0:PlayRoleAnimation("idle", true)
	end

	if FishGameManager.GetInstance():GetSeconds() < 0 then
		slot2 = 0
	end

	slot0.countdownLabel_.text = tostring(math.floor(slot2))

	if FishGameManager.GetInstance():GetIsEnd() then
		slot0.end_ = true
		slot0.tempScore_ = FishGameManager.GetInstance():GetScore()

		SailGameAction.EventOperate(slot0.params_.activityID, SailGameData:GetCurGameData(slot0.params_.activityID).curStageIndex, nil, slot0.tempScore_)
		manager.audio:StopEffect()
	end

	slot0.bubbleNumController_:SetSelectedIndex(FishGameManager.GetInstance():GetTreasureLimitNum())
end

function slot1.OnEventOperateSuccess(slot0)
	SDKTools.SendMessageToSDK("activity_skadi_sea_be_out_finish", {
		fish_event_level_id = slot0.levelId_
	})
	SailGameAction.SetEventEndMark(slot0.params_.activityID, SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS)
	JumpTools.OpenPageByJump("sailFishingGameResult", {
		activityID = slot0.params_.activityID,
		score = slot0.tempScore_
	})
end

return slot1
