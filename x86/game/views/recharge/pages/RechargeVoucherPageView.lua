slot1 = class("RechargeVoucherPageView", import("game.views.recharge.pages.RechargePageBase"))

function slot1.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.shopID = slot3

	slot0:Init()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RechargeVoucherItem)
end

function slot1.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.shopDataList_[slot1])
end

function slot1.AddUIListener(slot0)
end

function slot1.OnTop(slot0)
end

function slot1.OnEnter(slot0)
	slot0.shopDataList_ = slot0:InitDataList()

	slot0.list_:StartScroll(#slot0.shopDataList_)
end

function slot1.OnExit(slot0)
end

function slot1.Hide(slot0)
	uv0.super.Hide(slot0)
end

function slot1.InitDataList(slot0)
	slot1 = ShopTools.FilterShopDataList(slot0.shopID)

	table.sort(slot1, function (slot0, slot1)
		return getShopCfg(slot0.id).goods_id < getShopCfg(slot1.id).goods_id
	end)

	return slot1
end

function slot1.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
