slot0 = class("HeroClueTaskView", ReduxView)

function slot0.UIName(slot0)
	return HeroClueTools.GetTaskViewUIName(slot0.params_.activtiyID)
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, HeroClueTaskItem)
	slot0.taskUpdateHandler_ = handler(slot0, slot0.UpdateData)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.taskActivityID_ = slot0.params_.activityID
	slot0.mainActivityID_ = slot0.params_.mainActivityID

	slot0:RefreshUI()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.taskDataList_ = TaskData2:GetActivityTaskSortList(slot0.taskActivityID_)

	slot0.scrollHelper_:StartScroll(#slot0.taskDataList_)

	slot1 = #slot0.taskDataList_

	for slot6, slot7 in ipairs(slot0.taskDataList_) do
		if AssignmentCfg[slot7.id].need <= slot7.progress and TaskData2:GetTaskComplete(slot8) then
			slot2 = 0 + 1
		end
	end

	slot0.progressText_.text = string.format("%s/%s", slot2, slot1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList_[slot1].id, slot0.taskActivityID_)
end

function slot0.UpdateData(slot0)
	slot0:RefreshUI()
	HeroClueAction.UpdateDrawRedPoint(slot0.mainActivityID_)
end

return slot0
