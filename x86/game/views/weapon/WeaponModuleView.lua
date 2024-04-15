slot0 = class("WeaponModuleView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_module/HeroModuleMainUI"
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

	slot0.statusController_ = ControllerUtil.GetController(slot0.viewTrans_, "status")
	slot0.attributeItems_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.storyBtn_, nil, function ()
		JumpTools.OpenPageByJump("/weaponModuleStoryView", {
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		JumpTools.OpenPageByJump("weaponModulePreviewView", {
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.levelupBtn_, nil, function ()
		JumpTools.OpenPageByJump("/weaponModuleLevelUpView", {
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		JumpTools.OpenPageByJump("/weaponModuleUnlockView", {
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.astrolabeinfoBtn_, nil, function ()
		slot0 = nil

		JumpTools.OpenPageByJump("weaponModuleGodInfoView", {
			effectList = (uv0:GetModuleLevel() <= 0 or HeroData:GetCurModuleEffectListByType(uv0.heroID_, 3, slot1)) and HeroData:GetLockModuleEffectListByType(uv0.heroID_, 3),
			heroID = uv0.heroID_
		})
	end)
	slot0:AddBtnListener(slot0.servantinfoBtn_, nil, function ()
		slot0 = nil

		JumpTools.OpenPageByJump("weaponModuleServantInfoView", {
			effectList = (uv0:GetModuleLevel() <= 0 or HeroData:GetCurModuleEffectListByType(uv0.heroID_, 4, slot1)) and HeroData:GetLockModuleEffectListByType(uv0.heroID_, 4),
			heroID = uv0.heroID_
		})
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("WEAPON_MODULE_DESCRIPE")

	slot0.heroID_ = slot0.params_.heroID

	slot0:RefreshUI()
	slot0:AddRedPoint()
end

function slot0.AddRedPoint(slot0)
	slot1 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroID_

	manager.redPoint:bindUIandKey(slot0.levelupBtn_.transform, slot1)
	manager.redPoint:bindUIandKey(slot0.getBtn_.transform, slot1)
end

function slot0.GetModuleLevel(slot0)
	return HeroData:GetCurModuleLevel(slot0.heroID_)
end

function slot0.GetModuleMaxLevel(slot0)
	return HeroData:GetModuleMaxLevel(slot0.heroID_)
end

function slot0.GetEffectList(slot0)
	return HeroTools:GetModulePowersByHeroIDAndLevel(slot0.heroID_, slot0:GetModuleLevel())
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = GetI18NText(WeaponModuleCfg[slot0.heroID_].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.titleTrans_)

	slot0.moduleImage_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. slot0.heroID_)

	if slot0:GetModuleLevel() == 0 then
		slot0.statusController_:SetSelectedState("lock")
	else
		slot0.levelText_.text = slot1

		if slot0:GetModuleMaxLevel() <= slot1 then
			slot0.statusController_:SetSelectedState("max")
		else
			slot0.statusController_:SetSelectedState("unlock")
		end
	end

	slot0:RefreshDes()
end

function slot0.RefreshDes(slot0)
	slot2 = nil
	slot3, slot4, slot5, slot6 = HeroTools.GetModuleAllDes((slot0:GetModuleLevel() ~= 0 or WeaponModuleCfg[slot0.heroID_].skill[1]) and slot0:GetEffectList(), slot0.heroID_)

	if slot3 == nil then
		SetActive(slot0.attrGo_, false)
	else
		SetActive(slot0.attrGo_, true)
		slot0:RefreshAttriItems(slot3)
		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.attrGo_.transform)
	end

	if slot4 == nil then
		SetActive(slot0.skillGo_, false)
	else
		SetActive(slot0.skillGo_, true)

		slot0.skillText_.text = slot4

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillGo_.transform)
	end

	if slot5 == nil then
		SetActive(slot0.astrolabeGo_, false)
	else
		SetActive(slot0.astrolabeGo_, true)

		slot0.astrolabeText_.text = slot5

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.astrolabeGo_.transform)
	end

	if slot6 == nil then
		SetActive(slot0.servantGo_, false)
	else
		SetActive(slot0.servantGo_, true)

		slot0.servantText_.text = slot6

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.servantGo_.transform)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

	slot0.contentTrans_.localPosition = Vector3.New(0, 0, 0)
end

function slot0.RefreshAttriItems(slot0, slot1)
	slot3 = 1

	for slot7, slot8 in pairs(HeroTools.MergeModuleAttribute(slot1)) do
		if slot0.attributeItems_[slot3] == nil then
			slot0.attributeItems_[slot3] = WeaponModuleAttributeItem.New(GameObject.Instantiate(slot0.attriItemGo_, slot0.attriItemTrans_))
		end

		slot0.attributeItems_[slot3]:SetData(slot7, slot8)

		slot3 = slot3 + 1
	end

	for slot7, slot8 in pairs(slot0.attributeItems_) do
		if slot7 < slot3 then
			slot0.attributeItems_[slot7]:SetIsShow(true)
		else
			slot0.attributeItems_[slot7]:SetIsShow(false)
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveRedPoint()
end

function slot0.RemoveRedPoint(slot0)
	slot1 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroID_

	manager.redPoint:unbindUIandKey(slot0.levelupBtn_.transform, slot1)
	manager.redPoint:unbindUIandKey(slot0.getBtn_.transform, slot1)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attributeItems_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
