slot0 = class("MoonCakePartyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakePartyUI"
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

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.partyTypeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.rewardController_ = ControllerUtil.GetController(slot0.transform_, "reward")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.openPartyBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonPartyOpen", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonPartyShare", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.visitBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.TryQueryRecommendParty(uv0.activityID_)
	end)
	slot0:AddBtnListener(slot0.visitNextBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.VisitNextParty(uv0.activityID_)
	end)
	slot0:AddBtnListener(slot0.visitRewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.ownerData_.isVisited then
			ShowTips("MID_AUTUMN_FESTIVAL_PARTY_VISIT_OBTAINED_REWARD")

			return
		end

		if GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(uv0.activityID_) then
			ShowTips("MID_AUTUMN_FESTIVAL_PARTY_VISIT_REWARD_LIMIT")

			return
		end

		MoonCakeAction.ReceiveVisitReward(uv0.activityID_, uv0.ownerData_.uid)
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("moonCakeTask", {
			stage = 2,
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.moonBoBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.mainActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ActivityTools.JumpToSubmodulePage(MoonCakeTools.GetMoonBoStageActivityID(uv0.mainActivityID_))
	end)
end

function slot0.OnEnter(slot0)
	slot0:OnUpdate()
	slot0:BindRedPoint()
	slot0:AddTimer()
end

function slot0.OnUpdate(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityID_ = slot0.params_.activityID
	slot0.partyOwnerUID_ = slot0.params_.partyOwnerUID
	slot0.visitWay_ = slot0.params_.visitWay

	if slot0.partyOwnerUID_ == USER_ID then
		slot0.isMyParty_ = true
		slot0.partyData_ = MoonCakeData:GetOwnPartyData(slot0.activityID_)
	else
		slot0.isMyParty_ = false
		slot0.partyData_ = MoonCakeData:GetVisitPartyData(slot0.activityID_)
		slot0.ownerData_ = MoonCakeData:GetVisitPartyOwnerData(slot0.activityID_, slot0.partyOwnerUID_)
	end

	slot0:RefreshUI()

	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0.isMyParty_ == true or uv0.visitWay_ == MoonCakeConst.VISIT_WAY.SHARE then
			JumpTools.Back()
		else
			JumpTools.OpenPageByJump("/moonCakeParty", {
				activityID = uv0.activityID_,
				mainActivityID = uv0.mainActivityID_,
				partyOwnerUID = USER_ID
			})
			JumpTools.OpenPageByJump("moonPartyVisit", {
				isReturnFromOther = true,
				activityID = uv0.activityID_
			})
		end
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UnBindRedPoint()
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshPartyUI()
	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	if slot0.isMyParty_ == true then
		if slot0.partyData_.isOpened then
			slot0.statusController_:SetSelectedState("selfParty")
		else
			slot0.statusController_:SetSelectedState("unopen")
		end
	else
		slot0.statusController_:SetSelectedState("otherParty")
	end
end

function slot0.RefreshPartyUI(slot0)
	slot1 = 0
	slot2 = 0

	if slot0.partyData_.isOpened then
		slot1 = slot0.partyData_.visitNum
		slot2 = slot0.partyData_.partyType
	end

	slot0.accumulativeVisitorText_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_PARTY_PARTICIPANTS_NUM"), slot1)

	slot0.partyTypeController_:SetSelectedIndex(slot2)

	if slot0.isMyParty_ == false then
		slot0.userName_.text = slot0.ownerData_.nick
		slot0.userIcon.sprite = ItemTools.getItemSprite(slot0.ownerData_.portrait)
		slot0.userFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.ownerData_.frame)
		slot3 = false

		if MoonCakeTools.CanVisitNext(slot0.activityID_) then
			slot3 = true
		end

		SetActive(slot0.nextGo_, slot3)

		slot0.visitorNameText_.text = PlayerData:GetPlayerInfo().nick

		slot0:RefreshRewardBtn()
	end
end

function slot0.RefreshRewardBtn(slot0)
	if GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(slot0.activityID_) then
		SetActive(slot0.rewardPanelGo_, false)
	else
		SetActive(slot0.rewardPanelGo_, true)

		slot3 = true

		if slot0.ownerData_.isVisited then
			slot3 = false
		elseif GameSetting.activity_mid_autumn_present_limit.value[1] <= MoonCakeData:GetTodayVisitRewardTimes(slot0.activityID_) then
			slot3 = false
		end

		slot0.rewardController_:SetSelectedIndex(slot3 and 1 or 0)
	end
end

function slot0.OnPartyOpen(slot0)
	slot0:RefreshUI()
end

function slot0.OnPartyReset(slot0)
	ShowTips("MID_AUTUMN_FESTIVAL_PARTY_END")

	slot3 = ActivityEntraceCfg[ActivityEntraceCfg.get_id_list_by_theme[ActivityTools.GetActivityTheme(slot0.activityID_)][1]].jump_system
	slot5 = slot3[2]
	subActivityID = ActivityVersionData:GetSelectActivityID(slot5)

	JumpTools.OpenPageByJump(SystemLinkCfg[slot3[1]].link, {
		activityID = slot5,
		subActivityID = subActivityID
	})
end

function slot0.OnReceivedVisitReward(slot0)
	slot0:RefreshRewardBtn()
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
	manager.redPoint:bindUIandKey(slot0.openPartyBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.visitBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.visitNextBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.moonBoBtn_.transform, string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.openPartyBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_OPEN, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.visitBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.visitNextBtn_.transform, string.format("%s_%s", RedPointConst.MOON_PARTY_REWARD, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.moonBoBtn_.transform, string.format("%s_%s", RedPointConst.MOONBO, ActivityConst.ACTIVITY_2_4_MOONBO))
end

return slot0
