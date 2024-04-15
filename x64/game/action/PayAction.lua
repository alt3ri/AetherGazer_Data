slot0 = require("cjson")
slot1 = {
	RefreshAllRedPoint = function ()
		uv0.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.LIMIT_SUPPLY)
		uv0.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.DAILY_SUPPLY)
		uv0.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.NEWBIE_SHOP)
		uv0.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.RE_COME_SHOP)
		uv0.UpdateFreeGiftRedPoint(ShopConst.SHOP_ID.NEW_SERVER_SHOP)
	end,
	AfterPayGetReward = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if ItemCfg[slot5.id] and slot7.type == 5 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == slot7.sub_type then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("LUCKILYBAG_JUMP"),
					OkCallback = function ()
						JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
					end
				})

				return
			end
		end
	end,
	UpdateFreeGiftRedPoint = function (slot0)
		if slot0 ~= ShopConst.SHOP_ID.LIMIT_SUPPLY and slot0 ~= ShopConst.SHOP_ID.DAILY_SUPPLY and slot0 ~= ShopConst.SHOP_ID.NEWBIE_SHOP and slot0 ~= ShopConst.SHOP_ID.RE_COME_SHOP and slot0 ~= ShopConst.SHOP_ID.NEW_SERVER_SHOP then
			return
		end

		if not ShopData.GetShop(slot0) then
			return
		end

		slot3 = 0

		for slot7, slot8 in pairs(slot1.shopItemIDs) do
			if ShopTools.GetPrice(slot8) == 0 and ShopTools.IsGoodCanDisplay(slot0, slot8) and ShopData.IsGoodUnlock(slot8) == 1 and not ShopData.IsSoldout(slot0, slot8) then
				slot3 = 1
			end

			slot10 = 0

			for slot14, slot15 in pairs(slot1.shopItemIDs) do
				if ShopTools.GetPrice(slot15) == 0 and ShopTools.IsGoodCanDisplay(slot0, slot15) and ShopData.IsGoodUnlock(slot15) == 1 and not ShopData.IsSoldout(slot0, slot15) then
					slot10 = 1
				end
			end

			if OperationData:IsFunctionStoped(ShopListCfg[slot0].operation_stop_id) then
				slot10 = 0
			end

			if slot0 == ShopConst.SHOP_ID.LIMIT_SUPPLY then
				manager.redPoint:setTip(RedPointConst.ACTIVITY_BONUS_FREE, slot10)
			elseif slot0 == ShopConst.SHOP_ID.DAILY_SUPPLY then
				manager.redPoint:setTip(RedPointConst.NORMAL_BONUS_FREE, slot10)
			elseif slot0 == ShopConst.SHOP_ID.NEWBIE_SHOP then
				manager.redPoint:setTip(RedPointConst.NEWBIE_BONUS_FREE, slot10)
			elseif slot0 == ShopConst.SHOP_ID.RE_COME_SHOP then
				manager.redPoint:setTip(RedPointConst.REGRESSION_SUPPLY_FREE, slot10)
			elseif slot0 == ShopConst.SHOP_ID.NEW_SERVER_SHOP then
				manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE, slot10)
			end
		end

		if OperationData:IsFunctionStoped(ShopListCfg[slot0].operation_stop_id) then
			slot3 = 0
		end

		if slot0 == ShopConst.SHOP_ID.LIMIT_SUPPLY then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_BONUS_FREE, slot3)
		elseif slot0 == ShopConst.SHOP_ID.DAILY_SUPPLY then
			manager.redPoint:setTip(RedPointConst.NORMAL_BONUS_FREE, slot3)
		elseif slot0 == ShopConst.SHOP_ID.NEWBIE_SHOP then
			manager.redPoint:setTip(RedPointConst.NEWBIE_BONUS_FREE, slot3)
		elseif slot0 == ShopConst.SHOP_ID.RE_COME_SHOP then
			manager.redPoint:setTip(RedPointConst.REGRESSION_SUPPLY_FREE, slot3)
		elseif slot0 == ShopConst.SHOP_ID.NEW_SERVER_SHOP then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE, slot3)
		end
	end
}
slot2, slot3, slot4 = nil
slot5 = 0

