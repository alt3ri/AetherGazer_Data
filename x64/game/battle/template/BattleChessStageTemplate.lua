slot0 = class("BattleChessStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleChessStageCfg[slot1]
	slot0.nextBattleStage_ = nil
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
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS
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

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}

	for slot6, slot7 in ipairs(slot1.heroList) do
		table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetChessHeroData(slot7, slot7.trialID ~= 0 and slot7.trialID or slot0:GetSystemHeroTeam()[slot6] or 0, slot1.playerID, slot1.level))
	end

	slot0:SetMaxRaceData()
end

function slot0.GetStageAffix(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	for slot8, slot9 in pairs(WarChessData:GetArtifactData()) do
		if not WarchessItemCfg[slot8] then
			CustomLog.Log("不存在的战棋神器:" .. slot8)
		end

		for slot14, slot15 in ipairs(slot10.params) do
			table.insert(slot1, slot15[1])
			table.insert(slot2, slot15[2])
			table.insert(slot3, slot10.sub_affix_type)
		end
	end

	for slot10, slot11 in ipairs(TalentTreeData:GetTalentListByTheme(ActivityTools.GetActivityTheme(slot0.activityID_))) do
		table.insert(slot1, slot11[1])
		table.insert(slot2, slot11[2])
		table.insert(slot3, slot11[3])
	end

	return slot1, slot2, slot3
end

function slot0.GetServerExtant(slot0)
	return WarChessData:GetBattleIndex()
end

function slot0.GetNextStage(slot0)
	return slot0.nextBattleStage_
end

function slot0.SetNextStage(slot0, slot1)
	slot0.nextBattleStage_ = slot1
end

return slot0
