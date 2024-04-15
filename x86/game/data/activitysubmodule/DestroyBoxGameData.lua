slot0 = singletonClass("DestroyBoxGameData")
slot0.CHALLENGE_MAX_HARD_LEVEL = 2
slot0.SPECTIAL_HARD_LEVEL = 9

function slot0.Init(slot0)
	slot0.boxStageData_ = {}
	slot0.receiveRewardList_ = {}
	slot0.boxDifficultList_ = {}

	slot0:ParseCfg()

	slot0.curSelectID_ = {}
	slot0.curSelectDifficult_ = {}
	slot0.lastSelectNormalID_ = {}
end

function slot0.ParseCfg(slot0)
	for slot4, slot5 in pairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id) do
		slot0.boxDifficultList_[slot4] = {}

		for slot9, slot10 in ipairs(slot5) do
			if slot0.boxDifficultList_[slot4][DestroyBoxGameCfg[slot10].difficult] == nil then
				slot0.boxDifficultList_[slot4][slot12] = {}
			end

			table.insert(slot0.boxDifficultList_[slot4][slot12], slot10)
		end
	end
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.main_activity_id

	for slot6, slot7 in ipairs(slot1.stage_info_list) do
		slot0.boxStageData_[slot7.id] = {
			isSuccess = slot7.is_success,
			maxScore = slot7.history_max_score
		}
	end

	slot0.receiveRewardList_[slot2] = {}

	for slot6, slot7 in ipairs(slot1.got_reward_id_list) do
		table.insert(slot0.receiveRewardList_[slot2], slot7)
	end

	DestroyBoxGameAction.UpdateAllRedPoint(slot2)
	slot0:UpdateRewardRedPoint(slot2)
end

function slot0.GetDifficultList(slot0, slot1)
	return slot0.boxDifficultList_[slot1]
end

function slot0.GetStageData(slot0, slot1)
	return slot0.boxStageData_[slot1]
end

function slot0.GetReceiveRewardList(slot0, slot1)
	return slot0.receiveRewardList_[slot1]
end

function slot0.UpdateReceiveRewardList(slot0, slot1, slot2)
	table.insertto(slot0.receiveRewardList_[slot1], slot2)
	slot0:UpdateRewardRedPoint(slot1)
end

function slot0.UpdateRewardRedPoint(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(DestroyBoxGameRewardCfg.get_id_list_by_main_activity_id[slot1]) do
		slot9 = 0

		if DestroyBoxGameTools.IsUnlockReward(slot7) and not table.keyof(slot0.receiveRewardList_[slot1], slot7) then
			if DestroyBoxGameRewardCfg[slot7].need_show == 1 then
				slot2 = 1
			else
				slot9 = 1
			end
		end

		if slot8.need_show ~= 1 then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, slot8.activity_id), slot9)
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, slot1), slot2)
end

function slot0.IsClearStage(slot0, slot1)
	return slot0.boxStageData_[slot1] and slot0.boxStageData_[slot1].isSuccess or false
end

function slot0.IsFinishPreStage(slot0, slot1)
	slot2 = DestroyBoxGameCfg[slot1]
	slot3 = slot2.main_activity_id

	if slot2.unlock_condition ~= "" then
		if slot0.boxStageData_[slot2.unlock_condition[1]] and slot0.boxStageData_[slot4].isSuccess and slot2.unlock_condition[2] <= slot0.boxStageData_[slot4].maxScore then
			return true
		end

		return false
	end

	return true
end

function slot0.RefreshScore(slot0, slot1)
	slot3 = slot1.settle_score

	if slot0.boxStageData_[slot1.id] then
		slot0.boxStageData_[slot2].historyMaxScore = slot0.boxStageData_[slot2].maxScore

		if slot0.boxStageData_[slot2].maxScore < slot3 then
			slot0.boxStageData_[slot2].maxScore = slot3
		end

		slot0.boxStageData_[slot2].score = slot1.settle_score
	else
		slot0.boxStageData_[slot1.id] = {
			isSuccess = true,
			historyMaxScore = 0,
			maxScore = slot3,
			score = slot1.settle_score
		}
	end

	slot4 = DestroyBoxGameCfg[slot1.id].main_activity_id

	DestroyBoxGameAction.UpdateAllRedPoint(slot4)
	slot0:UpdateRewardRedPoint(slot4)
