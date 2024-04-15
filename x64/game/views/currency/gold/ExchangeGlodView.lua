slot0 = class("ExchangeGlodView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/AddmoneypopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot4 = "isItemExchange"
	slot0.isItemExchangeController_ = slot0.controllerEx_:GetController(slot4)
	slot0.topBtnList_ = {}

	for slot4 = 1, 2 do
		slot0.topBtnList_[slot4] = StoreBtnView.New(slot0[string.format("toggleBtnGo%s_", slot4)], CommonBtnTypeConst.EXCHANGE_GOLD, slot4)
	end

	slot0.exchangeGlodByItemView_ = ExchangeGlodByItem.New(slot0.itemExchangeGo_)
	slot0.exchangeGlodByCurrencyView_ = ExchangeGlodByCurrency.New(slot0.currencyExchangeGo_)
	slot0.OnSwitchBtnTypeHandler_ = handler(slot0, slot0.OnSwitchBtnType)
end

function slot0.OnEnter(slot0)
	slot0.exchangeGlodByItemView_:InitData()
	slot0.exchangeGlodByItemView_:OnEnter()
	slot0.exchangeGlodByCurrencyView_:OnEnter()

	slot0.selectIndex_ = 1

	slot0:RefreshTopBtn()
	slot0:RefreshBottomBtn()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchBtnTypeHandler_)
end

function slot0.OnExit(slot0)
	slot0:RestoreBar()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchBtnTypeHandler_)
	slot0.exchangeGlodByItemView_:OnExit()
	slot0.exchangeGlodByCurrencyView_:OnExit()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.topBtnList_) do
		slot5:Dispose()
	end

	slot0.topBtnList_ = nil
	slot0.OnSwitchBtnTypeHandler_ = nil

	slot0.exchangeGlodByItemView_:Dispose()

	slot0.exchangeGlodByItemView_ = nil

	slot0.exchangeGlodByCurrencyView_:Dispose()

	slot0.exchangeGlodByCurrencyView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sureBtn_, nil, function ()
		if uv0.selectIndex_ == 1 then
			uv0.exchangeGlodByItemView_:OnExchange()
		else
			uv0.exchangeGlodByCurrencyView_:OnExchange()
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateBar(slot0)
	slot0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	slot0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	slot0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	end

	manager.windowBar:SetAsLastSibling()
end

function slot0.RestoreBar(slot0)
	if slot0.lastBarList_ then
		manager.windowBar:SwitchBar(slot0.lastBarList_)
	end

	if slot0.lastAddBarList_ then
		for slot4, slot5 in ipairs(slot0.lastAddBarList_) do
			manager.windowBar:SetBarCanAdd(slot5, true)
		end
	end

	if slot0.lastCanClickBarList_ then
		for slot4, slot5 in ipairs(slot0.lastCanClickBarList_) do
			manager.windowBar:SetBarCanClick(slot5, true)
		end
	end
end

function slot0.OnSwitchBtnType(slot0, slot1, slot2)
	if slot1 ~= CommonBtnTypeConst.EXCHANGE_GOLD or slot0.selectIndex_ == btnBtnIndex then
		return
	end

	slot0.selectIndex_ = slot2

	slot0:RefreshTopBtn()
	slot0:RefreshBottomBtn()
end

function slot0.RefreshTopBtn(slot0)
	for slot4, slot5 in pairs(slot0.topBtnList_) do
		slot5:RefreshUI(slot0.selectIndex_)
	end
end

function slot0.RefreshBottomBtn(slot0)
	slot1 = true

	if slot0.selectIndex_ == 1 then
		slot0.isItemExchangeController_:SetSelectedState("true")

		slot1 = slot0.exchangeGlodByItemView_:HasMaterial()
	else
		slot0.isItemExchangeController_:SetSelectedState("false")
	end

	slot0.sureBtn_.interactable = slot1
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot0:Back()

		slot3 = {}

		for slot7, slot8 in ipairs(slot1.drop_list) do
			slot3[slot8.id] = slot3[slot8.id] and slot8.num + slot3[slot8.id] or slot8.num
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot3) do
			table.insert(slot4, {
				id = slot8,
				num = slot9
			})
		end

		getReward(slot4)
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnBuyCoin(slot0, slot1, slot2)
	if slot1.result == 0 then
		ShowTips("TRANSACTION_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)

		return
	end
end

return slot0
