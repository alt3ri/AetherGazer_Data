manager.net:Bind(60201, function (slot0)
	ActivityAccumulativeData:InitData(slot0)
	manager.notify:Invoke(ACCUMULATIVEGACHA_UPDATE)
end)

return {
	GetAccumulateReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot0
			}
		}, 60055, function (slot0)
			if isSuccess(slot0.result) then
				getReward2(slot0.reward_list)
				ActivityAccumulativeData:RefreshData(uv0)
				manager.notify:Invoke(ACCUMULATIVEGACHA_UPDATE)

				if uv1 then
					uv1()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
