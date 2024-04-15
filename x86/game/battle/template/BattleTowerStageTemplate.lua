slot0 = class("BattleTowerStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleTowerStageCfg[slot0.id]
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(type(slot0.cfg.affix_type) == "table" and slot0.cfg.affix_type or {} or {}) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetSettingShowAffix(slot0)
	slot2, slot3, slot4 = slot0:GetBattleStageAffix()

	for slot9 = 1, #slot2 do
		table.insert({}, {
			slot2[slot9],
			slot3[slot9],
			slot4[slot9]
		})
	end

	for slot10, slot11 in pairs(type(slot0.cfg.affix_type_in_map) == "table" and slot0.cfg.affix_type_in_map or {} or {}) do
		table.insert(slot1, slot11)
	end

	return slot1
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

return slot0
