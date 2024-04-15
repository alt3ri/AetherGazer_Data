slot0 = singletonClass("LimitedCalculationData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.SetData(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot1.activity_id] = {
			isNeed = true,
			score = 0,
			activityID = slot1.activity_id,
			lastDifficulty = getData("LimitedCalculation", "lastDifficulty" .. slot1.activity_id) or 1
		}
	end

	uv0[slot1.activity_id].clearActivityList = {}

	for slot5, slot6 in ipairs(slot1.clear_list or {}) do
		table.insert(uv0[slot1.activity_id].clearActivityList, slot6)
	end

	uv0[slot1.activity_id].score = math.max(uv0[slot1.activity_id].score, slot1.high_score)
	slot2 = {}

	if ActivityPointRewardCfg.get_id_list_by_activity_id[slot1.activity_id] then
		for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1.activity_id]) do
			slot2[slot7] = {
				complete_flag = 0,
				id = slot7
			}
		end
	end

	for slot6, slot7 in ipairs(slot1.got_reward_list) do
		if slot2[slot7] then
			slot2[slot7].complete_flag = 1
		end
	end

	uv0[slot1.activity_id].rewards = slot2
	uv0[slot1.activity_id].difficultyList = {}

	if ActivityData:GetActivityData(slot1.activity_id) then
		for slot7, slot8 in ipairs(slot3.subActivityIdList or {}) do
			if ActivityTemplateConst.LIMITED_DIFFICULTY == ActivityTools.GetActivityType(slot8) then
				table.insert(uv0[slot1.activity_id].difficultyList, slot8)
			end
		end
	end
end

function slot0.GetCurDifficulty(slot0, slot1)
	if uv0[slot1] == nil then
		print("activity data is null", slot1, debug.traceback())

		return 1
	end

	if (uv0[slot1].lastDifficulty or {}) == 1 then
		uv0[slot1].lastDifficulty = uv0[slot1].difficultyList[1]

		return uv0[slot1].difficultyList[1]
	else
		return slot2
	end
end

function slot0.SetCurDifficulty(slot0, slot1, slot2)
	uv0[slot1].lastDifficulty = slot2

	saveData("LimitedCalculation", "lastDifficulty" .. slot1, slot2)
	manager.notify:CallUpdateFunc(LIMITED_DIFFICULTY_CHANGE)
end

function slot0.GetDifficultyList(slot0, slot1)
	return uv0[slot1].difficultyList
end

function slot0.IsClearActivity(slot0, slot1, slot2)
	return table.keyof(uv0[slot1].clearActivityList, slot2)
end

function slot0.GetScore(slot0, slot1)
	return uv0[slot1] and uv0[slot1].score
end

function slot0.GetRewardList(slot0, slot1)
	if ActivityPointRewardCfg.get_id_list_by_activity_id[slot1] == nil then
		return {}
	end

	for slot6, slot7 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		table.insert(slot2, uv0[slot1] and uv0[slot1].rewards[slot7])
	end

	return slot2
end

function slot0.SetRewardState(slot0, slot1, slot2)
	uv0[slot1].rewards[slot2].complete_flag = ActivityConst.LIMITED_CALCULATION_REWARD_STATE.REWARDED
end

function slot0.GetIsNeed(slot0, slot1)
	return uv0[slot1] and uv0[slot1].isNeed
end

function slot0.SetIsNeed(slot0, slot1, slot2)
	if uv0[slot1].isNeed and slot2 == false then
		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. slot1, 0)
	end

	uv0[slot1].isNeed = slot2
end

return slot0
