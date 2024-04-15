slot1 = class("RechargeGiftPopLinkView", import("game.views.recharge.RechargeGiftPopView"))

function slot1.OnEnter(slot0)
	slot1 = slot0.params_.shopId
	slot2 = slot0.params_.goodId
	slot3 = getShopCfg(slot2, slot1)
	slot0.params_.itemCfg = ItemCfg[slot3.give_id]
	slot0.params_.shopCfg = slot3
	slot0.params_.itemDesCfg_ = RechargeShopDescriptionCfg[slot3.description]
	slot0.params_.buyTime = ShopData.GetShop(slot1)[slot2] ~= nil and ShopData.GetShop(slot1)[slot2].buy_times or 0

	uv0.super.OnEnter(slot0)
end

return slot1
