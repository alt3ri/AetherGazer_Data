slot0 = class("SuitSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/EquipSelectPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
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

function slot0.UpdateData(slot0)
	slot0.suitList_ = {}
	slot1 = HideInfoData:GetEquipSuitHideList()
	slot2 = {}
	slot3 = slot0.select_

	if slot0.select_ == 0 then
		slot3 = table.length(EquipSuitCfg.get_id_list_by_equip_type)
	elseif slot0.select_ == slot4 then
		slot3 = 0
	end

	for slot8, slot9 in ipairs((slot4 <= slot3 or EquipSuitCfg.get_id_list_by_equip_type[slot3]) and EquipSuitCfg.get_id_list_by_suit) do
		slot10 = slot9

		if type(slot9) == "table" then
			slot10 = slot9[1]
		end

		if EquipSuitCfg[slot10].stage_up_list == 1 and not slot1[slot10] then
			table.insert(slot0.suitList_, slot10)
		end
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.suitList_[slot1] == slot0.selectSuitId_ then
		slot2:ShowSelect(true)
	else
		slot2:ShowSelect(false)
	end

	if slot3 == slot0.params_.currentSuitId then
		slot2:ShowCurrentUp(true)
	else
		slot2:ShowCurrentUp(false)
	end

	slot2:RefreshData(slot0, {
		id = slot3
	})
	slot2:RegistCallBack(function (slot0)
		uv0:SelectSuitItem(slot0)
	end)
end

function slot0.SelectSuitItem(slot0, slot1)
	slot3 = table.indexof(slot0.suitList_, slot1.id)

	if slot0.scrollHelper_:GetItemList()[table.indexof(slot0.suitList_, slot0.selectSuitId_)] then
		slot2[slot4]:ShowSelect(false)
	end

	slot0.selectSuitId_ = slot1.id

	if slot0.params_.hideBtn then
		slot0.stateController_:SetSelectedState("hide")
	else
		slot0.stateController_:SetSelectedState(slot0.choosedId_ ~= slot0.selectSuitId_ and "confirm" or "select")
	end

	slot2[slot3]:ShowSelect(true)
	slot0:RefreshSelectSuitInfo()
end

function slot0.RefreshSelectSuitInfo(slot0)
	if not EquipSuitCfg[slot0.selectSuitId_] then
		SetActive(slot0.infoGo_, false)

		return
	end

	SetActive(slot0.infoGo_, true)

	slot0.name_.text = GetI18NText(slot1.name)
	slot0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), slot1.need)
	slot0.desc_.text = GetI18NText(EquipTools.GetEffectDesc(slot1.suit_effect[1]))
	slot0.scrollView_.verticalNormalizedPosition = 1
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBgMask_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.btnConfirm_, nil, function ()
		if uv0.selectSuitId_ == nil then
			return
		end

		BattleEquipAction.ChangeUpSuit(uv0.selectSuitId_)
		SDKTools.SendMessageToSDK("equip_target_changed", {
			equip_id_old = uv0.params_.currentSuitId,
			equip_id_new = uv0.selectSuitId_
		})
	end)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0.select_ = slot0

		uv0:RefreshUI()
	end)
end

function slot0.OnEnter(slot0)
	slot0.selectSuitId_ = slot0.params_.suitId
	slot0.choosedId_ = slot0.params_.suitId
	slot0.select_ = 0
	slot0.dropDown_.value = 0

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:UpdateData()

	slot1 = false

	if slot0.selectSuitId_ then
		if not table.indexof(slot0.suitList_, slot0.selectSuitId_) then
			slot1 = 1
			slot0.selectSuitId_ = slot0.suitList_[1]
		end
	else
		slot1 = 1
		slot0.selectSuitId_ = slot0.suitList_[1]
	end

	if slot0.params_.hideBtn then
		slot0.stateController_:SetSelectedState("hide")
	else
		slot0.stateController_:SetSelectedState(slot0.choosedId_ ~= slot0.selectSuitId_ and "confirm" or "select")
	end

	slot0.scrollHelper_:StartScroll(#slot0.suitList_, slot1 - 5 < 1 and 1 or slot1 - slot2)
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
