ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("XH3rdWaterMainView", ActivityMainBasePanel)
slot1 = 44

function slot0.Ctor(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWaterparkUI"), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.taskActivityId_ = slot0:GetTaskActivityId()

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.oneclickController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "oneclick")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistUilist_, XH3rdWaterMainItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.assignmentIdList_[slot1], slot0:GetTaskActivityId())
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnstartBtn_, nil, function ()
		JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot1 = {}

		if #TaskTools:GetCanGetActivityTaskList(uv0.taskActivityId_) > 0 then
			for slot5, slot6 in ipairs(slot0) do
				table.insert(slot1, slot6.id)
			end
		end

		TaskAction:SubmitTaskList(slot1)
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_WATER_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_WATER_DESC")
		})
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/activityShop", {
			shopId = uv0,
			showShops = {
				uv0
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.reviewBtn_, nil, function ()
		JumpTools.OpenPageByJump("/xH3rdWaterReview", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, function ()
		uv0:UpdateList()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	if ActivityWaterData:GetCurrentSchedule(slot0.activityID_) then
		slot3 = ShopListCfg[uv0].cost_id[1]

		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			slot3
		})
		manager.windowBar:SetBarCanAdd(slot3, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function slot0.OnEnter(slot0)
	ActivityWaterAction.ReadActivityOpen()
	slot0:AddEventListeners()
	slot0:UpdateList()
	slot0:StartTimer()
	slot0:UpdateTimer()
	manager.redPoint:bindUIandKey(slot0.btnstartBtn_.transform, RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
	manager.redPoint:bindUIandKey(slot0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)

	slot1 = manager.redPoint:getTipValue(RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot0.activityID_).stopTime)

	if ActivityData:GetActivityIsOpen(slot0:GetTaskActivityId()) then
		if ActivityWaterData:IsAllScheduleOver(slot0.activityID_) then
			slot0.statusController_:SetSelectedState("scheduleOver")
			SetActive(slot0.btnstartBtn_.gameObject, false)
		else
			slot0.statusController_:SetSelectedState("open")
		end
	else
		slot0.statusController_:SetSelectedState("taskOver")
		SetActive(slot0.btnstartBtn_.gameObject, false)
	end

	if ShopListCfg[uv0] then
		slot2 = ActivityData:GetActivityData(slot3.activity_id).stopTime
		slot0.shopTimeText_.text = manager.time:GetLostTimeStrWith2Unit(slot2)

		if slot2 < manager.time:GetServerTime() then
			SetActive(slot0.shopBtn_.gameObject, false)
		else
			SetActive(slot0.shopBtn_.gameObject, true)
		end
	end
end

function slot0.IsTimeOver(slot0)
	if ActivityData:GetActivityData(slot0.activityID_).stopTime <= manager.time:GetServerTime() then
		return true
	end

	return false
end

function slot0.UpdateList(slot0)
	if slot0:IsTimeOver() or not ActivityData:GetActivityIsOpen(slot0:GetTaskActivityId()) then
		slot0.uiList_:StartScroll(0)
		slot0.oneclickController_:SetSelectedState("no")

		return
	end

	slot0.assignmentIdList_ = {}

	table.insertto(slot0.assignmentIdList_, AssignmentCfg.get_id_list_by_activity_id[slot0.taskActivityId_], 1)
	table.sort(slot0.assignmentIdList_, function (slot0, slot1)
		if uv0:GetTaskStatus(slot0) ~= uv0:GetTaskStatus(slot1) then
			return slot2 < slot3
		end

		if AssignmentCfg[slot0].type ~= AssignmentCfg[slot1].type then
			return slot4.type < slot5.type
		end

		return slot4.id < slot5.id
	end)
	slot0.uiList_:StartScroll(#slot0.assignmentIdList_)

	if #TaskTools:GetCanGetActivityTaskList(slot0.taskActivityId_) > 0 then
		slot0.oneclickController_:SetSelectedState("on")
	else
		slot0.oneclickController_:SetSelectedState("off")
	end
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

function slot0.GetTaskActivityId(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(ActivityCfg[slot0.activityID_].sub_activity_list) do
		if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
			slot1 = slot6

			break
		end
	end

	return slot1
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.btnstartBtn_.transform, RedPointConst.ACTIVITY_WATER_ENTER_GROUP)
	manager.redPoint:unbindUIandKey(slot0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	slot0:StopTimer()
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:UpdateList()
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
