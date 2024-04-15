slot0 = {
	TaskNetHandler = {
		SCCancelTask = 28005,
		CSRequestTaskOnceRequire = 28014,
		SCResponseSubmitTask = 28011,
		SCTaskList = 28001,
		SCResponseTaskOnceRequire = 28015,
		CSRequestSubmitTask = 28010,
		SCTaskProgressUpdate = 28007
	},
	Init = function (slot0)
		slot1 = slot0.TaskNetHandler

		slot0:Add_SC_Listener(slot1.SCTaskList, handler(slot0, slot0.OnSCTaskList))
		slot0:Add_SC_Listener(slot1.SCCancelTask, handler(slot0, slot0.OnSCCancelTask))
		slot0:Add_SC_Listener(slot1.SCTaskProgressUpdate, handler(slot0, slot0.OnSCTaskProgressUpdate))
	end,
	Add_SC_Listener = function (slot0, slot1, slot2)
		manager.net:Bind(slot1, function (slot0)
			if uv0 then
				uv0(slot0)
			end
		end)
	end,
	OnSCTaskList = function (slot0, slot1)
		if slot1.send_type == 0 then
			TaskData2:TaskInit(slot1.assignment_list, slot1.assignment_phase, slot1.newbie_phase)
		elseif slot1.send_type then
			TaskData2:TaskUpdate(slot1.assignment_list, slot1.assignment_phase, slot1.newbie_phase)
		end

		TaskAction:OnTaskChange(slot1.assignment_list)
	end,
	OnSCCancelTask = function (slot0, slot1)
		TaskData2:TaskDelete(slot1.id_list)
		TaskAction:OnTaskChange(TaskAction:PackTaskIdListToTaskList(slot1.id_list))
	end,
	OnSCTaskProgressUpdate = function (slot0, slot1)
		TaskData2:TaskModify(slot1.progress_list)
		TaskAction:OnTaskChange(slot1.progress_list)
	end,
	SubmitTask = function (slot0, slot1)
		manager.net:SendWithLoadingNew(slot0.TaskNetHandler.CSRequestSubmitTask, {
			id = slot1
		}, slot0.TaskNetHandler.SCResponseSubmitTask, function (slot0)
			if isSuccess(slot0.result) then
				uv0:OnSubmitTask(slot0, uv1)
				manager.notify:Invoke(ON_TASK_SUBMIT_RESPONSE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	OnSubmitTask = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			slot3 = AssignmentCfg[slot2]

			TaskData2:SubmitTask(slot2)

			if #mergeReward2(slot1.reward_list or {}) > 0 then
				getReward2(slot4)
			end

			slot5 = 0
			slot6 = 0
			slot5, slot8, slot4 = slot0:FilterPassportWeeklyBonus(slot3.type, slot4)

			if slot8 > 0 then
				PassportData:AddWeeklyExp(slot6)
			end

			slot0:AddTaskPoint(slot4)
			TaskAction:OnTaskChange(TaskAction:PackTaskIdListToTaskList({
				slot2
			}))
		else
			ShowTips(slot1.result)
		end
	end,
	SubmitTaskList = function (slot0, slot1, slot2, slot3)
		slot4.type = slot2 or 0

		manager.net:SendWithLoadingNew(slot0.TaskNetHandler.CSRequestTaskOnceRequire, {
			id_list = slot1
		}, slot0.TaskNetHandler.SCResponseTaskOnceRequire, function (slot0)
			if isSuccess(slot0.result) then
				uv0:OnSubmitTaskList(slot0, uv1)
				uv0:OnTaskChange(uv0:PackTaskIdListToTaskList(uv1.id_list))

				if uv2 then
					uv2()
				else
					manager.notify:Invoke(ON_TASK_SUBMIT_LIST_RESPONSE)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	OnSubmitTaskList = function (slot0, slot1, slot2)
		if not isSuccess(slot1.result) then
			ShowTips(slot1.result)

			return
		end

		if #mergeReward2(slot1.reward_list or {}) > 0 then
			getReward2(slot3)
		end

		slot4 = 0
		slot5 = 0

		for slot9, slot10 in ipairs(slot2.id_list) do
			TaskData2:SubmitTask(slot10)
		end

		if slot2.type == TaskConst.TASK_TYPE.DAILY then
			slot0:PostSubmitTaskList_DAILY(slot2, slot3)
		elseif slot2.type == TaskConst.TASK_TYPE.WEEK then
			slot0:PostSubmitTaskList_WEEK(slot2, slot3)
		elseif slot2.type == TaskConst.TASK_TYPE.PASSPORT_MULTIPLE_TASK_TYPE then
			for slot10, slot11 in ipairs(slot0.passportDailyIdList_) do
				table.insertto({}, AssignmentCfg[slot11].reward or {})
			end

			for slot10, slot11 in ipairs(slot0.passportWeeklyIdList_) do
				table.insertto(slot6, AssignmentCfg[slot11].reward or {})
			end

			slot7, slot8 = nil
			slot12 = TaskConst.TASK_TYPE.PASSPORT_DAILY
			slot13 = deepClone(mergeReward(formatRewardCfgList(slot6)))
			slot7, slot8, slot6 = slot0:FilterPassportWeeklyBonus(slot12, slot13)

			for slot12, slot13 in ipairs(slot0.passportChallengeIdList_) do
				table.insertto(slot6, AssignmentCfg[slot13].reward or {})
			end

			slot9, slot10 = nil
			slot11, slot12, slot3 = slot0:FilterPassportWeeklyBonus(0, mergeReward(formatRewardCfgList(slot6)))
			slot4 = slot11 + slot7
			slot5 = slot12 + slot8
		else
			slot4, slot5, slot3 = slot0:FilterPassportWeeklyBonus(slot2.type, slot3)
		end

		if slot5 > 0 then
			PassportData:AddWeeklyExp(slot5)
		end

		slot0:AddTaskPoint(slot3)
	end,
	PostSubmitTaskList_DAILY = function (slot0, slot1, slot2)
		slot6 = ActivityPtConst.TASK_DAILY_ACTIVITY_PT

		for slot6, slot7 in ipairs(ActivityPtCfg[slot6].target) do
			if not TaskTools.ActivityPtIsReceived(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, slot6) and TaskTools.ActivityPtCanReceive(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, slot6) then
				ActivityPtData:TaskDailySubmit({
					activityID = ActivityPtConst.TASK_DAILY_ACTIVITY_PT,
					activityPt = ActivityPtData:GetGiftPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, slot6)
				})
				table.insertto(slot2, ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].reward[slot6])
			end
		end

		ActivityPtAction:UpdateActivityPt()
	end,
	PostSubmitTaskList_WEEK = function (slot0, slot1, slot2)
		slot6 = ActivityPtConst.TASK_WEEK_ACTIVITY_PT

		for slot6, slot7 in ipairs(ActivityPtCfg[slot6].target) do
			if not TaskTools.ActivityPtIsReceived(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, slot6) and TaskTools.ActivityPtCanReceive(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, slot6) then
				ActivityPtData:TaskDailySubmit({
					activityID = ActivityPtConst.TASK_WEEK_ACTIVITY_PT,
					activityPt = ActivityPtData:GetGiftPt(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, slot6)
				})
				table.insertto(slot2, ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].reward[slot6])
			end
		end

		ActivityPtAction:UpdateActivityPt()
	end,
	TryToSubmitPassportTaskList = function (slot0, slot1, slot2, slot3)
		uv0.passportDailyIdList_ = slot1
		uv0.passportWeeklyIdList_ = slot2
		uv0.passportChallengeIdList_ = slot3
		slot4 = {}

		table.insertto(slot4, slot1)
		table.insertto(slot4, slot2)
		table.insertto(slot4, slot3)
		slot0:SubmitTaskList(slot4, TaskConst.TASK_TYPE.PASSPORT_MULTIPLE_TASK_TYPE)
	end,
	FilterPassportWeeklyBonus = function (slot0, slot1, slot2)
		slot3 = 0
		slot4 = 0

		for slot8, slot9 in pairs(slot2) do
			if slot1 == TaskConst.TASK_TYPE.PASSPORT_WEEKLY or slot1 == TaskConst.TASK_TYPE.PASSPORT_DAILY then
				if slot9.id == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
					slot9.num = math.min(GameSetting.battlepass_exp_limit_weekly.value[1] - PassportData:GetExpWeekly(), slot9.num)
					slot4 = slot9.num
				end

				if slot9.num == 0 then
					table.remove(slot2, slot8)
				else
					slot3 = slot3 + 1
				end
			else
				slot3 = slot3 + 1
			end
		end

		return slot3, slot4, slot2
	end,
	AddTaskPoint = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot1) do
			if ItemCfg[slot6.id] and slot9.type == ItemConst.ITEM_TYPE.CURRENCY and slot9.activity_id then
				ActivityPtData:ActivityPtModify(slot9.activity_id, slot6.num)
			end
		end

		ActivityPtAction:UpdateActivityPt()
	end,
	OnTaskChange = function (slot0, slot1)
		manager.notify:CallUpdateFunc(TASK_LIST_CHANGE)
		manager.notify:Invoke(OSIRIS_TASK_UPDATE)
		TaskRedPoint:StartUpdateRedPointPhase(slot1)
		manager.notify:Invoke(TASK_LIST_CHANGE_NOTIFY, slot1)
	end,
	PackTaskIdListToTaskList = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			table.insert(slot2, {
				id = slot7
			})
		end

		return slot2
	end
}

slot0:Init()

return slot0
