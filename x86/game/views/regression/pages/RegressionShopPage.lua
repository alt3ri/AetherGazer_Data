slot1 = class("RegressionShopPage", import("game.views.shop.base.ShopContentViewBase"))

function slot1.OnCtor(slot0, slot1)
	slot3 = Object.Instantiate(Asset.Load("UI/ReturnUI/RegressionShopUI"), slot1)
	slot0.gameObject_ = slot3
	slot0.transform_ = slot3.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ExchangeItemView)
end

function slot1.AddUIListener(slot0)
end

function slot1.SetData(slot0)
	slot0:SetShopId(25)
	slot0:RefreshList()
end

function slot1.RefreshList(slot0, slot1)
	slot0:UpdateBarByShopId()

	slot0.shopDataList_ = slot0:GetShopGoodList(slot0.shopId_)

	if slot1 and slot0.list_:GetNum() == #slot0.shopDataList_ then
		slot0.list_:Refresh()
	else
		slot0.list_:StartScroll(#slot0.shopDataList_)
	end
end

function slot1.IndexItem(slot0, slot1, slot2)
	slot2:RegistCallBack(handler(slot0, slot0.OnShopClick))
	slot2:SetData(slot0.shopDataList_[slot1])
end

function slot1.GetLuaList(slot0)
	return slot0.list_
end

function slot1.GetItemList(slot0)
	return slot0.list_:GetItemList()
end

function slot1.ScrollByPosition(slot0, slot1, slot2)
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

function slot1.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
