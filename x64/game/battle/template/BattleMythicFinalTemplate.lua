slot0 = class("BattleMythicFinalTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleMythicFinalCfg[slot1]
	slot0.levelcfg = MythicFinalCfg[MythicData:GetCurHotLevelId()]
	slot0.nextBattleStage_ = nil
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0:GetTeamIndex()
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetAttributeFactor(slot0)
	if MythicFinalCfg[MythicData:GetCurHotLevelId()].attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(MythicData:GetFinalMonsterAffix() or {}) do
		table.insert(slot1, slot9[1])
		table.insert(slot2, slot9[2])
		table.insert(slot3, slot9[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetEnemyLevel(slot0)
	return slot0.levelcfg.monster_level
end

function slot0.GetNextStage(slot0)
	return slot0.nextBattleStage_
end

function slot0.SetNextStage(slot0, slot1)
	slot0.nextBattleStage_ = slot1
end

function slot0.GetBattleTime(slot0)
	return MythicData:GetBattleRemainTime(slot0:GetDest())
end

return slot0
