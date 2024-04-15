slot0 = class("BattleActivityHeroEnhanceTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleHeroEnhanceCfg[slot1]
	slot0.heroEnhanceCfgId_ = slot3
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.GetDest(slot0)
	return slot0:GetStageId()
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE
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

function slot0.GetAddUserExp(slot0)
	return slot0.cfg.user_exp or 0
end

function slot0.GetAddHeroExp(slot0)
	return slot0.cfg.hero_exp or 0
end

function slot0.GetCost(slot0)
	return slot0.cfg.cost or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(slot0:GetTalentIdList()) do
		table.insert(slot1, TalentTreeCfg[slot9].affix_id)
		table.insert(slot2, 1)
		table.insert(slot3, TalentTreeCfg[slot9].affix_user)
	end

	return slot1, slot2, slot3
end

function slot0.GetHeroEnhanceCfgId(slot0)
	return slot0.heroEnhanceCfgId_
end

function slot0.GetTalentIdList(slot0)
	return ActivityHeroEnhanceTools.GetCfgActivatedTalentDict(ActivityHeroEnhanceCfg[slot0.heroEnhanceCfgId_])
end

return slot0
