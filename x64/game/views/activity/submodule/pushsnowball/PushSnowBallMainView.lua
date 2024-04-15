slot0 = class("PushSnowBallMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.GetActivityID(slot0)
	return PushSnowBallData:GetActivityID()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.signalBtn_, nil, function ()
		if uv0:IsActivityTime() then
			PushSnowBallData:SetGoViewStr("/pushSnowBallSingle")
			DormMinigame.Launch("HZ07_tuanxue1")
		end
	end)
	slot0:AddBtnListener(slot0.teamBtn_, nil, function ()
		if uv0:IsActivityTime() then
			PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
			DormMinigame.Launch("HZ07_tuanxue1")
		end
	end)
	slot0:AddBtnListener(slot0.tutorialBtn_, nil, function ()
		if uv0:IsActivityTime() then
			JumpTools.OpenPageByJump("pushSnowBallTutorial")
		end
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SNOWBALL_PUSH_DESC_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_1")
		})
	end)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.signalBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID()))
	manager.redPoint:bindUIandKey(slot0.teamBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID()))
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = PushSnowBallData:GetActivityID()
	slot1 = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime

	if not getData("PushSnowBall", "pop" .. PlayerData:GetPlayerInfo().userID) and slot0:IsActivityTime() then
		JumpTools.OpenPageByJump("pushSnowBallTutorial")
		saveData("PushSnowBall", "pop" .. PlayerData:GetPlayerInfo().userID, true)
	end

	slot0:AddTimer()
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()
	slot0:RefreshTimeText()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			return
		end

		uv0:RefreshTimeText()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTimeText(slot0)
	if slot0.timeText_ then
		slot0.timeText_.text = manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	end
end

function slot0.IsActivityTime(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot0.startTime_, nil, true)))

		return false
	end

	if slot0.stopTime_ <= manager.time:GetServerTime() then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.signalBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetSingleActivityID()), PushSnowBallData:GetSingleActivityID()))
	manager.redPoint:unbindUIandKey(slot0.teamBtn_.transform, string.format("%s_%s", ActivityTools.GetRedPointKey(PushSnowBallData:GetTeamActivityID()), PushSnowBallData:GetTeamActivityID()))
	slot0:StopTimer()
	manager.windowBar:HideBar()
end

return slot0
