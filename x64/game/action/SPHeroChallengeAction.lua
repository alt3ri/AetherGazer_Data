manager.net:Bind(83017, function (slot0)
	if SPHeroChallengeData:GetActivityData(slot0.activity_id) then
		slot1:InitCurScheduleList(slot0.schedule_list)
	end
end)
manager.net:Bind(83015, function (slot0)
	if SPHeroChallengeData:GetActivityData(slot0.activity_id) then
		slot1:InitTrainInfo(slot0.train_list)
	end
end)

slot1 = nil

manager.net:Bind(83020, function (slot0)
	if ActivityCfg.get_id_list_by_sub_activity_list[slot0.activity_id] then
		if SPHeroChallengeData:GetActivityData(slot1[1]) then
			slot3:InitBossInfo(slot0)
		end

		uv0 = slot0
	end
end)
manager.net:Bind(83016, function (slot0)
	SPHeroChallengeData:InitEnterData(slot0)
	SPHeroChallengeRedPointTools:UpdataLogInRedPoint()

	if SPHeroChallengeData:GetActivityData(slot0.activity_id) and uv0 then
		slot1:InitBossInfo(uv0)

		uv0 = nil
	end
end)
manager.net:Bind(83026, function (slot0)
	SPHeroChallengeData:InitBarbuceAwardData(slot0.reward_record)
	SPHeroChallengeData:InitAccelerateData(slot0.ticket_record)
	manager.notify:Invoke(BREAK_GAME_REFRESH_VIEW)
end)

