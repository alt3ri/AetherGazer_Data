slot0 = singletonClass("MardukSpecialData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitDataFromServer(slot0, slot1)
	if not uv0[slot1.activity_id] then
		uv0[slot1.activity_id] = {}
	end

	uv0[slot1.activity_id].activity_id = slot1.activity_id
	uv0[slot1.activity_id].point = slot1.point
	uv0[slot1.activity_id].got_reward_id_list = {}

	for slot5, slot6 in ipairs(slot1.got_reward_id_list) do
		table.insert(uv0[slot1.activity_id].got_reward_id_list, slot6)
	end

	MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
	MardukSpecialAction.UpdateRedPoint(ActivityConst.ACTIVITY_2_2_SPECIAL)
	manager.notify:Invoke(MARDUK_SPECIAL_DATA_UPDATE, {})
end

function slot0.GetPoint(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return slot2.point
end

function slot0.GetCanGetRewardIndex(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		slot9 = nil

		for slot13, slot14 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot7]) do
			if ActivityPointRewardCfg[slot14].need <= MardukSpecialData:GetPoint(slot7) and not MardukSpecialData:HaveGotReward(slot7, slot14) then
				return table.indexof(slot2, slot7)
			end
		end
	end

	return 1
end

function slot0.GetGotRewardNum(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		if uv0[slot7] then
			slot2 = 0 + #uv0[slot7].got_reward_id_list
		end
	end

	return slot2
end

function slot0.HaveGotReward(slot0, slot1, slot2)
	if not uv0[slot1] then
		return false
	end

	if table.indexof(slot3.got_reward_id_list, slot2) then
		return true
	end

	return false
end

function slot0.OnGotReward(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list) do
		for slot12, slot13 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot7]) do
			if table.indexof(slot1, slot13) then
				table.insert(uv0[slot7].got_reward_id_list, slot13)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.FACTORY_MARDUK)
			end
		end
	end

	for slot7, slot8 in ipairs(ActivityCfg[ActivityConst.ACTIVITY_2_2_SPECIAL].sub_activity_list) do
		for slot13, slot14 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot8]) do
			if table.indexof(slot1, slot14) then
				table.insert(uv0[slot8].got_reward_id_list, slot14)
				MardukSpecialAction.UpdateRedPoint(ActivityConst.ACTIVITY_2_2_SPECIAL)
			end
		end
	end

	manager.notify:Invoke(MARDUK_SPECIAL_REWARD_UPDATE, slot1)
end

return slot0
