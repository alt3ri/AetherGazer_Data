slot1 = false

manager.net:Bind(68101, function (slot0)
	slot1 = slot0.activity_id

	if not uv0.inited then
		uv0.InitConst(slot1)
		uv0.InitRedPoint()

		uv0.inited = true
	end

	SailGameData:InitData(slot0)
	uv0.UpdateSailCountRedPoint(slot1)
	uv0.UpdatetTaskRedPoint(slot1)
	uv0.UpdateBuildingAFKRewardRedPoint(slot1)
	uv0.UpdateBuildingSetRedPoint(slot1)
	uv0.UpdateIslandUpgradeRedPoint(slot1)
end)
manager.net:Bind(68121, function (slot0)
	slot1 = slot0.activity_id

	SailGameData:UpdateBuilding(slot1, slot0.buildings)
	uv0.UpdatetTaskRedPoint(slot1)
	uv0.UpdateBuildingAFKRewardRedPoint(slot1)
	uv0.UpdateBuildingSetRedPoint(slot1)
	uv0.UpdateIslandUpgradeRedPoint(slot1)
end)
manager.net:Bind(68125, function (slot0)
	slot1 = slot0.activity_id

	SailGameData:UpdateCompleteSailTimes(slot1, slot0.complete_sailing_time)
	SailGameData:UpdateSailInfo(slot1, slot0.sailing_info)
	uv0.UpdateSailCountRedPoint(slot1)
	uv0.UpdateIslandUpgradeRedPoint(slot1)
end)
manager.net:Bind(68123, function (slot0)
	SailGameData:UpdateEventInfo(slot0.activity_id, slot0.sailing_info)
end)

