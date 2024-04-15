slot0 = singletonClass("SpringPreheatData")

function slot0.Ctor(slot0)
	slot0.praySelectList_ = {}
	slot0.progressAcquired_ = {}
	slot0.lastWriteTime_ = 0
end

function slot0.InitData(slot0, slot1)
	slot0.activityId_ = slot1.activity_id
	slot0.letterStorage_ = slot1.letter_storage
	slot0.lastWriteTime_ = slot1.last_write_time
	slot0.progress_ = slot1.progress
	slot0.progressAcquired_ = {}
	slot0.praySelection_ = {}

	for slot5, slot6 in ipairs(slot0:GetPoolItemList()) do
		slot0.praySelection_[slot6] = false
	end

	slot0.praySelectList_ = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.select_reward_list) do
		table.insert(slot2, slot7.first_reward_id)
		table.insert(slot2, slot7.second_reward_id)
	end

	slot0:ModifyPraySelection(slot2)

	for slot6, slot7 in ipairs(slot0:GetProgressRewardList()) do
		slot0.progressAcquired_[slot7.id] = false
	end

	for slot6, slot7 in ipairs(slot1.got_point_id_list) do
		slot0:AcquireProgressReward(slot7)
	end
end

function slot0.GetLetterStorage(slot0)
	return slot0.letterStorage_ or 0
end

function slot0.SendLetter(slot0, slot1, slot2, slot3)
	slot0.letterStorage_ = slot0:GetLetterStorage() + 1
	slot0.lastWriteTime_ = manager.time:GetServerTime()
	slot0.progress_ = slot0.progress_ + slot0:GetLetterScore()
end

function slot0.GetProgressRewardList(slot0)
	if not slot0.progressRewardList_ then
		slot0.progressRewardList_ = {}

		for slot4, slot5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot0:GetActivityId()] or {}) do
			table.insert(slot0.progressRewardList_, ActivityPointRewardCfg[slot5])
		end
	end

	return slot0.progressRewardList_
end

function slot0.GetProgressRewardScore(slot0)
	return slot0.progress_ or 0
end

function slot0.GetMaxPrgressRewardScore(slot0)
	if not slot0.progressRewardMaxScore then
		slot0.progressRewardMaxScore = 0

		for slot4, slot5 in pairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot0:GetActivityId()] or {}) do
			slot0.progressRewardMaxScore = math.max(slot0.progressRewardMaxScore, ActivityPointRewardCfg[slot5].need)
		end
	end

	return slot0.progressRewardMaxScore
end

function slot0.CanAcquire(slot0, slot1)
	return ActivityPointRewardCfg[slot1].need <= slot0:GetProgressRewardScore()
end

function slot0.IsAcquired(slot0, slot1)
	return slot0.progressAcquired_[slot1]
end

function slot0.AcquireProgressReward(slot0, slot1)
	slot0.progressAcquired_[slot1] = true
end

function slot0.HasRewardCanAcquire(slot0)
	for slot4, slot5 in ipairs(slot0:GetProgressRewardList()) do
		if slot0:CanAcquire(slot5.id) and not slot0:IsAcquired(slot5.id) then
			return true
		end
	end

	return false
end

function slot0.GetPoolItemList(slot0)
	return ActivityRewardPoolItemCfg.get_id_list_by_activity_id[slot0:GetPoolId()]
end

function slot0.GetPoolId(slot0)
	if not slot0.poolId_ then
		slot0.poolId_ = KagutsuchiGachaData:GetPoolIds(slot0:GetWelfareActivityId())[1]
	end

	return slot0.poolId_
end

