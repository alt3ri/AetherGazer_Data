slot0 = class("ChipManagerView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/MimirChip/MimirChipUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.isBattle = false
	slot0.tabIndex = 1

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chipManagerUIList_ = LuaList.New(handler(slot0, slot0.RefreshChipManagerItem), slot0.uiList_, slot0:GetChipManagerItem())
	slot0.chipManagerInfoView_ = slot0:GetChipManagerInfoView().New(slot0.panelGo_, slot0)

	slot0.chipManagerInfoView_:RegistEnableIDFunc(handler(slot0, slot0.EnableChipManagerIDFunc))
end

function slot0.SetWindowBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:SetWindowBar()

	slot0.handler_ = handler(slot0, slot0.OnUnlockChipManager)

	manager.notify:RegistListener(UNLOCK_CHIP_MANAGER, slot0.handler_)

	slot0.enabledChipHandler_ = handler(slot0, slot0.OnBattleChipUse)

	manager.notify:RegistListener(ENABLED_CHIP, slot0.enabledChipHandler_)

	if not slot0.chipManagerDataTemplate_ then
		slot0.chipManagerDataTemplate_ = slot0:GetChipDataTemplate()
	end

	slot0:SetViewParam()

	slot0.chipManagerList_ = slot0:GetChipManagerList()
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]

	slot0.chipManagerUIList_:StartScroll(#slot0.chipManagerList_, table.keyof(slot0.chipManagerList_, slot0.defaultSelectID_))
	slot0:RefreshUI()
end

function slot0.OnUpdate(slot0)
	slot0.defaultSelectID_ = slot0.params_.chipManagerID or slot0.chipManagerList_[1]

	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil

	manager.notify:RemoveListener(ENABLED_CHIP, slot0.enabledChipHandler_)

	slot0.enabledChipHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.schemeBtn_, nil, function ()
		uv0:OnSchemeBtn()
	end)
end

function slot0.OnUnlockChipManager(slot0)
	slot0:RefreshUI()
	slot0.chipManagerUIList_:Refresh()
end

function slot0.RefreshUI(slot0)
	slot1 = ChipCfg[slot0.defaultSelectID_]

	if slot0.chipManagerInfoView_ then
		slot0.chipManagerInfoView_:OnEnter()
		slot0.chipManagerInfoView_:SetTemplateData(slot0.chipManagerDataTemplate_)
		slot0.chipManagerInfoView_:RefreshData(slot0.defaultSelectID_)
	end

	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. slot1.picture_id)
end

function slot0.RefreshChipManagerItem(slot0, slot1, slot2)
	slot2:SetChipManagerID(slot0.chipManagerList_[slot1])

	if slot0.chipManagerDataTemplate_ and slot2.SetTemplateData then
		slot2:SetTemplateData(slot0.chipManagerDataTemplate_)
	end

	slot2:RefreshUI(slot3 == slot0.defaultSelectID_)
end

function slot0.RefreshManagerInfo(slot0)
	slot1 = ChipCfg[slot0.defaultSelectID_]
	slot0.chipManagerName_.text = GetI18NText(slot1.suit_name)
	slot0.skillText_.text = GetI18NText(slot1.desc)
	slot0.descText_.text = GetI18NText(slot1.profile)
	slot0.textStory_.text = GetI18NText(slot1.story)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	manager.notify:RemoveListener(UNLOCK_CHIP_MANAGER, slot0.handler_)

	slot0.handler_ = nil

	manager.notify:RemoveListener(ENABLED_CHIP, slot0.enabledChipHandler_)

	slot0.enabledChipHandler_ = nil

	if slot0.chipManagerInfoView_ then
		slot0.chipManagerInfoView_:Dispose()

		slot0.chipManagerInfoView_ = nil
	end

	if slot0.chipManagerUIList_ then
		slot0.chipManagerUIList_:Dispose()

		slot0.chipManagerUIList_ = nil
	end
end

function slot0.GetChipDataTemplate(slot0)
	return ChipManagerDataTemplate.New({
		id = slot0.defaultSelectID_,
		unlockChipManagerIDList_ = slot0:GetUnlockChipManagerList(),
		unlockChipIDList_ = slot0:GetUnlockChipList()
	})
end

function slot0.GetChipManagerList(slot0)
	return ChipTools.SortChipManager(ChipData:GetEnabledChipManagerID())
end

function slot0.GetUnlockChipManagerList(slot0)
	return ChipData:GetUnlockChipManagerIDList()
end

function slot0.GetUnlockChipList(slot0)
	return ChipData:GetUnlockChipIDList()
end

function slot0.GetChipTypeCntList(slot0)
	return ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]
end

function slot0.GetManagerUnlockView(slot0)
	return MimirChipManagerInfoView
end

function slot0.GetChipManagerItem(slot0)
	return ChipManagerItem
end

function slot0.GetChipManagerInfoView(slot0)
	return BattleChipManagerInfoView
end

function slot0.OnSchemeBtn(slot0)
end

function slot0.SetViewParam(slot0)
end

function slot0.EnableChipManagerIDFunc(slot0, slot1)
end

return slot0
