slot0 = class("MoonPartyVisitView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyVisitUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, MoonPartyVisitItem)
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if MoonCakeData:GetRefreshRecommendPartyTime(uv0.activityID_) and GameSetting.activity_mid_autumn_party_list_refresh_interval.value[1] > manager.time:GetServerTime() - slot1 then
			ShowTips("MID_AUTUMN_FESTIVAL_TASK_REFRESH_PROMPT")

			return
		end

		MoonCakeAction.RefreshRecommendParty(uv0.activityID_)
	end)
	slot0:AddBtnListener(slot0.allVisitBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.type_ == MoonCakeConst.VISIT_TYPE.ALL then
			return
		end

		uv0:RefreshList(MoonCakeConst.VISIT_TYPE.ALL)
	end)
	slot0:AddBtnListener(slot0.friendVisitBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.type_ == MoonCakeConst.VISIT_TYPE.FRIEND then
			return
		end

		uv0:RefreshList(MoonCakeConst.VISIT_TYPE.FRIEND)
	end)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()

	slot0.scrollHelper_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	if slot0.params_.isReturnFromOther then
		slot0.params_.isReturnFromOther = false
		slot0.tempScrollPos_ = MoonCakeTools.GetTempVisitViewScrollPos(slot0.activityID_) or 0
	elseif slot0.params_.isBack then
		slot0.params_.isBack = false
		slot0.type_ = MoonCakeTools.GetTempVisitViewType(slot0.activityID_) or MoonCakeConst.VISIT_TYPE.ALL
		slot0.tempScrollPos_ = MoonCakeTools.GetTempVisitViewScrollPos(slot0.activityID_) or 0
	else
		slot0.type_ = MoonCakeConst.VISIT_TYPE.ALL
	end

	slot0:RefreshList(slot0.type_)
	slot0:RefreshProgress()
end

function slot0.OnExit(slot0)
	MoonCakeTools.SetTempVisitViewType(slot0.activityID_, slot0.type_)
	MoonCakeTools.SetTempVisitViewScrollPos(slot0.activityID_, slot0.scrollHelper_:GetScrolledPosition())
end

function slot0.RefreshList(slot0, slot1)
	slot0.type_ = slot1
	slot0.visitorDataList_ = {}

	if slot0.type_ == MoonCakeConst.VISIT_TYPE.ALL then
		slot0.visitorDataList_ = MoonCakeData:GetSortedRecommendPartyList(slot0.activityID_)
	elseif slot0.type_ == MoonCakeConst.VISIT_TYPE.FRIEND then
		slot0.visitorDataList_ = MoonCakeData:GetSortedFriendPartyList(slot0.activityID_)
	end

	slot0.selectController_:SetSelectedIndex(slot0.type_)

	if not slot0.tempScrollPos_ then
		slot0.scrollHelper_:StartScroll(#slot0.visitorDataList_)
	else
		slot0.scrollHelper_:StartScrollByPosition(#slot0.visitorDataList_, slot0.tempScrollPos_)

		slot0.tempScrollPos_ = nil
	end
end

function slot0.RefreshProgress(slot0)
	slot0.progressText_.text = string.format("%d/%d", MoonCakeData:GetTodayVisitRewardTimes(slot0.activityID_), GameSetting.activity_mid_autumn_present_limit.value[1])
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.type_, slot1, slot0.visitorDataList_[slot1], slot0.activityID_)
end

function slot0.OnVisitOtherParty(slot0)
	slot0:Back()
end

function slot0.OnPartyRecommendUpdate(slot0)
	slot0:RefreshList(slot0.type_)
end

return slot0
