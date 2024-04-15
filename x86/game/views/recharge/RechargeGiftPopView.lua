slot0 = class("RechargeGiftPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeGiftPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.immeRewardItemList_ = {}
	slot0.immeRewardItemList2_ = {}
	slot0.dailyRewardItemList_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "rewardType")
	slot0.costTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "costType")
	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, RechargeGiftPopItem)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.itemDesCfg.param[slot1][1], slot0.itemDesCfg.param[slot1][2])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		SendMessageManagerToSDK("purchase_click_gp_once")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox_buy = uv0.goodID
		})

		if OperationData:IsFunctionStoped(ShopListCfg[uv0.shopID].operation_stop_id) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		if ShopTools.IsRMB(uv0.goodID) then
			slot1 = nil

			PayAction.RequestGSPay(((not uv0:IsOnDiscountArea() or PaymentCfg[uv0.shopCfg.cheap_cost_id]) and PaymentCfg[uv0.shopCfg.cost_id]).id, uv0.selectNum, uv0.shopCfg.shop_id, uv0.shopCfg.goods_id, nil, uv0.params_.buy_source or 0)
		else
			slot1 = uv0.params_.buy_source or 0

			if ShopTools.GetPrice(uv0.goodID) == 0 then
				uv0:Back()
				ShopAction.BuyItem({
					{
						goodID = uv0.goodID,
						buyNum = uv0.selectNum
					}
				}, nil, slot1)

				return
			end

			ShopTools.ConfirmBuyItem(uv0.goodID, uv0.selectNum, function ()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 0
				})
				uv0:Back()
			end, function ()
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_giftbox_check = 1
				})
				uv0:UpdateRealtimePrice()
				uv0:UpdatePreview()
			end, slot1)
		end
	end)
	slot0.useNumSlider_.onValueChanged:AddListener(function ()
		uv0.selectNum = uv0.useNumSlider_.value

		if uv0.selectNum < 1 then
			uv0.selectNum = 1

			uv0:UpdateSliderPositionBySelectNum()
		end

		uv0:UpdateDelAddBtn()
		uv0:UpdatePreview()
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum > 1 then
			uv0.selectNum = uv0.selectNum - 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.selectNum < uv0.canUseMaxNum_ then
			uv0.selectNum = uv0.selectNum + 1

			uv0:UpdateSliderPositionBySelectNum()
			uv0:UpdateDelAddBtn()
			uv0:UpdatePreview()

			return true
		end

		return false
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("SHOP_GIFT_DESCRIBE"),
			content = uv0.itemDesCfg.desc2
		})
	end)
end

function slot0.UpdateDelAddBtn(slot0)
	slot0.delBtn_.interactable = slot0.selectNum > 1
	slot0.addBtn_.interactable = slot0.selectNum < slot0.canUseMaxNum_
end

function slot0.UpdateSliderPositionBySelectNum(slot0)
	slot0.useNumSlider_.value = slot0.selectNum
end

function slot0.UpdateRealtimePrice(slot0)
	slot0.price_, slot0.oldPrice_, slot0.pricePercent_ = ShopTools.GetPrice(slot0.goodID)
end

function slot0.UpdatePreview(slot0)
	slot0.buyNumLabel_.text = tostring(slot0.selectNum)

	if slot0.price_ * slot0.selectNum <= 0 then
		slot0.costTypeController_:SetSelectedState("free")
	elseif ShopTools.IsRMB(slot0.goodID) then
		slot0.costTypeController_:SetSelectedState("money")

		slot0.totleLabel_.text = slot1
		slot0.rmbLabel_.text = "¥"
	else
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costIcon_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg.cost_id)
		slot0.totleLabel_.text = slot1
	end
end

function slot0.UpdateBar(slot0)
	if slot0.shopID == 1050 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
	slot0:UpdateView()
	slot0:UpdatePreview()
end

function slot0.OnEnter(slot0)
	slot0.itemCfg = slot0.params_.itemCfg
	slot0.goodID = slot0.params_.goodId
	slot0.buyTime = slot0.params_.buyTime
	slot0.shopID = slot0.params_.shopId
	slot0.shopCfg = slot0.params_.shopCfg
	slot0.itemDesCfg = slot0.params_.itemDesCfg_
	slot0.selectNum = 1
	slot0.multipleScrollRect_.verticalNormalizedPosition = 1

	slot0:UpdateRealtimePrice()

	slot0.canUseMaxNum_ = slot0:GetMaxNum()

	slot0:UpdateView()
	slot0:UpdateTimer()

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.useNumSlider_.value = 1

	slot0.timer_:Start()
	slot0:UpdateDelAddBtn()
	slot0:UpdatePreview()
	slot0:AddEventListeners()
