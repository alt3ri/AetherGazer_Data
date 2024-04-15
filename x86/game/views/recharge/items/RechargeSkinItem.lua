slot1 = class("RechargeSkinItem", import("game.views.shop.base.ShopItemBase"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isOnDiscountAreaController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isOnDiscountArea")
	slot0.isDiscountController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isDiscount")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.tipController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "tip")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.isLimitTimeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isLimitTime")
	slot0.dlcController_ = ControllerUtil.GetController(slot0.transform_, "dlc")
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

		if uv0.canBuyDlc then
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = uv0.goodID,
				heroID = uv0.skinCfg.hero,
				skinID = uv0.skinCfg.id,
				shopID = uv0.shopID
			}, ViewConst.SYSTEM_ID.SHOP)
		else
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = uv0.goodID,
				heroID = uv0.skinCfg.hero,
				skinID = uv0.skinCfg.id,
				shopID = uv0.shopID
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	end)
	slot0:AddBtnListener(nil, slot0.jumpBtn_, function ()
		if uv0.canBuyDlc == false then
			JumpTools.GoToSystem("/shop", {
				shopId = getShopCfg(uv0.dlcID).shop_id
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	slot0:AddBtnListener(slot0.pcBtn_, nil, function ()
		ShowTips("PC_SHOP_TIPS2")
	end)
end

function slot1.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot1.UpdateTimerView(slot0)
	slot1 = slot0.shopCfg

	if slot0.haveDlc and (ShopTools.HaveSkin(slot0.skinCfg.id) or HeroTools.CanChangeSkin(slot0.skinCfg.id)) then
		slot1 = slot0.shopDlcCfg
	end

	if #slot1.close_time > 0 then
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

	slot2, slot3, slot4 = ShopTools.IsOnDiscountArea(slot1.goods_id)

	if slot3 and slot4 and slot2 then
		slot0.isOnDiscountAreaController_:SetSelectedState("true")

		if TimeMgr.GetInstance():parseTimeFromConfig(slot1.cheap_close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.discountLastTimeLabel_.text = "0" .. GetTips("SECOND")
		else
			slot0.discountLastTimeLabel_.text = string.format("%s", manager.time:GetLostTimeStr(slot6))
		end
	else
		slot0.isOnDiscountAreaController_:SetSelectedState("false")

		slot0.discountLastTimeLabel_.text = ""
	end
end

function slot1.UpdateView(slot0)
	slot0.levelController_:SetSelectedState(tostring(slot0.skinCfg.skin_level))

	if ShopTools.HaveSkin(slot0.skinCfg.id) or HeroTools.CanChangeSkin(slot0.skinCfg.id) then
		if slot0.haveDlc and not ShopTools.CheckDlcPurchased(slot0.dlcID) then
			slot0.statusController_:SetSelectedState("normal")

			slot0.bgBtn_.interactable = true
			slot0.bottomBtn_.interactable = true

			slot0:RefreshDlcUI()
		else
			slot0.statusController_:SetSelectedState("sellout")

			slot0.bgBtn_.interactable = false
			slot0.bottomBtn_.interactable = false

			slot0:RefreshCommonUI()
		end
	else
		slot0.statusController_:SetSelectedState("normal")

		slot0.bgBtn_.interactable = true
		slot0.bottomBtn_.interactable = true

		slot0:RefreshCommonUI()
	end

	slot0.dlcController_:SetSelectedIndex(slot0.haveDlc and 1 or 0)

	if slot0.haveDlc then
		slot0.dlcImg_.sprite = ItemTools.getItemSprite(slot0.itemDlcCfg.id)
	end

	slot0:UpdateSkinPrice()

	if ShopTools.IsPC() then
		SetActive(slot0.pcBtn_.gameObject, ShopTools.IsRMB(slot0.goodID))
		SetActive(slot0.bottomGo_, ShopTools.IsRMB(slot0.goodID) == false)
	end
end

function slot1.RefreshCommonUI(slot0)
	slot0.nameLabel_.text = string.format("%s", slot0.skinCfg.name)
	slot0.titleLabel_.text = ItemTools.getItemName(ItemCfg[slot0.skinCfg.hero].id)
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.skinCfg.picture_id)
	slot2, slot3, slot4 = ShopTools.IsOnDiscountArea(slot0.goodID)

	if slot2 and slot4 then
		slot0.tipController_:SetSelectedState(slot3 and "time_limit_discount" or "discount")
	else
		slot0.tipController_:SetSelectedState(slot0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE and "superValue" or "none")
	end
end

function slot1.RefreshDlcUI(slot0)
	slot0.nameLabel_.text = GetI18NText(slot0.itemCfg.name)
	slot0.titleLabel_.text = ""

	if slot0.itemCfg and ItemConst.ITEM_TYPE.SCENE == slot0.itemCfg.type then
		slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.itemCfg.param[1])
	else
		slot0.icon_.sprite = nil
	end

	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.dlcID)

	if slot1 and slot3 then
		slot0.tipController_:SetSelectedState(slot2 and "time_limit_discount" or "discount")
	else
		slot0.tipController_:SetSelectedState(slot0.shopDlcCfg.tag == ShopConst.TAGS.SUPER_VALUE and "superValue" or "none")
	end
end

function slot1.UpdateSkinPrice(slot0)
	if ShopTools.HaveSkin(slot0.skinCfg.id) or HeroTools.CanChangeSkin(slot0.skinCfg.id) then
		if slot0.haveDlc and not ShopTools.CheckDlcPurchased(slot0.dlcID) then
			if slot0.canBuyDlc then
				slot0:RefreshPriceUI(slot0.dlcID)
			else
				SetActive(slot0.rebackSkinIcon_.gameObject, #slot0.shopDlcCfg.give_back_list > 0)
				slot0.costTypeController_:SetSelectedState("jump")
			end
		else
			slot0:RefreshPriceUI(slot0.goodID)
		end
	else
		slot0:RefreshPriceUI(slot0.goodID)
	end
end

function slot1.RefreshPriceUI(slot0, slot1)
	slot0:UpdatePrice(slot1)
	SetActive(slot0.rebackSkinIcon_.gameObject, #getShopCfg(slot1).give_back_list > 0)
end

function slot1.IsOnDiscountArea(slot0, slot1)
	slot3, slot4, slot5 = ShopTools.IsOnDiscountArea(getShopCfg(slot1).goods_id)

	if slot3 and slot5 then
		return true
	else
		return false
	end
end

return slot1
