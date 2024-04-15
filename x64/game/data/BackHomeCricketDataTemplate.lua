BackHomeCricketBattleResult = class("BackHomeCricketBattleResult")

function BackHomeCricketBattleResult.InitRoundList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = {
			roundIndex = slot7.round_index,
			myAction = slot0:InitActionOrder(slot7.attack_user_action),
			enemyAction = slot0:InitActionOrder(slot7.defend_user_action),
			myScore = slot0:InitScoreData(slot7.attack_user_score),
			enemyScore = slot0:InitScoreData(slot7.defend_user_score)
		}

		if slot2[slot7.round_index] then
			Debugger.LogError("有重复数据初始化，回合数为" .. slot7.round_index)

			return
		end

		slot2[slot7.round_index] = slot8
	end

	return slot2, #slot2
end

function slot0(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		table.insert(slot1, tonumber(slot6))
	end

	return slot1
end

function BackHomeCricketBattleResult.InitPrepareInfo(slot0, slot1)
	return {
		myActiveBuffList = uv0(slot1.attacker_active_buff_list),
		enemyActiveBuffList = uv0(slot1.defender_active_buff_list)
	}
end

function BackHomeCricketBattleResult.Ctor(slot0, slot1, slot2, slot3)
	slot0.settleType = slot3
	slot0.mySkinID = slot1.attacker_skin_id
	slot0.enemySkinID = slot1.defender_skin_id
	slot0.prepareInfo = slot0:InitPrepareInfo(slot1.prepare_info)
	slot0.roundList, slot0.lastRound = slot0:InitRoundList(slot1.round_list)

	if slot3 == BackHomeCricketConst.ROOM_TYPE.Video then
		slot0.stageID = slot1.stage_id
		slot0.battle_result = slot1.battle_result
		slot0.attacker_data = slot1.attacker_data
		slot0.defender_data = slot1.defender_data
		slot0.battleID = slot2.battle_id
		slot0.battleType = IdolTraineeData:GetHistoryBattleData()[slot0.battleID].friendType
	else
		slot0.stageID = slot2.stage_id
		slot0.battleType = slot2.battle_type
		slot0.enemyID = slot2.defender_uid
	end
end

function BackHomeCricketBattleResult.AddCompleteInfo(slot0, slot1, slot2)
	slot0.attacker_data = slot2.attacker_data
	slot0.defender_data = slot2.defender_data
	slot0.battle_result = slot2.battle_result
end

function BackHomeCricketBattleResult.InitActionOrder(slot0, slot1)
	slot2 = {
		actionID = slot1.atk_style_id,
		skillID = slot1.skill_id
	}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1.index_list) do
		table.insert(slot3, slot8)
	end

	slot2.effectList = slot3

	return slot2
end

function BackHomeCricketBattleResult.InitScoreData(slot0, slot1)
	return {
		type = slot1.peculiarity_score,
		actionScore = slot1.skill_score,
		isHit = slot1.sum_score
	}
end

function BackHomeCricketBattleResult.GetBattleDataByRound(slot0, slot1)
	if slot0.roundList and slot0.roundList[slot1] then
		return slot0.roundList[slot1]
	else
		Debugger.LogError("未获取对应回合数据" .. slot1)
	end
end

function BackHomeCricketBattleResult.Dispose(slot0)
end
