slot0 = class("DecomposeConfirmPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Bag/SplitGetPopUI"
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

	slot0.itemScroller_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemListGo_, CommonItemView)
	slot0.returnScroller_ = LuaList.New(handler(slot0, slot0.indexReturnItem), slot0.returnListGo_, CommonItemView)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnConfirm_, nil, function ()
		if uv0.type_ == "equip" then
			EquipAction.EquipDecompose(uv0.params_.itemList)
		elseif uv0.type_ == "servant" then
			ServantAction.ServantDecompose(uv0.params_.itemList)
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.type_ = slot0.params_.type
	slot0.itemList_ = slot0:SortItem(slot0.params_.itemList)
	slot0.returnList_ = slot0.params_.returnList

	slot0.itemScroller_:StartScroll(#slot0.itemList_)
	slot0.returnScroller_:StartScroll(#slot0.returnList_)
end

function slot0.SortItem(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	table.sort(slot2, function (slot0, slot1)
		return ItemCfg[slot0.id or slot0.prefab_id].rare < ItemCfg[slot1.id or slot1.prefab_id].rare
	end)

	return slot2
end

function slot0.indexItem(slot0, slot1, slot2)
	slot4 = slot0.itemList_[slot1]
	clone(ItemTemplateData).id = slot0.type_ == "equip" and slot4.prefab_id or slot4.id

	if slot0.type_ == "equip" then
		slot3.equipLevel = EquipTools.CountEquipLevel(slot4)
	end

	slot2:SetData(slot3)
end

function slot0.indexReturnItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot4 = slot0.returnList_[slot1]
	slot3.id = slot4.id
	slot3.number = slot4.number

	slot2:SetData(slot3)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.itemScroller_:Dispose()
	slot0.returnScroller_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
