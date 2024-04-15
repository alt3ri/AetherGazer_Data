slot0 = class("EquipCultureView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/Develop/EquipCultureUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.selectIndex_ = -1

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.group = {
		slot0.btn_detail,
		slot0.btn_levelup,
		slot0.btn_upgrade,
		slot0.btn_enchant,
		slot0.btn_reset,
		slot0.btn_inherit
	}
	slot0.SetBarInSelfView = {
		nil,
		true,
		true,
		nil,
		true,
		true
	}
	slot0.class_ = {
		EquipDetailView,
		EquipLevelUpView,
		EquipUpgradeView,
		EquipEnchantView,
		EquipResetView,
		EquipInheritView
	}
	slot0.prefabPath_ = {
		"Widget/System/Hero_equip/Develop/EquipDetailUI",
		"Widget/System/Hero_equip/Develop/EquipLevelUpUI",
		"Widget/System/Hero_equip/Develop/EquipUpgradeUI",
		"Widget/System/Hero_equip/Develop/EquipEnchantUI",
		"Widget/System/Hero_equip/Develop/EquipResetUI",
		"Widget/System/Hero_equip/Develop/EquipInheritUI"
	}
	slot0.equipTgl_ = {}
	slot0.posIcon_ = {}

	for slot4 = 1, 6 do
		slot0.equipTgl_[slot4] = slot0["equipBtn_" .. slot4]
		slot0.posIcon_[slot4] = slot0["posIcon_" .. slot4]
	end

	slot0.heroEquipController_ = slot0.cultureCon_:GetController("equipped")
	slot0.popController_ = slot0.cultureCon_:GetController("pop")
	slot0.equipPosController_ = slot0.equipPos_:GetController("pos")
	slot0.equipInfo_ = EquipInfoView.New(slot0.equipInfoGo_)
	slot0.skillInfo_ = EquipNewSkillInfoView.New(slot0.skillInfoGo_)
	slot0.equipDisc_ = EquipDisc.New(slot0.discGo_)
	slot0.pages_ = {}
end

function slot0.AddUIListener(slot0)
	slot0.sidebarCon_ = {}

	for slot4, slot5 in pairs(slot0.group) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:GoToTarget(uv1)
		end)

		slot0.sidebarCon_[slot4] = slot5.gameObject:GetComponent("ControllerExCollection"):GetController("btnController")
	end

	for slot4 = 1, 6 do
		slot0:AddBtnListener(slot0.equipTgl_[slot4], nil, function ()
			if uv0.equipList_[uv1].equip_id ~= 0 and uv0.index_ ~= uv1 then
				manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")
				uv0:RefreshDisc(uv1)
				uv0:RefreshPosBtn(uv1)
				uv0:RefreshSideBar(uv0.equipList_[uv1].equip_id)
			end
		end)
	end

	slot0:AddBtnListener(slot0.btnHidePop_, nil, function ()
		uv0:ClearSkillSelect()
		uv0.popController_:SetSelectedState("hide")
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroViewProxy_ = slot0.params_.proxy

	if not slot0.hadShow then
		slot0.equipId_ = slot0.params_.equipId
		slot0.equip = slot0.equipId_ and EquipData:GetEquipData(slot0.equipId_) or EquipStruct.New(0, slot0.params_.prefabId)
		slot0.index_ = EquipCfg[slot0.equip.prefab_id].pos
		slot0.oldIndex_ = slot0.params_.rotateAnim and 5 or slot1.pos

		slot0.equipDisc_:OnEnter({
			oldIndex = slot0.oldIndex_,
			newIndex = slot0.index_
		})
		slot0:RefreshView()
		slot0:GoToTarget(slot0.params_.pageIndex)

		if not slot0.params_.rotateAnim then
			slot0.discAnim_:Play("EquipCultureUI")
		end

		slot0.hadShow = true
	end

	slot0:RefreshSideBar(slot0.equipId_)
end

function slot0.ChangeBar(slot0)
	if slot0.SetBarInSelfView[slot0.curPageIndex_] then
		return
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnTop(slot0)
	slot0:ChangeBar()

	if slot0.pages_[slot0.curPageIndex_] then
		slot0.pages_[slot0.curPageIndex_]:OnTop()
	end

	slot1 = GameSetting.equip_culture_describe and GameSetting.equip_culture_describe.value or {}

	manager.windowBar:RegistInfoCallBack(function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = uv0
		})
	end)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back(1, {
			translationAnim = true,
			suitPos = uv0.index_
		})

		uv0.hadShow = false
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		JumpTools.OpenPageByJump("/home")

		uv0.hadShow = false
	end)