return {
	ParseScheduleInfo = function (slot0, slot1)
		if slot1 then
			return {
				index = slot1.index,
				scheduleID = slot1.schedule_id,
				isFinish = slot1.is_finish,
				type = ActivityHeroChallengeScheduleCfg[slot1.schedule_id].server_type
			}
		end

		Debug.LogError("未传入schedule_info")
	end,
	ParseEntrustInfo = function (slot0, slot1)
		if slot1 then
			return {
				index = slot1.index,
				entrustID = slot1.entrust_id,
				startTime = slot1.start_time or 0,
				showIndex = slot1.index
			}
		end

		Debug.LogError("未传入entrust_info")
	end,
	ParseTrainInfo = function (slot0, slot1, slot2)
		if slot1 then
			slot3 = {}

			for slot7, slot8 in ipairs(slot1.passed_level) do
				table.insert(slot3, slot8)
			end

			return {
				type = slot1.type,
				passStageList = slot3,
				value = slot1.value or 0
			}
		else
			return {
				value = 0,
				type = slot2,
				passStageList = {}
			}
		end

		Debug.LogError("未传入train_info")
	end,
	ParseScoreInfo = function (slot0, slot1)
		if slot1 then
			return {
				stageID = slot1.stage_id,
				score = slot1.score
			}
		end
	end,
	ConfirmScheduleList = function (slot0, slot1)
		slot2 = {}

		if not slot1 then
			return
		end

		for slot6, slot7 in ipairs(slot1) do
			if slot7 == 0 then
				print("数据非法")

				return
			end

			table.insert(slot2, {
				is_finish = false,
				index = slot6,
				schedule_id = slot7
			})
		end

		manager.net:SendWithLoadingNew(83003, {
			schedule_info_list = slot2,
			activity_id = SPHeroChallengeData:GetActivityID()
		}, 83004, uv0.ConfirmScheduleListCallBack)
	end,
	ConfirmScheduleListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetCurActivityInfo() then
				slot2:InitCurScheduleList(slot1.schedule_info_list)
			end

			manager.notify:Invoke(SP_HERO_CHALLENGE_UPDATE_SCHEDULE)
		else
			ShowTips(slot0.result)
		end
	end,
	GetScheduleAward = function (slot0)
		if GameSetting.activity_hero_challenge_schedule_award_point_limit.value[1] <= SPHeroChallengeData:GetCurActivityInfo():GetFinScheduleScore() then
			manager.net:SendWithLoadingNew(83005, {
				activity_id = SPHeroChallengeData:GetActivityID()
			}, 83006, uv0.GetScheduleAwardCallBack)
		else
			ShowTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_SCORE")
		end
	end,
	GetScheduleAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetActivityData(slot1.activity_id) then
				slot2.getAwardFlag = true
			end

			slot3 = {}

			for slot7, slot8 in ipairs(slot0.reward_list) do
				table.insert(slot3, {
					id = slot8.id,
					num = slot8.num
				})
			end

			getReward(slot3)
			manager.notify:Invoke(SP_HERO_CHALLENGE_GET_SCHEDULE_AWARD)
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshEntrustList = function (slot0)
		slot3 = SPHeroChallengeData:GetActivityID()

		if SPHeroChallengeData.activityCfg[slot3].freeRefreshEntrustTime and slot4 <= SPHeroChallengeData:GetCurActivityInfo().entrustFreeTime then
			ShowMessageBox({
				content = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_ENTRUST_TIPS"), slot5[2], ItemTools.getItemName(SPHeroChallengeData.activityCfg[slot3].refreshEntrustCost[1][1])),
				OkCallback = function ()
					manager.net:SendWithLoadingNew(83007, {
						activity_id = uv0
					}, 83008, uv1.RefreshEntrustListCallBack)
				end
			})
		else
			manager.net:SendWithLoadingNew(83007, {
				activity_id = slot3
			}, 83008, uv0.RefreshEntrustListCallBack)
		end
	end,
	RefreshEntrustListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetActivityData(slot1.activity_id) then
				slot2:InitWaiteEntrustList(slot0.entrust_id_list)
			end

			slot2.entrustFreeTime = math.min(slot2.entrustFreeTime + 1, GameSetting.activity_hero_challenge_task_free_refresh_num.value[1])
			slot2.entrustTime = slot2.entrustTime + 1

			manager.notify:Invoke(SP_HERO_CHALLENGE_REFRESH_ENTRUST)
		else
			ShowTips(slot0.result)
		end
	end,
	DispatchEntrust = function (slot0, slot1)
		slot3, slot4 = SPHeroChallengeTools:CheckCanStartEntrust(slot1.entrustID, SPHeroChallengeData:GetActivityID())

		if slot3 then
			manager.net:SendWithLoadingNew(83009, {
				activity_id = slot2,
				index = slot1.index,
				entrust_id = slot1.entrustID
			}, 83010, uv0.DispatchEntrustCallBack)
		else
			ShowTips(slot4)
		end
	end,
	DispatchEntrustCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetActivityData(slot1.activity_id) then
				slot2:StartEntrust(slot1.index, slot1.entrust_id)
			end

			manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
		else
			ShowTips(slot0.result)
		end
	end,
	CancelEntrust = function (slot0, slot1)
		manager.net:SendWithLoadingNew(83011, {
			activity_id = SPHeroChallengeData:GetActivityID(),
			index = slot1.index
		}, 83012, uv0.CancelEntrustCallBack)
	end,
	CancelEntrustCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetActivityData(slot1.activity_id) then
				slot2:CancelEntrust(slot1.index)
			end

			manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
		else
			ShowTips(slot0.result)
		end
	end,
	GetEntrustAward = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			table.insert(slot2, slot7)
		end

		manager.net:SendWithLoadingNew(83013, {
			activity_id = SPHeroChallengeData:GetActivityID(),
			index_list = slot2
		}, 83014, uv0.GetEntrustAwardCallBack)
	end,
	GetEntrustAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetActivityData(slot1.activity_id) then
				slot2:InitCurEntrustList(slot0.begin_entrust_list)

				slot3 = {}

				for slot7, slot8 in ipairs(slot0.reward_list) do
					table.insert(slot3, {
						id = slot8.id,
						num = slot8.num
					})
				end

				getReward(slot3)
				SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(SPHeroChallengeData:GetActivityID())
				manager.notify:Invoke(SP_HERO_CHALLENGE_START_ENTRUST)
			end
		else
			ShowTips(slot0.result)
		end
	end,
	UseEntrustAccelerator = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(83018, {
			activity_id = SPHeroChallengeData:GetActivityID(),
			index = slot2,
			use_cnt = slot1
		}, 83019, uv0.UseEntrustAcceleratorCallBack)
	end,
	UseEntrustAcceleratorCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if SPHeroChallengeData:GetActivityData(slot1.activity_id) then
				slot2:ModefyEntrustStartTime(slot1)
			end
		else
			ShowTips(slot0.result)
		end
	end,
	SettleBarbecueGame = function (slot0, slot1)
		manager.net:SendWithLoadingNew(83022, {
			stage_id = slot1.stage_id,
			grade_id = slot1.index,
			hero_id = slot1.hero_id,
			result = slot1.result
		}, 83023, uv0.SettleBarbecueGameCallBack)
	end,
	SettleBarbecueGameCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if ActivityHeroChallengeBarbecueCfg[slot1.stage_id] then
				SPHeroChallengeData:InitBarbuceAwardData(slot0.reward_recode)
				SPHeroChallengeData:InitAccelerateData(slot0.ticket_recode)
				manager.notify:Invoke(DORM_STOP_RHYTHM_GAME, true, slot0.reward_list)
			end
		else
			ShowTips(slot0.result)
		end
	end,
	OnEnterBarbuceScene = function (slot0, slot1)
		DormMinigame.Launch("HZ07_kaorou1")
	end
}
