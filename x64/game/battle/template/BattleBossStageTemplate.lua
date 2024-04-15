slot0 = class("BattleBossStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleBossStageCfg[slot0.id]
	slot0.bossIndex_ = slot2
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
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE
end

function slot0.GetMap(slot0)
	return slot0.cfg.map, false
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return BattleBossChallengeNormalData:GetBossChallengeCfg().level[1]
end

function slot0.GetHeroTeam(slot0)
	return slot0.heroList_, slot0.heroTrialList_
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

function slot0.GetThreeStar(slot0)
	if slot0.cfg.three_star_need == "" then
		return {}
	end

	return slot0.cfg.three_star_need
end

function slot0.GetAttributeFactor(slot0)
	slot2 = BattleBossChallengeNormalData:GetBossChallengeCfg().monster_value[BattleBossChallengeNormalData:GetSelectDifficult(slot0.bossIndex_)]

	return Vector3.New(slot2[1] / 1000, slot2[2] / 1000, slot2[3] / 1000)
end

return slot0
