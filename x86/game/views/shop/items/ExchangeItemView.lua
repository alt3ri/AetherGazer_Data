slot0 = class("ExchangeItemView", ShopItemBase)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItemView.New(slot0.commonGo_)
	slot0.commonData = clone(ItemTemplateData)
	slot0.lockController = slot0.controller_:GetController("lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, function ()
		if uv0.callBack then
			uv0.callBack(uv0.data)

			return
		end

		uv0:ClickFunction()
	end)
end

function slot0.UpdateView(slot0)
	slot0.commonData.id = slot0.itemCfg.id
	slot0.commonData.number = slot0.shopCfg.give

	slot0.commonItem_:SetData(slot0.commonData)

	slot0.nameText_.text = ItemTools.getItemName(slot0.itemCfg.id)

	SetActive(slot0.limitGo_, false)
	SetActive(slot0.newGo_, slot0.shopCfg.tag == ShopConst.TAGS.NEW)
	SetActive(slot0.discountGo_, ShopTools.GetDiscount(slot0.goodID) ~= 100)
	SetActive(slot0.oldPriceGo_, ShopTools.GetDiscount(slot0.goodID) ~= 100)
	slot0:SetCostIcon()
	slot0:SetPriceText()

	if ShopTools.GetDiscount(slot0.goodID) ~= 100 then
		slot0.discountText_.text = ShopTools.GetDiscountLabel(slot0.goodID)
		slot0.oldPriceText_.text = tostring(ShopTools.GetOriPrice(slot0.goodID))
	end

	if slot0.shopCfg.limit_num == -1 or slot0.shopCfg.limit_num == nil then
		SetActive(slot0.limitGo_, false)
		slot0.lockController:SetSelectedState("null")
	else
		if slot0.itemCfg.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(slot0.itemCfg.id) then
			slot0.restNum = 0
		end

		SetActive(slot0.limitGo_, slot0.restNum > 0)

		slot0.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", slot0.restNum, slot0.shopCfg.limit_num)
		slot0.limitText_.text = GetTips(slot0.restNum > 0 and "PURCHASE_LIMIT" or "SOLD_OUT")

		if slot0.restNum <= 0 then
			if slot0.shopCfg.refresh_cycle == 1 or slot0.isExchange then
				slot0.lockController:SetSelectedState("refresh1")
			else
				slot0.lockController:SetSelectedState("refresh2")
			end
		else
			slot0.lockController:SetSelectedState("null")
		end
	end

	if slot0.restNum <= 0 then
		if slot0.isExchange then
			slot0.soldOutText_.text = GetTips("SOLD_OUT")
		elseif slot0.shopCfg.refresh_cycle == 1 then
			slot0.soldOutText_.text = GetTips("SOLD_OUT")
		elseif slot1 == 2 then
			slot0.soldOutText_.text = GetTips("MONTHLY_SOLD_OUT")
		elseif slot1 == 3 then
			slot0.soldOutText_.text = GetTips("WEEKLY_SOLD_OUT")
		elseif slot1 == 4 then
			slot0.soldOutText_.text = GetTips("DAILY_SOLD_OUT")
		elseif slot1 == 5 then
			slot0.soldOutText_.text = GetTips("ACTIVITY_SOLD_OUT")
		end
	end

	slot0:UpdateLock()
end

function slot0.UpdateLock(slot0)
	slot0.isGoodLock = ShopData.IsGoodUnlock(slot0.goodID) == 0

	if slot0.isGoodLock then
		slot1, slot2 = ShopData.GetLockTypeAndCondition(slot0.goodID)

		slot0.lockController:SetSelectedState("lock")

		if slot1 == 5 then
			slot0.nullText_.text = string.format(GetTips("EXPLORE_AREA_DEBLOCKING"), slot2)
		end
	end

	slot0.isShopLock = not ShopTools.CheckShopIsUnLock(slot0.shopID)

	if slot0.isShopLock then
		slot0.lockController:SetSelectedState("lock")

		slot0.nullText_.text = GetTips("SHOP_LOCK")
	end
end

function slot0.UpdateTimerView(slot0)
	slot0:CloseTimer()

	if slot0.restNum > 0 then
		return
	end

	if slot0.isExchange or slot0.isLock then
		return
	end

	if slot0.shopCfg.refresh_cycle == 1 then
		return
	end

	if not slot0.isExchange then
		slot0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStrWith2Unit(slot0:GetLeftTime(), true))
		slot0.updateTimer = Timer.New(function ()
			if uv0.countdownText_ then
				uv0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStrWith2Unit(uv0:GetLeftTime(), true))
			else
				uv0:CloseTimer()
			end
		end, 1, -1, 1)

		slot0.updateTimer:Start()
	end
end

function slot0.CloseTimer(slot0)
	if slot0.updateTimer then
		slot0.updateTimer:Stop()

		slot0.updateTimer = nil
	end
end

function slot0.GetLeftTime(slot0)
	slot1 = nil

	if slot0.shopCfg.refresh_cycle == 2 then
		slot1 = _G.gameTimer:GetNextMonthFreshTime()
	elseif slot0.shopCfg.refresh_cycle == 3 then
		slot1 = _G.gameTimer:GetNextWeekFreshTime()
	elseif slot0.shopCfg.refresh_cycle == 4 then
		slot1 = _G.gameTimer:GetNextDayFreshTime()
	elseif slot0.shopCfg.refresh_cycle == 5 then
		slot1 = slot0.data.next_refresh_timestamp
	end

	return slot1
end

function slot0.OnExit(slot0)
	slot0:CloseTimer()

	slot0.callBack = nil
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnClick(slot0)
	if not ShopTools.CheckShopIsUnLock(slot0.shopID) then
		ShowPopItem(POP_ITEM, {
			slot0.shopCfg.give_id
		})

		return
	end

	slot0:ClickFunction()
end

return slot0
