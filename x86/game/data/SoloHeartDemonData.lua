slot0 = singletonClass("SoloHeartDemonData")
slot1 = {
	Init = function (slot0)
		slot0.taskData = {}
		slot0.maxExtremelyDodgeTimes = 0
		slot0.shortestBattleTime = uv0
		slot0.maxScore = 0
		slot0.minInjure = uv0
		slot0.rewardList = {}
		slot0.stageToDifficulty = {}

		for slot4, slot5 in ipairs(SoloHeartDemonCfg.all) do
			for slot10, slot11 in ipairs(SoloHeartDemonCfg[slot5].stage_id) do
				slot0.stageToDifficulty[slot11[2]] = slot11[1]
			end
		end

		slot0.normalTaskList = {}
		slot0.rankTaskList = {}
		slot0.maxCompleteDifficulty = 0

		for slot4, slot5 in ipairs(SoloHeartDemonRewardCfg.get_id_list_by_reward_type[1]) do
			table.insert(slot0.normalTaskList, slot5)
		end

		for slot4, slot5 in ipairs(SoloHeartDemonRewardCfg.get_id_list_by_reward_type[0]) do
			table.insert(slot0.rankTaskList, slot5)
		end
	end,
	InitSoloHeartDemonData = function (slot0, slot1)
		slot0.maxExtremelyDodgeTimes = 0
		slot0.shortestBattleTime = uv0
		slot0.maxScore = 0
		slot0.maxCompleteDifficulty = 0
		slot0.minInjure = uv0
		slot0.rewardList = {}
		slot0.openEditor = SoloHeartDemonCfg.get_id_list_by_activity_id[slot1.open_edition]

		if slot0.openEditor ~= nil then
			slot0.openEditor = slot0.openEditor[1]
		end

		slot0.difficultyData = slot0:ParseDifficultyData(slot1.info_list)
		slot0.challengeStage = slot1.challenge_stage

		for slot5, slot6 in ipairs(slot1.obtained_reward_list) do
			slot0.rewardList[slot6] = 1
		end

		slot0:UpdateData()
		slot0:TaskSort()
		SoloHeartDemonAction.UpdateRewardRedPoint()
	end,
	UpdateData = function (slot0)
		for slot4, slot5 in pairs(slot0.difficultyData) do
			slot0.maxExtremelyDodgeTimes = math.max(slot0.maxExtremelyDodgeTimes, slot5.maxExtremelyDodgeTimes)
			slot0.shortestBattleTime = math.min(slot0.shortestBattleTime, slot5.shortestBattleTime)
			slot0.maxScore = math.max(slot0.maxScore, slot5.maxScore)
			slot0.maxCompleteDifficulty = slot5.challengeState == 2 and slot4 or slot0.maxCompleteDifficulty
			slot0.minInjure = math.min(slot0.minInjure, slot5.minInjure)
		end
	end,
	UpdateRewardList = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot1.reward_list) do
			slot0.rewardList[slot6] = 1
		end
	end,
	ResetSelectDifficulty = function (slot0)
		slot0.selectDifficulty = nil
	end,
	UpdateBattleFinishData = function (slot0, slot1)
		if slot0.challengeStage == 1 then
			ShowTips("SOLO_HEART_DEMON_COMBAT_TIME_OUT")

			return
		end

		slot9.challengeState = slot0.difficultyData[slot0.stageToDifficulty[slot1[7]]].challengeState == 2 and 2 or slot1[1]
		slot9.maxExtremelyDodgeTimes = (slot1[5] or 0) + slot9.maxExtremelyDodgeTimes
		slot9.hitTime = math.min(slot1[6] or uv0, slot9.hitTime)
		slot9.shortestBattleTime = math.min(slot1[2] or uv0, slot9.shortestBattleTime)
		slot9.maxScore = math.max(slot1[3] or 0, slot9.maxScore)
		slot9.minInjure = math.min(slot1[4] or uv0, slot9.minInjure)
		slot0.selectDifficulty = slot8

		slot0:UpdateData()
		slot0:TaskSort()
		SoloHeartDemonAction.UpdateRewardRedPoint()
	end,
	ParseDifficultyData = function (slot0, slot1)
		slot2 = {
			[slot6] = slot0:DefaultData()
		}

		for slot6 = 1, 3 do
		end

		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot7.difficulty
			slot2[slot8].difficulty = slot7.difficulty
			slot2[slot8].challengeState = slot7.challenge_state
			slot2[slot8].maxExtremelyDodgeTimes = slot7.max_extremely_dodge_times

			if slot7.challenge_state == 2 then
				slot2[slot8].shortestBattleTime = slot7.shortest_battle_clear_time
				slot2[slot8].maxScore = slot7.max_score
				slot2[slot8].minInjure = slot7.least_injure_num
				slot2[slot8].hitTime = slot7.least_hit_num
			end
		end

		return slot2
	end,
	DefaultData = function (slot0)
		return {
			difficulty = 0,
			maxScore = 0,
			challengeState = 0,
			maxExtremelyDodgeTimes = 0,
			shortestBattleTime = uv0,
			minInjure = uv0,
			hitTime = uv0
		}
	end,
	GetTaskStatus = function (slot0, slot1)
		slot4 = 0

		if ConditionCfg[SoloHeartDemonRewardCfg[slot1].condition].type == 11001 then
			slot4 = slot3.params[1] <= slot0.maxCompleteDifficulty and 1 or 0
			slot0.taskData[slot1] = {
				slot3.params[1] <= slot0.maxCompleteDifficulty and 1 or 0,
				1
			}
		elseif slot3.type == 11002 then
			slot4 = slot0.difficultyData[slot3.params[1]].challengeState > 0 and 1 or 0
			slot0.taskData[slot1] = {
				slot0.difficultyData[slot3.params[1]].challengeState > 0 and 1 or 0,
				1
			}
		elseif slot3.type == 11003 then
			slot4 = slot0.shortestBattleTime < slot3.params[1] and 1 or 0
			slot0.taskData[slot1] = {
				slot0.shortestBattleTime < slot3.params[1] and 1 or 0,
				1
			}
		elseif slot3.type == 11004 then
			slot4 = slot3.params[1] < slot0.maxExtremelyDodgeTimes and 1 or 0
			slot0.taskData[slot1] = {
				slot3.params[1] <= slot0.maxExtremelyDodgeTimes and slot3.params[1] or slot0.maxExtremelyDodgeTimes,
				slot3.params[1]
			}
		elseif slot3.type == 11005 then
			slot4 = slot3.params[1] < slot0.maxScore and 1 or 0
			slot0.taskData[slot1] = {
				slot3.params[1] < slot0.maxScore and 1 or 0,
				1
			}
		end

		return slot0.rewardList[slot1] and 0 or 1 + slot4
	end,
	UpdateBattleFinishScore = function (slot0, slot1)
		slot0.battleScore = slot1
	end,
	TaskSort = function (slot0)
		table.sort(slot0.normalTaskList, function (slot0, slot1)
			if uv0:GetTaskStatus(slot0) ~= uv0:GetTaskStatus(slot1) then
				return slot3 < slot2
			end

			return slot1 < slot0
		end)
	end
}
slot2 = 999999999

function slot0.Init(slot0)
	uv0:Init()
end

function slot0.InitSoloHeartDemonData(slot0, slot1)
	uv0:InitSoloHeartDemonData(slot1)
end

function slot0.UpdateRewardList(slot0, slot1)
	uv0:UpdateRewardList(slot1)
	uv0:TaskSort()
end

function slot0.GetDataByPara(slot0, slot1)
	return uv0[slot1]
end

function slot0.ResetSelectDifficulty(slot0)
	uv0:ResetSelectDifficulty()
end

function slot0.UpdateBattleFinishData(slot0, ...)
	uv0:UpdateBattleFinishData({
		...
	})
end

function slot0.UpdateBattleFinishScore(slot0, slot1)
	uv0:UpdateBattleFinishScore(slot1)
end

return slot0
