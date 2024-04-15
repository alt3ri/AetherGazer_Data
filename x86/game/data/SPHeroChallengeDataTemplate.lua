SPHeroChallengeActivityTemplate = class("SPHeroChallengeActivityTemplate")

function SPHeroChallengeActivityTemplate.Ctor(slot0, slot1)
	slot0.activityID = slot1.activity_id
	slot0.entrustTime = slot1.entrust_refresh_times or 0
	slot0.entrustFreeTime = math.min(slot0.entrustTime, SPHeroChallengeData.activityCfg[slot0.activityID].freeRefreshEntrustTime)
	slot0.getAwardFlag = slot1.is_got_schedule_reward or false

	slot0:InitCurScheduleList(slot1.save_schedule_list, true)
	slot0:InitCurEntrustList(slot1.begin_entrust_list)
	slot0:InitWaiteEntrustList(slot1.entrust_id_list)
	slot0:InitFinStoryList(slot1.passed_chapter_level_list)
	slot0:InitTrainInfo(slot1.train_list)
end

function SPHeroChallengeActivityTemplate.InitTrainInfo(slot0, slot1)
	slot0.trainInfo = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = SPHeroChallengeAction:ParseTrainInfo(slot6)
			slot0.trainInfo[slot7.type] = slot7
		end
	end

	for slot5 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		if not slot0.trainInfo[slot5] then
			slot0.trainInfo[slot5] = SPHeroChallengeAction:ParseTrainInfo(nil, slot5)
		end
	end
end

function SPHeroChallengeActivityTemplate.InitCurScheduleList(slot0, slot1, slot2)
	slot0.curScheduleList = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if SPHeroChallengeAction:ParseScheduleInfo(slot7) then
				slot0.curScheduleList[slot8.index] = slot8
			end
		end
	end

	if not slot2 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM)
	end
end

function SPHeroChallengeActivityTemplate.InitCurEntrustList(slot0, slot1)
	slot0.beganEntrustList = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if SPHeroChallengeAction:ParseEntrustInfo(slot6) then
				slot0.beganEntrustList[slot7.index] = slot7
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.InitWaiteEntrustList(slot0, slot1)
	slot0.waitEntrustList = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.waitEntrustList, slot6)
		end
	end
end

function SPHeroChallengeActivityTemplate.InitFinStoryList(slot0, slot1)
	slot0.storyFinStageList = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.storyFinStageList, slot6)
		end
	end
end

function SPHeroChallengeActivityTemplate.Dispose(slot0)
	slot0.activityID = nil
	slot0.entrustFreeTime = nil
	slot0.getAwardFlag = nil
	slot0.storyFinStageList = nil
	slot0.waitEntrustList = nil
	slot0.beganEntrustList = nil
	slot0.curScheduleList = nil
	slot0.trainInfo = nil
end

function SPHeroChallengeActivityTemplate.RefreshDormDailyZero(slot0)
	slot0.entrustFreeTime = 0
	slot0.entrustTime = 0
end

function SPHeroChallengeActivityTemplate.GetRefreshFreeEntrustTime(slot0)
	return GameSetting.activity_hero_challenge_task_free_refresh_num.value[1] - slot0.entrustFreeTime
end

function SPHeroChallengeActivityTemplate.GetRefreshTotalEntrustTime(slot0)
	return GameSetting.activity_hero_challenge_task_refresh_num.value[1] - slot0.entrustTime
end

function SPHeroChallengeActivityTemplate.GetNextStoryStageIDList(slot0)
	slot3 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.ScheduleSubType.story][1]

	if slot0.storyFinStageList and #slot0.storyFinStageList > 0 and (not BattleVerthandiExclusiveCfg[slot0.storyFinStageList[#slot0.storyFinStageList]].next_unlock_id_list[1] or slot3 == "") then
		slot3 = slot4
	end

	return slot3
end

function SPHeroChallengeActivityTemplate.GetBossErosiveness(slot0)
	slot1 = 0

	if slot0.trainInfo then
		for slot5, slot6 in pairs(slot0.trainInfo) do
			slot1 = slot1 + slot6.value
		end
	end

	return math.ceil(slot1 / (3 * GameSetting.activity_hero_challenge_erosion_num.value[1]))
