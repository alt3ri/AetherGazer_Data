manager.net:Bind(34031, function (slot0)
	PassportData:InitWithServerData(slot0)
	uv0.UpdateBonusRedPoint()
	uv0.UpdateNewSeasonRedPoint()
	TaskRedPoint:UpdatePassportTaskRedTip()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function ()
	uv0.UpdateBonusRedPoint()
	TaskRedPoint:UpdatePassportTaskRedTip()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function (slot0)
	if slot0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
		uv0.UpdateBonusRedPoint()
	end
end)

return {
	UpdateBonusRedPoint = function ()
		manager.redPoint:setTip(RedPointConst.PASSPORT_BONUS, #PassportData:GetCanGetBonusList() > 0 and (PassportData:IsOpen() and PassportData:IsUnlock()) and 1 or 0)
	end,
	UpdateNewSeasonRedPoint = function ()
		manager.redPoint:setTip(RedPointConst.PASSPORT_NEW_SEASON, getData("passport", "poster_" .. PassportData:GetId()) ~= "1" and 1 or 0, RedPointStyle.SHOW_NEW_TAG)
	end,
	RequestPassportData = function ()
		manager.net:SendWithLoadingNew(34030, {}, 34031, uv0.OnPassportData)
	end,
	OnPassportData = function (slot0, slot1)
		PassportData:InitWithServerData(slot0)
		uv0.UpdateBonusRedPoint()

		if PassportData:GetPayLevel() <= 0 then
			for slot6, slot7 in pairs(gameContext:GetAllOpenPage()) do
				if slot7.__cname == "PassportMainView" then
					gameContext:Go("/home")
					ShowTips("BATTLEPASS_EXPIRED")

					break
				end
			end
		end

		TaskRedPoint:UpdatePassportTaskRedTip()
	end,
	RequestGetBonus = function (slot0, slot1)
		manager.net:SendWithLoadingNew(34032, {
			id = slot0,
			is_pay = slot1
		}, 34033, uv0.OnGetBonus)
	end,
	OnGetBonus = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward(slot0.reward_list)
			PassportData:GetBonusSuccess(slot1.id, slot0.receive_info)
			uv0.UpdateBonusRedPoint()
		end
	end,
	BuyLevel = function (slot0)
		manager.net:SendWithLoadingNew(34036, {
			num = slot0
		}, 34037, uv0.OnBuyLevel)
	end,
	OnBuyLevel = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(PASSPORT_ONBUYLEVEL)
			ShowTips("TRANSACTION_SUCCESS")
			uv0.UpdateBonusRedPoint()
		end
	end,
	OneKeyGet = function ()
		manager.net:SendWithLoadingNew(34034, {}, 34035, uv0.OnOneKeyGet)
	end,
	OnOneKeyGet = function (slot0, slot1)
		if isSuccess(slot0.result) then
			PassportData:MarkAllBonusGet(slot0)
			getReward(slot0.reward_list)
			uv0.UpdateBonusRedPoint()
		else
			ShowTips(slot0.result)
		end
	end
}
