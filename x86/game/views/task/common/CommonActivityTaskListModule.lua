slot0 = class("CommonActivityTaskListModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.InitContext(slot0)
	slot0.constVar = {
		taskList = {},
		scrollHelper = LuaList.New(handler(slot0, slot0.OnRenderTask), slot0.taskList_, CommonActivityTaskItem)
	}
end

function slot0.BuildContext(slot0)
	slot0.renderContext = {
		activityId = 0
	}
	slot0.constVar.taskList = {}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitContext()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.oneKeyBtn_, nil, function ()
		uv0:OnOnceBtnClick()
	end)
end

function slot0.RegisterTaskListChangedEvent(slot0, slot1)
	slot0.constVar.changeEvent = slot1
end

function slot0.RenderView(slot0, slot1)
	slot0:BuildContext()

	slot0.renderContext.activityId = slot1
	slot2 = TaskData2:GetActivityTaskSortList(slot1)
	slot0.constVar.taskList = slot2
	slot0.renderContext.taskCount = #slot2

	slot0.constVar.scrollHelper:StartScroll(slot0.renderContext.taskCount, 1)
	slot0:ShowOnce()
end

function slot0.RefreshView(slot0)
	slot0:RenderView(slot0.renderContext.activityId)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function ()
		uv0:RefreshView()
		uv0:OnTaskListChanged()
	end)
	slot0:RegistEventListener(ON_TASK_SUBMIT_LIST_RESPONSE, function ()
		uv0:RefreshView()
		uv0:OnTaskListChanged()
	end)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	slot0.constVar.scrollHelper:Dispose()
end

function slot0.OnRenderTask(slot0, slot1, slot2)
	slot2:RefreshTaskItem(slot0.constVar.taskList[slot1].id)
end

function slot0.OnTaskListChanged(slot0)
	if slot0.constVar.changeEvent then
		slot1()
	end
end

function slot0.ShowOnce(slot0)
	for slot5, slot6 in ipairs(slot0.constVar.taskList) do
		if AssignmentCfg[slot6.id].need <= TaskData2:GetTaskProgress(slot6.id) and not TaskData2:GetTaskComplete(slot6.id) then
			slot1 = 0 + 1
		end
	end

	SetActive(slot0.oneKeyObj_, slot1 > 0)
end

function slot0.OnOnceBtnClick(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.constVar.taskList) do
		if AssignmentCfg[slot6.id].need <= TaskData2:GetTaskProgress(slot6.id) and not TaskData2:GetTaskComplete(slot6.id) then
			table.insert(slot1, slot6.id)
		end
	end

	if #slot1 > 0 then
		TaskAction:SubmitTaskList(slot1)
	end
end

return slot0
