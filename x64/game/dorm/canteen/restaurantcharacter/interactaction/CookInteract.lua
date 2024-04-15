slot0 = import(".InteractUtil")
slot1 = slot0.waitAnime.handleEventWaitAnimation
slot2 = slot0.GetEntityType
slot3 = slot0.GetEntityBB
slot4 = slot0.NewTask
slot5 = slot0.NewTimer
slot6 = slot0.IsCanteenManualMode
slot7 = slot0.SnapToNearestInteractPoint
slot8 = slot0.RefreshFoodContainer
slot9 = slot0.PickFoodFromTable
slot10 = slot0.PutFoodOnTable
slot11 = slot0.commonAction.PickItemAction
slot12 = slot0.commonAction.PlaceCarryingItemAction

function slot13(slot0)
	return slot0 == DormEnum.ItemType.Pan or slot0 == DormEnum.ItemType.Oven or slot0 == DormEnum.ItemType.Pot or slot0 == DormEnum.ItemType.Steamer
end

slot14 = slot0.IsCustomer

function slot15(slot0)
	slot0:Notify(false)
end

function slot16(slot0)
	slot1 = slot0.entityID
	slot3 = slot0.finish
	slot4 = uv0(slot1)

	uv1(slot1, slot0.targetID, function (slot0)
		uv0(slot0, uv1)
		uv2(uv1)
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, uv1)

		if uv3.selectedOrder then
			uv3.selectedOrder.status = DormEnum.FoodState.HasCook
		end
	end):Then(function ()
		uv0.selectedOrder = nil

		uv1:Notify()
	end):Start()
end

function slot17(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish

	if slot0.entityData.isControlledByPlayer then
		JumpTools.OpenPageByJump("pickFoodView", {
			playerEID = slot1,
			onSelect = function ()
				uv0.target = uv1(uv0.target, uv2)
			end,
			onCanceled = function ()
				uv0(uv1)
			end
		})
	end

	uv2(slot1, slot2, function (slot0)
		uv0(uv1)
		manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, uv1)
	end):Then(function ()
		uv0:Notify()
	end):Start()
end

