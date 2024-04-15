SPHeroChallengeActivityTemplate = class("SPHeroChallengeActivityTemplate")

function SPHeroChallengeActivityTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityID = arg_1_1.activity_id
	arg_1_0.entrustTime = arg_1_1.entrust_refresh_times or 0
	arg_1_0.entrustFreeTime = math.min(arg_1_0.entrustTime, SPHeroChallengeData.activityCfg[arg_1_0.activityID].freeRefreshEntrustTime)
	arg_1_0.getAwardFlag = arg_1_1.is_got_schedule_reward or false

	arg_1_0:InitCurScheduleList(arg_1_1.save_schedule_list, true)
	arg_1_0:InitCurEntrustList(arg_1_1.begin_entrust_list)
	arg_1_0:InitWaiteEntrustList(arg_1_1.entrust_id_list)
	arg_1_0:InitFinStoryList(arg_1_1.passed_chapter_level_list)
	arg_1_0:InitTrainInfo(arg_1_1.train_list)
end

function SPHeroChallengeActivityTemplate.InitTrainInfo(arg_2_0, arg_2_1)
	arg_2_0.trainInfo = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_0 = SPHeroChallengeAction:ParseTrainInfo(iter_2_1)

			arg_2_0.trainInfo[var_2_0.type] = var_2_0
		end
	end

	for iter_2_2 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		if not arg_2_0.trainInfo[iter_2_2] then
			arg_2_0.trainInfo[iter_2_2] = SPHeroChallengeAction:ParseTrainInfo(nil, iter_2_2)
		end
	end
end

function SPHeroChallengeActivityTemplate.InitCurScheduleList(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.curScheduleList = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_0 = SPHeroChallengeAction:ParseScheduleInfo(iter_3_1)

			if var_3_0 then
				arg_3_0.curScheduleList[var_3_0.index] = var_3_0
			end
		end
	end

	if not arg_3_2 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM)
	end
end

function SPHeroChallengeActivityTemplate.InitCurEntrustList(arg_4_0, arg_4_1)
	arg_4_0.beganEntrustList = {}

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			local var_4_0 = SPHeroChallengeAction:ParseEntrustInfo(iter_4_1)

			if var_4_0 then
				arg_4_0.beganEntrustList[var_4_0.index] = var_4_0
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.InitWaiteEntrustList(arg_5_0, arg_5_1)
	arg_5_0.waitEntrustList = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			table.insert(arg_5_0.waitEntrustList, iter_5_1)
		end
	end
end

function SPHeroChallengeActivityTemplate.InitFinStoryList(arg_6_0, arg_6_1)
	arg_6_0.storyFinStageList = {}

	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			table.insert(arg_6_0.storyFinStageList, iter_6_1)
		end
	end
end

function SPHeroChallengeActivityTemplate.Dispose(arg_7_0)
	arg_7_0.activityID = nil
	arg_7_0.entrustFreeTime = nil
	arg_7_0.getAwardFlag = nil
	arg_7_0.storyFinStageList = nil
	arg_7_0.waitEntrustList = nil
	arg_7_0.beganEntrustList = nil
	arg_7_0.curScheduleList = nil
	arg_7_0.trainInfo = nil
end

function SPHeroChallengeActivityTemplate.RefreshDormDailyZero(arg_8_0)
	arg_8_0.entrustFreeTime = 0
	arg_8_0.entrustTime = 0
end

function SPHeroChallengeActivityTemplate.GetRefreshFreeEntrustTime(arg_9_0)
	return GameSetting.activity_hero_challenge_task_free_refresh_num.value[1] - arg_9_0.entrustFreeTime
end

function SPHeroChallengeActivityTemplate.GetRefreshTotalEntrustTime(arg_10_0)
	return GameSetting.activity_hero_challenge_task_refresh_num.value[1] - arg_10_0.entrustTime
end

