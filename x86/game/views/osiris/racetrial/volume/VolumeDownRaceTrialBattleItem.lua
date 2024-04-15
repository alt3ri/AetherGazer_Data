slot1 = class("VolumeDownRaceTrialBattleItem", import("game.views.osiris.raceTrial.RaceTrialBattleItem"))

function slot1.RefreshRace(slot0)
	if slot0.raceCon_ then
		slot0.raceCon_:SetSelectedState(tostring(slot0.cfg_.race))
	end

	slot0.raceIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/VolumeIIIDownChellgeUI/" .. slot0.cfg_.race)
end

return slot1
