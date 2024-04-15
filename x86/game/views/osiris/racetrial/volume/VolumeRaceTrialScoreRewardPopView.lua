slot1 = class("VolumeRaceTrialScoreRewardPopView", import("game.views.osiris.raceTrial.RaceTrialScoreRewardPopView"))

function slot1.UIName(slot0)
	return RaceTrialTools.GetScoreRewardUIName(slot0.params_.mainActivityID)
end

function slot1.GetRewardItemClass(slot0)
	return VolumeRaceTrialScoreRewardItem
end

return slot1
