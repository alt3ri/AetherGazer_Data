slot0 = class("BattleActivityAttributeArenaTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.stageID_ = slot1
	slot0.cfg = BattleAttributeArenaCfg[slot0.stageID_]
	slot0.destID_ = slot3
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0.destID_
end

function slot0.GetStageId(slot0)
	return slot0.stageID_
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_
end

return slot0
