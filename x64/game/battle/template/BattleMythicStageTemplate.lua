slot0 = class("BattleMythicStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.dest = slot2

	uv0.super.Ctor(slot0, slot0.id)

	slot0.cfg = BattleMythicStageCfg[slot0.id]
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.dest
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetAttributeFactor(slot0)
	return MythicData:GetAttributeFactor(slot0.dest)
end

function slot0.GetEnemyLevel(slot0)
	return MythicData:GetMonsterLevel(slot0.dest)
end

function slot0.GetStageAffix(slot0)
	slot5 = MythicData:GetHeroAffix()

	for slot9, slot10 in pairs(MythicData:GetMonsterAffix() or {}) do
		table.insert({}, slot10[1])
		table.insert({}, slot10[2])
		table.insert({}, slot10[3])
	end

	for slot9, slot10 in pairs(slot5 or {}) do
		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetThreeStar(slot0)
	if slot0.cfg.three_star_need == "" then
		return {}
	end

	return slot0.cfg.three_star_need
end

return slot0
