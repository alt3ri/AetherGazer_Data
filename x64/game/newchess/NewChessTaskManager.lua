CheckTaskIterator = class("CheckTaskIterator")

function CheckTaskIterator.Ctor(slot0)
	slot0.curTaskIndex = 0
	slot0.curTaskList = {}
	slot3 = manager.NewChessManager.taskManager_
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetTaskList(slot5)) do
		table.insert(slot0.curTaskList, deepClone(slot5))
	end

	manager.NewChessManager:ShowBlock()
end

function CheckTaskIterator.MoveNext(slot0)
	slot0.curTaskIndex = slot0.curTaskIndex + 1

	if slot0.curTaskIndex <= #slot0.curTaskList then
		slot1 = slot0.curTaskList[slot0.curTaskIndex]

		if slot1.need <= slot1.cur then
			NewWarChessAction.FinishTask(slot1.taskID, function ()
				manager.NewChessManager.taskManager_:DeleteTask(uv0.taskID)

				if uv0.finishevent ~= 0 then
					manager.NewChessManager:ExecutChess(NewChessConst.TIMING_TASK, nil, NewWarChessData:GetServerEvent(NewChessConst.TIMING_TASK, {
						uv0.taskID
					}))
					manager.NewChessManager:StartExecuteEvent()
				end

				manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
				uv1:MoveNext()
			end)
		else
			slot0:MoveNext()
		end

		return
	end

	slot0:Dispose()
end

function CheckTaskIterator.Dispose(slot0)
	manager.NewChessManager:CloseBlock()

	slot0.curTaskIndex = 0
	slot0.curTaskList = 0

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

slot0 = singletonClass("NewChessTaskManager")

function slot0.Ctor(slot0)
	slot0.activeTaskList_ = {}
end

function slot0.SetServerData(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot7 = NewWarChessTaskPoolCfg[slot6.taskID]
		slot0.activeTaskList_[slot6.taskID] = {
			taskID = slot6.taskID,
			type = slot7.type,
			conditionType = slot7.condition_type,
			need = slot7.need,
			cur = slot6.progress,
			clickevent = slot7.clickevent,
			finishevent = slot7.finishevent
		}
	end
end

function slot0.AddNewTask(slot0, slot1)
	slot2 = NewWarChessTaskPoolCfg[slot1]
	slot0.activeTaskList_[slot1] = {
		cur = 0,
		taskID = slot1,
		type = slot2.type,
		conditionType = slot2.condition_type,
		need = slot2.need,
		clickevent = slot2.clickevent,
		finishevent = slot2.finishevent
	}

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

function slot0.UpdateTask(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.activeTaskList_) do
		if slot7.conditionType == slot1 then
			slot7.cur = slot7.cur + slot2
		end
	end

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATETASK)
end

function slot0.DeleteTask(slot0, slot1)
	slot0.activeTaskList_[slot1] = nil
end

function slot0.GetTaskList(slot0)
	return slot0.activeTaskList_
end

function slot0.GetTaskInfo(slot0, slot1)
	return slot0.activeTaskList_[slot1]
end

function slot0.CheckTask(slot0)
	CheckTaskIterator.New():MoveNext()
end

function slot0.Dispose(slot0)
	slot0.activeTaskList_ = {}
end

return slot0
