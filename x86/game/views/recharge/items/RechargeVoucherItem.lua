slot1 = class("RechargeVoucherItem", import("game.views.shop.base.ShopItemBase"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_ticket = uv0.goodID
		})
		JumpTools.OpenPopUp("rechargeDiamondExchange", {
			defaultNum = 0,
			getBaseNum = 1,
			useBaseNum = uv0.shopCfg.cost,
			useId = uv0.shopCfg.cost_id,
			getId = uv0.itemCfg.id,
			exchangeId = uv0.goodID,
			buy_source = PayConst.BUY_SOURCE_DRAW_SHOP
		}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
	end)
end

function slot1.UpdateView(slot0)
	slot0.nameLabel_.text = ItemTools.getItemName(slot0.itemCfg.id)
	slot0.image_.sprite = ItemTools.getItemSprite(slot0.itemCfg.id)
	slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg.cost_id)
	slot0.costLabel_.text = slot0.shopCfg.cost
end

return slot1
