RaceTrialMainView = import("game.views.osiris.raceTrial.RaceTrialMainView")
slot0 = class("VolumeRaceTrialMainView", RaceTrialMainView)

function slot0.UIName(slot0)
	return RaceTrialTools.GetMainUIName(slot0.params_.activityID)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.firstRewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.scoreRewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("volumeRaceTrialScoreRewardPop", {
			mainActivityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		RaceTrialAction:ReceiveScoreReward(uv0.curLv_)
	end)
	slot0:AddBtnListener(slot0.DivineBtn_, nil, function ()
		JumpTools.OpenPageByJump("volumeHeroRaceTrialDetails")
	end)
end

return slot0
