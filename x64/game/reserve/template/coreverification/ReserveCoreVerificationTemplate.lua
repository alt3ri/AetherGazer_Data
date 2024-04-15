slot1 = class("ReserveCoreVerificationTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.GetLockHero(slot0, slot1, slot2)
	for slot8, slot9 in pairs(CoreVerificationData:GetLockHeroByInfoID(slot1.customData.activityID)) do
		table.insert(slot2.lockHeroList, slot9)
	end
end

return slot1
