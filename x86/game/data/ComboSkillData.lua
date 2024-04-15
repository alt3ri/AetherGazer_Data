slot0 = singletonClass("ComboSkillData")
slot1 = {}

function slot0.Init(slot0)
	slot0.comboSkill_ = {}
	slot0.needRefresh_ = false
	slot0.needRefreshBoss_ = {}
	uv0 = {}
end

function slot0.InitData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.cooperate_unique_skill_list) do
		slot0.comboSkill_[slot6.type] = slot0.comboSkill_[slot6.type] or {}

		if slot6.difficulty == nil then
			slot7 = 1
		end

		slot0.comboSkill_[slot6.type][slot7] = slot6.cooperate_unique_skill_id
	end
end

function slot0.GetComboSkillID(slot0, slot1, slot2, slot3)
	if slot3 == nil then
		slot3 = 1
	end

	slot4 = GetHeroTeamActivityID(slot1, slot2)

	if (slot1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE) and getData("BossChallenge", "boss_combo_skill_" .. slot3) then
		return slot5
	end

	if slot0.comboSkill_[slot4] and slot0.comboSkill_[slot4][slot3] then
		return slot0.comboSkill_[slot4][slot3]
	else
		return 0
	end
end

function slot0.SetComboSkillID(slot0, slot1, slot2, slot3)
	if slot0.comboSkill_[slot1] == nil then
		slot0.comboSkill_[slot1] = {}
	end

	slot0.comboSkill_[slot1][slot2] = slot3

	if slot1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE or slot1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		saveData("BossChallenge", "boss_combo_skill_" .. slot2, slot3)
	end
end

function slot0.SetNeedRefresh(slot0, slot1)
	slot0.needRefresh_ = slot1
end

function slot0.GetNeedRefresh(slot0, slot1, slot2)
	return slot0.needRefresh_
end

function slot0.SetBossChallengeNeedRefresh(slot0, slot1, slot2)
	slot0.needRefreshBoss_[slot1] = slot2
end

function slot0.GetBossChallengeNeedRefresh(slot0, slot1)
	return slot0.needRefreshBoss_[slot1]
end

function slot0.SetMatrixNeedRefresh(slot0, slot1)
	slot0.matrixNeedRefresh_ = slot1
end

function slot0.GetMatrixNeedRefresh(slot0)
	return slot0.matrixNeedRefresh_
end

function slot0.GetComboSkill(slot0)
	return slot0.comboSkill_
end

function slot0.InitLevelData(slot0, slot1)
	uv0 = {}

	for slot6, slot7 in ipairs(slot1.info.skill_list) do
		slot8 = {}

		for slot12, slot13 in ipairs(slot7.progress_list) do
			table.insert(slot8, {
				condition_id = slot13.id,
				times = slot13.times
			})
		end

		uv0[slot7.id] = {
			level = slot7.level,
			progress_list = slot8
		}
	end
end

function slot0.UpdateLevelData(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.skill.progress_list) do
		table.insert(slot3, {
			condition_id = slot8.id,
			times = slot8.times
		})
	end

	uv0[slot2.id] = {
		level = slot2.level,
		progress_list = slot3
	}
end

function slot0.UpgradeComboSkillLevel(slot0, slot1)
	if uv0[slot1] then
		uv0[slot1].level = slot0:GetCurComboSkillLevel(slot1) + 1
	else
		uv0[slot1] = {
			level = 1,
			progress_list = {}
		}
	end
end

function slot0.GetCurComboSkillLevel(slot0, slot1)
	if uv0[slot1] then
		return slot2.level
	else
		return 1
	end
end

function slot0.GetComboSkillUpConditionProcess(slot0, slot1, slot2)
	if uv0[slot1] then
		for slot7, slot8 in ipairs(slot3.progress_list) do
			if slot2 == slot8.condition_id then
				return slot8.times
			end
		end
	end

	return 0
end

return slot0
