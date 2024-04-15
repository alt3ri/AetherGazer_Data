slot1 = class("RaceTrialBattleItem_2_6", import("game.views.osiris.raceTrial.RaceTrialBattleItem"))

function slot1.RefreshRace(slot0)
	slot0.raceIcon_.sprite = getSprite("Atlas/JapanRegionUI_2_6", tostring(slot0.cfg_.race))
end

return slot1
