manager.net:Bind(34101, function (slot0)
	BigMonthCardData:InitData(slot0)
	uv0.RefreshRedPoint()
end)

return {
	SignToday = function ()
		manager.net:SendWithLoadingNew(34110, {}, 34111, uv0.OnSignToday)
	end,
	OnSignToday = function (slot0, slot1)
		if isSuccess(slot0.result) then
			BigMonthCardData:SetRecord(slot0.daily_record)
			BigMonthCardData:UpdateIsSign(slot0.is_sign)
			BigMonthCardData:UpdateSignData(slot0.total_sign_times)
			uv0.RefreshRedPoint()
			manager.notify:CallUpdateFunc(BIG_MONTH_CARD_SIGN, slot0.rewards, slot0)
		else
			ShowTips(slot0.result)
		end
	end,
	AccumulateSign = function (slot0)
		manager.net:SendWithLoadingNew(34112, {
			id = slot0
		}, 34113, uv0.OnAccumulateSign)
	end,
	OnAccumulateSign = function (slot0, slot1)
		if isSuccess(slot0.result) then
			BigMonthCardData:SignAccumulate(slot1.id)
			uv0.RefreshRedPoint()

			slot2 = slot1.id

			manager.notify:CallUpdateFunc(BIG_MONTH_CARD_ACCUMULATE_SIGN, slot0.rewards, slot0, table.indexof(BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardAccumulationCfg[slot2].template_id], slot2))
		else
			ShowTips(slot0.result)
		end
	end,
	BuyBigMonthCard = function ()
		manager.net:SendWithLoadingNew(34114, {}, 34115, uv0.OnBuyBigMonthCard)
	end,
	OnBuyBigMonthCard = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:Invoke(BUY_BIG_MONTH_CARD)
			ShowTips("TRANSACTION_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshRedPoint = function ()
		if BigMonthCardData:HaveMonthCard() and (not BigMonthCardData:IsSignToday() or BigMonthCardData:IsNeedAccumulatSign()) then
			manager.redPoint:setTip(RedPointConst.BIG_MONTH_CARD, 1)
		else
			manager.redPoint:setTip(RedPointConst.BIG_MONTH_CARD, 0)
		end
	end,
	FirstLoginSinceMonthCardFinish = function ()
		manager.net:SendWithLoadingNew(34116, {}, 34117, uv0.OnFirstLoginSinceMonthCardFinish)
	end,
	OnFirstLoginSinceMonthCardFinish = function (slot0, slot1)
		if isSuccess(slot0.result) then
			BigMonthCardData:SetIsExpireTip()
		else
			ShowTips(slot0.result)
		end
	end
}
