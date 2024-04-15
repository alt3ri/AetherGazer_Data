slot0 = singletonClass("EquipSeizureData")

function slot0.Init(slot0)
	slot0.stageID_ = nil
	slot0.challengeRate_ = 1
	slot0.affixIDList_ = {}
	slot0.receivedList_ = {}
	slot0.canReceiveList_ = {}
	slot0.affixRefreshTimestamp_ = 0
	slot0.todayMaxScore_ = 0
	slot0.sumScore_ = 0
	slot0.nextRefreshTimestamp_ = 0
end

function slot0.InitData(slot0, slot1)
	slot0.stageID_ = slot1.stage_id
	slot0.challengeRate_ = slot1.challenge_rate or 1
	slot0.affixRefreshTimestamp_ = slot1.affix_info.refresh_timestamp or 0
	slot0.affixIDList_ = {}

	for slot5, slot6 in ipairs(slot1.affix_info.affix_id_list) do
		table.insert(slot0.affixIDList_, slot6)
	end

	slot0.todayMaxScore_ = slot1.today_max_score or 0
	slot0.sumScore_ = slot1.sum_score or 0
	slot0.nextRefreshTimestamp_ = slot1.refresh_timestamp or 0
	slot0.receivedList_ = {}

	for slot5, slot6 in ipairs(slot1.got_reward_id_list) do
		table.insert(slot0.receivedList_, slot6)
	end

	slot0:CheckRedPoint()
	slot0:SortRewardList()
end

function slot0.RefreshBattleScore(slot0, slot1)
	slot0.isValid_ = slot1.is_valid
	slot0.resultScore_ = slot1.score or 0

	if slot1.is_valid and slot0.todayMaxScore_ < slot0.resultScore_ then
		slot0.todayMaxScore_ = slot0.resultScore_
		slot0.sumScore_ = slot1.sum_score or slot0.sumScore_

		slot0:CheckRedPoint()
		slot0:SortRewardList()
	end
end

function slot0.GetStageID(slot0)
	return slot0.stageID_
end

function slot0.GetChallengeRate(slot0)
	return slot0.challengeRate_
end

function slot0.GetAffixRefreshTimestamp(slot0)
	return slot0.affixRefreshTimestamp_
end

function slot0.GetAffixIDList(slot0)
	return slot0.affixIDList_
end

function slot0.GetTodayMaxScore(slot0)
	return slot0.todayMaxScore_
end

function slot0.GetTotalScore(slot0)
	return slot0.sumScore_
end

function slot0.NextRefreshTimestamp(slot0)
	return slot0.nextRefreshTimestamp_
end

function slot0.GetResultScore(slot0)
	return slot0.resultScore_
end

function slot0.GetCanReceiveList(slot0)
	return slot0.canReceiveList_
end

function slot0.GetReceiveList(slot0)
	return slot0.receivedList_
end

function slot0.GetSortRewardList(slot0)
	return slot0.sortRewardList_
end

function slot0.ReceiveReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.receivedList_, slot6)
	end

	slot0:CheckRedPoint()
	slot0:SortRewardList()
end

function slot0.SortRewardList(slot0)
	slot0.canReceiveList_ = {}
	slot1 = {}

	for slot6, slot7 in ipairs(EquipSeizurePointRewardCfg.all) do
		if slot0:GetTotalScore() < EquipSeizurePointRewardCfg[slot7].need then
			table.insert(slot1, slot7)
		elseif table.keyof(slot0.receivedList_, slot7) == nil then
			table.insert(slot0.canReceiveList_, slot7)
		end
	end

	slot3 = {}

	table.insertto(slot3, slot0.canReceiveList_)
	table.insertto(slot3, slot1)
	table.insertto(slot3, slot0.receivedList_)

	slot0.sortRewardList_ = slot3
end

function slot0.CheckRedPoint(slot0)
	for slot5, slot6 in ipairs(EquipSeizurePointRewardCfg.all) do
		if EquipSeizurePointRewardCfg[slot6].need <= slot0:GetTotalScore() and not table.keyof(slot0.receivedList_, slot6) then
			manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_REWARD, 0)
end

return slot0
