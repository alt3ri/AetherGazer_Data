slot0 = class("HeroSkillView", ReduxView)
slot1 = {
	PROPERTY = 2,
	SKILL = 1
}
slot2 = {
	[slot1.SKILL] = "skill",
	[slot1.PROPERTY] = "property"
}

function slot0.UIName(slot0)
	return "Widget/System/Hero_skill/HeroSkillMainUI"
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

	slot0.tabSelectController_ = slot0.tablistControllerEx_:GetController("tabSelect")
	slot0.propertyController_ = slot0.propertyControllerexcollection_:GetController("lock")
	slot0.hideTabController_ = slot0.controller_:GetController("hide")
	slot0.skillView_ = HeroSkillView.New(slot0, slot0.heroskilluiGo_)
	slot0.propertyObj_ = slot0.propertyBtn_.gameObject
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		uv0:ChangeTab(uv1.SKILL)
	end)
	slot0:AddBtnListener(slot0.propertyBtn_, nil, function ()
		slot0, slot1 = uv0:CheckPrepertyCondition(ViewConst.SYSTEM_ID.HERO_SKILL_ATTR)

		if not slot0 then
			ShowTips(slot1)

			return
		end

		OperationRecorder.RecordButtonTouch("hero_skill_attribute_lv_up")
		uv0:ChangeTab(uv1.PROPERTY)
	end)
end

function slot0.CheckPrepertyCondition(slot0, slot1)
	if not table.keyof(ViewConst.SYSTEM_ID, slot1) then
		return true, ""
	end

	if not JumpTools.IsSystemLocked(slot1) then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(slot1, slot2)
	end
end

function slot0.ChangeTab(slot0, slot1)
	if slot0.selectTabType and slot0.selectTabType == slot1 then
		return
	end

	slot0.tabSelectController_:SetSelectedState(uv0[slot1])

	slot0.selectTabType = slot1

	slot0.skillView_:ChangeTabShow(slot1)
end

function slot0.NotHaveAttrShow(slot0, slot1)
	SetActive(slot0.propertyObj_, not slot1)

	if slot1 and slot0.selectTabType == uv0.PROPERTY then
		slot0:ChangeTab(uv0.SKILL)
	end
end

function slot0.isPropertyView(slot0)
	return slot0.selectTabType == uv0.PROPERTY
end

function slot0.GetSelectTabType(slot0)
	return slot0.selectTabType
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if slot0.skillView_ then
		slot0.skillView_:OnTop()
	end
end

function slot0.OnEnter(slot0)
	slot0.skillView_:OnEnter(slot0.params_)

	slot0.heroViewDataProxy_ = slot0.params_.proxy

	slot0.hideTabController_:SetSelectedState(tostring(slot0.heroViewDataProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))

	if not slot0.selectTabType or slot0.heroViewDataProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		slot0:ChangeTab(uv0.SKILL)
	end

	slot0:CheckLocked()
end

function slot0.CheckLocked(slot0)
	slot1, slot2 = slot0:CheckPrepertyCondition(ViewConst.SYSTEM_ID.HERO_SKILL_ATTR)

	slot0.propertyController_:SetSelectedState(slot1 and "false" or "true")
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		1
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.skillView_:OnExit()

	if slot0.skillView_ and slot0.skillView_.isGoHeroMain then
		slot0:ChangeTab(uv0.SKILL)
	end
end

function slot0.OnHeroSkillUpgrade(slot0, slot1, slot2)
	slot0.skillView_:OnHeroSkillUpgrade(slot1, slot2)
end

function slot0.OnHeroSkillAttrUpgrade(slot0, slot1, slot2)
	slot0.skillView_:OnHeroSkillAttrUpgradeInView(slot1, slot2)
end

function slot0.GetPlayBackwardsAnimator(slot0)
	return slot0.skillView_:GetPlayBackwardsAnimator()
end

function slot0.Dispose(slot0)
	slot0.skillView_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
