slot0 = import("game.dorm.DormEnum")
slot1 = singletonClass("CanteenData")
slot2, slot3, slot4, slot5, slot6 = nil
slot7 = DormConst.CANTEEN_ID

function slot1.InitSimpleCanteenInfo(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.canteens) do
		uv0[slot6.id] = {
			totalEar = slot6.accruing_earnings or 0
		}
	end

	CanteenEntrustData:InitSimpleCanteenEntrustData(slot1)
	CanteenFoodData:InitSimpleCanteenFoodData(slot1)
	CanteenHeroTools:InitCanteenJobState(slot1.canteens[1].careers)
	uv1:InitFurnitureLevel(slot1.canteen_furnitures)
end

function slot1.InitDetailCanteenData(slot0, slot1)
	uv0:InitCanteenMapData(slot1)
	CanteenEntrustData:InitDetailCanteenEntrustData(slot1)
	CanteenFoodData:InitDetailCanteenFoodData(slot1)
	CanteenHeroTools:InitCanteenJobState(slot1.canteens[1].careers)
	uv0:InitPopularity(uv1[uv2])
end

function slot1.EnterCurSystem(slot0)
	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Canteen, false)
end

function slot1.ExitCurSystem(slot0)
	uv0 = nil

	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Canteen, true)
end

function slot1.ExitBackHomeSystem(slot0)
	uv0 = nil

	CanteenFoodData:DisposeDetailData()
	CanteenEntrustData:DisposeDetailData()
end

function slot1.InitCanteenMapData(slot0, slot1)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = nil

	for slot5, slot6 in ipairs(slot1.canteens) do
		slot7 = slot6.id
		uv1[slot7] = {
			totalEar = slot6.accruing_earnings or 0,
			earnings = slot6.business.earnings or 0,
			last_earnings_update_time = slot6.business.last_earnings_update_time or manager.time:GetServerTime(),
			last_receive_earnings_time = slot6.business.last_receive_earnings_time or manager.time:GetServerTime()
		}
		uv0[slot6.id] = {
			roomInfo = RoomInfo.New()
		}
		uv0[slot6.id].roomInfo.id = slot6.id
		uv0[slot6.id].roomInfo.sceneName = BackHomeCfg[slot6.id].scene
		uv0[slot6.id].roomInfo.furnitureInfoS = {}
		uv2[slot7] = {
			Popularity = {
				dynamicNum = slot6.attractive.dynamic or 0,
				updataTime = slot6.attractive.dynamic_update_time
			}
		}
	end
end

function slot1.GetCanteenSceneData(slot0)
	if uv0[uv1] then
		return uv0[uv1]
	end
end

function slot1.GetCurEarning(slot0)
	return uv0[uv1].totalEar
end

function slot1.InitFurnitureLevel(slot0, slot1)
	uv0 = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			uv0[slot6.uid] = {
				level = slot6.level or 1,
				cfgID = BackHomeCanteenFurnitureIDCfg[slot6.uid].type_id,
				stringEid = BackHomeCanteenFurnitureIDCfg[slot6.uid].type_id,
				unLock = BackHomeCanteenFurnitureIDCfg[slot6.uid].unLock
			}
		end
	end
end

function slot1.GetFurnitureLevel(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].level
	else
		return 0
	end
end

function slot1.FurLevelUpCallBack(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			level = 0
		}
	end

	if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot1].type_id].skill[uv0[slot1].level] then
		for slot7, slot8 in ipairs(slot3) do
			if DormSkillData:CheckSkillIsRun(slot1, slot8, uv1.EntityType.Furniture) then
				DormSkillData:DisposeSkillComponent(slot1, slot8, uv1.EntityType.Furniture)
			end
		end
	end

	uv0[slot1].level = uv0[slot1].level + 1

	if BackHomeCanteenFurnitureCfg[slot2].skill[uv0[slot1].level] then
		for slot8, slot9 in ipairs(slot4) do
			if DormSkillData:CheckSkillIsOpen(slot1, slot9, uv1.EntityType.Furniture) then
				DormSkillData:AddSkillComponent(slot1, slot9, uv1.EntityType.Furniture)
			end
		end
	end
end

function slot1.GetFurInfoList(slot0)
	if uv0 then
		return uv0
	else
		print("家具信息不存在")
	end
end

function slot1.GetCanteenState(slot0)
	return uv0
end

function slot1.SetCanteenState(slot0, slot1)
	if slot1 == uv0 then
		return
	end

	CanteenAction:ChangeCanteenMode(uv1, slot1)
end

