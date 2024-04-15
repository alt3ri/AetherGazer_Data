function slot1(slot0)
	slot1 = {
		pos = slot0.pos,
		extra_reward = slot0.extra_reward,
		entrustID = CanteenEntrustData:GetEntrustByPos(slot0.pos).id
	}
	slot2 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternAwardAdd, nil, slot0.pos)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.reward_list) do
		if slot0.extra_reward == 1 then
			-- Nothing
		end

		table.insert(slot3, {
			id = slot8.id,
			num = slot8.num,
			extraNum = slot8.num - math.ceil(slot8.num / ((100 + GameSetting.canteen_task_success.value[1]) / 100))
		})
	end

	slot1.rewardList = slot3

	return slot1
end

slot2 = nil

manager.net:Bind(58023, function (slot0)
	CanteenData:RefreshAutoAwardInfo(slot0)

	for slot4, slot5 in ipairs(slot0.fatigue_list) do
		if slot5 and DormData:GetHeroInfo(slot5.archives_id) then
			slot6:SetFatigue(slot5.fatigue)
		end
	end

	manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)

	for slot4, slot5 in ipairs(slot0.signature_dish) do
		if slot5 then
			CanteenFoodData:ReviseSignFoodInfo(slot5)
		end
	end

	for slot4, slot5 in ipairs(slot0.food) do
		if slot5 then
			CanteenFoodData:UpdataFoodProficiency(slot5)
		end
	end

	slot1 = nil

	for slot5, slot6 in ipairs(slot0.npc_change) do
		if slot6 then
			slot7 = BackHomeNpcData:GetNpcInfoById(slot6)

			slot7:SetJob(slot7.constJobType)

			slot1 = true
		end
	end

	if slot1 then
		CanteenHeroTools:RefreshCanteenJobList()
		manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
	end

	DormRedPointTools:UpdateCanteenNotify()
end)
manager.net:Bind(58027, function (slot0)
	for slot4, slot5 in ipairs(slot0.fatigue_list) do
		if DormData:GetHeroInfo(slot5.archives_id) then
			slot7:SetFatigue(slot5.fatigue)
		end

		for slot11, slot12 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
			if not CanteenHeroTools:HasJobAssignedToHero(slot12) then
				manager.notify:Invoke(CANTEEN_UPDATE_STATE)

				break
			end
		end
	end

	manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)
end)

