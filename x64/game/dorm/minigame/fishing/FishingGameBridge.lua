function slot1(...)
	slot0 = {
		...
	}

	if uv0.waitTask then
		uv0.waitTask:Abort()
	end

	uv0.waitTask = DormCharacterActionManager.taskRunner:NewTask()

	uv0.waitTask:WaitForSec(1.6):Then(function ()
		manager.notify:CallUpdateFunc("EndFishingGame", unpack(uv0))

		uv1.waitTask = nil
	end)
	uv0.waitTask:Start()
	SDKTools.SendMessageToSDK("activity_kagutsuchi_fish", {
		activity_id = KagutsuchiFishingEventData.activityID,
		reward = slot0[1],
		result = slot0[2] and 1 or 2
	})
end

return {
	Enter = function (slot0)
		manager.ui:SetMainCamera("fishing")

		slot0.game = FishingGame.New()

		gameContext:Go("/kagutsuchiFishingGameEnter")
		manager.notify:RegistListener(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, uv0)
		slot0.game:Init()
	end,
	Exit = function (slot0)
		if uv0.waitTask then
			uv0.waitTask:Abort()
		end

		manager.notify:RemoveListener(KAGUTSUCHI_FISHING_EVENT_QTE_FINISH, uv1)
		slot0.game:Dispose()

		slot0.game = nil
	end
}
