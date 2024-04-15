slot1 = class("RechargeSkinNewItem", import("game.views.shop.base.ShopItemBase"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.isLimitTimeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isLimitTime")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.levelController_ = ControllerUtil.GetController(slot0.transform_, "level")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		SendMessageManagerToSDK("purchase_click_skin")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin = uv0.skinCfg.id
		})
		uv0:Go("/heroSkinPreview", {
			isShop = true,
			heroID = uv0.skinCfg.hero,
			skinID = uv0.skinCfg.id,
			goodId = uv0.goodID,
			shopID = uv0.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. uv0.skinCfg.id)
	end)
	slot0:AddBtnListener(slot0.bottomBtn_, nil, function ()
		SendMessageManagerToSDK("purchase_click_skin")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin = uv0.skinCfg.id
		})
		uv0:Go("/heroSkinPreview", {
			isShop = true,
			heroID = uv0.skinCfg.hero,
			skinID = uv0.skinCfg.id,
			goodId = uv0.goodID,
			shopID = uv0.shopID
		})
		OperationRecorder.RecordButtonTouch("buy_skin_button_" .. uv0.skinCfg.id)
	end)
	slot0:AddBtnListener(slot0.pcBtn_, nil, function ()
		ShowTips("PC_SHOP_TIPS2")
	end)
end

function slot1.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot1.UpdateTimerView(slot0)
	if #slot0.shopCfg.close_time > 0 then
		slot0.isLimitTimeController_:SetSelectedState("true")

		slot0.lastTimeLabel_.text = TimeMgr.GetInstance():parseTimeFromConfig(slot1.close_time)

		if TimeMgr.GetInstance():parseTimeFromConfig(slot1.close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if slot0.outOfDateHandler_ ~= nil then
				slot0.outOfDateHandler_(slot1.goods_id)
			end
		else
			slot0.lastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(slot3))
		end
	else
		slot0.isLimitTimeController_:SetSelectedState("false")

		slot0.lastTimeLabel_.text = ""
	end

	slot0:RefreshPriceUI(slot0.goodID)
end

function slot1.UpdateView(slot0)
	slot0.levelController_:SetSelectedState(tostring(slot0.skinCfg.skin_level))

	if ShopTools.HaveSkin(slot0.skinCfg.id) or HeroTools.CanChangeSkin(slot0.skinCfg.id) then
		slot0.bgBtn_.interactable = false
	else
		slot0.bgBtn_.interactable = true
	end

	slot0:RefreshCommonUI()
	slot0:RefreshPriceUI(slot0.goodID)
end

function slot1.RefreshCommonUI(slot0)
	slot0.nameLabel_.text = string.format("%s", slot0.skinCfg.name)
	slot0.titleLabel_.text = ItemTools.getItemName(ItemCfg[slot0.skinCfg.hero].id)
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.skinCfg.picture_id)
end

function slot1.RefreshPriceUI(slot0, slot1)
	slot0:UpdatePrice(slot1)

	if ShopTools.HaveSkin(slot0.skinCfg.id) or HeroTools.CanChangeSkin(slot0.skinCfg.id) then
		slot0.statusController_:SetSelectedState("sellout")
	else
		slot0.statusController_:SetSelectedState(slot0.shopCfg.give_back_list and #slot0.shopCfg.give_back_list > 0 and "back" or "normal")
	end

	if slot0.shopCfg.give_back_list and #slot0.shopCfg.give_back_list > 0 then
		slot0.rebackTxt_.text = slot0.shopCfg.give_back_list[1].num
		slot0.rebackSkinIcon_.sprite = ItemTools.getItemSprite(slot0.shopCfg.give_back_list[1].id)
	end
end

function slot1.UpdatePrice(slot0, slot1)
	slot2 = getShopCfg(slot1)
	slot3, slot4, slot5 = ShopTools.GetPrice(slot1)
	slot0.moneyTxt_.text = ShopTools.GetMoneySymbol(slot1)

	if slot3 <= 0 then
		slot0.costTypeController_:SetSelectedState("free")
	else
		if ShopTools.IsRMB(slot1) then
			slot0.priceText_.text = slot3

			if ShopTools.IsPC() then
				slot0.priceText_.text = GetTips("PC_SHOP_TIPS3")
			end
		else
			slot0:SetCostIcon()
			slot0:SetPriceText(slot1)
		end

		slot0.costTypeController_:SetSelectedState(ShopTools.IsRMB(slot1) and "money" or "currency")
	end

	SetActive(slot0.superValueGo_, slot2.tag == ShopConst.TAGS.SUPER_VALUE)

	slot0.oldPriceLabel_.text = slot4
	slot6, slot7, slot8 = ShopTools.IsOnDiscountArea(slot0.goodID)

	if slot6 and slot8 then
		SetActive(slot0.limitDiscountGo_, slot0.shopCfg.is_limit_time_discount == 1)
		SetActive(slot0.oldPriceLabel_.gameObject, slot3 ~= slot4 and slot7 and ShopTools.IsPC() == false)
	else
		SetActive(slot0.limitDiscountGo_, false)
		SetActive(slot0.oldPriceLabel_.gameObject, false)
	end

	if ShopTools.IsRMB(slot1) and ShopTools.IsPC() then
		slot0.priceText_.text = GetTips("PC_SHOP_TIPS3")
		slot0.moneyTxt_.text = ""
	end

	SetActive(slot0.discountGo_, false)
end

return slot1
