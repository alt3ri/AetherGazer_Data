slot0 = class("SkinBuyCheckView", ReduxView)

function slot0.UIName(slot0)
	return "UI/HeroSkin/SkinBuyCheckUI"
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

	slot0.costTypeController_ = ControllerUtil.GetController(slot0.transform_, "price")
	slot0.commonItem_ = CommonItem.New(slot0.commonitemGo_)
	slot0.give_backController_ = ControllerUtil.GetController(slot0.transform_, "give_back")
	slot0.dlcController = ControllerUtil.GetController(slot0.transform_, "dlc")
	slot0.dlcViewBtnController = ControllerUtil.GetController(slot0.transform_, "dlcViewBtn")
	slot0.dlcJumpController = ControllerUtil.GetController(slot0.transform_, "dlcJump")
	slot0.dlcList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_dlcList, SkinBuyCheckDLCItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		function slot0(slot0)
			if ShopTools.IsRMB(slot0, getShopCfg(uv0.goodID_).shop_id) then
				slot2, slot3, slot4 = ShopTools.IsOnDiscountArea(slot0, slot1.shop_id)
				slot5 = nil

				PayAction.RequestGSPay((not slot2 or not slot4 or getShopCfg(slot0).cheap_cost_id) and getShopCfg(slot0).cost_id, 1, getShopCfg(slot0).shop_id, slot0)
			else
				slot2, slot3 = uv0:HaveDlc()

				if slot2 and slot3 then
					if #uv0.selectList == 1 then
						ShopTools.ConfirmBuyItem(uv0.selectList[1], 1)
					else
						ShopDlcAction.DlcConfirmBuyItem(uv0.goodID_, uv0.selectList)
					end
				else
					ShopTools.ConfirmBuyItem(slot0, 1)
				end
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_skin_buy_check = uv0.params_.skinID
		})

		if ShopData.IsGoodOutOfDate(uv0.goodID_, getShopCfg(uv0.goodID_).shop_id) then
			ShowTips("SKIN_SALE_FINISH")
			uv0:Back()

			return
		end

		slot3 = HeroData:GetHeroData(uv0.params_.heroID)
		slot4, slot5, slot6 = ShopTools.GetPrice(slot2, slot1.shop_id)
		slot7, slot8 = uv0:HaveDlc()

		if slot7 and slot8 then
			for slot12, slot13 in ipairs(uv0.selectList) do
				slot15, slot16, slot17 = ShopTools.GetPrice(slot13, getShopCfg(slot13).shop_id)
				slot4 = 0 + slot15
			end
		end

		if slot3.unlock == 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("NOT_HAVE_HERO_SKIN_CONFIRM"), GetI18NText(HeroCfg[uv0.params_.heroID].name)),
				OkCallback = function ()
					if ShopTools.IsSkin(uv0.goodID_, uv1.shop_id) then
						if ShopTools.GetCostCount(uv0.goodID_) < uv2 then
							uv0:SkinIsdeficiency()
						else
							uv3(uv4)
							SDKTools.SendPaymentMessageToSDK("payment_touch", {
								payment_skin_buy_unlock = 0
							})
						end
					elseif ShopTools.IsRMB(uv4, uv1.shop_id) then
						uv3(uv4)
						SDKTools.SendPaymentMessageToSDK("payment_touch", {
							payment_skin_buy_unlock = 0
						})
					elseif ShopTools.GetCostCount(uv0.goodID_) < uv2 then
						uv3(uv4)
					else
						uv3(uv4)
						SDKTools.SendPaymentMessageToSDK("payment_touch", {
							payment_skin_buy_unlock = 0
						})
					end
				end,
				CancelCallback = function ()
					SDKTools.SendPaymentMessageToSDK("payment_touch", {
						payment_skin_buy_unlock = 1
					})
				end
			})
		elseif ShopTools.IsSkin(uv0.goodID_, slot1.shop_id) then
			if ShopTools.GetCostCount(uv0.goodID_) < slot4 then
				uv0:SkinIsdeficiency()
			else
				slot0(slot2)
				SDKTools.SendPaymentMessageToSDK("payment_touch", {
					payment_skin_buy_unlock = 0
				})
			end
		elseif ShopTools.IsRMB(slot2, slot1.shop_id) then
			slot0(slot2)
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_skin_buy_unlock = 0
			})
		elseif ShopTools.GetCostCount(uv0.goodID_) < slot4 then
			slot0(slot2)
		else
			slot0(slot2)
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_skin_buy_unlock = 0
			})
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_dlcViewBtn, function ()
		JumpTools.OpenPageByJump("/skinDlcShow", {
			goodId = uv0.dlcID_
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_jumpBtn, function ()
		slot0, slot1 = uv0:HaveDlc()

		if slot0 and not slot1 then
			JumpTools.GoToSystem("/shop", {
				shopId = getShopCfg(uv0.dlcID_).shop_id
			}, ViewConst.SYSTEM_ID.SHOP)
		end
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

function slot0.RefreshUI(slot0)
	slot2, slot3 = slot0:HaveDlc()

	if not slot2 then
		slot0.dlcController:SetSelectedIndex(0)

		slot4 = {}
		slot4 = (RechargeShopDescriptionCfg[getShopCfg(slot0.goodID_).description].type ~= 8 or slot5.id) and HeroTools.GetSkinChangeItem(slot0.skinID_)
		slot0.textnameText_.text = ItemTools.getItemName(slot4)
		slot0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(slot4)) .. ItemTools.getItemDesc(slot4)
		slot0.m_textinfoScroll.verticalNormalizedPosition = 1

		slot0.commonItem_:RefreshData({
			number = 1,
			id = slot4
		})
		slot0:UpdatePrice()
	else
		slot0.dlcController:SetSelectedIndex(1)

		slot0.selectList = {}

		if ShopTools.HaveSkin(slot0.skinID_) or HeroTools.CanChangeSkin(slot0.skinID_) then
			slot0.selectIndex = 2

			if slot3 then
				slot0.selectList = {
					slot0.dlcID_
				}
			else
				slot0.selectList = {}
			end
		else
			slot0.selectIndex = 1
			slot0.selectList = {
				slot0.goodID_
			}
		end

		slot0.dlcList:StartScroll(2)
		slot0:RefreshDlcDes()
		slot0:UpdatePriceByDlc()
	end
end

function slot0.UpdatePrice(slot0)
	slot1 = getShopCfg(slot0.goodID_)
	slot0.rmbpriceText_.text, slot4, slot5 = ShopTools.GetPrice(slot0.goodID_, slot1.shop_id)

	if slot1.give_back_list == 0 or #slot7 == 0 then
		slot0.give_backController_:SetSelectedState("false")

		if ShopTools.IsRMB(slot2, slot1.shop_id) then
			slot0.costTypeController_:SetSelectedState("money")

			slot0.symbolText_.text = PaymentCfg[1].currency_symbol
		else
			slot0.costTypeController_:SetSelectedState("currency")

			slot0.costiconImg_.sprite = ItemTools.getItemLittleSprite(slot1.cost_id)
			slot0.symbolText_.text = " "
			slot0.priceText_.text = slot3
		end
	else
		slot0.give_backController_:SetSelectedState("true")

		slot0.rebackSkinTicketText_.text = slot7[1].num or 0

		if SettingData:GetCurrentLanguage() == "fr" or slot8 == "de" then
			slot3 = string.gsub(tostring(slot3), "%.", ",")
		end

		slot0.rmbpriceText_.text = slot3

		if ShopTools.IsRMB(slot2, slot1.shop_id) then
			slot0.costTypeController_:SetSelectedState("money")

			slot0.symbolText_.text = slot6
		elseif ShopTools.IsSkin(slot2, slot1.shop_id) then
			slot0.costTypeController_:SetSelectedState("skin")

			slot0.currencyiconImg_.sprite = ItemTools.getItemLittleSprite(slot1.give_back_list[1].id)
			slot0.give_back_icon_.sprite = ItemTools.getItemLittleSprite(slot1.give_back_list[1].id)
			slot0.costSkinTicketText_.text = slot3
		else
			slot0.costTypeController_:SetSelectedState("currency")

			slot0.currencyiconImg_.sprite = ItemTools.getItemLittleSprite(slot1.give_back_list[1].id)
			slot0.give_back_icon_.sprite = ItemTools.getItemLittleSprite(slot1.give_back_list[1].id)
			slot0.costSkinTicketText_.text = slot3
		end
	end
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot5 = getShopCfg(slot2, slot3)
		slot6 = slot5.description
		slot8 = {
			{
				slot6,
				(slot5.give or 1) * slot4
			}
		}
		slot9, slot10 = nil

		slot0:Back()

		if ((not slot5.description or RechargeShopDescriptionCfg[slot5.description]) and ItemCfg[slot6]).type ~= 14 then
			return
		end

		if slot5.give_back_list ~= 0 and #slot5.give_back_list ~= 0 then
			slot11 = {}

			for slot15, slot16 in ipairs(slot5.give_back_list) do
				table.insert(slot11, {
					slot16.id,
					slot16.num
				})
			end

			table.insertto(slot8, slot11)
		end

		getReward(mergeReward(formatRewardCfgList(slot8)), nil, function ()
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("USE_SKIN_CHANGE"), GetI18NText(RechargeShopDescriptionCfg[uv0].name)),
				OkCallback = function ()
					CommonAction.TryToUseItem({
						{
							item_info = {
								num = 1,
								id = HeroTools.GetSkinChangeItem(uv0.skinID_)
							},
							use_list = {}
						}
					})
				end
			})
		end, nil, true)

		return
	end

	slot0:Back()
