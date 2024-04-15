slot0 = class("BattleActivityPtScrollTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.stageID_ = slot1
	slot0.cfg = BattleStageTools.GetStageCfg(slot0:GetType(), slot1)
	slot0.destID_ = 0
	slot3 = {}

	for slot8, slot9 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot0.activityID_]) do
		if ActivityPtRouletteStageCfg[slot9].stage_id == slot0.stageID_ then
			slot0.destID_ = slot9
		end
	end
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
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL
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
	return ActivityPtRouletteStageCfg[slot0:GetDest()].cost[2] or 0
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot10, slot11 in ipairs(ActivityPtRouletteStageCfg[slot0:GetDest()].roulette_id) do
		if ActivityPtRouletteRandomCfg[slot11].time == manager.time:GetGameServerWeek() then
			for slot17, slot18 in ipairs(slot12.affix_list) do
				slot20 = ActivityPtRouletteAffixCfg[slot18].affix_list

				table.insert(slot1, slot20[1])
				table.insert(slot2, slot20[2])
				table.insert(slot3, slot20[3])
			end

			slot14 = ActivityPtScrollData:GetChooseAffixID(slot0.activityID_)
			slot15 = ActivityPtScrollData:GetAffixInfo(slot0.activityID_, slot14)

			table.insert(slot1, slot15.affix)
			table.insert(slot2, slot15.level)
			table.insert(slot3, slot15.target)

			for slot20, slot21 in ipairs(ActivityPtRouletteAffixCfg[slot14].affix_list2) do
				table.insert(slot1, slot21[1])
				table.insert(slot2, slot21[2])
				table.insert(slot3, slot21[3])
			end

			break
		end
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
