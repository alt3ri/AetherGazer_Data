slot0 = singletonClass("CombineGameData")
slot1 = {
	Init = function (slot0)
		slot0.stageDataTable = {}
	end,
	InitServerData = function (slot0, slot1)
		slot0.activityId = slot1.activity_id
		slot0.nowDay = slot1.daily_stage

		if slot1.score_of_endless then
			slot0.score = slot1.score_of_endless
		end

		for slot5, slot6 in ipairs(slot1.reward_list) do
			slot0.stageDataTable[slot6] = true
		end
	end,
	UpdateStageData = function (slot0, slot1)
		if slot1.score then
			slot0.score = math.max(slot1.score, slot0.score or 0)
		end

		slot0.stageDataTable[slot1.reward_id] = true
	end
}

function slot0.Init(slot0)
	uv0:Init()
end

function slot0.GetDataByPara(slot0, slot1)
	return uv0[slot1]
end

function slot0.InitServerData(slot0, slot1)
	uv0:InitServerData(slot1)
end

function slot0.UpdateStageData(slot0, slot1)
	uv0:UpdateStageData(slot1)
end

function slot0.CheckHeroLock(slot0, slot1, slot2)
	return ActivityCombineHeroCfg[slot2].unlock_condition[1][2] <= uv0.nowDay - 3 and slot1 == slot3.unlock_condition[1][1]
end

return slot0
