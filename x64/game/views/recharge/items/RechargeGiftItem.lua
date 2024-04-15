slot1 = class("RechargeGiftItem", import("game.views.shop.base.ShopItemBase"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveTimeLimitController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveTimeLimit")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.tipController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "tip")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if ShopTools.IsPC() and ShopTools.IsRMB(uv0.goodID) then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		SendMessageManagerToSDK("purchase_click_gp_once")

		if uv0.statusController_:GetSelectedState() == "normal" then
			if uv0.itemCfg.type == ItemConst.ITEM_TYPE.GIFT and uv0.itemCfg.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
				JumpTools.OpenPageByJump("rechargeFukubukuro", {
					goodID = uv0.goodID,
					shopID = uv0.shopID
				})
			else
				JumpTools.OpenPageByJump("rechargeGiftPop", {
					goodId = uv0.goodID,
					buyTime = uv0.buyTime,
					itemCfg = ItemCfg[uv0.shopCfg.give_id],
					shopId = uv0.shopID,
					shopCfg = uv0.shopCfg,
					itemDesCfg_ = uv0.itemCfg
				})
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox = uv0.goodID
		})
	end)

	if slot0.buttonBtn_ then
		slot0:AddBtnListener(slot0.buttonBtn_, nil, function ()
			if ShopTools.IsPC() and ShopTools.IsRMB(uv0.goodID) then
				ShowTips("PC_SHOP_TIPS2")

				return
			end

			SendMessageManagerToSDK("purchase_click_gp_once")

			if uv0.statusController_:GetSelectedState() == "normal" then
				if uv0.itemCfg.type == ItemConst.ITEM_TYPE.GIFT and uv0.itemCfg.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
					JumpTools.OpenPageByJump("rechargeFukubukuro", {
						goodID = uv0.goodID,
						shopID = uv0.shopID
					})
				else
					JumpTools.OpenPageByJump("rechargeGiftPop", {
						goodId = uv0.goodID,
						buyTime = uv0.buyTime,
						itemCfg = ItemCfg[uv0.shopCfg.give_id],
						shopId = uv0.shopID,
						shopCfg = uv0.shopCfg,
						itemDesCfg_ = uv0.itemCfg
					})
				end
			end

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_giftbox = uv0.goodID
			})
		end)
	end
end

function slot1.UpdateTimerView(slot0)
	if #slot0.shopCfg.close_time > 0 and slot0.restNum ~= 0 then
		slot0.haveTimeLimitController_:SetSelectedState("true")

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg.close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if slot0.outOfDateHandler_ ~= nil then
				slot0.outOfDateHandler_(slot0.goodID)
			end
		else
			slot0.lastTimeLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(slot2))
		end
	else
		slot0.haveTimeLimitController_:SetSelectedState("false")

		slot0.lastTimeLabel_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.countdownTransform_)
	slot0:UpdatePrice(slot0.goodID)
end

function slot1.SetOutOfDateHandler(slot0, slot1)
	slot0.outOfDateHandler_ = slot1
end

function slot1.UpdatePrice(slot0)
	slot1, slot0.oldPriceLabel_.text, slot3 = ShopTools.GetPrice(slot0.goodID)
	slot0.moneyTxt_.text = ShopTools.GetMoneySymbol(slot0.goodID)

	if slot1 <= 0 then
		slot0.costTypeController_:SetSelectedState("free")
		SetActive(slot0.oldPriceLabel_.gameObject, false)
	else
		if ShopTools.IsRMB(slot0.goodID) then
			slot0.priceText_.text = slot1
		else
			slot0:SetCostIcon()
			slot0:SetPriceText(slot0.goodID)
		end

		slot0.costTypeController_:SetSelectedState(ShopTools.IsRMB(slot0.goodID) and "money" or "currency")
	end

	SetActive(slot0.superValueGo_, slot0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE and slot0.restNum ~= 0)

	slot4, slot5, slot6 = ShopTools.IsOnDiscountArea(slot0.goodID)

	if slot4 and slot6 and slot0.restNum ~= 0 then
		SetActive(slot0.limitDiscountGo_, slot0.shopCfg.is_limit_time_discount == 1)
		SetActive(slot0.oldPriceLabel_.gameObject, slot1 ~= slot2 and slot5)

		slot0.discountLabel_.text = ShopTools.GetDiscountLabel(slot0.goodID)

		SetActive(slot0.discountGo_, true)
	else
		SetActive(slot0.limitDiscountGo_, false)
		SetActive(slot0.oldPriceLabel_.gameObject, false)
		SetActive(slot0.discountGo_, false)
	end

	if ShopTools.IsRMB(slot0.goodID) and ShopTools.IsPC() then
		slot0.priceText_.text = GetTips("PC_SHOP_TIPS3")
		slot0.moneyTxt_.text = ""
	end
end

function slot1.UpdateView(slot0)
	slot0.nameLabel_.text = string.format("%s", GetI18NText(slot0.itemCfg.name))
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/PrizeItem/" .. slot0.itemCfg.icon)
	slot1 = ShopTools.CheckSoldOut(slot0.goodID)
	slot2 = ShopTools.CheckLevelEnough(slot0.goodID)
	slot3 = false

	if slot0.shopCfg.limit_num ~= nil and slot0.shopCfg.limit_num ~= -1 then
		slot0.limitLabel_.text = string.format("%d/%d", slot0.shopCfg.limit_num - slot0.buyTime, slot0.shopCfg.limit_num)
		slot0.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot0.shopCfg.refresh_cycle])
	else
		slot0.limitLabel_.text = " "
		slot0.limitTitle_.text = ""
	end

	if ShopTools.CheckGiftSkinOwn(slot0.goodID) then
		slot0.statusController_:SetSelectedState("soldout")

		slot0.soldTxt_.text = GetTips("ALREADY_GET")
	elseif slot1 then
		slot0.statusController_:SetSelectedState("soldout")

		slot0.soldTxt_.text = GetTips("SELL_OUT")
	elseif not slot2 then
		slot0.statusController_:SetSelectedState("locked")

		slot0.lockLabel_.text = string.format(GetTips("PLAYER_LEVEL_UNLOCK_SHOP_GOODS"), slot0.shopCfg.level_limit[1][2] or slot0.shopCfg.level_limit[1].num)
	else
		slot0.statusController_:SetSelectedState("normal")
	end

	slot0:UpdatePrice()

	slot4, slot5, slot6 = ShopTools.GetPrice(slot0.goodID)

	if slot4 <= 0 and not slot1 and slot2 then
		slot3 = true
	end

	SetActive(slot0.redPointGo_, slot3 and not OperationData:IsFunctionStoped(slot0.shopCfg.operation_stop_id))
end

return slot1