end

function slot0.UpdateTimer(slot0)
	if #slot0.shopCfg.close_time > 0 then
		SetActive(slot0.remainTimeGo_, true)

		if TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg.close_time) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.remainTimeTxt_.text = GetTips("TIP_EXPIRED")
		else
			slot0.remainTimeTxt_.text = manager.time:GetLostTimeStr(slot2)
		end
	else
		SetActive(slot0.remainTimeGo_, false)
	end

	if slot0:IsOnDiscountArea() then
		SetActive(slot0.discountGo_, true)

		slot0.tipLabel_.text = ShopTools.GetDiscountLabel(slot0.shopCfg.goods_id)

		if #slot0.shopCfg.cheap_close_time > 0 then
			slot0.lastLabel_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopCfg.cheap_close_time))

			SetActive(slot0.limitTimeGo_, slot0.shopCfg.is_limit_time_discount == 1)
			SetActive(slot0.discountLimitTimeGo_, slot0.shopCfg.is_limit_time_discount == 1)
		else
			SetActive(slot0.limitTimeGo_, false)
			SetActive(slot0.discountLimitTimeGo_, false)
		end
	else
		SetActive(slot0.limitTimeGo_, false)
		SetActive(slot0.discountGo_, false)
		SetActive(slot0.limitTimeGo_, false)
		SetActive(slot0.discountLimitTimeGo_, false)
	end
end

