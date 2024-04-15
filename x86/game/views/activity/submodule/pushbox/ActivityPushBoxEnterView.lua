ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityPushBoxEnterView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10AnniversaryMainUI"
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if "ACTIVITY_PUSH_BOX_DESC" ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(slot0),
				key = slot0
			})
		end
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if uv0.activityData_:IsActivitying() then
			JumpTools.OpenPageByJump("/activityPushBoxMain", {
				activityID = uv0.activityID_
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:BindRedPointUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshTime()
end

function slot0.RefreshData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			if uv0.startTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot1 < slot0.stopTime_ then
		slot0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			if uv0.stopTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end

			uv0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv0.stopTime_)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. slot0.activityID_)
end

function slot0.UnbindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, RedPointConst.ACTIVITY_PUSH_BOX .. "_" .. slot0.activityID_)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:UnbindRedPointUI()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
