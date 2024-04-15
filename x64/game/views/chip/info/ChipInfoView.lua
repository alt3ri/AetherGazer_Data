slot0 = class("ChipInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/MimirChip/MimirChipEditUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.chipUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipItem), slot0.uiList_, slot0:GetChipItem())
	slot0.chipTypeCntList_ = slot0:GetChipTypeCntList() or {}
	slot0.btnState = slot0.btnControllerexcollection_:GetController("btn")
	slot0.conditionControl = slot0.conditionControllerexcollection_:GetController("clear")

	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.chipManagerDataTemplate_ = slot0.params_.chipDataTemplate
	slot0.chipManagerID = slot0.params_.chipManagerID
	slot0.sortChipIDList_ = slot0:SortChip()
	slot0.defaultSelectID_ = ChipData:GetChipManagerList()[slot0.params_.chipManagerID][slot0.params_.selectChipIndex] or slot0.sortChipIDList_[1]

	slot0.chipUIList_:StartScroll(#slot0.sortChipIDList_, 1)
	slot0:RefreshUI()

	slot0.unlockChipHandler_ = handler(slot0, slot0.OnUnlockChip)

	manager.notify:RegistListener(UNLOCK_CHIP, slot0.unlockChipHandler_)

	slot0.enabledChipHandler_ = handler(slot0, slot0.OnEnabledChip)

	manager.notify:RegistListener(ENABLED_CHIP, slot0.enabledChipHandler_)

	slot0.clickItemHandler_ = handler(slot0, slot0.OnClickItem)

	manager.notify:RegistListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP, slot0.unlockChipHandler_)
	manager.notify:RemoveListener(ENABLED_CHIP, slot0.enabledChipHandler_)
	manager.notify:RemoveListener(ON_CLICK_CHIP_ITEM, slot0.clickItemHandler_)

	slot0.unlockChipHandler_ = nil
	slot0.enabledChipHandler_ = nil
	slot0.clickItemHandler_ = nil
end

function slot0.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.selectChipID or slot0.sortChipIDList_[1]

	slot0:OnEnabledChip()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		uv0.chipManagerDataTemplate_:SetUseChipId(uv0.defaultSelectID_)
		manager.notify:Invoke(ENABLED_CHIP, uv0.defaultSelectID)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		ChipAction.UnlockChip(uv0.defaultSelectID_)
	end)
	slot0:AddBtnListener(slot0.unloadBtn_, nil, function ()
		uv0.chipManagerDataTemplate_:SetNoUseChipId(uv0.defaultSelectID_)
		manager.notify:CallUpdateFunc(UNUSE_BATTLECHIP, uv0.defaultSelectID_)
	end)
end

function slot0.OnUnlockChip(slot0)
	slot0.sortChipIDList_ = slot0:SortChip()

	slot0:OnEnabledChip()
end

function slot0.OnEnabledChip(slot0)
	slot0:RefreshUI()
	slot0.chipUIList_:Refresh()
end

function slot0.OnClickItem(slot0, slot1)
	slot0:Go(slot0.chipManagerDataTemplate_:GetChipInfoViewPath(), {
		chipManagerID = slot0.params_.chipManagerID,
		selectChipID = slot1,
		selectChipIndex = slot0.params_.selectChipIndex,
		chipDataTemplate = slot0.chipManagerDataTemplate_
	})
end

function slot0.GetFirstUnSelectID(slot0)
	for slot5, slot6 in ipairs(slot0.sortChipIDList_) do
		if not table.keyof(slot0:GetChipData(), slot6) then
			return slot6
		end
	end

	return slot0.sortChipIDList_[1]
end

function slot0.RefreshChipItem(slot0, slot1, slot2)
	slot2:SetChipID(slot0.sortChipIDList_[slot1])
	slot2:SetTemplateData(slot0.chipManagerDataTemplate_)
	slot2:RefreshUI(slot0.defaultSelectID_, slot0.chipManagerID)
end

function slot0.RefreshUI(slot0)
	if ChipCfg[slot0.defaultSelectID_] then
		slot2, slot3, slot4 = IsConditionAchieved(slot1.new_condition)
		slot0.conditiondescireText_.text = GetI18NText(ConditionCfg[slot1.new_condition].desc)
		slot0.iconImage_.sprite = getSpriteViaConfig("ChipSkillIcon", slot1.picture_id)
		slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. ChipCfg[slot0.chipManagerID].picture_id)
		slot0.name_.text = GetI18NText(slot1.suit_name)
		slot0.effectText_.text = GetI18NText(slot1.desc)
		slot0.isUnlock_, slot7, slot8 = IsConditionAchieved(slot1.new_condition)

		if slot0.chipManagerDataTemplate_:GetIsUnlockChip(slot0.defaultSelectID_) == false then
			if slot0.isUnlock_ then
				slot0.btnState:SetSelectedState("unLock2")
				slot0.conditionControl:SetSelectedState("clear")
			else
				slot0.btnState:SetSelectedState("unLock1")
				slot0.conditionControl:SetSelectedState("notClear")
			end
		elseif slot0.chipManagerDataTemplate_:GetIsUesChipID(slot0.defaultSelectID_) then
			slot0.btnState:SetSelectedState("unUse")
		else
			slot0.btnState:SetSelectedState("use")
		end

		SetActive(slot0.lockPanel_, not slot9)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.chipUIList_ then
		slot0.chipUIList_:Dispose()

		slot0.chipUIList_ = nil
	end
end

function slot0.GetChipItem(slot0)
	return ChipItem
end

function slot0.GetChipTypeCntList(slot0)
	return ChipTools.GetChipTypeCntList(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP])
end

function slot0.GetChipData(slot0)
	return ReserveTools.GetMimirChipList(slot0.reserveParams_)
end

function slot0.SortChip(slot0)
	return ChipTools.SortChip((slot0:GetChipTypeCntList() or {})[-1], slot0.params_.chipManagerID)
end

function slot0.GetUnlockChipIDList(slot0)
	return ChipData:GetUnlockChipIDList()
end

return slot0
