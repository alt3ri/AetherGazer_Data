slot1 = class("ReserveAbyssTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.GetLockHero(slot0, slot1, slot2)
	slot4 = {}

	for slot9, slot10 in ipairs(ActivityAttributeArenaData:GetArenaList(slot1.customData.activityID)) do
		if slot10.score > 0 then
			for slot16, slot17 in ipairs(slot0:GetContDataTemplateById(slot10.id):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX)) do
				if slot17:GetHeroID() ~= 0 then
					slot4[#slot4 + 1] = slot17:GetHeroID()
				end
			end
		end
	end

	slot2.lockHeroList = slot4
	slot6 = clone(slot2.resultHeroList)

	for slot10, slot11 in ipairs(slot2.resultHeroList) do
		if table.keyof(slot2.lockHeroList, slot11) then
			slot6[slot10] = 0
			slot2.isInVaild = true
		end
	end

	slot2.resultHeroList = slot6
end

function slot1.GetTrialHeroList(slot0, slot1)
	return AttributeArenaTools.GetTrialHeroList(slot1.customData.attribute_arena_id)
end

function slot1.GetArenaHeroList(slot0, slot1)
	for slot9, slot10 in ipairs(slot0:GetContDataTemplateById(slot1):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX)) do
		-- Nothing
	end

	return {
		0,
		0,
		0,
		[slot9] = slot10:GetHeroID()
	}, {
		0,
		0,
		0,
		[slot9] = slot10:GetTrialID()
	}
end

return slot1
