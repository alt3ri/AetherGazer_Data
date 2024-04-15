slot0 = singletonClass("SailGameData")

function slot0.Init(slot0)
	slot0.tempRewardDic_ = {}
	slot0.selectedSailBtn_ = {}
	slot0.selectedMainBtn_ = {}
	slot0.islandLevel_ = {}
	slot0.unlockBuildingDic_ = {}
	slot0.lastReceiveTimeStepList_ = {}
	slot0.gameDataList_ = {}
	slot0.fullRecoverTimeStepList_ = {}
	slot0.tempSettlementDataList_ = {}
	slot0.accumulateSailTimes_ = {}
	slot0.tempCurrency_ = {}
	slot0.eventEndMark_ = {}
	slot0.receivedBuildingDic_ = {}
	slot0.receivedIslandLevelDic_ = {}
	slot0.sortedTaskList_ = {}
	slot0.needSortTask_ = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id
	slot0.selectedSailBtn_[slot2] = false
	slot0.selectedMainBtn_[slot2] = false
	slot3 = slot1.island_info
	slot0.islandLevel_[slot2] = slot3.island_level
	slot0.receivedBuildingDic_[slot2] = {}

	for slot7, slot8 in ipairs(slot3.building_reward_achive) do
		slot0.receivedBuildingDic_[slot2][slot8] = true
	end

	slot0.receivedIslandLevelDic_[slot2] = {}

	for slot7, slot8 in ipairs(slot3.island_reward_achive) do
		slot0.receivedIslandLevelDic_[slot2][slot8] = true
	end

	slot0:UpdateBuilding(slot2, slot3.buildings)
	slot0:UpdateSailInfo(slot2, slot1.sailing_info)
	slot0:UpdateCompleteSailTimes(slot2, slot1.complete_sailing_time)
end

function slot0.UpdateBuilding(slot0, slot1, slot2)
	slot0.unlockBuildingDic_[slot1] = {}
	slot0.lastReceiveTimeStepList_[slot1] = {}

	for slot6, slot7 in ipairs(slot2) do
		slot0.unlockBuildingDic_[slot1][slot7.building_id] = true
		slot0.lastReceiveTimeStepList_[slot1][slot7.building_id] = slot7.last_yield_timestamp
	end

	slot0.needSortTask_[slot1] = true
end

function slot0.UpdateSailInfo(slot0, slot1, slot2)
	slot0.fullRecoverTimeStepList_[slot1] = slot2.next_reach_max_times_timestamp
	slot4 = slot2.event_list

	if not (slot0.gameDataList_[slot1] or {}).eventList or #slot3.eventList ~= #slot4 then
		slot3.eventList = {}
	end

	if #slot4 > 0 then
		slot3.gameState = SailGameConst.GAME_STATUS.RUNNING

		for slot8, slot9 in ipairs(slot4) do
			slot0:UpdateSingleEventInfo(slot3, slot9)
		end
	else
		slot3.gameState = SailGameConst.GAME_STATUS.OVER
	end

	slot0.gameDataList_[slot1] = slot3
	slot0.needSortTask_[slot1] = true

	if slot3.gameState == SailGameConst.GAME_STATUS.RUNNING then
		slot0:InitTempCurrency(slot1)

		slot0.eventEndMark_[slot1] = {
			isEnd = false
		}
	end
end

function slot0.UpdateCompleteSailTimes(slot0, slot1, slot2)
	slot0.accumulateSailTimes_[slot1] = slot2
end

function slot0.UpdateEventInfo(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot2) do
		slot0:UpdateSingleEventInfo(slot0.gameDataList_[slot1], slot8, slot1)
	end
end

function slot0.UpdateSingleEventInfo(slot0, slot1, slot2, slot3)
	slot4 = slot1.eventList[slot2.event_order] or {}

	if slot2.event_status == SailGameConst.EVENT_STATUS.RUNNING then
		slot1.curStageIndex = slot2.event_order
	end

	slot4.order = slot2.event_order
	slot4.id = slot2.event_id
	slot4.status = slot2.event_status
	slot4.rewardList = {}

	for slot8, slot9 in ipairs(slot2.event_reward) do
		slot4.rewardList[slot8] = {
			slot9.reward_id,
			slot9.reward_num
		}
	end

	slot4.lotteryInfo = nil

	if #slot2.sailing_event_gamble_result > 0 then
		slot4.lotteryInfo = {}

		for slot9, slot10 in ipairs(slot2.sailing_event_gamble_result) do
			slot4.lotteryInfo[slot9] = {
				order = slot10.gamble_order,
				result = slot10.gamble_result
			}
		end
	end

	slot4.shopInfo = nil

	if #slot2.sailing_event_trade_commodity > 0 then
		slot4.shopInfo = {}

		for slot10, slot11 in ipairs(slot2.sailing_event_trade_commodity) do
			slot12 = slot11.commodity_order
			slot4.shopInfo[slot12] = {
				order = slot11.commodity_order,
				costID = slot11.currency_id,
				costNum = slot11.currency_num,
				goodID = slot11.commodity_id,
				goodNum = slot11.commodity_num,
				soldOut = slot11.is_sell_out
			}
		end
	end

	if slot2.sailing_event_gift ~= nil then
		slot4.giftInfo = slot4.giftInfo or {}
		slot4.giftInfo.order = slot2.sailing_event_gift.gift_order
		slot4.giftInfo.itemID = slot2.sailing_event_gift.gift_id
		slot4.giftInfo.itemNum = slot2.sailing_event_gift.gift_num
	end

	slot1.eventList[slot2.event_order] = slot4

	if slot4.id == 0 and slot4.status == SailGameConst.EVENT_STATUS.OVER then
		SailGameAction.GameSettlement(slot3)
	end
