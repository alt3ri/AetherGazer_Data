local var_0_0 = {
	ParseScheduleInfo = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			return {
				index = arg_1_1.index,
				scheduleID = arg_1_1.schedule_id,
				isFinish = arg_1_1.is_finish,
				type = ActivityHeroChallengeScheduleCfg[arg_1_1.schedule_id].server_type
			}
		end

		Debug.LogError("未传入schedule_info")
	end,
	ParseEntrustInfo = function(arg_2_0, arg_2_1)
		if arg_2_1 then
			return {
				index = arg_2_1.index,
				entrustID = arg_2_1.entrust_id,
				startTime = arg_2_1.start_time or 0,
				showIndex = arg_2_1.index
			}
		end

		Debug.LogError("未传入entrust_info")
	end,
	ParseTrainInfo = function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_1 then
			local var_3_0 = {}

			for iter_3_0, iter_3_1 in ipairs(arg_3_1.passed_level) do
				table.insert(var_3_0, iter_3_1)
			end

			return {
				type = arg_3_1.type,
				passStageList = var_3_0,
				value = arg_3_1.value or 0
			}
		else
			return {
				value = 0,
				type = arg_3_2,
				passStageList = {}
			}
		end

		Debug.LogError("未传入train_info")
	end,
	ParseScoreInfo = function(arg_4_0, arg_4_1)
		if arg_4_1 then
			return {
				stageID = arg_4_1.stage_id,
				score = arg_4_1.score
			}
		end
	end
}

manager.net:Bind(83017, function(arg_5_0)
	local var_5_0 = SPHeroChallengeData:GetActivityData(arg_5_0.activity_id)

	if var_5_0 then
		var_5_0:InitCurScheduleList(arg_5_0.schedule_list)
	end
end)

function var_0_0.ConfirmScheduleList(arg_6_0, arg_6_1)
	local var_6_0 = {}

	if not arg_6_1 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if iter_6_1 == 0 then
			print("数据非法")

			return
		end

		local var_6_1 = {
			is_finish = false,
			index = iter_6_0,
			schedule_id = iter_6_1
		}

		table.insert(var_6_0, var_6_1)
	end

	local var_6_2 = SPHeroChallengeData:GetActivityID()

	manager.net:SendWithLoadingNew(83003, {
		schedule_info_list = var_6_0,
		activity_id = var_6_2
	}, 83004, var_0_0.ConfirmScheduleListCallBack)
end

function var_0_0.ConfirmScheduleListCallBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		local var_7_0 = SPHeroChallengeData:GetCurActivityInfo()

		if var_7_0 then
			var_7_0:InitCurScheduleList(arg_7_1.schedule_info_list)
		end

		manager.notify:Invoke(SP_HERO_CHALLENGE_UPDATE_SCHEDULE)
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.GetScheduleAward(arg_8_0)
	local var_8_0 = SPHeroChallengeData:GetCurActivityInfo():GetFinScheduleScore()
	local var_8_1 = SPHeroChallengeData:GetActivityID()

	if var_8_0 >= GameSetting.activity_hero_challenge_schedule_award_point_limit.value[1] then
		manager.net:SendWithLoadingNew(83005, {
			activity_id = var_8_1
		}, 83006, var_0_0.GetScheduleAwardCallBack)
	else
		ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_SCORE")
	end
end

function var_0_0.GetScheduleAwardCallBack(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		local var_9_0 = SPHeroChallengeData:GetActivityData(arg_9_1.activity_id)

		if var_9_0 then
			var_9_0.getAwardFlag = true
		end

		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_0.reward_list) do
			table.insert(var_9_1, {
				id = iter_9_1.id,
				num = iter_9_1.num
			})
		end

		getReward(var_9_1)
		manager.notify:Invoke(SP_HERO_CHALLENGE_GET_SCHEDULE_AWARD)
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.RefreshEntrustList(arg_10_0)
	local var_10_0 = SPHeroChallengeData:GetCurActivityInfo().entrustFreeTime
	local var_10_1 = SPHeroChallengeData:GetActivityID()
	local var_10_2 = SPHeroChallengeData.activityCfg[var_10_1].freeRefreshEntrustTime
	local var_10_3 = SPHeroChallengeData.activityCfg[var_10_1].refreshEntrustCost[1]
	local var_10_4 = ItemTools.getItemName(var_10_3[1])

	if var_10_2 and var_10_2 <= var_10_0 then
		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_ENTRUST_TIPS"), var_10_3[2], var_10_4),
			OkCallback = function()
				manager.net:SendWithLoadingNew(83007, {
					activity_id = var_10_1
				}, 83008, var_0_0.RefreshEntrustListCallBack)
			end
		})
	else
		manager.net:SendWithLoadingNew(83007, {
			activity_id = var_10_1
		}, 83008, var_0_0.RefreshEntrustListCallBack)
	end
end

