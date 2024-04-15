slot0 = class("RechargeSkinAllItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
	SetActive(slot0.gameObject_, true)
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skinItem = RechargeSkinNewItem.New(slot0.skinGo_)
	slot0.dlcItem = RechargeSkinDlcItem.New(slot0.dlcGo_)
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData(slot0.data[slot1])
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.shopCfg = getShopCfg(slot1.id)
	slot0.goodID = slot1.id
	slot0.dlcID = slot0.shopCfg.dlc or nil
	slot0.haveDlc = slot0.dlcID ~= nil and slot0.dlcID ~= 0
	slot0.isExchange = slot0.shopCfg.shop_refresh == 2
	slot0.shopID = slot0.shopCfg.shop_id
	slot3 = nil

	if slot0.shopCfg.description then
		slot0.isDesc = true
		slot0.itemCfg = RechargeShopDescriptionCfg[slot0.shopCfg.description]
		slot3 = slot0.itemCfg.param[1]
	else
		slot0.isDesc = false
		slot0.itemCfg = ItemCfg[slot0.shopCfg.give_id]
	end

	if slot3 and SkinCfg[slot3] then
		slot0.skinCfg = SkinCfg[slot3]
		slot0.skinID = slot3
		slot0.heroCfg = HeroCfg[slot0.skinCfg.hero]
	end

	if slot0.haveDlc then
		slot0.shopDlcCfg = getShopCfg(slot0.dlcID)
		slot0.itemDlcCfg = RechargeShopDescriptionCfg[slot0.shopDlcCfg.description]

		if slot0.itemDlcCfg == nil then
			slot0.itemDlcCfg = ItemCfg[getShopCfg(slot0.dlcID).give_id]
		end

		slot0.canBuyDlc = slot0.shopDlcCfg and ShopConst.SHOP_ID.DLC_SHOP == slot0.shopDlcCfg.shop_id
	end

	slot0.buyTime = ShopData.GetShop(slot0.shopID)[slot0.goodID] ~= nil and ShopData.GetShop(slot0.shopID)[slot0.goodID].buy_times or 0
	slot0.restNum = slot0.shopCfg.limit_num - slot0.buyTime
	slot0.index = slot2

	slot0:Show(true)
	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.skinItem:SetData(slot0.data)
	slot0.dlcItem:SetData(slot0.dlcID, slot0.skinID, slot0.goodID)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
	slot0:UpdateTimerView()
end

function slot0.UpdateTimerView(slot0)
	slot0.skinItem:UpdateTimerView()
	slot0.dlcItem:UpdateTimerView()
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0.skinItem:OnExit()
	slot0.dlcItem:OnExit()
end

function slot0.Dispose(slot0)
	slot0.skinItem:Dispose()
	slot0.dlcItem:Dispose()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

function slot0.GetItemHeight(slot0)
	return slot0.rectGo_.sizeDelta.x
end

function slot0.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot0.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot0.GetIndex(slot0)
	return slot0.index
end

function slot0.IsActive(slot0)
	return true
end

function slot0.IsTimeBar(slot0)
	return false
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
