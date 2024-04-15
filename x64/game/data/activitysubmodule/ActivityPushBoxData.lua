slot0 = singletonClass("ActivityPushBoxData")
slot1 = {}
slot2 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
end

function slot0.SetCakeData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = {
		activityID = slot2,
		cakeID = slot1.cake_id,
		sign = slot1.sign
	}
end

function slot0.SetActivityData(slot0, slot1)
	slot2 = slot1.activity_id
	uv0[slot2] = {
		activityID = slot2,
		fatigue = slot1.value,
		hadRefresh = slot1.refresh_times,
		battleList = slot1.battle_order_list,
		pushBoxFinishList = slot1.finish_mission or {},
		pushBoxList = {},
		pushBoxLockList = {},
		emptyIndexList = {}
	}
end

function slot0.ReBuild(slot0, slot1)
	if not uv0[slot1] then
		return
	end

	slot3 = slot2.pushBoxFinishList or {}
	slot2.pushBoxList, slot2.pushBoxLockList = slot0:GetReadyAndLockList(slot1, slot3)
	slot2.emptyIndexList = slot0:GetEmptyList(slot1, slot3)
end

function slot0.GetEmptyList(slot0, slot1, slot2)
	slot3 = slot0:GetIndexMap(slot1)
	slot4 = {
		[slot9] = true
	}

	for slot8, slot9 in ipairs(slot2) do
		-- Nothing
	end

	slot6 = {}

	for slot10, slot11 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[slot1]) do
		if ActivityCelebrationOrderCfg[slot11].type == 2 and slot0:FindEndIndex(slot11, slot4, slot3) then
			table.insert(slot6, slot11)
		end
	end

	return slot6
end

function slot0.FindEndIndex(slot0, slot1, slot2, slot3)
	if not slot2[slot1] then
		return false
	end

	if not slot3[slot1] then
		return true
	end

	if slot2[slot4] then
		return false
	end

	if ActivityData:GetActivityData(ActivityCelebrationOrderCfg[slot4].activity_id):IsActivitying() then
		return false
	else
		return true
	end
end

function slot0.GetIndexMap(slot0, slot1)
	for slot7, slot8 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[slot1]) do
		if ActivityCelebrationOrderCfg[slot8].type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
			-- Nothing
		end
	end

	return {
		[slot9.pre_id] = slot8
	}
end

function slot0.GetReadyAndLockList(slot0, slot1, slot2)
	slot3 = ActivityCelebrationOrderCfg.get_id_list_by_main_activity[slot1]
	slot4 = {}
	slot5 = {}
	slot6 = {
		[slot11] = true
	}

	for slot10, slot11 in ipairs(slot2) do
		slot12 = ActivityCelebrationOrderCfg[slot11]
	end

	for slot10, slot11 in ipairs(slot3) do
		if ActivityCelebrationOrderCfg[slot11].type == PushBoxConst.EVENT_TYPE.PUSH_BOX and not slot6[slot11] and ActivityData:GetActivityData(slot12.activity_id):IsActivitying() then
			if slot6[slot12.pre_id] or slot15 == 0 then
				table.insert(slot4, slot11)
			else
				table.insert(slot5, slot11)
			end
		end
	end

	return slot4, slot5
end

function slot0.FinishPushBox(slot0, slot1, slot2)
	slot3 = uv0[slot1]
	slot5 = slot3.pushBoxLockList
	slot6 = slot3.pushBoxList

	table.insert(slot3.pushBoxFinishList, slot2)
	table.remove(slot6, table.indexof(slot6, slot2))

	if not slot0:GetIndexMap(slot1)[slot2] then
		table.insert(slot3.emptyIndexList, slot2)
	elseif not ActivityData:GetActivityData(ActivityCelebrationOrderCfg[slot9].activity_id):IsActivitying() then
		table.insert(slot8, slot2)
	else
		table.insert(slot6, slot9)
	end
end

function slot0.GetCurIndex(slot0, slot1)
	if uv0[slot1] then
		return ActivityCelebrationCakeCfg[uv0[slot1].cakeID] and slot3.level or 0
	end

	return 0
end

function slot0.GetFatigue(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].fatigue
	end

	return 0
end

function slot0.ModifyFatigue(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].fatigue = uv0[slot1].fatigue + slot2
	end
end

function slot0.GetMapEventList(slot0, slot1)
	slot2 = {}

	table.insertto(slot2, uv0[slot1].battleList)
	table.insertto(slot2, uv0[slot1].pushBoxList)

	return slot2
end

function slot0.GetPushBoxEmptyList(slot0, slot1)
	return uv0[slot1].emptyIndexList
end

function slot0.GetFinishList(slot0, slot1)
	return uv0[slot1].pushBoxFinishList
end

function slot0.GetRefreshTime(slot0, slot1)
	for slot6, slot7 in ipairs(GameSetting.activity_push_box_refresh_time.value) do
		if slot7[1] == slot1 then
			return slot7[2] - uv0[slot1].hadRefresh
		end
	end
end

function slot0.IsHadMade(slot0, slot1)
	return uv0[slot1] and uv0[slot1].sign == 1 or false
end

function slot0.GetNextID(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[slot1]) do
		if ActivityCelebrationOrderCfg[slot8].type == PushBoxConst.EVENT_TYPE.PUSH_BOX and slot9.pre_id == slot2 then
			return slot8
		end
	end

	return 0
end

return slot0
