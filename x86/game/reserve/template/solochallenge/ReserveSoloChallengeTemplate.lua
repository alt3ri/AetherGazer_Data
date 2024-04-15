slot1 = class("ReserveSoloChallengeTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.UpdateServerData(slot0, slot1)
	uv0.super.UpdateServerData(slot0, slot1)

	for slot5, slot6 in ipairs(slot1.data) do
		if slot0.cont_dic[slot6.cont_id] then
			slot0:GetContDataTemplateById(slot7):SetAffixList(slot6.team_index, cleanProtoTable(slot6.artifact))
		end
	end
end

function slot1.GetLockHero(slot0, slot1, slot2)
	slot2.lockHeroList = slot0:GetContDataTemplateById(slot1.contID):GetLockHeroList(slot1.customData.activityID, slot1.customData.difficultyIndex)
	slot2.lockStateList = {
		true,
		true,
		true
	}
end

return slot1
