manager.net:Bind(11080, function (slot0)
	SevenDaySkinData:InitData(slot0)
end)
manager.notify:RegistListener(NEW_DAY, function ()
	SevenDaySkinData:Clear()
	manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_CLEAR)
end)

return {
	ReqSign = function (slot0)
		manager.net:SendWithLoadingNew(11081, {
			activity_id = slot0
		}, 11082, uv0.OnSignResp)
	end,
	OnSignResp = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			return
		end

		slot2 = slot1.activity_id

		SevenDaySkinData:UpdateActivityData(slot2, slot0)

		if slot2 == ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW then
			NorseSurpriseGiftReceiveData:UpdateRedPointData(ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
		end

		manager.notify:Invoke(SEVEN_DAY_SKIN_SIGN_SUCCESS, slot0)
	end
}
