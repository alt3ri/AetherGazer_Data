slot0 = class("BattleBaseStageTemplate")

function slot0.Ctor(slot0, slot1)
	slot0.roleDataInLua = {}
	slot0.multiple_ = 1
	slot0.comboSkillID_ = 0
	slot0.maxRaceID_ = 0
	slot0.maxRacePlayerCount_ = 1
	slot0.serverTeamPlayer = nil
end

function slot0.Init(slot0)
end

function slot0.InitHeroList(slot0)
	slot0.heroList_, _, _, slot0.heroTrialList_ = ReserveTools.GetHeroList(slot0:GetReserveParams())
end

function slot0.GetDest(slot0)
	return 0
end

function slot0.GetStageId(slot0)
	return 0
end

function slot0.GetType(slot0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function slot0.GetMap(slot0)
	return 0, false
end

function slot0.GetAILevel(slot0)
	return 0
end

function slot0.GetEnemyLevel(slot0)
	return 0
end

function slot0.GetStageAffix(slot0)
	return {}, {}, {}
end

function slot0.GetBattleStageAffix(slot0)
	if slot0.affixIDList == nil or slot0.levelIDList == nil or slot0.targetTypeList == nil then
		slot0.affixIDList, slot0.levelIDList, slot0.targetTypeList = slot0:GetStageAffix()
	end

	return slot0.affixIDList, slot0.levelIDList, slot0.targetTypeList
end

function slot0.GetSettingShowAffix(slot0)
	slot1 = {}
	slot2, slot3, slot4 = slot0:GetBattleStageAffix()

	for slot9 = 1, #slot2 do
		table.insert(slot1, {
			slot2[slot9],
			slot3[slot9],
			slot4[slot9]
		})
	end

	return slot1
end

function slot0.GetRevive(slot0)
	return false, 0, 0, 0
end

function slot0.GetMultiple(slot0)
	return slot0.multiple_ or 1
end

function slot0.SetMultiple(slot0, slot1)
	slot0.multiple_ = slot1
end

function slot0.GetClearTime(slot0)
	return 0
end

function slot0.GetHeroTeam(slot0)
	return {}, {}
end

function slot0.GetAssistHeroOwnerList(slot0)
	return {}
end

function slot0.GetSystemHeroTeam(slot0)
	return {}
end

function slot0.GetRoleDatas(slot0)
	return slot0.roleDataInLua
end

function slot0.GetThreeStar(slot0)
	return {}
end

function slot0.GetAddUserExp(slot0)
	return 0
end

function slot0.GetAddHeroExp(slot0)
	return 0
end

function slot0.GetCost(slot0)
	return 0
end

function slot0.GetAttributeFactor(slot0)
	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()).attribute_factor and slot1.attribute_factor[3] then
		return Vector3.New(slot1.attribute_factor[1] / 1000, slot1.attribute_factor[2] / 1000, slot1.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function slot0.UpdateRoleDatas(slot0, slot1)
	slot0.serverTeamPlayer = slot1
	slot0.roleDataInLua = {}

	for slot6, slot7 in ipairs(slot1.heroList) do
		table.insert(slot0.roleDataInLua, BattleController.GetInstance():SetHeroData(slot7, slot7.trialID ~= 0 and slot7.trialID or slot0:GetSystemHeroTeam()[slot6] or 0, slot1.playerID, slot1.level))
	end

	slot0:SetMaxRaceData()
end

function slot0.GetHeroDataByPos(slot0, slot1)
	slot2, slot3 = slot0:GetHeroTeam()
	slot4 = slot0:GetSystemHeroTeam()

	if slot2[slot1] and slot2[slot1] ~= 0 then
		if slot4[slot1] or slot3[slot1] and slot3[slot1] ~= 0 then
			return GetVirtualData(slot4[slot1] or slot3[slot1])
		else
			slot5 = slot2[slot1]

			if (slot0.serverTeamPlayer and slot0.serverTeamPlayer.heroList[slot1]) == nil then
				return nil
			end

			return GetPracticalData(slot6)
		end
	end

	return nil
end

function slot0.GetIsStoryTag(slot0)
	return slot0.storyTag or false
end

function slot0.SetIsStoryTag(slot0, slot1)
	slot0.storyTag = slot1
end

function slot0.GetIsCooperation(slot0)
	return false, {}
end

function slot0.InitComboSkillID(slot0)
	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()) and slot1.combo_skill_id and slot1.combo_skill_id ~= 0 then
		slot0.comboSkillID_ = slot1.combo_skill_id

		return
	end

	if type(BattleStageTools.GetRestrictHeroList(slot0:GetType(), slot0:GetStageId())) == "table" then
		slot0.comboSkillID_ = 0
	else
		slot0.comboSkillID_ = ReserveTools.GetComboSkillID(slot0:GetReserveParams())
	end
