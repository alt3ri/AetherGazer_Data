slot0 = class("SkinTrialSelect1002", SkinTrialActivitySelectView)

function slot0.UIName(slot0)
	return "UI/OsirisUI/OsirisSkinTrialUI_101"
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.startTime_ = ActivityData:GetActivityData(slot0.activityID_).startTime
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBattle_, nil, function ()
		SkinTrialData:SaveStageID(uv0.skinTrialID_)

		if not ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[uv0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.RefreshUI(slot0)
	slot2 = SkinTrialTools.GetHeroStandardID(slot0.skinTrialID_)
	slot3 = HeroStandardSystemCfg[slot2].skin_id
	slot4 = HeroStandardSystemCfg[slot2].hero_id
	slot0.heroTitleText_.text = GetI18NText(SkinCfg[slot3].name)
	slot0.skinImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[slot3].picture_id)
	slot0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))

	if SettingData:GetCurrentLanguage() == "fr" or slot5 == "de" then
		slot0.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))
	end

	slot0.skinDescText_.text = GetI18NText(SkinCfg[slot3].desc)

	slot0:RefreshReward()
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
	slot4:RegistCallBack(function ()
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, uv1)
			end
		else
			ShowPopItem(uv0.popType_, uv1)
		end
	end)

	if slot0.receivedControllerList_[slot1] == nil then
		slot0.receivedControllerList_[slot1] = ControllerUtil.GetController(slot4.transform_, "received")
	end

	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.receivedControllerList_[slot1]:SetSelectedState("true")
	end
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

return slot0
