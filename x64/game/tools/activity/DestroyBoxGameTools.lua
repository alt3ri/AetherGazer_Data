return {
	GetRewardPanelList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(DestroyBoxGameRewardCfg.get_id_list_by_main_activity_id[slot0]) do
			if not slot1[DestroyBoxGameRewardCfg[slot6].activity_id] and slot7.need_show == 1 then
				slot1[slot8] = clone(DestroyBoxGameRewardCfg.get_id_list_by_activity_id[slot8])
			end
		end

		return slot1
	end,
	GetSortRewardPanel = function (slot0, slot1)
		slot2 = {}
		slot3 = {}

		for slot7, slot8 in pairs(slot1) do
			slot9, slot10 = uv0.GetSortRewardList(slot0, slot8)

			if slot10 > 0 then
				table.insert(slot3, slot7)
			else
				table.insert(slot2, slot7)
			end
		end

		slot4 = {}

		table.sort(slot3, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.sort(slot2, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.insertto(slot4, slot3)
		table.insertto(slot4, slot2)

		return slot4, #slot3
	end,
	GetSortRewardList = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in ipairs(slot1) do
			if table.keyof(DestroyBoxGameData:GetReceiveRewardList(slot0), slot9) then
				table.insert(slot4, slot9)
			elseif uv0.IsUnlockReward(slot9) then
				table.insert(slot3, slot9)
			else
				table.insert(slot2, slot9)
			end
		end

		slot5 = {}

		table.insertto(slot5, slot3)
		table.insertto(slot5, slot2)
		table.insertto(slot5, slot4)

		return slot5, #slot3
	end,
	IsUnlockReward = function (slot0)
		slot1 = DestroyBoxGameRewardCfg[slot0]
		slot2 = slot1.activity_id

		for slot6, slot7 in ipairs(slot1.difficulty_id) do
			slot8 = nil

			if DestroyBoxGameData:GetStageData((slot1.need_show == 1 or DestroyBoxGameCfg.get_id_list_by_activity_id[slot2][1]) and DestroyBoxGameCfg.get_id_list_by_activity_id[slot2][slot7]) and slot1.complete_num <= slot9.maxScore then
				return true
			end
		end

		return false
	end,
	GetCanReceiveRewardList = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(DestroyBoxGameRewardCfg.get_id_list_by_main_activity_id[slot0]) do
			if DestroyBoxGameRewardCfg[slot7].need_show == 1 and not table.keyof(DestroyBoxGameData:GetReceiveRewardList(slot0), slot7) and DestroyBoxGameTools.IsUnlockReward(slot7) then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end,
	GetFinishRewardCnt = function (slot0)
		for slot6, slot7 in ipairs(DestroyBoxGameRewardCfg.get_id_list_by_main_activity_id[slot0]) do
			if table.keyof(DestroyBoxGameData:GetReceiveRewardList(slot0), slot7) and DestroyBoxGameRewardCfg[slot7].need_show == 1 then
				slot1 = 0 + 1
			end
		end

		return slot1
	end
}
