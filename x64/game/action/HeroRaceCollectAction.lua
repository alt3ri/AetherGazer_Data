manager.net:Bind(52025, function (slot0)
	HeroRaceCollectData:InitData(slot0)
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function (slot0)
	HeroRaceCollectData:NewHeroUnlock(slot0)
end)

return {
	ReceiveTaskReward = function (slot0)
		manager.net:SendWithLoadingNew(52022, {
			id_list = slot0
		}, 52023, uv0.OnGetRewardCallback)
	end,
	OnGetRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			getReward(mergeReward(slot0.item_list))
			HeroRaceCollectData:SetTasksReceived(slot1.id_list)
			manager.notify:Invoke(RACE_COLLECT_REWARD_GET, slot1.id_list)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	ReceiveOneTaskReward = function (slot0)
		uv0.ReceiveTaskReward({
			slot0
		})
	end,
	ReceiveAllTasksReward = function ()
		uv0.ReceiveTaskReward(HeroRaceCollectData:GetAllCanReceiveTasks())
	end
}