function SPHeroChallengeActivityTemplate.GetNextStoryStageIDList(arg_11_0)
	local var_11_0 = SpHeroChallengeConst.ScheduleSubType.story
	local var_11_1 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[var_11_0][1]

	if arg_11_0.storyFinStageList and #arg_11_0.storyFinStageList > 0 then
		local var_11_2 = arg_11_0.storyFinStageList[#arg_11_0.storyFinStageList]

		var_11_1 = BattleVerthandiExclusiveCfg[var_11_2].next_unlock_id_list[1]

		if not var_11_1 or var_11_1 == "" then
			var_11_1 = var_11_2
		end
	end

	return var_11_1
end

function SPHeroChallengeActivityTemplate.GetBossErosiveness(arg_12_0)
	local var_12_0 = 0

	if arg_12_0.trainInfo then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.trainInfo) do
			var_12_0 = var_12_0 + iter_12_1.value
		end
	end

	return math.ceil(var_12_0 / (3 * GameSetting.activity_hero_challenge_erosion_num.value[1]))
end

function SPHeroChallengeActivityTemplate.GetTrainNumBySchedule(arg_13_0, arg_13_1)
	local var_13_0 = ActivityHeroChallengeScheduleCfg[arg_13_1].server_type

	return arg_13_0:GetTrainNumByType(var_13_0)
end

function SPHeroChallengeActivityTemplate.GetTrainNumByType(arg_14_0, arg_14_1)
	local var_14_0 = ActivityHeroChallengeCfg[arg_14_0.activityID]["affix_group_" .. tostring(arg_14_1 - 1)][3][1]
	local var_14_1 = 0

	if arg_14_0.trainInfo[arg_14_1] then
		var_14_1 = arg_14_0.trainInfo[arg_14_1].value
	end

	return var_14_1 or 0, var_14_0
end

function SPHeroChallengeActivityTemplate.FinishTrainStage(arg_15_0, arg_15_1)
	local var_15_0 = BattleVerthandiExclusiveCfg[arg_15_1]

	if var_15_0 then
		local var_15_1 = var_15_0.sub_type

		if not table.indexof(arg_15_0.trainInfo[var_15_1].passStageList, arg_15_1) then
			table.insert(arg_15_0.trainInfo[var_15_1].passStageList, arg_15_1)
		end
	end
end

function SPHeroChallengeActivityTemplate.GetEntrustEndTime(arg_16_0, arg_16_1)
	if arg_16_0.beganEntrustList and arg_16_0.beganEntrustList[arg_16_1] then
		local var_16_0 = arg_16_0.beganEntrustList[arg_16_1]

		if var_16_0.startTime > 0 then
			local var_16_1 = ActivityHeroChallengeTaskCfg[var_16_0.entrustID]
			local var_16_2 = manager.time:GetServerTime()

			if var_16_2 - var_16_0.startTime >= var_16_1.time * 60 then
				return true, 0
			else
				return false, var_16_1.time * 60 - (var_16_2 - var_16_0.startTime)
			end
		end
	else
		Debug.LogError("未获取到已开始委托数据" .. arg_16_1)
	end
end

function SPHeroChallengeActivityTemplate.ModefyEntrustStartTime(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.index
	local var_17_1 = SPHeroChallengeData.activityCfg[arg_17_0.activityID].acceleratorTime
	local var_17_2 = arg_17_0.beganEntrustList[var_17_0]

	if var_17_2 then
		var_17_2.startTime = var_17_2.startTime - arg_17_1.use_cnt * var_17_1 * 60
	end

	manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
end

function SPHeroChallengeActivityTemplate.GetCanGetRewardEntrustIndexList(arg_18_0)
	local var_18_0 = {}

	if arg_18_0.beganEntrustList then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.beganEntrustList) do
			if arg_18_0:GetEntrustEndTime(iter_18_0) then
				table.insert(var_18_0, iter_18_0)
			end
		end
	end

	return var_18_0
end

