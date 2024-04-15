manager.net:Bind(76001, function (slot0)
	KagutsuchiFishingEventData:InitFromServer(slot0)
end)
manager.notify:RegistListener(NEW_DAY, function ()
	KagutsuchiFishingEventData.dailyGameCount = 0

	manager.notify:CallUpdateFunc("UpdateFishingGameCount")
end)

function slot1()
	if KagutsuchiWorkData then
		return KagutsuchiWorkData:GetStamina()
	end

	return 0
end

return {
	SendFishingSuccess = function (slot0, slot1)
		slot5 = math.max(0, math.min(GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1], GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] - uv0()))

		manager.net:SendWithLoadingNew(76006, {
			activity_id = KagutsuchiFishingEventData.GetInstance().activityID,
			fish_id = slot0
		}, 76007, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end

			KagutsuchiFishingEventData:OnFishingGameFinish(uv0, slot1)
			manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, uv0, slot1, slot1 and uv1 or 0, slot1 and KagutsuchiFishingEventData:GetRarity(uv0))

			if uv2 then
				uv2()
			end
		end)
	end
}
