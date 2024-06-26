slot0 = singletonClass("NewServerData")
slot1 = 0
slot2 = 0
slot3 = 4
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = 0
slot8 = 0

function slot0.Init(slot0)
	uv0 = 0
	uv1 = 0
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = 0
end

function slot0.InitData(slot0, slot1)
	uv0 = slot1.activity_id
	uv1 = slot1.receive_sign_index
	uv2 = slot1.last_update_receive_time
	uv3 = {}

	for slot6, slot7 in ipairs(slot1.received_sign_list) do
		table.insert(uv3, slot7)
	end

	if slot1.bp ~= nil then
		uv4 = slot3.is_recharge

		for slot7, slot8 in ipairs(slot3.bp_assignment) do
			uv5[slot8.id] = {
				id = slot8.id,
				is_receive_reward = slot8.is_receive_reward,
				is_receive_recharge_reward = slot8.is_receive_recharge_reward
			}
		end
	end

	if slot1.gashapon_reward_list ~= nil then
		for slot8, slot9 in ipairs(slot4) do
			uv6[slot9.id] = {
				id = slot9.id,
				remain_num = slot9.residual_num
			}
		end
	end

	uv7 = slot1.acc_num or 0
end

function slot0.GetActivityID(slot0)
	return uv0
end

function slot0.IsSignReward(slot0, slot1)
	return not not table.indexof(uv0, slot1)
end

function slot0.UpdateSign(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetSignIndex(slot0)
	slot1 = manager.time:GetTodayFreshTime()

	if uv1 >= #(NewServerCfg[uv0] and NewServerCfg[uv0].sign_reward or {}) then
		return #slot2
	end

	if uv2 < slot1 then
		return uv1 + 1
	end

	return uv1
end

function slot0.GetBPTaskStatus(slot0)
	return uv0
end

function slot0.GetBPTaskIsRecharge(slot0)
	return uv0
end

function slot0.SetBPTaskIsRecharge(slot0)
	uv0 = 1
end

function slot0.SetBPTaskStatus(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if uv0[slot6.id] == nil then
			uv0[slot6.id] = {
				is_receive_recharge_reward = 0,
				is_receive_reward = 0,
				id = slot6.id
			}
		end

		if slot6.receive_type == 1 then
			uv0[slot6.id].is_receive_reward = 1
		else
			uv0[slot6.id].is_receive_recharge_reward = 1
		end
	end
end

function slot0.GetCapsuleToysStatus(slot0)
	return uv0
end

function slot0.SetCapsuleToysStatus(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if uv0[slot6[1]] then
			uv0[slot7].remain_num = uv0[slot7].remain_num - 1
			uv0[slot7].remain_num = uv0[slot7].remain_num < 0 and 0 or uv0[slot7].remain_num
		end
	end
end

function slot0.GetAccumulateCurrency(slot0)
	return uv0
end

function slot0.SetAccumulateCurrency(slot0, slot1)
	uv0 = slot1
end

return slot0
