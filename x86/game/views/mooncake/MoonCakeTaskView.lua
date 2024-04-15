slot0 = class("MoonCakeTaskView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeTaskUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.needAdaptRight_ = true

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, MoonCakeTaskItem)
	slot0.taskUpdateHandler_ = handler(slot0, slot0.UpdateData)
	slot0.allReceiveController_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
	slot0.selectController_ = ControllerUtil.GetController(slot0.stage1PanelTrans_, "select")
	slot0.stageController_ = ControllerUtil.GetController(slot0.transform_, "stage")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot0 = {}

		for slot4, slot5 in ipairs(uv0.taskDataList_) do
			if slot5.progress < AssignmentCfg[slot5.id].need or slot5.complete_flag >= 1 then
				break
			end

			slot0[#slot0 + 1] = slot5.id
		end

		TaskAction:SubmitTaskList(slot0)
	end)
	slot0:AddBtnListener(slot0.activityTaskBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.taskType_ == 1 then
			return
		end

		uv0:RefreshUI(1)
	end)
	slot0:AddBtnListener(slot0.playTaskBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.taskType_ == 2 then
			return
		end

		uv0:RefreshUI(2)
	end)
end

function slot0.Dispose(slot0)
	slot0.taskUpdateHandler_ = nil

	slot0.scrollHelper_:Dispose()

	slot0.scrollHelper_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.stage_ = slot0.params_.stage

	slot0.stageController_:SetSelectedIndex(slot0.stage_ - 1)

	slot0.taskActivityIDList_ = ActivityCfg[slot0.activityID_].sub_activity_list

	slot0:RefreshUI(1)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	slot0.taskType_ = nil

	slot0:RemoveAllEventListener()
	slot0:UnBindRedPoint()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.taskType_ = slot1

	slot0.selectController_:SetSelectedIndex(slot1 - 1)

	slot0.taskActivityID_ = slot0.taskActivityIDList_[slot0.taskType_]
	slot0.taskDataList_ = TaskData2:GetActivityTaskSortList(slot0.taskActivityID_)

	slot0.scrollHelper_:StartScroll(#slot0.taskDataList_)
	slot0:RefreshReceiveBtn()
end

function slot0.RefreshReceiveBtn(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.taskDataList_) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
			slot1 = 1

			break
		end
	end

	slot0.allReceiveController_:SetSelectedIndex(slot1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList_[slot1].id, slot0.taskActivityID_)
end

function slot0.UpdateData(slot0)
	slot0:RefreshUI(slot0.taskType_)

	if slot0.tempReceiveTaskID_ then
		slot0.tempReceiveTaskID_ = nil
		slot0.dropRewardList_ = {}
		slot3 = {}

		for slot7, slot8 in ipairs(AssignmentCfg[slot0.tempReceiveTaskID_].reward) do
			if slot8[1] == 30051 or slot8[1] == 30052 then
				table.insert(slot3, {
					item_info = {
						id = slot8[1],
						num = slot8[2]
					},
					use_list = {}
				})
			end
		end

		CommonAction.TryToUseItem(slot3)
	end
end

function slot0.BindRedPoint(slot0)
	if slot0.stage_ == 1 then
		manager.redPoint:bindUIandKey(slot0.activityTaskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.taskActivityIDList_[1]))
		manager.redPoint:bindUIandKey(slot0.playTaskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.taskActivityIDList_[2]))
	else
		manager.redPoint:bindUIandKey(slot0.activityTaskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.taskActivityIDList_[1]))
	end
end

function slot0.UnBindRedPoint(slot0)
	if slot0.stage_ == 1 then
		manager.redPoint:unbindUIandKey(slot0.activityTaskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.taskActivityIDList_[1]))
		manager.redPoint:unbindUIandKey(slot0.playTaskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.taskActivityIDList_[2]))
	else
		manager.redPoint:unbindUIandKey(slot0.activityTaskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.taskActivityIDList_[1]))
	end
end

return slot0
