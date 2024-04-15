slot0 = class("NewSkinBuyCheckView", ReduxView)
slot1 = {
	OnlySkin = 1,
	OnlyDlc = 2,
	SpecialShow = 3,
	BuyDlcAndSkin = 4
}

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeSkinPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.dlcselController = slot0.controller_:GetController("dlcsel")
	slot0.dlcbtnController = slot0.controller_:GetController("dlcbtn")
	slot0.dlcbgController = slot0.controller_:GetController("dlcbg")
	slot0.dlcIconController = slot0.controller_:GetController("dlcIcon")
	slot0.discountController = slot0.controller_:GetController("discount")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.calcelBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.jumpBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = getShopCfg(uv0.dlcID).shop_id,
			goodId = uv0.goodID
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		slot3, slot1, slot2 = ShopTools.GetPrice(uv0.goodID)

		if uv0.showModel == uv1.BuyDlcAndSkin then
			slot5, slot6, slot7 = ShopTools.GetPrice(uv0.dlcID)
			slot3 = slot3 + slot5

			table.insert({
				uv0.goodID
			}, uv0.dlcID)
		elseif uv0.showModel == uv1.OnlyDlc then
			slot3, slot6, slot7 = ShopTools.GetPrice(uv0.dlcID)
		end

		function slot5(slot0)
			if ShopTools.IsRMB(slot0[1]) then
				PayAction.RequestGSPay(ShopTools.GetCostId(uv0.goodID), 1, uv0.shopID, slot0[1])
			elseif uv0.showModel == uv1.BuyDlcAndSkin then
				ShopTools.ConfirmBuySkin(slot0, {
					1,
					1
				})
			else
				ShopTools.ConfirmBuyItem(slot0[1], 1)
			end
		end

		function slot6()
			if ShopTools.IsRMB(uv0.goodID) == false and ShopTools.GetCostCount(uv0.goodID) < uv1 then
				if ShopTools.IsSkin(uv0.goodID) then
					uv0:SkinIsdeficiency()
				else
					uv2(uv3)
				end
			else
				uv2(uv3)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = uv0.skinID
		})

		if ShopData.IsGoodOutOfDate(uv0.goodID) then
			ShowTips("SKIN_SALE_FINISH")
			uv0:Back()

			return
		end

		if HeroData:GetHeroData(uv0.heroID).unlock == 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("NOT_HAVE_HERO_SKIN_CONFIRM"), GetI18NText(uv0.heroCfg.name)),
				OkCallback = slot6,
				CancelCallback = function ()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			})
		else
			slot6()
		end
	end)
	slot0:AddBtnListener(slot0.dlcBtn_, nil, function ()
		if ShopTools.CheckDlcCanBuy(uv0.dlcID) and ShopTools.CheckDlcPurchased(uv0.dlcID) == false then
			if uv0.params_.selectDlc == true then
				uv0.dlcselController:SetSelectedState("false")

				uv0.params_.selectDlc = false
			else
				uv0.params_.selectDlc = true

				uv0.dlcselController:SetSelectedState("true")

				uv0.dlcIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. uv0.skinCfg.id)
			end
		end
	end)
	slot0:AddBtnListener(slot0.addDlcBtn_, nil, function ()
		uv0.showModel = uv1.BuyDlcAndSkin

		uv0:UpdateView()
		uv0.dlcbtnController:SetSelectedState("buy")
	end)
	slot0:AddBtnListener(slot0.cancelDlcBtn_, nil, function ()
		uv0.showModel = uv1.OnlySkin

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.btnView_, nil, function ()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = uv0.goodID
		})
	end)
end