function slot0.ModifyPraySelection(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.praySelection_[slot6] = true
	end

	table.insertto(slot0.praySelectList_, slot1)
end

function slot0.GetPraySelectionList(slot0, slot1)
	slot2 = 2

	if 1 + slot2 * (slot1 - 1) + slot2 - 1 > #slot0.praySelectList_ then
		return {
			0,
			0
		}
	end

	slot5 = {}

	for slot9 = slot3, slot4 do
		table.insert(slot5, slot0.praySelectList_[slot9])
	end

	return slot5
end

function slot0.GetPraySelectionFullList(slot0)
	return slot0.praySelectList_
end

function slot0.IsSelected(slot0, slot1)
	return table.indexof(slot0.praySelectList_, slot1)
end

function slot0.GetNextSelectionIndex(slot0)
	return slot0:GetCurSelectionDay() + 1
end

function slot0.GetCurSelectionDay(slot0)
	return #slot0.praySelectList_ / 2
end

function slot0.GetActivityDay(slot0)
	return math.max(manager.time:DiffDay(ActivityData:GetActivityData(slot0:GetActivityId()).startTime, manager.time:GetServerTime()) + 1, 1)
end

function slot0.GetActivityTotalDay(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityId())

	return manager.time:DiffDay(slot1.startTime, slot1.stopTime)
end

function slot0.GetDayState(slot0, slot1)
	slot3 = slot0:GetNextSelectionIndex()

	if slot0:GetLetterStorage() < slot1 then
		return ({
			LOCKED = 1,
			SELECTABLE = 3,
			SELECTED = 4,
			NOT_READY = 2
		}).LOCKED
	elseif slot3 < slot1 then
		return slot2.NOT_READY
	elseif slot1 == slot3 then
		return slot2.SELECTABLE
	else
		return slot2.SELECTED
	end
end

function slot0.IsTodayWritten(slot0)
	slot1 = 86400
	slot2 = manager.time:GetNextFreshTime()

	return math.floor((slot2 - manager.time:GetServerTime()) / slot1) == math.floor((slot2 - slot0.lastWriteTime_) / slot1)
end

function slot0.GetActivityId(slot0)
	return slot0.activityId_ or 212531
end

function slot0.GetWelfareActivityId(slot0)
	return 222541
end

function slot0.GetSystemLetterList(slot0)
	if not slot0.systemLetterList_ then
		slot0.systemLetterList_ = {}
		slot4 = slot0

		for slot4, slot5 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[slot0.GetActivityId(slot4)]) do
			if ActivityBlessingLetterCfg[slot5].type == 1 then
				table.insert(slot0.systemLetterList_, slot5)
			end
		end
	end

	return slot0.systemLetterList_
end

function slot0.GetPlayerLetterList(slot0)
	if not slot0.playerLetterList_ then
		slot0.playerLetterList_ = {}
		slot4 = slot0

		for slot4, slot5 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[slot0.GetActivityId(slot4)]) do
			if ActivityBlessingLetterCfg[slot5].type == 2 then
				table.insert(slot0.playerLetterList_, slot5)
			end
		end
	end

	return slot0.playerLetterList_
end

function slot0.GetLetterCfg(slot0, slot1)
	return ActivityBlessingLetterCfg[slot1]
end

function slot0.GetPlayerLetter(slot0)
	return slot0:GetLetterCfg(slot0:GetPlayerLetterList()[1])
end

function slot0.GetLetterTitle(slot0, slot1)
	return slot0:GetLetterCfg(slot1).title
end

function slot0.GetLetterFixedText(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetLetterCfg(slot1)

	return slot0:GetLetterOptionList(slot1, slot2, slot3)[1]
end

function slot0.GetLetterOptionList(slot0, slot1, slot2, slot3)
	return slot0:GetLetterCfg(slot1).fixed_or_option_text_list[slot2][slot3]
end

function slot0.GetLetterOptionText(slot0, slot1, slot2, slot3, slot4)
	return slot0:GetLetterOptionList(slot1, slot2, slot3)[slot4]
end

function slot0.GetEnableOptionList(slot0, slot1, slot2)
	return slot0:GetLetterCfg(slot1).option_button_list[slot2]
end

function slot0.IsEnableOption(slot0, slot1, slot2, slot3)
	return slot0:GetEnableOptionList(slot1, slot2)[slot3] ~= 0
end

function slot0.GetLetterHeroId(slot0, slot1)
	return slot0:GetLetterCfg(slot1).hero_id
end

function slot0.GetLetterRewards(slot0, slot1)
	return slot0:GetLetterCfg(slot1).reward_list
end

function slot0.GetSentenceIdx(slot0, slot1, slot2)
	slot4 = 1

	for slot8 = 1, #SpringPreheatData:GetPlayerLetter().option_button_list[slot1] do
		if SpringPreheatData:IsEnableOption(slot3.id, slot1, slot8) then
			if slot4 == slot2 then
				return slot8
			end

			slot4 = slot4 + 1
		end
	end

	return -1
end

function slot0.GetOptionCount(slot0, slot1)
	for slot7 = 1, #SpringPreheatData:GetPlayerLetter().option_button_list[slot1] do
		if SpringPreheatData:IsEnableOption(slot2.id, slot1, slot7) then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.GetMaxProgress(slot0)
	return GameSetting.spring_preheat_2_8_progress_max.value[1]
end

function slot0.GetLetterScore(slot0)
	return GameSetting.spring_preheat_2_8_letter_getscore.value[1]
end

return slot0
