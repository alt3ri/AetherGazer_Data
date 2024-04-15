slot0 = class("ActivityHeroEnhanceHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selController_ = slot0.controller_:GetController("selected")
	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.passController_ = slot0.controller_:GetController("pass")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0.onClickHandler_(uv0.heroID)
		end
	end)
end

function slot0.SetClickHandler(slot0, slot1)
	if slot1 then
		slot0.onClickHandler_ = slot1
	end
end

function slot0.SetData(slot0, slot1)
	slot0.cfgId_ = slot1
end

function slot0.SetIgnorePass(slot0, slot1)
	slot0.isIgnorePass_ = slot1
end

function slot0.SetSelected(slot0, slot1)
	slot0.selected_ = slot1

	return slot0.selected_
end

function slot0.RefreshUI(slot0)
	slot1 = ActivityHeroEnhanceCfg[slot0.cfgId_]
	slot2 = slot1.activity_id
	slot3 = slot1.hero_id
	slot4 = HeroData:GetHeroData(slot3)
	slot5 = HeroCfg[slot3]
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot3)
	slot0.nameText_.text = HeroTools.GetHeroFullName(slot3)
	slot6, slot7 = ActivityHeroEnhanceTools.IsCfgHeroLock(slot1)

	slot0.selController_:SetSelectedState(slot0.selected_ and "true" or "false")
	slot0.lockController_:SetSelectedState(slot6 and "true" or "false")

	if not slot0.isIgnorePass_ then
		slot0.passController_:SetSelectedState(not slot6 and ActivityHeroEnhanceTools.IsCfgHeroPass(slot1) and "true" or "false")
	end

	if slot6 then
		if slot7.isBeforeStartDay then
			slot0.lockText_.text = string.format(GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION"), slot7.startDay - slot7.curDay)
		else
			slot0.lockText_.text = GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION_2")
		end
	end
end

function slot0.GetRedPointTransform(slot0)
	return slot0.selfBtn_.transform
end

function slot0.GetCfgId(slot0)
	return slot0.cfgId_
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
