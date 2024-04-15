slot0 = singletonClass("TimerReminderData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.SetReminder(slot0, slot1)
	if not uv0[slot1] then
		uv0[slot1] = {
			num = 0,
			sureNum = 0,
			id = slot1
		}
	end

	if slot1 == TimerReminderConst.FATIGUE then
		slot5 = nil

		if tonumber(string.split(manager.time:DescCTime(manager.time:GetServerTime() + (GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) and 0 or (slot3 - slot4 - 1) * slot6 + (CurrencyData:GetLastFatigueRecoverTime() == 0 and slot6 or slot6 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % slot6) + 28800), "!%Y %m %d %H %M %S"), " ")[4]) >= 0 and slot9 < 8 then
			slot6 = manager.time:Table2ServerTime({
				hour = 8,
				min = 0,
				sec = 0,
				year = tonumber(slot8[1]),
				month = tonumber(slot8[2]),
				day = tonumber(slot8[3])
			})
		end

		if uv0[slot1].nextReminderTime == nil then
			uv0[slot1].nextReminderTime = slot6
		else
			if uv0[slot1].nextReminderTime and uv0[slot1].nextReminderTime == slot6 then
				return
			end

			if uv0[slot1].nextReminderTime <= manager.time:GetServerTime() then
				uv0[slot1].lastReminderTime = uv0[slot1].nextReminderTime
			end

			if uv0[slot1].lastReminderTime and slot6 <= uv0[slot1].lastReminderTime + GameSetting.push_notification_fatigue_cooldown.value[1] * 60 then
				slot0:CancelReminder(slot1)

				return
			end

			uv0[slot1].nextReminderTime = slot6
		end

		slot10 = PushNotificationCfg.get_id_list_by_type[slot1]
		slot12 = PushNotificationCfg[slot10[math.round(math.random(#slot10))]]

		if slot5 * 1000 >= 1000 then
			GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", slot1, GetI18NText(slot12.title), GetI18NText(slot12.content), slot5 * 1000))
		end
	elseif slot1 == TimerReminderConst.DAILYFATIGUE then
		slot0:DailyFatigueReminder(slot1)
	elseif slot1 == TimerReminderConst.CAT_EXPLORE then
		slot0:CatExploreReminder(slot1)
	elseif slot1 == TimerReminderConst.CANTEEN_DISPATCH then
		slot0:CanteenDispatchReminder(slot1)
	elseif slot1 == TimerReminderConst.CANTEEN_FULL then
		slot0:CanteenFullReminder(slot1)
	else
		print("未设置此推送类型", slot1)
	end
end

function slot0.CalHeroWorkTime(slot0, slot1, slot2)
	slot4 = GameSetting.canteen_popular_cost_time.value
	slot5 = slot4[#slot4][2]

	for slot9, slot10 in ipairs(slot4) do
		if CanteenData:GetPopularityNum() < slot10[1] then
			slot5 = slot10[2]
		end
	end

	slot6 = GameSetting.dorm_canteen_fatigue_cost.value[1] / 100

	for slot12, slot13 in ipairs(DormSkillData:CheckSkillCanOpen(slot1, slot2)) do
		if BackHomeHeroSkillCfg[slot13].type == CanteenConst.HeroSkillType.FatigueRecuse then
			slot8 = 0 + BackHomeHeroSkillCfg[slot13].param[1]
		end
	end

	return slot6 * (100 - slot8) / 100
end

slot2 = 9999999999.0
slot3 = 0

function slot0.traceback(slot0, slot1, slot2, slot3)
	uv0 = uv0 + 1
	slot4 = 0
	slot5 = 0
	slot6 = 9999999999.0
	slot7 = slot3

	for slot12, slot13 in pairs(slot2) do
		if DormNpcTools:CheckIDIsNpc(slot12) then
			for slot17, slot18 in pairs(slot7) do
				slot5 = slot5 + (CanteenFoodData:GetFoodUnitCost(slot17) or 0) / (CanteenFoodData:CalSignFoodTime(slot17, 1) or 1)
			end

			uv1 = math.min(uv1, slot1 / slot5)
		else
			slot15 = GameSetting.canteen_popular_cost_time.value
			slot16 = slot15[#slot15][2]

			for slot20, slot21 in ipairs(slot15) do
				if (CanteenData:GetPopularityNum() or 0) < slot21[1] then
					slot16 = slot21[2]

					break
				end
			end

			slot17 = slot0:CalHeroWorkTime(slot12, slot13.heroID) or 1
			slot6 = math.min(slot13.curFatigue / slot17 * slot16, slot6)
			slot13.curFatigue = slot13.curFatigue - slot17
		end
	end

	for slot12, slot13 in pairs(slot7) do
		slot15 = CanteenFoodData:GetFoodUnitCost(slot12) or 0

		if (CanteenFoodData:CalSignFoodTime(slot12, slot13.sellNum - slot13.soldNum) or 1) <= 0 or slot14 <= 0 then
			break
		end

		slot18 = 0
		slot19 = nil
		slot5 = slot5 + slot15 / (slot16 / slot14)

		if slot6 / (slot16 / slot14) <= slot14 then
			slot18 = slot19 * slot6
			slot13.soldNum = slot13.soldNum + slot17
		else
			slot18 = slot14 * slot15
			slot13.soldNum = slot13.soldNum + slot14
		end

		slot4 = slot4 + slot18
	end

	if slot4 < slot1 and uv0 <= 10 then
		if uv1 == 9999999999.0 then
			uv1 = 0
		end

		uv1 = uv1 + slot6

		slot0:traceback(slot1 - slot4, slot8, slot7)
	else
		slot9 = slot1 / slot5

		if uv1 == 9999999999.0 then
			uv1 = 0
		end

		uv1 = uv1 + slot9
		slot6 = 9999999999.0
		uv0 = 0
	end
end

function slot0.CanteenFullReminder(slot0, slot1)
	slot2 = nil

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		if CanteenTools:CheckSignFoodNumCanOpen() and CanteenTools:CheckCanteenJobCanOpen() then
			slot5 = {
				[slot10] = {
					sellNum = slot11.sellNum,
					soldNum = slot11.soldNum
				}
			}

			for slot9, slot10 in ipairs(CanteenFoodData:GetChooseFoodList()) do
				slot11 = CanteenFoodData:GetSignFoodInfo(slot10)
				slot4 = 0 + (slot11.sellNum - slot11.soldNum or 0) * (CanteenFoodData:GetFoodUnitCost(slot10) or 0)
			end

			slot8 = (DormSkillData:GetInComeStorageMax() or 0) - (CanteenData:GetAutoAwardNum() or 0)
			slot10 = {
				[slot15.heroID] = {
					curFatigue = DormData:GetCharacterInfo(slot15.heroID):GetFatigue() or 0,
					jobType = CanteenHeroTools:GetJobTypeByHeroID(slot15.heroID),
					heroID = slot15.heroID
				}
			}

			for slot14, slot15 in pairs(CanteenHeroTools:GetCanteenJobList()) do
				if not DormNpcTools:CheckIDIsNpc(slot15.heroID) then
					-- Nothing
				end
			end

			if slot4 < slot7 - slot6 then
				return
			else
				slot0:traceback(slot8, slot10, slot5)
			end

			slot8 = 0
		else
			return
		end
	else
		return
	end

	slot3 = nil
	uv0 = 9999999999.0

	if manager.time:GetServerTime() + math.ceil(uv0) + 28800 <= manager.time:GetServerTime() + 28800 then
		slot4 = manager.time:GetServerTime() + 7200 + 28800
		slot3 = true
		uv1[slot1].sureNum = uv1[slot1].num
	end

	slot7 = tonumber(string.split(manager.time:DescCTime(slot4, "!%Y %m %d %H %M %S"), " ")[4])
	slot8 = math.floor(slot2 / 86400)

	if slot0:KrNotPush() then
		if slot7 > 20 or slot7 < 7 then
			slot2 = manager.time:Table2ServerTime({
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(slot6[1]),
				month = tonumber(slot6[2]),
				day = tonumber(slot6[3])
			})
			uv1[slot1].num = 0
			uv1[slot1].nextReminderTime = nil
			uv1[slot1].lastReminderTime = nil
		end
	elseif slot7 >= 0 and slot7 < 8 then
		slot2 = manager.time:Table2ServerTime({
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(slot6[1]),
			month = tonumber(slot6[2]),
			day = tonumber(slot6[3])
		})
		uv1[slot1].num = 0
		uv1[slot1].nextReminderTime = nil
		uv1[slot1].lastReminderTime = nil
	end

	if uv1[slot1].nextReminderTime == nil then
		uv1[slot1].nextReminderTime = slot4
	else
		if uv1[slot1].nextReminderTime and uv1[slot1].nextReminderTime == slot4 then
			return
		end

		if uv1[slot1].nextReminderTime <= manager.time:GetServerTime() + 28800 then
			uv1[slot1].lastReminderTime = uv1[slot1].nextReminderTime
		end

		if uv1[slot1].lastReminderTime and slot4 <= uv1[slot1].lastReminderTime + GameSetting.push_notification_canteenfull_cooldown.value[1] * 60 then
			return
		end

		uv1[slot1].nextReminderTime = slot4
	end

	slot11 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]]

	if slot2 % 86400 == 0 then
		if slot2 == 0 then
			slot2 = 7200
		else
			slot2 = 86400 - manager.time:GetServerTime() % 86400 + slot8 * 86400
		end
	elseif slot3 then
		slot2 = 7200
		slot3 = false
	end

	print("餐厅收益上限推送", slot1, slot11.title, slot11.content, slot2 * 1000)

	if slot2 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", slot1, slot11.title, slot11.content, slot2 * 1000))

		uv1[slot1].num = uv1[slot1].num + 1
	end
end

function slot0.CanteenDispatchReminder(slot0, slot1)
	slot2 = nil
	slot3 = 9999999999.0

	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) and CanteenEntrustData:GetEntrustList() then
		for slot8, slot9 in pairs(slot4) do
			if slot9.start_time and slot9.start_time > 0 then
				slot3 = math.min(slot9.start_time + BackHomeCanteenTaskCfg[slot9.id].time[slot9.timeLevel][1] * 60, slot3)
			end
		end
	end

	slot4 = nil

	if slot3 == 9999999999.0 then
		return
	end

	if slot2 + 28800 < manager.time:GetServerTime() + 28800 then
		slot5 = manager.time:GetServerTime() + 7200 + 28800
		slot4 = true
		uv0[slot1].sureNum = uv0[slot1].num
	end

	slot8 = tonumber(string.split(manager.time:DescCTime(slot5, "!%Y %m %d %H %M %S"), " ")[4])

	if slot0:KrNotPush() then
		if slot8 > 20 or slot8 < 7 then
			slot2 = manager.time:Table2ServerTime({
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(slot7[1]),
				month = tonumber(slot7[2]),
				day = tonumber(slot7[3])
			})
			uv0[slot1].num = 0
			uv0[slot1].nextReminderTime = nil
			uv0[slot1].lastReminderTime = nil
		end
	elseif slot8 >= 0 and slot8 < 8 then
		slot2 = manager.time:Table2ServerTime({
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(slot7[1]),
			month = tonumber(slot7[2]),
			day = tonumber(slot7[3])
		})
		uv0[slot1].num = 0
		uv0[slot1].nextReminderTime = nil
		uv0[slot1].lastReminderTime = nil
	end

	if uv0[slot1].nextReminderTime == nil then
		uv0[slot1].nextReminderTime = slot5
	else
		if uv0[slot1].nextReminderTime and uv0[slot1].nextReminderTime == slot5 then
			return
		end

		if uv0[slot1].nextReminderTime <= manager.time:GetServerTime() + 28800 then
			uv0[slot1].lastReminderTime = uv0[slot1].nextReminderTime
		end

		if uv0[slot1].lastReminderTime and (slot5 <= uv0[slot1].lastReminderTime + GameSetting.push_notification_canteendispatch_cooldown.value[1] * 60 or PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]].times <= uv0[slot1].sureNum) then
			return
		end

		uv0[slot1].nextReminderTime = slot5
	end

	slot11 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]]

	if slot2 % 86400 == 0 then
		slot2 = 86400 - manager.time:GetServerTime() % 86400
	elseif slot4 then
		slot2 = 7200
		slot4 = false
	else
		slot2 = math.abs(slot2 % 86400 - manager.time:GetServerTime() % 86400)
	end

	print("餐厅派遣推送", slot1, slot11.title, slot11.content, slot2 * 1000)

	if slot2 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", slot1, slot11.title, slot11.content, slot2 * 1000))

		uv0[slot1].num = uv0[slot1].num + 1
	end
