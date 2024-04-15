slot1 = class("SailBattleEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.AcceptEvent(slot0)
	JumpTools.OpenPageByJump("/sailLotteryGame", {
		activityID = slot0.activityID_,
		stageIndex = slot0.stageIndex_
	})
end

function slot1.RefreshReward(slot0)
	SetActive(slot0.rewardPanelGo_, false)
end

return slot1
