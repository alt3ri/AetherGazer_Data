slot0 = class("ShopExchangeContentView", ShopContentViewBase)

function slot0.InitUI(slot0)
	slot1 = Asset.Load("Widget/System/Shop/contentViews/defaultView")
	slot1.name = "exchangeContentUI"
	slot0.gameObject_ = Object.Instantiate(slot1, slot0.containerGo_.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ExchangeItemView)
end

function slot0.RefreshList(slot0, slot1)
	uv0.super.RefreshList(slot0, slot1)

	slot0.shopDataList_ = slot0:GetExchangeGoodList(slot0.shopId_)

	if slot1 and slot0.list_:GetNum() == #slot0.shopDataList_ then
		slot0.list_:Refresh()
	else
		slot0.list_:StartScroll(#slot0.shopDataList_)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.shopDataList_[slot1])
end

function slot0.GetLuaList(slot0)
	return slot0.list_
end

function slot0.GetItemList(slot0)
	return slot0.list_:GetItemList()
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

function slot0.GetExchangeGoodList(slot0)
	return ShopTools.FilterShopDataList(slot0.shopId_, ShopListCfg[slot0.shopId_].chain_last_visible == 1)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