function var_0_0.RefreshEntrustListCallBack(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		local var_12_0 = SPHeroChallengeData:GetActivityData(arg_12_1.activity_id)

		if var_12_0 then
			var_12_0:InitWaiteEntrustList(arg_12_0.entrust_id_list)
		end

		var_12_0.entrustFreeTime = math.min(var_12_0.entrustFreeTime + 1, GameSetting.activity_hero_challenge_task_free_refresh_num.value[1])
		var_12_0.entrustTime = var_12_0.entrustTime + 1

		manager.notify:Invoke(SP_HERO_CHALLENGE_REFRESH_ENTRUST)
	else
		ShowTips(arg_12_0.result)
	end
end

function var_0_0.DispatchEntrust(arg_13_0, arg_13_1)
	local var_13_0 = SPHeroChallengeData:GetActivityID()
	local var_13_1, var_13_2 = SPHeroChallengeTools:CheckCanStartEntrust(arg_13_1.entrustID, var_13_0)

	if var_13_1 then
		manager.net:SendWithLoadingNew(83009, {
			activity_id = var_13_0,
			index = arg_13_1.index,
			entrust_id = arg_13_1.entrustID
		}, 83010, var_0_0.DispatchEntrustCallBack)
	else
		ShowTips(var_13_2)
	end
end

function var_0_0.DispatchEntrustCallBack(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		local var_14_0 = SPHeroChallengeData:GetActivityData(arg_14_1.activity_id)

		if var_14_0 then
			var_14_0:StartEntrust(arg_14_1.index, arg_14_1.entrust_id)
		end

		manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
	else
		ShowTips(arg_14_0.result)
	end
end

function var_0_0.CancelEntrust(arg_15_0, arg_15_1)
	local var_15_0 = SPHeroChallengeData:GetActivityID()

	manager.net:SendWithLoadingNew(83011, {
		activity_id = var_15_0,
		index = arg_15_1.index
	}, 83012, var_0_0.CancelEntrustCallBack)
end

function var_0_0.CancelEntrustCallBack(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		local var_16_0 = SPHeroChallengeData:GetActivityData(arg_16_1.activity_id)

		if var_16_0 then
			var_16_0:CancelEntrust(arg_16_1.index)
		end

		manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
	else
		ShowTips(arg_16_0.result)
	end
end

function var_0_0.GetEntrustAward(arg_17_0, arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		table.insert(var_17_0, iter_17_1)
	end

	local var_17_1 = SPHeroChallengeData:GetActivityID()

	manager.net:SendWithLoadingNew(83013, {
		activity_id = var_17_1,
		index_list = var_17_0
	}, 83014, var_0_0.GetEntrustAwardCallBack)
end

function var_0_0.GetEntrustAwardCallBack(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		local var_18_0 = SPHeroChallengeData:GetActivityData(arg_18_1.activity_id)

		if var_18_0 then
			var_18_0:InitCurEntrustList(arg_18_0.begin_entrust_list)

			local var_18_1 = {}

			for iter_18_0, iter_18_1 in ipairs(arg_18_0.reward_list) do
				table.insert(var_18_1, {
					id = iter_18_1.id,
					num = iter_18_1.num
				})
			end

			getReward(var_18_1)

			local var_18_2 = SPHeroChallengeData:GetActivityID()

			SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(var_18_2)
			manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
		end
	else
		ShowTips(arg_18_0.result)
	end
end

function var_0_0.UseEntrustAccelerator(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = SPHeroChallengeData:GetActivityID()

	manager.net:SendWithLoadingNew(83018, {
		activity_id = var_19_0,
		index = arg_19_2,
		use_cnt = arg_19_1
	}, 83019, var_0_0.UseEntrustAcceleratorCallBack)
end

function var_0_0.UseEntrustAcceleratorCallBack(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		local var_20_0 = SPHeroChallengeData:GetActivityData(arg_20_1.activity_id)

		if var_20_0 then
			var_20_0:ModefyEntrustStartTime(arg_20_1)
		end
	else
		ShowTips(arg_20_0.result)
	end
end

manager.net:Bind(83015, function(arg_21_0)
	local var_21_0 = SPHeroChallengeData:GetActivityData(arg_21_0.activity_id)

	if var_21_0 then
		var_21_0:InitTrainInfo(arg_21_0.train_list)
	end
end)

local var_0_1

manager.net:Bind(83020, function(arg_22_0)
	local var_22_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_22_0.activity_id]

	if var_22_0 then
		local var_22_1 = var_22_0[1]
		local var_22_2 = SPHeroChallengeData:GetActivityData(var_22_1)

		if var_22_2 then
			var_22_2:InitBossInfo(arg_22_0)
		end

		var_0_1 = arg_22_0
	end
end)
manager.net:Bind(83016, function(arg_23_0)
	SPHeroChallengeData:InitEnterData(arg_23_0)
	SPHeroChallengeRedPointTools:UpdataLogInRedPoint()

	local var_23_0 = SPHeroChallengeData:GetActivityData(arg_23_0.activity_id)

	if var_23_0 and var_0_1 then
		var_23_0:InitBossInfo(var_0_1)

		var_0_1 = nil
	end
end)

function var_0_0.SettleBarbecueGame(arg_24_0, arg_24_1)
	manager.net:SendWithLoadingNew(83022, {
		stage_id = arg_24_1.stage_id,
		grade_id = arg_24_1.index,
		hero_id = arg_24_1.hero_id,
		result = arg_24_1.result
	}, 83023, var_0_0.SettleBarbecueGameCallBack)
end

function var_0_0.SettleBarbecueGameCallBack(arg_25_0, arg_25_1)
	if isSuccess(arg_25_0.result) then
		if ActivityHeroChallengeBarbecueCfg[arg_25_1.stage_id] then
			SPHeroChallengeData:InitBarbuceAwardData(arg_25_0.reward_recode)
			SPHeroChallengeData:InitAccelerateData(arg_25_0.ticket_recode)
			manager.notify:Invoke(DORM_STOP_RHYTHM_GAME, true, arg_25_0.reward_list)
		end
	else
		ShowTips(arg_25_0.result)
	end
end

manager.net:Bind(83026, function(arg_26_0)
	SPHeroChallengeData:InitBarbuceAwardData(arg_26_0.reward_record)
	SPHeroChallengeData:InitAccelerateData(arg_26_0.ticket_record)
	manager.notify:Invoke(BREAK_GAME_REFRESH_VIEW)
end)

function var_0_0.OnEnterBarbuceScene(arg_27_0, arg_27_1)
	DormMinigame.Launch("HZ07_kaorou1")
end

return var_0_0
