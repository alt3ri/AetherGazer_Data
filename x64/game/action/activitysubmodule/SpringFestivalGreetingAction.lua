manager.net:Bind(64041, function (slot0)
	SpringFestivalGreetingData:InitData(slot0)
end)

return {
	GetGreetingReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = {
				slot1
			}
		}, 60055, function (slot0)
			if isSuccess(slot0.result) then
				SpringFestivalGreetingData:ReceiveReward(uv0)
			end

			uv1(slot0)
		end)
	end
}
