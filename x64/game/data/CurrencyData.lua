slot0 = singletonClass("CurrencyData")
slot1 = 0
slot2 = 0
slot3 = 0
slot4 = false
slot5 = 0
slot6 = {}
slot7 = {}
slot8 = {}

function slot0.Init(slot0)
	uv0 = 0
	uv1 = 0
	uv2 = 0
	uv3 = false
	uv4 = 0
	uv5 = {}
	uv6 = {}
	uv7 = {}
	slot4 = ItemConst.ITEM_TYPE.CURRENCY

	for slot4, slot5 in ipairs(ItemCfg.get_id_list_by_type[slot4]) do
		uv5[slot5] = {
			num = 0,
			id = slot5
		}
	end

	manager.notify:Invoke(CURRENCY_UPDATE, 0)
end

function slot0.CurrencyBuyTimes(slot0, slot1, slot2)
	uv0 = slot1
	uv1 = slot2

	manager.notify:Invoke(CURRENCY_BUY_TIME_UPDATE, 0)
end

function slot0.InitExpiredCurrencyList(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.num > 0 then
			table.insert(uv0, {
				id = slot6.id,
				num = slot6.num,
				timeValid = slot6.time_valid
			})
		end
	end

	manager.notify:Invoke(MATERIAL_EXPIRED)
end

function slot0.CurrencyInit(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7.time_valid and slot7.time_valid ~= 0 then
			uv0[slot7.id] = uv0[slot7.id] or {}
			uv0[slot7.id][slot7.time_valid] = slot7.num
		else
			uv1[slot7.id] = {
				id = slot7.id,
				num = slot7.num
			}

			manager.notify:Invoke(CURRENCY_UPDATE, slot7.id)

			if slot7.id == CurrencyConst.CURRENCY_TYPE_VITALITY and slot7.num <= GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max - GameSetting.push_notification_fatigue_threshold.value[1] then
				slot0:SetFatigueCallFlag(1)
			end
		end
	end

	if slot2 ~= nil then
		uv2 = slot2
	end

	SDKTools.SetDefaultPublicAttribute()
end

function slot0.SetLastFatigueRecoverTime(slot0, slot1)
	uv0 = slot1
end

function slot0.SetCurrencyValue(slot0, slot1, slot2, slot3)
	if slot3 > 0 then
		uv0[slot1] = uv0[slot1] or {}
		uv0[slot1][slot3] = slot2
	else
		uv1[slot1].num = slot2
	end

	if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY and ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max < uv1[slot1].num then
		uv1[slot1].num = ItemCfg[CurrencyConst.CURRENCY_TYPE_VITALITY].max
	end

	if slot1 == CurrencyConst.GetOtherPlatformDiamondId() and AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].currency_merge == 1 then
		slot1 = CurrencyConst.GetPlatformDiamondId()
	end

	if slot1 == CurrencyConst.CURRENCY_TYPE_SHIFTING_EXP then
		PolyhedronAction.RefreshPolicyRedPoint()
	end

	manager.notify:Invoke(CURRENCY_UPDATE, slot1, slot3, slot2)

	if slot1 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or slot1 == CurrencyConst.GetPlatformDiamondId() then
		SDKTools.SetCurrencyPublicAttribute(CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE)
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		SDKTools.SetCurrencyPublicAttribute(slot1)
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		SDKTools.SetCurrencyPublicAttribute(slot1)
	elseif slot1 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
		SDKTools.SetCurrencyPublicAttribute(slot1)
	end
end

function slot0.GetTimeVaildCurrencyListBySubTypes(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0[slot1] or {}) do
		table.insert(slot2, {
			id = slot1,
			num = slot7,
			timeValid = slot6
		})
	end

	return slot2
end

function slot0.GetGoldBuyTimes(slot0)
	return uv0
end

function slot0.GetFatigueBuyTimes(slot0)
	return uv0
end

function slot0.GetLastFatigueRecoverTime(slot0)
	return uv0
end

function slot0.GetVitalityFull(slot0)
	return uv0
end

function slot0.VitalityFull(slot0, slot1)
	uv0 = slot1
end

function slot0.GetRechargeDiamond(slot0)
	if uv0 == nil then
		return 0
	end

	slot1 = uv0[CurrencyConst.GetPlatformDiamondId()].num
	slot2 = uv0[CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE].num
	slot3 = 0

	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].currency_merge == 1 or SDKTools.GetIsOverSea() == false then
		slot3 = uv0[CurrencyConst.GetOtherPlatformDiamondId()].num
	end

	return slot1 + slot2 + slot3
end

function slot0.GetCurrencyNum(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
		return slot0:GetRechargeDiamond()
	end

	if uv0[slot1] then
		for slot6, slot7 in pairs(uv0[slot1]) do
			slot2 = slot7 + 0
		end

		return slot2
	elseif uv1[slot1] == nil then
		uv1[slot1] = {
			num = 0,
			id = slot1
		}

		return 0
	end

	return uv1[slot1].num
end

function slot0.SetFatigueCallFlag(slot0, slot1)
	uv0 = slot1
end

function slot0.GetFatigueCallFlag(slot0)
	return uv0
end

function slot0.IsRechargeDiamond(slot0, slot1)
	return slot1 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id or slot1 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_IOS.item_id or slot1 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_NOT_IOS.item_id
end

function slot0.CheckExpiredCurrencyList(slot0)
	return uv0
end

function slot0.ClearExpiredCurrencyList(slot0)
	uv0 = {}
end

return slot0
