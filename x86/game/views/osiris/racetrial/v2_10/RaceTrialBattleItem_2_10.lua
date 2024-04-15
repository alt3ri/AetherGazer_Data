slot1 = class("RaceTrialBattleItem_2_10", import("game.views.osiris.raceTrial.RaceTrialBattleItem"))

function slot1.RefreshRace(slot0)
	slot0.raceIcon_.sprite = getSprite("Atlas/JapanRegionUI_2_10", tostring(slot0.cfg_.race))
end

return slot1
