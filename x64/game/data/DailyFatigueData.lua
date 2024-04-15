slot0 = singletonClass("DailyFatigueData")
slot1 = ActivityConst.DAILY_FATIGUE_STATUS

function slot0.InitData(slot0, slot1)
	slot0.data = {}
	slot0.loginPopFlag = true

	if not slot1.daily_fatigue_dessert_list then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		slot0:SetData(slot7.type, slot7.is_got)
	end
end

function slot0.Clear(slot0)
	slot0.data = nil
end

function slot0.SetData(slot0, slot1, slot2)
	if not slot0.data then
		slot0.data = {}
	end

	slot0.data[slot1] = slot2
end

function slot0.GetStatus(slot0, slot1)
	if slot0.data and slot0.data[slot1] then
		return uv0.CLAIMED
	end

	slot2 = manager.time
	slot3 = slot2:GetServerTime()
	slot4 = slot2:GetLastZeroTime()

	if slot2:GetDeltaToday() < slot2:GetToday() or math.abs(slot5 - slot6) > 1 then
		return uv0.AVAILABLE
	elseif slot3 > slot4 + slot1 * 3600 then
		return uv0.AVAILABLE
	end

	return uv0.NOT_AVAILABLE
end

function slot0.IsFatigueFull(slot0)
	return ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= 999
end

function slot0.LoginPopFlag(slot0, slot1)
	if slot1 ~= nil then
		slot0.loginPopFlag = slot1
	else
		return slot0.loginPopFlag
	end
end

function slot0.GetRedCount(slot0)
	for slot5, slot6 in ipairs(GameSetting.daily_free_physical_strength.value) do
		if slot0:GetStatus(slot6[1]) == uv0.AVAILABLE then
			return 1
		end
	end

	return 0
end

return slot0
