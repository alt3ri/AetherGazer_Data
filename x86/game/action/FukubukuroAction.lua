manager.net:Bind(17021, function (slot0)
	FukubukuroData:InitData(slot0.instance_list)
end)

return {
	QuseryUseItem = function (slot0, slot1)
		if FukubukuroData:GetFukubukuroByInstanceId(slot0) == nil then
			return
		end

		manager.net:SendWithLoadingNew(17012, {
			use_item_list = {
				{
					item_info = {
						num = 1,
						time_valid = 0,
						id = slot2.item_id
					},
					use_list = {
						slot0,
						slot1
					}
				}
			}
		}, 17013, uv0.OnUseItemBack)
	end,
	OnUseItemBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward(slot0.drop_list)
			manager.notify:Invoke(MATERIAL_LIST_UPDATE)
		else
			ShowTips(slot0.result)
		end
	end,
	UpdateItem = function (slot0)
		FukubukuroData:UpdateData(slot0)
	end
}