end

function slot0.CatExploreReminder(slot0, slot1)
	slot2 = nil

	if AdminCatExploreData:GetMinStopTime() == 9999999999.0 then
		return
	end

	slot3 = nil

	if slot2 + 28800 < manager.time:GetServerTime() + 28800 then
		slot4 = manager.time:GetServerTime() + 7200 + 28800
		slot3 = true
		uv0[slot1].sureNum = uv0[slot1].num
	end

	slot7 = tonumber(string.split(manager.time:DescCTime(slot4, "!%Y %m %d %H %M %S"), " ")[4])

	if slot0:KrNotPush() then
		if slot7 > 20 or slot7 < 7 then
			slot2 = manager.time:Table2ServerTime({
				hour = 7,
				min = 0,
				sec = 0,
				year = tonumber(slot6[1]),
				month = tonumber(slot6[2]),
				day = tonumber(slot6[3])
			})
			uv0[slot1].num = 0
			uv0[slot1].nextReminderTime = nil
			uv0[slot1].lastReminderTime = nil
		end
	elseif slot7 >= 0 and slot7 < 8 then
		slot2 = manager.time:Table2ServerTime({
			hour = 8,
			min = 0,
			sec = 0,
			year = tonumber(slot6[1]),
			month = tonumber(slot6[2]),
			day = tonumber(slot6[3])
		})
		uv0[slot1].num = 0
		uv0[slot1].nextReminderTime = nil
		uv0[slot1].lastReminderTime = nil
	end

	if uv0[slot1].nextReminderTime == nil then
		uv0[slot1].nextReminderTime = slot4
	else
		if uv0[slot1].nextReminderTime and uv0[slot1].nextReminderTime == slot4 then
			return
		end

		if uv0[slot1].nextReminderTime <= manager.time:GetServerTime() + 28800 then
			uv0[slot1].lastReminderTime = uv0[slot1].nextReminderTime
		end

		if uv0[slot1].lastReminderTime and (slot4 <= uv0[slot1].lastReminderTime + GameSetting.push_notification_catexplore_cooldown.value[1] * 60 or PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]].times <= uv0[slot1].sureNum) then
			return
		end

		uv0[slot1].nextReminderTime = slot4
	end

	slot10 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]]

	if slot2 % 86400 == 0 then
		slot2 = 86400 - manager.time:GetServerTime() % 86400
	elseif slot3 then
		slot2 = 7200
		slot3 = false
	else
		slot2 = math.abs(slot2 % 86400 - manager.time:GetServerTime() % 86400)
	end

	print("猫咪探索推送", slot1, slot10.title, slot10.content, slot2 * 1000)

	if slot2 * 1000 >= 1000 then
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", slot1, slot10.title, slot10.content, slot2 * 1000))

		uv0[slot1].num = uv0[slot1].num + 1
	end
