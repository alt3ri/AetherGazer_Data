return {
	GetTaskList = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in pairs(slot0) do
			if AssignmentCfg[slot8.id] == nil then
				print("没有对应的任务ID:", slot8.id)
			elseif AssignmentCfg[slot8.id].type == slot1 then
				if slot2 then
					if AssignmentCfg[slot8.id].phase == slot2 then
						table.insert(slot3, slot8.id)
					end
				else
					table.insert(slot3, slot8.id)
				end
			end
		end

		table.sort(slot3)

		return slot3
	end,
	ActivityPtCanReceive = function (slot0, slot1)
		return ActivityPtCfg[slot0].target[slot1] <= ActivityPtData:GetCurrentActivityPt(slot0)
	end,
	ActivityPtIsReceived = function (slot0, slot1)
		if ActivityPtData:GetDailyGetRewardList()[slot0][ActivityPtCfg[slot0].target[slot1]] then
			return true
		end

		return false
	end,
	GetCanGetActivityTaskList = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in pairs(TaskData2:GetTaskIDListByActivity(slot1)) do
			if slot7 and TaskData2:GetTask(slot7) then
				if not TaskData2:GetTaskComplete(slot7) and AssignmentCfg[slot7].need <= slot9.progress then
					table.insert(slot3, slot9)
				end
			end
		end

		return slot3
	end,
	GetActivityTaskList = function (slot0, slot1)
		for slot7, slot8 in pairs(TaskData2:GetActivityTaskSortList(slot1)) do
			if slot8 then
				-- Nothing
			end
		end

		return {
			[slot8.id] = slot8
		}
	end,
	GetAllCanReciveTaskByActivityID = function (slot0, slot1, slot2)
		if slot1 then
			slot3 = {}

			for slot8, slot9 in pairs(uv0:GetActivityTaskList(slot1)) do
				if slot9 then
					if AssignmentCfg[slot8].need <= TaskData2:GetTaskProgress(slot8) and not TaskData2:GetTaskComplete(slot8) then
						table.insert(slot3, slot8)
					end
				end
			end

			if next(slot3) then
				TaskAction:SubmitTaskList(slot3)
			end

			if slot2 then
				slot2()
			end
		end
	end,
	GetFinishTaskIds = function (slot0, slot1, slot2)
		slot3 = manager.time:GetServerTime()

		return slot0:GetTaskListByPredict(slot1, slot2, function (slot0)
			if AssignmentCfg[slot0].need <= TaskData2:GetTask(slot0).progress and slot2.complete_flag == 0 and (slot2.expired_timestamp == 0 or uv0 <= slot2.expired_timestamp) then
				return true
			end

			return false
		end)
	end,
	GetTaskListByPredict = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		if slot1 and TaskData2:GetTaskIDListByType(slot1) then
			for slot9, slot10 in pairs(slot5) do
				if AssignmentCfg[slot9] == nil then
					print("没有对应的任务ID:", slot9)

					break
				end

				slot12 = nil

				if slot2 then
					if slot11.phase == slot2 then
						slot12 = slot9
					end
				else
					slot12 = slot9
				end

				if slot12 then
					if slot3 then
						if slot3(slot12) then
							table.insert(slot4, slot12)
						end
					else
						table.insert(slot4, slot12)
					end
				end
			end
		end

		return slot4
	end,
	GetTaskCountByType = function (slot0, slot1)
		for slot7, slot8 in pairs(TaskData2:GetTypedTaskSortList(slot1)) do
			if slot8 and TaskData2:GetTask(slot8.id) then
				slot3 = 0 + 1
			end
		end

		return slot3
	end,
	GetPlotPhaseID = function (slot0)
		slot0:GetTaskCountByType(TaskConst.TASK_TYPE.PLOT)

		for slot5, slot6 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.PLOT)) do
			if slot5 and TaskData2:GetTask(slot5) and AssignmentCfg[slot5].condition == GameSetting.task_top_type.value[1] and slot7.type == TaskConst.TASK_TYPE.PLOT and TaskData2:GetPlotPhase() <= slot7.phase then
				return slot5
			end
		end
	end,
	GetNewbiePhaseTask = function (slot0)
		for slot6, slot7 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.ALPHA)) do
			if slot6 and TaskData2:GetTask(slot6) and AssignmentCfg[slot6].condition == TaskConst.STAGE_TASK_ID and slot9.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
				-- Nothing
			end
		end

		return {
			[slot9.phase] = slot8
		}
	end,
	GetNoobPhaseTask = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in pairs(TaskData2:GetTaskIDListByType(slot1)) do
			slot9 = TaskData2:GetTask(slot7)

			if slot8 and slot9 then
				slot10 = AssignmentCfg[slot7]
				slot2[slot10.phase] = slot2[slot10.phase] or {}
				slot2[slot10.phase][slot7] = slot9
			end
		end

		return slot2
	end,
	GetNoobReadyList = function (slot0, slot1, slot2)
		slot3 = {}

		for slot8, slot9 in pairs(TaskTools:GetNoobTaskSortList(slot1, slot2)) do
			if AssignmentCfg[slot9.id].phase <= ActivityNoobData:GetUnlockPhase() and slot10.need <= slot9.progress and slot9.complete_flag < 1 then
				table.insert(slot3, slot9.id)
			end
		end

		return slot3
	end,
	GetNoobCompletedList = function (slot0, slot1)
		slot2 = {}

		for slot7, slot8 in pairs(TaskData2:GetTaskIDListByType(slot1)) do
			slot9 = TaskData2:GetTask(slot7)

			if slot8 and slot9 then
				slot10 = AssignmentCfg[slot7]

				if slot9.complete_flag >= 1 then
					slot2[slot10.phase] = (slot2[slot10.phase] or 0) + 1
				end
			end
		end

		return slot2
	end,
	IsCompletedAllNoobAdvanceTask = function (slot0, slot1)
		for slot6, slot7 in pairs(TaskData2:GetTaskIDListByType(slot1)) do
			slot8 = TaskData2:GetTask(slot6)

			if slot7 and slot8 and (slot8.progress < AssignmentCfg[slot6].need or slot8.complete_flag == 0) then
				return false
			end
		end

		return true
	end,
	GetNewbieDailyTaskFinishCnt = function (slot0)
		for slot6, slot7 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.DAILY_OFFER)) do
			slot8 = TaskData2:GetTask(slot6)

			if slot7 and slot8 and slot8.complete_flag == 1 then
				slot9 = AssignmentCfg[slot6]
				slot2 = 0 + 1
			end
		end

		return slot2
	end,
	GetTaskIDList = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in pairs(TaskData2:GetTaskIDListByType(slot1)) do
			if slot8 and TaskData2:GetTask(slot7) then
				table.insert(slot3, slot7)
			end
		end

		return slot3
	end,
	GetNoobAdvanceTaskSortList = function (slot0, slot1, slot2)
		return TaskData2:GetSortedPhaseTaskList(slot1, slot2)
	end,
	GetNoobTaskSortList = function (slot0, slot1, slot2)
		return TaskData2:GetSortedPhaseTaskList(slot1, slot2)
	end,
	GetNewbieTaskSortList = function (slot0, slot1)
		return TaskData2:GetSortedPhaseTaskList(TaskConst.TASK_TYPE.ALPHA, slot1)
	end,
	GetIdolTraineeTaskSortList = function (slot0)
		slot2 = TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.IDOL_TRAINEE_WEEKLY)

		for slot7, slot8 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY)) do
			table.insert({}, slot7)
		end

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot7)
		end

		table.sort(slot3, function (slot0, slot1)
			slot4 = AssignmentCfg[slot0].need <= TaskData2:GetTaskProgress(slot0)
			slot5 = AssignmentCfg[slot1].need <= TaskData2:GetTaskProgress(slot1)

			if TaskData2:GetTaskComplete(slot0) ~= TaskData2:GetTaskComplete(slot1) then
				return slot3
			end

			if slot4 ~= slot5 then
				return slot4
			end

			return slot0 < slot1
		end)

		return slot3
	end,
	ShowActivityTaskPop = function (slot0, slot1)
		JumpTools.OpenPageByJump("commonTaskPop", {
			activityId = slot1
		})
	end,
	ShowTypeTaskPop = function (slot0, slot1)
		JumpTools.OpenPageByJump("commonTaskPop", {
			taskType = slot1
		})
	end
}
