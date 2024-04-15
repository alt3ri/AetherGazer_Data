SkinTrialActivityItem = import("game.views.skinTrialActivity.SkinTrialActivityItem")
slot0 = class("FactorySkinTrialActivityItem", SkinTrialActivityItem)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:SetSkinTrialID(slot2)
	SetActive(slot0.gameObject_, true)
end

function slot0.RefreshUI(slot0)
	if SDKTools.GetIsOverSea() then
		if getSpriteViaConfig("SkinTrialTextrues", string.format("%s_oversea", HeroStandardSystemCfg[ActivitySkinTrialCfg[slot0.skinTrialID_].trial_id].skin_id)) ~= nil then
			slot0.skinImage_.sprite = slot4
		end

		slot0.skinNameText_.text = GetI18NText(slot1.name)
		slot0.heroNameText_.text = HeroTools.GetHeroFullName(HeroStandardSystemCfg[slot2].hero_id)
	end

	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.stateController_:SetSelectedState("true")
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))

			return
		end

		if uv0.stopTime_ <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return
		end

		SkinTrialData:SetSelectSkinTrialID(uv0.skinTrialID_)

		if uv0.path_ == nil then
			uv0.path_ = string.format("/skinTrialSelect%d", uv0.skinTrialID_)
		end

		uv0:Go(uv0.path_, {
			canPlayAnim = true,
			activityID = uv0.activityID_,
			skinTrialID = uv0.skinTrialID_
		})
	end)
end

return slot0
