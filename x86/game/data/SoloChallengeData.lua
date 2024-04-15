slot0 = singletonClass("SoloChallengeData")
slot1 = nil

function slot0.Init(slot0)
	slot0.customAffixList_ = {}
	slot0.completedActivityList_ = {}
	slot0.receivedActivityList_ = {}
	slot0.uncompletedActivityList_ = {}
	slot0.affixStateList_ = {}
	slot0.stageIDToActivityID_ = {}
	slot0.completedStageList_ = {}
	slot0.lastTeamDataList_ = {}
	slot0.InitedAffixState_ = {}
	uv0 = nil
end

function slot0.SetData(slot0, slot1)
	slot2 = slot1.info
	slot3 = ActivitySoloChallengeCfg[slot2.challenge_id].activity_id
	slot0.completedActivityList_[slot3] = {}
	slot0.receivedActivityList_[slot3] = {}

	for slot7, slot8 in ipairs(slot2.is_award_admited) do
		slot0:SetReceivedActivityList(slot3, SoloChallengeTools.GetDifficultyIndex(slot8), false)
	end

	slot4 = false

	for slot8, slot9 in ipairs(slot2.is_clear) do
		slot0:SetCompletedActivityList(slot3, SoloChallengeTools.GetDifficultyIndex(slot9), false)

		slot4 = true
	end

	if not slot4 and not table.keyof(slot0.uncompletedActivityList_, slot3) then
		table.insert(slot0.uncompletedActivityList_, slot3)
	end

	for slot10, slot11 in ipairs(ActivitySoloChallengeCfg[slot2.challenge_id].stage_id) do
		if slot11[1] == (slot2.select_difficult or 1) then
			slot0:SetSelectedDifficultyIndex(slot3, slot10)
		end
	end

	slot0.completedStageList_[slot3] = slot0.completedStageList_[slot3] or {}

	if slot2.solo_info ~= nil then
		slot8 = 1

		for slot12 = 1, #ActivitySoloChallengeCfg[slot3].stage_id do
			slot0.completedStageList_[slot3][slot12] = {}

			for slot16 = 1, 3 do
				if slot2.clear_list[slot8] == 1 then
					table.insert(slot0.completedStageList_[slot3][slot12], ActivitySoloChallengeCfg[slot3].stage_id[slot12][2][slot16])
				end

				slot8 = slot8 + 1
			end
		end
	end

	slot0:RefreshRedPoint(slot3)
end

function slot0.InitAffixState(slot0, slot1)
	slot0.customAffixList_[slot1] = {}
	slot0.affixStateList_[slot1] = {}

	for slot7, slot8 in ipairs(ActivitySoloChallengeCfg[slot1].stage_id) do
		slot0.affixStateList_[slot1][slot7] = {}
		slot12 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(slot8[1])

		for slot16, slot17 in ipairs(slot8[2]) do
			for slot22, slot23 in ipairs(slot12:GetAffixList(slot16)) do
				if slot23 ~= 0 then
					slot0.customAffixList_[slot1] = slot0.customAffixList_[slot1] or {}
					slot0.customAffixList_[slot1][slot17] = slot0.customAffixList_[slot1][slot17] or {}
					slot0.customAffixList_[slot1][slot17][slot22] = slot23
					slot0.affixStateList_[slot1][slot7][slot23] = slot0.affixStateList_[slot1][slot7][slot23] or {}
					slot0.affixStateList_[slot1][slot7][slot23].stageID = slot17
					slot0.affixStateList_[slot1][slot7][slot23].pos = slot22
				end
			end
		end
	end

	slot0.InitedAffixState_[slot1] = true
end

function slot0.EquipAffix(slot0, slot1, slot2, slot3, slot4)
	if not slot0.InitedAffixState_[slot1] then
		slot0:InitAffixState(slot1)
	end

	slot5 = slot0:GetSelectedDifficultyIndex(slot1)
	slot0.customAffixList_[slot1] = slot0.customAffixList_[slot1] or {}
	slot0.customAffixList_[slot1][slot2] = slot0.customAffixList_[slot1][slot2] or {}
	slot0.customAffixList_[slot1][slot2][slot3] = slot4
	slot0.affixStateList_[slot1] = slot0.affixStateList_[slot1] or {}
	slot0.affixStateList_[slot1][slot5] = slot0.affixStateList_[slot1][slot5] or {}
	slot0.affixStateList_[slot1][slot5][slot4] = slot0.affixStateList_[slot1][slot5][slot4] or {}
	slot0.affixStateList_[slot1][slot5][slot4].stageID = slot2
	slot0.affixStateList_[slot1][slot5][slot4].pos = slot3
end

function slot0.DischargeAffix(slot0, slot1, slot2)
	if not slot0.InitedAffixState_[slot1] then
		slot0:InitAffixState(slot1)
	end

	slot3 = slot0:GetSelectedDifficultyIndex(slot1)

	if slot0.affixStateList_[slot1] and slot0.affixStateList_[slot1][slot3] and slot0.affixStateList_[slot1][slot3][slot2] then
		slot0.customAffixList_[slot1][slot0.affixStateList_[slot1][slot3][slot2].stageID][slot0.affixStateList_[slot1][slot3][slot2].pos] = nil
		slot0.affixStateList_[slot1][slot3][slot2].stageID = nil
		slot0.affixStateList_[slot1][slot3][slot2].pos = nil
		slot0.affixStateList_[slot1][slot3][slot2] = nil
	end