end

function slot0.DailyFatigueReminder(slot0, slot1)
	slot4 = PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]]

	if (43200 - manager.time:GetServerTime() % 86400) * 1000 >= 1000 and (DailyFatigueData:GetStatus(11) ~= 3 or DailyFatigueData:GetStatus(18) ~= 3) then
		print("吨吨补给站推送", slot1, slot4.title, slot4.content, slot5 * 1000)
		GameToSDK.SendMessage(string.format("{\"messageType\" : \"PushNotification\" , \"msgId\" : \"%d\" , \"title\" : \"%s\" , \"message\" : \"%s\" , \"time\" : \"%d\"}", slot1, slot4.title, slot4.content, slot5 * 1000))
	end
end

function slot0.CancelReminder(slot0, slot1)
	if slot1 == nil or uv0[slot1] == nil then
		print("未设置此推送", slot1)

		return
	end

	if uv0[slot1].nextReminderTime and uv0[slot1].nextReminderTime <= manager.time:GetServerTime() + 28800 then
		return
	end

	GameToSDK.SendMessage(string.format("{\"messageType\" : \"CancelNotification\" , \"msgId\" : \"%d\"}", slot1))

	if uv0[slot1].sureNum >= 0 and uv0[slot1].sureNum < PushNotificationCfg[PushNotificationCfg.get_id_list_by_type[slot1][1]].times then
		uv0[slot1].num = uv0[slot1].num - 1
		uv0[slot1].nextReminderTime = nil
	end
end

function slot0.KrNotPush(slot0)
	if manager.time then
		if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].push_message == 1 then
			return true
		else
			return false
		end
	end
end

return slot0
