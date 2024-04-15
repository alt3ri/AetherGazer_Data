slot0 = class("CombineGameTaskView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRewardsUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, CombineGameTaskItem)
	slot0.rewardController = ControllerUtil.GetController(slot0.gameObject_.transform, "reward")
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.taskList[slot1], slot0.activityId)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.allGetBtn_, nil, function ()
		if #TaskTools:GetCanGetActivityTaskList(uv0.activityId) <= 0 then
			return
		end

		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			table.insert(slot1, slot6.id)
		end

		TaskAction:SubmitTaskList(slot1)
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	if not ActivityData:GetActivityIsOpen(CombineGameData:GetDataByPara("activityId")) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	slot0.activityId = ActivityConst.SPRING_FESTIVAL_ACTIVITY_V2_COMBINE_GAME_TASK

	slot0:AddEventListeners()
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.taskList = {}

	table.insertto(slot0.taskList, AssignmentCfg.get_id_list_by_activity_id[slot0.activityId], 1)
	table.sort(slot0.taskList, function (slot0, slot1)
		if uv0:GetTaskStatus(slot0) ~= uv0:GetTaskStatus(slot1) then
			return slot2 < slot3
		end

		if AssignmentCfg[slot0].type ~= AssignmentCfg[slot1].type then
			return slot4.type < slot5.type
		end

		return slot4.id < slot5.id
	end)
	slot0.list:StartScroll(#slot0.taskList)
	slot0.rewardController:SetSelectedState(#TaskTools:GetCanGetActivityTaskList(slot0.activityId) > 0 and "true" or "false")
end

function slot0.GetTaskStatus(slot0, slot1)
	slot2 = AssignmentCfg[slot1]

	if not TaskData2:GetTask(slot1) then
		return 0
	end

	slot4 = slot3.progress

	if slot3 ~= nil and TaskData2:GetTaskComplete(slot1) then
		return 3
	elseif slot2.need <= slot4 then
		return 1
	else
		return 2
	end
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnbindRedPoint(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, function ()
		uv0:UpdateView()
	end)
end

function slot0.OnExit(slot0)
	slot0:UnbindRedPoint()
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
