slot0 = class("BattleNewWarChessStageTemplate", BattleBaseStageTemplate)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1)

	slot0.id = slot1
	slot0.activityID_ = slot2
	slot0.cfg = BattleNewWarChessStageCfg[slot1]
end

function slot0.Init(slot0)
	slot0:InitHeroList()
	slot0:InitComboSkillID()
	slot0:InitChipData()
end

function slot0.InitChipData(slot0)
	slot1 = {}
	slot0.chipManagerID_, slot1 = ReserveTools.GetMimirData(slot0:GetReserveParams())

	if not slot0.chipManagerID_ or slot0.chipManagerID_ == 0 then
		slot1 = {}
	end

	slot2, slot3 = slot0:GetHeroTeam()
	slot4 = {}
	slot5 = false

	for slot9, slot10 in pairs(slot2) do
		slot5 = false

		for slot14, slot15 in pairs(slot3) do
			if slot10 == (slot15 - slot15 % 100) / 100 then
				slot5 = true
			end
		end

		if slot5 == false then
			table.insert(slot4, slot10)
		end
	end

	slot0.chipList_ = ChipData:GetEnableAllChipList(slot0.chipManagerID_, slot4, slot1)
end

function slot0.GetDest(slot0)
	return slot0.id
end

function slot0.GetStageId(slot0)
	return slot0.id
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS
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
	for slot8, slot9 in pairs(type(slot0.cfg.affix_type) == "table" and slot0.cfg.affix_type or {} or {}) do
		table.insert({}, slot9[1])
		table.insert({}, slot9[2])
		table.insert({}, slot9[3])
	end

	for slot9, slot10 in pairs(manager.NewChessManager:GetCurBattleAffix() or {}) do
		table.insert(slot1, slot10[1])
		table.insert(slot2, slot10[2])
		table.insert(slot3, slot10[3])
	end

	return slot1, slot2, slot3
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}

	for slot5, slot6 in ipairs(slot1.heroList) do
		table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetNewWarChessHeroData(slot6, slot6.trialID ~= 0 and slot6.trialID, slot1.playerID, slot1.level))
	end

	slot0:SetMaxRaceData()
end

return slot0
