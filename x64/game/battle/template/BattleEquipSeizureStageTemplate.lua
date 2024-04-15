slot0 = class("BattleEquipSeizureStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleEquipSeizureStageCfg[slot1]
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
	return BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE
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

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetStageAffix(slot0)
	for slot8, slot9 in pairs(type(slot0.cfg.affix_type) == "table" and slot0.cfg.affix_type or {} or {}) do
		table.insert({}, slot9[1])
		table.insert({}, slot9[2])
		table.insert({}, slot9[3])
	end

	slot7 = EquipSeizureData
	slot9 = slot7

	for slot8, slot9 in ipairs(slot7.GetAffixIDList(slot9)) do
		slot10 = ActivityAffixPoolCfg[slot9].affix

		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

return slot0
