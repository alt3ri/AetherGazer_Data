slot0 = class("ActivityPushBoxRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryQuestPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.clearCon_ = ControllerUtil.GetController(slot0.transform_, "clear")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityPushBoxRewardItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.list_) do
			if slot5.complete_flag == 0 and AssignmentCfg[slot5.id].need <= slot5.progress then
				table.insert(slot0, slot6)
			end
		end

		TaskAction:SubmitTaskList(slot0)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.taskActivityID_ = ActivityConst.ACTIVITY_2_10_PUSH_BOX_TASK

	slot0:RefreshTask()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshTask))
end

function slot0.RefreshTask(slot0)
	slot0.list_ = TaskData2:GetActivityTaskSortList(slot0.taskActivityID_)

	slot0.scrollHelper_:StartScroll(#slot0.list_)

	if slot0.list_[1] then
		if slot1.complete_flag == 0 and AssignmentCfg[slot1.id].need <= slot1.progress then
			slot0.clearCon_:SetSelectedState("true")
		else
			slot0.clearCon_:SetSelectedState("false")
		end
	else
		slot0.clearCon_:SetSelectedState("false")
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
