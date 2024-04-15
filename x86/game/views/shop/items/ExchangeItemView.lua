local var_0_0 = class("ExchangeItemView", ShopItemBase)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.commonGo_)
	arg_1_0.commonData = clone(ItemTemplateData)
	arg_1_0.lockController = arg_1_0.controller_:GetController("lock")
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.clickBtn_, nil, function()
		if arg_2_0.callBack then
			arg_2_0.callBack(arg_2_0.data)

			return
		end

		arg_2_0:ClickFunction()
	end)
end

function var_0_0.UpdateView(arg_4_0)
	arg_4_0.commonData.id = arg_4_0.itemCfg.id
	arg_4_0.commonData.number = arg_4_0.shopCfg.give

	arg_4_0.commonItem_:SetData(arg_4_0.commonData)

	arg_4_0.nameText_.text = ItemTools.getItemName(arg_4_0.itemCfg.id)

	SetActive(arg_4_0.limitGo_, false)
	SetActive(arg_4_0.newGo_, arg_4_0.shopCfg.tag == ShopConst.TAGS.NEW)
	SetActive(arg_4_0.discountGo_, ShopTools.GetDiscount(arg_4_0.goodID) ~= 100)
	SetActive(arg_4_0.oldPriceGo_, ShopTools.GetDiscount(arg_4_0.goodID) ~= 100)
	arg_4_0:SetCostIcon()
	arg_4_0:SetPriceText()

	if ShopTools.GetDiscount(arg_4_0.goodID) ~= 100 then
		arg_4_0.discountText_.text = ShopTools.GetDiscountLabel(arg_4_0.goodID)
		arg_4_0.oldPriceText_.text = tostring(ShopTools.GetOriPrice(arg_4_0.goodID))
	end

	if arg_4_0.shopCfg.limit_num == -1 or arg_4_0.shopCfg.limit_num == nil then
		SetActive(arg_4_0.limitGo_, false)
		arg_4_0.lockController:SetSelectedState("null")
	else
		if arg_4_0.itemCfg.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(arg_4_0.itemCfg.id) then
			arg_4_0.restNum = 0
		end

		SetActive(arg_4_0.limitGo_, arg_4_0.restNum > 0)

		arg_4_0.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", arg_4_0.restNum, arg_4_0.shopCfg.limit_num)
		arg_4_0.limitText_.text = GetTips(arg_4_0.restNum > 0 and "PURCHASE_LIMIT" or "SOLD_OUT")

		if arg_4_0.restNum <= 0 then
			if arg_4_0.shopCfg.refresh_cycle == 1 or arg_4_0.isExchange then
				arg_4_0.lockController:SetSelectedState("refresh1")
			else
				arg_4_0.lockController:SetSelectedState("refresh2")
			end
		else
			arg_4_0.lockController:SetSelectedState("null")
		end
	end

	if arg_4_0.restNum <= 0 then
		if arg_4_0.isExchange then
			arg_4_0.soldOutText_.text = GetTips("SOLD_OUT")
		else
			local var_4_0 = arg_4_0.shopCfg.refresh_cycle

			if var_4_0 == 1 then
				arg_4_0.soldOutText_.text = GetTips("SOLD_OUT")
			elseif var_4_0 == 2 then
				arg_4_0.soldOutText_.text = GetTips("MONTHLY_SOLD_OUT")
			elseif var_4_0 == 3 then
				arg_4_0.soldOutText_.text = GetTips("WEEKLY_SOLD_OUT")
			elseif var_4_0 == 4 then
				arg_4_0.soldOutText_.text = GetTips("DAILY_SOLD_OUT")
			elseif var_4_0 == 5 then
				arg_4_0.soldOutText_.text = GetTips("ACTIVITY_SOLD_OUT")
			end
		end
	end

	arg_4_0:UpdateLock()
end

function var_0_0.UpdateLock(arg_5_0)
	arg_5_0.isGoodLock = ShopData.IsGoodUnlock(arg_5_0.goodID) == 0

	if arg_5_0.isGoodLock then
		local var_5_0, var_5_1 = ShopData.GetLockTypeAndCondition(arg_5_0.goodID)

		arg_5_0.lockController:SetSelectedState("lock")

		if var_5_0 == 5 then
			arg_5_0.nullText_.text = string.format(GetTips("EXPLORE_AREA_DEBLOCKING"), var_5_1)
		end
	end

	arg_5_0.isShopLock = not ShopTools.CheckShopIsUnLock(arg_5_0.shopID)

	if arg_5_0.isShopLock then
		arg_5_0.lockController:SetSelectedState("lock")

		arg_5_0.nullText_.text = GetTips("SHOP_LOCK")
	end
end

function var_0_0.UpdateTimerView(arg_6_0)
	arg_6_0:CloseTimer()

	if arg_6_0.restNum > 0 then
		return
	end

	if arg_6_0.isExchange or arg_6_0.isLock then
		return
	end

	if arg_6_0.shopCfg.refresh_cycle == 1 then
		return
	end

	local var_6_0 = arg_6_0:GetLeftTime()

	if not arg_6_0.isExchange then
		arg_6_0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStrWith2Unit(var_6_0, true))
		arg_6_0.updateTimer = Timer.New(function()
			if arg_6_0.countdownText_ then
				local var_7_0 = arg_6_0:GetLeftTime()

				arg_6_0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStrWith2Unit(var_7_0, true))
			else
				arg_6_0:CloseTimer()
			end
		end, 1, -1, 1)

		arg_6_0.updateTimer:Start()
	end
end

function var_0_0.CloseTimer(arg_8_0)
	if arg_8_0.updateTimer then
		arg_8_0.updateTimer:Stop()

		arg_8_0.updateTimer = nil
	end
end

function var_0_0.GetLeftTime(arg_9_0)
	local var_9_0

	if arg_9_0.shopCfg.refresh_cycle == 2 then
		var_9_0 = _G.gameTimer:GetNextMonthFreshTime()
	elseif arg_9_0.shopCfg.refresh_cycle == 3 then
		var_9_0 = _G.gameTimer:GetNextWeekFreshTime()
	elseif arg_9_0.shopCfg.refresh_cycle == 4 then
		var_9_0 = _G.gameTimer:GetNextDayFreshTime()
	elseif arg_9_0.shopCfg.refresh_cycle == 5 then
		var_9_0 = arg_9_0.data.next_refresh_timestamp
	end

	return var_9_0
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:CloseTimer()

	arg_10_0.callBack = nil
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.commonItem_:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnClick(arg_12_0)
	if not ShopTools.CheckShopIsUnLock(arg_12_0.shopID) then
		ShowPopItem(POP_ITEM, {
			arg_12_0.shopCfg.give_id
		})

		return
	end

	arg_12_0:ClickFunction()
end

return var_0_0
