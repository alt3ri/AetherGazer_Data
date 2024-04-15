slot1 = class("ReserveBossChallengeTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.FilterInvalidTeamData(slot0, slot1, slot2)
	slot3 = 1

	for slot8, slot9 in ipairs(clone(slot2.resultHeroList)) do
		if slot9 ~= 0 and not table.keyof(slot2.lockHeroList, slot9) then
			slot2.resultHeroList[slot3] = slot9
			slot3 = slot3 + 1
		elseif table.keyof(slot2.lockHeroList, slot9) then
			slot2.isInVaild = true
			slot2.resultHeroList[slot3] = 0
		end
	end
end

function slot1.GetLockHero(slot0, slot1, slot2)
	for slot8, slot9 in pairs(BossTools.GetLockHero()) do
		if slot8 ~= slot1.customData.bossIndex then
			table.insertto(slot2.lockHeroList, slot9)
		end
	end
end

return slot1