end

function slot0.RefreshView(slot0)
	slot0.equipPos_ = {}
	slot0.heroId_ = HeroData:GetEquipMap()[slot0.equipId_]
	slot1 = slot0.heroId_ and slot0.heroId_ ~= 0

	slot0.heroEquipController_:SetSelectedState(tostring(slot1))

	if slot1 then
		slot0.equipList_ = HeroTools.GetHeroEquipS(slot0.heroId_)
		slot0.equipDataList_ = EquipTools.GetEquipDataList(slot0.equipList_)

		slot0.equipDisc_:RefreshItem(slot0.equipDataList_)
		slot0:RefreshHero(slot0.heroId_)
		slot0:RefreshPosBtn(slot0.index_)
	else
		slot0.equipDisc_:HideItems()
		slot0.equipDisc_:RefreshItemByIndex(slot0.index_, slot0.equip)
	end
end

function slot0.RefreshHero(slot0, slot1)
	slot0.heroIcon_.sprite = ItemTools.getItemSprite(HeroTools.HeroUsingSkinInfo(slot1).id)

	slot0.heroIcon_:SetNativeSize()

	slot0.heroGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", string.format("com_white_icon_group_%s_c", HeroCfg[slot1].race))
end

function slot0.RefreshPosBtn(slot0, slot1)
	slot0.equipPosController_:SetSelectedState(slot0.index_)

	for slot5, slot6 in ipairs(slot0.equipList_) do
		slot7 = slot6.equip_id ~= 0
		slot0.equipTgl_[slot5].interactable = slot7
		slot0.posIcon_[slot5].color = slot7 and Color.New(0.4235294117647059, 0.4980392156862745, 0.5647058823529412, 1) or Color.New(0.49019607843137253, 0.5411764705882353, 0.596078431372549, 0.5019607843137255)
	end
end

function slot0.RefreshDisc(slot0, slot1)
	slot0.oldIndex_ = slot0.index_
	slot0.index_ = slot1 or slot0.index_

	slot0.equipDisc_:RotateServant(slot0.oldIndex_, slot0.index_)
end

function slot0.GoToTarget(slot0, slot1)
	if slot0.curPageIndex_ == slot1 then
		return
	end

	if slot0.pages_[slot0.curPageIndex_] then
		slot2:Hide()
	end

	if slot0.curPageIndex_ then
		slot0.sidebarCon_[slot0.curPageIndex_]:SetSelectedState("false")
	end

	slot0.sidebarCon_[slot1]:SetSelectedState("true")

	slot0.curPageIndex_ = slot1
	slot0.params_.pageIndex = slot1

	if not slot0.pages_[slot1] then
		slot4 = slot0.class_[slot1]

		if slot0.prefabPath_[slot1] and slot4 then
			slot0.pages_[slot1] = slot4.New(slot0, Object.Instantiate(Asset.Load(slot5), slot0.pageContainer_), {
				equipId = slot0.equipId_,
				heroId = slot0.heroId_,
				prefabId = slot0.params_.prefabId,
				proxy = slot0.heroViewProxy_
			})

			slot0.pages_[slot1]:OnEnter()
		end
	else
		slot0.pages_[slot1]:Show(slot3)
	end

	if slot1 == 5 and slot0.equip.race_preview ~= 0 then
		JumpTools.OpenPageByJump("/equipRaceConfirmView", slot3)
	end

	slot0:ChangeBar()
end

