ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityNewWarChessMainView", ActivityMainBasePanel)
slot1 = "ACTIVITY_NEW_WARCHESS_DESCRIBE"

function slot0.GetUIName(slot0)
	if slot0.activityID_ == ActivityConst.ACTIVITY_NEWWARCHESS_2_6 then
		return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionNewWarChessUI"
	elseif slot0.activityID_ == ActivityConst.ACTIVITY_2_10_NEWWARCHESS then
		return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10NewWarChessUI"
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.taskListModule = CommonActivityTaskListModule.New(slot0.taskPanelTrans_.gameObject)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = NewChessTools.GetNewWarChessGameSetting("new_warchess_describe", NewWarChessData:GetCurrentMainActivity())
		})
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityNewWarChessRewardView", {
			mainActivityID = uv0.activityID_,
			activityIDList = ActivityCfg[uv0.activityID_].sub_activity_list
		})
	end)
	slot0:AddBtnListener(slot0.levelBtn_, nil, function ()
		manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. uv0.activityID_, 0)
		JumpTools.OpenPageByJump("/newWarChessLevelView", {
			ActivityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.taskListModule:OnEnter()
	slot0:RefreshUI()
	slot0:BindRedPoint()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.levelBtn_.transform, RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. slot0.activityID_)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. slot0.activityID_)
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.levelBtn_.transform, RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. slot0.activityID_)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.NEW_WARCHESS_EXPROLE_REWARD .. "_" .. slot0.activityID_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTime()
	slot0:RefreshTask()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTime(slot0)
	slot0.activityID_ = slot0.activityID_
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	if manager.time:GetServerTime() < slot0.stopTime_ then
		slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
	else
		slot0:StopTimer()

		slot0.timeText_.text = GetTips("TIME_OVER")
	end

	slot0.timer_ = Timer.New(function ()
		if manager.time:GetServerTime() < uv0.stopTime_ then
			uv0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(uv0.stopTime_)
		else
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RefreshTask(slot0)
	slot0.taskListModule:RenderView(slot0.activityID_)
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0:RefreshTask()
	end
end

function slot0.UpdateBar(slot0)
	slot1 = {}
	slot5 = ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE

	for slot5, slot6 in pairs(ItemCfg.get_id_list_by_sub_type[slot5]) do
		if ItemCfg[slot6].time[2][1] == slot0.activityID_ then
			table.insert(slot1, slot6)
		end
	end

	slot2 = {
		BACK_BAR,
		HOME_BAR
	}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	slot6 = slot2

	manager.windowBar:SwitchBar(slot6)

	for slot6, slot7 in pairs(slot1) do
		manager.windowBar:SetBarCanAdd(slot7, true)
	end
end

function slot0.OnExit(slot0)
	slot0.taskListModule:OnExit()
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:UnBindRedPoint()
end

function slot0.Dispose(slot0)
	slot0.taskListModule:Dispose()
	slot0:StopTimer()
	slot0:RemoveAllListeners()

	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
