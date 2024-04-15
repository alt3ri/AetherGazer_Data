slot0 = singletonClass("IndiaNianData")
slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10 = nil

function slot0.UpdateNianData(slot0, slot1)
	uv0 = slot1.activity_id

	if slot1.round then
		uv1 = slot1.round
	end

	uv2 = 0

	for slot6, slot7 in ipairs(IndiaNianCfg.get_id_list_by_group_id[100]) do
		if IndiaNianCfg[slot7].stage_type ~= 1 then
			uv2 = uv2 + slot8.boss_hp
		end
	end

	if slot1.clear_id_list then
		uv3 = {}

		for slot6, slot7 in ipairs(slot1.clear_id_list) do
			table.insert(uv3, slot7)
		end
	end

	if slot1.boss_list then
		uv4 = {}
		slot7 = slot1.boss_list

		for slot6, slot7 in ipairs(cleanProtoTable(slot7)) do
			uv4[IndiaNianCfg[slot7.id].group_id] = slot7.hp
		end
	end
end

function slot0.SetSelectedDestID(slot0, slot1)
	uv0 = slot1
end

function slot0.GetSelectedDestID(slot0)
	return uv0
end

function slot0.GetClearedBossIDList(slot0)
	return uv0
end

function slot0.SetSelectedDescIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.GetSelectedDescIndex(slot0)
	return uv0 or 0
end

function slot0.GetTotalHp(slot0)
	return uv0
end

function slot0.SetSelectedStage(slot0, slot1)
	uv0 = slot1
end

function slot0.GetSelectedStageID(slot0)
	return uv0
end

function slot0.SetSelectedStageCost(slot0, slot1)
	slot1 = slot1 or {
		54043,
		1
	}
end

function slot0.GetSelectedStageCost(slot0)
	return uv0 or {
		54043,
		1
	}
end

function slot0.SetMainSelectedIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.GetMainSelectedIndex(slot0)
	return uv0 or 0
end

function slot0.GetCurrentHpByID(slot0, slot1)
	slot2 = 0

	if IndiaNianCfg[slot1].group_id == 100 then
		for slot7, slot8 in ipairs(IndiaNianCfg.get_id_list_by_group_id[100]) do
			if uv0 < IndiaNianCfg[slot8].round and slot9.stage_type ~= 1 then
				slot2 = slot2 + slot9.boss_hp
			end
		end
	end

	return slot2 + (uv1[IndiaNianCfg[slot1].group_id] or 0)
end

function slot0.GetActivityID(slot0)
	return uv0
end

function slot0.GetRound(slot0)
	return uv0
end

function slot0.IsBossRound(slot0, slot1)
	for slot5, slot6 in ipairs(IndiaNianCfg.get_id_list_by_group_id[100]) do
		if IndiaNianCfg[slot6].round == slot1 then
			return true
		end
	end

	return false
end

function slot0.GetStageHasClearedByID(slot0, slot1)
	slot2 = slot1

	if IndiaNianCfg[slot1].stage_type ~= 1 then
		slot2 = IndiaNianCfg.get_id_list_by_group_id[IndiaNianCfg[slot1].group_id][2]
	end

	return table.keyof(uv0, slot2) and true or false
end

function slot0.GetHasCompeletedTask(slot0)
	slot1 = {}

	if table.isEmpty(TaskData2:GetActivityTaskSortList(IndiaNianData:GetActivityID())) then
		return false
	end

	for slot6, slot7 in pairs(slot2) do
		table.insert(slot1, slot7)
	end

	function slot6(slot0, slot1)
		return slot0.id < slot1.id
	end

	table.sort(slot1, slot6)

	for slot6, slot7 in ipairs(slot1) do
		if AssignmentCfg[slot7.id].need <= slot7.progress and not (slot7.complete_flag >= 1) then
			return true
		end
	end

	return false
end

function slot0.GetClearBuffNum(slot0)
	for slot5, slot6 in ipairs(uv0) do
		if IndiaNianCfg[slot6].group_id ~= 100 and IndiaNianCfg[slot6].stage_type == 1 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.GetHasUnlockBuff(slot0)
	if (getData("ActivityIndiaNian" .. slot0:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "buffNum") or 0) < slot0:GetClearBuffNum() then
		return true
	end

	return false
end

return slot0