end

function slot0.UpdateBar(slot0)
	if slot0.params_.shopID == 1048 then
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
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
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	manager.windowBar:SetAsLastSibling()
end

function slot0.OnEnter(slot0)
	slot0.goodID_ = slot0.params_.goodID
	slot0.heroID_ = slot0.params_.heroID
	slot0.skinID_ = slot0.params_.skinID
	slot1 = getShopCfg(slot0.goodID_)
	slot0.dlcID_ = slot1.dlc

	if ShopTools.IsRMB(slot0.goodID_, slot1.shop_id) then
		slot0.dlcID_ = nil
	end

	if slot0.dlcID_ ~= nil and slot0.dlcID_ ~= 0 then
		slot0.dlcViewBtnController:SetSelectedIndex(1)
	else
		slot0.dlcViewBtnController:SetSelectedIndex(0)
	end

	slot0:RefreshUI()
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:Back()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(HeroTools.GetSkinChangeItem(uv0.skinID_))),
			OkCallback = function ()
				CommonAction.TryToUseItem({
					{
						num = 1,
						item_id = uv0,
						use_list = {}
					}
				})
			end
		})
	end)

	if (ShopTools.HaveSkin(slot0.skinID_) or HeroTools.CanChangeSkin(slot0.skinID_)) and slot0.dlcID_ and slot0.dlcID_ ~= 0 and ShopTools.CheckDlcPurchased(slot0.dlcID_) then
		Timer.New(function ()
			uv0:Back()
		end, 0.033, 1):Start()
	end

	if slot0.timer_ == nil then
		slot0.timer_ = FrameTimer.New(function ()
			slot0, slot1 = uv0:HaveDlc()

			if not slot0 then
				uv0:UpdatePrice()
			else
				if uv0.dlcList ~= nil then
					for slot5, slot6 in ipairs(uv0.dlcList:GetItemList()) do
						slot6:UpdateTimer()
					end
				end

				uv0:UpdatePriceByDlc()
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.OnExit(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()
	slot0.dlcList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.HaveDlc(slot0)
	if slot0.dlcID_ == nil or slot0.dlcID_ == 0 then
		return false, false
	elseif getShopCfg(slot0.dlcID_) == nil then
		return false, false
	elseif ShopTools.CheckDlcPurchased(slot0.dlcID_) then
		return false, false
	else
		return true, ShopConst.SHOP_ID.DLC_SHOP == slot1.shop_id
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	if slot1 == 1 then
		if ShopTools.HaveSkin(slot0.skinID_) or HeroTools.CanChangeSkin(slot0.skinID_) then
			slot2:SetState(2)
		elseif table.indexof(slot0.selectList, slot0.goodID_) then
			slot2:SetState(1)
		else
			slot2:SetState(0)
		end

		slot2:SetData(slot1, slot0.goodID_)
	elseif slot1 == 2 then
		slot3, slot4 = slot0:HaveDlc()

		if not slot4 then
			slot2:SetState(3)
		elseif table.indexof(slot0.selectList, slot0.dlcID_) then
			slot2:SetState(1)
		else
			slot2:SetState(0)
		end

		slot2:SetData(slot1, slot0.dlcID_)
	end

	slot2:SetSelect(slot1 == slot0.selectIndex)
	slot2:RegistCallBack(function (slot0)
		uv0:DlcItemClick(slot0)
	end)
	slot2:RegistSelectCallBack(function (slot0)
		uv0:DlcItemSelectClick(slot0)
	end)
end

function slot0.DlcItemClick(slot0, slot1)
	slot0.selectIndex = slot1

	slot0.dlcList:Refresh()
	slot0:RefreshDlcDes()
	slot0:UpdatePriceByDlc()
end

function slot0.DlcItemSelectClick(slot0, slot1)
	if table.indexof(slot0.selectList, slot1) then
		table.remove(slot0.selectList, slot2)
	else
		table.insert(slot0.selectList, slot1)
	end

	slot0.dlcList:Refresh()
	slot0:UpdatePriceByDlc()
end

function slot0.RefreshDlcDes(slot0)
	if slot0.selectIndex == 1 then
		slot2 = {}
		slot2 = (RechargeShopDescriptionCfg[getShopCfg(slot0.goodID_).description].type ~= 8 or slot3.id) and HeroTools.GetSkinChangeItem(slot0.skinID_)
		slot0.textnameText_.text = ItemTools.getItemName(slot2)
		slot0.textinfoText_.text = string.format(GetTips("BUY_SKIN_CHANGE"), ItemTools.getItemName(slot2)) .. ItemTools.getItemDesc(slot2)
		slot0.m_textinfoScroll.verticalNormalizedPosition = 1

		slot0.dlcJumpController:SetSelectedIndex(0)
	else
		slot3 = slot1.give or 1
		slot4, slot5 = nil
		slot5 = (not slot1.description or RechargeShopDescriptionCfg[slot1.description]) and ItemCfg[getShopCfg(slot0.dlcID_).give_id or slot1.description]
		slot0.textnameText_.text = ItemTools.getItemName(slot5.id)
		slot0.textinfoText_.text = ItemTools.getItemDesc(slot5.id)
		slot0.m_textinfoScroll.verticalNormalizedPosition = 1
		slot6, slot7 = slot0:HaveDlc()

		if slot6 and not slot7 then
			slot0.dlcJumpController:SetSelectedIndex(1)
		else
			slot0.dlcJumpController:SetSelectedIndex(0)
		end
	end
end

function slot0.UpdatePriceByDlc(slot0)
	slot1 = getShopCfg(slot0.goodID_)
	slot2 = PaymentCfg[1].currency_symbol
	slot3 = slot0.goodID_

	if #slot0.selectList == 0 then
		slot0.give_backController_:SetSelectedState("false")
		slot0.costTypeController_:SetSelectedState("null")

		return
	end

	slot5 = ""
	slot6 = {}

	for slot10, slot11 in ipairs(slot0.selectList) do
		slot12, slot13, slot14 = ShopTools.GetPrice(slot11, slot1.shop_id)
		slot4 = 0 + slot12
		slot5 = slot10 == 1 and "(" .. slot4 or "(" .. slot4 .. "+" .. slot12

		if type(getShopCfg(slot11).give_back_list) == "table" then
			for slot20, slot21 in ipairs(slot16) do
				if not slot6[slot21.id] then
					slot6[slot21.id] = slot21.num
				else
					slot6[slot21.id] = slot6[slot21.id] + slot21.num
				end
			end
		end
	end

	slot5 = slot5 .. ")"

	if table.length(slot6) == 0 then
		slot0.give_backController_:SetSelectedState("false")
	else
		slot0.give_backController_:SetSelectedState("true")

		for slot10, slot11 in pairs(slot6) do
			slot0.currencyiconImg_.sprite = ItemTools.getItemLittleSprite(slot10)
			slot0.give_back_icon_.sprite = ItemTools.getItemLittleSprite(slot10)
			slot0.rebackSkinTicketText_.text = slot11
		end
	end

	if #slot0.selectList > 1 then
		slot0.m_delPrice.text = slot5
	else
		slot0.m_delPrice.text = ""
	end

	if ShopTools.IsRMB(slot3, slot1.shop_id) then
		slot0.costTypeController_:SetSelectedState("money")

		slot0.rmbpriceText_.text = slot4
		slot0.symbolText_.text = slot2
	else
		slot0.costTypeController_:SetSelectedState("currency")

		slot0.costiconImg_.sprite = ItemTools.getItemLittleSprite(slot1.cost_id)
		slot0.symbolText_.text = " "
		slot0.priceText_.text = slot4
	end
end

return slot0
