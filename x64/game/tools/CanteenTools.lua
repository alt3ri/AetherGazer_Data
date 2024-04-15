return {
	GetFoodSprite = function (slot0)
		return getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[slot0].icon)
	end,
	GetCanteenSkillSprite = function (slot0)
		return getSpriteViaConfig("DormHeroSkill", BackHomeHeroSkillCfg[slot0].icon)
	end,
	CheckSignFoodNumCanOpen = function (slot0)
		if CanteenFoodData:GetCanOrderFoodList() then
			if #slot1 < DormConst.ORDER_FOOD_AUTO_NUM then
				return false
			else
				return true
			end
		end
	end,
	CheckCanteenJobCanOpen = function (slot0)
		for slot5, slot6 in pairs(CanteenHeroTools:GetCanteenJobList()) do
			if not slot6.heroID then
				return false
			end

			if not DormNpcTools:CheckIDIsNpc(slot6.heroID) then
				slot9 = GameSetting.dorm_canteen_work_fatigue.value[1] / 100

				if DormData:GetHeroFatigue(slot7) < slot9 - slot9 % 0.1 then
					return false
				end
			end
		end

		return true
	end,
	CheckFoodUnLock = function (slot0, slot1)
		if BackHomeCanteenFoodCfg[slot1].unlock ~= 0 then
			return BackHomeTools:CheckBackHomeConditionAccord(slot2)
		end

		return true
	end,
	GetFoodUnLockLevel = function (slot0, slot1)
		if BackHomeCanteenFoodCfg[slot1].unlock ~= 0 then
			return ConditionCfg[slot2].params[2]
		else
			return 0
		end
	end,
	CheckFurCanLevelUp = function (slot0, slot1)
		if not BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot1].type_id].condition[CanteenData:GetFurnitureLevel(slot1) + 1] then
			return false
		end

		for slot8, slot9 in ipairs(slot4) do
			if ConditionCfg[slot9] and not BackHomeTools:CheckBackHomeConditionAccord(slot9) then
				return false
			end
		end

		if not BackHomeCanteenFurnitureCfg[slot2].cost_material[slot3 + 1] then
			return true
		end

		for slot9, slot10 in ipairs(slot5) do
			if ItemTools.getItemNum(slot10[1]) < slot10[2] then
				return false
			end
		end

		return true
	end,
	CheckAllFurCanLevelUp = function (slot0, slot1)
		for slot6, slot7 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
			if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot7].type_id].type == slot1 and slot0:CheckFurCanLevelUp(slot7) then
				return true
			end
		end

		return false
	end,
	GetCookCfgName = function (slot0, slot1)
		if string.isNullOrEmpty(GetTips(CanteenConst.COOK_TYPE_NAME[slot1])) then
			print("未获取到厨具名字")
		end

		return slot3
	end,
	GetCookCfgNameByEid = function (slot0, slot1)
		if BackHomeCanteenFurnitureIDCfg[slot1] then
			if BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot1].type_id].name then
				return slot3
			else
				print("未找到家具名字")
			end
		end
	end,
	GetJobName = function (slot0, slot1)
		if slot1 == 1 then
			return GetTips("DORM_CANTEEN_COOK")
		elseif slot1 == 2 then
			return GetTips("DORM_CANTEEN_WAITER")
		elseif slot1 == 3 then
			return GetTips("DORM_CANTEEN_CASHIER")
		end
	end,
	GetFootTypeName = function (slot0, slot1)
		if type(DormEnum.FoodType[slot1]) == "string" then
			return slot2
		elseif type(slot2) == "number" then
			return GetTips(slot2)
		end
	end,
	GetFurEidByType = function (slot0, slot1)
		for slot5, slot6 in ipairs(BackHomeFurniture.all) do
			if BackHomeFurniture[slot6].type == slot1 then
				for slot10, slot11 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
					if BackHomeCanteenFurnitureIDCfg[slot11].type_id == slot6 then
						return slot11
					end
				end
			end
		end
	end,
	GetCanteenEIDByFurCfgID = function (slot0, slot1)
		for slot5, slot6 in ipairs(BackHomeCanteenFurnitureIDCfg.all) do
			if BackHomeCanteenFurnitureIDCfg[slot6].type_id == slot1 then
				return slot6
			end
		end
	end,
	AnyJobAvailable = function (slot0)
		for slot5, slot6 in pairs(CanteenHeroTools:GetCanteenJobList()) do
			if slot6.heroID == nil then
				return true
			end
		end

		return false
	end,
	AutoModeReadyForBusiness = function (slot0)
		return slot0:CheckSignFoodNumCanOpen() and slot0:CheckCanteenJobCanOpen()
	end,
	SwitchCanteenBgm = function (slot0, slot1)
		if slot1 == DormEnum.RestaurantMode.Start then
			slot2 = MusicReference[1]

			manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)

			slot3 = MusicReference[3]

			manager.audio:PlayBGM(slot3.cuesheet, slot3.cueName, slot3.awbName)
		elseif slot1 == DormEnum.RestaurantMode.RestaurantAuto or slot1 == DormEnum.RestaurantMode.Close then
			slot2 = MusicReference[3]

			manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)
		elseif slot1 == DormEnum.RestaurantMode.RestaurantManual then
			slot2 = MusicReference[2]

			manager.audio:PlayBGM(slot2.cuesheet, slot2.cueName, slot2.awbName)
		end
	end,
	GetIndexByTaskDuring = function (slot0, slot1, slot2)
		if BackHomeCanteenTaskCfg[slot1] then
			for slot7, slot8 in ipairs(slot3.time) do
				if slot2 == slot8[1] then
					return slot7
				end
			end
		end
	end,
	ShowTipsGetCookCfgName = function (slot0, slot1)
		if CanteenConst.COOK_TYPE_NAME[slot1] then
			return GetTips(slot2)
		else
			return ""
		end
	end
}