function slot0.SkinIsdeficiency(slot0)
	ShowMessageBox({
		content = string.format(GetTips("ERROR_ITEM_NOT_SKIN_TICKET_C")),
		OkCallback = function ()
			JumpTools.GoToSystem("/rechargeMain", {
				childShopIndex = 4,
				page = 2
			}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
		end,
		CancelCallback = function ()
			uv0:Back()
		end
	})
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot0:Back()
	else
		slot0:Back()
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId(),
		CurrencyConst.CURRENCY_TYPE_SKIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function slot0.UpdateData(slot0)
	slot0.shopCfg = getShopCfg(slot0.goodID)
	slot0.shopID = slot0.shopCfg.shop_id
	slot0.skinCfg = SkinCfg[slot0.skinID]
	slot0.heroCfg = HeroCfg[slot0.skinCfg.hero]
	slot0.desCfg = RechargeShopDescriptionCfg[slot0.shopCfg.description]
	slot0.descID = slot0.desCfg.id
	slot0.dlcID = slot0.shopCfg.dlc or nil
	slot0.shopDlcCfg = getShopCfg(slot0.dlcID)
	slot0.showModel = slot0.params_.onlySkin and uv0.OnlySkin or uv0.BuyDlcAndSkin

	if slot0.shopDlcCfg and slot0.shopDlcCfg.shop_id == slot0.shopID or slot0.shopDlcCfg and slot0.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		slot0.itemDlcCfg = RechargeShopDescriptionCfg[slot0.shopDlcCfg.description]

		if slot0.itemDlcCfg == nil then
			slot0.itemDlcCfg = ItemCfg[slot0.shopDlcCfg.give_id]
			slot0.showModel = uv0.OnlySkin
		end
	end

	if slot0.showModel == uv0.BuyDlcAndSkin and ShopTools.HaveSkin(slot0.skinID) then
		slot0.showModel = uv0.OnlyDlc
		slot0.goodID = slot0.dlcID
	end
end

function slot0.UpdatePrice(slot0)
	slot1, slot2, slot3 = ShopTools.GetPrice(slot0.goodID)
	slot4 = ItemCfg[slot0.skinCfg.hero]

	SetActive(slot0.oriOriceTxt_.gameObject, false)
	SetActive(slot0.skinOriginTxt_.gameObject, false)
	SetActive(slot0.dlcPrice_.gameObject, false)
	slot0.dlcbgController:SetSelectedState(slot0.showModel == uv0.OnlyDlc and "true" or "false")

	slot5, slot6, slot7 = ShopTools.IsOnDiscountArea(slot0.goodID)

	if slot0.showModel == uv0.BuyDlcAndSkin then
		slot8, slot9, slot10 = ShopTools.GetPrice(slot0.dlcID)
		slot11, slot12, slot13 = ShopTools.IsOnDiscountArea(slot0.dlcID)

		if ShopTools.IsRMB(slot0.goodID) then
			SetActive(slot0.costiconImg_.gameObject, false)

			slot0.priceText_.text = ShopTools.GetMoneySymbol(slot0.goodID) .. slot1 + slot8
		else
			slot0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(slot0.shopCfg.cost_id), slot1 + slot8, ItemTools.getItemName(slot4.id), ItemTools.getItemName(slot0.shopCfg.description)) .. string.format("+ <color=#E78300>「%s」</color>", ItemTools.getItemName(slot0.itemDlcCfg.id))

			SetActive(slot0.costiconImg_.gameObject, true)

			if slot5 and slot7 then
				SetActive(slot0.skinOriginTxt_.gameObject, slot1 ~= slot2)

				if slot1 ~= slot2 then
					slot0.skinOriginTxt_.text = slot2
				end
			end

			if slot11 and slot13 then
				SetActive(slot0.oriOriceTxt_.gameObject, slot8 ~= slot9)

				if slot8 ~= slot9 then
					slot0.oriOriceTxt_.text = slot9
				end
			else
				SetActive(slot0.oriOriceTxt_.gameObject, false)
			end

			slot0.costiconImg_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg.cost_id)
			slot0.priceText_.text = slot1 + slot8

			if ItemTools.getItemNum(slot0.shopCfg.cost_id) < slot1 + slot8 then
				slot0.priceText_.text = "<color=#FF000B>" .. slot1 + slot8 .. "</color>"
			end
		end

		if #slot0.shopCfg.give_back_list ~= 0 then
			slot0.rebackSkinTicketText_.text = slot0.shopCfg.give_back_list[1].num
			slot0.allrebackTxt_.text = ""
		end

		SetActive(slot0.dlcPrice_.gameObject, true)

		slot0.allPriceTxt_.text = string.format("( %d", slot1)
		slot0.dlcPrice_.text = "+" .. slot8

		SetActive(slot0.kuoGo_, true)
	else
		if slot0.showModel == uv0.OnlyDlc then
			slot8, slot9, slot3 = ShopTools.GetPrice(slot0.dlcID)
			slot0.dlcItemIcon_.sprite = ItemTools.getItemSprite(slot0.itemDlcCfg.id)

			SetActive(slot0.oriOriceTxt_.gameObject, slot8 ~= slot9)

			if slot1 ~= slot2 then
				slot0.oriOriceTxt_.text = slot2
			end
		end

		if ShopTools.IsRMB(slot0.goodID) then
			SetActive(slot0.costiconImg_.gameObject, false)

			slot0.priceText_.text = ShopTools.GetMoneySymbol(slot0.goodID) .. slot1
			slot0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS"), ShopTools.GetMoneySymbol(slot0.goodID) .. slot1, "", ItemTools.getItemName(slot4.id), ItemTools.getItemName(slot0.shopCfg.description))

			if slot5 and slot7 then
				SetActive(slot0.skinOriginTxt_.gameObject, slot1 ~= slot2)

				if slot1 ~= slot2 then
					slot0.skinOriginTxt_.text = slot2
				end
			end
		else
			if slot0.showModel == uv0.OnlyDlc then
				slot0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(slot0.shopDlcCfg.cost_id), slot1, ItemTools.getItemName(slot4.id), ItemTools.getItemName(slot0.itemDlcCfg.id))
			else
				slot0.buyDesc_.text = string.format(GetTips("BUY_SKIN_TIPS_TICKET"), ItemTools.getItemName(slot0.shopCfg.cost_id), slot1, ItemTools.getItemName(slot4.id), ItemTools.getItemName(slot0.shopCfg.description))
			end

			if slot5 and slot7 then
				SetActive(slot0.skinOriginTxt_.gameObject, slot1 ~= slot2 and slot0.showModel ~= uv0.OnlyDlc)

				if slot1 ~= slot2 then
					slot0.skinOriginTxt_.text = slot2
				end
			end

			SetActive(slot0.costiconImg_.gameObject, true)

			slot0.costiconImg_.sprite = ItemTools.getItemLittleSprite(slot0.shopCfg.cost_id)
			slot0.priceText_.text = slot1

			if ItemTools.getItemNum(slot0.shopCfg.cost_id) < slot1 then
				slot0.priceText_.text = "<color=#FF000B>" .. slot1 .. "</color>"
			end
		end

		if #slot0.shopCfg.give_back_list ~= 0 then
			slot0.rebackSkinTicketText_.text = slot0.shopCfg.give_back_list[1].num
			slot0.allrebackTxt_.text = ""
		end

		slot0.allrebackTxt_.text = ""
		slot0.allPriceTxt_.text = ""

		SetActive(slot0.kuoGo_, false)
	end