function slot0.RefreshSideBar(slot0, slot1)
	slot0.equipId_ = slot1
	slot0.equip = EquipData:GetEquipData(slot0.equipId_)

	if slot0.equip then
		slot3 = EquipCfg[slot0.equip.prefab_id]
		slot4 = slot0.equip.now_break_level + 1
		slot7 = slot0.equip:GetMaxLv() <= slot0.equip:GetLevel() and slot0.equip.now_break_level < slot3.break_times_max

		SetActive(slot0.gameObject_levelup, not slot7)
		SetActive(slot0.gameObject_upgrade, slot7)
		SetActive(slot0.gameObject_enchant, slot3.starlevel >= 4)
		SetActive(slot0.gameObject_reset, slot3.starlevel >= 5 and (slot0.equip.race == 0 or table.keyof(RaceEffectCfg.all, slot0.equip.race) ~= nil))
		SetActive(slot0.gameObject_inherit, slot3.starlevel >= 5 and slot0.equip.race ~= 0 and table.keyof(RaceEffectCfg.all, slot0.equip.race) == nil)

		if slot0.params_.pageIndex == 2 and slot7 then
			slot2 = 3
		elseif slot2 == 3 and slot8 then
			slot2 = 2
		elseif slot2 == 4 and not slot9 or slot2 == 5 and not slot10 or slot2 == 6 and not slot11 then
			slot2 = 1
		end

		slot0:GoToTarget(slot2)

		if slot2 == slot0.params_.pageIndex then
			slot0.pages_[slot2]:OnEquipChange(slot0.equipId_)
			slot0.equipDisc_:RefreshItemByIndex(slot0.index_, slot0.equip)
		end
	else
		SetActive(slot0.gameObject_levelup, false)
		SetActive(slot0.gameObject_upgrade, false)
		SetActive(slot0.gameObject_enchant, false)
		SetActive(slot0.gameObject_reset, false)
		SetActive(slot0.gameObject_inherit, false)
	end
end

function slot0.RefreshEquipInfo(slot0, slot1, slot2, slot3)
	slot0.equipCommonItem_ = slot2

	slot0.equipInfo_:RefreshData(slot0, slot1, slot3, slot0.heroId_, slot0.equipId_)
	slot0.popController_:SetSelectedState("equip")
end

function slot0.RefreshSkillInfo(slot0, slot1, slot2)
	slot0.skillItem_ = slot1

	slot0.skillInfo_:RefreshData(slot0, slot2)
	slot0.popController_:SetSelectedState("skill")
end

function slot0.HidePop(slot0)
	slot0:ClearEquipSelect()
	slot0:ClearSkillSelect()
	slot0.popController_:SetSelectedState("hide")
end

function slot0.ClearEquipSelect(slot0)
	if slot0.equipCommonItem_ then
		slot0.equipCommonItem_:RefreshSelectState(false)

		slot0.equipCommonItem_ = nil
	end
end

function slot0.ClearSkillSelect(slot0)
	if slot0.skillItem_ then
		slot0.skillItem_:ShowSelect(false)

		slot0.skillItem_ = nil
	end
end

function slot0.OnEquipInherit(slot0)
	slot0.equip = EquipData:GetEquipData(slot0.equipId_)

	slot0.equipDisc_:RefreshItemByIndex(slot0.index_, slot0.equip)
	slot0.pages_[6]:ResetInherit()
end

function slot0.GetEquipId(slot0)
	return slot0.equipId_
end

function slot0.GetCulturePage(slot0)
	return slot0.curPageIndex_
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:HidePop()

	if slot0.curPageIndex_ ~= nil then
		slot2 = slot0.pages_[slot0.curPageIndex_]

		if slot0.sidebarCon_[slot0.curPageIndex_] then
			slot1:SetSelectedState("false")
		end

		if slot2 then
			slot0.pages_[slot0.curPageIndex_]:Hide()
		end

		slot0.curPageIndex_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:Dispose()
	end

	slot0.pages_ = nil

	slot0.equipInfo_:Dispose()
	slot0.skillInfo_:Dispose()
	slot0.equipDisc_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
