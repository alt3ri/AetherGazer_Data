manager.net:Bind(15005, function (slot0)
	CurrencyData:InitExpiredCurrencyList(slot0.invalid_item_list)
end)
manager.net:Bind(15007, function (slot0)
	CurrencyAction.CurrencyBuyTimes(slot0.left_time_coin, slot0.left_time_fatigue)
end)
manager.net:Bind(15009, function (slot0)
	CurrencyAction.CurrencyInit(slot0.currency_list, slot0.last_fatigue_recover_time)
end)

return {
	CurrencyBuyTimes = function (slot0, slot1)
		CurrencyData:CurrencyBuyTimes(slot0, slot1)
	end,
	CurrencyInit = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot0) do
			if slot6.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT then
				AchievementData:InitAchievementPoint(slot6.num)
			end
		end

		CurrencyData:CurrencyInit(slot0, slot1)
	end,
	SetCurrencyValue = function (slot0, slot1, slot2)
		if slot0 == CurrencyConst.CURRENCY_TYPE_PLAYER_EXP then
			PlayerAction.EXPChange(slot1)
		elseif slot0 == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT then
			AchievementData:SetAchievementPoint(slot1)
		else
			CurrencyData:SetCurrencyValue(slot0, slot1, slot2)
		end
	end,
	BuyCoin = function ()
		manager.net:SendWithLoadingNew(15012, {
			id = 2
		}, 15013, uv0.OnBuyCoin)
	end,
	OnBuyCoin = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_BUY_COIN, slot0, slot1)
	end,
	BuyFatigue = function ()
		manager.net:SendWithLoadingNew(15016, {
			num = 1
		}, 15017, uv0.OnBuyFatigue)
	end,
	OnBuyFatigue = function (slot0, slot1)
		manager.notify:CallUpdateFunc(ON_BUY_FATIGUE, slot0, slot1)
	end,
	BuyDiamond = function (slot0)
		manager.net:SendWithLoadingNew(15020, {
			num = slot0
		}, 15021, uv0.OnBuyDiamond)
	end,
	OnBuyDiamond = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(ON_BUY_DIAMOND, slot0, slot1)
			manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK)
		else
			ShowTips(slot0.result)
		end
	end,
	VitalityFull = function (slot0)
		CurrencyData:VitalityFull(slot0)
	end,
	ExchangeItem = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(15022, {
			exchange_id = slot0,
			num = slot1
		}, 15023, function (slot0)
			if isSuccess(slot0.result) then
				uv0(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReadExpiredCurrency = function ()
		manager.net:SendWithLoadingNew(15024, {
			nothing = 0
		}, 15025, uv0.OnReadExpiredCurrencyCallback)
	end,
	OnReadExpiredCurrencyCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CurrencyData:ClearExpiredCurrencyList()
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