end

function SPHeroChallengeActivityTemplate.GetTrainNumBySchedule(slot0, slot1)
	return slot0:GetTrainNumByType(ActivityHeroChallengeScheduleCfg[slot1].server_type)
end

function SPHeroChallengeActivityTemplate.GetTrainNumByType(slot0, slot1)
	slot3 = ActivityHeroChallengeCfg[slot0.activityID]["affix_group_" .. tostring(slot1 - 1)][3][1]
	slot4 = 0

	if slot0.trainInfo[slot1] then
		slot4 = slot0.trainInfo[slot1].value
	end

	return slot4 or 0, slot3
end

function SPHeroChallengeActivityTemplate.FinishTrainStage(slot0, slot1)
	if BattleVerthandiExclusiveCfg[slot1] and not table.indexof(slot0.trainInfo[slot2.sub_type].passStageList, slot1) then
		table.insert(slot0.trainInfo[slot3].passStageList, slot1)
	end
end

function SPHeroChallengeActivityTemplate.GetEntrustEndTime(slot0, slot1)
	if slot0.beganEntrustList and slot0.beganEntrustList[slot1] then
		if slot0.beganEntrustList[slot1].startTime > 0 then
			if manager.time:GetServerTime() - slot2.startTime >= ActivityHeroChallengeTaskCfg[slot2.entrustID].time * 60 then
				return true, 0
			else
				return false, slot3.time * 60 - (slot4 - slot2.startTime)
			end
		end
	else
		Debug.LogError("未获取到已开始委托数据" .. slot1)
	end
end

function SPHeroChallengeActivityTemplate.ModefyEntrustStartTime(slot0, slot1)
	if slot0.beganEntrustList[slot1.index] then
		slot4.startTime = slot4.startTime - slot1.use_cnt * SPHeroChallengeData.activityCfg[slot0.activityID].acceleratorTime * 60
	end

	manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
end

function SPHeroChallengeActivityTemplate.GetCanGetRewardEntrustIndexList(slot0)
	slot1 = {}

	if slot0.beganEntrustList then
		for slot5, slot6 in pairs(slot0.beganEntrustList) do
			if slot0:GetEntrustEndTime(slot5) then
				table.insert(slot1, slot5)
			end
		end
	end

	return slot1
end

function SPHeroChallengeActivityTemplate.GetCurRunEntrustInfo(slot0)
	slot1 = {}

	if slot0.beganEntrustList then
		for slot5, slot6 in pairs(slot0.beganEntrustList) do
			if slot6.start > 0 then
				slot1[slot5] = slot6
			end
		end
	end

	return slot1
end

function SPHeroChallengeActivityTemplate.StartEntrust(slot0, slot1, slot2)
	if not slot0.beganEntrustList then
		slot0.beganEntrustList = {}
	end

	if slot0.waitEntrustList then
		for slot6, slot7 in ipairs(slot0.waitEntrustList) do
			if slot7 == slot2 then
				table.remove(slot0.waitEntrustList, slot6)

				break
			end
		end

		slot3 = 0

		if slot1 <= (SPHeroChallengeTools:GetCanOperationEntrustNum(slot0.activityID) or 0) then
			slot3 = manager.time:GetServerTime()
		end

		slot0.beganEntrustList[slot1] = {
			entrustID = slot2,
			startTime = slot3,
			index = slot1,
			showIndex = slot1
		}
	end
end

function SPHeroChallengeActivityTemplate.CancelEntrust(slot0, slot1)
	slot0.beganEntrustList[slot1] = nil
end

function SPHeroChallengeActivityTemplate.GetReceiveEntrustNum(slot0)
	slot1 = 0

	if slot0.beganEntrustList then
		for slot5, slot6 in pairs(slot0.beganEntrustList) do
			slot1 = slot1 + 1
		end
	end

	return slot1
end

function SPHeroChallengeActivityTemplate.GetEntrustInfoByIndex(slot0, slot1)
	if slot0.beganEntrustList then
		return slot0.beganEntrustList[slot1]
	end
end

