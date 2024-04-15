slot0 = class("StrategyMatrixRwardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatriRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.taskUpdateHandler_ = handler(slot0, slot0.RefreshScroll)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, StrategyMatrixRwardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.taskType_ = TaskConst.TASK_TYPE.STRATEGY_MATRIX
	slot0.activity_id = slot0.params_.task_activity_id
	slot0._taskIDList = TaskData2:GetActivityTaskSortList(slot0.activity_id)

	slot0.list:StartScroll(#slot0._taskIDList)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.RefreshScroll(slot0)
	slot0._taskIDList = TaskData2:GetActivityTaskSortList(slot0.activity_id)

	slot0.list:StartScrollWithoutAnimator(#slot0._taskIDList, slot0.list:GetScrolledPosition())
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0._taskIDList[slot1])
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()

	slot0.taskUpdateHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshScroll()
end

return slot0
