slot0 = singletonClass("ActivityReforgeData")
slot0.FinishLevelDataType = {
	"time",
	"point",
	"gold"
}

function slot0.Init(slot0)
	slot0.activityData_ = {}
	slot0.chapterData_ = {}
	slot0.finishLevelData_ = {}
	slot0.curLevelData_ = {}
	slot0.cacheFinishLevelAllPlayerData_ = {}
	slot0.cachePopBattleInfoView_ = false
	slot0.cacheAddGoldNum_ = 0
end

function slot0.SetActivityData(slot0, slot1)
	slot0.activityData_[slot1.activity_id] = {
		goldMax = slot1.gold,
		unlockSkillList = cleanProtoTable(slot1.skill)
	}
end

function slot0.SetChapterData(slot0, slot1)
	slot0.chapterData_[slot1.chapter_id] = {
		finishLevelIDList = {}
	}

	for slot5, slot6 in ipairs(slot1.finish_stage_list) do
		table.insert(slot0.chapterData_[slot1.chapter_id].finishLevelIDList, slot6.stage_id)

		slot0.finishLevelData_[slot6.stage_id] = {
			times = slot6.times,
			minLosePoint = slot6.min_lose_point,
			minUseGold = slot6.min_use_gold,
			minUseSeconds = slot6.min_use_seconds
		}
	end

	slot2 = false

	if slot1.is_reward == 1 then
		slot2 = true
	end

	slot0.chapterData_[slot1.chapter_id].isReward = slot2
	slot3 = false

	if slot1.is_unlock == 1 then
		slot3 = true
	end

	slot0.chapterData_[slot1.chapter_id].isUnlock = slot3

	if slot1.is_being_challenged > 0 then
		slot0:SetCurLevelData(slot1)
	end
end

function slot0.InitCurLevelData(slot0, slot1, slot2)
	slot0.curLevelData_ = {
		curLevelID = slot2
	}
	slot6 = slot1
	slot0.curLevelData_.canUseGold = slot0.activityData_[ActivityTools.GetMainActivityId(slot6)].goldMax
	slot0.curLevelData_.waveDataList = {}

	for slot6, slot7 in pairs(ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID].wave_list) do
		slot8 = {
			waveID = slot7,
			teamID = 0,
			isPass = false
		}
		slot0.curLevelData_.waveDataList[slot8.waveID] = slot8
	end

	slot3 = ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID]
	slot0.curLevelData_.skillData = {}

	for slot7, slot8 in pairs(ActivityReforgeSkillCfg.all) do
		slot0.curLevelData_.skillData[slot8] = 0
	end

	slot0.curLevelData_.teamData = {}

	for slot7, slot8 in pairs(slot3.team_list) do
		slot0.curLevelData_.teamData[slot8] = {
			level = 1,
			teamID = slot8
		}
	end

	slot0.curLevelData_.selectInitiativeSkillList = {
		0,
		0,
		0,
		0
	}
	slot0.curLevelData_.selectPassiveSkillList = {}
end

