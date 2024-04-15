slot0 = class("ActivitySkinDrawTaskView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetTaskUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivitySkinDrawTaskItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1], slot0.activityID_)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		slot0 = {}
		slot1 = ActivitySkinDrawTools.GetTaskActivityID(uv0.activityID_)

		for slot5, slot6 in ipairs(uv0.list_) do
			if TaskData2:GetTask(slot6).complete_flag < 1 and AssignmentCfg[slot6].need <= slot8.progress then
				table.insert(slot0, slot6)
			end
		end

		TaskAction:SubmitTaskList(slot0)
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshTask))
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTask()
end

function slot0.RefreshTask(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.taskActivityID_ = slot0.params_.taskActivityID
	slot0.list_ = {}

	function slot2(slot0, slot1)
		if AssignmentCfg[slot0].type ~= AssignmentCfg[slot1].type then
			return slot2.type < slot3.type
		end

		return slot0 < slot1
	end

	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in pairs(TaskTools:GetActivityTaskList(slot0.taskActivityID_) or {}) do
		taskID = slot10.id

		if AssignmentCfg[taskID].activity_id == slot0.taskActivityID_ then
			if slot10.complete_flag >= 1 then
				table.insert(slot5, taskID)
			elseif slot11.need <= slot10.progress then
				table.insert(slot3, taskID)
			else
				table.insert(slot4, taskID)
			end
		end
	end

	table.sort(slot3, slot2)
	table.sort(slot4, slot2)
	table.sort(slot5, slot2)
	table.insertto(slot0.list_, slot3)
	table.insertto(slot0.list_, slot4)
	table.insertto(slot0.list_, slot5)
	slot0.scrollHelper_:StartScroll(#slot0.list_)

	if #slot3 > 0 then
		slot0.typeCon_:SetSelectedState("true")
	else
		slot0.typeCon_:SetSelectedState("false")
	end
end

function slot0.OnTop(slot0)
	slot1 = {
		BACK_BAR,
		HOME_BAR
	}
	slot2 = ActivitySkinDrawTools.GetTaskCurrency(slot0.activityID_)

	table.insertto(slot1, slot2)

	slot6 = slot1

	manager.windowBar:SwitchBar(slot6)

	for slot6, slot7 in ipairs(slot2) do
		manager.windowBar:SetBarCanAdd(slot7, true)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
