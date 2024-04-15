slot0 = singletonClass("SpringPreheatData")
SPRING_WELFARE_DAY_STATE_TYPE = {
	ACQUIRED = 1,
	NEED_SIGN = 3,
	CAN_PRAY = 4,
	NOT_ACQUIRE = 2
}

function slot0.Ctor(slot0)
	slot0.prayedDays_ = {}
	slot0.letterData_ = {}
	slot0.systemLetterIdList_ = {}
	slot0.playerLetterIdList_ = {}
	slot0.userBriefInfo_ = {}
	slot0.newLetterIdList_ = {}
	slot0.newSystemLetterIdList_ = {}
	slot0.newPlayerLetterIdList_ = {}
	slot0.selectRewardList_ = {}
end

function slot0.InitData(slot0, slot1)
	slot0.prayedDays_ = {}
	slot0.letterData_ = {}
	slot0.systemLetterIdList_ = {}
	slot0.playerLetterIdList_ = {}
	slot0.userBriefInfo_ = {}
	slot0.newLetterIdList_ = {}
	slot0.newSystemLetterIdList_ = {}
	slot0.newPlayerLetterIdList_ = {}
	slot0.activityId_ = slot1.activity_id
	slot0.day = slot1.day
	slot0.resignNum_ = slot1.re_sign_num
	slot0.point_ = slot1.point
	slot0.gotPointRewardList_ = slot1.point_reward_list
	slot0.selectRewardList_ = {}

	for slot5, slot6 in ipairs(slot1.select_reward_list) do
		table.insertto(slot0.selectRewardList_, {
			slot6.first_reward_id,
			slot6.second_reward_id
		})
	end

	for slot5, slot6 in ipairs(slot1.receive_reward_list) do
		slot0.prayedDays_[slot6] = true
	end

	for slot5, slot6 in ipairs(slot1.system_letter) do
		slot7 = slot0:MakeLetterData(slot6)
		slot0.letterData_[slot7.serverId] = slot7

		table.insert(slot0.systemLetterIdList_, slot7.serverId)
	end

	for slot5, slot6 in ipairs(slot1.player_letter_list) do
		print(slot6.sticker_id_list, slot6.user_base_info, slot6.sticker_id_list, slot6.nick, " InitData")

		slot7 = slot0:MakeLetterData(slot6)
		slot0.letterData_[slot7.serverId] = slot7

		table.insert(slot0.playerLetterIdList_, slot7.serverId)
		slot0:RefreshLetterPlayerInfoSingle(slot6)
	end

	slot0.isFetched_ = false

	table.insert(slot0.newSystemLetterIdList_, slot0.systemLetterIdList_[1])
	table.insert(slot0.newPlayerLetterIdList_, slot0.playerLetterIdList_[#slot0.playerLetterIdList_])
end

function slot0.MakeLetterData(slot0, slot1)
	if ({
		letterId = slot1.letter_template_id,
		paragraphs = {}
	}).letterId == nil then
		if #slot0:GetSystemLetterCfgList() < slot1.day then
			Debug.LogError(string.format("第%d天系统祝福信没有对应的配置 现取第%d天的配置", slot1.day, #slot3))

			slot2.letterId = slot3[#slot3].id
		else
			slot2.letterId = slot3[slot1.day].id
		end
	end

	slot3 = SpringPreheatData:GetLetterCfg(slot2.letterId)
	slot2.rewardList = slot3.reward_list
	slot2.title = SpringPreheatData:GetLetterTitle(slot3.id)

	if slot3.type == 1 then
		slot2.isSystem = true
		slot2.heroId = slot3.hero_id
		slot2.serverId = slot1.day
		slot2.day = slot1.day
		slot2.gotReward = slot1.is_reward ~= 0
	elseif slot3.type == 2 then
		slot2.isPlayer = true
		slot2.playerId = slot1.user_id
		slot2.gotReward = true
		slot7 = slot1.user_id
		slot8 = slot1.id
		slot2.serverId = string.format("%s_%s", slot7, slot8)
		slot2.timestamp = slot1.id
		slot2.stickerList = {}

		for slot7, slot8 in ipairs(slot1.sticker_id_list) do
			table.insert(slot2.stickerList, {
				id = slot8
			})
		end
	end

	slot4 = slot1.optional_content_index
	slot5 = 1

	for slot9, slot10 in ipairs(slot3.option_button_list) do
		slot11 = ""

		for slot15, slot16 in ipairs(slot10) do
			slot17 = nil

			if slot16 ~= 0 then
				if slot4[slot5] == nil then
					slot18 = 1

					print("祝福信可选文本序号缺失！")
				end

				slot17 = SpringPreheatData:GetLetterOptionText(slot3.id, slot9, slot15, slot18)
				slot5 = slot5 + 1
			else
				slot17 = SpringPreheatData:GetLetterFixedText(slot3.id, slot9, slot15)
			end

			slot11 = slot11 .. GetTips(slot17)
		end

		slot2.paragraphs[slot9] = slot11
	end

	return slot2
end

function slot0.GetLetterData(slot0, slot1)
	return slot0.letterData_[slot1]
end

function slot0.GetLetterList(slot0)
	return slot0.letterData_
end

function slot0.GetNextNewSystemLetterId(slot0)
	return slot0.newSystemLetterIdList_[1]
end

function slot0.GetNextNewPlayerLetterId(slot0)
	return slot0.newPlayerLetterIdList_[1]
end

function slot0.GetPlayerLetterIdList(slot0)
	return slot0.playerLetterIdList_
end

function slot0.GetSystemLetterIdList(slot0)
	return slot0.systemLetterIdList_
end

function slot0.AcquireLetterReward(slot0, slot1)
	slot0.letterData_[slot1].gotReward = true
end

function slot0.GetPraySelectionList(slot0, slot1)
	slot2 = 2

	if 1 + slot2 * (slot1 - 1) + slot2 - 1 > #slot0.selectRewardList_ then
		return {
			0,
			0
		}
	end

	slot5 = {}

	for slot9 = slot3, slot4 do
		table.insert(slot5, slot0.selectRewardList_[slot9])
	end

	return slot5
end

function slot0.GetDayState(slot0, slot1)
	if slot0.prayedDays_[slot1] then
		return SPRING_WELFARE_DAY_STATE_TYPE.ACQUIRED
	end

	if slot1 < slot0:GetActivityDay() then
		return SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN
	elseif slot1 == slot2 then
		return SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY
	end

	return SPRING_WELFARE_DAY_STATE_TYPE.NOT_ACQUIRE
end

function slot0.ModifyPrayedDay(slot0, slot1)
	slot0.prayedDays_[slot1] = true
end

function slot0.GetActivityDay(slot0)
	return slot0.day
end

function slot0.GetCurPrayDay(slot0)
	slot1 = SpringPreheatData:GetMaxProgress()

	if slot0:GetDayState(math.min(slot0:GetActivityDay(), 7)) == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
		return slot2
	end

	for slot7 = 1, slot2 do
		if slot0:GetDayState(slot7) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			return slot7
		end
	end

	return slot2
end

function slot0.GetCurSignDay(slot0)
	slot1 = SpringPreheatData:GetMaxProgress()

	for slot6 = 1, slot0:GetActivityDay() do
		if slot0:GetDayState(slot6) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			return slot6
		end
	end

	return -1
end

function slot0.GetLetterParagText(slot0, slot1, slot2)
	return slot0:GetLetterData(slot1).paragraphs[slot2]
end

function slot0.DeleteLetter(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0.letterData_[slot6] = nil
	end
end

function slot0.GetPlayerInfo(slot0, slot1)
	return slot0.userBriefInfo_[slot1]
end

function slot0.IsFetched(slot0)
	return slot0.isFetched_ or true
end

function slot0.SetFetchState(slot0, slot1)
	slot0.isFetched_ = slot1
end

function slot0.RefreshLetterPlayerInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:RefreshLetterPlayerInfoSingle(slot6)
	end
end

function slot0.RefreshLetterPlayerInfoSingle(slot0, slot1)
	slot0.userBriefInfo_[slot1.user_id] = {
		uid = slot1.user_id,
		nick = slot1.user_base_info and slot1.user_base_info.nick,
		icon = slot1.user_base_info and slot1.user_base_info.icon,
		icon_frame = slot1.user_base_info and slot1.user_base_info.icon_frame,
		level = slot1.level
	}
end

function slot0.IsFriendOrInRequest(slot0, slot1)
	return FriendsData:IsFriend(slot1) or FriendsData:IsInRequest(slot1)
end

function slot0.GetPoolItemList(slot0)
	return SpringPreheatData:GetPoolItemList()
end

function slot0.GetPoolId(slot0)
	return SpringPreheatData:GetPoolId()
end

function slot0.GetPoolCost(slot0)
	return 53088, 1
end

function slot0.GetPoolSignCost(slot0)
	slot3 = {
		1,
		0
	}

	if slot0.resignNum_ >= #GameSetting.spring_festival_supplementary_sign.value then
		slot3 = slot2[#slot2]
	elseif slot1 >= 0 then
		slot3 = slot2[slot1 + 1]
	end

	return slot3[1], slot3[2]
end

function slot0.GetTodayPtCfg(slot0)
	if ActivityPointRewardCfg.get_id_list_by_activity_id[slot0:GetActivityId()][math.min(slot0.day, #slot0.gotPointRewardList_ + 1)] == nil then
		slot3 = slot2[1]

		Debug.LogError(string.format("SpringWelfare could not find pt cfg by index:%d, day:%d, got_reward_count:%d", slot1, slot0.day, #slot0.gotPointRewardList_))
	end

	return ActivityPointRewardCfg[slot3]
end

function slot0.IsTodayPtCanAcquire(slot0)
	return slot0:GetTodayPtCfg().need <= slot0:GetTodayPtProgress()
end

function slot0.IsTodayPtAcquired(slot0)
	return table.indexof(slot0.gotPointRewardList_, slot0:GetTodayPtCfg().id)
end

function slot0.HasTaskCanAcquire(slot0)
	slot6 = slot0

	for slot5, slot6 in ipairs(TaskData2:GetActivityTaskSortList(slot0.GetActivityId(slot6))) do
		if AssignmentCfg[slot6.id].need <= slot6.progress and not (slot6.complete_flag >= 1) then
			return true
		end
	end

	return false
end

function slot0.GetPtItemId(slot0)
	return 53089
end

function slot0.GetTodayPtProgress(slot0)
	return slot0.point_
end

function slot0.AddTodayPtProgress(slot0, slot1)
	slot0.point_ = slot0.point_ + slot1
end

function slot0.AcquireDailyPointReward(slot0, slot1)
	table.insert(slot0.gotPointRewardList_, slot1)
end

function slot0.GetActivityId(slot0)
	return slot0.activityId_ or 222541
end

function slot0.GetSystemLetterCfgList(slot0)
	if not slot0.systemLetterCfgList_ then
		slot0.systemLetterCfgList_ = {}
		slot4 = slot0:GetActivityId()

		for slot4, slot5 in pairs(ActivityBlessingLetterCfg.get_id_list_by_activity_id[slot4]) do
			if ActivityBlessingLetterCfg[slot5].type == 1 then
				table.insert(slot0.systemLetterCfgList_, slot6)
			end
		end
	end

	return slot0.systemLetterCfgList_
end

return slot0
