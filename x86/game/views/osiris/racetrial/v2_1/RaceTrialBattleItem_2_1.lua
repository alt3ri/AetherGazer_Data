slot1 = class("RaceTrialBattleItem_2_1", import("game.views.osiris.raceTrial.RaceTrialBattleItem"))

function slot1.RefreshRace(slot0)
	slot0.raceNameIcon_.sprite = getSprite("Atlas/XuHeng2ndUI", string.format("name_%d", slot0.cfg_.race))
	slot0.raceIcon_.sprite = getSprite("Atlas/XuHeng2ndUI", tostring(slot0.cfg_.race))
end

return slot1
