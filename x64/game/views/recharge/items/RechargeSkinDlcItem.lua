slot1 = class("RechargeSkinDlcItem", import("game.views.shop.base.ShopItemBase"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.isLimitTimeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "isLimitTime")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		SendMessageManagerToSDK("purchase_click_skin")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin = uv0.skinCfg.id
		})

		if ShopConst.SHOP_ID.DLC_SHOP ~= uv0.shopCfg.shop_id then
			ShowMessageBox({
				content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(uv0.shopCfg.give_id)),
				OkCallback = function ()
					JumpTools.GoToSystem("/shop", {
						shopId = uv0.shopID,
						goodId = uv0.goodID
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			})
		else
			uv0:Go("/heroSkinPreview", {
				isShop = true,
				isDlc = true,
				heroID = uv0.skinCfg.hero,
				skinID = uv0.skinCfg.id,
				shopID = uv0.shopID
			})
			OperationRecorder.RecordButtonTouch("buy_skin_button_" .. uv0.goodID)
		end
	end)
end

function slot1.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot1.SetData(slot0, slot1, slot2, slot3)
	slot0.shopCfg = getShopCfg(slot1)
	slot0.goodID = slot1
	slot0.skinGoodId = slot3
	slot0.shopID = slot0.shopCfg.shop_id
	slot0.skinId = slot2
	slot0.skinCfg = SkinCfg[slot2]
	slot0.canBuyDlc = ShopConst.SHOP_ID.DLC_SHOP == slot0.shopCfg.shop_id and ShopTools.CheckDlcPurchased(slot1) == false
	slot0.itemCfg = RechargeShopDescriptionCfg[slot0.shopCfg.description]

	if slot0.itemCfg == nil then
		slot0.itemCfg = ItemCfg[slot0.shopCfg.give_id]
	end

	slot0:UpdateView()
	slot0:UpdateTimerView()
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

	slot0:RefreshCommonUI()
	slot0:RefreshPriceUI()
end

function slot1.UpdateView(slot0)
	slot0:RefreshPriceUI()
	slot0:RefreshCommonUI()

	slot0.nameLabel_.text = string.format("%s", slot0.itemCfg.name)
	slot0.titleLabel_.text = ItemTools.getItemName(ItemCfg[slot0.skinCfg.hero].id)
	slot0.dlcImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.itemCfg.id)

	if ShopTools.IsPC() then
		SetActive(slot0.pcBtn_.gameObject, ShopTools.IsRMB(slot0.goodID))
	end
end

function slot1.RefreshCommonUI(slot0)
	SetActive(slot0.discountGo_, false)
	SetActive(slot0.superValueGo_, slot0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.goodID)

	if slot1 and slot3 and #slot0.shopCfg.cheap_close_time > 0 then
		SetActive(slot0.limitDiscountGo_, slot0.shopCfg.is_limit_time_discount == 1)
	else
		SetActive(slot0.limitDiscountGo_, false)
	end
end

function slot1.RefreshPriceUI(slot0, slot1)
	if ShopConst.SHOP_ID.DLC_SHOP == slot0.shopCfg.shop_id and ShopTools.CheckDlcPurchased(slot0.goodID) == false then
		slot0.statusController_:SetSelectedState(slot0.shopCfg.give_back_list and #slot0.shopCfg.give_back_list > 0 and "back" or "normal")
	elseif ShopTools.CheckDlcPurchased(slot0.goodID) == false then
		slot0.statusController_:SetSelectedState("normal")
	else
		slot0.statusController_:SetSelectedState("sellout")
	end

	if slot0.shopCfg.give_back_list and #slot0.shopCfg.give_back_list > 0 then
		slot0.rebackTxt_.text = slot0.shopCfg.give_back_list[1].num
	end
end

return slot1
