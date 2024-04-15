slot1 = class("VolumeRaceTrialScoreRewardItem", import("game.views.osiris.raceTrial.RaceTrialScoreRewardItem"))

function slot1.RefreshTitle(slot0)
	slot0.title_.text = slot0.cfg_.need
end

return slot1