end

function slot0.GetComboSkillID(slot0)
	return slot0.comboSkillID_
end

function slot0.GetComboSkillLevel(slot0)
	return ComboSkillData:GetCurComboSkillLevel(slot0:GetComboSkillID())
end

function slot0.InitChipData(slot0)
	slot2 = {}

	if BattleStageTools.GetStageCfg(slot0:GetType(), slot0:GetStageId()) and type(slot1.chip_list) == "table" then
		slot0.chipManagerID_ = slot1.chip_list[1]

		for slot6 = 2, 3 do
			slot2[slot6 - 1] = slot1.chip_list[slot6]
		end
	else
		slot2 = slot0:GetBaseChipData()
	end

	slot0.chipList_ = slot0:GetHeroChipData(slot2)
end

function slot0.GetBaseChipData(slot0)
	slot1 = {}
	slot0.chipManagerID_, slot1 = ReserveTools.GetMimirData(slot0:GetReserveParams())

	if not slot0.chipManagerID_ or slot0.chipManagerID_ == 0 then
		slot1 = {}
	end

	return slot1
end

function slot0.GetHeroChipData(slot0, slot1)
	slot2, slot3 = slot0:GetHeroTeam()

	for slot7, slot8 in ipairs(slot2) do
		if slot8 ~= 0 then
			if slot3[slot7] and slot9 ~= 0 then
				table.insertto(slot1, HeroStandardSystemCfg[slot9].using_hero_chip)
			else
				for slot13, slot14 in pairs(ChipData:GetEnableHeroChipIdByHeroId(slot8) or {}) do
					if slot14 > 0 then
						table.insert(slot1, slot14)
					end
				end
			end
		end
	end

	return slot1
end

function slot0.GetChipManagerID(slot0)
	return slot0.chipManagerID_ or 0
end

function slot0.GetChipList(slot0)
	return slot0.chipList_ or {}
end

function slot0.GetChipOfHeroDic(slot0)
	return {}
end

function slot0.SetMaxRaceData(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.roleDataInLua) do
		slot1[#slot1 + 1] = SkinCfg[slot6.ID].hero
	end

	slot0.maxRaceID_, slot0.maxRacePlayerCount_ = BattleTools.GetMaxRaceData(slot1)
end

function slot0.GetMaxRaceData(slot0)
	return slot0.maxRaceID_, slot0.maxRacePlayerCount_
end

function slot0.GetPathList(slot0)
	return {}
end

function slot0.GetActivityID(slot0)
	return slot0.activityID_ or 0
end

function slot0.GetServerExtant(slot0)
	return 0
end

function slot0.GetBattleTime(slot0)
	return 0
end

function slot0.GetResurrectHP(slot0)
	return 0
end

function slot0.GetResurrectImmediately(slot0)
	return false
end

function slot0.GetTargetEnemyID(slot0)
	return 0
end

function slot0.SetReserveParams(slot0, slot1)
	slot0.reserveParams_ = slot1 or ReserveTools.GetReserveParams(slot0:GetType(), slot0:GetStageId(), slot0:GetActivityID())
	slot0.contID_ = slot0.reserveParams_.contID
	slot0.teamIndex_ = slot0.reserveParams_.teamIndex
	slot0.customReserveParams_ = slot0.reserveParams_.customData
end

function slot0.GetReserveParams(slot0)
	if not slot0.reserveParams_ then
		slot0.reserveParams_ = ReserveTools.GetReserveParams(slot0:GetType(), slot0:GetStageId(), slot0:GetActivityID())
	end

	return slot0.reserveParams_
end

function slot0.GetContID(slot0)
	return slot0.contID_ or ReserveTools.GetContID(slot0:GetType(), slot0:GetStageId())
end

function slot0.GetTeamIndex(slot0)
	return slot0.teamIndex_ or ReserveConst.DEFAULT_TEAM_INDEX
end

function slot0.GetCustomReserveParams(slot0)
	return slot0.customReserveParams_ or {}
end

function slot0.GetActivityReforgeSkillList(slot0)
	return {}
end

function slot0.GetBattleParams(slot0)
	return 0
end

return slot0
