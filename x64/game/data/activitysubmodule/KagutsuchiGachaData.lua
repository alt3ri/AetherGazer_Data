slot0 = singletonClass("KagutsuchiGachaData")
slot1 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.InitDrawData(slot0, slot1)
	for slot7, slot8 in ipairs(slot0:GetPoolIds(slot1.activity_id)) do
		slot0:InitPoolData(slot8, slot1)
	end
end

function slot0.InitPoolData(slot0, slot1, slot2)
	uv0[slot1] = {
		all = {},
		displayItemIds = ActivityRewardPoolCfg[slot1].icon_info,
		cost = ActivityRewardPoolCfg[slot1].cost_once
	}

	for slot7, slot8 in ipairs(ActivityRewardPoolItemCfg.get_id_list_by_activity_id[slot1]) do
		uv0[slot1][slot8] = {
			id = slot8,
			num = ActivityRewardPoolItemCfg[slot8].total
		}

		table.insert(uv0[slot1].all, slot8)
	end

	for slot7, slot8 in ipairs(slot2.reward_pool_list) do
		if slot8.pool_id == slot1 then
			for slot12, slot13 in ipairs(slot8.reward_history_list) do
				slot14 = uv0[slot1][slot13.id]
				slot14.num = slot14.num - slot13.num
			end
		end
	end

	for slot8, slot9 in ipairs(slot3) do
		slot4 = 0 + uv0[slot1][slot9].num
	end

	uv0[slot1].poolRemains = slot4
end

function slot0.RefreshData(slot0, slot1, slot2)
	if uv0[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			uv0[slot1][slot7].num = math.max(uv0[slot1][slot7].num - 1, 0)
			uv0[slot1].poolRemains = math.max(uv0[slot1].poolRemains - 1, 0)
		end
	end
end

function slot0.GetPoolIds(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(ActivityRewardPoolCfg.all) do
		if ActivityRewardPoolCfg[slot7].activity_id == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetDrawItemReward(slot0, slot1, slot2)
	slot3 = ActivityRewardPoolItemCfg[slot2].reward

	return slot3[1], slot3[2]
end

function slot0.GetDrawItemTotalCount(slot0, slot1, slot2)
	return ActivityRewardPoolItemCfg[slot2].total
end

function slot0.GetDrawItemRemainCount(slot0, slot1, slot2)
	return uv0[slot1][slot2].num
end

function slot0.GetDrawCost(slot0, slot1, slot2)
	if uv0[slot1] == nil then
		return
	end

	slot3 = uv0[slot1].cost

	return slot3[1], slot3[2] * slot2
end

function slot0.GetAllDrawItemIds(slot0, slot1)
	return uv0[slot1].all
end

function slot0.GetDisplayDrawItemIds(slot0, slot1)
	return uv0[slot1].displayItemIds
end

function slot0.GetMaxDrawTimes(slot0, slot1)
	slot3 = uv0[slot1].cost

	if math.min(math.floor(ItemTools.getItemNum(slot3[1]) / slot3[2]), 10) == 0 then
		return slot4
	end

	return math.min(slot4, slot0:GetPoolRemains(slot1))
end

function slot0.GetPoolRemains(slot0, slot1)
	if not slot1 or not uv0[slot1] then
		return 0
	end

	return uv0[slot1].poolRemains
end

return slot0