end

function slot0.SaveTempSettlementData(slot0, slot1, slot2, slot3)
	slot0.tempSettlementDataList_[slot1] = slot0.tempSettlementDataList_[slot1] or {}
	slot0.tempSettlementDataList_[slot1].getDic = slot2
	slot0.tempSettlementDataList_[slot1].costDic = slot3
end

function slot0.GetTempSettlementData(slot0, slot1)
	return slot0.tempSettlementDataList_[slot1]
end

function slot0.GetCompleteSailTimes(slot0, slot1)
	return slot0.accumulateSailTimes_[slot1] or 0
end

function slot0.GetSailCount(slot0, slot1)
	slot2 = 0
	slot3 = GameSetting.activity_skadi_sea_be_out_num_max.value[1]

	return manager.time:GetServerTime() < slot0:GetFullRecoverTimeStep(slot1) and slot3 - math.ceil((slot4 - slot5) / SailGameTools.GetSailRecoverTime()) or slot3
end

function slot0.GetSelectedSailBtn(slot0, slot1)
	return slot0.selectedSailBtn_[slot1]
end

function slot0.SetSelectedSailBtn(slot0, slot1)
	if manager.redPoint:getTipBoolean(string.format("%s_%d", RedPointConst.SAIL_GAME_COUNT, slot1)) then
		slot0.selectedSailBtn_[slot1] = true

		SailGameAction.UpdateSailCountRedPoint(slot1)
	end
end

function slot0.GetSelectedMainBtn(slot0, slot1)
	return slot0.selectedMainBtn_[slot1]
end

function slot0.SetSelectedMainBtn(slot0, slot1)
	if manager.redPoint:getTipBoolean(string.format("%s_%d", RedPointConst.SAIL_GAME_BUILDING_AFK_REWARD, slot1)) then
		slot0.selectedMainBtn_[slot1] = true

		SailGameAction.UpdateBuildingAFKRewardRedPoint(slot1)
	end
end

function slot0.GetCurGameData(slot0, slot1)
	return slot0.gameDataList_[slot1]
end

function slot0.GetFullRecoverTimeStep(slot0, slot1)
	return slot0.fullRecoverTimeStepList_[slot1] or 0
end

function slot0.SetEventEndMark(slot0, slot1, slot2, slot3)
	slot0.eventEndMark_[slot1] = slot0.eventEndMark_[slot1] or {}
	slot0.eventEndMark_[slot1].isEnd = true
	slot0.eventEndMark_[slot1].stageIndex = slot2
	slot0.eventEndMark_[slot1].tipsIndex = slot3
end

function slot0.GetEventEndMark(slot0, slot1)
	slot0.eventEndMark_[slot1].isEnd = false

	return deepClone(slot0.eventEndMark_[slot1])
end

function slot0.GetEventReward(slot0, slot1, slot2)
	slot3 = 0

	if slot0:GetCurGameData(slot1).eventList[slot2].status == SailGameConst.EVENT_STATUS.OVER then
		if #slot4.rewardList > 0 then
			for slot9, slot10 in ipairs(slot5) do
				if slot10[1] == CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id then
					slot3 = slot3 + slot10[2]
				end
			end
		end

		if slot4.shopInfo ~= nil then
			for slot9, slot10 in ipairs(slot4.shopInfo) do
				if slot10.soldOut == SailGameConst.EVENT_SHOP_STATUS.SOLD_OUT and slot10.goodID == CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id then
					slot3 = slot3 + slot10.goodNum
				end
			end
		end
	end

	return slot3
end

