ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityReforgeMainView", ActivityMainBasePanel)
slot1 = "ACTIVITY_REFORGE_GAMEHELPKEY"

function slot0.GetUIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeMainUI"
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeChapterView", {
			ActivityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(uv0),
			key = uv0
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:BindRedPoint()
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnBindRedPoint(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTime()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTime(slot0)
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

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:UnBindRedPoint()
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
