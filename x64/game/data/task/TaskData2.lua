slot0 = singletonClass("TaskData2")

function slot0.Init(slot0)
	slot0.data = {
		plotPhase_ = 1,
		newbieTaskPhase_ = 1,
		taskList = {},
		activityList = {},
		typeList = {},
		typedSortedList = {},
		activitySortedList = {},
		phaseSortedList = {}
	}
end

function slot0.TaskInit(slot0, slot1, slot2)
	slot0.data.newbieTaskPhase_ = slot2

	slot0:TaskModify(slot1)
end

function slot0.TaskUpdate(slot0, slot1, slot2)
	if slot2 then
		slot0.data.newbieTaskPhase_ = slot2
	end

	slot0:TaskModify(slot1)
end

function slot0.TaskModify(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if AssignmentCfg[slot6.id] == nil then
			Debug.LogError("TaskCfg没有对应ID:" .. slot6.id)
		else
			slot0:UpdateData(slot6)
			slot0:TaskUpdatePlotPhase(slot6)
		end
	end
end

function slot0.UpdateData(slot0, slot1)
	slot1 = slot0:ParserData(slot1)
	slot2 = AssignmentCfg[slot1.id]
	slot0.data.taskList[slot1.id] = slot1

	slot0:BuildTypedMap(slot1)
	slot0:BuildActivityMap(slot1)
	slot0:MarkSortDirty(slot1)
end

function slot0.TaskUpdatePlotPhase(slot0, slot1)
	if AssignmentCfg[slot1.id].type == TaskConst.TASK_TYPE.PLOT and slot0.data.plotPhase_ < slot2.phase then
		slot0.data.plotPhase_ = slot2.phase
	end
end

function slot0.TaskDelete(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			id = slot6
		}
		slot8 = AssignmentCfg[slot7.id]
		slot0.data.taskList[slot7.id] = nil
		slot0.data.typeList[slot8.type][slot7.id] = nil

		if slot8.activity_id and slot8.activity_id ~= 0 then
			slot0.data.activityList[slot8.activity_id][slot7.id] = nil
		end

		slot0:MarkSortDirty(slot7)
	end
end

function slot0.MarkSortDirty(slot0, slot1)
	slot2 = AssignmentCfg[slot1.id]
	slot0.data.typedSortedList[slot2.type] = false

	if slot2.activity_id and slot2.activity_id ~= 0 then
		slot0.data.activitySortedList[slot2.activity_id] = false
	end

	if slot2.phase and slot2.phase ~= 0 then
		slot0.data.phaseSortedList[slot2.type] = slot0.data.phaseSortedList[slot2.type] or {}
		slot0.data.phaseSortedList[slot2.type][slot2.phase] = false
	end
end

function slot0.SortTask(slot0, slot1)
	if slot1 == nil then
		return {}
	end

	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(slot1) do
		if slot10 and slot0:GetTask(slot9) then
			if slot11.complete_flag == 0 then
				if slot11.progress < AssignmentCfg[slot9].need then
					if slot12.activity_id ~= 0 then
						if manager.time:GetServerTime() < ActivityData:GetActivityData(slot13).startTime then
							table.insert(slot2, slot11)
						else
							table.insert(slot3, slot11)
						end
					else
						table.insert(slot3, slot11)
					end
				else
					table.insert(slot4, slot11)
				end
			elseif slot11.complete_flag > 0 then
				table.insert(slot5, slot11)
			end
		end
	end

	table.sort(slot4, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.sort(slot3, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.sort(slot5, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.sort(slot2, function (slot0, slot1)
		return AssignmentCfg[slot0.id].type < AssignmentCfg[slot1.id].type and true or slot0.id < slot1.id
	end)
	table.insertto(slot4, slot3)
	table.insertto(slot4, slot2)
	table.insertto(slot4, slot5)

	return slot4
end

function slot0.ParserData(slot0, slot1)
	return {
		id = slot1.id,
		progress = slot1.progress,
		complete_flag = slot1.complete_flag,
		expired_timestamp = slot1.expired_timestamp
	}
end

function slot0.BuildTypedMap(slot0, slot1)
	if not slot0.data.typeList[AssignmentCfg[slot1.id].type] then
		slot0.data.typeList[slot2.type] = {}
	end

	slot0.data.typeList[slot2.type][slot1.id] = true
end

function slot0.BuildActivityMap(slot0, slot1)
	if AssignmentCfg[slot1.id].activity_id or slot2.activity_id ~= 0 then
		if not slot0.data.activityList[slot2.activity_id] then
			slot0.data.activityList[slot2.activity_id] = {}
		end

		slot0.data.activityList[slot2.activity_id][slot1.id] = true
	end
end

function slot0.GetTaskIDListByType(slot0, slot1)
	return slot0.data.typeList[slot1] or {}
end

function slot0.GetTaskIDListByActivity(slot0, slot1)
	return slot0.data.activityList[slot1] or {}
end

function slot0.GetTask(slot0, slot1)
	return slot0.data.taskList[slot1]
end

function slot0.GetTaskComplete(slot0, slot1)
	if slot0.data.taskList[slot1] then
		return slot0.data.taskList[slot1].complete_flag >= 1
	end

	return false
end

function slot0.GetActivityTaskSortList(slot0, slot1)
	if not slot0.data.activitySortedList[slot1] then
		slot0.data.activitySortedList[slot1] = slot0:SortTask(slot0.data.activityList[slot1])
	end

	return slot0.data.activitySortedList[slot1] or {}
end

function slot0.GetTypedTaskSortList(slot0, slot1, slot2)
	if not slot0.data.typedSortedList[slot1] then
		slot0.data.typedSortedList[slot1] = slot0:SortTask(slot0.data.typeList[slot1])
	end

	slot3 = slot0.data.typedSortedList[slot1] or {}

	if slot2 then
		slot4 = {}

		for slot8, slot9 in ipairs(slot3) do
			if slot2(slot9) then
				table.insert(slot4, slot9)
			end
		end

		return slot4
	else
		return slot3
	end
end

function slot0.GetTypedTaskSortListCommonFilter(slot0, slot1)
	return slot0:GetTypedTaskSortList(slot1, slot0.CommonTaskFilterRole)
end

function slot0.GetTaskProgress(slot0, slot1)
	if slot0.data.taskList[slot1] then
		return slot0.data.taskList[slot1].progress
	end

	return 0
end

function slot0.GetAssignmentPhase(slot0)
	return slot0.data.newbieTaskPhase_ or 1
end

function slot0.GetPlotPhase(slot0)
	return slot0.data.plotPhase_
end

function slot0.GetSortedPhaseTaskList(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return {}
	end

	if not slot0.data.phaseSortedList[slot1] or not slot0.data.phaseSortedList[slot1][slot2] then
		for slot8, slot9 in pairs(slot0:GetTaskIDListByType(slot1)) do
			slot10 = slot0:GetTask(slot8)

			if slot9 and slot10 and not slot0:CheckFilterPhaseTask(slot10) and AssignmentCfg[slot8].phase == slot2 then
				-- Nothing
			end
		end

		slot0.data.phaseSortedList[slot1] = slot0.data.phaseSortedList[slot1] or {}
		slot0.data.phaseSortedList[slot1][slot2] = slot0:SortTask({
			[slot8] = true
		})
	end

	return slot0.data.phaseSortedList[slot1][slot2]
end

function slot0.SubmitTask(slot0, slot1)
	if slot0:GetTask(slot1) then
		slot2.complete_flag = 1

		slot0:MarkSortDirty(slot2)
	end
end

function slot0.SubmitTaskList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:SubmitTask(slot6)
	end
end

function slot0.UpdateTaskCompleteFlag(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0:GetTask(slot6.id) then
			slot7.complete_flag = slot7.complete_flag + slot6.vary
		end
	end
end

function slot0.CommonTaskFilterRole(slot0)
	if slot0 then
		slot1 = AssignmentCfg[slot0.id]

		if slot0.complete_flag >= 1 and slot1.type == TaskConst.TASK_TYPE.PLOT and slot1.phase < TaskData2:GetPlotPhase() then
			return false
		else
			if slot1.condition == GameSetting.task_top_type.value[1] and slot1.type == TaskConst.TASK_TYPE.PLOT then
				return false
			end

			return true
		end
	end

	return false
end

function slot0.CheckFilterPhaseTask(slot0, slot1)
	if not slot1 then
		return false
	end

	if not AssignmentCfg[slot1.id] then
		return false
	end

	if slot2.condition == TaskConst.STAGE_TASK_ID and slot2.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		return true
	end

	return false
end

return slot0
