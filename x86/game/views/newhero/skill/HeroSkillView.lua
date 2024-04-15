slot0 = class("HeroSkillView", ReduxView)
slot0.skillAdditionType = {
	astrolabe = 3,
	weaponModule = 2,
	attribute = 4,
	weaponServant = 1
}
slot1 = {
	PROPERTY = 2,
	SKILL = 1
}
slot2 = {
	[slot1.SKILL] = "skill",
	[slot1.PROPERTY] = "property"
}
slot3 = 6
slot4 = 1.2
slot5 = 0.333

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.parent = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItemList = {}

	for slot4 = 1, uv0 do
		slot0.skillItemList[slot4] = HeroSkillViewItem.New(slot0, slot0["skillitem" .. slot4 .. "Go_"])
	end

	slot0.heroSkillInfo_ = HeroSkillInfoView.New(slot0, slot0.skillnodeGo_)
	slot0.heroSkillProperty_ = HeroSkillPropertyView.New(slot0, slot0.propertynodeGo_)
	slot0.showStateController_ = slot0.controllerexcollection_:GetController("showState")
	slot0.previewController_ = slot0.controllerexcollection_:GetController("preview")
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, uv0 do
		slot0.skillItemList[slot4]:RegistCallBack(function (slot0)
			uv0:OnClickSkillItem(uv1, slot0)
		end)
	end

	slot0:AddBtnListener(slot0.comboskillBtn_, nil, function ()
		manager.windowBar:HideBar()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = uv0.heroInfo.id
		})
	end)
end

function slot0.OnClickSkillItem(slot0, slot1, slot2)
	if slot0.selectSkillId == slot2.id then
		return
	end

	slot0.selectSkillId = slot2.id
	slot0.selectIndex = slot1
	slot0.params.skillId = slot0.selectSkillId

	slot0:RefreshSelectSkill(slot2.id, true)
end

function slot0.UpdateRedState(slot0)
	if not slot0:CheckIsSelf() then
		manager.redPoint:setRedPoint({
			display = slot0.parent.skillBtn_.transform
		}, false)
		manager.redPoint:setRedPoint({
			display = slot0.parent.propertyBtn_.transform
		}, false)

		return
	end

	manager.redPoint:setRedPoint({
		display = slot0.parent.skillBtn_.transform
	}, slot0.skillList[slot0.selectIndex] and slot1.isCanStarUp or false)
	manager.redPoint:setRedPoint({
		display = slot0.parent.propertyBtn_.transform
	}, slot1 and slot1.isCanAttrUp or false)
end

function slot0.CheckIsSelf(slot0)
	slot0.heroViewDataProxy = slot0.params.proxy

	if slot0.heroViewDataProxy and slot0.heroViewDataProxy:CheckIsSelf() then
		return true
	end

	return false
end

function slot0.RefreshSelectSkill(slot0, slot1, slot2)
	slot0.parent:NotHaveAttrShow(slot0:isNotHaveAttrSkill(slot1))
	slot0:RefreshSkillList()
	slot0:RefreshSkillInfo(slot2)
	slot0:RefreshPropertyInfo(slot2)
end

function slot0.isNotHaveAttrSkill(slot0, slot1)
	if not SkillTools.GetSkillAttrCfg(slot0.heroId, SkillTools.GetSkillIdIndex(slot1), 2) or not next(slot3) or not next(slot3.attr) then
		return true
	end

	return false
end

