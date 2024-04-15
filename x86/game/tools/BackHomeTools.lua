return {
	GotoBackHomeRoom = function (slot0, slot1, slot2)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			ShowTips(JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.DORM, slot3))

			return nil
		end

		slot4 = nil

		BackHomeDataManager:EnterBackHomeSystem((not slot2 or function (slot0)
			BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.TRAIN)
		end) and function (slot0)
			BackHomeDataManager:GotoBackHomeScene(uv0)
		end)
	end,
	BackHomeGotoMain = function (slot0)
		BackHomeDataManager:ExitBackHomeSystem()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/home")
	end,
	OtherSystemVisitExit = function (slot0)
		BackHomeDataManager:OtherSystemVisitBack()
		LuaExchangeHelper.GoToMain()
	end,
	CheckBackHomeConditionAccord = function (slot0, slot1, slot2)
		if ConditionCfg[slot1] == nil then
			return true, 0, 0
		end

		slot4 = 0

		if slot3 then
			if slot3.type == CanteenConst.UnLockCon.CookLevel then
				return slot3.params[2] <= CanteenData:GetFurnitureLevel(slot3.params[1]), slot4, slot3.params[2]
			elseif slot5 == CanteenConst.UnLockCon.TotleIncome then
				return slot3.params[1] <= CanteenData:GetCurEarning(), slot4, slot3.params[1]
			elseif slot5 == CanteenConst.UnLockCon.FoodProficiency then
				return slot3.params[2] <= CanteenFoodData:GetFoodProficiency(slot3.params[1]), slot4, slot3.params[2]
			elseif slot5 == CanteenConst.UnLockCon.FoodComplateNum then
				return slot3.params[2] <= CanteenFoodData:GetFoodCookNum(slot3.params[1]), slot4, slot3.params[2]
			elseif slot5 == CanteenConst.UnLockCon.FoodTypeComplateNum then
				return slot3.params[2] <= CanteenFoodData:GetFoodTypeCookNum(slot3.params[1]), slot4, slot3.params[2]
			elseif slot5 == CanteenConst.UnLockCon.RoomunLockNum then
				return slot3.params[1] <= DormRoomTools:GetUnlockRoomNum(), slot4, slot3.params[1]
			end
		else
			print("不存在该解锁条件")
		end
	end,
	GetBackHomeConditionDes = function (slot0, slot1)
		if ConditionCfg[slot1] then
			if slot2.type == CanteenConst.UnLockCon.CookLevel then
				return string.format(GetI18NText(slot2.desc), CanteenTools:GetCookCfgNameByEid(slot2.params[1]), slot2.params[2])
			elseif slot4 == CanteenConst.UnLockCon.TotleIncome then
				return string.format(slot3, CanteenData:GetCurEarning())
			elseif slot4 == CanteenConst.UnLockCon.FoodProficiency then
				slot5 = slot2.params[1]

				return string.format(slot3, BackHomeCanteenFoodCfg[slot5].name, CanteenFoodData:GetFoodProficiency(slot5))
			elseif slot4 == CanteenConst.UnLockCon.FoodComplateNum then
				slot5 = slot2.params[1]

				return string.format(slot3, BackHomeCanteenFoodCfg[slot5].name, CanteenFoodData:GetFoodCookNum(slot5))
			elseif slot4 == CanteenConst.UnLockCon.FoodTypeComplateNum then
				slot5 = slot2.params[1]

				return string.format(slot3, CanteenTools:ShowTipsGetCookCfgName(slot5), CanteenFoodData:GetFoodTypeCookNum(slot5))
			elseif slot4 == CanteenConst.UnLockCon.RoomunLockNum then
				return slot3
			end
		else
			print("不存在该解锁条件")
		end
	end
}
