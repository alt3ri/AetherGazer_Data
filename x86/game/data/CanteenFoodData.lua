slot0 = singletonClass("CanteenFoodData")
slot1, slot2, slot3, slot4 = nil

function slot0.InitSimpleCanteenFoodData(slot0, slot1)
	uv0:InitSignFoodList(slot1.canteens[1])
	uv0:InitCanteenIngredient(slot1.ingredients)
end

function slot0.InitDetailCanteenFoodData(slot0, slot1)
	uv0:InitSignFoodList(slot1.canteens[1])
	uv0:InitCanteenIngredient(slot1.ingredients)
	uv0:InitFoodProficiency(slot1.food)
end

function slot0.InitFoodProficiency(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.id] = slot0:InitFoodProficiencyData(slot6)
	end

	for slot5, slot6 in ipairs(BackHomeCanteenFoodCfg.all) do
		if not uv0[slot6] then
			uv0[slot6] = slot0:InitFoodProficiencyData({
				id = slot6
			})
		end
	end
end

function slot0.InitSignFoodList(slot0, slot1)
	uv0 = CanteenConst.CanteenMapID
	uv1 = {
		[slot1.id] = {}
	}

	for slot6, slot7 in ipairs(slot1.signature_dish) do
		uv1[slot2][slot7.food_id] = {
			sellNum = slot7.sell_num,
			soldNum = slot7.sold_num,
			soldIncome = slot7.sell_earnings
		}
	end

	slot0:RefreshCanOrderFoodList()
end

function slot0.GetFoodToSignList(slot0)
	return uv0
end

function slot0.GetChooseFoodList(slot0)
	slot1 = {}

	if uv0[uv1] then
		for slot5, slot6 in pairs(uv0[uv1]) do
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

function slot0.GetSignFoodInfo(slot0, slot1)
	if uv0[uv1][slot1] then
		return uv0[uv1][slot1]
	end

	print("未找到对应招牌菜信息")
end

function slot0.CheckIsSignFood(slot0, slot1)
	for slot5, slot6 in pairs(uv0[uv1]) do
		if slot1 == slot5 then
			return true
		end
	end

	return false
end

function slot0.PushFoodToSignList(slot0, slot1, slot2)
	if uv0[uv1] then
		if slot2 then
			uv0[uv1][slot1] = {}
			uv0[uv1][slot1] = {
				soldIncome = 0,
				soldNum = 0,
				sellNum = slot2
			}
		elseif uv0[uv1][slot1] then
			uv0[uv1][slot1] = nil
		end
	end

	slot0:RefreshCanOrderFoodList()
end

slot5 = nil

function slot0.GetCanOrderFoodList(slot0)
	return uv0
end

function slot0.CalculateFoodCanCookNum(slot0, slot1)
	slot3 = 0

	if not CanteenFoodData:CheckIsSignFood(slot1) and BackHomeCanteenFoodCfg[slot1].ingredient_list then
		slot5 = 100000

		for slot9, slot10 in pairs(slot4) do
			if uv0 then
				if (slot0:GetCateenIngredientNum(slot10[1]) or 0) < slot10[2] then
					return 0
				else
					slot5 = math.min(math.modf(slot13 / slot12), slot5)
				end
			end
		end

		if slot5 ~= 10000 then
			slot3 = slot5
		end
	end

	if slot3 >= 0 then
		return slot3
	else
		print("可制作数量错误")

		return 0
	end
end

function slot0.GetSignFoodTime(slot0, slot1)
	return slot0:CalSignFoodTime(slot1, uv0[uv1][slot1].sellNum - uv0[uv1][slot1].soldNum)
end

function slot0.CalSignFoodTime(slot0, slot1, slot2)
	return math.ceil(BackHomeCanteenFoodCfg[slot1].cost_time * slot2 * (100 - DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostQucik, nil, , BackHomeCanteenFoodCfg[slot1].cook_type)) / 100)
end

function slot0.GetSignFoodCanCookNum(slot0, slot1)
	slot3 = 0

	if CanteenManualData:GetManualCookFoodInfo() then
		slot3 = slot2[slot1] or 0
	end

	if uv0[uv1][slot1].sellNum - uv0[uv1][slot1].soldNum - slot3 < 0 then
		print("计算数量错误")

		slot5 = 0
	end

	return slot5
end

