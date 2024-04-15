slot0 = class("CommonTaskListModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.InitContext(slot0)
	slot0.constVar = {
		taskList = {},
		scrollHelper = LuaList.New(handler(slot0, slot0.OnRenderTask), slot0.m_list, CommonTaskItemModule)
	}
	slot0.RenderType = {
		Type = 2,
		Activity = 1,
		OriginTask = 3,
		None = 0
	}
end

function slot0.BuildContext(slot0)
	slot0.renderContext = {
		taskCount = 0,
		activityId = 0,
		taskType = 0,
		renderType = slot0.RenderType.None
	}
	slot0.constVar.taskList = {}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitContext()
end

function slot0.RegisterTaskListChangedEvent(slot0, slot1)
	slot0.constVar.changeEvent = slot1
end

function slot0.RenderActivityTaskList(slot0, slot1)
	slot0:BuildContext()

	slot0.renderContext.renderType = slot0.RenderType.Activity
	slot0.renderContext.activityId = slot1
	slot2 = TaskData2:GetActivityTaskSortList(slot1)
	slot0.constVar.taskList = slot2
	slot0.renderContext.taskCount = #slot2

	slot0:RenderView()
end

function slot0.RenderTypeTaskList(slot0, slot1)
	slot0:BuildContext()

	slot0.renderContext.renderType = slot0.RenderType.Type
	slot0.renderContext.taskType = slot1
	slot2 = TaskData2:GetTypedTaskSortList(slot1)
	slot0.constVar.taskList = slot2
	slot0.renderContext.taskCount = #slot2

	slot0:RenderView()
end

function slot0.RenderView(slot0)
	slot0.constVar.scrollHelper:StartScroll(slot0.renderContext.taskCount, 1)
end

function slot0.RefreshView(slot0)
	if slot0.renderContext.renderType == slot0.RenderType.Type then
		slot0:RenderTypeTaskList(slot0.renderContext.taskType)
	elseif slot0.renderContext.renderType == slot0.RenderType.Activity then
		slot0:RenderActivityTaskList(slot0.renderContext.activityId)
	end
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
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	slot0.constVar.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnRenderTask(slot0, slot1, slot2)
	slot2:RefreshTaskItem(slot0.constVar.taskList[slot1].id)
end

function slot0.OnTaskListChanged(slot0)
	if slot0.constVar.changeEvent then
		slot1()
	end
end

return slot0
