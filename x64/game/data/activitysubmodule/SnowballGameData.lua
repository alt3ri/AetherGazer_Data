slot0 = singletonClass("SnowballGameData")

function slot0.Init(slot0)
	slot0.unlockedLevels = {
		[0] = 0
	}
	slot0.lastSelectPlayer = nullable(SnowballGameUnitCfg, getData("snowball", "lastSelectedPlayer"), "id") or nullable(SnowballGameUnitCfg.get_id_list_by_unit_type, 0, 1)
	slot0.lastEnter = getData("snowball", "lastEnter")
end

function slot1(slot0, slot1)
	return string.format("%s_%s", slot0, slot1)
end

slot2 = "ACTIVITY_COMMON"
slot3 = "ACTIVITY_TASK"
slot4 = "INFINITY_POOL"

function slot0.InitSnowballRedPoint(slot0, slot1)
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1
	slot3 = uv0(uv1, slot1)
	slot4 = {
		RedPointConst.ACTIVITY_2_6_SNOWBALL_NOT_YET_ENTERED,
		RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL,
		RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE
	}

	for slot9, slot10 in ipairs(ActivityTools.GetAllSubActivityByTemplate(slot1, ActivityTemplateConst.INFINITY_POOL)) do
		table.insert(slot4, uv0(uv2, slot10))
	end

	slot0.infPoolSubActivity = slot5

	manager.redPoint:addGroup(RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME, slot4, true)
	manager.redPoint:addGroup(slot2, {
		RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME,
		RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_DAILY
	}, true)
end

function slot0.CheckTaskRedPoint(slot0)
	slot1 = false
	slot2 = false

	for slot7, slot8 in ipairs(TaskTools:GetCanGetActivityTaskList(slot0.activityID)) do
		if AssignmentCfg[slot8.id].type == TaskConst.TASK_TYPE.SNOWBALL_TASK_CHALLENGE then
			slot1 = true
		elseif AssignmentCfg[slot8.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY or AssignmentCfg[slot8.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
			slot2 = true
		end

		if slot2 and slot1 then
			break
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_DAILY, slot2 and 1 or 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_TASK_CHALLENGE, slot1 and 1 or 0)
end

function slot0.GetTaskRedPointKey(slot0)
	return uv0(uv1, slot0.activityID)
end

function slot0.GetInfPoolRedPointKey(slot0, slot1)
	return uv0(uv1, slot0.infPoolSubActivity[slot1])
end

function slot0.InitFromServer(slot0, slot1)
	slot0.activityID = slot1.activity_id
	slot5 = slot0.activityID

	slot0:InitSnowballRedPoint(slot5)
	slot0:CheckTaskRedPoint()

	for slot5, slot6 in ipairs(slot1.stage_list) do
		slot0.unlockedLevels[slot6.stage_id] = slot6.max_score
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_NOT_YET_ENTERED, slot0:IsFirstEnterGame() and 1 or 0)
	slot0:UpdateUnlockLevelRedPoint()
end

function slot0.UpdateUnlockLevelRedPoint(slot0)
	if slot0:AnyLevelNotPlayed() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_UNCOMPLETE_LEVEL, 1)
	end
end

slot0.LevelLockReason = {
	NEED_UNLOCK_OTHER_LEVEL = 1,
	ACTIVITY_TIME_LOCK = 0
}

function slot0.CheckLevelCost(slot0, slot1)
	if SnowballGameCfg[slot1].level_cost[1] == nil then
		return true
	else
		return slot3[2] <= ItemTools.getItemNum(slot3[1])
	end
end

function slot0.IsLevelUnlocked(slot0, slot1, slot2)
	if not ActivityTools.GetActivityIsOpenWithTip(SnowballGameCfg[slot1].activity_id, slot2 or false) then
		return false, uv0.LevelLockReason.ACTIVITY_TIME_LOCK, slot4
	elseif not slot0.unlockedLevels[slot3.level_unlock] then
		return false, uv0.LevelLockReason.NEED_UNLOCK_OTHER_LEVEL, slot3.level_unlock
	else
		return true
	end
end

function slot0.CacheLevelAlreadyUnlocked(slot0, slot1)
	saveData("snowballLevel", tostring(slot1), true)
end

function slot0.IsLevelFirstUnlocked(slot0, slot1)
	return not getData("snowballLevel", tostring(slot1))
end

function slot0.AnyLevelUnlocked(slot0)
	for slot4, slot5 in ipairs(SnowballGameCfg.all) do
		if slot0:IsLevelUnlocked(slot5) then
			return true
		end
	end

	return false
end

function slot0.AnyLevelNotPlayed(slot0)
	for slot4, slot5 in ipairs(SnowballGameCfg.all) do
		if slot0:IsLevelUnlocked(slot5) and slot0:GetLevelHighScore(slot5) == nil and slot0:CheckLevelCost(slot5) then
			return true
		end
	end

	return false
end

function slot0.GetLastSelectedPlayer(slot0)
	return slot0.lastSelectPlayer
end

function slot0.SetLastSelectedPlayer(slot0, slot1)
	saveData("snowball", "lastSelectedPlayer", slot1)

	slot0.lastSelectPlayer = slot1
end

function slot0.IsFirstEnterGame(slot0)
	return slot0.lastEnter == nil or slot0.lastEnter < ActivityData:GetActivityData(slot0.activityID).startTime
end

function slot0.SetAlreadyEnter(slot0)
	slot0.lastEnter = manager.time:GetServerTime()

	saveData("snowball", "lastEnter", slot0.lastEnter)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_2_6_SNOWBALL_NOT_YET_ENTERED, 0)
end

function slot0.GetLevelHighScore(slot0, slot1)
	return slot0.unlockedLevels[slot1]
end

function slot0.OnLevelClear(slot0, slot1, slot2)
	slot4 = slot0.unlockedLevels[slot1] or 0
	slot0.unlockedLevels[slot1] = math.max(slot4, slot2)

	return slot0.unlockedLevels[slot1] == nil, slot2 > slot4
end

function slot0.CheckAlreadyShowInGameTip(slot0, slot1)
	return getData("snowballInGameTips", slot1)
end

function slot0.InGameTipClose(slot0, slot1)
	saveData("snowballInGameTips", slot1, true)
end

slot0.InGameTips = {
	Shoot = "shoot",
	Move = "move"
}

return slot0
