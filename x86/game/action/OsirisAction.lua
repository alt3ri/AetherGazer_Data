function slot1(slot0)
	for slot5, slot6 in pairs(slot0) do
		slot1 = 0 + 1
	end

	return slot1
end

manager.net:Bind(11017, function (slot0)
	uv0.UpdateRewardRedPoint()
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function ()
	uv0.UpdateRewardRedPoint()
end)

return {
	OpenPoolBox = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(11024, {
			pool_id = slot0,
			index = slot1
		}, 11025, function (slot0)
			if isSuccess(slot0.result) then
				OsirisInfinityPoolData:OpenBox(uv0, uv1, slot0.box_list)
				uv2.UpdateRewardRedPoint()
			end

			uv3(slot0)
		end)
	end,
	ResetPool = function (slot0, slot1)
		manager.net:SendWithLoadingNew(11026, {
			pool_id = slot0
		}, 11027, function (slot0)
			if isSuccess(slot0.result) then
				OsirisInfinityPoolData:ResetPool(uv0, slot0.pool)
				uv1.UpdateRewardRedPoint()
			end

			uv2(slot0)
		end)
	end,
	UpdateRewardRedPoint = function ()
		slot1 = {}

		for slot5, slot6 in pairs(OsirisInfinityPoolData:GetPoolList()) do
			if slot1[ActivityInfinityPoolCfg[slot5].activity_id] == nil then
				slot1[slot7.activity_id] = 0
			end

			if uv0(slot6.openBoxList) ~= #slot6.itemList + (slot6.coreItem == nil and 0 or 1) and slot7.cost_item[2] <= ItemTools.getItemNum(slot7.cost_item[1]) then
				slot1[slot7.activity_id] = 1
			end
		end

		for slot5, slot6 in pairs(slot1) do
			manager.redPoint:setTip(string.format("%s_%s", "INFINITY_POOL", slot5), slot6)
		end
	end
}