function SPHeroChallengeActivityTemplate.GetCurRunEntrustInfo(arg_19_0)
	local var_19_0 = {}

	if arg_19_0.beganEntrustList then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.beganEntrustList) do
			if iter_19_1.start > 0 then
				var_19_0[iter_19_0] = iter_19_1
			end
		end
	end

	return var_19_0
end

function SPHeroChallengeActivityTemplate.StartEntrust(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.beganEntrustList then
		arg_20_0.beganEntrustList = {}
	end

	if arg_20_0.waitEntrustList then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0.waitEntrustList) do
			if iter_20_1 == arg_20_2 then
				table.remove(arg_20_0.waitEntrustList, iter_20_0)

				break
			end
		end

		local var_20_0 = 0

		if arg_20_1 <= (SPHeroChallengeTools:GetCanOperationEntrustNum(arg_20_0.activityID) or 0) then
			var_20_0 = manager.time:GetServerTime()
		end

		arg_20_0.beganEntrustList[arg_20_1] = {
			entrustID = arg_20_2,
			startTime = var_20_0,
			index = arg_20_1,
			showIndex = arg_20_1
		}
	end
end

function SPHeroChallengeActivityTemplate.CancelEntrust(arg_21_0, arg_21_1)
	arg_21_0.beganEntrustList[arg_21_1] = nil
end

function SPHeroChallengeActivityTemplate.GetReceiveEntrustNum(arg_22_0)
	local var_22_0 = 0

	if arg_22_0.beganEntrustList then
		for iter_22_0, iter_22_1 in pairs(arg_22_0.beganEntrustList) do
			var_22_0 = var_22_0 + 1
		end
	end

	return var_22_0
end

function SPHeroChallengeActivityTemplate.GetEntrustInfoByIndex(arg_23_0, arg_23_1)
	if arg_23_0.beganEntrustList then
		return arg_23_0.beganEntrustList[arg_23_1]
	end
end

function SPHeroChallengeActivityTemplate.GetNextExtrustIndex(arg_24_0)
	if arg_24_0.beganEntrustList then
		local var_24_0 = SPHeroChallengeTools:GetMaxTotleEntrustPosNum(arg_24_0.activityID)

		for iter_24_0 = 1, var_24_0 do
			if SPHeroChallengeTools:GetEntrustPosState(arg_24_0.activityID, iter_24_0) == SpHeroChallengeConst.EntrustPosState.empty then
				return iter_24_0
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.GetPrepareEntrustList(arg_25_0)
	local var_25_0 = {}

	if arg_25_0.beganEntrustList then
		local var_25_1 = {}

		for iter_25_0, iter_25_1 in ipairs(arg_25_0.beganEntrustList) do
			if iter_25_1.start == 0 or arg_25_0:GetEntrustEndTime(iter_25_1.index) then
				talbe.insert(var_25_1, iter_25_1.showIndex)
			end
		end
	end

	return var_25_0
end

function SPHeroChallengeActivityTemplate.GetShowIndexEntrustInfo(arg_26_0, arg_26_1)
	if arg_26_0.beganEntrustList then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.beganEntrustList) do
			if iter_26_1.showIndex == arg_26_1 then
				return iter_26_1
			end
		end
	end
end

function SPHeroChallengeActivityTemplate.EntrustFinish(arg_27_0, arg_27_1)
	if arg_27_0.beganEntrustList then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.beganEntrustList) do
			if iter_27_1.showIndex == arg_27_1 then
				local var_27_0 = SPHeroChallengeTools:GetMaxStartEntrustPosNum(arg_27_0.activityID)
				local var_27_1 = arg_27_0:GetShowIndexEntrustInfo(var_27_0 + 1)

				if var_27_1 and var_27_1.startTime == 0 then
					local var_27_2 = var_27_1.showIndex
					local var_27_3 = var_27_1.showIndex

					var_27_1.showIndex = arg_27_1
					var_27_1.startTime = manager.time:GetServerTime()

					for iter_27_2, iter_27_3 in pairs(arg_27_0.beganEntrustList) do
						if iter_27_3.startTime == 0 then
							var_27_3 = math.max(var_27_3, iter_27_3.showIndex)
							iter_27_3.showIndex = iter_27_3.showIndex - 1
						end
					end

					iter_27_1.showIndex = var_27_3
				end

				break
			end
		end

		local var_27_4 = SPHeroChallengeData:GetActivityID()

		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(var_27_4)
		manager.notify:Invoke(SP_HERO_CHALLENGE_FIN_ENTRUST)
	end
