slot0 = singletonClass("ActivityAccumulativeData")

function slot0.Init(slot0)
	slot0.activityID = 0
	slot0.drawNum = 0
	slot0.taskList = {}
end

function slot0.InitData(slot0, slot1)
	slot0.activityID = slot1.activity_id
	slot0.drawNum = slot1.point
	slot0.taskList = slot1.reward_list or {}

	slot0:UpdateRedPoint()
end

function slot0.RefreshData(slot0, slot1)
	if not table.indexof(slot0.taskList, slot1) then
		table.insert(slot0.taskList, slot1)
	end

	slot0:UpdateRedPoint()
end

function slot0.GetNum(slot0)
	return slot0.drawNum
end

function slot0.UpdateRedPoint(slot0)
	slot2 = false

	for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.activityID] or {}) do
		if ActivityPointRewardCfg[slot7].need <= slot0.drawNum and not table.indexof(slot0.taskList, slot7) then
			slot2 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ACCUMULATIVE .. "_" .. tostring(slot0.activityID), slot2 and 1 or 0)
end

function slot0.GetList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1] or {}) do
		if ActivityPointRewardCfg[slot8].need <= slot0.drawNum then
			-- Nothing
		end

		if table.indexof(slot0.taskList, slot8) then
			slot9.state = 2
		end

		table.insert(slot3, {
			state = 0,
			id = slot8,
			state = 1
		})
	end

	table.sort(slot3, function (slot0, slot1)
		return (ActivityPointRewardCfg[slot0.id] and ActivityPointRewardCfg[slot0.id].need or 0) < (ActivityPointRewardCfg[slot1.id] and ActivityPointRewardCfg[slot1.id].need or 0)
	end)

	return slot3
end

return slot0