return {
	InitConst = function (slot0)
		SailGameConst.STAGE_TIME = SailGameConst.STAGE_TIME or {}
		SailGameConst.STAGE_TIME[slot0] = {}

		for slot5, slot6 in ipairs(GameSetting.activity_skadi_sea_event_time.value) do
			SailGameConst.STAGE_TIME[slot0][slot6] = slot5
		end

		SailGameConst.STAGE_TIME[slot0][GameSetting.activity_skadi_sea_total_time.value[1]] = #slot1 + 1
	end,
	UpgradeIsland = function (slot0)
		manager.net:SendWithLoadingNew(68106, {
			oper_type = 1,
			activity_id = slot0
		}, 68107, function (slot0)
			if isSuccess(slot0.result) then
				SailGameData:UpgradeIsland(uv0)
				uv1.UpdateBuildingSetRedPoint(uv0)
				uv1.UpdateIslandUpgradeRedPoint(uv0)
				uv1.UpdatetTaskRedPoint(uv0)
				manager.notify:CallUpdateFunc(SAIL_ISLAND_UPGRADE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	UnlockBuilding = function (slot0, slot1)
		manager.net:SendWithLoadingNew(68106, {
			oper_type = 2,
			activity_id = slot0,
			building_id = slot1
		}, 68107, function (slot0)
			if isSuccess(slot0.result) then
				SailGameData:UnLockBuilding(uv0, uv1)
				uv2.UpdateBuildingSetRedPoint(uv0)
				uv2.UpdateIslandUpgradeRedPoint(uv0)
				uv2.UpdatetTaskRedPoint(uv0)
				manager.notify:CallUpdateFunc(SAIL_BUILDING_UNLOCK)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReceiveTask = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(68108, {
			activity_id = slot0,
			award_id = slot1,
			award_type = slot2
		}, 68109, function (slot0)
			if isSuccess(slot0.result) then
				SailGameData:ReceiveTask(uv0, uv1, uv2)
				uv3.UpdatetTaskRedPoint(uv0)
				getReward2(slot0.reward_list)
				manager.notify:CallUpdateFunc(SAIL_TASK_RECEIVE)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ReceiveBuildingReward = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot8, slot9 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[slot0]) do
			if SailGameTools.GetBuildingTotalReward(slot0, slot9) > 0 then
				slot3 = 0 + slot10
				slot1[#slot1 + 1] = {
					SailGameBuildingCfg[slot9].token_get[1][1],
					slot10
				}
				slot2[#slot2 + 1] = slot9
			end
		end

		manager.net:SendWithLoadingNew(68102, {
			activity_id = slot0,
			building_id = slot2
		}, 68103, function (slot0)
			if isSuccess(slot0.result) then
				uv0.UpdateBuildingAFKRewardRedPoint(uv1)
				uv0.UpdateBuildingSetRedPoint(uv1)
				uv0.UpdateIslandUpgradeRedPoint(uv1)
				manager.notify:CallUpdateFunc(SAIL_BUILDING_REWARD_RECEIVE, uv2)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	StartGame = function (slot0)
		manager.net:SendWithLoadingNew(68104, {
			activity_id = slot0
		}, 68105, function (slot0)
			if isSuccess(slot0.result) then
				SailGameTools.GoToGameView(uv0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GiveUp = function (slot0)
		manager.net:SendWithLoadingNew(68112, {
			activity_id = slot0
		}, 68113, function (slot0)
			if isSuccess(slot0.result) then
				manager.notify:CallUpdateFunc(SAIL_GIVE_UP)
				SailGameTools.ShutDown()
				JumpTools.OpenPageByJump("/sailMain", {
					activityID = uv0
				})
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GameSettlement = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot7, slot8 in ipairs(SailGameData:GetCurGameData(slot0).eventList) do
			for slot13, slot14 in ipairs(slot8.rewardList) do
				if not slot1[slot14[1]] then
					slot1[slot14[1]] = slot14[2]
				else
					slot1[slot14[1]] = slot1[slot14[1]] + slot14[2]
				end
			end

			if slot8.shopInfo ~= nil then
				for slot13, slot14 in ipairs(slot8.shopInfo) do
					if slot14.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT then
						if not slot1[slot14.goodID] then
							slot1[slot14.goodID] = slot14.goodNum
						else
							slot1[slot14.goodID] = slot1[slot14.goodID] + slot14.goodNum
						end

						if not slot2[slot14.costID] then
							slot2[slot14.costID] = slot14.costNum
						else
							slot2[slot14.costID] = slot2[slot14.costID] + slot14.costNum
						end
					end
				end
			end
		end

		SailGameData:SaveTempSettlementData(slot0, slot1, slot2)
		uv0.UpdateBuildingSetRedPoint(slot0)
		uv0.UpdateIslandUpgradeRedPoint(slot0)
	end,
	EventOperate = function (slot0, slot1, slot2, slot3)
		slot5 = slot1 == #SailGameData:GetCurGameData(slot0).eventList

		manager.net:SendWithLoadingNew(68110, {
			activity_id = slot0,
			event_order = slot1,
			oper = slot2,
			score = slot3
		}, 68111, function (slot0)
			if isSuccess(slot0.result) then
				manager.notify:CallUpdateFunc(SAIL_EVENT_OPERATE_SUCCESS, uv0)
			elseif not uv1 then
				ShowTips(slot0.result)
			else
				ShowMessageBox({
					ButtonType = "SingleBtn",
					title = GetTips("COMFIRM"),
					content = GetTips("ACTIVITY_SKADI_SEA_BE_OUT_SETTLEMENT_FAIL"),
					OkCallback = function ()
						SailGameTools.ShutDown()
						JumpTools.OpenPageByJump("/sailMain", {
							activityID = uv0
						})
					end,
					MaskCallback = function ()
						SailGameTools.ShutDown()
						JumpTools.OpenPageByJump("/sailMain", {
							activityID = uv0
						})
					end
				})
			end
		end)
	end,
	SetEventEndMark = function (slot0, slot1)
		slot2 = SailGameData:GetCurGameData(slot0).curStageIndex

		SailGameData:SetEventEndMark(slot0, slot2 - 1, slot1)
		SailGameData:SaveTempCurrency(slot0, slot2 - 1)

		if not isNil(SailGameManager.Instance) then
			SailGameManager.Instance:UpdateStageIndex(slot2 - 1)
		end
	end,
	InitRedPoint = function ()
		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SAIL_GAME]) do
			slot6 = {}

			for slot11, slot12 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[slot5]) do
				slot6[#slot6 + 1] = string.format("%s_%d_%d", RedPointConst.SAIL_GAME_BUILDING_SET, slot5, slot12)
			end

			manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_SET, slot5), slot6)

			slot8 = {
				[#slot8 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, slot5),
				[#slot8 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, slot5),
				[#slot8 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_SET, slot5),
				[#slot8 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, slot5),
				[#slot8 + 1] = string.format("%s_%d", RedPointConst.SAIL_GAME_TASK, slot5)
			}

			manager.redPoint:addGroup(string.format("%s_%d", RedPointConst.SAIL_GAME, slot5), slot8)
		end
	end,
	UpdateRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_SET, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, slot0), 0)
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_TASK, slot0), 0)
		end
	end,
	UpdateSailCountRedPoint = function (slot0)
		slot4 = 0

		if SailGameData:GetSailCount(slot0) > 0 and SailGameData:GetIslandLevel(slot0) < #SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0] and not SailGameData:GetSelectedSailBtn(slot0) then
			slot4 = 1
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, slot0), slot4)
	end,
	UpdatetTaskRedPoint = function (slot0)
		slot4 = SailGameData:GetIslandLevel(slot0)
		slot5 = SailGameData:GetReceivedIslandLevel(slot0)
		slot6 = 0

		for slot10, slot11 in ipairs(SailGameData:GetSortTaskList(slot0)) do
			if slot11.type == SailGameConst.TASK_TYPE.BUILDING then
				if SailGameData:GetUnLockBuilding(slot0)[slot11.id] and not SailGameData:GetRceivedBuilding(slot0)[slot11.id] then
					slot6 = 1

					break
				end
			elseif SailGameIslandLevelCfg[slot11.id].level <= slot4 and not slot5[slot12] then
				slot6 = 1

				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_TASK, slot0), slot6)
	end,
	UpdateBuildingAFKRewardRedPoint = function (slot0)
		slot3 = 0

		if SailGameData:GetIslandLevel(slot0) < #SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0] and not SailGameData:GetSelectedMainBtn(slot0) then
			for slot9, slot10 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[slot0]) do
				slot4 = 0 + SailGameTools.GetBuildingTotalReward(slot0, slot10)
			end

			if GameSetting.activity_skadi_sea_building_red_dot_need.value[1] <= slot4 then
				slot3 = 1
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, slot0), slot3)
	end,
	UpdateBuildingSetRedPoint = function (slot0)
		for slot7, slot8 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[slot0]) do
			slot9 = 0

			if not SailGameData:GetUnLockBuilding(slot0)[slot8] and SailGameBuildingCfg[slot8].unlock_level_need <= SailGameData:GetIslandLevel(slot0) then
				slot10 = SailGameBuildingCfg[slot8].cost[1]
				slot9 = slot10[2] <= ItemTools.getItemNum(slot10[1]) and 1 or 0
			end

			manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.SAIL_GAME_BUILDING_SET, slot0, slot8), slot9)
		end
	end,
	UpdateIslandUpgradeRedPoint = function (slot0)
		slot3 = 1

		if SailGameData:GetIslandLevel(slot0) < #SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0] then
			for slot10, slot11 in ipairs(SailGameIslandLevelCfg[SailGameIslandLevelCfg.get_id_list_by_activity_id[slot0][slot2 + 1]].unlock_level_need) do
				slot13, slot14 = nil

				if ConditionCfg[slot11].type == 2508 then
					slot13 = 1
					slot14 = SailGameData:GetUnLockBuilding(slot0)[slot12.params[1]] == true and 1 or 0
				elseif slot12.type == 2509 then
					slot13 = slot12.params[1]
					slot14 = SailGameData:GetCompleteSailTimes(slot0)
				end

				if slot14 < slot13 then
					slot3 = 0

					break
				end
			end

			if slot3 == 1 then
				slot7 = SailGameIslandLevelCfg[slot5].cost[1]
				slot3 = slot7[2] <= ItemTools.getItemNum(slot7[1]) and 1 or 0
			end
		else
			slot3 = 0
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, slot0), slot3)
	end
}