end

function SPHeroChallengeActivityTemplate.FinishSchedule(arg_28_0, arg_28_1)
	if arg_28_0.curScheduleList and arg_28_0.curScheduleList[arg_28_1] then
		arg_28_0.curScheduleList[arg_28_1].isFinish = true
	end
end

function SPHeroChallengeActivityTemplate.GetStartListScheduleInfoByList(arg_29_0, arg_29_1)
	if arg_29_0.curScheduleList then
		return arg_29_0.curScheduleList[arg_29_1]
	end
end

function SPHeroChallengeActivityTemplate.GetFinScheduleScore(arg_30_0)
	local var_30_0 = 0

	if arg_30_0.curScheduleList then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.curScheduleList) do
			if iter_30_1.isFinish then
				local var_30_1 = ActivityHeroChallengeScheduleCfg[iter_30_1.scheduleID]

				if var_30_1 then
					var_30_0 = var_30_0 + var_30_1.score
				else
					Debug.LogError("未获取日程任务配置" .. iter_30_1.scheduleID)
				end
			end
		end
	end

	return var_30_0
end

function SPHeroChallengeActivityTemplate.CheckCurScheduleFinish(arg_31_0)
	local var_31_0 = true

	if arg_31_0.curScheduleList and next(arg_31_0.curScheduleList) ~= nil then
		for iter_31_0, iter_31_1 in pairs(arg_31_0.curScheduleList) do
			if not iter_31_1.isFinish then
				var_31_0 = false

				break
			end
		end
	else
		var_31_0 = false
	end

	return var_31_0
end

function SPHeroChallengeActivityTemplate.CheckDailyScheduleAwardReceived(arg_32_0)
	return arg_32_0.getAwardFlag
end

function SPHeroChallengeActivityTemplate.CheckCurScheduleStart(arg_33_0)
	if arg_33_0.curScheduleList and next(arg_33_0.curScheduleList) then
		return true
	else
		return false
	end
end

function SPHeroChallengeActivityTemplate.GetStartBattelScheduleByType(arg_34_0, arg_34_1)
	local var_34_0 = 0
	local var_34_1 = 0

	if arg_34_0.curScheduleList then
		for iter_34_0, iter_34_1 in pairs(arg_34_0.curScheduleList) do
			local var_34_2 = iter_34_1.scheduleID

			if ActivityHeroChallengeScheduleCfg[var_34_2].server_type == arg_34_1 then
				var_34_0 = var_34_0 + 1

				if iter_34_1.isFinish then
					var_34_1 = var_34_1 + 1
				end
			end
		end
	end

	return var_34_0, var_34_1
end

function SPHeroChallengeActivityTemplate.GetSaveScheudlList(arg_35_0)
	if arg_35_0.localSaveSchedule then
		arg_35_0.localSaveSchedule = getData("SPHeroChallenge" .. arg_35_0.activityID, "localSchedule") or {}
	end

	return arg_35_0.localSaveSchedule
end

function SPHeroChallengeActivityTemplate.SetSaveScheudlList(arg_36_0)
	if arg_36_0.localSaveSchedule then
		saveData("SPHeroChallenge" .. arg_36_0.activityID, "localSchedule", arg_36_0.localSaveSchedule)
	end

	arg_36_0.localSaveSchedule = nil
end