function SPHeroChallengeActivityTemplate.GetNextExtrustIndex(slot0)
	if slot0.beganEntrustList then
		for slot5 = 1, SPHeroChallengeTools:GetMaxTotleEntrustPosNum(slot0.activityID) do
			if SPHeroChallengeTools:GetEntrustPosState(slot0.activityID, slot5) == SpHeroChallengeConst.EntrustPosState.empty then
				return slot5
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.GetPrepareEntrustList(slot0)
	slot1 = {}

	if slot0.beganEntrustList then
		for slot6, slot7 in ipairs(slot0.beganEntrustList) do
			if slot7.start == 0 or slot0:GetEntrustEndTime(slot7.index) then
				talbe.insert({}, slot7.showIndex)
			end
		end
	end

	return slot1
end

function SPHeroChallengeActivityTemplate.GetShowIndexEntrustInfo(slot0, slot1)
	if slot0.beganEntrustList then
		for slot5, slot6 in pairs(slot0.beganEntrustList) do
			if slot6.showIndex == slot1 then
				return slot6
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.EntrustFinish(slot0, slot1)
	if slot0.beganEntrustList then
		for slot5, slot6 in pairs(slot0.beganEntrustList) do
			if slot6.showIndex == slot1 then
				if slot0:GetShowIndexEntrustInfo(SPHeroChallengeTools:GetMaxStartEntrustPosNum(slot0.activityID) + 1) and slot8.startTime == 0 then
					slot9 = slot8.showIndex
					slot8.showIndex = slot1
					slot8.startTime = manager.time:GetServerTime()

					for slot14, slot15 in pairs(slot0.beganEntrustList) do
						if slot15.startTime == 0 then
							slot10 = math.max(slot8.showIndex, slot15.showIndex)
							slot15.showIndex = slot15.showIndex - 1
						end
					end

					slot6.showIndex = slot10
				end

				break
			end
		end

		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(SPHeroChallengeData:GetActivityID())
		manager.notify:Invoke(SP_HERO_CHALLENGE_FIN_ENTRUST)
	end
end

function SPHeroChallengeActivityTemplate.FinishSchedule(slot0, slot1)
	if slot0.curScheduleList and slot0.curScheduleList[slot1] then
		slot0.curScheduleList[slot1].isFinish = true
	end
end

function SPHeroChallengeActivityTemplate.GetStartListScheduleInfoByList(slot0, slot1)
	if slot0.curScheduleList then
		return slot0.curScheduleList[slot1]
	end
end

function SPHeroChallengeActivityTemplate.GetFinScheduleScore(slot0)
	slot1 = 0

	if slot0.curScheduleList then
		for slot5, slot6 in pairs(slot0.curScheduleList) do
			if slot6.isFinish then
				if ActivityHeroChallengeScheduleCfg[slot6.scheduleID] then
					slot1 = slot1 + slot7.score
				else
					Debug.LogError("未获取日程任务配置" .. slot6.scheduleID)
				end
			end
		end
	end

	return slot1
end

function SPHeroChallengeActivityTemplate.CheckCurScheduleFinish(slot0)
	slot1 = true

	if slot0.curScheduleList and next(slot0.curScheduleList) ~= nil then
		for slot5, slot6 in pairs(slot0.curScheduleList) do
			if not slot6.isFinish then
				slot1 = false

				break
			end
		end
	else
		slot1 = false
	end

	return slot1
end

function SPHeroChallengeActivityTemplate.CheckDailyScheduleAwardReceived(slot0)
	return slot0.getAwardFlag
end

function SPHeroChallengeActivityTemplate.CheckCurScheduleStart(slot0)
	if slot0.curScheduleList and next(slot0.curScheduleList) then
		return true
	else
		return false
	end
end

function SPHeroChallengeActivityTemplate.GetStartBattelScheduleByType(slot0, slot1)
	slot2 = 0
	slot3 = 0

	if slot0.curScheduleList then
		for slot7, slot8 in pairs(slot0.curScheduleList) do
			if ActivityHeroChallengeScheduleCfg[slot8.scheduleID].server_type == slot1 then
				slot2 = slot2 + 1

				if slot8.isFinish then
					slot3 = slot3 + 1
				end
			end
		end
	end

	return slot2, slot3
