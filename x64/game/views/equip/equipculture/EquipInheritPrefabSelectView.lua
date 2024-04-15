slot0 = class("EquipInheritPrefabSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/EquipSelectPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.suitListGo_, SuitSelectItem)
	slot0.stateController_ = slot0.controller:GetController("state")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBgMask_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.btnConfirm_, nil, function ()
		if uv0.selectSuitId_ == nil then
			JumpTools.Back()

			return
		end

		if uv0.selectHandler_ ~= nil then
			uv0.selectHandler_(uv0.selectSuitId_)
		end

		JumpTools.Back()
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0.select_ = slot0

		uv0:RefreshUI()
	end)
end

function slot0.OnEnter(slot0)
	slot0.selectSuitId_ = slot0.params_.suitId
	slot0.choosedId_ = slot0.params_.suitId
	slot0.selectHandler_ = slot0.params_.selectSuitHandler
	slot0.equipTypeCfg_ = EquipSuitCfg.get_id_list_by_equip_type
	slot0.select_ = slot0.select_ or 0

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:UpdateData()

	if not table.indexof(slot0.suitList_, slot0.selectSuitId_) then
		slot1 = 1
		slot0.selectSuitId_ = slot0.suitList_[1]
	end

	slot0.stateController_:SetSelectedState(slot0.choosedId_ ~= slot0.selectSuitId_ and "confirm" or "select")
	slot0.scrollHelper_:StartScroll(#slot0.suitList_, slot1 - 6 < 1 and 1 or slot1 - slot2)
	slot0:RefreshSelectSuitInfo()
end

function slot0.UpdateData(slot0)
	slot0.suitList_ = {}

	for slot8, slot9 in ipairs(slot0.select_ ~= 0 and slot0.equipTypeCfg_[slot0.select_ - 1] or EquipSuitCfg.all) do
		if not HideInfoData:GetEquipSuitHideList()[slot9] and slot9 ~= EquipCfg[EquipData:GetEquipData(slot0.params_.equipID).prefab_id].suit and EquipSuitCfg[slot9].inherit_cost_type ~= 0 then
			table.insert(slot0.suitList_, slot9)
		end
	end
end

function slot0.RefreshSelectSuitInfo(slot0)
	if not EquipSuitCfg[slot0.selectSuitId_] then
		SetActive(slot0.infoGo_, false)

		return
	end

	slot0.name_.text = GetI18NText(slot1.name)
	slot0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), slot1.need)
	slot0.desc_.text = GetI18NText(EquipTools.GetEffectDesc(slot1.suit_effect[1]))

	SetActive(slot0.infoGo_, true)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:ShowSelect(slot0.suitList_[slot1] == slot0.selectSuitId_)
	slot2:ShowCurrentUp(slot3 == slot0.params_.currentSuitId)
	slot2:RefreshData(slot0, {
		id = slot3
	})
	slot2:RegistCallBack(function (slot0)
		uv0:SelectSuitItem(slot0)
	end)
end

function slot0.SelectSuitItem(slot0, slot1)
	slot4 = slot0.scrollHelper_:GetItemByIndex(table.indexof(slot0.suitList_, slot1.id))

	if slot0.scrollHelper_:GetItemByIndex(table.indexof(slot0.suitList_, slot0.selectSuitId_)) then
		slot5:ShowSelect(false)
	end

	slot4:ShowSelect(true)

	slot0.selectSuitId_ = slot1.id

	slot0.stateController_:SetSelectedState(slot0.choosedId_ ~= slot0.selectSuitId_ and "confirm" or "select")
	slot0:RefreshSelectSuitInfo()
end

function slot0.OnChangeUpSuit(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		JumpTools.Back()
	end
end

function slot0.OnExit(slot0)
	slot0.selectSuitId_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
