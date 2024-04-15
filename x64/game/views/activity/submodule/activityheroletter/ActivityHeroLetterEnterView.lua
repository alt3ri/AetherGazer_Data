ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("ActivityHeroLetterEnterView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return ActivityHeroLetterTools.GetEnterUIName(slot0.activityID_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityHeroLetter", {
			isEnter = true,
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		if ActivityHeroLetterTools.GetHelpKey(uv0.activityID_) ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(slot0),
				key = slot0
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

	slot0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		uv0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.goBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. slot0.activityID_)
end

function slot0.UnbindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.goBtn_.transform, RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. slot0.activityID_)
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
