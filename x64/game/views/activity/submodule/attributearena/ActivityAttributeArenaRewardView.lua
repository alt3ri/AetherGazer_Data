slot0 = class("ActivityAttributeArenaRewardView", ReduxView)

function slot0.UIName(slot0)
	return AttributeArenaTools.GetRewardUI(slot0.params_.task_activity_id)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.taskUpdateHandler_ = handler(slot0, slot0.RefreshScroll)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, ActivityAttributeArenaRewardItem)
	slot0.recevieAllController = ControllerUtil.GetController(slot0.transform_, "recevieAll")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_recevieBtn, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0._taskIDList) do
			if slot5.progress < AssignmentCfg[slot5.id].need or slot5.complete_flag >= 1 then
				break
			end

			slot0[#slot0 + 1] = slot5.id
		end

		TaskAction:SubmitTaskList(slot0)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.task_activity_id
	slot0._taskIDList = TaskData2:GetActivityTaskSortList(slot0.activity_id)

	slot0.list:StartScroll(#slot0._taskIDList)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	slot0:RefreshReceiveBtn()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.RefreshScroll(slot0)
	slot0._taskIDList = TaskData2:GetActivityTaskSortList(slot0.activity_id)

	slot0.list:StartScrollWithoutAnimator(#slot0._taskIDList, slot0.list:GetScrolledPosition())
	slot0:RefreshReceiveBtn()
end

function slot0.RefreshReceiveBtn(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0._taskIDList) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
			slot1 = 1

			break
		end
	end

	slot0.recevieAllController:SetSelectedIndex(slot1 == 1 and 1 or 0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0._taskIDList[slot1], slot1)
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
