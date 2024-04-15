slot0 = class("MoonCakeDelegateView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeDelegateUI"
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

	slot0.ownDetailView_ = MoonOwnDelegateDetailView.New(slot0.ownDelegateViewGo_)
	slot0.recommendView_ = MoonRecommendDelegateView.New(slot0.recommendDelegateViewGo_)
	slot0.refreshController_ = ControllerUtil.GetController(slot0.transform_, "refresh")
	slot0.pageController_ = ControllerUtil.GetController(slot0.transform_, "page")
	slot0.pageConst_ = {
		recommend = 2,
		own = 1
	}
	slot0.pageBtnList_ = {
		slot0.ownDelegateBtn_,
		slot0.recommendBtn_
	}
	slot0.pageViewList_ = {
		slot0.ownDetailView_,
		slot0.recommendView_
	}
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.pageBtnList_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0.curPageIndex_ and uv0.curPageIndex_ == uv1 then
				return
			end

			uv0:SwitchPage(uv1)
		end)
	end

	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.curPageIndex_ == uv0.pageConst_.recommend then
			if uv0.leftTime_ and uv0.leftTime_ > 0 then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_PROMPT")

				return
			end

			MoonCakeAction.QueryRecommendDelegate(uv0.activityID_, function ()
				uv0:AddCdTimer()
			end)
		end
	end)
	slot0:AddBtnListener(slot0.recordBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeDelegateRecord", {
			activityID = uv0.activityID_,
			recoverType = uv0.curPageIndex_
		})
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.pageViewList_) do
		slot5:Dispose()
	end

	slot0.pageViewList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	if slot0.params_.isBack then
		slot0.params_.isBack = false
		slot0.curPageIndex_ = MoonCakeTools.GetTempDelegateViewPageIndex(slot0.activityID_) or slot0.pageConst_.own

		if slot0.curPageIndex_ == slot0.pageConst_.recommend then
			slot0.tempScrollPos_ = MoonCakeTools.GetTempDelegateViewScrollPos(slot0.activityID_)
		end
	else
		slot0.curPageIndex_ = slot0.pageConst_.own
	end

	slot0:SwitchPage(slot0.curPageIndex_)
	slot0:PageRegisterEvent()
	slot0:BindRedPoint()
	slot0:AddCdTimer()
end

function slot0.OnExit(slot0)
	MoonCakeTools.SetTempDelegateViewPageIndex(slot0.activityID_, slot0.curPageIndex_)

	if slot0.curPageIndex_ == slot0.pageConst_.recommend then
		MoonCakeTools.SetTempDelegateViewScrollPos(slot0.activityID_, slot0.pageViewList_[slot0.curPageIndex_]:GetScrollPos())
	end

	slot0.pageViewList_[slot0.curPageIndex_]:Show(false)
	slot0:StopCdTimer()
	slot0:PageRemoveEvent()
	slot0:UnBindRedPoint()
end

function slot0.SwitchPage(slot0, slot1)
	slot0.pageViewList_[slot0.curPageIndex_]:Show(false)

	slot0.curPageIndex_ = slot1

	slot0.pageViewList_[slot0.curPageIndex_]:Show(true)
	slot0.pageViewList_[slot0.curPageIndex_]:SetData(slot0.activityID_, slot0.tempScrollPos_)

	if slot0.tempScrollPos_ then
		slot0.tempScrollPos_ = nil
	end

	slot0.pageController_:SetSelectedIndex(slot0.curPageIndex_ - 1)
end

function slot0.PageRegisterEvent(slot0)
	for slot4, slot5 in pairs(slot0.pageViewList_) do
		slot5:PageRegisterEvent()
	end
end

function slot0.PageRemoveEvent(slot0)
	for slot4, slot5 in pairs(slot0.pageViewList_) do
		slot5:PageRemoveEvent()
	end
end

function slot0.OnFriendsListChange(slot0)
	if slot0.pageViewList_[slot0.curPageIndex_].OnFriendsListChange then
		slot0.pageViewList_[slot0.curPageIndex_]:OnFriendsListChange()
	end
end

function slot0.AddCdTimer(slot0)
	slot0:StopCdTimer()

	slot0.leftTime_ = MoonCakeData:GetLastRefreshDelegateTime(slot0.activityID_) + GameSetting.activity_mid_autumn_entrust_list_refresh_interval.value[1] + 1 - manager.time:GetServerTime()

	if slot0.leftTime_ <= 0 then
		return
	end

	slot0.cdTimeText_.text = slot0.leftTime_ <= slot3 and slot0.leftTime_ or slot3
	slot0.cdTimer_ = Timer.New(function ()
		uv0.leftTime_ = uv0.leftTime_ - 1
		uv0.cdTimeText_.text = uv0.leftTime_

		if uv0.leftTime_ <= 0 then
			uv0:StopCdTimer()

			return
		end
	end, 1, -1)

	slot0.cdTimer_:Start()
	slot0.refreshController_:SetSelectedState("off")
end

function slot0.StopCdTimer(slot0)
	if slot0.cdTimer_ then
		slot0.cdTimer_:Stop()

		slot0.cdTimer_ = nil
	end

	slot0.refreshController_:SetSelectedState("on")

	slot0.leftTime_ = 0
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.ownDelegateBtn_.transform, string.format("%s_%s", RedPointConst.MOON_DELEGATE, slot0.activityID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.ownDelegateBtn_.transform, string.format("%s_%s", RedPointConst.MOON_DELEGATE, slot0.activityID_))
end

return slot0
