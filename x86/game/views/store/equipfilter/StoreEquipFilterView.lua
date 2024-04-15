slot0 = class("StoreEquipFilterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Bag/BagEquipFilterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.suitUIList_ = LuaList.New(handler(slot0, slot0.IndexSuitItem), slot0.suitListGo_, EquipFilterSuitItem)
	slot0.skillUIList_ = LuaList.New(handler(slot0, slot0.IndexSkillItem), slot0.skillListGo_, EquipFilterSkillItem)
	slot0.tabController_ = slot0.filterController_:GetController("tab")
	slot0.selectController_ = slot0.filterController_:GetController("select")
	slot0.suitList_ = {}
	slot0.skillList_ = {}
	slot0.selectList_ = {}
	slot0.selectItemList_ = {}
	slot0.selectPanelType_ = StoreConst.EQUIP_FILTER_TYPE.SUIT
	slot0.OnEquipFilterSelectChangeHandler = handler(slot0, slot0.OnEquipFilterSelectChange)
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(EQUIP_FILTER_SELECT_CHANGE, slot0.OnEquipFilterSelectChangeHandler)

	slot0.filterParams_ = clone(slot0.params_.filterParams)

	slot0:InitSuitDataList()
	slot0:InitSkillDataList()
	slot0:InitSelectList()
	slot0.suitUIList_:StartScroll(#slot0.suitList_)
	slot0.skillUIList_:StartScroll(#slot0.skillList_)
	slot0:RefreshSelectPanel()
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(EQUIP_FILTER_SELECT_CHANGE, slot0.OnEquipFilterSelectChangeHandler)
end

function slot0.Dispose(slot0)
	slot0.OnEquipFilterSelectChangeHandler = nil

	for slot4, slot5 in ipairs(slot0.selectItemList_) do
		slot5:Dispose()
	end

	slot0.selectItemList_ = nil

	slot0.suitUIList_:Dispose()

	slot0.suitUIList_ = nil

	slot0.skillUIList_:Dispose()

	slot0.skillUIList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnConfirm_, nil, function ()
		for slot4, slot5 in ipairs(uv0.filterParams_.suit) do
			table.insert({}, slot5)
		end

		slot1 = {}

		for slot5, slot6 in ipairs(uv0.filterParams_.skill) do
			table.insert(slot1, slot6)
		end

		manager.notify:Invoke(EQUIP_FILTER_SELECT_APPLY, {
			suitList = slot0,
			skillList = slot1
		})
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnSuit_, nil, function ()
		uv0:SwitchPanel(StoreConst.EQUIP_FILTER_TYPE.SUIT)
	end)
	slot0:AddBtnListener(slot0.btnSkill_, nil, function ()
		uv0:SwitchPanel(StoreConst.EQUIP_FILTER_TYPE.SKILL)
	end)
	slot0:AddBtnListener(slot0.btnMask_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.brnCloseSelected_, nil, function ()
		uv0.filterParams_.suit = {}
		uv0.filterParams_.skill = {}

		uv0:ClearSelectItemData()
		uv0:RefreshSuitUIList()
		uv0:RefreshSkillUIList()
		uv0:RefreshSelectPanel()
	end)
end

function slot0.OnEquipFilterSelectChange(slot0, slot1)
	if slot1.type == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		if slot1.state == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			table.insert(slot0.filterParams_.suit, slot1.id)
			slot0:AddSelectItemData(slot1)
		else
			table.removebyvalue(slot0.filterParams_.suit, slot1.id)
			slot0:RemoveSelectItemData(slot1)
		end

		slot0:RefreshSuitUIList()
	else
		if slot1.state == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			table.insert(slot0.filterParams_.skill, slot1.id)
			slot0:AddSelectItemData(slot1)
		else
			table.removebyvalue(slot0.filterParams_.skill, slot1.id)
			slot0:RemoveSelectItemData(slot1)
		end

		slot0:RefreshSkillUIList()
	end

	slot0:RefreshSelectPanel()
end

function slot0.SwitchPanel(slot0, slot1)
	if slot0.selectPanelType_ ~= slot1 then
		slot0.selectPanelType_ = slot1
		slot0.filterParams_.suit = {}
		slot0.filterParams_.skill = {}

		slot0:ClearSelectItemData()
		slot0:RefreshSelectPanel()

		if slot1 == StoreConst.EQUIP_FILTER_TYPE.SUIT then
			slot0.tabController_:SetSelectedState("suit")
		else
			slot0.tabController_:SetSelectedState("skill")
		end

		slot0:RefreshPanel()
	end
end

function slot0.RefreshPanel(slot0)
	if slot0.selectPanelType_ == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		slot0.suitUIList_:StartScroll(#slot0.suitList_)
	else
		slot0.skillUIList_:StartScroll(#slot0.skillList_)
	end
end

function slot0.RefreshSelectPanel(slot0)
	if #slot0.selectList_ <= 0 then
		slot0.selectController_:SetSelectedState("noselect")
	else
		slot0.selectController_:SetSelectedState("select")
		slot0:RefreshAllSelectItem()
	end
end

function slot0.RefreshSuitUIList(slot0)
	slot0.suitUIList_:Refresh()
end

function slot0.InitSuitDataList(slot0)
	slot0.suitList_ = {}

	for slot4, slot5 in ipairs(EquipSuitCfg.all) do
		slot0.suitList_[slot4] = {
			type = StoreConst.EQUIP_FILTER_TYPE.SUIT,
			id = slot5,
			cnt = EquipTools.GetSuitEquipNum(slot5, nil, slot0.params_.equipPosition)
		}
	end
end

function slot0.IndexSuitItem(slot0, slot1, slot2)
	slot3 = slot0.suitList_[slot1]

	slot2:SetData(slot3, table.keyof(slot0.filterParams_.suit, slot3.id) ~= nil)
end

function slot0.RefreshSkillUIList(slot0)
	slot0.skillUIList_:Refresh()
end

function slot0.InitSkillDataList(slot0)
	slot0.skillList_ = {}

	for slot4, slot5 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]) do
		slot0.skillList_[slot4] = {
			type = StoreConst.EQUIP_FILTER_TYPE.SKILL,
			id = slot5,
			cnt = EquipTools.GetEquipSkillNum(slot5, nil, slot0.params_.equipPosition)
		}
	end
end

function slot0.IndexSkillItem(slot0, slot1, slot2)
	slot3 = slot0.skillList_[slot1]

	slot2:SetData(slot3, table.keyof(slot0.filterParams_.skill, slot3.id) ~= nil)
end

function slot0.InitSelectList(slot0)
	slot0.selectList_ = {}

	for slot4, slot5 in ipairs(slot0.filterParams_.suit) do
		table.insert(slot0.selectList_, {
			type = StoreConst.EQUIP_FILTER_TYPE.SUIT,
			id = slot5
		})
	end

	for slot4, slot5 in ipairs(slot0.filterParams_.skill) do
		table.insert(slot0.selectList_, {
			type = StoreConst.EQUIP_FILTER_TYPE.SKILL,
			id = slot5
		})
	end
end

function slot0.AddSelectItemData(slot0, slot1)
	table.insert(slot0.selectList_, {
		type = slot1.type,
		id = slot1.id
	})
end

function slot0.RemoveSelectItemData(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.selectList_) do
		if slot6.type == slot1.type and slot6.id == slot1.id then
			table.remove(slot0.selectList_, slot5)

			return
		end
	end
end

function slot0.ClearSelectItemData(slot0)
	slot0.selectList_ = {}
end

function slot0.RefreshAllSelectItem(slot0)
	for slot4, slot5 in ipairs(slot0.selectList_) do
		slot0.selectItemList_[slot4] = slot0.selectItemList_[slot4] or EquipFilterSelectItem.New(slot0.filterItemGo_, slot0.filterItemParentGo_)

		slot0.selectItemList_[slot4]:SetData(slot5)
	end

	for slot4 = #slot0.selectList_ + 1, #slot0.selectItemList_ do
		slot0.selectItemList_[slot4]:Show(false)
	end
end

return slot0
