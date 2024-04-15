slot1 = class("ReserveAbyssTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.FilterInvalidTeamData(slot0, slot1, slot2)
	slot3 = clone(slot2.resultHeroList)

	if slot1.customData.layer ~= nil then
		for slot8, slot9 in pairs(slot0:GetLayerLockHeroList(slot1.customData.layer)) do
			for slot13, slot14 in pairs(slot3) do
				if slot14 == slot9 then
					slot3[slot13] = 0
					slot2.isInvaild = true
				end
			end
		end
	end

	for slot8, slot9 in pairs(slot0:GetGloalBanHeroList()) do
		for slot13, slot14 in pairs(slot3) do
			if slot14 == slot9 then
				slot3[slot13] = 0
				slot2.isInvaild = true
			end
		end
	end

	for slot9, slot10 in pairs(slot3) do
		if slot10 ~= 0 then
			table.insert({}, slot10)
		end
	end

	for slot9 = 1, 3 do
		if slot5[slot9] == nil then
			slot2.resultHeroList[slot9] = 0
		else
			slot2.resultHeroList[slot9] = slot5[slot9]
		end
	end
end

function slot1.GetLayerLockHeroList(slot0, slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(AbyssData:GetAbyssCfg(slot1).stage_list) do
		table.insertto(slot4, slot0:GetStageLockHeroList(slot1, slot8))
	end

	return slot4
end

function slot1.GetStageLockHeroList(slot0, slot1, slot2)
	slot3 = {}
	slot6 = AbyssData:GetAbyssCfg(slot1).stage_list[slot2]

	if AbyssData:GetStageData(slot1, slot2).is_completed == true then
		slot10 = slot0:GetContDataTemplateById(slot6[2])
		slot11 = nil

		for slot15, slot16 in ipairs((slot6[1] == 3 or slot0:GetContDataTemplateById(slot6[2]):GetHeroList(ReserveConst.DEFAULT_TEAM_INDEX)) and slot10:GetHeroList(slot10:GetTeamCount())) do
			if slot16:GetHeroID() ~= 0 then
				slot3[#slot3 + 1] = slot17
			end
		end
	end

	return slot3
end

function slot1.GetGloalBanHeroList(slot0)
	slot1 = {}
	slot5 = AbyssData:GetActivityId()

	for slot5, slot6 in ipairs(AbyssCfg.get_id_list_by_activity_id[slot5]) do
		if AbyssData:IsLayerUnlock(AbyssCfg[slot6].level) then
			for slot13, slot14 in ipairs(AbyssCfg[slot6].stage_list) do
				table.insertto(slot1, slot0:GetStageBanHeroList(slot7, slot13))
			end
		end
	end

	return slot1
end

function slot1.GetStageBanHeroList(slot0, slot1, slot2)
	slot3 = {}

	if AbyssData:IsLayerUnlock(slot1) and AbyssData:GetAbyssCfg(slot1).stage_list[slot2][1] == 3 then
		slot11 = slot0:GetContDataTemplateById(slot6[2]):GetTeamCount()
		slot12 = nil

		for slot17 = 1, AbyssTools.GetLayerBossTeamCacheFlag(slot1, slot2) and slot11 - 1 or AbyssData:GetStageData(slot1, slot2).is_completed and slot11 - 1 or slot11 do
			for slot22, slot23 in ipairs(slot10:GetHeroList(slot17)) do
				if slot23:GetHeroID() ~= 0 then
					slot3[#slot3 + 1] = slot24
				end
			end
		end
	end

	return slot3
end

return slot1
