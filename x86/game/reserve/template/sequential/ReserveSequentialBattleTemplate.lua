slot1 = class("ReserveSequentialBattleTemplate", import("game.reserve.template.ReserveBaseTemplate"))

function slot1.GetLockHero(slot0, slot1, slot2)
	for slot8 = 1, #SequentialBattleChapterCfg[slot1.contID].stage_id do
		if slot8 ~= slot1.teamIndex then
			for slot14, slot15 in ipairs(slot0:GetContDataTemplateById(slot1.contID):GetHeroList(slot8)) do
				if slot15:GetHeroID() ~= 0 then
					table.insert(slot2.lockHeroList, slot16)
				end
			end
		end
	end
end

function slot1.CheckHeroTeam(slot0, slot1, slot2)
	slot8 = false

	for slot12, slot13 in pairs(slot0:GetContDataTemplateById(slot1):GetHeroList(slot2)) do
		if slot13:GetTrialID() ~= 0 and not table.keyof(GetTrialHeroList(_, _, slot1), slot14) then
			slot13:SetHeroID(0)
			slot13:SetTrialID(0)

			slot8 = true
		end
	end

	if slot8 then
		slot0:SaveEnabledBuff(slot1, slot2)
	end
end

function slot1.SaveEnabledBuff(slot0, slot1, slot2)
	for slot6 = 1, #SequentialBattleChapterCfg[slot1].stage_id do
		slot0:RefreshEnabeldBuff(slot1, slot2)
	end
end

function slot1.RefreshEnabeldBuff(slot0, slot1, slot2)
	slot8 = SequentialBattleBuffCfg.get_id_list_by_activity_id[SequentialBattleChapterCfg[slot1].main_id]

	for slot13, slot14 in pairs(slot0:GetContDataTemplateById(slot1):GetHeroList(slot2)) do
		if slot14:GetHeroID() and slot15 ~= 0 then
			table.insert({}, slot15)
		end
	end

	slot10 = {}

	for slot14, slot15 in ipairs(slot8) do
		slot16 = SequentialBattleBuffCfg[slot15].type
		slot18 = true

		for slot22, slot23 in ipairs(slot16) do
			if SequentialBattleTools.GetConditionStatus(slot9, slot16)[slot22] < slot23[3] then
				slot18 = false

				break
			end
		end

		if slot18 then
			table.insert(slot10, slot15)
		end
	end

	slot5:SetAffixList(slot4, slot10)
end

return slot1