end

function slot0.UpdateTitle(slot0)
	if slot0.showModel == uv0.OnlyDlc or slot0.showModel == uv0.BuyDlcAndSkin then
		slot0.textnameText_.text = ItemTools.getItemName(slot0.itemDlcCfg.id)
		slot0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(slot0.itemDlcCfg.id)) .. ItemTools.getItemDesc(slot0.itemDlcCfg.id)
	else
		slot0.textnameText_.text = ItemTools.getItemName(slot0.shopCfg.description)
		slot0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(slot0.shopCfg.description)) .. ItemTools.getItemDesc(slot0.descID)
	end
end

function slot0.UpdateView(slot0)
	slot0:UpdatePrice()
	slot0:UpdateTitle()
	SetActive(slot0.dlcItemLimit_, false)
	slot0.dlcselController:SetSelectedState((slot0.showModel == uv0.OnlyDlc or slot0.showModel == uv0.BuyDlcAndSkin) and "true" or "false")
	SetActive(slot0.giveBackGo_, #slot0.shopCfg.give_back_list ~= 0 and slot0.showModel ~= uv0.OnlyDlc)
	SetActive(slot0.skinRemainGo_, false)

	slot0.skinImg_.sprite = getSpriteViaConfig("HeroIcon", slot0.skinCfg.picture_id)

	slot0.skinImg_:SetNativeSize()
	slot0.dlcIconController:SetSelectedState(slot0.shopDlcCfg and "true" or "false")

	if slot0.showModel == uv0.OnlyDlc then
		slot0.dlcIconController:SetSelectedState("false")
	end

	if slot0.dlcID and ShopTools.CheckDlcCanBuy(slot0.dlcID) and ShopTools.CheckDlcPurchased(slot0.dlcID) == false and slot0.shopDlcCfg.shop_id == slot0.shopID then
		if slot0.showModel == uv0.BuyDlcAndSkin then
			slot0.dlcbtnController:SetSelectedState("buy")
		else
			slot0.dlcbtnController:SetSelectedState("notBuy")
		end

		slot0.dlcIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot0.skinCfg.id .. "_character")
		slot0.dlcLittleIcon_.sprite = ItemTools.getItemSprite(slot0.itemDlcCfg.id)
		slot0.dlcBgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/BackgroundQuad/" .. HomeSceneSettingCfg[slot0.itemDlcCfg.id].prefix)
		slot0.dlcbuyTxt_.text = string.format(GetTips("BUY_SKIN_DLC_TIPS"), ItemTools.getItemName(slot0.itemDlcCfg.id))
		slot0.dlcItemNameTxt_.text = string.format(ItemTools.getItemName(slot0.itemDlcCfg.id))
	elseif slot0.shopDlcCfg and ShopConst.SHOP_ID.DLC_SHOP ~= slot0.shopDlcCfg.shop_id then
		slot0.dlcbtnController:SetSelectedState(ShopTools.CheckDlcPurchased(slot0.dlcID) == false and "cannotBuy" or "get")

		slot0.dlcLittleIcon_.sprite = ItemTools.getItemSprite(slot0.itemDlcCfg.id)
		slot0.dlcItemNameTxt_.text = string.format(ItemTools.getItemName(slot0.itemDlcCfg.id))
	else
		slot0.dlcbtnController:SetSelectedState("none")
	end

	slot0:UpdateTimeView()
