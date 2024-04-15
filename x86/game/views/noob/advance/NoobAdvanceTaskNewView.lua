slot1 = class("NoobAdvanceTaskNewView", import("game.views.noob.advance.NoobAdvanceTaskView"))

function slot1.UIName(slot0)
	return "Widget/System/Activitynewbie/NewbieAdvanceTaskUI_new"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.uiTreeGo_)
	slot0.taskList_ = LuaList.New(handler(slot0, slot0.IndexTaskItem), slot0.uiListGo_, NoobAdvanceTaskItem)
	slot0.conditionList_ = {}
	slot0.allReceiveBtnState_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
	slot0.progressController_ = slot0.controllerExcollection_:GetController("progress")
end

function slot1.UpdateNextType(slot0)
	slot0.curTaskTypeCfg_ = ActivityNewbieTools.GetAdvanceTaskCfg(slot0.taskType_)
	slot0.nextTypeIndex_ = slot0.curTaskTypeCfg_.index + 1
	slot0.nextType_ = NoobVersionCfg[slot0.curTaskTypeCfg_.versionID].noob_advance_task_type[slot0.nextTypeIndex_]
end

function slot1.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot1, slot2 = ActivityNewbieTools.CheckAdvanceTaskOpen()

	if slot0.taskType_ ~= slot2 then
		slot0.taskType_ = slot2

		slot0:UpdateNextType()

		if getData("noobAdvanceTask", string.format("need_level_enough_tips_%s", slot0.taskType_)) == 1 == true then
			ShowTips("NOOB_ADVANCE_TASK_LEVEL_ENOUGH")
			saveData("noobAdvanceTask", string.format("need_level_enough_tips_%s", slot0.taskType_), 0)
		end

		slot0:GreatTree()
	end

	if slot0.params_.isEnter == true then
		slot3, slot4 = slot0:GetSelectIndex()

		slot0.tree_:SelectItem(slot3, slot4)

		slot0.params_.isEnter = false
	elseif slot0.params_.groupIndex and slot0.params_.itemIndex then
		slot0.tree_:SelectItem(slot0.params_.groupIndex, slot0.params_.itemIndex)
	else
		slot0.tree_:SelectItem(1, 1)
	end

	slot0:RefreshUI()

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	slot0:BindRedPoint()
end

function slot1.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)

	slot0.params_.groupIndex = slot0.curSelectedGroupIndex_
	slot0.params_.itemIndex = slot0.curSelectedItemIndex_
	slot0.curSlectedItemID_ = nil

	slot0:UnbindRedPoint()
end

function slot1.OnTop(slot0)
	if slot0.needShowTips_ then
		slot0.needShowTips_ = false

		ShowTips(slot0.tipsStr_)
	end
end

function slot1.RefreshUI(slot0)
	slot0:RefreshProgress()
end

function slot1.RefreshProgress(slot0)
	if slot0.nextType_ then
		slot4 = slot0.nextTypeIndex_
		slot0.nextTypeTitle_.text = GetTips(NoobVersionCfg[slot0.curTaskTypeCfg_.versionID].noob_advance_task_title[slot4])

		for slot4 = 1, 2 do
			if not slot0.conditionList_[slot4] then
				slot0.conditionList_[slot4] = NoobAdvanceConditionItem.New(Object.Instantiate(slot0.conditionItemGo_, slot0.conditionContent_))
			end

			slot0.conditionList_[slot4]:SetData(slot4, slot0.taskType_, slot0.nextTypeIndex_)
		end
	end

	slot0.curTypeTitle_.text = GetTips(NoobVersionCfg[slot0.curTaskTypeCfg_.versionID].noob_advance_task_title[slot0.curTaskTypeCfg_.index])

	slot0.progressController_:SetSelectedState(tostring(slot0.curTaskTypeCfg_.index))
end

function slot1.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.conditionList_) do
		slot5:Dispose()
	end

	slot0.conditionList_ = nil

	uv0.super.Dispose(slot0)
end

function slot1.OnTaskUpdate(slot0)
	slot1 = false

	if TaskTools:IsCompletedAllNoobAdvanceTask(slot0.taskType_) then
		slot2 = true

		if slot0.nextType_ then
			if NoobVersionCfg[slot0.curTaskTypeCfg_.versionID].noob_advance_task_open[slot0.nextTypeIndex_] <= PlayerData:GetPlayerInfo().userLevel then
				slot1 = true
				slot2 = true
			else
				slot2 = false

				saveData("noobAdvanceTask", string.format("need_level_enough_tips_%s", slot0.nextType_), 1)
			end
		end

		if slot2 then
			slot0.needShowTips_ = true
			slot0.tipsStr_ = string.format(GetTips("NOOB_ADVANCE_TASK_COMPLETE"), GetTips(NoobVersionCfg[slot3].noob_advance_task_title[slot0.curTaskTypeCfg_.index]))
		else
			slot0.needShowTips_ = true
			slot0.tipsStr_ = string.format(GetTips("NOOB_ADVANCE_TASK_LEVEL_NOTENOUGH"), slot6)
		end
	end

	if not slot1 then
		slot0.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(slot0.taskType_, slot0.curSlectedItemID_)

		slot0.taskList_:StartScroll(#slot0.taskDataList_)
		slot0:RefreshReceiveBtn()
	else
		slot0:UnbindRedPoint()

		slot0.taskType_ = slot0.nextType_

		slot0:UpdateNextType()
		slot0:GreatTree()
		slot0:BindRedPoint()

		slot2, slot3 = slot0:GetSelectIndex()
		slot0.curSlectedItemID_ = nil

		slot0.tree_:SelectItem(slot2, slot3)
		slot0:RefreshProgress()
	end
end

return slot1
