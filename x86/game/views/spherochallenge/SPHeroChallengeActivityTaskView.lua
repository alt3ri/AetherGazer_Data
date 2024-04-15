slot0 = class("SPHeroChallengeActivityTaskView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeActivityTaskPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.taskList_ = {}
	slot0.taskListModule = CommonTaskListModule.New(slot0.comTaskList_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.allBtn, nil, function ()
		TaskTools:GetAllCanReciveTaskByActivityID(uv0.params_.activityID)
	end)
end

function slot0.OnEnter(slot0)
	slot0.taskListModule:OnEnter()

	if slot0.params_.activityID then
		slot0.taskListModule:RenderActivityTaskList(slot1)
	end
end

function slot0.OnTop(slot0)
	slot0:RefreshReciveBtn()
end

function slot0.RefreshReciveBtn(slot0)
	if #TaskTools:GetCanGetActivityTaskList(slot0.params_.activityID) > 0 then
		SetActive(slot0.allBtn.gameObject, true)
	else
		SetActive(slot0.allBtn.gameObject, false)
	end
end

function slot0.OnExit(slot0)
	slot0.taskListModule:OnExit()
end

function slot0.Dispose(slot0)
	slot0.taskListModule:Dispose()
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
