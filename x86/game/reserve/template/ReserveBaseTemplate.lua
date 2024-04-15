slot0 = class("ReserveBaseTemplate")

function slot0.Ctor(slot0, slot1)
	slot0.team_type = slot1 or ReserveConst.RESERVE_TYPE.DEFAULT
	slot0.cont_teams = {}
	slot0.cont_dic = {}
end

function slot0.UpdateServerData(slot0, slot1)
	slot0.team_type = slot1.team_type

	for slot5, slot6 in ipairs(slot1.cont_teams) do
		slot0:GetContDataTemplateById(slot6.cont_id):UpdateServerData(slot6)
	end
end

function slot0.GetTeamType(slot0)
	return slot0.team_type
end

function slot0.SetHeroList(slot0, slot1, slot2, slot3)
	slot0:GetContDataTemplateById(slot1.contID):SetHeroList(slot2, slot3, slot1.teamIndex)
end

function slot0.GetHeroList(slot0, slot1)
	slot2 = {
		isInVaild = false,
		resultHeroList = {
			0,
			0,
			0
		},
		lockStateList = {
			false,
			false,
			false
		},
		lockHeroList = {},
		resultTrialList = {
			0,
			0,
			0
		}
	}

	if slot1.reserveType ~= ReserveConst.RESERVE_TYPE.NOT_NEED_RESERVE then
		slot0:FormatHeroList(slot1, slot2, slot0:GetContDataTemplateById(slot1.contID):GetHeroList(slot1.teamIndex))

		if slot1.needDefaultTeam and slot0:IsEmptyTeam(slot2) then
			slot0:GetDefaultTeam(slot1, slot2)
		end
	end

	slot0:FilterInvalidTeamData(slot1, slot2)
	slot0:GetLockHero(slot1, slot2)
	slot0:ReorderHeroList(slot1, slot2)

	return slot2.resultHeroList, slot2.lockStateList, slot2.lockHeroList, slot2.resultTrialList, slot2.isInVaild
end

function slot0.FormatHeroList(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot3) do
		slot2.resultHeroList[slot7] = slot8:GetHeroID()
		slot2.resultTrialList[slot7] = slot8:GetTrialID()
	end
end

function slot0.IsEmptyTeam(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.resultHeroList) do
		if slot6 ~= 0 then
			return false
		end
	end

	return true
end

function slot0.GetLockHero(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}
	slot5, slot6, slot7 = nil

	if slot1.stageType and slot1.stageID then
		slot5, slot9 = BattleStageTools.GetRestrictHeroList(slot1.stageType, slot1.stageID)

		if type(slot9) ~= "table" then
			slot6 = {}
		end

		slot7 = BattleStageTools.GetStageCfg(slot1.stageType, slot1.stageID).auto_next_stage_group and slot8.auto_next_stage_group > 0
	end

	if type(slot5) == "table" then
		slot8 = {
			[slot14] = slot12
		}

		for slot12, slot13 in ipairs(slot5) do
			if slot13[1] and slot13[1] ~= 0 and HeroCfg[slot14] and HeroCfg[slot14].private == 0 then
				-- Nothing
			end
		end

		for slot12 = 1, 3 do
			if slot5[slot12][1] then
				if slot13 ~= 0 then
					if not slot7 and slot6[slot12] and slot6[slot12] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
						if slot2.resultHeroList[slot12] == 0 or not slot8[slot15] or slot8[slot15] ~= slot12 then
							slot3[slot12] = slot13
							slot4[slot12] = slot5[slot12][2]
						else
							slot3[slot12] = slot2.resultHeroList[slot12]
							slot4[slot12] = slot2.resultTrialList[slot12]
						end
					else
						slot3[slot12] = slot13
						slot4[slot12] = slot14
						slot2.lockStateList[slot12] = true
					end
				else
					slot3[slot12] = 0
					slot4[slot12] = 0
					slot2.lockStateList[slot12] = true
				end
			elseif slot8[slot2.resultHeroList[slot12]] and slot8[slot15] ~= slot12 then
				slot3[slot12] = 0
				slot4[slot12] = 0
			else
				slot3[slot12] = slot2.resultHeroList[slot12]
				slot4[slot12] = slot2.resultTrialList[slot12]
			end
		end

		slot2.resultHeroList = slot3
		slot2.resultTrialList = slot4
	end
end

