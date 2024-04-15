slot1 = class("SailFishGameEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.AcceptEvent(slot0)
	JumpTools.OpenPageByJump("/sailFishingGame", {
		activityID = slot0.activityID_,
		stageIndex = slot0.stageIndex
	})
end

function slot1.RefreshReward(slot0)
	SetActive(slot0.rewardPanelGo_, false)
end

return slot1
