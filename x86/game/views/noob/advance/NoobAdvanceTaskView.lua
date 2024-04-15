slot0 = class("NoobAdvanceTaskView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Activitynewbie/NewbieAdvanceTaskUI_old"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.uiTreeGo_)
	slot0.taskList_ = LuaList.New(handler(slot0, slot0.IndexTaskItem), slot0.uiListGo_, NoobAdvanceTaskItem)
	slot0.taskType_ = NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_advance_task_type[1]

	slot0:GreatTree()

	slot0.noobTaskUpdateHandler_ = handler(slot0, slot0.OnTaskUpdate)
	slot0.allReceiveBtnState_ = ControllerUtil.GetController(slot0.transform_, "allReceive")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveAllBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.taskDataList_) do
			if AssignmentCfg[slot5.id].need <= slot5.progress and slot5.complete_flag < 1 then
				slot0[#slot0 + 1] = slot5.id
			else
				break
			end
		end

		TaskAction:SubmitTaskList(slot0, TaskConst.TASK_TYPE.NOOB_ADVANCE)
	end)
end

function slot0.onSubmitTaskResponse(slot0)
	slot0:OnTaskUpdate()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if slot0.params_.isEnter == true then
		slot1, slot2 = slot0:GetSelectIndex()

		slot0.tree_:SelectItem(slot1, slot2)

		slot0.params_.isEnter = false
	elseif slot0.params_.groupIndex and slot0.params_.itemIndex then
		slot0.tree_:SelectItem(slot0.params_.groupIndex, slot0.params_.itemIndex)
	else
		slot0.tree_:SelectItem(1, 1)
	end

	manager.notify:RegistListener(NEWBIE_TASK_UPDATE, slot0.noobTaskUpdateHandler_)

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_LIST_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(NEWBIE_TASK_UPDATE, slot0.noobTaskUpdateHandler_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_LIST_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)

	slot0.params_.groupIndex = slot0.curSelectedGroupIndex_
	slot0.params_.itemIndex = slot0.curSelectedItemIndex_
	slot0.curSlectedItemID_ = nil

	slot0:UnbindRedPoint()
end

function slot0.IndexTaskItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskDataList_[slot1].id, slot0.maxRewardNum_)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.curSelectedGroupIndex_ = slot1
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.curSlectedItemID_ == slot2 then
		return
	end

	slot0.curSelectedItemIndex_ = slot1
	slot0.curSlectedItemID_ = slot2
	slot8 = slot2
	slot0.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(slot0.taskType_, slot8)
	slot0.maxRewardNum_ = 0

	for slot8, slot9 in ipairs(slot0.taskDataList_) do
		slot0.maxRewardNum_ = slot0.maxRewardNum_ < #AssignmentCfg[slot9.id].reward and slot11 or slot0.maxRewardNum_
	end

	slot0.taskList_:StartScroll(#slot0.taskDataList_)
	slot0:RefreshReceiveBtn()
end

function slot0.RefreshReceiveBtn(slot0)
	for slot4, slot5 in ipairs(slot0.taskDataList_) do
		if AssignmentCfg[slot5.id].need <= slot5.progress and slot5.complete_flag < 1 then
			slot0.allReceiveBtnState_:SetSelectedState("true")

			return
		end
	end

	slot0.allReceiveBtnState_:SetSelectedState("false")
end

function slot0.Dispose(slot0)
	slot0.tree_:Dispose()

	slot0.tree_ = nil

	slot0.taskList_:Dispose()

	slot0.taskList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.GreatTree(slot0)
	slot0.tree_:SetSelectedHandler(nil, )

	slot5 = UITreeData.New()
	slot0.groupCfgList_ = NoobAdvanceTaskPhaseListCfg[NoobVersionCfg[ActivityNewbieTools.GetVersionID()].noob_advance_task_phase[ActivityNewbieTools.GetAdvanceTaskCfg(slot0.taskType_).index]].phase_list

	for slot9, slot10 in ipairs(slot0.groupCfgList_) do
		slot11 = UITreeGroupData.New()
		slot11.id = slot9
		slot11.text = GetTips(slot10[1])

		for slot16, slot17 in ipairs(slot10[2]) do
			if (slot17[3] or 0) == 0 or not SystemCfg[slot18] or SystemCfg[slot18].system_hide == 0 then
				slot19 = UITreeItemData.New()
				slot19.id = slot17[1]
				slot19.text = GetTips(slot17[2])

				slot11.itemDatas:Add(slot19)
			end
		end

		slot5.groupDatas:Add(slot11)
	end

	slot4:SetData(slot5)
	slot4:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))
end

function slot0.GetSelectIndex(slot0)
	slot1 = 1
	slot2 = 1

	for slot6, slot7 in ipairs(slot0.groupCfgList_) do
		slot1 = slot6

		for slot11, slot12 in ipairs(slot7[2]) do
			for slot17, slot18 in pairs(TaskTools:GetNoobAdvanceTaskSortList(slot0.taskType_, slot12[1])) do
				if slot18.progress < AssignmentCfg[slot18.id].need or slot18.complete_flag == 0 then
					return slot1, slot11
				end
			end
		end
	end

	return slot1, slot2
end

function slot0.OnTaskUpdate(slot0)
	slot0.taskDataList_ = TaskTools:GetNoobAdvanceTaskSortList(slot0.taskType_, slot0.curSlectedItemID_)

	slot0.taskList_:StartScroll(#slot0.taskDataList_)
	slot0:RefreshReceiveBtn()
end

function slot0.BindRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.groupCfgList_) do
		slot9 = string.format
		slot10 = "%s_%d_%d"

		manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), slot9(slot10, RedPointConst.NOOB_ADVANCE, slot0.taskType_, slot4))

		for slot9, slot10 in ipairs(slot5[2]) do
			if (slot10[3] or 0) == 0 or not SystemCfg[slot11] or SystemCfg[slot11].system_hide == 0 then
				manager.redPoint:bindUIandKey(slot0.tree_:GetItemRedPointContainerById(slot4, slot10[1]), string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, slot0.taskType_, slot4, slot10[1]))
			end
		end
	end
end

function slot0.UnbindRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.groupCfgList_) do
		slot9 = string.format
		slot10 = "%s_%d_%d"

		manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(slot4), slot9(slot10, RedPointConst.NOOB_ADVANCE, slot0.taskType_, slot4))

		for slot9, slot10 in ipairs(slot5[2]) do
			if (slot10[3] or 0) == 0 or not SystemCfg[slot11] or SystemCfg[slot11].system_hide == 0 then
				manager.redPoint:unbindUIandKey(slot0.tree_:GetItemRedPointContainerById(slot4, slot10[1]), string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, slot0.taskType_, slot4, slot10[1]))
			end
		end
	end
end

return slot0
