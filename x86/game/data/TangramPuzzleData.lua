slot0 = singletonClass("TangramPuzzleData")

function slot0.Init(slot0)
	slot0.clearDic_ = {}
	slot0.regionReceivedDic_ = {}
	slot0.unlockRegionDic_ = {}
	slot0.puzzleDic_ = {}
	slot0.clueDic_ = {}
	slot0.selectPlayBtn_ = {}
	slot0.selectPutBtn_ = {}
	slot0.inited = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id
	slot0.inited[slot2] = true
	slot0.regionReceivedDic_[slot2] = {}
	slot0.unlockRegionDic_[slot2] = {}

	for slot7, slot8 in ipairs(slot1.area_award_id) do
		slot0.regionReceivedDic_[slot2][slot8] = true
	end

	slot0.puzzleDic_[slot2] = slot0:ParsePuzzle(slot1.puzzle)
	slot5 = 1

	for slot9, slot10 in ipairs(TangramPuzzleCfg[slot2].correct_array) do
		slot12 = slot10[2]

		if slot0.puzzleDic_[slot2][slot5] ~= nil then
			slot0.unlockRegionDic_[slot2][slot10[1]] = true
		end

		slot5 = slot5 + #slot12
	end

	slot0.clueDic_[slot2] = {}

	for slot10, slot11 in ipairs(slot1.clue_list) do
		slot0.clueDic_[slot2][slot11] = true
	end
end

function slot0.IsInited(slot0, slot1)
	return slot0.inited[slot1] == true
end

function slot0.ParsePuzzle(slot0, slot1)
	slot5 = {}
	slot6 = 1
	slot7 = 1

	for slot11 = 1, #slot1.vacant_position + #slot1.puzzle_data do
		if slot2[slot6] == slot11 then
			slot6 = slot6 + 1
		else
			slot5[slot11] = slot3[slot7]
			slot7 = slot7 + 1
		end
	end

	return slot5
end

function slot0.SetPuzzle(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		slot0.puzzleDic_[slot1][slot3] = slot2
	else
		slot0.puzzleDic_[slot1][slot3] = nil
	end
end

function slot0.SetPuzzleDic(slot0, slot1, slot2)
	slot0.puzzleDic_[slot1] = slot2
end

function slot0.ExchangePuzzle(slot0, slot1, slot2, slot3)
	slot0:SetPuzzle(slot1, slot0.puzzleDic_[slot1][slot2], slot3)
	slot0:SetPuzzle(slot1, slot0.puzzleDic_[slot1][slot3], slot2)
end

function slot0.RetateRegion(slot0, slot1, slot2, slot3)
	if rotatetimes == 0 then
		return
	end

	if math.abs(slot3) == #TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(slot1)[slot2] then
		return
	end

	slot6 = {
		[slot10] = slot0.puzzleDic_[slot1][slot11]
	}

	for slot10, slot11 in ipairs(slot4) do
		-- Nothing
	end

	slot8, slot9, slot10, slot11 = nil

	if slot3 > 0 == true then
		slot8 = 1
		slot9 = slot5
		slot11 = 1
	else
		slot8 = slot5
		slot9 = 1
		slot11 = -1
	end

	slot10 = slot8 + slot3

	for slot15 = slot8, slot9, slot11 do
		slot0:SetPuzzle(slot1, slot6[slot15], slot4[slot10])

		if slot10 + slot11 <= 0 then
			slot10 = slot5
		elseif slot5 < slot10 then
			slot10 = 1
		end
	end
end

function slot0.GetCurPuzzleDic(slot0, slot1)
	return slot0.puzzleDic_[slot1] or {}
end

function slot0.GetRegionReceivedDic(slot0, slot1)
	return slot0.regionReceivedDic_[slot1] or {}
end

function slot0.SetRegionReceivedDic(slot0, slot1, slot2)
	slot0.regionReceivedDic_[slot1] = slot0.regionReceivedDic_[slot1] or {}

	for slot6, slot7 in pairs(slot2) do
		slot0.regionReceivedDic_[slot1][slot7] = true
	end
end

function slot0.IsReceivedFinalReward(slot0, slot1)
	return slot0:GetRegionReceivedDic(slot1)[0] == true
end

function slot0.GetUnlockRegionDic(slot0, slot1)
	return slot0.unlockRegionDic_[slot1]
end

function slot0.GetCurClueDic(slot0, slot1)
	return slot0.clueDic_[slot1] or {}
end

function slot0.SetCurClueDic(slot0, slot1, slot2)
	slot0.clueDic_[slot1][slot2] = true
end

function slot0.SetSelecteClue(slot0, slot1, slot2, slot3)
	saveData("tangram_puzzle", string.format("select_clue_%d_%d", slot1, slot2), slot3)
end

function slot0.GetSelecteClue(slot0, slot1, slot2)
	return getData("tangram_puzzle", string.format("select_clue_%d_%d", slot1, slot2))
end

function slot0.SetFirstEnter(slot0, slot1, slot2)
	saveData("tangram_puzzle", string.format("first_enter_%d", slot1), slot2)
end

function slot0.GetFirstEnter(slot0, slot1)
	return getData("tangram_puzzle", string.format("first_enter_%d", slot1))
end

function slot0.SetFirstEnterRegionType(slot0, slot1, slot2, slot3)
	saveData("tangram_puzzle", string.format("first_enter_region_%d_%d", slot1, slot2), slot3)
end

function slot0.GetFirstEnterRegionType(slot0, slot1, slot2)
	return getData("tangram_puzzle", string.format("first_enter_region_%d_%d", slot1, slot2))
end

function slot0.SetFirstTips(slot0, slot1, slot2)
	saveData("tangram_puzzle", string.format("first_tips_%d", slot1), slot2)
end

function slot0.GetFirstTips(slot0, slot1)
	return getData("tangram_puzzle", string.format("first_tips_%d", slot1))
end

return slot0