return {
	SendTaskDispatchInfo = function (slot0, slot1)
		slot2 = {}

		if slot1.heroList == nil then
			slot2 = nil
		else
			for slot6, slot7 in ipairs(slot1.heroList) do
				table.insert(slot2, slot7)
			end
		end

		slot4 = nil

		if slot1.timeLevel then
			slot4 = BackHomeCanteenTaskCfg[CanteenEntrustData:GetEntrustByPos(slot1.pos).id].time[slot1.timeLevel][1]
		end

		manager.net:SendWithLoadingNew(58102, {
			architecture_id = slot1.sceneID,
			pos = slot1.pos,
			hero_list = slot2,
			duration = slot4
		}, 58103, uv0.OnSolveTaskDispatchCallBack)
	end,
	OnSolveTaskDispatchCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenEntrustData:ConfirmEntrustListCallBack(slot1)
		else
			ShowTips(slot0.result)
			CanteenEntrustData:ClearDispatchCharacterList()
		end
	end,
	SetCharacterJob = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58104, {
			architecture_id = DormConst.CANTEEN_ID,
			type = slot1,
			hero_id = slot2[1]
		}, 58105, uv0.OnSetCharacterJobCallBack)
	end,
	OnSetCharacterJobCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(CanteenHeroTools:GetCurWorkIDListByJobType(slot1.type)) do
				if DormNpcTools:CheckIDIsNpc(slot7) then
					BackHomeNpcData:GetNpcInfoById(slot7):SetJob(nil)
				else
					DormData:GetHeroInfo(slot7):BackToDorm()
				end
			end

			if slot1.hero_id > 0 then
				if DormNpcTools:CheckIDIsNpc(slot1.hero_id) then
					BackHomeNpcData:GetNpcInfoById(slot3):SetJob(slot1.type)
				else
					slot4 = DormData:GetHeroTemplateInfo(slot3)

					slot4:SetCurHeroID(slot3)
					slot4:SetJob(slot1.type)
					slot4:GoToCanteen()
				end
			elseif slot1.hero_id == 0 and not DormNpcTools:CheckIDIsNpc(slot2[1]) then
				BackHomeNpcData:GetNpcInfoById(DormNpcTools:GetNpcInfoListByConstJobType(slot1.type)[1]):SetJob(slot1.type)
			end

			CanteenHeroTools:RefreshCanteenJobList()

			if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
				manager.notify:Invoke(DORM_RESTAURANT_UPDATE_CHARACTER_BY_TYPE, DormEnum.RestaurantJobToClientMap[slot1.type])
			elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
				manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
			end

			manager.notify:Invoke(CANTEEN_SET_JOG_SUCCESS)
		else
			ShowTips(slot0.result)
		end
	end,
	ReceiveCanteenAutoAward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58106, {
			architecture_id = slot1
		}, 58107, uv0.OnCanteenAutoAwardCallBack)
	end,
	OnCanteenAutoAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenData:ReceiveCurPenEarSuccess(slot0.earnings, DormEnum.RestaurantMode.RestaurantAuto)
		else
			ShowTips(slot0.result)
		end
	end,
	ChangeCanteenMode = function (slot0, slot1, slot2, slot3)
		slot4 = nil
		uv0 = slot3

		if slot2 == DormEnum.RestaurantMode.RestaurantAuto then
			slot4 = 0
		elseif slot2 == DormEnum.RestaurantMode.RestaurantManual then
			slot4 = 1
		end

		if slot4 then
			manager.net:SendWithLoadingNew(58108, {
				architecture_id = slot1,
				cmd = slot4
			}, 58109, uv1.ChangeCanteenModeCallBack)
		end
	end,
	ChangeCanteenModeCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			if slot1.cmd == 0 then
				slot2 = DormEnum.RestaurantMode.RestaurantAuto
			elseif slot1.cmd == 1 then
				slot2 = DormEnum.RestaurantMode.RestaurantManual
			end

			CanteenData:ChangeCanteenStateSusscee(slot2, uv0)

			uv0 = nil
		else
			ShowTips(slot0.result)
		end
	end,
	RefreshEntrust = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58012, {
			architecture_id = slot1,
			pos = slot2
		}, 58013, uv0.RefreshEntrustCallBack)
	end,
	RefreshEntrustCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenEntrustData:InitEntrustData(slot0.entrust)
			manager.notify:Invoke(CANTEEN_REFRESH_ENTRUST_CALLBACK, slot0.entrust.pos)
		else
			ShowTips(slot0.result)
		end
	end,
	SendSignFoodInfo = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58114, {
			architecture_id = DormConst.CANTEEN_ID,
			food_id = slot1,
			sell_num = slot2
		}, 58115, uv0.SetSignFoodCallBack)
	end,
	SetSignFoodCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if slot1.sell_num > 0 then
				CanteenFoodData:PushFoodToSignList(slot1.food_id, slot1.sell_num)
			else
				CanteenFoodData:PushFoodToSignList(slot1.food_id)
			end

			manager.notify:Invoke(CANTEEN_SET_SIGNFOOD_SUCCESS)
		else
			ShowTips(slot0.result)
		end
	end,
	CanteenFurnitureUpgrade = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58116, {
			uid = slot1
		}, 58117, uv0.CanteenFurnitureUpgradeCallBack)
	end,
	CanteenFurnitureUpgradeCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenData:FurLevelUpCallBack(slot1.uid)
			DormSkillData:CalCanSignFoodNum()
			DormSkillData:CalInComeStorageMaxNum()
			DormRedPointTools:CheckUnLockFoodRedPoint()
			manager.notify:Invoke(CANTEEN_FUR_LEVEL_UP)
		else
			ShowTips(slot0.result)
		end
	end,
	ReceiveEntrustAward = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3, slot8)
		end

		manager.net:SendWithLoadingNew(58018, {
			architecture_id = slot1,
			pos = slot3
		}, 58019, uv0.ReceiveEntrustAwardCallBack)
	end,
	ReceiveEntrustAwardCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot6, slot7 in ipairs(slot0.extra_reward) do
				slot8 = CanteenEntrustData:GetEntrustByPos(slot7.pos).id

				table.insert({}, uv0(slot7))
			end

			for slot6, slot7 in ipairs(slot0.fatigue_list) do
				slot8 = DormData:GetHeroInfo(slot7.archives_id)

				slot8:SetFatigue(slot7.fatigue)
				slot8:BackToDorm()
			end

			manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)
			CanteenEntrustData:EntrustFinish(slot2, slot0.entrust)
		else
			ShowTips(slot0.result)
		end
	end,
	CanteenManualSettlement = function (slot0, slot1, slot2)
		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, {
				food_id = slot8.food_id,
				quality = slot8.quality,
				guest_uid = slot8.guest_uid,
				guest_id = slot8.guest_id,
				special_event = slot8.special_event,
				evaluate = slot8.evaluate
			})
		end

		manager.net:SendWithLoadingNew(58120, {
			architecture_id = slot1,
			oper_list = slot3
		}, 58121, uv0.CanteenManualSettlementCallBack)
	end,
	CanteenManualSettlementCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			CanteenFoodData:GetManualAward(slot1)
			manager.notify:Invoke(CANTEEN_MANUAL_REWARD_CALLBACK)
		else
			ShowTips(slot0.result)
		end
	end,
	UnLockEntrust = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58024, {
			pos = slot1
		}, 58025, uv0.UnLockEntrustCallBack)
	end,
	UnLockEntrustCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot0.entrust

			CanteenEntrustData:InitEntrustData(slot2)
			DormRedPointTools:CheckUnLockEntrustRedPoint()
			manager.notify:Invoke(CANTEEN_REFRESH_ENTRUST_CALLBACK, slot2.pos)
		else
			ShowTips(slot0.result)
		end
	end
}