function SPHeroChallengeActivityTemplate.AddScheduleInDailyList(arg_37_0, arg_37_1)
	if not arg_37_0.dailyList then
		arg_37_0.dailyList = {}
	end

	local var_37_0

	for iter_37_0 = 1, SpHeroChallengeConst.scheduleNum do
		if not arg_37_0.dailyList[iter_37_0] or arg_37_0.dailyList[iter_37_0] == 0 then
			arg_37_0.dailyList[iter_37_0] = arg_37_1
			var_37_0 = iter_37_0

			break
		end
	end

	if var_37_0 then
		manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, var_37_0)
	end
end

function SPHeroChallengeActivityTemplate.RemoveScheduleInDailyList(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0.dailyList then
		return
	end

	arg_38_0.dailyList[arg_38_2] = 0

	manager.notify:Invoke(SP_HERO_CHALLENGE_SCHEDULE_CHANGE, arg_38_2)
end

function SPHeroChallengeActivityTemplate.GetScheduleDailyList(arg_39_0)
	return arg_39_0.dailyList or {}
end

function SPHeroChallengeActivityTemplate.ClearScheduleDailyList(arg_40_0)
	arg_40_0.dailyList = {}
end

function SPHeroChallengeActivityTemplate.InitBossInfo(arg_41_0, arg_41_1)
	if arg_41_1 then
		arg_41_0.bossHadFightDailyList = {}

		local var_41_0 = {}

		for iter_41_0, iter_41_1 in ipairs(arg_41_1.stage_id_list) do
			table.insert(var_41_0, iter_41_1)
		end

		arg_41_0.bossHadFightDailyList.dailyChallenge = var_41_0
		arg_41_0.bossHadFightDailyList.time = arg_41_1.fight_cnt
		arg_41_0.bossStageScore = {}

		for iter_41_2, iter_41_3 in ipairs(arg_41_1.score_info_list) do
			local var_41_1 = SPHeroChallengeAction:ParseScoreInfo(iter_41_3)

			arg_41_0.bossStageScore[var_41_1.stageID] = var_41_1.score
		end

		arg_41_0.bossStart = arg_41_1.is_start

		manager.notify:Invoke(SP_HERO_CHALLENGE_UPDATE_BOSS)
	end
end

function SPHeroChallengeActivityTemplate.GetBossScoreInfo(arg_42_0, arg_42_1)
	if arg_42_0.bossStageScore then
		return arg_42_0.bossStageScore[arg_42_1] or 0
	end

	return 0
end

function SPHeroChallengeActivityTemplate.FinishStoryStage(arg_43_0, arg_43_1)
	if not arg_43_0.storyFinStageList then
		arg_43_0.storyFinStageList = {}
	end

	if not table.indexof(arg_43_0.storyFinStageList, arg_43_1) then
		table.insert(arg_43_0.storyFinStageList, arg_43_1)
	end
end

function SPHeroChallengeActivityTemplate.CheckStoryFinState(arg_44_0, arg_44_1)
	if not arg_44_0.storyFinStageList then
		arg_44_0.storyFinStageList = {}
	end

	if not table.indexof(arg_44_0.storyFinStageList, arg_44_1) then
		return false
	else
		return true
	end
end

function SPHeroChallengeActivityTemplate.GetNextStageName(arg_45_0)
	if arg_45_0.storyFinStageList then
		local var_45_0 = #arg_45_0.storyFinStageList
		local var_45_1 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.story][1 + var_45_0]

		if var_45_1 then
			return BattleVerthandiExclusiveCfg[var_45_1].name
		end
	end
end

function SPHeroChallengeActivityTemplate.CheckCanGetHeroChipTaskAward(arg_46_0)
	local var_46_0 = SPHeroChallengeData.activityCfg[arg_46_0.activityID].HeroChipTask

	if var_46_0 then
		local var_46_1 = TaskData2:GetTaskComplete(var_46_0)
		local var_46_2 = TaskData2:GetTaskProgress(var_46_0)
		local var_46_3 = AssignmentCfg[var_46_0].need

		if var_46_1 or var_46_2 < var_46_3 then
			return false, var_46_1, var_46_3, var_46_2
		else
			return true, nil, var_46_3, var_46_2
		end
	end
end