end

function slot0.UpdateTimer(slot0)
	slot0:UpdateTimeView()

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimeView()
		end, 1, -1, -1)

		slot0.timer_:Start()
	end
end

function slot0.UpdateTimeView(slot0)
	if slot0.showModel ~= uv0.OnlyDlc and slot0.shopDlcCfg then
		slot1, slot2, slot3 = ShopTools.IsOnDiscountArea(slot0.dlcID)

		if slot1 and slot3 then
			SetActive(slot0.dlcItemLimit_, slot0.shopDlcCfg.is_limit_time_discount == 1)

			slot0.dlcItemLimitTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(slot0.shopDlcCfg.cheap_close_time))
		else
			SetActive(slot0.dlcItemLimit_, false)
		end
	end

	slot1 = slot0.shopCfg.close_time
	slot2 = slot0.shopCfg

	if slot0.showModel == uv0.OnlyDlc then
		slot1 = slot0.shopDlcCfg.close_time
		slot2 = slot0.shopDlcCfg
	end

	SetActive(slot0.timeGo_, #slot1 > 0)

	if #slot1 <= 0 then
		slot0.discountController:SetSelectedState("none")
	end

	if #slot1 > 0 then
		if TimeMgr.GetInstance():parseTimeFromConfig(slot1) <= TimeMgr.GetInstance():GetServerTime() then
			slot0.remainTxt_.text = GetTips("TIP_EXPIRED")
		else
			slot0.remainTxt_.text = string.format("%s", manager.time:GetLostTimeStr(slot4))
		end
	end

	if #slot2.cheap_close_time > 0 then
		slot3, slot4, slot5 = ShopTools.IsOnDiscountArea(slot2.goods_id)

		if slot3 and slot5 then
			slot0.discountController:SetSelectedState("none")
			SetActive(slot0.skinRemainGo_, slot2.is_limit_time_discount == 1)

			slot0.skinRemianTxt_.text = manager.time:GetLostTimeStr(TimeMgr.GetInstance():parseTimeFromConfig(slot2.cheap_close_time))
		else
			slot0.discountController:SetSelectedState("none")
			SetActive(slot0.skinRemainGo_, false)
		end
	end

	slot0:UpdatePrice()
end

function slot0.OnEnter(slot0)
	slot0.goodID = slot0.params_.goodID
	slot0.heroID = slot0.params_.heroID
	slot0.skinID = slot0.params_.skinID

	slot0:UpdateData()
	slot0:UpdateView()
	slot0:UpdateTimer()
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(HeroTools.GetSkinChangeItem(uv0.skinID))),
			OkCallback = function ()
				CommonAction.TryToUseItem({
					{
						item_info = {
							num = 1,
							id = uv0
						},
						use_list = {}
					}
				})
			end
		})
	end)
end

function slot0.OnExit(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	manager.windowBar:HideBar()

	slot0.params_.onlySkin = nil

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
