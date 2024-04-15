manager.net:Bind(76301, function (slot0)
	IndiaNianData:UpdateNianData(slot0)
	uv0.InitIndiaNianRedPoint()
	manager.notify:CallUpdateFunc(INDIA_NIAN_UPDATE_DATA)
end)
manager.net:Bind(76303, function (slot0)
	IndiaNianData:UpdateNianData(slot0)
	uv0.UpdateIndiaNianRedPoint()
	manager.notify:CallUpdateFunc(INDIA_NIAN_UPDATE_DATA)
end)
manager.net:Bind(76305, function (slot0)
	IndiaNianData:UpdateNianData(slot0)
	uv0.UpdateIndiaNianRedPoint()
	manager.notify:CallUpdateFunc(INDIA_NIAN_UPDATE_DATA)
end)

return {
	SendGetNianData = function (slot0)
		manager.net:SendWithLoadingNew(76302, {
			activity_id = slot0
		}, 76303, uv0.GetNianDataResultHandler)
	end,
	GetNianDataResultHandler = function (slot0, slot1)
		if isSuccess(slot0.result) then
			IndiaNianData:UpdateNianData(slot0)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	IsActivityTime = function ()
		slot0 = ActivityData:GetActivityData(IndiaNianData:GetActivityID())

		if manager.time:GetServerTime() < slot0.stopTime and slot0.startTime < manager.time:GetServerTime() then
			return true
		end

		return false
	end,
	InitIndiaNianRedPoint = function ()
		manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
			uv0.UpdateIndiaNianRedPoint()
		end)
		manager.redPoint:addGroup(ActivityTools.GetRedPointKey(IndiaNianData:GetActivityID()) .. IndiaNianData:GetActivityID(), {
			RedPointConst.ACTIVITY_INDIA_NIAN_REWARD,
			RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK
		})
		manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_REWARD, IndiaNianData:GetHasCompeletedTask() and uv0.IsActivityTime() and 1 or 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, IndiaNianData:GetHasUnlockBuff() and uv0.IsActivityTime() and 1 or 0)
	end,
	UpdateIndiaNianRedPoint = function ()
		manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_REWARD, IndiaNianData:GetHasCompeletedTask() and uv0.IsActivityTime() and 1 or 0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, IndiaNianData:GetHasUnlockBuff() and uv0.IsActivityTime() and 1 or 0)
	end
}
