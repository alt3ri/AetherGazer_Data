slot0 = class("BattleSailGameTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleSailGameStageCfg[slot1]
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.SAIL_GAME
end

function slot0.GetStageId(slot0)
	return slot0.id_
end

function slot0.GetDest(slot0)
	slot1 = SailGameData:GetCurGameData(slot0.activityID_)

	return slot1.eventList[slot1.curStageIndex].order
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level or 0
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level or 0
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetCost(slot0)
	return slot0.cfg.cost or 0
end

return slot0
