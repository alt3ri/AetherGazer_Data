slot0 = class("BattleSequentialBattleStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.cfg = BattleSequentialBattleStageCfg[slot1]
	slot0.activityID_ = slot2
	slot0.currentStageIndex_ = SequentialBattleData:GetCurrentFinishStageIndex(slot2) + 1
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
	return BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE
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
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in ipairs(SequentialBattleTools.GetEnabledBuff(slot0.activityID_, slot0.currentStageIndex_)) do
		table.insert(slot2, SequentialBattleBuffCfg[slot9].affix_id)
		table.insert(slot3, 1)
		table.insert(slot4, 3)
	end

	return slot2, slot3, slot4
end

return slot0
