slot0 = class("EquipGoodsItem", ShopItemBase)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItemView.New(slot0.commonGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		uv0:ClickFunction()
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index = slot2
	slot0.data = slot1
	slot0.shopCfg = getShopCfg(slot1.id)
	slot0.goodID = slot1.id
	slot0.dlcID = slot0.shopCfg.dlc or nil
	slot0.haveDlc = slot0.dlcID ~= nil and slot0.dlcID ~= 0
	slot0.isExchange = slot0.shopCfg.shop_refresh == 2
	slot0.shopID = slot1.shopId
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

		slot0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == slot0.shopDlcCfg.shop_id
	end

	slot0.buyTime = ShopData.GetShop(slot0.shopID)[slot0.goodID] ~= nil and ShopData.GetShop(slot0.shopID)[slot0.goodID].buy_times or 0
	slot0.restNum = slot0.shopCfg.limit_num - slot0.data.buyTime

	slot0:UpdateView()
	slot0:UpdateTimerView()
end

function slot0.UpdateView(slot0)
	slot0:SetCommonItem()
	slot0:SetCostIcon()
	slot0:SetPriceText(slot0.goodID)

	slot0.titleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/com_equip_icon_0" .. slot0.index)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
