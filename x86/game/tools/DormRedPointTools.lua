slot1 = nil
slot2 = nil
slot3 = nil

return {
	UpdataGlobalRedPoint = function (slot0)
		slot0:UpdataDormGlobalRedPoint()
		slot0:UpdateCanteenNotify()
		slot0:UpdataSuitShopRedPoint()
	end,
	EnterDormitorySystem = function (slot0)
		slot0:InitSuitRedPointData()
		slot0:InitFurPlaceRedPointData()
		slot0:UpdataSuitShopRedPoint()
	end,
	ExitDormitorySystem = function (slot0)
		slot0:SaveSuitRedRedPointData()
		slot0:SaveSuitGoodRedPointData()
	end,
	UpdataDormGlobalRedPoint = function (slot0)
		slot0:UpdataDormRedPoint()
	end,
	FurnitureItemRedPoint = function (slot0, slot1)
		return string.format("%s_%s_%s", RedPointConst.DORM_SUIT_SHOP, tostring(slot0), tostring(slot1))
	end,
	UpdataDormRedPoint = function (slot0, slot1)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) or not DormitoryData:GetDormMapList() then
			return
		end

		if slot1 == false then
			manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT, 0)

			slot5 = {}

			for slot9, slot10 in pairs(DormData:GetHeroInfoList()) do
				if GameSetting.dorm_hero_set_level.value[1] <= DormData:GetHeroInfo(slot9):GetHeroFavorability() then
					table.insert(slot5, slot9)
				end
			end

			saveData("RedPoint", RedPointConst.DORM_PLACEMENT, slot5)

			return
		end

		slot4 = getData("RedPoint", RedPointConst.DORM_PLACEMENT)

		if not DormData:GetHeroInfoList() then
			return
		end

		slot6 = false

		for slot10, slot11 in pairs(slot5) do
			if not DormRoomTools:GetDormIDViaArchive(slot10) and GameSetting.dorm_hero_set_level.value[1] <= DormData:GetHeroInfo(slot10):GetHeroFavorability() then
				slot6 = true

				if slot4 then
					for slot17, slot18 in ipairs(slot4) do
						if slot10 == slot18 then
							slot6 = false

							break
						end
					end
				end
			end
		end

		slot7 = false

		for slot11, slot12 in pairs(slot2) do
			if BackHomeCfg[slot11].type == DormConst.BACKHOME_TYPE.PrivateDorm and (not slot12.archiveIDList or #slot12.archiveIDList == 0) then
				slot7 = true
			end
		end

		if slot6 and slot7 then
			manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT, 1)
		end
	end,
	InitFurPlaceRedPointData = function (slot0)
		uv0 = {}

		for slot4 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
			uv0[slot4] = {}

			if getData("RedPoint", string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot4))) then
				if tostring(slot6[1]) == "userdata: NULL" then
					for slot10, slot11 in pairs(slot6) do
						if tostring(slot11) ~= "userdata: NULL" then
							uv0[slot4][slot10] = slot11
						end
					end
				else
					for slot10, slot11 in ipairs(slot6) do
						if slot11[2] and tostring(slot11[2]) ~= "userdata: NULL" then
							uv0[slot4][slot11[1]] = slot11[2]
						end
					end
				end
			end
		end
	end,
	SaveFurPlaceRedPointData = function (slot0)
		if uv0 then
			for slot4, slot5 in pairs(uv0) do
				slot6 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot4))
				slot7 = {}

				for slot11, slot12 in pairs(slot5) do
					table.insert(slot7, {
						slot11,
						slot12
					})
				end

				saveData("RedPoint", slot6, slot7)
			end
		end
	end,
	UpdataDormFurRedPoint = function (slot0, slot1, slot2)
		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM or BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot2)), 0)

			return
		end

		slot3 = DormitoryData:GetDormMapList()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			return
		end

		slot5 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot2))

		if tostring((uv0[slot2] or {})[slot1]) == "userdata: NULL" then
			slot7 = {}
		end

		slot7 = slot7 or {}
		slot8 = DormFurnitureTools:GetRoomCanPlaceFurList(slot1)

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			for slot12, slot13 in ipairs(slot8) do
				if BackHomeFurniture[slot13].type == slot2 then
					slot14 = DormData:GetFurNumInfo(slot13).num
					slot15 = 0

					for slot19, slot20 in ipairs(slot7) do
						if slot20.furID == slot13 then
							slot15 = slot20.num
						end
					end

					if slot15 < slot14 then
						manager.redPoint:setTip(slot5, 1)

						return
					end
				end
			end
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			for slot12, slot13 in ipairs(slot8) do
				if BackHomeFurniture[slot13].type == slot2 then
					slot14 = slot3[slot1].give_furnitures[slot13] or 0
					slot15 = 0

					for slot19, slot20 in ipairs(slot7) do
						if slot20.furID == slot13 then
							slot15 = slot20.num
						end
					end

					if slot15 < slot14 then
						manager.redPoint:setTip(slot5, 1)

						return
					end
				end
			end
		end

		manager.redPoint:setTip(slot5, 0)
	end,
	CloseDormFurRedPoint = function (slot0, slot1, slot2, slot3)
		slot4 = DormitoryData:GetDormMapList()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			return
		end

		slot6 = string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot2))

		if tostring((uv0[slot2] or {})[slot1]) == "userdata: NULL" then
			slot8 = {}
		end

		slot8 = slot8 or {}

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			for slot12, slot13 in ipairs(slot3) do
				slot14 = slot13.furID
				slot15 = false

				for slot19, slot20 in ipairs(slot8) do
					if slot20.furID == slot14 then
						slot20.num = DormData:GetFurNumInfo(slot14).num
						slot15 = true

						break
					end
				end

				if not slot15 then
					table.insert(slot8, {
						furID = slot14,
						num = DormData:GetFurNumInfo(slot14).num
					})
				end
			end
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			for slot12, slot13 in pairs(slot4[slot1].give_furnitures) do
				slot14 = false

				for slot18, slot19 in ipairs(slot8) do
					if slot19.furID == slot12 then
						slot19.num = slot13
						slot14 = true

						break
					end
				end

				if not slot14 then
					table.insert(slot8, {
						furID = slot12,
						num = slot13
					})
				end
			end
		end

		if not uv0[slot2] then
			uv0[slot2] = {}
		end

		uv0[slot2][slot1] = slot8

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot2)), 0)
		slot0:SaveFurPlaceRedPointData()
	end,
	InitSuitRedPointData = function (slot0)
		uv0 = {}

		if tostring(getData("RedPoint", RedPointConst.DORM_SUIT) or {}) == "userdata: NULL" then
			slot2 = {}
		end

		for slot6, slot7 in ipairs(slot2) do
			uv0[slot7] = true
		end
	end,
	SaveSuitRedRedPointData = function (slot0)
		if uv0 then
			slot1 = {}

			for slot5, slot6 in pairs(uv0) do
				table.insert(slot1, slot5)
			end

			saveData("RedPoint", RedPointConst.DORM_SUIT, slot1)
		end
	end,
	UpdataSuitRedPoint = function (slot0)
		if BackHomeDataManager:GetCurSystem() ~= DormEnum.DormSystemType.Dormitory then
			return
		end

		if not uv0 then
			uv0 = {}
		end

		slot1 = false

		for slot6, slot7 in ipairs(DormSuitData:GetUnLockSuitList()) do
			if not uv0[slot7] then
				slot1 = true
				slot8, slot9 = DormSuitData:CheckIsConfigSuit(slot7)
				slot10 = nil

				if slot9 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
					if BackHomeSuitCfg[slot7].scene_id[1] == DormConst.BACKHOME_TYPE.PublicDorm then
						slot10 = RedPointConst.DORM_FULL_PUBLIC_SUIT
					elseif slot11 == DormConst.BACKHOME_TYPE.PrivateDorm then
						slot10 = RedPointConst.DORM_FULL_PRIVATE_SUIT
					end
				elseif slot9 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
					slot10 = RedPointConst.DORM_PART_SUIT
				end

				manager.redPoint:setTip(string.format("%s_%s", slot10, tostring(slot7)), slot1 and 1 or 0)
			end
		end
	end,
	ClickSuitIconRedPoint = function (slot0, slot1)
		if uv0[slot1] then
			return
		end

		slot2, slot3 = DormSuitData:CheckIsConfigSuit(slot1)
		slot4 = nil

		if slot3 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
			if BackHomeSuitCfg[slot1].scene_id[1] == DormConst.BACKHOME_TYPE.PublicDorm then
				slot4 = RedPointConst.DORM_FULL_PUBLIC_SUIT
			elseif slot5 == DormConst.BACKHOME_TYPE.PrivateDorm then
				slot4 = RedPointConst.DORM_FULL_PRIVATE_SUIT
			end
		elseif slot3 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
			slot4 = RedPointConst.DORM_PART_SUIT
		end

		manager.redPoint:setTip(string.format("%s_%s", slot4, tostring(slot1)), 0)

		uv0[slot1] = true

		slot0:SaveSuitRedRedPointData()
	end,
	UpdataSuitShopRedPoint = function (slot0)
		slot0:GetSuitShopCache()

		for slot5, slot6 in ipairs(DormTools:GetAllDormShopIDList()) do
			uv0:UpdataSingleDormShopRedPoint(slot6)
		end
	end,
	GetSuitShopCache = function (slot0)
		if not uv0 then
			uv0 = {}

			for slot6, slot7 in ipairs(getData("RedPoint", RedPointConst.DORM_SUIT_SHOP) or {}) do
				uv0[slot7.id] = {}

				for slot11, slot12 in ipairs(slot7.goodList) do
					uv0[slot7.id][slot12] = true
				end
			end
		end
	end,
	SaveSuitGoodRedPointData = function (slot0, slot1)
		slot2 = RedPointConst.DORM_SUIT_SHOP

		if uv0 then
			slot3 = {}

			for slot7, slot8 in pairs(uv0) do
				slot9 = {
					id = slot7
				}
				slot10 = {}

				for slot14, slot15 in pairs(slot8) do
					table.insert(slot10, slot14)
				end

				slot9.goodList = slot10

				table.insert(slot3, slot9)
			end

			saveData("RedPoint", slot2, slot3)
		end

		if not slot1 then
			uv0 = nil
		end
	end,
	UpdataSingleDormShopRedPoint = function (slot0, slot1)
		slot0:GetSuitShopCache()

		for slot7, slot8 in ipairs(DormSuitTools:GetFurSuitGoodListByShopID(slot1)) do
			if not (uv0[slot1] or {})[slot8] then
				manager.redPoint:setTip(uv1.FurnitureItemRedPoint(slot1, slot8), 1)
			end
		end
	end,
	CloseSingleSuitGoodRedPoint = function (slot0, slot1, slot2)
		slot0:GetSuitShopCache()

		if manager.redPoint:getTipBoolean(uv0.FurnitureItemRedPoint(slot1, slot2)) then
			slot4 = uv1[slot1] or {}

			manager.redPoint:setTip(slot3, 0)

			slot4[slot2] = true
			uv1[slot1] = slot4

			slot0:SaveSuitGoodRedPointData(true)
		end
	end,
	CloseAllSuitGoodRedPoint = function (slot0, slot1)
		slot0:GetSuitShopCache()

		if manager.redPoint:getTipBoolean(ShopTools.GetShopRedPointKey(slot1)) then
			slot4 = uv0[slot1] or {}

			for slot8, slot9 in ipairs(DormSuitTools:GetFurSuitGoodListByShopID(slot1)) do
				if manager.redPoint:getTipBoolean(uv1.FurnitureItemRedPoint(slot1, slot9)) then
					manager.redPoint:setTip(slot10, 0)

					slot4[slot9] = true
				end
			end

			uv0[slot1] = slot4

			slot0:SaveSuitGoodRedPointData(true)
		end
	end,
	RedPointType = {
		Session = 1,
		LocalMachine = 2,
		Normal = 0
	},
	SkipNotify = function (slot0, slot1)
		return RedPointData:GetSessionCacheRedPoint(slot1) == RedPointData.HasNotified or RedPointData:GetJsonCacheRedPoint(slot1) == RedPointData.HasNotified
	end,
	Notify = function (slot0, slot1, slot2)
		if ((slot2 == false or slot0:SkipNotify(slot1)) and 0 or 1) ~= manager.redPoint:getTipBoolean(slot1) then
			manager.redPoint:setTip(slot1, slot2)
		end
	end,
	ConsumeNotification = function (slot0, slot1, slot2)
		manager.redPoint:setTip(slot1, 0)

		if slot2 == uv0.RedPointType.Session and RedPointData:GetSessionCacheRedPoint(slot1) ~= 0 then
			RedPointData:SetSessionCacheRedPoint(slot1)
		elseif slot2 == uv0.RedPointType.LocalMachine and RedPointData:GetJsonCacheRedPoint(slot1) ~= 0 then
			RedPointData:SetJsonCacheRedPoint(slot1)
		end
	end,
	CheckCanteenOpen = function (slot0)
		slot1 = CanteenTools:CheckSignFoodNumCanOpen()
		slot2 = true

		for slot6, slot7 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
			if not CanteenHeroTools:HasJobAssignedToHero(slot7) then
				slot2 = false

				break
			end
		end

		return slot1 and slot2
	end,
	CheckUnLockEntrustRedPoint = function (slot0)
		if CanteenEntrustData:GetEntrustList() then
			for slot5, slot6 in pairs(slot1) do
				slot7 = false

				if slot6.id < 0 then
					slot9, slot10, slot11 = nil

					if GameSetting.dorm_canteen_task_unlock.value[slot5][2] ~= 0 then
						slot9, slot10, slot11 = IsConditionAchieved(slot8)
					else
						slot9 = true
					end

					slot7 = slot9
				end

				slot0:Notify(string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, slot5), slot7)
			end
		end
	end,
	CheckUnLockFoodRedPoint = function (slot0)
		for slot4, slot5 in ipairs(BackHomeCanteenFoodCfg.all) do
			slot6 = false

			if BackHomeCanteenFoodCfg[slot5].unlock > 0 and CanteenTools:CheckFoodUnLock(slot5) then
				slot6 = true
			end

			slot0:Notify(string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(BackHomeCanteenFoodCfg[slot5].cook_type), slot5), slot6)
		end
	end,
	CheckCanLevelUpFurRedPoint = function (slot0)
		for slot4, slot5 in pairs(DormEnum.FurnitureMainType) do
			slot0:Notify(string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(slot5)), CanteenTools:CheckAllFurCanLevelUp(slot5))
		end
	end,
	UpdateCanteenNotify = function (slot0)
		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			slot0:Notify(RedPointConst.CANTEEN_BUSINESS_STOPPED, not slot0:CheckCanteenOpen())
			slot0:Notify(RedPointConst.CANTEEN_DISPATCH_NONE, CanteenEntrustData.NoEntrustDispatched())
			slot0:Notify(RedPointConst.CANTEEN_DISPATCH_FINISHED, CanteenEntrustData.AnyEntrustFinished())
			slot0:Notify(RedPointConst.CANTEEN_JOB_AVAILABLE, CanteenTools:AnyJobAvailable())
			slot0:CheckUnLockEntrustRedPoint()
			slot0:CheckUnLockFoodRedPoint()
			slot0:CheckCanLevelUpFurRedPoint()
		end
	end
}
