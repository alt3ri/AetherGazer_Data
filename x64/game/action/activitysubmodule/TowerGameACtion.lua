manager.net:Bind(61075, function (slot0)
	TowerGameData:SetData(slot0)
	manager.notify:CallUpdateFunc(TOWERGAME_REFRESH)
end)
manager.net:Bind(61079, function (slot0)
	TowerGameData:SetSeverPoint(slot0.point)
end)

return {
	GetReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(61076, {
			point_id = slot1
		}, 61077, function (slot0, slot1)
			if isSuccess(slot0.result) then
				TowerGameData:GetReward(slot1.point_id)
				getReward2(slot0.reward_list)
				manager.notify:CallUpdateFunc(TOWERGAME_GETREWARD)
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
