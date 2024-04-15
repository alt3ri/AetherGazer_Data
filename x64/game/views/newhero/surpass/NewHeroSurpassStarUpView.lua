slot0 = class("NewHeroSurpassView", ReduxView)
slot1 = {
	showEx = {
		name = "infoShow",
		skill = "skill",
		attr = "attr"
	}
}

function slot0.UIName(slot0)
	return "Widget/System/Hero_transition/HeroPrintLvUI"
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

	slot0.attrInfo = SurpassUpAttrNode.New(slot0.levelcapbreakthroughGo_)
	slot0.skillInfo = SurpassUpSkillNode.New(slot0.skilllevelimprovementGo_)
	slot0.showController = slot0.heroprintlvuiControllerexcollection_:GetController(uv0.showEx.name)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.fullscreenBtn_, nil, function ()
		uv0:OnClose()
	end)
end

function slot0.OnClose(slot0)
	if slot0.exitTimer then
		return
	end

	slot0.compopui04Ani_:Play("Fx_CompopUI04_xs", 0, 0)

	slot0.exitTimer = Timer.New(function ()
		JumpTools.Back()
	end, 0.467)

	slot0.exitTimer:Start()
end

function slot0.OnEnter(slot0)
	slot0.starID = slot0.params_.starID
	slot0.heroID = slot0.params_.heroID
	slot0.dataProxy = slot0.params_.dataProxy

	if slot0.exitTimer then
		slot0.exitTimer:Stop()

		slot0.exitTimer = nil
	end

	slot0:Refresh()
	manager.audio:PlayEffect("ui_system", "starsup_small", "")
end

function slot0.Refresh(slot0)
	SurpassTools.ChangeIconStarSpirte(slot0.iconImg_, HeroStarCfg[slot0.starID].star)

	slot3, slot4, slot5 = SurpassTools.GetStarUpAttrShowDesc(HeroCfg[slot0.heroID], slot0.starID)
	slot6 = ""

	if HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP == slot5.type then
		slot0.showController:SetSelectedState(uv0.showEx.attr)
		slot0.attrInfo:RefreshUi(slot5, slot0.dataProxy:GetHeroAllAttribute(slot0.heroID))
	elseif HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP == slot5.type then
		slot0.showController:SetSelectedState(uv0.showEx.skill)
		slot0.skillInfo:RefreshUi(slot3, GetTips("SKILL_LEVEL_UP"))
	else
		slot0.showController:SetSelectedState(uv0.showEx.skill)
		slot0.skillInfo:RefreshUi(slot3, GetTips("SPECIAL_SKILL"))
	end

	slot0.lvText_.text = SurpassTools.GetSmallStageShow(slot0.starID)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.exitTimer then
		slot0.exitTimer:Stop()

		slot0.exitTimer = nil
	end

	slot0.attrInfo:Dispose()
	slot0.skillInfo:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