end

function slot0.GetAffixState(slot0, slot1, slot2)
	if not slot0.InitedAffixState_[slot1] then
		slot0:InitAffixState(slot1)
	end

	slot3 = slot0:GetSelectedDifficultyIndex(slot1)

	if slot0.affixStateList_[slot1] == nil or slot0.affixStateList_[slot1][slot3] == nil or slot0.affixStateList_[slot1][slot3][slot2] == nil then
		return {
			stageID = -1,
			pos = -1
		}
	end

	return {
		stageID = slot0.affixStateList_[slot1][slot3][slot2].stageID,
		pos = slot0.affixStateList_[slot1][slot3][slot2].pos
	}
end

function slot0.GetAffixCount(slot0, slot1, slot2)
	if slot0.customAffixList_[slot1] and slot0.customAffixList_[slot1][slot2] then
		return table.nums(slot0.customAffixList_[slot1][slot2])
	end

	return 0
end

function slot0.GetNextEquipPos(slot0, slot1, slot2)
	if slot0.customAffixList_[slot1] and slot0.customAffixList_[slot1][slot2] then
		slot6 = slot1

		for slot6 = 1, slot0:GetMaxAffixCount(slot6) do
			if slot0.customAffixList_[slot1][slot2][slot6] == nil then
				return slot6
			end
		end
	end

	return -1
end

function slot0.CanEquipAffix(slot0, slot1, slot2)
	return slot0:GetAffixCount(slot1, slot2) < slot0:GetMaxAffixCount(slot1)
end

function slot0.GetCustomAffixList(slot0, slot1, slot2)
	slot3 = {}

	if slot0.customAffixList_[slot1] ~= nil then
		slot7 = slot1

		for slot7 = 1, slot0:GetMaxAffixCount(slot7) do
			if slot0.customAffixList_[slot1][slot2] and slot0.customAffixList_[slot1][slot2][slot7] then
				slot3[slot7] = slot0.customAffixList_[slot1][slot2][slot7]
			end
		end
	end

	return slot3
end

function slot0.GetMaxAffixCount(slot0, slot1)
	if ActivitySoloChallengeCfg[slot1] ~= nil then
		slot2 = ActivitySoloChallengeCfg[slot1].max_affix_count or 2
	end

	return slot2
end

function slot0.SaveActivityID(slot0, slot1, slot2)
	if slot0.stageIDToActivityID_[slot2] == nil then
		slot0.stageIDToActivityID_[slot2] = {}
	end

	slot0.stageIDToActivityID_[slot2].activityID = slot1
end

function slot0.GetActivityID(slot0, slot1)
	return slot0.stageIDToActivityID_[slot1].activityID
end

function slot0.SaveDifficultyIndex(slot0, slot1, slot2)
	if slot0.stageIDToActivityID_[slot2] == nil then
		slot0.stageIDToActivityID_[slot2] = {}
	end

	slot0.stageIDToActivityID_[slot2].difficultyIndex = slot1
end

function slot0.GetDifficultyIndex(slot0, slot1)
	return slot0.stageIDToActivityID_[slot1].difficultyIndex
end

function slot0.GetCompletedStageList(slot0, slot1)
	return slot0.completedStageList_[slot1] or {}
end

function slot0.GetCompletedStageCount(slot0, slot1)
	return #slot0:GetCompletedStageList(slot1)
end

function slot0.GetCompletedActivityList(slot0)
	return slot0.completedActivityList_
end

function slot0.SetCompletedActivityList(slot0, slot1, slot2, slot3)
	if slot0.completedActivityList_[slot1] == nil then
		slot0.completedActivityList_[slot1] = {}
	end

	if table.keyof(slot0.completedActivityList_[slot1], slot2) == nil then
		table.insert(slot0.completedActivityList_[slot1], slot2)
	end

	table.removebyvalue(slot0.uncompletedActivityList_, slot1)

	if slot3 ~= false then
		slot0:RefreshRedPoint(slot1)
	end
end

function slot0.GetReceivedActivityList(slot0)
	return slot0.receivedActivityList_
end

function slot0.SetReceivedActivityList(slot0, slot1, slot2, slot3)
	if slot0.receivedActivityList_[slot1] == nil then
		slot0.receivedActivityList_[slot1] = {}
	end

	if table.keyof(slot0.receivedActivityList_[slot1], slot2) == nil then
		table.insert(slot0.receivedActivityList_[slot1], slot2)
	end

	if slot3 ~= false then
		slot0:RefreshRedPoint(slot1)
	end
end

function slot0.SetSelectActivityID(slot0, slot1, slot2)
	saveData("SoloChallenge", "selectActivityID_" .. slot1, slot2)

	if table.keyof(slot0.uncompletedActivityList_, slot2) then
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, ActivitySoloChallengeCfg[slot2].main_activity_id, slot2), 0)
	end