end

function slot0.SwitchDifficult(slot0, slot1, slot2)
	if DestroyBoxGameCfg[slot1].difficult <= uv0.CHALLENGE_MAX_HARD_LEVEL then
		slot1 = DestroyBoxGameCfg.get_id_list_by_activity_id[slot3.activity_id][slot2]
	else
		slot4 = slot3.main_activity_id
		slot7 = DestroyBoxGameCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[slot0:GetLastSelectNormalID(slot4)].activity_id][slot2]
		slot0.lastSelectNormalID_[slot4] = slot7

		saveData("destroyBoxGame", string.format("lastSelectNormalID_", slot4), slot7)
	end

	return slot1
end

function slot0.SetSelectIDAndDifficult(slot0, slot1, slot2, slot3)
	slot0.curSelectID_[slot1] = slot2

	saveData("destroyBoxGame", string.format("id_%s", slot1), slot2)

	slot0.curSelectDifficult_[slot1] = slot3 or slot0.curSelectDifficult_[slot1] or 1

	if DestroyBoxGameCfg[slot2].difficult <= uv0.CHALLENGE_MAX_HARD_LEVEL then
		slot0.lastSelectNormalID_[slot1] = slot2

		saveData("destroyBoxGame", string.format("lastSelectNormalID_", slot1), slot2)
	end
end

function slot0.GetSelectID(slot0, slot1)
	slot0.curSelectID_[slot1] = slot0.curSelectID_[slot1] or getData("destroyBoxGame", string.format("id_%s", slot1)) or slot0:GetCurMaxStageID(slot1)

	return slot0.curSelectID_[slot1]
end

function slot0.GetSelectDifficult(slot0, slot1)
	if slot0.curSelectDifficult_[slot1] then
		return slot0.curSelectDifficult_[slot1]
	end

	slot2 = slot0:GetLastSelectNormalID(slot1)
	slot4 = table.keyof(DestroyBoxGameCfg.get_id_list_by_activity_id[DestroyBoxGameCfg[slot2].activity_id], slot2) or 1
	slot0.curSelectDifficult_[slot1] = slot4

	return slot4
end

function slot0.GetLastSelectNormalID(slot0, slot1)
	slot0.lastSelectNormalID_[slot1] = slot0.lastSelectNormalID_[slot1] or getData("destroyBoxGame", string.format("lastSelectNormalID_", slot1)) or slot0:GetCurMaxNormalStageID(slot1)

	return slot0.lastSelectNormalID_[slot1]
end

function slot0.GetCurMaxStageID(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[slot1]) do
		if slot6 == 1 and not slot0:IsFinishFirstStage(DestroyBoxGameCfg[slot7].activity_id) then
			return 1
		end

		if not slot0:IsFinishPreStage(slot7) then
			return slot2
		end

		slot2 = slot7
	end

	return slot2
end

function slot0.GetCurMaxNormalStageID(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[slot1]) do
		if slot6 == 1 and not slot0:IsFinishFirstStage(DestroyBoxGameCfg[slot7].activity_id) then
			return 1
		end

		if DestroyBoxGameCfg[slot7].difficult <= uv0.CHALLENGE_MAX_HARD_LEVEL then
			if not slot0:IsFinishPreStage(slot7) then
				return slot7
			end

			slot2 = slot7
		end
	end

	return slot2
end

function slot0.IsFinishFirstStage(slot0, slot1)
	for slot5, slot6 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[slot1]) do
		if slot0.boxStageData_[slot6] and slot0.boxStageData_[slot6].isSuccess then
			return true
		end
	end

	return false
end

return slot0