function slot0.UpdateView(slot0)
	slot0.useNumSlider_.maxValue = slot0.canUseMaxNum_
	slot0.nameLabel_.text = GetI18NText(slot0.itemDesCfg.name)
	slot0.image_.sprite = getSpriteWithoutAtlas("TextureConfig/PrizeItem/" .. slot0.itemDesCfg.icon)

	slot0.image_:SetNativeSize()

	if slot0.shopCfg.limit_num ~= nil and slot0.shopCfg.limit_num ~= -1 then
		slot0.limitLabel_.text = string.format("%d/%d", slot0.shopCfg.limit_num - slot0.buyTime, slot0.shopCfg.limit_num)
		slot0.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot0.shopCfg.refresh_cycle])
	else
		slot0.limitLabel_.text = " "
		slot0.limitTitle_.text = " "
	end

	SetActive(slot0.limitGo_, slot0.shopCfg.limit_num ~= nil and slot0.shopCfg.limit_num ~= -1)
	SetActive(slot0.surperValue, slot0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE)

	if slot0.itemDesCfg.desc2 ~= "" then
		slot0.rewardTypeController_:SetSelectedState("value_2")

		slot0.descText_.text = slot0.itemDesCfg.desc
		slot1 = slot0.itemDesCfg.param[1] or {}

		for slot5, slot6 in ipairs(slot1) do
			if slot5 <= #slot0.immeRewardItemList2_ then
				slot0.immeRewardItemList2_[slot5]:SetData(slot6[1], slot6[2])
			else
				slot8 = RechargeGiftPopItem.New(Object.Instantiate(slot0.GiftPopItemPrefab_, slot0.itemParent2_))

				slot8:SetData(slot6[1], slot6[2])
				table.insert(slot0.immeRewardItemList2_, slot8)
			end
		end

		while #slot1 < #slot0.immeRewardItemList2_ do
			slot0.immeRewardItemList2_[#slot0.immeRewardItemList2_]:Dispose()
			table.remove(slot0.immeRewardItemList2_, #slot0.immeRewardItemList2_)
		end
	elseif slot0.itemDesCfg.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		slot0.rewardTypeController_:SetSelectedState("normal")
		slot0.list_:StartScroll(#slot0.itemDesCfg.param)
	elseif slot0.itemDesCfg.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
		slot0.rewardTypeController_:SetSelectedState("multiple")

		if #(slot0.itemDesCfg.param[1] or {}) > 0 then
			for slot5, slot6 in ipairs(slot1) do
				if slot5 <= #slot0.immeRewardItemList_ then
					slot0.immeRewardItemList_[slot5]:SetData(slot6[1], slot6[2])
				else
					slot8 = RechargeGiftPopItem.New(Object.Instantiate(slot0.GiftPopItemPrefab_, slot0.immeList_))

					slot8:SetData(slot6[1], slot6[2] * slot0.shopCfg.give)
					table.insert(slot0.immeRewardItemList_, slot8)
				end
			end

			SetActive(slot0.immeLabelGo_, true)
		else
			SetActive(slot0.immeLabelGo_, false)
		end

		while #slot1 < #slot0.immeRewardItemList_ do
			slot0.immeRewardItemList_[#slot0.immeRewardItemList_]:Dispose()
			table.remove(slot0.immeRewardItemList_, #slot0.immeRewardItemList_)
		end

		slot7 = slot0.itemDesCfg.param[3]
		slot0.dailyLabel_.text = string.format(GetTips("CONSECUTIVE_DAYS"), tostring(slot7))

		for slot7, slot8 in ipairs(slot0.itemDesCfg.param[2]) do
			if slot7 <= #slot0.dailyRewardItemList_ then
				slot0.dailyRewardItemList_[slot7]:SetData(slot8[1], slot8[2])
			else
				slot10 = RechargeGiftPopItem.New(Object.Instantiate(slot0.GiftPopItemPrefab_, slot0.dailyList_))

				slot10:SetData(slot8[1], slot8[2])
				table.insert(slot0.dailyRewardItemList_, slot10)
			end
		end

		while #slot3 < #slot0.dailyRewardItemList_ do
			slot0.dailyRewardItemList_[#slot0.dailyRewardItemList_]:Dispose()
			table.remove(slot0.dailyRewardItemList_, #slot0.dailyRewardItemList_)
		end

		if slot0.layoutTimer_ == nil then
			slot0.layoutTimer_ = Timer.New(function ()
				LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.multipleContainer_)
				uv0.layoutTimer_:Stop()

				uv0.layoutTimer_ = nil
			end, 0.05)
		end

		slot0.layoutTimer_:Start()
	end

	slot0.useNumSlider_.minValue = 0

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.dailyList_)
end

function slot0.GetMaxNum(slot0)
	slot1 = 1

	if slot0.shopCfg.limit_num ~= nil and slot0.shopCfg.limit_num ~= -1 then
		slot1 = slot0.shopCfg.limit_num - slot0.buyTime
	end

	if slot1 < 1 then
		slot1 = 1
	end

	return slot1
end

function slot0.OnShopBuyResult(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = getShopCfg(slot2)

		slot0:Back()

		if RechargeShopDescriptionCfg[slot3.goods_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					id = slot4,
					num = slot3.give
				}
			}, {
				ItemConst.ITEM_TYPE.HERO_SKIN
			})
		elseif slot6 == ItemConst.ITEM_TYPE.EQUIP then
			if EquipData:GetEquipBagFull() then
				showEquipSendMail(nil)
				EquipAction.EquipBagFull(false)
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		else
			ShowTips("TRANSACTION_SUCCESS")
		end
	elseif slot1 == 899 then
		ShowMessageBox({
			content = GetTips("EQUIP_NUM_MAX"),
			OkCallback = function ()
				JumpTools.GoToSystem("/bag", {
					type = "equip"
				}, ViewConst.SYSTEM_ID.BAG)
			end
		})
	elseif slot1 == 406 then
		ShowTips("ITEM_INVALID")
	elseif slot1 then
		ShowTips(slot1)
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		slot1 = nil
		slot1 = (not uv0:IsOnDiscountArea() or PaymentCfg[uv0.shopCfg.cheap_cost_id]) and PaymentCfg[uv0.shopCfg.cost_id]

		if slot0 == uv0.shopCfg.cheap_cost_id or slot0 == uv0.shopCfg.cost_id then
			uv0:Back()
		end
	end)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.IsOnDiscountArea(slot0)
	slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.shopCfg.goods_id)

	if slot1 and slot3 then
		return true
	else
		return false
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	if slot0.immeRewardItemList_ then
		for slot4, slot5 in ipairs(slot0.immeRewardItemList_) do
			slot5:Dispose()
		end

		slot0.immeRewardItemList_ = nil
	end

	if slot0.immeRewardItemList2_ then
		for slot4, slot5 in ipairs(slot0.immeRewardItemList2_) do
			slot5:Dispose()
		end

		slot0.immeRewardItemList2_ = nil
	end

	if slot0.dailyRewardItemList_ then
		for slot4, slot5 in ipairs(slot0.dailyRewardItemList_) do
			slot5:Dispose()
		end

		slot0.dailyRewardItemList_ = nil
	end

	slot0.useNumSlider_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
