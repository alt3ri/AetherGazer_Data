slot0 = class("BattleActivityPushBoxTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.destID_ = slot3
	slot0.activityID_ = slot2
	slot0.stageID_ = slot1
	slot0.cfg = BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId())
	slot0.heroList_, _, _, slot0.heroTrialList_ = GetLocalHeroTeam(slot0:GetType(), slot0.stageID_, slot2)

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
	return BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_
end

function slot0.GetThreeStar(slot0)
	return {}
end

function slot0.GetCost(slot0)
	return ActivityCelebrationOrderCfg[slot0:GetDest()].cost or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot9, slot10 in pairs(ActivityCelebrationOrderCfg[slot0:GetDest()].affix_list or {}) do
		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

return slot0
