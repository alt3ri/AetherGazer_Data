manager.net:Bind(76401, function (slot0)
	SpringPreheatData:InitData(slot0)
	SpringPreheatAction:InitRedPoint(slot0)
end)

return {
	SendBlessingLetter = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(76402, {
			activity_id = SpringPreheatData:GetActivityId(),
			letter_id = SpringPreheatData:GetPlayerLetter().id,
			optional_content_index = slot2,
			sticker_id_list = slot3
		}, 76403, function (slot0, slot1)
			uv0:OnSendBlessingLetter(slot0, slot1, uv1)
		end)
	end,
	OnSendBlessingLetter = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			SpringPreheatData:SendLetter()
			slot3()
		else
			ShowTips(slot1.result)
		end
	end,
	UploadPraySelection = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(76404, {
			activity_id = SpringPreheatData:GetActivityId(),
			day = slot1,
			select_reward_list = {
				first_reward_id = slot2[1],
				second_reward_id = slot2[2]
			}
		}, 76405, function (slot0, slot1)
			uv0:OnUploadPraySelection(slot0, slot1, uv1)
		end)
	end,
	OnUploadPraySelection = function (slot0, slot1, slot2, slot3)
		if isSuccess(slot1.result) then
			SpringPreheatData:ModifyPraySelection({
				slot2.select_reward_list.first_reward_id,
				slot2.select_reward_list.second_reward_id
			})
			slot3()
		else
			ShowTips(slot1.result)
		end
	end,
	RequestProgressReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot1
			}
		}, 60055, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			SpringPreheatData:AcquireProgressReward(uv0)
			uv1(slot0)
		end)
	end,
	InitRedPoint = function (slot0, slot1)
		slot2 = slot1.activity_id
		slot0.activityId = slot2

		if not ActivityData:GetActivityIsOpen(slot2) then
			return
		end

		slot3 = ActivityTools.GetRedPointKey(slot2) .. slot2
		slot7 = {}

		table.insert(slot7, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, slot3))
		table.insert(slot7, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, slot3))
		table.insert(slot7, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, slot3))
		manager.redPoint:addGroup(slot3, slot7)
		slot0:UpdateRedPoint(slot2)
	end,
	UpdateRedPoint = function (slot0, slot1)
		slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1
		slot3 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, slot2)
		slot4 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, slot2)
		slot5 = string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, slot2)
		slot6 = SpringPreheatData:HasRewardCanAcquire()
		slot9 = SpringPreheatData:GetLetterStorage() ~= math.min(SpringPreheatData:GetMaxProgress(), SpringPreheatData:GetActivityTotalDay()) and not SpringPreheatData:IsTodayWritten()
		slot10 = false

		for slot15 = 1, SpringPreheatData:GetMaxProgress() do
			if SpringPreheatData:GetDayState(slot15) == 1 then
				break
			elseif slot16 == 2 or slot16 == 3 then
				slot10 = true

				break
			end
		end

		manager.redPoint:setTip(slot3, slot9 and 1 or 0)
		manager.redPoint:setTip(slot4, slot6 and 1 or 0)
		manager.redPoint:setTip(slot5, slot10 and 1 or 0)
	end,
	RefreshRedPoint = function (slot0)
		if slot0.activityId and not ActivityData:GetActivityIsOpen(slot0.activityId) then
			slot1 = ActivityTools.GetRedPointKey(slot0.activityId) .. slot0.activityId

			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, slot1), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, slot1), 0)
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, slot1), 0)

			return
		end
	end
}