end

function SPHeroChallengeActivityTemplate.GetSaveScheudlList(slot0)
	if slot0.localSaveSchedule then
		slot0.localSaveSchedule = getData("SPHeroChallenge" .. slot0.activityID, "localSchedule") or {}
	end

	return slot0.localSaveSchedule
end

function SPHeroChallengeActivityTemplate.SetSaveScheudlList(slot0)
	if slot0.localSaveSchedule then
		saveData("SPHeroChallenge" .. slot0.activityID, "localSchedule", slot0.localSaveSchedule)
	end

	slot0.localSaveSchedule = nil
end

function SPHeroChallengeActivityTemplate.AddScheduleInDailyList(slot0, slot1)
	if not slot0.dailyList then
		slot0.dailyList = {}
	end

	slot2 = nil

	for slot6 = 1, SpHeroChallengeConst.scheduleNum do
		if not slot0.dailyList[slot6] or slot0.dailyList[slot6] == 0 then
			slot0.dailyList[slot6] = slot1
			slot2 = slot6

			break
		end
	end

	if slot2 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, slot2)
	end
end

function SPHeroChallengeActivityTemplate.RemoveScheduleInDailyList(slot0, slot1, slot2)
	if not slot0.dailyList then
		return
	end

	slot0.dailyList[slot2] = 0

	manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, slot2)
end

function SPHeroChallengeActivityTemplate.GetScheduleDailyList(slot0)
	return slot0.dailyList or {}
end

function SPHeroChallengeActivityTemplate.ClearScheduleDailyList(slot0)
	slot0.dailyList = {}
end

function SPHeroChallengeActivityTemplate.InitBossInfo(slot0, slot1)
	if slot1 then
		slot0.bossHadFightDailyList = {}
		slot2 = {}

		for slot6, slot7 in ipairs(slot1.stage_id_list) do
			table.insert(slot2, slot7)
		end

		slot0.bossHadFightDailyList.dailyChallenge = slot2
		slot0.bossHadFightDailyList.time = slot1.fight_cnt
		slot0.bossStageScore = {}

		for slot6, slot7 in ipairs(slot1.score_info_list) do
			slot8 = SPHeroChallengeAction:ParseScoreInfo(slot7)
			slot0.bossStageScore[slot8.stageID] = slot8.score
		end

		slot0.bossStart = slot1.is_start

		manager.notify:Invoke(SP_HERO_CHALLENGE_UPDATE_BOSS)
	end
end

function SPHeroChallengeActivityTemplate.GetBossScoreInfo(slot0, slot1)
	if slot0.bossStageScore then
		return slot0.bossStageScore[slot1] or 0
	end

	return 0
end

function SPHeroChallengeActivityTemplate.FinishStoryStage(slot0, slot1)
	if not slot0.storyFinStageList then
		slot0.storyFinStageList = {}
	end

	if not table.indexof(slot0.storyFinStageList, slot1) then
		table.insert(slot0.storyFinStageList, slot1)
	end
end

function SPHeroChallengeActivityTemplate.CheckStoryFinState(slot0, slot1)
	if not slot0.storyFinStageList then
		slot0.storyFinStageList = {}
	end

	if not table.indexof(slot0.storyFinStageList, slot1) then
		return false
	else
		return true
	end
end

function SPHeroChallengeActivityTemplate.GetNextStageName(slot0)
	if slot0.storyFinStageList and BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][1 + #slot0.storyFinStageList] then
		return BattleVerthandiExclusiveCfg[slot2].name
	end
end

function SPHeroChallengeActivityTemplate.CheckCanGetHeroChipTaskAward(slot0)
	if SPHeroChallengeData.activityCfg[slot0.activityID].HeroChipTask then
		slot3 = TaskData2:GetTaskProgress(slot1)
		slot4 = AssignmentCfg[slot1].need

		if TaskData2:GetTaskComplete(slot1) or slot3 < slot4 then
			return false, slot2, slot4, slot3
		else
			return true, nil, slot4, slot3
		end
	end
end