manager.net:Bind(34009, function (slot0)
	slot1 = slot0.order

	print(string.format("=======> pay result, channel = %s, platform = %s, create_timestamp = %s", tostring(slot1.channel), tostring(slot1.platform), tostring(slot1.create_timestamp)))

	if SDKTools.IsSDK() and (slot1.channel ~= uv0 or slot1.platform ~= uv1 or slot1.create_timestamp ~= uv2) then
		return
	end

	if uv3.payTimer_ ~= nil then
		uv3.payTimer_:Stop()

		uv3.payTimer_ = nil
	end

	uv3.ShowWaiting(false)

	slot2 = slot1.order_id
	slot4 = slot1.num
	slot5 = slot1.value
	slot6 = slot1.sign
	slot7 = slot1.state
	slot8 = PaymentCfg[slot1.goods_id]

	if getShopCfg(slot1.shop_goods_id) then
		slot10 = slot9.give_id and ItemCfg[slot9.give_id] or RechargeShopDescriptionCfg[slot9.description]

		ShowTips(string.format(GetTips("PAY_SUCCESS"), GetI18NText(slot10 and slot10.name or tostring(slot1.shop_goods_id))))
	else
		ShowTips(string.format(GetTips("PAY_SUCCESS"), GetI18NText(slot8.name)))
	end

	RechargeData:RecordTotalRecharge(slot3)
	uv3.UpdateTotalRechargeRedPoint()

	if slot8.type == 1 then
		RechargeData:RecordRecharge(slot3)
	elseif slot8.type == 2 then
		RechargeData:SignToday()
	elseif slot8.type == 3 then
		PassportData:BuyedCard(slot8.id)
	end

	if slot0.reward and #slot0.reward > 0 then
		if whereami == "battle" or whereami == "battleResult" or manager.guide:IsPlaying() then
			manager.notify:Invoke(RECHARGE_SUCCESS, slot8.id)
		else
			getReward(slot0.reward, nil, function ()
				manager.notify:Invoke(RECHARGE_SUCCESS, uv0.id)
				uv1.AfterPayGetReward(uv2.reward)
			end)
		end
	else
		manager.notify:Invoke(RECHARGE_SUCCESS, slot8.id)
	end

	if slot8.type == 1 then
		SendMessageManagerToSDK("purchase_crystal", {
			purchaseNum = slot8.total_point
		})
	elseif slot8.type == 3 then
		SendMessageManagerToSDK("passport_complete")
	elseif slot8.type == 4 then
		SendMessageManagerToSDK("purchase_complete_skin")
	end

	if uv4 <= 0 then
		uv4 = uv4 + slot5 / 100

		SendMessageManagerToSDK("purchase_first_ys")
	end

	SendMessageManagerToSDK("purchase_complete")
	SendMessageManagerToSDK("purchase_ys", {
		value = slot5 / 100,
		order_id = slot2,
		currency_type = slot8.currency_type
	})
end)
manager.notify:RegistListener(RECHARGE_FAILED, function ()
	uv0.ShowWaiting(false)
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.RefreshAllRedPoint()
end)
manager.notify:RegistListener(OPERATION_STOP_UPDATE, function ()
	uv0.RefreshAllRedPoint()
end)
manager.notify:RegistListener(SHOP_LIST_UPDATE, function (slot0)
	if slot0 == 0 then
		uv0.RefreshAllRedPoint()
	end
end)
manager.notify:RegistListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
	if slot0 == ShopConst.SHOP_ID.LIMIT_SUPPLY or slot0 == ShopConst.SHOP_ID.DAILY_SUPPLY or slot0 == ShopConst.SHOP_ID.NEWBIE_SHOP or slot0 == ShopConst.SHOP_ID.RE_COME_SHOP or slot0 == ShopConst.SHOP_ID.NEW_SERVER_SHOP then
		uv0.RefreshAllRedPoint()
	end
end)
manager.net:Bind(34007, function (slot0)
	RechargeData:InitTotalRechargeDataFromServer(slot0)
	SDKTools.SetRechargePublicAttribute()
	uv0.UpdateTotalRechargeRedPoint()

	uv1 = slot0.total_recharge_num / 100
end)
manager.net:Bind(34021, function (slot0)
	RechargeData:InitFirstChargeDataFromServer(slot0)
end)

slot6 = -1

manager.net:Bind(34023, function (slot0)
	if uv0 >= 0 and uv0 < slot0.monthly_card_num then
		SendMessageManagerToSDK("purchase_complete_montlycard")
	end

	uv0 = slot0.monthly_card_num

	RechargeData:InitWithServerData(slot0)
	SDKTools.SetRechargePublicAttribute()
end)
slot1.RefreshAllRedPoint()

function slot1.UpdateTotalRechargeRedPoint()
	manager.redPoint:setTip(RedPointConst.TOTAL_CHARGE_BONUS, RechargeData:HaveUngetTotalRechargeBonus() and 1 or 0)
end

function slot1.GetMonthCardBonus()
	manager.net:SendWithLoadingNew(34024, {}, 34025, uv0.OnGetMonthCardBonus)
end

