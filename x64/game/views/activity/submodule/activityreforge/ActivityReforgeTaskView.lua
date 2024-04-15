slot0 = class("ActivityReforgeTaskView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = slot0.controllerEx_:GetController("isShow")
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityReforgeTaskItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskList_[slot1].id)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshView()
	slot0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function ()
		uv0:RefreshView()
	end)
	slot0:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function ()
		uv0:RefreshView()
	end)
end

function slot0.RefreshView(slot0)
	slot0.taskList_ = TaskData2:GetActivityTaskSortList(slot0.activityID_)

	slot0.list_:StartScroll(#slot0.taskList_)

	slot1 = {}

	for slot5, slot6 in ipairs(slot0.taskList_) do
		if AssignmentCfg[slot6.id].need <= TaskData2:GetTaskProgress(slot6.id) and not TaskData2:GetTaskComplete(slot6.id) then
			table.insert(slot1, slot6.id)
		end
	end

	if #slot1 > 0 then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.taskList_) do
			if AssignmentCfg[slot5.id].need <= TaskData2:GetTaskProgress(slot5.id) and not TaskData2:GetTaskComplete(slot5.id) then
				table.insert(slot0, slot5.id)
			end
		end

		if #slot0 > 0 then
			TaskAction:SubmitTaskList(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