end

function slot0.GetSelectActivityID(slot0, slot1)
	return getData("SoloChallenge", "selectActivityID_" .. slot1)
end

function slot0.GetActivityTeamData(slot0, slot1)
	slot2 = slot0:GetSelectedDifficultyIndex(slot1)
	slot4 = {
		before_solo_info = {}
	}
	slot5, slot6 = slot0:GetCustomHeroList(slot1, slot2)
	slot9 = 0
	slot10 = {}

	for slot14, slot15 in ipairs(ActivitySoloChallengeCfg[slot1].stage_id[slot0:GetSelectedDifficultyIndex(slot1)][2]) do
		if table.nums(slot0.completedStageList_[slot1][slot2]) < slot14 then
			if slot6[slot14] ~= 0 then
				-- Nothing
			else
				slot16.hero_id = slot5[slot14]
			end

			slot10 = slot0:GetCustomAffixList(slot1, slot15)

			for slot21 = 1, slot0:GetMaxAffixCount(slot1) do
				if slot10[slot21] ~= nil then
					-- Nothing
				else
					slot17[slot21] = 0
				end
			end

			slot4.before_solo_info[#slot4.before_solo_info + 1] = {
				challenge_id = slot1,
				stage_id = slot15,
				hero_id = slot6[slot14],
				artifact = {
					[slot21] = slot10[slot21]
				}
			}
		end
	end

	return slot4
end

function slot0.ResetLockData(slot0, slot1)
	slot0.completedStageList_[slot1][slot0:GetSelectedDifficultyIndex(slot1)] = {}
end

function slot0.RefreshRedPoint(slot0, slot1)
	slot2 = ActivitySoloChallengeCfg[slot1].main_activity_id
	slot4 = slot0.receivedActivityList_[slot1]
	slot5 = nil

	if #slot0.completedActivityList_[slot1] == 0 then
		slot5 = 1
	else
		for slot9, slot10 in pairs(slot3) do
			if (table.keyof(slot4, slot10) == nil and 1 or 0) == 1 then
				break
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, slot2, slot1), slot5)
end

function slot0.SetSelectedDifficultyIndex(slot0, slot1, slot2)
	saveData("SoloChallenge", "selectDifficultyIndex_" .. slot1, slot2)
end

function slot0.GetSelectedDifficultyIndex(slot0, slot1)
	return getData("SoloChallenge", "selectDifficultyIndex_" .. slot1)
end

function slot0.SetContentPosX(slot0, slot1, slot2)
	saveData("SoloChallenge", "contentPosX" .. slot1, slot2)
end

function slot0.GetContentPosX(slot0, slot1)
	return getData("SoloChallenge", "contentPosX" .. slot1)
end

function slot0.SaveLocalCustomList(slot0, slot1)
	slot2 = slot0:GetSelectedDifficultyIndex(slot1)
	slot3 = {}
	slot4, slot5 = slot0:GetCustomHeroList(slot1, slot2)
	slot7 = 0
	slot8 = {}

	for slot12, slot13 in ipairs(ActivitySoloChallengeCfg[slot1].stage_id[slot2][2]) do
		if slot5[slot12] ~= 0 then
			-- Nothing
		else
			slot14.hero_Id = slot4[slot12]
		end

		slot8 = slot0:GetCustomAffixList(slot1, slot13)

		for slot19 = 1, slot0:GetMaxAffixCount(slot1) do
			if slot8[slot19] ~= nil then
				-- Nothing
			else
				slot15[slot19] = 0
			end
		end

		table.insert(slot3, {
			hero_Id = slot5[slot12],
			artifact = {
				[slot19] = slot8[slot19]
			}
		})
	end

	uv0 = slot3

	saveData("SoloChallenge", "CustomList", slot3)
end

function slot0.GetLocalCustom(slot0)
	if uv0 == nil then
		uv0 = getData("SoloChallenge", "CustomList")
	end

	return uv0
end

function slot0.GetLocalCustomHeroList(slot0)
	if uv0 == nil then
		uv0 = getData("SoloChallenge", "CustomList")
	end

	if uv0 then
		slot1 = {}
		slot2 = {}

		for slot6 = 1, 3 do
			slot8 = 0
			slot9 = 0

			if uv0[slot6] then
				if HeroStandardSystemCfg[slot7.hero_Id] == nil then
					slot8 = slot7.hero_Id
				else
					slot8 = slot10.hero_id
					slot9 = slot7.hero_Id
				end
			end

			table.insert(slot1, slot8)
			table.insert(slot2, slot9)
		end

		return slot1, slot2
	end

	return {}
end

function slot0.GetLocalCustomAffix(slot0, slot1)
	if uv0 == nil then
		uv0 = getData("SoloChallenge", "CustomList")
	end

	if uv0 then
		slot3 = {}

		if uv0[slot1] then
			for slot7, slot8 in ipairs(slot2.artifact) do
				if slot8 and slot8 ~= 0 then
					slot3[slot7] = slot8
				end
			end
		end

		return slot3
	end

	return {}
end

return slot0