function slot0.SetCurLevelData(slot0, slot1)
	slot0.curLevelData_ = {
		curLevelID = slot1.save_stage_info.stage_id,
		canUseGold = slot1.save_stage_info.gold,
		waveDataList = {}
	}

	for slot5, slot6 in pairs(ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID].wave_list) do
		slot7 = {
			waveID = slot6,
			teamID = 0,
			isPass = false
		}
		slot0.curLevelData_.waveDataList[slot7.waveID] = slot7
	end

	slot2 = ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID]
	slot0.curLevelData_.skillData = {}

	for slot6, slot7 in pairs(ActivityReforgeSkillCfg.all) do
		slot0.curLevelData_.skillData[slot7] = 0
	end

	slot0.curLevelData_.teamData = {}

	for slot6, slot7 in pairs(slot2.team_list) do
		slot0.curLevelData_.teamData[slot7] = {
			level = 1,
			teamID = slot7
		}
	end

	slot0.curLevelData_.selectInitiativeSkillList = {
		0,
		0,
		0,
		0
	}
	slot0.curLevelData_.selectPassiveSkillList = {}

	for slot6, slot7 in ipairs(slot1.save_stage_info.wave_list) do
		slot8 = {
			waveID = slot7.wave_id,
			teamID = slot7.team,
			isPass = true
		}

		if slot7.is_pass == 1 then
			-- Nothing
		else
			slot8.isPass = false
		end

		if slot8.isPass then
			slot8.losePoint = slot7.wave_battle_end_info.lose_point
			slot8.useSeconds = slot7.wave_battle_end_info.use_seconds
			slot8.useGold = slot7.wave_battle_end_info.use_gold
			slot8.battleParams = slot7.wave_battle_end_info.token
			slot8.heroInfo = {}

			for slot12, slot13 in ipairs(slot7.wave_battle_end_info.battle_hero_list) do
				table.insert(slot8.heroInfo, {
					heroID = slot13.hero_id,
					leftHp = slot13.left_hp,
					maxHp = slot13.max_hp
				})
			end

			slot8.selectInitiativeSkillList = {
				0,
				0,
				0,
				0
			}

			for slot12, slot13 in ipairs(slot7.wave_battle_end_info.select_active_skill_list) do
				slot8.selectInitiativeSkillList[slot13.slot] = slot13.id
			end

			slot8.selectPassiveSkillList = cleanProtoTable(slot7.wave_battle_end_info.select_passive_skill_list)
		else
			slot8.isPass = false
		end

		slot0.curLevelData_.waveDataList[slot8.waveID] = slot8
	end

	for slot6, slot7 in ipairs(slot1.save_stage_info.skill_list) do
		if ActivityReforgeSkillCfg[slot7.skill_id].count == -1 then
			slot0.curLevelData_.skillData[slot7.skill_id] = -1
		else
			slot0.curLevelData_.skillData[slot7.skill_id] = slot8.count - slot7.use_times
		end
	end

	for slot6, slot7 in ipairs(slot1.save_stage_info.team_list) do
		slot0.curLevelData_.teamData[slot7.team_id].level = slot7.level
	end

	for slot6, slot7 in ipairs(slot1.save_stage_info.select_active_skill_list) do
		slot0.curLevelData_.selectInitiativeSkillList[slot7.slot] = slot7.id
	end

	for slot6, slot7 in ipairs(slot1.save_stage_info.select_passive_skill_list) do
		table.insert(slot0.curLevelData_.selectPassiveSkillList, slot7)
	end
end

function slot0.ClearCurLevelData(slot0)
	slot0.curLevelData_ = {}
end

function slot0.GetChapterIsUnlock(slot0, slot1)
	if ActivityData:GetActivityIsOpen(slot1) then
		return slot0.chapterData_[slot1].isUnlock
	else
		return false
	end
end

function slot0.GetCurLevel(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	return slot0.curLevelData_.curLevelID
end

function slot0.GetGoldMaxNum(slot0, slot1)
	if slot0.activityData_[slot1] == nil then
		return 0
	end

	return slot0.activityData_[slot1].goldMax
end

function slot0.SubGoldMaxNum(slot0, slot1, slot2)
	if slot0.activityData_[slot1] == nil then
		return 0
	end

	slot0.activityData_[slot1].goldMax = slot0.activityData_[slot1].goldMax + slot2

	return slot0.activityData_[slot1].goldMax
end

function slot0.GetChapterFinishLevelNum(slot0, slot1)
	if slot0.chapterData_[slot1] == nil then
		return 0
	end

	return #slot0.chapterData_[slot1].finishLevelIDList
end

function slot0.GetLevelIsFinish(slot0, slot1, slot2)
	if slot0.chapterData_[slot1] == nil then
		return false
	end

	return table.indexof(slot0.chapterData_[slot1].finishLevelIDList, slot2)
end

function slot0.FinishLevel(slot0, slot1, slot2, slot3)
	slot0.curLevelData_ = {}

	if slot0:GetLevelIsFinish(slot1, slot2) then
		return
	end

	if slot0.chapterData_[slot1] == nil then
		return
	end

	if slot0.finishLevelData_[slot2] == nil then
		slot0.finishLevelData_[slot2] = {
			times = 1,
			minLosePoint = slot3.minLosePoint,
			minUseGold = slot3.minUseGold,
			minUseSeconds = slot3.minUseSeconds
		}
	end

	table.insert(slot0.chapterData_[slot1].finishLevelIDList, slot2)
	ActivityReforgeData:AddCacheAddGoldNum(ActivityReforgeLevelCfg[slot2].reward_money)

	if #slot0.chapterData_[slot1].finishLevelIDList >= #ActivityReforgeChapterCfg[slot1].level_list and not slot0:GetChapterIsReward(slot1) then
		slot0:FinishChapter(slot1)
	end
end

function slot0.FinishChapter(slot0, slot1)
	slot3 = ActivityReforgeChapterCfg[slot1]

	slot0:AddCacheAddGoldNum(slot3.reward_money)

	for slot7, slot8 in pairs(slot3.get_skill_list) do
		table.insert(slot0.activityData_[ActivityTools.GetMainActivityId(slot1)].unlockSkillList, slot8)
	end

	for slot7, slot8 in pairs(ActivityReforgeChapterCfg.all) do
		if ActivityReforgeChapterCfg[slot8].front_chapter_activity_id == slot1 and slot0.chapterData_[slot8] then
			slot0.chapterData_[slot8].isUnlock = true
		end
	end

	for slot7, slot8 in pairs(slot3.get_skill_list) do
		manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_SKILL .. slot8, 1)
	end

	for slot7, slot8 in pairs(ActivityReforgeChapterCfg.all) do
		if ActivityReforgeChapterCfg[slot8].front_chapter_activity_id == slot1 and ActivityData:GetActivityIsOpen(slot8) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. slot8, 1)
		end
	end