function slot0.OnEnter(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.params = slot1
	slot0.isGoHeroMain = false
	slot0.skillAni_.enabled = true

	slot0:InitData()
	slot0:InitViewCallback()
	slot0.heroSkillInfo_:OnEnter(slot0.params.proxy)
	slot0.heroSkillProperty_:OnEnter(slot0.params.proxy)

	for slot5 = 1, 6 do
		slot0.skillItemList[slot5]:SetProxy(slot0.params.proxy)
	end

	slot0:RefreshSelectSkill(slot0.selectSkillId)
	slot0.previewController_:SetSelectedState(tostring(slot0.heroViewDataProxy:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))
end

function slot0.InitData(slot0)
	slot0.selectSkillId = slot0.selectSkillId or slot0.params.skillId
	slot0.heroInfo = slot0.params.heroInfo
	slot0.heroId = slot0.heroInfo and slot0.heroInfo.id or nil
	slot0.aniEndPos = slot0.params.aniEndPos
	slot0.heroViewDataProxy = slot0.params.proxy
	slot0.skillList = slot0.heroViewDataProxy:GetHeroSkillInfo(slot0.heroId)
	slot0.selectIndex = 1

	for slot4, slot5 in pairs(slot0.skillList) do
		if slot5.id == slot0.selectSkillId then
			slot0.selectIndex = slot4

			break
		end
	end

	for slot4 = 1, uv0 do
		slot0.skillItemList[slot4]:SetProxy(slot0.heroViewDataProxy)
	end
end

function slot0.InitViewCallback(slot0)
	slot0.heroSkillInfo_:SetTempRefreshCallback(function (slot0, slot1, slot2)
		uv0:TempSkillUpgrade(slot0, slot1, slot2)
	end)
end

function slot0.ChangeTabShow(slot0, slot1)
	slot0.showStateController_:SetSelectedState(uv0[slot1])
	slot0:RefreshSkillList()
end

function slot0.OnHeroSkillAttrUpgradeInView(slot0, slot1, slot2)
	slot0:RefreshSkillData()
	slot0.heroSkillProperty_:OnHeroSkillAttrUpgradeInView(slot1, slot2)
	slot0.heroSkillInfo_:UpdateTargetCondition(4)
end

function slot0.OnHeroSkillUpgrade(slot0, slot1, slot2)
	slot0:RefreshSkillData()
	slot0.heroSkillInfo_:OnHeroSkillUpgrade(slot1, slot2)
	slot0.heroSkillProperty_:RefreshUi()
end

function slot0.TempSkillUpgrade(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot0.skillList) do
		if slot1 == slot8.id then
			slot0.skillList[slot7].tempAddLevel = slot2
		end

		slot8.isCanStarUp = SkillTools.GetIsCanUp(slot8.id, slot8.lv + (slot8.tempAddLevel or 0), slot3)
	end

	slot0:RefreshSkillList()

	for slot7, slot8 in pairs(slot0.skillList) do
		if slot1 == slot8.id then
			slot0.skillList[slot7].tempAddLevel = 0
		end
	end
end

function slot0.RefreshSkillData(slot0)
	slot0.skillList = slot0.heroViewDataProxy:GetHeroSkillInfo(slot0.heroId)

	slot0:RefreshSkillList()
end

function slot0.RefreshSkillList(slot0)
	if slot0.skillList then
		for slot4 = 1, uv0 do
			slot0.skillItemList[slot4]:RefreshData(slot0.skillList[slot4], slot0.parent:GetSelectTabType())
		end
	end

	slot0:UpdateRedState()
end

function slot0.RefreshSkillInfo(slot0, slot1)
	slot0.heroSkillInfo_:UpdateSkillData(slot0.skillList[slot0.selectIndex], slot1)
end

function slot0.RefreshPropertyInfo(slot0, slot1)
	slot0.heroSkillProperty_:UpdatePropertyData(slot0.skillList[slot0.selectIndex], slot1)
end

function slot0.GetPlayBackwardsAnimator(slot0)
	if not slot0.isGoHeroMain then
		return {}, nil
	end

	slot1 = nil

	return (not slot0.parent:isPropertyView() or {
		{
			slot0.propertynodeAni_,
			"Fx_Common_right_cx_out 1",
			false
		}
	}) and {
		{
			slot0.skillnodeAni_,
			"Fx_Common_right_cx_out 1",
			false
		}
	}, handler(slot0, slot0.PlayBackwardsAnimatorFun)
end

function slot0.PlayBackwardsAnimatorFun(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		0
	}, false)
	slot0:PlayBackAniEffect()
	slot0.skillItemList[slot0.selectIndex]:UpdateSelectState(false)
end

function slot0.OnExit(slot0)
	slot0.selectSkillId = nil

	SetActive(slot0.gameObject_, false)
end

function slot0.OnTop(slot0)
	manager.windowBar:RegistBackCallBack(function ()
		uv0.isGoHeroMain = true

		JumpTools.Back(nil, {
			isSkillReturn = true
		})
	end)
end

function slot0.Dispose(slot0)
	if slot0.exitTimer then
		slot0.exitTimer:Stop()

		slot0.exitTimer = nil
	end

	if slot0.skillCxTimer then
		slot0.skillCxTimer:Stop()

		slot0.skillCxTimer = nil
	end

	if slot0.backTween then
		LeanTween.cancel(slot0.backTween.id)

		slot0.backTween = nil
	end

	for slot4 = 1, uv0 do
		slot0.skillItemList[slot4]:Dispose()
	end

	slot0.heroSkillInfo_:Dispose()
	slot0.heroSkillProperty_:Dispose()
	uv1.super.Dispose(slot0)
end

function slot0.PlaySkillCxAnim(slot0)
	if slot0.skillCxTimer then
		slot0.skillCxTimer:Stop()

		slot0.skillCxTimer = nil
	end

	slot0.skillCxTimer = Timer.New(function ()
		uv0.skillAni_:Play("Fx_skill_cx", 0, 0)
	end, 0.5)

	slot0.skillCxTimer:Start()
end

function slot0.SetEffectState(slot0, slot1)
	if slot1 then
		slot0:PlayBackAniEffect()

		if slot0.skillnodeAni_:GetCurrentAnimatorClipInfoCount(0) > 0 then
			slot0.skillnodeAni_:SetFloat("speed", -uv0)
			slot0.skillnodeAni_:Play("Fx_Common_right_cx", 0, slot0.skillnodeAni_:GetCurrentAnimatorClipInfo(0)[0].clip.length)
		end

		if slot0.propertynodeAni_:GetCurrentAnimatorClipInfoCount(0) > 0 then
			slot0.propertynodeAni_:SetFloat("speed", -uv0)
			slot0.propertynodeAni_:Play("Fx_Common_right_cx", 0, slot0.propertynodeAni_:GetCurrentAnimatorClipInfo(0)[0].clip.length)
		end
	end
end

function slot0.PlayBackAniEffect(slot0)
	slot1 = slot0.skillTrs_.position
	slot0.skillAni_.enabled = false
	slot0.backTween = LeanTween.value(0, 1, uv0 / uv1):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.skillTrs_.position = Vector3.Lerp(uv1, uv0.aniEndPos, slot0)
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.backTween then
			uv0.backTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			uv0.backTween = nil
		end
	end)):setEase(LeanTweenType.easeOutQuad)
end

return slot0
