slot0 = singletonClass("CanteenManualData")
slot1, slot2 = nil

function slot0.EnterManualState(slot0)
	uv0 = {
		manualSerCusNum = 0,
		hightPopularityNum = 0,
		manualPopNum = 0,
		manualGenCusNum = 0,
		manualTotalIncome = 0,
		manualSettlementList = {}
	}
	uv1 = {}
end

function slot0.ExitManualState(slot0)
	uv0 = nil
	uv1 = nil
end

function slot0.GetManualPopNum(slot0)
	if uv0 then
		return uv0.manualPopNum
	end

	return 0
end

function slot0.CookFoodComplete(slot0, slot1, slot2, slot3, slot4, slot5)
	CanteenAIFunction:GetEntityData(slot3).curCooking = {
		cfgID = slot4,
		taste = slot5,
		quality = slot2
	}

	if not uv0 then
		uv0 = {}
	end

	if not uv0[slot4] then
		uv0[slot4] = 0
	end

	uv0[slot4] = uv0[slot4] + 1

	CanteenFoodData:RefreshCanOrderFoodList()
end

slot0.COOK_FOOD_CANCELED = false

function slot0.CookFoodCanceled(slot0, slot1, slot2)
	CanteenAIFunction:GetEntityData(slot2).curCooking = slot0.COOK_FOOD_CANCELED
end

function slot0.RecordCookFood(slot0, slot1, slot2)
	slot3 = CanteenAIFunction:GetEntityData(slot2)
	slot4 = slot3.cfgID
	slot5 = slot3.quality

	if uv0.manualSettlementList[slot1] == nil then
		uv0.manualSettlementList[slot1] = {}
	end

	uv0.manualSettlementList[slot1].food_id = slot4
	uv0.manualSettlementList[slot1].quality = slot5
	uv0.manualSettlementList[slot1].guest_uid = 0
	uv0.manualSettlementList[slot1].guest_id = 0
	uv0.manualSettlementList[slot1].special_event = 0
	uv0.manualSettlementList[slot1].evaluate = 0
end

function slot0.RecordFoodDelivery(slot0, slot1, slot2, slot3)
	if uv0.manualSettlementList[slot1] == nil then
		uv0.manualSettlementList[slot1] = {}
	end

	uv0.manualSettlementList[slot1].guest_uid = slot2
	uv0.manualSettlementList[slot1].guest_id = slot3
end

function slot0.RecordFoodQuality(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		uv0.manualSettlementList[CanteenAIFunction:GetFoodManualIndex(slot7)].evaluate = slot2
	end
end

function slot0.RecordManualGenCustomerNum(slot0, slot1)
	uv0.manualGenCusNum = uv0.manualGenCusNum + slot1
end

function slot0.RecordManualSerCustomerNum(slot0, slot1)
	uv0.manualSerCusNum = uv0.manualSerCusNum + slot1
end

function slot0.GetManualInfo(slot0)
	return uv0
end

function slot0.GetTotalIncome(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.manualSettlementList) do
		if not slot1[BackHomeCanteenFoodCfg[slot6.food_id].cook_type] then
			slot1[slot8] = 0
		end

		slot1[slot8] = slot1[slot8] + BackHomeCanteenFoodCfg[slot7].sell * GameSetting.canteen_customer_evaluation.value[slot6.quality][2] / 100
	end

	for slot6, slot7 in pairs(slot1) do
		slot2 = 0 + (DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostRise, nil, , slot6) + 100) / 100 * slot7
	end

	uv0.ManualTotalIncome = math.floor(slot2)

	return uv0.ManualTotalIncome
end

function slot0.ManualConsumeMaterial(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.manualSettlementList) do
		if slot6 then
			for slot12, slot13 in ipairs(BackHomeCanteenFoodCfg[slot6.food_id].ingredient_list) do
				slot1[slot13[1]] = slot1[slot13[1]] or 0
				slot1[slot13[1]] = slot1[slot13[1]] + slot13[2]
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			slot6,
			slot7
		})
	end

	return slot2
end

function slot0.CalculateRemainPopularity(slot0)
	return math.floor(uv0.manualPopNum * GameSetting.canteen_hot_hold.value[1] / 100)
end

function slot0.MostPopFoodIdAndNum(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0.manualSettlementList) do
		slot1[slot7] = slot1[slot6.food_id] or 0
		slot1[slot7] = slot1[slot7] + 1
	end

	slot2 = {
		num = -1,
		name = ""
	}
	slot4 = nil

	for slot8, slot9 in pairs(slot1) do
		if 0 < slot9 then
			slot4 = slot8
			slot3 = slot9
		end
	end

	if slot4 then
		slot2.name = BackHomeCanteenFoodCfg[slot4].name
		slot2.num = slot3

		return slot2
	end

	return slot2
end

function slot0.GetManualCookFoodInfo(slot0)
	return uv0
end

function slot0.AddPopularityNum(slot0, slot1)
	uv0.manualPopNum = uv0.manualPopNum + GameSetting.canteen_hot_increase.value[slot1][2]

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function slot0.GetManualAward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.oper_list) do
		CanteenFoodData:AddFoodProficiency(slot6.food_id, slot6.quality)
	end

	CanteenData:ReceiveCurPenEarSuccess(slot0:GetTotalIncome(), DormEnum.RestaurantMode.RestaurantManual)

	slot3 = CanteenData:GetPopularInfo()
	slot3.dynamicNum = slot3.dynamicNum + CanteenManualData:CalculateRemainPopularity()

	if slot3.dynamicNum < 0 then
		slot3.dynamicNum = 0
	end

	if uv0 then
		slot4 = CanteenFoodData:GetFoodToSignList()

		for slot8, slot9 in pairs(uv0) do
			slot4[slot8].soldNum = slot4[slot8].soldNum + slot9
			slot4[slot8].soldIncome = slot4[slot8].soldIncome + CanteenFoodData:GetFoodUnitCost(slot8) * slot9
		end
	end
end

return slot0
