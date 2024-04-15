slot0 = class("PassportBuyView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Passport/PassportBuyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.item68_ = {}

	for slot4 = 1, 10 do
		if slot0["item68_" .. slot4] then
			slot6 = clone(ItemTemplateData)

			function slot6.clickFun(slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			table.insert(slot0.item68_, {
				item = CommonItemView.New(slot0["item68_" .. slot4]),
				data = slot6
			})
		end
	end

	slot0.item128_ = {}

	for slot4 = 1, 10 do
		if slot0["item128_" .. slot4] then
			slot6 = clone(ItemTemplateData)

			function slot6.clickFun(slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			table.insert(slot0.item128_, {
				item = CommonItemView.New(slot0["item128_" .. slot4]),
				data = slot6
			})
		end
	end

	slot0.controller = Object.Instantiate(Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path), slot0.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	slot0.controller:SetSelectedState("PassportBuyUI")

	slot0.grey = slot0.image68_.material
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cheepBtn_, nil, function ()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		SendMessageManagerToSDK("purchase_click_montlycard")
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_buy = 68
		})

		if PassportData:GetEndTimestamp() - TimeMgr.GetInstance():GetServerTime() < 1200 then
			ShowTips("NOT_ENOUGH_TIME_TO_BUY")

			return
		end

		if PassportData:GetPayLevel() == 201 then
			ShowTips("BATTLEPASS_HAS_BUYED")

			return
		end

		PayAction.RequestGSPay(201, 1)
	end)
	slot0:AddBtnListener(slot0.expensiveBtn_, nil, function ()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end

		SendMessageManagerToSDK("purchase_click_montlycard")

		if PassportData:GetEndTimestamp() - TimeMgr.GetInstance():GetServerTime() < 1200 then
			ShowTips("NOT_ENOUGH_TIME_TO_BUY")

			return
		end

		if PassportData:GetPayLevel() == 202 then
			ShowTips("BATTLEPASS_HAS_BUYED")

			return
		end

		if PassportData:GetPayLevel() == 201 then
			PayAction.RequestGSPay(203, 1)
		else
			PayAction.RequestGSPay(202, 1)
		end
	end)

	if slot0.fundsettlementmethodBtn_ and slot0.commercialBtn_ then
		slot0:AddBtnListener(slot0.fundsettlementmethodBtn_, nil, function ()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", fund_settlement_algorithm))
		end)
		slot0:AddBtnListener(slot0.commercialBtn_, nil, function ()
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"ShowAgreement\" , \"type\" : \"%s\"}", specific_commercial_transaction_act))
		end)
	end

	if slot0.checkBtn_ then
		slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
			JumpTools.OpenPageByJump("passportShow", {
				isPassPortBuy = true,
				type = 2
			})
		end)
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()

	slot0.dataList1_ = BattlePassListCfg[PassportData:GetId()].display_reward_01
	slot0.dataList2_ = BattlePassListCfg[PassportData:GetId()].display_reward_02

	slot0:UpdateView()
	slot0:UpdateTimer()
	slot0:RegisterEventListeners()
	SetActive(slot0.btnsGo_, GameToSDK.CURRENT_SERVER == SERVER_REGION.JAPAN)
end

function slot0.RegisterEventListeners(slot0)
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:UpdateView()
	end)
end

function slot0.UpdateView(slot0)
	if ShopTools.IsPC() then
		slot0.image68_.material = slot0.grey
		slot0.image128_.material = slot0.grey
	else
		slot0.image68_.material = nil
		slot0.image128_.material = nil
	end

	SetActive(slot0.cheapBuy_, false)
	SetActive(slot0.cheapNot_, false)
	SetActive(slot0.heavyBuy_, false)
	SetActive(slot0.heavyNot_, false)

	if PassportData:GetPayLevel() >= 202 then
		SetActive(slot0.heavyNot_, true)
		SetActive(slot0.cheapNot_, true)
	elseif PassportData:GetPayLevel() >= 201 then
		SetActive(slot0.cheapNot_, true)
		SetActive(slot0.heavyBuy_, true)

		slot0.priceLabel2_.text = slot0:GetPriceText(203)
	else
		SetActive(slot0.heavyBuy_, true)
		SetActive(slot0.cheapBuy_, true)

		slot0.priceLabel1_.text = slot0:GetPriceText(201)
		slot0.priceLabel2_.text = slot0:GetPriceText(202)
	end

	for slot4, slot5 in ipairs(slot0.item68_) do
		CommonTools.SetCommonData(slot5.item, {
			id = slot0.dataList1_[slot4][1],
			number = slot0.dataList1_[slot4][2]
		}, slot5.data)
	end

	for slot4, slot5 in ipairs(slot0.item128_) do
		CommonTools.SetCommonData(slot5.item, {
			id = slot0.dataList2_[slot4][1],
			number = slot0.dataList2_[slot4][2]
		}, slot5.data)
	end
end

function slot0.GetPriceText(slot0, slot1)
	if SDKTools.GetIsKorea() then
		return PaymentCfg[slot1].cost / 100 .. GetTips("CURRENCY_TEXT")
	else
		return string.format(GetTips("PASSPORT_BUY_BUTTON_1"), PaymentCfg[slot1].currency_symbol, slot2)
	end
end

function slot0.UpdateTimer(slot0)
	slot0.timeLabel_.text = manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M") .. "  -  " .. manager.time:STimeDescS(PassportData:GetEndTimestamp() - 1200, "!%Y/%m/%d %H:%M")
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	if slot0.item68_ then
		for slot4, slot5 in pairs(slot0.item68_) do
			slot5.item:Dispose()
		end

		slot0.item68_ = nil
	end

	if slot0.item128_ then
		for slot4, slot5 in pairs(slot0.item128_) do
			slot5.item:Dispose()
		end

		slot0.item128_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
