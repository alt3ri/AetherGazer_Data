slot0 = class("ShopContentViewWithPoster", ShopContentViewBase)

function slot0.GetAssetPath()
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0.GetAssetPath()), slot0.containerGo_.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ExchangeItemView)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.UpdateListByFilter(slot0)
	slot0:RefreshList()
end

function slot0.GetPoster(slot0)
	return getSpriteViaConfig("ShopPoster", slot0.shopId_)
end

function slot0.RefreshList(slot0, slot1)
	slot0.imageImg_.sprite = slot0:GetPoster()
	slot0.shopName.text = ShopListCfg[slot0.shopId_].remark

	uv0.super.RefreshList(slot0, slot1)

	slot0.shopDataList_ = ShopTools.FilterShopDataList(slot0.shopId_)
	slot2 = {}

	if not slot0.selectedPos then
		slot0.selectedPos = DormConst.DORM_FURTYPE_OFFSET
	end

	if slot0.selectedPos ~= DormConst.DORM_FURTYPE_OFFSET then
		for slot6, slot7 in ipairs(slot0.shopDataList_) do
			slot8 = getShopCfg(slot7.id).give_id

			if slot0.selectedPos == DormConst.DORM_SUIT_TYPE and BackHomeSuitCfg[slot8] or BackHomeFurniture[slot8] and slot0.selectedPos == BackHomeFurniture[slot8].type then
				table.insert(slot2, slot7)
			end
		end

		slot0.shopDataList_ = slot2
	end

	if slot1 and slot0.list_:GetNum() == #slot0.shopDataList_ then
		slot0.list_:Refresh()
	else
		slot0.list_:StartScroll(#slot0.shopDataList_)

		if #slot0.shopDataList_ == 0 then
			-- Nothing
		end
	end
end

function slot0.OnItemClick(slot0, slot1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnItemClick))
	slot2:SetData(slot0.shopDataList_[slot1])

	slot0.contentHeight = slot0.contentTrs_.rect.height
end

function slot0.ScrollByPosition(slot0, slot1, slot2)
	slot3 = nil

	if slot2 then
		for slot7, slot8 in ipairs(slot0.shopDataList_) do
			if slot8.id == slot2 then
				slot3 = slot7

				break
			end
		end
	end

	if slot3 ~= nil then
		slot0.list_:ScrollToIndex(slot3)
	elseif slot1 then
		slot0.list_:SetScrolledPosition(slot1)
	end
end

function slot0.GetLuaList(slot0)
	return slot0.list_
end

function slot0.GetItemList(slot0)
	return slot0.list_:GetItemList()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
