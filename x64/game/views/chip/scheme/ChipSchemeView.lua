slot0 = class("ChipSchemeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/MimirChip/MimirPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.schemeUIList_ = LuaList.New(handler(slot0, slot0.RefreshSchemeItem), slot0.uiList_, slot0:GetChipSchemeItem())

	slot0:AddBtnListener(slot0.btn_backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.chipManagerID_ = slot0.params_.chipManagerID
	slot0.dataTemplate = slot0.params_.template
	slot0.sortSchemeList_ = slot0:GetSchemeList()

	slot0.schemeUIList_:StartScroll(#slot0.sortSchemeList_, 1)
	slot0:RefreshUI()

	slot0.enabledSchemeHandler_ = handler(slot0, slot0.OnEnabledScheme)

	manager.notify:RegistListener(ENABLED_SCHEME, slot0.enabledSchemeHandler_)

	slot0.deleteSchemeHandler_ = handler(slot0, slot0.OnDeleteScheme)

	manager.notify:RegistListener(DELETE_CHIP_SCHEME, slot0.deleteSchemeHandler_)

	slot0.saveHandler_ = handler(slot0, slot0.OnSaveChipScheme)

	manager.notify:RegistListener(SAVE_CHIP_SCHEME, slot0.saveHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ENABLED_SCHEME, slot0.enabledSchemeHandler_)

	slot0.enabledSchemeHandler_ = nil

	manager.notify:RemoveListener(DELETE_CHIP_SCHEME, slot0.deleteSchemeHandler_)

	slot0.deleteSchemeHandler_ = nil

	manager.notify:RemoveListener(SAVE_CHIP_SCHEME, slot0.saveHandler_)

	slot0.saveHandler_ = nil
	slot0.useIndex = nil
end

function slot0.RefreshSchemeItem(slot0, slot1, slot2)
	slot2:SetTemplateData(slot0.dataTemplate)
	slot2:RefreshUI(slot0.chipManagerID_, slot1, slot0.sortSchemeList_[slot1], slot0.useIndex)
end

function slot0.RefreshUI(slot0)
	slot0.numText_.text = string.format("%s/%s", table.length(ChipData:GetSchemeList()), GameSetting.ai_chip_proposal_num_max.value[1])
end

function slot0.GetChipSchemeItem(slot0)
	return ChipSchemeItem
end

function slot0.GetSchemeList(slot0)
	for slot5, slot6 in ipairs(ChipTools.SortScheme(slot0.chipManagerID_)) do
		if slot6.id == 0 then
			slot0.useIndex = 1
		end
	end

	return slot1
end

function slot0.GetSchemeList(slot0)
	slot3 = {
		{
			id = 0,
			name = GetTips(slot7),
			chipList = slot0:GetEquipChipList()
		}
	}
	slot7 = "CURRENT_SCHEME"

	for slot7, slot8 in pairs(ChipData:GetSchemeList()) do
		slot9 = #slot1 == #slot8.chipList

		for slot13, slot14 in ipairs(slot8.chipList) do
			if not table.keyof(slot1, slot14) then
				slot9 = false

				break
			end
		end

		if slot9 then
			slot3[1] = clone(slot8)
		else
			table.insert(slot3, clone(slot8))
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot8.id == 0 then
			slot0.useIndex = 1
		end
	end

	return slot3
end

function slot0.GetEquipChipList(slot0)
	print("ChipSchemeView  GetEquipChipList")

	return slot0.dataTemplate:GetEquipChipList()
end

function slot0.OnEnabledScheme(slot0)
	slot0.useIndex = nil

	slot0:OnDeleteScheme()
end

function slot0.OnDeleteScheme(slot0)
	slot0.sortSchemeList_ = slot0:GetSchemeList()

	slot0.schemeUIList_:StartScroll(#slot0.sortSchemeList_)
	slot0:RefreshUI()
end

function slot0.OnSaveChipScheme(slot0, slot1)
	slot0.useIndex = nil
	slot0.sortSchemeList_ = slot0:GetSchemeList()

	slot0.schemeUIList_:StartScroll(#slot0.sortSchemeList_)
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.schemeUIList_ then
		slot0.schemeUIList_:Dispose()

		slot0.schemeUIList_ = nil
	end
end

return slot0