function slot1.ChangeCanteenStateSusscee(slot0, slot1, slot2)
	uv0 = slot1

	if slot1 == uv1.RestaurantMode.RestaurantManual then
		manager.notify:Invoke(DORM_RESTAURANT_START_MANUAL)
		JumpTools.OpenPageByJump("dormPlayerControlView")
		CanteenTools:SwitchCanteenBgm(uv1.RestaurantMode.RestaurantManual)
		DormLuaBridge.ChangeRoomState(true)
		CanteenManualData:EnterManualState()
		manager.notify:Invoke(DORM_REFRESH_RESTAURANT_STATUS_EVENT, uv0)
	else
		if slot2 then
			CanteenManualData:ExitManualState()
		else
			CanteenAction:CanteenManualSettlement(uv2, CanteenManualData:GetManualInfo().manualSettlementList)
		end

		slot0:ChooseCanteenAutoState()
		CharacterBubbleManager:Dispose()
		DormLuaBridge.ChangeRoomState(false)
		CanteenTools:SwitchCanteenBgm(uv1.RestaurantMode.RestaurantAuto)
	end
end

function slot1.ChooseCanteenAutoState(slot0)
	if uv0 == uv1.RestaurantMode.RestaurantManual then
		return
	end

	slot1 = nil

	if ((not CanteenTools:AutoModeReadyForBusiness() or uv1.RestaurantMode.RestaurantAuto) and uv1.RestaurantMode.Close) ~= uv0 then
		manager.notify:Invoke(DORM_RESTAURANT_START_AUTO)
	end

	uv0 = slot1

	manager.notify:Invoke(DORM_REFRESH_RESTAURANT_STATUS_EVENT, uv0)
end

function slot1.InitPopularity(slot0, slot1)
	slot2 = 0
	slot3 = GameSetting.canteen_hot_reduce.value[1]

	if slot1.Popularity.updataTime == 0 or not slot1.Popularity.updataTime then
		slot1.Popularity.updataTime = manager.time:GetServerTime()
	end

	slot4 = manager.time:GetServerTime() - slot1.Popularity.updataTime
	slot6 = slot4 % GameSetting.canteen_hot_reduce.value[2]
	slot1.Popularity.updataTime = slot1.Popularity.updataTime + math.modf(slot4 / GameSetting.canteen_hot_reduce.value[2]) * slot3

	if slot1.Popularity.dynamicNum > 0 then
		slot2 = math.max(0, slot1.Popularity.dynamicNum - slot5 * slot3)
	end

	slot1.buffList = {}
	slot1.hightPopularityNum = 0
	slot1.dynamicNum = slot2
	slot1.basePopualrityNum = 0
	slot1.remainTime = slot6
	slot1.manualNum = 0

	if slot0.startHotTimer == nil then
		slot0.startHotTimer = Timer.New(function ()
			uv0:UpdataDynmicPopularity()

			uv0.updataHotTimer = Timer.New(handler(uv0, uv0.UpdataDynmicPopularity), GameSetting.canteen_hot_reduce.value[2], -1)

			uv0.updataHotTimer:Start()
		end, uv0[uv1].remainTime, 1)
	end

	slot0.startHotTimer:Start()
end

function slot1.GetPopularInfo(slot0)
	return uv0[uv1]
end

function slot1.GetPopularityNum(slot0)
	if not uv0 then
		return DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.PopularRise) or 0
	else
		uv0[uv1].basePopualrityNum = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.PopularRise)

		return math.max(uv0[uv1].dynamicNum + uv0[uv1].basePopualrityNum + CanteenManualData:GetManualPopNum(), 0)
	end
end

function slot1.UpdataDynmicPopularity(slot0)
	uv0[uv1].dynamicNum = math.max(uv0[uv1].dynamicNum - GameSetting.canteen_hot_reduce.value[1], 0)
	uv0[uv1].Popularity.updataTime = manager.time:GetServerTime()

	manager.notify:Invoke(DORM_REFRESH_POPULAR_EVENT)
end

function slot1.RefreshAutoAwardInfo(slot0, slot1)
	if not uv0 then
		uv0 = {
			[uv1] = {}
		}
	end

	uv0[uv1].earnings = slot1.earnings
	uv0[uv1].last_earnings_update_time = slot1.last_earnings_update_time
end

function slot1.GetAutoAwardNum(slot0)
	if uv0[uv1].earnings then
		return uv0[uv1].earnings
	else
		return 0
	end
end

function slot1.ReceiveCurPenEarSuccess(slot0, slot1, slot2)
	uv0[uv1].totalEar = uv0[uv1].totalEar + slot1

	if slot2 == uv2.RestaurantMode.RestaurantAuto then
		uv0[uv1].earnings = 0
		uv0[uv1].last_receive_earnings_time = manager.time:GetServerTime()
	end
end

function slot1.GetAutoNextAwardTime(slot0)
	slot3 = nil

	if (uv0[uv1].last_receive_earnings_time and slot2 + GameSetting.canteen_receive_time_interval.value[1] or manager.time:GetServerTime()) - manager.time:GetServerTime() > 0 then
		slot5 = math.modf(slot4 / 3600)

		return slot5, math.floor((slot4 - slot5 * 3600) / 60), (slot4 - slot5 * 3600) % 60
	else
		return -1, -1, -1
	end
end

function slot1.RefreshCanteenDailyZero(slot0)
	CanteenEntrustData:RefreshDailyZero()
end

return slot1
