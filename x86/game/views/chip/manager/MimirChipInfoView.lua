slot0 = class("MimirChipInfoView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.pCtrl = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.btnState = slot0.btnControllerexcollection_:GetController("btn")
	slot0.conditionControl = slot0.conditionControllerexcollection_:GetController("clear")
end

function slot0.AddListeners(slot0)
	slot0.clickItemHandler_ = handler(slot0, slot0.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)
	slot0:AddBtnListener(slot0.btn_unlock1Btn_, nil, function ()
		ShowTips("CHIP_HERO_UNLOCK_FAILED")
	end)
	slot0:AddBtnListener(slot0.btn_unlock2Btn_, nil, function ()
		ChipAction.UnlockChip(uv0.chipID)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnClickItem(slot0, slot1)
	slot0:RefreshData(slot1)
end

function slot0.RefreshData(slot0, slot1)
	if not ChipCfg[slot1] then
		return
	end

	slot0.chipID = slot1
	slot3 = ChipCfg[slot1]
	slot0.iconchipImg_.sprite = getSpriteViaConfig("ChipSkillIcon", slot3.picture_id)
	slot0.txt_dyn_nameText_.text = GetI18NText(slot3.suit_name)
	slot0.textText_.text = GetI18NText(slot3.desc)
	slot4, slot5, slot6 = IsConditionAchieved(slot3.new_condition)
	slot0.conditiondescireText_.text = GetI18NText(ConditionCfg[slot3.new_condition].desc)

	if slot0.chipManagerDataTemplate_:GetIsUnlockChip(slot1) == false then
		if slot4 then
			slot0.btnState:SetSelectedState("unLock2")
			slot0.conditionControl:SetSelectedState("clear")
		else
			slot0.btnState:SetSelectedState("unLock1")
			slot0.conditionControl:SetSelectedState("notClear")
		end
	else
		slot0.btnState:SetSelectedState("unlocked")
	end

	SetActive(slot0.conditionGo_, not slot7)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)

	slot0.clickItemHandler_ = nil
end

function slot0.SetChipManagerID(slot0, slot1)
	slot0.chipManagerID = slot1
end

function slot0.SetTemplateData(slot0, slot1)
	slot0.chipManagerDataTemplate_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)

	slot0.clickItemHandler_ = nil
	slot0.pCtrl = nil
end

return slot0
