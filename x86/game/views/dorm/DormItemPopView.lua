slot0 = class("DormItemPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureInfoPopUI_02"
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
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.itemID = slot0.params_.id

	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	slot0:RefreshCommonItem()
	slot0:RefreshItemInfo()
	slot0:RefreshLableContent()
end

function slot0.RefreshCommonItem(slot0)
	if not slot0.commonItemView_ then
		slot0.commonItemView_ = CommonItemView.New(slot0.commonItem_)
	end

	slot0.commonItemView_:SetData({
		id = slot0.itemID
	})
end

function slot0.RefreshItemInfo(slot0)
	slot0.holdNum.text = tostring(DormData:GetFurNumInfo(slot0.itemID).num)
end

function slot0.RefreshLableContent(slot0)
	if ItemCfg[slot0.itemID] then
		slot0.ItemDesc.text = ItemTools.getItemDesc(slot0.itemID)
	else
		slot0.ItemDesc.text = ""
	end

	slot0.titletextText_.text = ItemTools.getItemName(slot0.itemID)
	slot0.typeDesc.text = DormTools:GetFurGiftTypeDesc(slot0.itemID)

	for slot7, slot8 in ipairs(BackHomeFurniture[slot0.itemID].scene_id) do
		slot2 = "" .. DormTools:GetRoomTypeName(slot8) .. " "
	end

	slot0.sceneDesc.text = slot2
	slot0.giftMax.text = DormTools:GetFurGiftMaxDesc(slot0.itemID)
	slot0.comfortNum.text = DormTools:GetFurComfortDesc(slot0.itemID)
end

function slot0.Dispose(slot0)
	if slot0.commonItemView_ then
		slot0.commonItemView_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