function slot18(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish
	slot4 = slot0.entityData
	slot5 = slot0.targetData
	slot8 = CanteenItemManager.GetInstance():GenerateFood(slot5.curCooking.cfgID, slot5.curCooking)

	if slot5.curCookingFoodOrder then
		slot9.foodEID = slot8
	end

	slot4.pick = slot8

	Dorm.DormEntityManager.AttachToEntityCMD(slot8, slot1, "gua_R_hand_bone")

	slot4.target = slot8
	slot4.selectedOrder = slot9
	slot5.curCookingFoodOrder = nil

	uv0(slot1, slot2):Then(function ()
		CanteenAIFunction:SetItemAvailable(uv0, true)

		uv1.curCooking = nil
		uv1.cookComplete = nil

		if uv2() then
			CanteenManualData:RecordCookFood(CanteenAIFunction:GetFoodManualIndex(uv3), uv3)
		end

		uv4:Notify()
	end):Start()
end

function slot19(slot0)
	slot2 = slot0.targetID
	slot3 = slot0.finish

	JumpTools.OpenPageByJump("/cookFoodView", {
		cookEid = slot2,
		playerEid = slot0.entityID
	})

	slot4 = slot0.targetData

	CanteenAIFunction:SetItemAvailable(slot2, false)
	uv0():WaitUntil(function ()
		return uv0.curCooking ~= nil
	end):Then(function ()
		if uv0.curCooking then
			uv1(uv2)
		else
			CanteenAIFunction:SetItemAvailable(uv3, true)

			uv0.curCooking = nil

			uv4:Notify()
		end
	end):Start()
end

slot20 = {
	[DormEnum.ItemType.Steamer] = "steamer",
	[DormEnum.ItemType.Oven] = "oven",
	[DormEnum.ItemType.Pot] = "stew",
	[DormEnum.ItemType.Pan] = "saucepan"
}

function slot21(slot0, slot1)
	if package.loaded["game.dorm.interacts.canteen.cook_" .. slot0 .. "_" .. slot1] then
		if type(slot3) == "table" then
			return slot3
		end
	elseif Dorm.InteractionGrouping[slot2] then
		return slot4[math.random(#slot4)]
	end
end

function slot22(slot0)
	slot1 = slot0.entityID
	slot3 = slot0.finish
	slot5 = slot0.targetData

	CanteenAIFunction:SetItemAvailable(slot0.targetID, false)
	(DormCharacterInteractBehaviour.MakeInteractTask(uv1(uv0[slot0.targetType], nullable(BackHomeHeroSkinCfg[slot0.entityData.cfgID], "style") or nullable(BackHomeNpcCfg[slot4.heroID], "style")), slot0) or uv2()):WaitUntil(function ()
		return uv0.curCooking ~= nil
	end):Then(function ()
		uv0.curCookingFoodOrder = uv1.selectedOrder
		uv1.selectedOrder = nil
		slot1 = uv2(function ()
			uv0.cookComplete = true
			uv0.curCookingTimer = nil

			CanteenAIFunction:SetItemAvailable(uv1, true)
		end, BackHomeCanteenFoodCfg[uv0.curCooking.cfgID].cook_time, false, false)
		uv0.curCookingTimer = slot1

		slot1:Start()
		uv4:Notify()
	end):Start()
end

function slot23(slot0, slot1)
	for slot7, slot8 in pairs(uv0(slot0).curOrder) do
		if slot8.status ~= DormEnum.FoodState.HasServer and uv0(slot1).cfgID == slot8.cfgID then
			slot8.status = DormEnum.FoodState.HasServer

			manager.notify:Invoke(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, slot0)

			return
		end
	end
end

function slot24(slot0)
	slot3 = slot0.entityData

	uv3(slot0.entityID, slot0.targetID, function (slot0)
		uv0(slot0, uv1)
		uv2(uv1)

		if uv3.selectedOrder then
			uv3.selectedOrder.status = DormEnum.FoodState.HasServer
		else
			uv4(uv1, slot0)
		end
	end):Then(function (slot0)
		uv0.selectedOrder = nil

		uv1.finish:Notify()
	end):Start()
end

function slot25(slot0)
	if slot0.entityData.pick then
		uv0(slot0)
	else
		uv1(slot0)
	end
end

function slot26(slot0)
	slot2 = slot0.targetID
	slot3 = slot0.finish

	uv0(slot0.entityID, slot2, Dorm.DormEntityManager.QueryForwardDir(slot2))

	if slot0.entityData.isControlledByPlayer then
		uv1(slot0)
	elseif slot0.targetData.cookComplete then
		uv2(slot0)
	else
		uv3(slot0)
	end
end

function slot27(slot0)
	slot1 = slot0.entityID
	slot2 = slot0.targetID
	slot3 = slot0.finish
	slot4 = slot0.entityData

	if slot0.targetData.sit and not slot5.eat then
		for slot12, slot13 in ipairs(uv0(slot5.tableEid).curOrder) do
			slot13.status = DormEnum.FoodState.Canceled
		end

		if slot8.foodList and slot8.foodList[1] then
			slot4.target = uv1(slot8.foodList[1], slot7)

			uv2(slot1, slot7)
			uv3(slot1, slot7, function ()
				uv0(uv1)
			end):Then(function ()
				uv0:Notify()
			end):Start()
		else
			slot3:Notify()
		end

		manager.notify:Invoke(DORM_RESTAURANT_INTERACT_CUSTOMER, slot2, slot1)
	end
end

return function (slot0)
	slot2 = slot0.finish

	if slot0.targetType == DormEnum.ItemType.PassTable then
		uv0(slot0)
	elseif uv1(slot1) then
		uv2(slot0)
	elseif slot1 == DormEnum.ItemType.DinningTable then
		uv3(slot0)
	elseif uv4(slot1) then
		uv5(slot0)
	else
		slot2:Notify(false)
		error("交互类型错误，错误类型为" .. slot1)
	end
end
