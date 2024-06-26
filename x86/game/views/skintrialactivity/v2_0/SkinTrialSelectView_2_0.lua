slot0 = class("SkinTrialSelectView_2_0", ReduxView)

function slot0.UIName(slot0)
	return SkinTrialTools.GetSelectViewUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.popType_ = POP_ITEM
	slot0.receivedControllerList_ = {}
	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itemListGo_, slot0:GetRewardItem())

	slot0:AddListeners()

	slot0.specialRoleController_ = ControllerUtil.GetController(slot0.transform_, "specialRole")
	slot0.styleController_ = ControllerUtil.GetController(slot0.transform_, "style")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		uv0:OnBackBtnClick()
	end)

	slot0.activityID_ = slot0.params_.activityID
	slot0.skinTrialID_ = slot0.params_.skinTrialID
	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBattle_, nil, function ()
		SkinTrialData:SaveStageID(uv0.skinTrialID_)

		if not ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:SaveRoute()
		uv0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[uv0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		if not ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(ActivitySkinTrialCfg[uv0.skinTrialID_].source)
	end)
end

function slot0.OnBackBtnClick(slot0)
	SkinTrialData:SaveSkinTrialMainScrollPos(SkinTrialData:GetSkinTrialMainScrollPos("Global"), "Back")
	slot0:Back()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
	slot0.itemList_:Dispose()

	slot0.itemList_ = nil
end

function slot0.RefreshUI(slot0)
	slot2 = SkinTrialTools.GetHeroStandardID(slot0.skinTrialID_)
	slot3 = HeroStandardSystemCfg[slot2].skin_id
	slot4 = HeroStandardSystemCfg[slot2].hero_id
	slot0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))
	slot0.skinDescText_.text = GetI18NText(SkinCfg[slot3].desc)
	slot0.skinNameText_.text = GetI18NText(SkinCfg[slot3].name)

	slot0:RefreshRoleImage()
	slot0:RefreshReward()
	slot0.specialRoleController_:SetSelectedState("none")

	if slot0.styleController_ and (ActivityTools.GetActivityTheme(slot0.activityID_) == ActivityConst.THEME.ACTIVITY_2_2 or slot5 == ActivityConst.THEME.ACTIVITY_2_4) then
		slot0.styleController_:SetSelectedState("V2_2")
	end
end

function slot0.RefreshRoleImage(slot0)
	if getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[SkinTrialTools.GetHeroStandardID(slot0.skinTrialID_)].skin_id].picture_id) ~= nil then
		slot0.skinImage_.sprite = slot2
	end
end

function slot0.RefreshReward(slot0)
	slot0.rewardCfg_ = ActivitySkinTrialCfg[slot0.skinTrialID_].reward

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.GetRewardItem(slot0)
	return CommonItem
end

function slot0.GetCommonItem(slot0, slot1)
	return slot1
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot4 = slot0:GetCommonItem(slot2)

	slot4:RefreshData(formatReward(slot0.rewardCfg_[slot1]))
	slot4:RegistCallBack(function (slot0)
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, slot0)
			end
		else
			ShowPopItem(uv0.popType_, slot0)
		end
	end)

	if slot0.receivedControllerList_[slot1] == nil then
		slot0.receivedControllerList_[slot1] = ControllerUtil.GetController(slot4.transform_, "received")
	end

	slot0.receivedControllerList_[slot1]:SetSelectedState(tostring(SkinTrialData:IsCompleted(slot0.skinTrialID_)))
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.SaveRoute(slot0)
	SkinTrialData:SaveRoute({
		name = "skinTrialSelectView_2_0",
		activityID = slot0.activityID_,
		skinTrialID = slot0.skinTrialID_
	})
end

return slot0
