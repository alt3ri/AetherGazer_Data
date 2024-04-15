slot0 = class("ChapterPlot19RewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/Chapter19SectionRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, ChapterPlot19RewardPanel)
	slot0.OnSubmitTaskHandler_ = handler(slot0, slot0.OnSubmitTask)
end

function slot0.OnEnter(slot0)
	slot0.chapterID_ = tonumber(slot0.params_.chapterID)
	slot0.taskIDList_ = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]

	slot0.uiList_:StartScroll(#AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19], slot0:GetSortIndex())
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.OnSubmitTaskHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.OnSubmitTaskHandler_)
end

function slot0.Dispose(slot0)
	slot0.OnSubmitTaskHandler_ = nil

	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.taskIDList_[slot1])
end

function slot0.OnSubmitTask(slot0)
	slot0.uiList_:Refresh()
end

function slot0.GetSortIndex(slot0)
	for slot4, slot5 in ipairs(slot0.taskIDList_) do
		if AssignmentCfg[slot5].need <= TaskData2:GetTaskProgress(slot5) and not TaskData2:GetTaskComplete(slot5) then
			return slot4
		end
	end

	for slot4, slot5 in ipairs(slot0.taskIDList_) do
		if TaskData2:GetTaskProgress(slot5) < AssignmentCfg[slot5].need then
			return slot4
		end
	end

	return 1
end

return slot0
