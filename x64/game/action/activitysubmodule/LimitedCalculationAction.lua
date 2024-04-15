slot1 = false

return {
	Init = function ()
		if uv0 then
			return
		end

		uv0 = true

		LimitedCalculationData:Init()
		manager.net:Bind(60053, function (slot0)
			LimitedCalculationData:SetData(slot0.calculation)
			LimitedCalculationAction:RefreshRedPoint(slot0.calculation.activity_id)
		end)
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(RedPointConst.LIMITED_CALCULATION .. slot0, {
			RedPointConst.LIMITED_CALCULATION_OPEN .. slot0,
			RedPointConst.LIMITED_CALCULATION_REWARD .. slot0
		})
	end,
	OnReceivePointReward = function (slot0, slot1, slot2)
		LimitedCalculationData:SetRewardState(slot1, slot2)
		slot0:RefreshRewardRedPoint(slot1)
	end,
	RefreshRedPoint = function (slot0, slot1)
		if not ActivityData:GetActivityIsOpen(slot1) then
			manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. slot1, 0)
			manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. slot1, 0)

			return
		end

		slot0:RefreshActivityOpenRedPoint(slot1)
		slot0:RefreshRewardRedPoint(slot1)
	end,
	RefreshActivityOpenRedPoint = function (slot0, slot1)
		if not LimitedCalculationData:GetIsNeed(slot1) then
			return
		end

		if LimitedCalculationData:GetScore(slot1) and slot3 <= 0 then
			manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. slot1, 1)
		end
	end,
	RefreshRewardRedPoint = function (slot0, slot1)
		slot2 = nil

		for slot8, slot9 in ipairs(LimitedCalculationData:GetRewardList(slot1)) do
			if ActivityPointRewardCfg[slot9.id].need < LimitedCalculationData:GetScore(slot1) and slot9.complete_flag == ActivityConst.LIMITED_CALCULATION_REWARD_STATE.UNFINISHED then
				manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. slot1, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. slot1, 0)
	end,
	GetAllRewardAction = function (slot0, slot1)
		slot3 = {}
		slot6 = nil

		for slot10, slot11 in ipairs(LimitedCalculationData:GetRewardList(slot1)) do
			if slot11.complete_flag <= 0 and ActivityPointRewardCfg[slot11.id].need <= LimitedCalculationData:GetScore(slot1) then
				table.insert({}, slot11)
				table.insert(slot3, slot11.id)
			end
		end

		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = slot3
		}, 60055, function (slot0, slot1)
			if isSuccess(slot0.result) then
				for slot5, slot6 in pairs(uv0) do
					LimitedCalculationData:SetRewardState(uv1, slot6.id)
				end

				getReward2(mergeReward2(slot0.reward_list))
				manager.notify:Invoke(ACTIVITY_REWARD_GET, {
					point_reward_id_list = slot1.point_reward_id_list
				})
				manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, slot1.point_reward_id_list)
				uv2:RefreshRewardRedPoint(uv1)
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
