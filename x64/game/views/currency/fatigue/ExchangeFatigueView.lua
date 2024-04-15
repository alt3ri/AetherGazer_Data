slot0 = class("ExchangeFatigueView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/AddstaminapopUI"
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

	for slot4 = 1, 3 do
		slot0.topBtnList_[slot4] = StoreBtnView.New(slot0[string.format("toggleBtnGo%s_", slot4)], CommonBtnTypeConst.EXCHANGE_VITALITY, slot4)
	end

	slot0.exchangeFatigueByItemView_ = ExchangeFatigueByItem.New(slot0.itemExchangeGo_)
	slot0.exchangeFatigueByCurrencyView_ = ExchangeFatigueByCurrency.New(slot0.currencyExchangeGo_)
	slot0.dailyFatigueView_ = DailyFatiguePage.New(slot0.dailyFatigueGo_)
	slot0.OnSwitchBtnTypeHandler_ = handler(slot0, slot0.OnSwitchBtnType)

	slot0:BindDailyFatigueRedPoint()
end

function slot0.BindDailyFatigueRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.toggleBtnGo3_.transform, RedPointConst.DAILY_FATIGUE)
	manager.redPoint:updateKey(RedPointConst.DAILY_FATIGUE)
end

function slot0.UnbindDailyFatigueRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.toggleBtnGo3_.transform, RedPointConst.DAILY_FATIGUE)
end

function slot0.OnEnter(slot0)
	slot0.exchangeFatigueByItemView_:InitData()
	slot0.exchangeFatigueByItemView_:OnEnter()
	slot0.exchangeFatigueByCurrencyView_:OnEnter()
	slot0.dailyFatigueView_:OnEnter()

	slot1 = slot0.dailyFatigueView_:CheckEnable()

	if slot0.params_.page and slot2 ~= 0 then
		slot0.selectIndex_ = slot2
	else
		slot0.selectIndex_ = slot1 and 3 or 1
	end

	slot0:RefreshTopBtn()
	slot0:RefreshBottomBtn()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchBtnTypeHandler_)
end

function slot0.OnExit(slot0)
	slot0:RestoreBar()
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchBtnTypeHandler_)
	slot0.exchangeFatigueByItemView_:OnExit()
	slot0.exchangeFatigueByCurrencyView_:OnExit()
	slot0.dailyFatigueView_:OnExit()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:UnbindDailyFatigueRedPoint()

	for slot4, slot5 in pairs(slot0.topBtnList_) do
		slot5:Dispose()
	end

	slot0.topBtnList_ = nil
	slot0.OnSwitchBtnTypeHandler_ = nil

	slot0.exchangeFatigueByItemView_:Dispose()

	slot0.exchangeFatigueByItemView_ = nil

	slot0.exchangeFatigueByCurrencyView_:Dispose()

	slot0.exchangeFatigueByCurrencyView_ = nil

	slot0.dailyFatigueView_:Dispose()

	slot0.dailyFatigueView_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sureBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_dundun_diamond_check = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		})

		if uv0.selectIndex_ == 1 then
			uv0.exchangeFatigueByItemView_:OnExchange()
		else
			uv0.exchangeFatigueByCurrencyView_:OnExchange()
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
		CurrencyConst.CURRENCY_TYPE_VITALITY,
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
	if slot1 ~= CommonBtnTypeConst.EXCHANGE_VITALITY or slot0.selectIndex_ == slot2 then
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
		slot0.isItemExchangeController_:SetSelectedIndex(1)

		slot1 = slot0.exchangeFatigueByItemView_:HasMaterial()

		slot0.dailyFatigueView_:OnUnSelect()
	elseif slot0.selectIndex_ == 2 then
		slot0.isItemExchangeController_:SetSelectedIndex(0)
		slot0.dailyFatigueView_:OnUnSelect()
	else
		slot0.isItemExchangeController_:SetSelectedIndex(2)
		slot0.dailyFatigueView_:OnSelect()
	end

	slot0.sureBtn_.interactable = slot1
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		if GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) then
			CurrencyData:SetFatigueCallFlag(0)
		end

		ShowTips("EXCHANGE_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnBuyFatigue(slot0, slot1, slot2)
	if slot1.result == 0 then
		ShowTips("TRANSACTION_SUCCESS")
		slot0:Back()
	else
		ShowTips(slot1.result)

		return
	end
end

return slot0
