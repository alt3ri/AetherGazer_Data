slot0 = class("RechargeDiamondExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/Addshiftedstars"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
	slot0:UpdateBar()
	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_flower_to_diamond = "{" .. ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) .. "," .. CurrencyData:GetRechargeDiamond()
	})
	manager.windowBar:SetAsLastSibling()
end

function slot0.ConfirmToDo(slot0, slot1)
	slot2 = ItemCfg[slot0.params_.useId]
	slot3 = ItemCfg[slot0.params_.getId]

	SDKTools.SendPaymentMessageToSDK("payment_touch", {
		payment_ticket_check = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
	})

	slot4 = tonumber(slot0.inputFieldText_.text)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("CONFIRM_BUY"), ItemTools.getItemName(slot0.params_.useId), slot0.params_.useBaseNum * slot4, ItemTools.getItemName(slot0.params_.getId), slot0.params_.getBaseNum * slot4),
		OkCallback = function ()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 0
			})
			uv0()
		end,
		CancelCallback = function ()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_flower_to_diamond_check = 1
			})
		end
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		uv0:CheckBuy()
	end)
	slot0:AddPressingByTimeListener(slot0.addBtn_.gameObject, 3, 0.5, 0.2, function ()
		if uv0.canUseMaxNum_ <= tonumber(uv0.inputFieldText_.text) then
			return false
		end

		if (uv0.pressCnt_ > 1 and (uv0.pressCnt_ == 2 and slot0 + 9 or slot0 + 10) or slot0 + 1) < uv0.canUseMaxNum_ then
			uv0:UpdateCnt(slot0)

			return true
		end

		uv0:UpdateCnt(uv0.canUseMaxNum_)

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.delBtn_.gameObject, 3, 0.5, 0.2, function ()
		if tonumber(uv0.inputFieldText_.text) <= 1 then
			return false
		end

		if (uv0.pressCnt_ > 1 and (uv0.pressCnt_ == 2 and slot0 - 9 or slot0 - 10) or slot0 - 1) > 1 then
			uv0:UpdateCnt(slot0)

			return true
		end

		uv0:UpdateCnt(1)

		return false
	end)
	slot0:AddBtnListener(slot0.maxBtn_, nil, function ()
		uv0:UpdateCnt(uv0.canUseMaxNum_)
	end)
	slot0.inputFieldText_.onValueChanged:AddListener(function ()
		if (tonumber(uv0.inputFieldText_.text) or 0) < 1 then
			slot0 = 1
		end

		uv0:UpdateCnt(slot0)
	end)
end

function slot0.UpdateView(slot0)
	if slot0.params_.useId then
		slot0.icon1_.sprite = ItemTools.getItemLittleSprite(slot0.params_.useId)
		slot0.useNameText_.text = ItemTools.getItemName(slot0.params_.useId)
	end

	if slot0.params_.getId then
		slot1 = ItemTools.getItemLittleSprite(slot0.params_.getId)
		slot0.icon2_.sprite = slot1
		slot0.getImage_.sprite = slot1
		slot0.getNameText_.text = ItemTools.getItemName(slot0.params_.getId)
		slot0.titleText_.text = string.format(GetTips("EXCHANGE_TIP"), ItemTools.getItemName(slot0.params_.getId))
	end

	slot0.canUseMaxNum_ = math.floor(slot0:GetTotal() / (slot0.params_.useBaseNum or 1))

	slot0:UpdateCnt(slot0.params_.defaultNum ~= 0 and slot0.params_.defaultNum or 1)

	if slot0.canUseMaxNum_ ~= 1 == false then
		slot0.addBtn_.interactable = slot2
		slot0.maxBtn_.interactable = slot2
	end
end

function slot0.UpdateBar(slot0)
	slot0.lastBarList_ = manager.windowBar:GetLastBarList() or {}
	slot0.lastAddBarList_ = manager.windowBar:GetLastAddBarList()
	slot0.lastCanClickBarList_ = manager.windowBar:GetLastCanClickBarList()

	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})

	if whereami ~= "battle" and whereami ~= "battleResult" then
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	end
end

function slot0.GetTotal(slot0)
	if slot0.params_.useId == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or slot0.params_.useId == CurrencyConst.GetPlatformDiamondId() then
		return CurrencyData:GetRechargeDiamond()
	end

	return ItemTools.getItemNum(slot0.params_.useId)
end

function slot0.UpdateCnt(slot0, slot1)
	slot0.useNumText_.text = NumberTools.RetractNumberForWindBar(slot1 * slot0.params_.useBaseNum)
	slot0.getNumText_.text = NumberTools.RetractNumberForWindBar(slot1)

	if tonumber(slot0.inputFieldText_.text) ~= slot1 then
		slot0.inputFieldText_.text = slot1
	end

	slot0.tipsNumText_.text = slot1

	if slot0.canUseMaxNum_ < slot1 then
		slot0.inputFieldText_.textComponent.color = Color(1, 0, 0.043)
	else
		slot0.inputFieldText_.textComponent.color = Color(0.302, 0.338, 0.389)
	end

	slot0.delBtn_.interactable = slot1 > 1
	slot0.addBtn_.interactable = slot1 < slot0.canUseMaxNum_
	slot0.maxBtn_.interactable = slot1 < slot0.canUseMaxNum_
end

function slot0.CheckBuy(slot0)
	if slot0.params_.defaultNum ~= 0 then
		slot1 = tonumber(slot0.inputFieldText_.text) * slot0.params_.useBaseNum
	end

	if slot0.params_.getId == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		if slot1 <= CurrencyData:GetRechargeDiamond() then
			slot0:ConfirmToDo(function ()
				CurrencyAction.BuyDiamond(uv0)
			end)
		else
			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
				ShopTools.DiamondEnoughMessageBox()
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
			end
		end
	elseif slot0.params_.exchangeId then
		if getShopCfg(slot0.params_.exchangeId).cost_id == CurrencyConst.CURRENCY_TYPE_DIAMOND then
			if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) < slot2.cost * slot1 then
				slot0:Back()
				ShopTools.DefaultOpenPopUp(0)

				return
			end
		elseif slot3 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE and CurrencyData:GetRechargeDiamond() < slot2.cost * slot1 then
			slot0:Back()

			if whereami == "battle" or whereami == "battleResult" then
				ShowTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH_NO_BUY")

				return
			end

			ShopTools.DiamondEnoughMessageBox()

			return
		end

		slot0:ConfirmToDo(function ()
			slot0 = nil

			if uv0.params_.buy_source then
				slot0 = uv0.params_.buy_source
			end

			ShopAction.BuyItem({
				{
					goodID = uv1.goods_id,
					buyNum = uv2
				}
			}, nil, slot0)
		end)
	end
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

function slot0.OnBuyDiamond(slot0, slot1, slot2)
	if slot1.result == 0 then
		slot0:Back()
		ShowTips("TRANSACTION_SUCCESS")
	end
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot1 == 0 then
		slot0:Back()
	end
end

function slot0.OnExit(slot0)
	slot0:RestoreBar()
	manager.windowBar:SetAsFirstSibling()

	slot0.lastBarList_ = nil
	slot0.lastAddBarList_ = nil
	slot0.lastCanClickBarList_ = nil
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
