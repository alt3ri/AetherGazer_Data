slot0 = class("BattleActivityReforgeTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2.activityID
	slot0.chapterActivityID_ = slot2.chapterActivityID
	slot0.levelID_ = slot2.levelID
	slot0.waveID_ = slot2.waveID
	slot0.skillList_ = slot2.skillList
	slot0.battleParams_ = slot2.battleParams
	slot3 = ActivityReforgeData:GetWaveTeamInfo(slot0.waveID_)
	slot0.teamID = slot3.teamID
	slot0.level = slot3.level
	slot0.teamCfg = ActivityReforgeTeamCfg[slot0.teamID]
	slot0.cfg = BattleActivityReforgeCfg[slot1]
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.InitHeroList(slot0)
	slot0.heroTrialList_ = {}
	slot0.heroList_ = {}

	for slot5, slot6 in pairs(slot0.teamCfg.team_info[slot0.level]) do
		table.insert(slot0.heroList_, HeroStandardSystemCfg[slot6].hero_id)
		table.insert(slot0.heroTrialList_, slot6)
	end
end

function slot0.InitComboSkillID(slot0)
	slot0.comboSkillID_ = slot0.teamCfg.combo_skill_id
end

function slot0.InitChipData(slot0)
	slot0.chipList_ = {}
end

function slot0.GetComboSkillLevel(slot0)
	return 3
end

function slot0.GetDest(slot0)
	return slot0.waveID_
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE
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

function slot0.GetChapterActivityID(slot0)
	return slot0.chapterActivityID_
end

function slot0.GetLevelID(slot0)
	return slot0.levelID_
end

function slot0.GetActivityID(slot0)
	return slot0.chapterActivityID_
end

function slot0.GetMainActivityID(slot0)
	return slot0.activityID_
end

function slot0.GetWaveID(slot0)
	return slot0.waveID_
end

function slot0.GetActivityReforgeSkillList(slot0)
	return slot0.skillList_
end

function slot0.GetBattleParams(slot0)
	return slot0.battleParams_
end

return slot0