function slot0.FilterInvalidTeamData(slot0, slot1, slot2)
	slot3, slot4 = nil

	if slot1.stageType and slot1.stageID then
		slot3, slot4 = BattleStageTools.GetRestrictHeroList(slot1.stageType, slot1.stageID)
	end

	for slot10, slot11 in ipairs(clone(slot2.resultTrialList)) do
		if slot11 ~= 0 and not table.keyof(slot0:GetTrialHeroList(slot1), slot11) then
			slot2.resultTrialList[slot10] = 0
			slot2.resultHeroList[slot10] = 0

			if type(slot4) == "table" then
				for slot15, slot16 in ipairs(slot4) do
					if slot16 ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
						slot2.isInVaild = false
					end
				end
			else
				slot2.isInVaild = true
			end
		end
	end
end

function slot0.ReorderHeroList(slot0, slot1, slot2)
	if slot2.isInVaild then
		for slot6 = 1, 2 do
			for slot10 = slot6 + 1, 3 do
				if slot2.resultHeroList[slot6] == 0 and slot2.lockStateList[slot6] ~= true and slot2.lockStateList[slot10] ~= true then
					slot2.resultHeroList[slot6] = slot2.resultHeroList[slot10]
					slot2.resultHeroList[slot10] = 0
					slot2.resultTrialList[slot6] = slot2.resultTrialList[slot10]
					slot2.resultTrialList[slot10] = 0

					break
				end
			end
		end
	end
end

function slot0.GetTrialHeroList(slot0, slot1)
	slot2 = 0

	if slot1.customData and slot1.customData.activityID then
		slot2 = slot1.customData.activityID
	end

	return GetTrialHeroList(slot1.stageType, slot1.stageID, slot2)
end

function slot0.GetDefaultTeam(slot0, slot1, slot2)
	slot2.resultHeroList, slot2.lockStateList, slot2.lockHeroList, slot2.resultTrialList, slot2.isInVaild = ReserveTools.GetHeroList(ReserveParams.New(ReserveConst.RESERVE_TYPE.DEFAULT))
end

function slot0.GetComboSkillID(slot0, slot1)
	slot4 = ReserveTools.GetHeroList(slot1)

	if slot0:GetContDataTemplateById(slot1.contID):GetComboSkillID(slot1.teamIndex) ~= 0 and not ComboSkillTools.IsAllMatch(slot3, slot4) then
		return ComboSkillTools.GetRecommendSkillID(slot4, true)
	end

	return slot3
end

function slot0.SetComboSkillID(slot0, slot1, slot2)
	slot0:GetContDataTemplateById(slot1.contID):SetComboSkillID(slot2, slot1.teamIndex)
end

function slot0.GetMimirData(slot0, slot1)
	return slot0:GetMimirID(slot1), slot0:GetMimirChipList(slot1)
end

function slot0.GetMimirID(slot0, slot1)
	return slot0:GetContDataTemplateById(slot1.contID):GetMimirID(slot1.teamIndex)
end

function slot0.SetMimirID(slot0, slot1, slot2)
	slot0:GetContDataTemplateById(slot1.contID):SetMimirID(slot2, slot1.teamIndex)
end

function slot0.GetMimirChipList(slot0, slot1)
	return slot0:GetContDataTemplateById(slot1.contID):GetMimirChipList(slot1.teamIndex)
end

function slot0.SetMimirChipList(slot0, slot1, slot2)
	return slot0:GetContDataTemplateById(slot1.contID):SetMimirChipList(slot2, slot1.teamIndex)
end

function slot0.ResetMimirChipList(slot0, slot1)
	slot0:GetContDataTemplateById(slot1.contID):ResetMimirChipList(slot1.teamIndex)
end

function slot0.GetContDataTemplateById(slot0, slot1)
	if not slot0.cont_dic[slot1 or ReserveConst.DETAULT_CONT_ID] then
		slot0.cont_dic[slot1] = slot0:GetContDataTemplateClass().New(slot0:GetTeamType(), slot1)
		slot0.cont_teams[#slot0.cont_teams + 1] = slot0.cont_dic[slot1]
	end

	return slot0.cont_dic[slot1]
end

function slot0.GetSingleTeamData(slot0, slot1)
	return slot0:GetContDataTemplateById(slot1.contID or ReserveTools.GetContID(slot1.stageType, slot1.stageID)):GetSingleTeamData(slot1.teamIndex or slot0:GetTeamIndex(slot1))
end

function slot0.CleanCacheData(slot0)
	for slot4, slot5 in ipairs(slot0.cont_teams) do
		slot5:CleanCacheData()
	end
end

function slot0.GetTeamIndex(slot0, slot1)
	return ReserveConst.DEFAULT_TEAM_INDEX
end

function slot0.GetContDataTemplateClass(slot0)
	return ReserveTools.GetContDataClass(slot0:GetTeamType())
end

function slot0.Clone(slot0)
	return deepClone(slot0)
end

return slot0
