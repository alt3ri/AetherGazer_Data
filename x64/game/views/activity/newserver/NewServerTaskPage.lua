slot0 = class("NewServerTaskPage", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("Widget/System/NewServer/NewServerQuestListUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.taskTypeList_ = {
		TaskConst.TASK_TYPE.NEW_SERVER_DAILY,
		TaskConst.TASK_TYPE.NEW_SERVER_WEEK,
		TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE
	}
	slot0.clickItemHandler_ = handler(slot0, slot0.SwitchPage)
	slot0.switchItemList_ = {}

	for slot5 = 1, slot0.switchPanelTrans_.childCount do
		slot0.switchItemList_[slot5] = NewServerTaskSwitchItem.New(slot0.switchPanelTrans_:GetChild(slot5 - 1).gameObject, slot0.taskTypeList_[slot5])

		slot0.switchItemList_[slot5]:SetClickCallBack(slot0.clickItemHandler_)
	end

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, NewServerTaskItem)
	slot0.allReceiveBtnState_ = slot0.controllerEx_:GetController("allReceive")
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0.activityID_) then
			return
		end

		TaskAction:SubmitTaskList(TaskTools:GetFinishTaskIds(uv0.taskType_), uv0.taskType_)
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.switchItemList_[1].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	manager.redPoint:bindUIandKey(slot0.switchItemList_[2].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	manager.redPoint:bindUIandKey(slot0.switchItemList_[3].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[1].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_DAILY))
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[2].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_WEEK))
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[3].transform_, string.format("%s_%s", RedPointConst.ACTIVITY_NEW_SERVER_TASK, TaskConst.TASK_TYPE.NEW_SERVER_CHALLENGE))
	ActivityNewServerTools.SetLastTaskScrollPos(slot0.itemList_:GetScrolledPosition())

	slot0.taskType_ = nil
end

function slot0.SetIsBack(slot0, slot1)
	slot0.isBack_ = slot1
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1

	if not slot0.isBack_ then
		slot0:SwitchPage(slot0.taskTypeList_[1])
	else
		slot0.isBack_ = false
		slot0.targetScrollPos_ = ActivityNewServerTools.GetLastTaskScrollPos()

		slot0:SwitchPage(ActivityNewServerTools.GetLastSelectTaskType())
	end
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.taskType_ == slot1 then
		return
	end

	slot0.taskType_ = slot1

	ActivityNewServerTools.SetLastSelectTaskType(slot0.taskType_)

	slot0.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(slot0.taskType_)
	slot5 = slot0.taskType_
	slot0.finishList_ = TaskTools:GetFinishTaskIds(slot5)
	slot0.maxRewardNum_ = 0

	for slot5, slot6 in ipairs(slot0.taskIDList_) do
		if not AssignmentCfg[slot6.id] then
			print(slot7)
		else
			slot0.maxRewardNum_ = slot0.maxRewardNum_ < #AssignmentCfg[slot7].reward and slot8 or slot0.maxRewardNum_
		end
	end

	if slot0.targetScrollPos_ then
		slot0.itemList_:StartScrollByPosition(#slot0.taskIDList_, slot0.targetScrollPos_)

		slot0.targetScrollPos_ = nil
	else
		slot0.itemList_:StartScroll(#slot0.taskIDList_)
	end

	slot0:RefreshRecivedAll()
	slot0:RefreshSelect()
end

function slot0.Refresh(slot0)
	slot0.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(slot0.taskType_)
	slot0.finishList_ = TaskTools:GetFinishTaskIds(slot0.taskType_)

	slot0.itemList_:Refresh()
	slot0:RefreshRecivedAll()
end

function slot0.RefreshRecivedAll(slot0)
	slot0.allReceiveBtnState_:SetSelectedState(#slot0.finishList_ > 0 and "true" or "false")
end

function slot0.RefreshSelect(slot0)
	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:RefreshSelect(slot0.taskType_)
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskIDList_[slot1].id, slot0.maxRewardNum_)
end

function slot0.Dispose(slot0)
	slot0.itemList_:Dispose()

	slot0.itemList_ = nil

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:Dispose()
	end

	slot0.switchItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshScroll(slot0)
	slot0.taskIDList_ = TaskData2:GetTypedTaskSortListCommonFilter(slot0.taskType_)

	slot0.itemList_:StartScrollWithoutAnimator(#slot0.taskIDList_, slot0.itemList_:GetScrolledPosition())
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshScroll()

	slot0.finishList_ = TaskTools:GetFinishTaskIds(slot0.taskType_)

	slot0:RefreshRecivedAll()
end

return slot0
