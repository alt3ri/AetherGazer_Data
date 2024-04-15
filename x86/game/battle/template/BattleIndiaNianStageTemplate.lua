slot0 = class("BattleIndiaNianStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.stageID_ = slot1
	slot0.cfg = BattleStageTools.GetStageCfg(slot0:GetType(), slot1)
	slot0.destID_ = IndiaNianData:GetSelectedDestID()
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
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN
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
	return IndiaNianData:GetSelectedStageCost()
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = IndiaNianData:GetClearedBossIDList()

	if IndiaNianCfg[IndiaNianData:GetSelectedDestID()].group_id == 100 then
		for slot9, slot10 in ipairs(slot4) do
			for slot16, slot17 in ipairs(IndiaNianCfg[slot10].affix_reward) do
				table.insert(slot1, slot17[1])
				table.insert(slot2, slot17[2])
				table.insert(slot3, slot17[3])
			end
		end
	end

	return slot1, slot2, slot3
end

function slot0.GetAILevel(slot0)
	return slot0.cfg.ai_level
end

function slot0.GetEnemyLevel(slot0)
	return slot0.cfg.monster_level
end

return slot0