function slot0.RefreshCanOrderFoodList(slot0)
	slot1 = CanteenManualData:GetManualCookFoodInfo()
	uv0 = {}

	if slot0:GetChooseFoodList() then
		for slot6, slot7 in pairs(slot2) do
			slot8 = slot0:GetSignFoodInfo(slot7)
			slot9 = 0

			if slot8.sellNum - slot8.soldNum - (not slot1 and 0 or slot1[slot7] or 0) > 0 then
				table.insert(uv0, slot7)
			end
		end
	end

	manager.notify:Invoke(CANTEEN_SIGN_FOOD_NUM_CHANGE)
	uv1:OnIngredientChange()
end

function slot0.GetCateenIngredient(slot0)
	if uv0 then
		return uv0
	end
end

function slot0.GetHadIngredientNum(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.AddFoodIngredients(slot0, slot1, slot2)
	if slot1 then
		if not uv0 then
			uv0 = {}
		end

		if not uv0[slot1] then
			uv0[slot1] = 0
		end

		if slot2 then
			uv0[slot1] = slot2
		end

		if uv0[slot1] < 0 then
			uv0[slot1] = 0

			print("食材减少数量不正确")
		end
	end
end

function slot0.GetCateenIngredientNum(slot0, slot1)
	slot2 = 0

	if uv0[slot1] then
		slot2 = uv0[slot1]

		for slot6, slot7 in pairs(uv1[uv2]) do
			for slot12, slot13 in ipairs(BackHomeCanteenFoodCfg[slot6].ingredient_list) do
				if slot13[1] == slot1 then
					slot2 = slot2 - (slot7.sellNum - slot7.soldNum) * slot13[2]
				end
			end
		end
	end

	if slot2 < 0 then
		slot2 = 0
	end

	return slot2
end

function slot0.UpdataFoodProficiency(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	uv0[slot1.id] = slot0:InitFoodProficiencyData(slot1)
end

function slot0.GetFoodProficiency(slot0, slot1)
	return uv0[slot1].proficiency
end

function slot0.GetFoodCookNum(slot0, slot1)
	return uv0[slot1].hasCookNum
end

function slot0.InitFoodProficiencyData(slot0, slot1)
	return {
		foodCfgID = slot1.id,
		proficiency = slot1.proficiency or 0,
		hasCookNum = slot1.num or 0,
		foodType = BackHomeCanteenFoodCfg[slot1.id].cook_type
	}
end

function slot0.GetFoodTypeCookNum(slot0, slot1)
	slot2 = 0

	if uv0 then
		for slot6, slot7 in pairs(uv0) do
			if BackHomeCanteenFoodCfg[slot6].cook_type == slot1 then
				slot2 = slot2 + slot7.hasCookNum
			end
		end
	end

	return slot2
end

function slot0.AddFoodProficiency(slot0, slot1, slot2)
	slot4 = 0

	for slot8, slot9 in ipairs(GameSetting.canteen_cook_mastery.value) do
		if slot9[1] == slot2 then
			slot4 = slot9[2]

			break
		end
	end

	uv0[slot1].proficiency = math.min(uv0[slot1].proficiency + slot4, GameSetting.canteen_cook_mastery_max.value[1])
end

function slot0.GetFoodUnitCost(slot0, slot1)
	return math.floor(BackHomeCanteenFoodCfg[slot1].sell * (100 + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostRise, nil, , BackHomeCanteenFoodCfg[slot1].cook_type)) / 100)
end

function slot0.ReviseSignFoodInfo(slot0, slot1)
	if not uv0 then
		uv0 = {
			[uv1] = {}
		}
	end

	if uv0[uv1][slot1.food_id] then
		uv0[uv1][slot1.food_id] = {}
	end

	uv0[uv1][slot1.food_id].sellNum = slot1.sell_num
	uv0[uv1][slot1.food_id].soldNum = slot1.sold_num
	uv0[uv1][slot1.food_id].soldIncome = slot1.sell_earnings

	if slot1.sell_num == slot1.sold_num then
		slot0:RefreshCanOrderFoodList()
		manager.notify:Invoke(CANTEEN_UPDATE_STATE)
	end

	manager.notify:Invoke(CANTEEN_SIGN_FOOD_INFO_CHANGE)
end

function slot0.InitCanteenIngredient(slot0, slot1)
	uv0 = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			uv0[slot6.id] = slot6.num
		end
	end
end

function slot0.OnIngredientChange(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		DormRedPointTools:Notify(RedPointConst.CANTEEN_BUSINESS_STOPPED, #slot0:GetCanOrderFoodList() < DormConst.ORDER_FOOD_NUM)
	end
end

function slot0.DisposeDetailData(slot0)
	uv0 = nil
end

return slot0
