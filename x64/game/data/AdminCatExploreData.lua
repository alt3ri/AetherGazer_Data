slot0 = singletonClass("AdminCatExploreData")

function slot1(slot0)
	slot1 = {
		[slot5] = {}
	}

	for slot5, slot6 in ipairs(slot0) do
		slot1[slot5].time = slot6.time
		slot1[slot5].address = slot6.address_id
		slot1[slot5].content = slot6.content_id
	end

	return slot1
end

function slot0.Init(slot0)
	slot0.nextLockAdminCat = {}
	slot0.nextLockRegion = {}
	slot0.skillData = {}
	slot0.adminCatLockList = {}
	slot0.maxLevel = ExploreLevelCfg[#ExploreLevelCfg.all].id
	slot0.unlockAdminCat = {}
	slot0.exp = 0
	slot0.regionUnlockLevel = {}
	slot0.regionData = {}
	slot0.isView = false
	slot1 = {
		[slot7] = slot7
	}
	slot2 = {}

	for slot6, slot7 in pairs(ExploreLevelCfg[1].area) do
		-- Nothing
	end

	for slot6, slot7 in pairs(ExploreLevelCfg[1].meow) do
		slot2[slot7] = slot7
	end

	for slot6 = 2, slot0.maxLevel do
		for slot11, slot12 in pairs(ExploreLevelCfg[slot6].area) do
			if slot1[slot12] == nil then
				slot1[slot12] = slot12
				slot0.nextLockRegion[slot6] = slot12
				slot0.regionUnlockLevel[slot12] = slot6
			end
		end

		for slot11, slot12 in pairs(slot7.meow) do
			if slot2[slot12] == nil then
				slot2[slot12] = slot12
				slot0.nextLockAdminCat[slot6] = slot12
				slot0.adminCatLockList[slot12] = slot6
			end
		end
	end

	slot0.totalAdminCat = #ExploreMeowCfg.all
	slot0.rate = GameSetting.explore_accumulation_multiplying_power.value
	slot0.rate[0] = 0
	slot0.level = nil
end

function slot0.CalculateLevel(slot0)
	slot1 = ItemTools.getItemNum(53)

	for slot6 = 1, slot0.maxLevel do
		if ExploreLevelCfg[slot6].exp <= slot1 and ExploreLevelCfg[slot6].exp ~= 0 then
			slot1 = slot1 - ExploreLevelCfg[slot6].exp
			slot2 = 1 + 1
		end
	end

	if slot0.level ~= nil and slot0.level < slot2 then
		slot0.level = slot2

		JumpTools.GoToSystem("/adminCatExploreLevelUpPop", {})
	end

	slot0.level = slot2
	slot0.exp = slot1
end

function slot0.CheckCanGetWeeklyReward(slot0)
	return manager.time:GetGameServerWeek() == 6 or slot1 == 7
end

function slot0.CalculateMaxExploreHour(slot0)
	slot0.maxExploreHour = ExploreLevelCfg[slot0.level].time
end

function slot0.GetRegionIdByIndex(slot0, slot1)
	return ExploreLevelCfg[slot0.maxLevel].area[slot1]
end

function slot0.ResetExploreDay(slot0)
	slot0.exploreDay = 0
	slot0.getWeeklyReward = 1

	slot0:UpdateRewardRedPoint()
end

function slot0.GetDataByPara(slot0, slot1)
	return slot0[slot1]
end

function slot0.ModifyData(slot0, slot1, slot2)
	slot0:CalculateLevel()
end

function slot0.UpdateWeeklyFirst(slot0)
	slot0.isFirstOpen = 1
end

function slot0.InitExploreData(slot0, slot1)
	slot0.exploringCount = 0

	for slot5, slot6 in ipairs(slot1.explore_queue) do
		slot0.regionData[slot6.area_id] = {
			regionID = slot6.area_id,
			startTime = slot6.start_time,
			adminCatID = slot6.mimir_id,
			stopTime = slot6.stop_time,
			exploreHour = slot6.target_explore_hour,
			eventData = uv0(slot6.explore_event)
		}
		slot0.exploringCount = slot0.exploringCount + 1
	end

	for slot5, slot6 in ipairs(slot1.mimir) do
		slot0.skillData[slot6.skill[1].skill_id] = slot6.skill[1].skill_level
		slot0.unlockAdminCat[slot6.mimir_id] = true
	end

	slot0.exploreDay = slot1.weekly_time
	slot0.isFirstOpen = slot1.weekly_scene_open
	slot0.dailyTime = slot1.daily_time
	slot0.getWeeklyReward = slot1.weekly_reward_state
	slot0.accumulateC = slot1.total_explore_c or 0

	slot0:CalculateLevel()
	slot0:UpdateFirstViewRedPoint()
	slot0:UpdateRewardRedPoint()
end

function slot0.UpdateSkillList(slot0, slot1)
	if slot0.skillData[slot1] == nil then
		slot0.skillData[slot1] = 1
	else
		slot0.skillData[slot1] = slot0.skillData[slot1] + 1
	end
end

function slot0.UpdateUnlockAdminCatList(slot0, slot1)
	slot0.unlockAdminCat[slot1] = true

	slot0:UpdateSkillList(ExploreMeowCfg[slot1].skill)
	slot0:UpdateAdminCatRedPoint()
end

function slot0.UpdateFinishExploreData(slot0, slot1, slot2, slot3)
	slot4 = slot0.regionData[slot1]

	slot0:CalculateAdminCatRate(slot4.adminCatID, slot4.exploreHour)
	slot0:CalculateInbornRate(slot4.adminCatID, slot1)
	manager.redPoint:setTip(RedPointConst.EXPLORE_FINISH .. slot4.regionID, 0)
	JumpTools.OpenPageByJump("adminCatExploreFinishPop", {
		regionId = slot1,
		eventId = slot2,
		reward = slot3,
		adminCatID = slot4.adminCatID
	})

	slot0.regionData[slot1] = nil

	slot0:UpdateRewardRedPoint()
end

function slot0.CalculateAdminCatRate(slot0, slot1, slot2)
	slot0.skillEffect = true

	if ExploreMeowSkillCfg[ExploreMeowCfg[slot1].skill].skill_type == 1 and slot2 <= 8 then
		-- Nothing
	elseif slot6 == 2 and slot2 <= 8 then
		-- Nothing
	elseif slot6 == 3 and slot2 > 8 then
		-- Nothing
	elseif slot6 == 4 and slot2 > 8 then
		-- Nothing
	elseif slot6 ~= 5 then
		slot0.skillEffect = false
	end
end

function slot0.CalculateInbornRate(slot0, slot1, slot2)
	slot0.inbornEffect = false

	for slot7, slot8 in ipairs(ExploreMeowCfg[slot1].area_recommend) do
		if slot8 == slot2 then
			slot0.inbornEffect = true
		end
	end
end

function slot0.UpdateRegionRedPoint(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	for slot4, slot5 in pairs(slot0.regionData) do
		manager.redPoint:setTip(RedPointConst.EXPLORE_FINISH .. slot5.regionID, slot5.stopTime <= manager.time:GetServerTime() and 1 or 0)
	end

	slot0:UpdateAdminCatRedPoint()
	slot0:UpdateRewardRedPoint()
end

function slot0.UpdateFirstViewRedPoint(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	if slot0.isView then
		manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, 0)
	else
		manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, slot0.level and slot0.exploringCount < ExploreLevelCfg[slot0.level].amount and 1 or 0)
	end
end

function slot0.UpdateQueueRedPoint(slot0)
	slot0.isView = true

	manager.redPoint:setTip(RedPointConst.EXPLORE_QUEUE, 0)
end

function slot0.UpdateRewardRedPoint(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.ADMIN_CAT_EXPLORE) then
		return
	end

	if slot0:CheckCanGetWeeklyReward() and slot0.getWeeklyReward == 0 and slot0.exploreDay > 0 then
		manager.redPoint:setTip(RedPointConst.EXPLORE_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.EXPLORE_REWARD, 0)
	end
end

function slot0.CheckCanLock(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.accumulateC < slot6[2] then
			return false
		end
	end

	return true
end

function slot0.UpdateAdminCatRedPoint(slot0)
	for slot4 = 1, slot0.totalAdminCat do
		manager.redPoint:setTip(RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. slot5.id, slot0.unlockAdminCat[ExploreMeowCfg[ExploreMeowCfg.all[slot4]].id] ~= true and slot0.level ~= nil and slot0.level >= (slot0.adminCatLockList[slot5.id] or 0) and slot0:CheckCanLock(slot5.unlock_condition) and 1 or 0)
	end
end

function slot0.SortAdminCatList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0.unlockAdminCat) do
		slot10 = false

		for slot14, slot15 in ipairs(ExploreMeowCfg[slot6].area_recommend) do
			if slot15 == slot1 then
				slot9 = 1000 * 1000
				slot10 = true
			end
		end

		table.insert(slot2, {
			canUse = true,
			sort = slot9,
			id = slot6,
			recommend = slot10
		})
	end

	for slot6, slot7 in pairs(slot0.regionData) do
		for slot11, slot12 in ipairs(slot2) do
			if slot12.id == slot7.adminCatID then
				slot12.sort = slot12.sort / 1000
				slot12.canUse = false
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		slot7.sort = slot7.sort + slot7.id
	end

	table.sort(slot2, function (slot0, slot1)
		return slot1.sort < slot0.sort
	end)

	return slot2
end

function slot0.SortAllAdminCatList(slot0)
	for slot5, slot6 in ipairs(ExploreMeowCfg.all) do
		slot7 = 100000

		table.insert({}, {
			sort = (slot0.unlockAdminCat[slot6] and slot7 / 1000 or slot7) + slot6,
			id = slot6,
			canUse = slot0.unlockAdminCat[slot6] or false
		})
	end

	for slot5, slot6 in pairs(slot0.regionData) do
		for slot10, slot11 in ipairs(slot1) do
			if slot11.id == slot6.adminCatID then
				slot11.canLevelUp = false
			end
		end
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.sort < slot1.sort
	end)

	return slot1
end

function slot0.GetMinStopTime(slot0)
	slot1 = 9999999999.0

	if slot0.regionData then
		for slot5, slot6 in pairs(slot0.regionData) do
			if slot6.stopTime then
				slot1 = math.min(slot6.stopTime, slot1)
			end
		end
	end

	return slot1
end

return slot0
