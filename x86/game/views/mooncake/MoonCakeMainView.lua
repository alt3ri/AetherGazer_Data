slot0 = class("MoonCakeMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeMainUI"
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.makeFillingBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectMakeFillingBtn(uv0.activityID_)
		MoonCakeAction.UpdateFillingMakeRedPoint(uv0.activityID_)
		JumpTools.OpenPageByJump("moonFillingMake", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.makeMoonCakeBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectMakeCakeBtn(uv0.activityID_)
		MoonCakeAction.UpdateCakeMakeRedPoint(uv0.activityID_)
		JumpTools.OpenPageByJump("moonCakeMake", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.bagBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/moonCakeBag", {
			activityID = uv0.activityID_,
			mainActivityID = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.delegateBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.RefreshRecommendDelegate(uv0.activityID_, function ()
			JumpTools.OpenPageByJump("moonCakeDelegate", {
				activityID = uv0.activityID_
			})
		end)
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeTask", {
			stage = 1,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityID_ = slot0.params_.activityID
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:AddTimer()
	slot0:RefreshUI()
	slot0:BindRedPoint()
end

function slot0.OnTop(slot0)
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

function slot0.RefreshUI(slot0)
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.remainTimeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)

	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.remainTimeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.makeFillingBtn_.transform, string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.makeMoonCakeBtn_.transform, string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.bagBtn_.transform, string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.delegateBtn_.transform, string.format("%s_%s", RedPointConst.MOON_DELEGATE, slot0.activityID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.makeFillingBtn_.transform, string.format("%s_%s", RedPointConst.MOON_FILLING_MAKE, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.makeMoonCakeBtn_.transform, string.format("%s_%s", RedPointConst.MOON_CAKE_MAKE, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.bagBtn_.transform, string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.delegateBtn_.transform, string.format("%s_%s", RedPointConst.MOON_DELEGATE, slot0.activityID_))
end

return slot0
