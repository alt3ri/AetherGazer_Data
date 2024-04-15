manager.net:Bind(12045, function (slot0)
	DailyFatigueData:InitData(slot0)
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, DailyFatigueData:GetRedCount())
end)
manager.notify:RegistListener(NEW_DAY, function ()
	DailyFatigueData:Clear()
	manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, 0)
end)

return {
	ReqGetFatigue = function (slot0)
		manager.net:SendWithLoadingNew(12046, {
			type = slot0
		}, 12047, uv0.OnReqResp)
	end,
	OnReqResp = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			return
		end

		DailyFatigueData:SetData(slot1.type, true)
		manager.redPoint:setTip(RedPointConst.DAILY_FATIGUE, DailyFatigueData:GetRedCount())
		manager.notify:CallUpdateFunc(GET_FATIGUE_SUCCESS, slot1.type)
	end
}
