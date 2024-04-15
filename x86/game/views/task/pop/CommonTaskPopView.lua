slot0 = class("CommonTaskPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/CommonTask"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.InitContext(slot0)
	slot0.constVar = {
		taskIdList = {},
		taskListModule = CommonTaskListModule.New(slot0.m_taskList)
	}
end

function slot0.BuildContext(slot0)
	slot0.data = {
		activityId = slot0.params_.activityId,
		taskType = slot0.params_.taskType
	}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:InitContext()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:BuildContext()
	slot0.constVar.taskListModule:OnEnter()

	if slot0.data.activityId then
		slot0.constVar.taskListModule:RenderActivityTaskList(slot0.data.activityId)
	elseif slot0.data.taskType then
		slot0.constVar.taskListModule:RenderTypeTaskList(slot0.data.taskType)
	end
end

function slot0.OnExit(slot0)
	slot0.constVar.taskListModule:OnExit()
end

function slot0.Dispose(slot0)
	slot0.constVar.taskListModule:Dispose()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

return slot0