function slot0.InitTempCurrency(slot0, slot1)
	slot0.tempCurrency_[slot1] = slot0.tempCurrency_[slot1] or {}

	for slot8 = 1, slot0.gameDataList_[slot1].curStageIndex - 1 do
		slot4 = 0 + slot0:GetEventReward(slot1, slot8)
	end

	slot0.tempCurrency_[slot1].lastNum = slot4
	slot0.tempCurrency_[slot1].curNum = slot4
end

function slot0.SaveTempCurrency(slot0, slot1, slot2)
	slot0.tempCurrency_[slot1].lastNum = slot0.tempCurrency_[slot1].curNum
	slot0.tempCurrency_[slot1].curNum = slot0.tempCurrency_[slot1].curNum + slot0:GetEventReward(slot1, slot2)
end

function slot0.GetTempCurrency(slot0, slot1)
	return slot0.tempCurrency_[slot1]
end

function slot0.GetBuildingData(slot0, slot1, slot2)
	if slot0.buildingDataList_[slot1] then
		return slot0.buildingDataList_[slot1][slot2] or {}
	end

	return {}
end

function slot0.UnLockBuilding(slot0, slot1, slot2)
	slot0.unlockBuildingDic_[slot1][slot2] = true
	slot0.needSortTask_[slot1] = true
end

function slot0.GetUnLockBuilding(slot0, slot1)
	return slot0.unlockBuildingDic_[slot1]
end

function slot0.GetRceivedBuilding(slot0, slot1)
	return slot0.receivedBuildingDic_[slot1]
end

function slot0.GetBuildingLastReceiveTimeList(slot0, slot1)
	return slot0.lastReceiveTimeStepList_[slot1]
end

function slot0.GetIslandLevel(slot0, slot1)
	return slot0.islandLevel_[slot1]
end

function slot0.UpgradeIsland(slot0, slot1)
	slot0.islandLevel_[slot1] = slot0.islandLevel_[slot1] + 1
	slot0.needSortTask_[slot1] = true
end

function slot0.GetReceivedIslandLevel(slot0, slot1)
	return slot0.receivedIslandLevelDic_[slot1]
end

function slot0.ReceiveTask(slot0, slot1, slot2, slot3)
	if slot3 == SailGameConst.TASK_TYPE.BUILDING then
		slot0.receivedBuildingDic_[slot1][slot2] = true
	elseif slot3 == SailGameConst.TASK_TYPE.ISLAND_LEVEL then
		slot0.receivedIslandLevelDic_[slot1][slot2] = true
	end

	slot0.needSortTask_[slot1] = true
end

function slot0.GetSortTaskList(slot0, slot1)
	if not slot0.needSortTask_[slot1] then
		return slot0.sortedTaskList_[slot1]
	end

	slot0.needSortTask_[slot1] = false
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot6 = slot0:GetUnLockBuilding(slot1)

	for slot11, slot12 in ipairs(SailGameBuildingCfg.get_id_list_by_activity_id[slot1]) do
		if slot0:GetRceivedBuilding(slot1)[slot12] then
			slot3[#slot3 + 1] = {
				id = slot12,
				type = SailGameConst.TASK_TYPE.BUILDING
			}
		elseif slot6[slot12] then
			slot2[#slot2 + 1] = {
				id = slot12,
				type = SailGameConst.TASK_TYPE.BUILDING
			}
		else
			slot4[#slot4 + 1] = {
				id = slot12,
				type = SailGameConst.TASK_TYPE.BUILDING
			}
		end
	end

	slot9 = slot0:GetIslandLevel(slot1)

	for slot14, slot15 in ipairs(SailGameIslandLevelCfg.get_id_list_by_activity_id[slot1]) do
		if SailGameIslandLevelCfg[slot15].level > 1 then
			if slot0:GetReceivedIslandLevel(slot1)[slot16] then
				slot3[#slot3 + 1] = {
					id = slot15,
					type = SailGameConst.TASK_TYPE.ISLAND_LEVEL
				}
			elseif slot16 <= slot9 then
				slot2[#slot2 + 1] = {
					id = slot15,
					type = SailGameConst.TASK_TYPE.ISLAND_LEVEL
				}
			else
				slot4[#slot4 + 1] = {
					id = slot15,
					type = SailGameConst.TASK_TYPE.ISLAND_LEVEL
				}
			end
		end
	end

	slot11 = handler(slot0, slot0.SortCompareFunc)

	table.sort(slot3, slot11)
	table.sort(slot2, slot11)
	table.sort(slot4, slot11)
	table.insertto(slot2, slot4)
	table.insertto(slot2, slot3)

	slot0.sortedTaskList_[slot1] = slot2

	return slot2
end

function slot0.SortCompareFunc(slot0, slot1, slot2)
	if slot1.type == slot2.type then
		return slot1.id < slot2.id
	else
		return slot1.type < slot2.type
	end
end

return slot0