end

function slot0.GetWaveTeamInfo(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return nil
	end

	if slot0.curLevelData_.waveDataList[slot1].teamID == 0 then
		return nil
	end

	return deepClone(slot0.curLevelData_.teamData[slot3])
end

function slot0.GetTeamInfo(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return nil
	end

	slot2 = nil

	return deepClone(slot0.curLevelData_.teamData[slot1])
end

function slot0.CheckLevelCanStart(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return false
	end

	for slot4, slot5 in pairs(slot0.curLevelData_.waveDataList) do
		if slot5.teamID == 0 then
			return false
		end
	end

	return true
end

function slot0.GetTeamCurUsingWaveID(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	for slot5, slot6 in pairs(slot0.curLevelData_.waveDataList) do
		if slot6.teamID == slot1 then
			return slot6.waveID
		end
	end

	return 0
end

function slot0.GetSkillStatus(slot0, slot1, slot2, slot3)
	if table.isEmpty(slot0.curLevelData_) then
		return
	end

	if ActivityReforgeSkillCfg[slot3].is_lock == 1 and table.indexof(slot0.activityData_[slot1].unlockSkillList, slot3) == false then
		return "lock", 0
	else
		if table.indexof(ActivityReforgeLevelCfg[slot2].ban_skill_list, slot3) then
			return "ban", 0
		end

		if table.indexof(slot5.free_skill_list, slot3) then
			if slot4.type == 1 then
				if table.indexof(slot0.curLevelData_.selectInitiativeSkillList, slot3) then
					return "freeUsing", nil
				else
					return "freeNormal", nil
				end
			elseif table.indexof(slot0.curLevelData_.selectPassiveSkillList, slot3) then
				return "freeUsing", nil
			else
				return "freeNormal", nil
			end
		end

		if slot4.count == -1 and slot0.curLevelData_.skillData[slot3] == 0 then
			return "haveNotFree", nil
		elseif slot0.curLevelData_.skillData[slot3] == 0 then
			return "haveNot", 0
		end

		if slot4.type == 1 then
			if table.indexof(slot0.curLevelData_.selectInitiativeSkillList, slot3) then
				if slot0.curLevelData_.skillData[slot3] == -1 then
					return "infiniteUsing", nil
				else
					return "using", slot0.curLevelData_.skillData[slot3]
				end
			elseif slot0.curLevelData_.skillData[slot3] == -1 then
				return "infiniteNormal", nil
			else
				return "normal", slot0.curLevelData_.skillData[slot3]
			end
		elseif table.indexof(slot0.curLevelData_.selectPassiveSkillList, slot3) then
			if slot0.curLevelData_.skillData[slot3] == -1 then
				return "infiniteUsing", nil
			else
				return "using", slot0.curLevelData_.skillData[slot3]
			end
		elseif slot0.curLevelData_.skillData[slot3] == -1 then
			return "infiniteNormal", nil
		else
			return "normal", slot0.curLevelData_.skillData[slot3]
		end
	end
end

function slot0.GetSkillIsLock(slot0, slot1, slot2)
	if table.isEmpty(slot0.activityData_) then
		return
	end

	if ActivityReforgeSkillCfg[slot2].is_lock == 1 and table.indexof(slot0.activityData_[slot1].unlockSkillList, slot2) == false then
		return true
	end

	return false
end

function slot0.GetInitiativeSkillUseNum(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	if slot0.curLevelData_.selectInitiativeSkillList[slot1] ~= 0 then
		return 1
	end

	return 0
end

function slot0.GetPassiveSkillUseNum(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	return #slot0.curLevelData_.selectPassiveSkillList
end

function slot0.GetCurNextWaveID(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	slot1 = ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID].wave_list

	if table.nums(slot0.curLevelData_.waveDataList) > 0 then
		for slot5, slot6 in pairs(slot1) do
			if slot0.curLevelData_.waveDataList[slot6].isPass == false then
				return slot6
			end
		end
	else
		return slot1[1]
	end
end

function slot0.GetCurLevelFinishWave(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	for slot5, slot6 in pairs(slot0.curLevelData_.waveDataList) do
		if slot6.isPass == true then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.GetCurLastWinWaveID(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	slot1 = ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID].wave_list

	if table.nums(slot0.curLevelData_.waveDataList) > 0 then
		slot2 = 0

		for slot6, slot7 in pairs(slot1) do
			if slot0.curLevelData_.waveDataList[slot7].isPass == true then
				slot2 = slot7
			end
		end

		return slot2
	else
		return 0
	end
end

function slot0.GetCurUsingInitiativeSkill(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	return slot0.curLevelData_.selectInitiativeSkillList[slot1]
end

function slot0.GetCurUsingInitiativeSkillList(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	slot1 = {}

	for slot5 = 1, 4 do
		if slot0.curLevelData_.selectInitiativeSkillList[slot5] > 0 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.GetCurUsingPassiveSkillList(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return {}
	end

	return slot0.curLevelData_.selectPassiveSkillList
end

function slot0.GetWaveFinishData(slot0, slot1)
	if slot0.curLevelData_.waveDataList[slot1].isPass then
		-- Nothing
	else
		slot2.useSeconds = 0
		slot2.losePoint = 0
		slot2.useGold = 0
	end

	return {
		isPass = slot0.curLevelData_.waveDataList[slot1].isPass,
		useSeconds = slot0.curLevelData_.waveDataList[slot1].useSeconds,
		losePoint = slot0.curLevelData_.waveDataList[slot1].losePoint,
		useGold = slot0.curLevelData_.waveDataList[slot1].useGold
	}
end

function slot0.GetFinishWaveHeroInfo(slot0, slot1, slot2)
	if table.isEmpty(slot0.curLevelData_) then
		return nil
	end

	for slot7, slot8 in pairs(slot0.curLevelData_.waveDataList[slot1].heroInfo) do
		if slot8.heroID == slot2 then
			return {
				leftHp = slot8.leftHp,
				maxHp = slot8.maxHp
			}
		end
	end
end

function slot0.GetCurUsingSkillList(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return {}
	end

	slot1 = true

	for slot6 = 1, 4 do
		if slot0.curLevelData_.selectInitiativeSkillList[slot6] > 0 then
			slot1 = false

			table.insert({}, slot7)
		else
			table.insert(slot2, 0)
		end
	end

	for slot6, slot7 in pairs(slot0.curLevelData_.selectPassiveSkillList) do
		slot1 = false

		table.insert(slot2, slot7)
	end

	return slot2, slot1
end

function slot0.GetFrontWaveBattleParams(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	slot2 = 0

	for slot7, slot8 in pairs(ActivityReforgeLevelCfg[slot0.curLevelData_.curLevelID].wave_list) do
		if slot8 == slot1 then
			if slot7 == 1 then
				return 0
			else
				slot2 = slot3[slot7 - 1]

				break
			end
		end
	end

	return slot0.curLevelData_.waveDataList[slot2].battleParams
end

function slot0.GetPassWaveUsedSkillList(slot0, slot1)
	if table.isEmpty(slot0.curLevelData_) then
		return {}
	end

	for slot6 = 1, 4 do
		if slot0.curLevelData_.waveDataList[slot1].selectInitiativeSkillList[slot6] > 0 then
			table.insert({}, slot7)
		else
			table.insert(slot2, 0)
		end
	end

	for slot6, slot7 in pairs(slot0.curLevelData_.waveDataList[slot1].selectPassiveSkillList) do
		table.insert(slot2, slot7)
	end

	return slot2
end

function slot0.SetCurFinishLevelServerData(slot0, slot1)
	slot0.curLevelData_.finishLevelData_ = {
		stageID = slot1.stage_id,
		times = slot1.times,
		minLosePoint = slot1.min_lose_point,
		minUseGold = slot1.min_use_gold,
		minUseSeconds = slot1.min_use_seconds
	}
end

function slot0.GetCurFinishLevelServerData(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return nil
	end

	return slot0.curLevelData_.finishLevelData_
end

function slot0.SetLevelAllPlayerServerData(slot0, slot1, slot2, slot3)
	slot0.cacheFinishLevelAllPlayerData_[slot2] = {}
	slot5 = ActivityReforgeGameSettingCfg[ActivityTools.GetMainActivityId(slot1)].bar_num_max

	for slot9, slot10 in ipairs(slot3) do
		if slot10.id == 1 then
			slot0.cacheFinishLevelAllPlayerData_[slot2].minLosePoint = {
				rangeValue = {}
			}

			for slot14 = 1, slot5 do
				slot0.cacheFinishLevelAllPlayerData_[slot2].minLosePoint.rangeValue[slot14] = 0
			end

			slot0.cacheFinishLevelAllPlayerData_[slot2].minLosePoint.rangeLength = slot10.step

			for slot14, slot15 in ipairs(slot10.range_value_list) do
				slot0.cacheFinishLevelAllPlayerData_[slot2].minLosePoint.rangeValue[slot15.index] = slot15.value
			end
		elseif slot10.id == 2 then
			slot0.cacheFinishLevelAllPlayerData_[slot2].minUseGold = {
				rangeValue = {}
			}

			for slot14 = 1, slot5 do
				slot0.cacheFinishLevelAllPlayerData_[slot2].minUseGold.rangeValue[slot14] = 0
			end

			slot0.cacheFinishLevelAllPlayerData_[slot2].minUseGold.rangeLength = slot10.step

			for slot14, slot15 in ipairs(slot10.range_value_list) do
				slot0.cacheFinishLevelAllPlayerData_[slot2].minUseGold.rangeValue[slot15.index] = slot15.value
			end
		elseif slot10.id == 3 then
			slot0.cacheFinishLevelAllPlayerData_[slot2].minUseSeconds = {
				rangeValue = {}
			}

			for slot14 = 1, slot5 do
				slot0.cacheFinishLevelAllPlayerData_[slot2].minUseSeconds.rangeValue[slot14] = 0
			end

			slot0.cacheFinishLevelAllPlayerData_[slot2].minUseSeconds.rangeLength = slot10.step

			for slot14, slot15 in ipairs(slot10.range_value_list) do
				slot0.cacheFinishLevelAllPlayerData_[slot2].minUseSeconds.rangeValue[slot15.index] = slot15.value
			end
		end
	end
end

function slot0.GetLevelAllPlayerServerData(slot0, slot1)
	if table.isEmpty(slot0.cacheFinishLevelAllPlayerData_) or table.isEmpty(slot0.cacheFinishLevelAllPlayerData_[slot1]) then
		return nil
	end

	return slot0.cacheFinishLevelAllPlayerData_[slot1]
end

function slot0.GetBestFinishLevelServerData(slot0, slot1)
	if slot0.finishLevelData_[slot1] then
		return slot0.finishLevelData_[slot1]
	end

	return nil
end

function slot0.SetCachePopBattleInfoView(slot0, slot1)
	slot0.cachePopBattleInfoView_ = slot1
end

function slot0.GetCachePopBattleInfoView(slot0)
	return slot0.cachePopBattleInfoView_
end

function slot0.GetCurCanUseGold(slot0)
	if table.isEmpty(slot0.curLevelData_) then
		return 0
	end

	return slot0.curLevelData_.canUseGold
end

function slot0.AddCacheAddGoldNum(slot0, slot1)
	slot0.cacheAddGoldNum_ = slot0.cacheAddGoldNum_ + slot1
end

function slot0.GetCacheAddGoldNum(slot0)
	return slot0.cacheAddGoldNum_
end

function slot0.ClearCacheAddGoldNum(slot0)
	slot0.cacheAddGoldNum_ = 0
end

function slot0.GetChapterIsReward(slot0, slot1)
	return slot0.chapterData_[slot1].isReward
end

return slot0
