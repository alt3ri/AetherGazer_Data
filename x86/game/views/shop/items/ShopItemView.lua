slot0 = class("ShopItemView", ShopItemBase)

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.limitController_ = slot0.controller_:GetController("lock")
	slot0.commonItem_ = CommonItemView.New(slot0.commonGo_)
	slot0.commonData = clone(ItemTemplateData)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, , "OnClick")
end

function slot0.UpdateTimerView(slot0)
	if slot0.isExchange or slot0.isLock then
		return
	end

	if slot0.shopCfg.refresh_cycle == 1 then
		return
	end

	slot2 = nil

	if not slot0.isExchange then
		if slot1 == 2 then
			slot2 = _G.gameTimer:GetNextMonthFreshTime()
		elseif slot1 == 3 then
			slot2 = _G.gameTimer:GetNextWeekFreshTime()
		elseif slot1 == 4 then
			slot2 = _G.gameTimer:GetNextDayFreshTime()
		elseif slot1 == 5 then
			slot2 = slot0.data.next_refresh_timestamp
		end

		slot0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCdTime3(slot2 - manager.time:GetServerTime()))
	end
end

function slot0.OnClick(slot0)
	if not ShopTools.CheckShopIsUnLock(slot0.shopID) then
		if slot0.shopCfg then
			ShowPopItem(POP_ITEM, {
				slot0.shopCfg.give_id
			})
		end

		return
	end

	slot0:ClickFunction()
end

function slot0.UpdateView(slot0)
	slot0:SetCommonItem()

	slot0.nameText_.text = string.format("%s x%d", ItemTools.getItemName(slot0.itemCfg.id), slot0.shopCfg.give)
	slot0.isLock = ShopData.IsGoodUnlock(slot0.goodID, slot0.shopID) == 0

	if slot0.isLock then
		slot1, slot2 = ShopData.GetLockTypeAndCondition(slot0.goodID, slot0.shopID)

		SetActive(slot0.null_, true)
		SetActive(slot0.countdownText_.gameObject, true)

		if slot1 == 5 then
			slot0.nullText_.text = GetTips("EXPLORE_SHOP_TIPS_1")
			slot0.countdownText_.text = string.format(GetTips("EXPLORE_SHOP_TIPS_2"), slot2)
		end
	elseif slot0.shopCfg.limit_num == -1 or slot0.shopCfg.limit_num == nil then
		SetActive(slot0.limitGo_, false)
		SetActive(slot0.null_, false)
	else
		slot1 = slot0.shopCfg.limit_num - slot0.data.buyTime

		if slot0.itemCfg.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(slot0.itemCfg.id) then
			slot1 = 0
		end

		if slot1 > 0 then
			SetActive(slot0.limitGo_, true)
			SetActive(slot0.null_, false)

			slot0.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", slot1, slot0.shopCfg.limit_num)
			slot0.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[slot0.shopCfg.refresh_cycle or 7])
		else
			if slot0.isExchange then
				slot0.limitController_:SetSelectedState("empty1")

				slot0.nullText_.text = GetTips("SOLD_OUT")
			elseif slot0.shopCfg.refresh_cycle == 1 then
				slot0.nullText_.text = GetTips("SOLD_OUT")
			elseif slot2 == 2 then
				slot0.nullText_.text = GetTips("MONTHLY_SOLD_OUT")
			elseif slot2 == 3 then
				slot0.nullText_.text = GetTips("WEEKLY_SOLD_OUT")
			elseif slot2 == 4 then
				slot0.nullText_.text = GetTips("DAILY_SOLD_OUT")
			elseif slot2 == 5 then
				slot0.nullText_.text = GetTips("ACTIVITY_SOLD_OUT")
			end

			SetActive(slot0.limitGo_, false)
			SetActive(slot0.null_, true)
		end
	end

	if slot0.shopCfg.limit_num == 0 then
		SetActive(slot0.limitGo_, false)
	end

	slot1 = slot0.shopCfg.cost

	slot0:SetCostIcon()

	slot2, slot3, slot4 = nil

	if ShopTools.GetDiscount(slot0.goodID, slot0.shopID) ~= 100 then
		slot1 = slot0.shopCfg.cheap_cost

		SetActive(slot0.discountGo_, true)

		slot0.discountText_.text = ShopTools.GetDiscountLabel(slot0.goodID, slot0.shopID)

		SetActive(slot0.oldPriceGo_, true)

		slot0.oldPriceText_.text = tostring(ShopTools.GetOriPrice(slot0.goodID, slot0.shopID))
	else
		SetActive(slot0.oldPriceGo_, false)

		if slot0.shopCfg.tag == 2 then
			SetActive(slot0.discountGo_, true)

			slot0.discountText_.text = GetTips("NEW_ADD")
		else
			SetActive(slot0.discountGo_, false)
		end
	end

	slot0:SetPriceText()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