function slot1.OnGetMonthCardBonus(slot0, slot1)
	if isSuccess(slot0.result) then
		RechargeData:SignToday(slot0.is_sign)
		getReward(slot0.reward_list)
		manager.notify:CallUpdateFunc(MONTH_CARD_DAILY_REWARD)
		ActivityNewbieTools.SetMonthlyCardSign()
	end
end

function slot1.RequestGSPay(slot0, slot1, slot2, slot3, slot4, slot5)
	if ShopTools.IsPC() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	uv0.gsPayCallback_ = slot4

	if slot2 ~= nil then
		-- Nothing
	end

	if slot3 ~= nil then
		slot6.buy_id = slot3
	end

	if slot5 ~= nil then
		slot6.buy_source = slot5
	end

	manager.net:SendWithLoadingNew(34010, {
		id = slot0,
		number = slot1 or 1,
		shop_id = slot2
	}, 34011, uv0.OnRequestGSPayCallback)
	uv0.ShowWaiting(true)
	SendMessageManagerToSDK("purchase_click")
end

function slot1.OnRequestGSPayCallback(slot0, slot1)
	if ShopTools.IsPC() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	if isSuccess(slot0.result) then
		slot2 = slot0.order

		print("extra_data = " .. slot2.extra_data)

		slot4 = slot2.goods_id
		slot8 = slot2.state
		uv0 = slot2.channel
		uv1 = slot2.platform
		uv2 = slot2.create_timestamp

		print(string.format("=======> pay request, channel = %s, platform = %s, create_timestamp = %s", tostring(uv0), tostring(uv1), tostring(uv2)))

		slot9 = PaymentCfg[slot1.id]
		slot10 = {}
		slot11 = PlayerData:GetPlayerInfo()

		if GameToSDK.PLATFORM_ID == 1 then
			slot10 = {
				productId = slot9.product_id,
				price = slot2.value,
				count = slot2.num,
				outOrderNo = slot2.order_id,
				currency = slot9.currency_type,
				extraData = slot2.extra_data,
				orderSign = slot2.sign,
				params = {
					gameRoleId = slot11.userID,
					gameRoleName = slot11.nick,
					gameRoleLevel = slot11.userLevel,
					gameServerId = _G.TMP_SERVER_ID,
					gameServerName = tostring(_G.TMP_SERVER_ID),
					gameServerCode = _G.TMP_SERVER_ID
				}
			}
		elseif GameToSDK.PLATFORM_ID == 0 then
			slot10 = {
				orderId = slot3,
				productId = slot9.product_id,
				productName = slot9.name,
				productDes = slot9.describe,
				price = slot6,
				count = slot5,
				currentNum = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_RMB),
				gameServerId = _G.TMP_SERVER_ID,
				gameServerName = tostring(_G.TMP_SERVER_ID),
				gameServerCode = _G.TMP_SERVER_ID,
				gameRoleId = slot11.userID,
				gameRoleName = slot11.nick,
				gameRoleLevel = slot11.userLevel,
				currency = slot9.currency_type,
				orderSign = slot7,
				extraData = slot2.extra_data
			}
		end

		GameToSDK.Pay(uv3.encode(slot10))
		uv4.ShowWaiting(true)
	else
		if TipsCfg[slot0.result] ~= nil then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(GetTips(tostring(slot0.result)))
		end

		uv4.ShowWaiting(false)
	end

	if uv4.gsPayCallback_ ~= nil then
		uv4.gsPayCallback_(slot0)

		uv4.gsPayCallback_ = nil
	end
end

function slot1.GetTotalRechargeBonus(slot0)
	manager.net:SendWithLoadingNew(34012, {
		id = slot0
	}, 34013, uv0.OnGetTotalRechargeBonus)
end

function slot1.OnGetTotalRechargeBonus(slot0, slot1)
	if isSuccess(slot0.result) then
		RechargeData:MarkBonusGet(slot0)
		getReward(slot0.reward_list)
		manager.notify:Invoke(GET_TOTAL_RECHARGE_BONUS, slot1.id)
		uv0.UpdateTotalRechargeRedPoint()
	end
end

function slot1.ShowWaiting(slot0, slot1)
	SetForceShowQuanquan(slot0)

	if slot0 then
		uv0.payTimer_ = TimeTools.StartAfterSeconds(slot1 or 180, function ()
			if uv0.payTimer_ ~= nil then
				uv0.payTimer_:Stop()

				uv0.payTimer_ = nil
			end

			SetForceShowQuanquan(false)
		end, {})
	elseif uv0.payTimer_ ~= nil then
		uv0.payTimer_:Stop()

		uv0.payTimer_ = nil
	end
end

return slot1
