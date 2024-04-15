slot0 = class("BattleSPHeroChallengeTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleVerthandiExclusiveCfg[slot1]
end

function slot0.Init(slot0)
	slot0.heroList_ = slot0.cfg.hero_list
	slot0.systemHeroList = {}

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
	return BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1
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

function slot0.GetAttributeFactor(slot0)
	if slot0.cfg.attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot5 = SPHeroChallengeData:GetCurActivityInfo()
	slot6 = SPHeroChallengeData:GetActivityID()

	for slot11, slot12 in pairs(SPHeroChallengeTools:GetUnlockChapterAffix() or {}) do
		table.insert({}, slot12[1])
		table.insert({}, slot12[2])
		table.insert({}, slot12[3])
	end

	for slot12, slot13 in pairs(SPHeroChallengeTools:GetUnlockAffix() or {}) do
		if ActivityAffixPoolCfg[slot13] then
			table.insert(slot2, slot14.affix[1])
			table.insert(slot3, slot14.affix[2])
			table.insert(slot4, slot14.affix[3])
		end
	end

	if slot0.cfg.sub_type == SpHeroChallengeConst.BattleSubType.boss and slot5 then
		if ActivityHeroChallengeCfg[slot6].affix_defense then
			table.insert(slot2, slot10[1])
			table.insert(slot3, slot5:GetBossErosiveness())
			table.insert(slot4, slot10[3])
		end
	end

	return slot2, slot3, slot4
end

return slot0
