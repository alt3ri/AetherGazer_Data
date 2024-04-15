manager.net:Bind(61041, function (slot0)
	ActivityRaceData:SetData(slot0)
end)
manager.net:Bind(61045, function (slot0)
	ActivityRaceData:SetDropAffixes(slot0)
end)

return {
	RequireReceive = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(61042, {
			activity_id = slot0,
			reward_id = slot1
		}, 61043, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if uv0 ~= nil then
					uv0(slot0)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	InitRedPointKey = function (slot0)
		slot2 = {}
		slot3 = {}

		for slot7, slot8 in pairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
			slot2[#slot2 + 1] = string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot0, slot8)
			slot3[#slot3 + 1] = string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot0, slot8)
		end

		manager.redPoint:addGroup(string.format("%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot0), slot2)
		manager.redPoint:addGroup(string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot0), slot3)

		slot4 = {
			[#slot4 + 1] = string.format("%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot0),
			[#slot4 + 1] = string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot0)
		}

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_RACE, slot0), slot4)
	end,
	UpdateRedPoint = function (slot0)
		if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
			for slot6, slot7 in ipairs(ActivityData:GetActivityData(slot0).subActivityIdList) do
				manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, slot0, slot7), 0)
				manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, slot0, slot7), 0)
			end
		end
	end
}
