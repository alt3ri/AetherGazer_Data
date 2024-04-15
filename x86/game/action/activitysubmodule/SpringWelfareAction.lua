manager.net:Bind(76411, function (slot0)
	SpringWelfareData:InitData(slot0)
	SpringWelfareAction:InitRedPoint(slot0)
	Timer.New(function ()
		SpringWelfareAction:UpdateRedPoint(uv0.activity_id)
	end, 1, 0):Start()
	manager.notify:CallUpdateFunc(ACTIVITY_SPRING_WELFARE_INIT)
end)

return {
	StartPray = function (slot0, slot1, slot2)
		slot3 = 0

		if SpringWelfareData:GetDayState(slot1) == SPRING_WELFARE_DAY_STATE_TYPE.NEED_SIGN then
			slot3 = 1
		elseif slot4 == SPRING_WELFARE_DAY_STATE_TYPE.CAN_PRAY then
			slot3 = 0
		else
			return
		end

		manager.net:SendWithLoadingNew(76414, {
			activity_id = SpringWelfareData:GetActivityId(),
			type = slot3
		}, 76415, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			SpringWelfareData:ModifyPrayedDay(uv0)
			uv1(uv0)
			getReward(slot0.reward_list or {})
		end)
	end,
	AcquireDailyPointReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot1
			}
		}, 60055, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			getReward2(mergeReward2(slot0.reward_list))
			SpringWelfareData:AcquireDailyPointReward(uv0)
			uv1()
		end)
	end,
	FetchAllLetterPlayerInfo = function (slot0)
		if SpringWelfareData:IsFetched() then
			return
		end

		slot1 = {}

		for slot5, slot6 in ipairs(SpringWelfareData:GetLetterList()) do
			if SpringWelfareData:GetLetterData(slot6).isPlayer then
				table.insert(slot1, slot7.playerId)
			end
		end

		manager.net:SendWithLoadingNew(32036, {
			user_id_list = slot1
		}, 32037, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			SpringWelfareData:RefreshLetterPlayerInfo(slot0.user_brief_list)
			SpringWelfareData:SetFetchState(true)
			manager.notify:CallUpdateFunc("OnLetterPlayerInfoFetched")
		end)
	end,
	AcquireLetterReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(76412, {
			activity_id = SpringWelfareData:GetActivityId(),
			day = slot1
		}, 76413, function (slot0, slot1)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)

				return
			end

			SpringWelfareData:AcquireLetterReward(uv0)
			getReward(slot0.reward_list or {})
			uv1()
		end)
	end,
	InitRedPoint = function (slot0, slot1)
		slot0.BannedRedPoint_ = slot0.BannedRedPoint_ or {}
		slot2 = slot1.activity_id
		slot0.activityId_ = slot2

		if not ActivityData:GetActivityIsOpen(slot2) then
			return
		end

		slot3 = ActivityTools.GetRedPointKey(slot2) .. slot2
		slot6 = {}

		table.insert(slot6, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, slot3))
		table.insert(slot6, string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, slot3))
		manager.redPoint:addGroup(slot3, slot6)

		if not slot0.registerEvent_ then
			manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
				uv0:UpdateRedPoint(uv0.activityId_)
			end)

			slot0.registerEvent_ = true
		end
	end,
	UpdateRedPoint = function (slot0, slot1)
		slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1
		slot3 = string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_LETTER, slot2)
		slot4 = string.format("%s_%s", RedPointConst.ACTIVITY_2_9_SPRING_WELFARE_REWARD, slot2)
		slot5 = 0

		for slot10, slot11 in ipairs(SpringWelfareData:GetSystemLetterIdList()) do
			if SpringWelfareData:GetLetterData(slot11).gotReward == false then
				slot5 = 1

				break
			end
		end

		slot7 = 0

		if SpringWelfareData:HasTaskCanAcquire() then
			slot7 = 1
		elseif not SpringWelfareData:IsTodayPtAcquired() and SpringWelfareData:IsTodayPtCanAcquire() then
			slot7 = 1
		end

		manager.redPoint:setTip(slot3, slot5)
		manager.redPoint:setTip(slot4, slot7)
	end,
	BanRedPoint = function (slot0, slot1)
		slot0.BannedRedPoint_[slot1] = true
	end
}
