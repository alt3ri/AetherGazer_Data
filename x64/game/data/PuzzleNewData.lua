slot0 = singletonClass("PuzzleNewData")

function slot0.Init(slot0)
	slot0.clearDic_ = {}
	slot0.regionReceivedList_ = {}
	slot0.puzzleDic_ = {}
	slot0.checkList_ = {}
	slot0.checkTipsList_ = {}
	slot0.selectPlayBtn_ = {}
end

function slot0.InitData(slot0, slot1)
	slot0.regionReceivedList_[slot1.activity_id] = {}

	for slot7, slot8 in ipairs(slot1.area_award_id) do
		slot0.regionReceivedList_[slot2][slot8] = true
	end

	slot9 = slot1.puzzle
	slot0.puzzleDic_[slot2] = slot0:ParsePuzzle(slot9)
	slot0.checkList_[slot2] = {}

	for slot9, slot10 in ipairs(slot1.clue_list) do
		slot0.checkList_[slot2][slot10] = true
	end

	slot0.checkTipsList_[slot2] = {}

	for slot9, slot10 in ipairs(slot1.clue_tip_list) do
		slot0.checkTipsList_[slot2][slot10] = true
	end

	slot0:RefreshPlayRedPoint(slot2)
	slot0:RefreshPieceRedPoint(slot2)
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

function slot0.GetRegionReceivedList(slot0, slot1)
	return slot0.regionReceivedList_[slot1] or {}
end

function slot0.SetRegionReceivedList(slot0, slot1, slot2)
	slot0.regionReceivedList_[slot1] = slot0.regionReceivedList_[slot1] or {}

	for slot6, slot7 in pairs(slot2) do
		slot0.regionReceivedList_[slot1][slot7] = true
	end
end

function slot0.GetCurPuzzleList(slot0, slot1)
	return slot0.puzzleDic_[slot1] or {}
end

function slot0.GetCurCheckList(slot0, slot1)
	return slot0.checkList_[slot1] or {}
end

function slot0.SetCurCheckList(slot0, slot1, slot2)
	slot0.checkList_[slot1][slot2] = true
end

function slot0.GetCheckTipsList(slot0, slot1)
	return slot0.checkTipsList_[slot1] or {}
end

function slot0.SetCheckTipsList(slot0, slot1, slot2)
	slot0.checkTipsList_[slot1][slot2] = true
end

function slot0.IsCompleted(slot0, slot1)
	if not slot0.clearDic_[slot1] then
		for slot6, slot7 in ipairs(PuzzleNewCfg[slot1].area_fragment_list) do
			if not slot0:GetRegionReceivedList(slot1) or not slot9[slot7[1]] then
				return false
			end
		end

		slot0.clearDic_[slot1] = true
	end

	return true
end

function slot0.RefreshPlayRedPoint(slot0, slot1)
	slot2 = 0

	if not (slot0.selectPlayBtn_[slot1] == true) then
		slot4 = PuzzleNewCfg[slot1].area_fragment_list
		slot5 = slot0:GetRegionReceivedList(slot1)
		slot6 = PuzzleNewTools.GetPuzzlePosDic(slot1)
		slot8 = {
			[slot13] = true
		}

		for slot12, slot13 in pairs(slot0:GetCurPuzzleList(slot1)) do
			-- Nothing
		end

		for slot12, slot13 in ipairs(slot4) do
			if not slot5 or not slot5[slot13[1]] then
				slot15 = false

				for slot19, slot20 in ipairs(slot13[2]) do
					if not slot8[slot20] then
						slot15 = false

						break
					end

					if slot7[slot6[slot20]] ~= slot20 then
						slot15 = true
					end
				end

				if slot15 == true then
					slot2 = 1

					break
				end
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, slot1), slot2)
end

function slot0.SetPlayBtnSelected(slot0, slot1)
	if manager.redPoint:getTipBoolean(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, slot1)) and not slot0.selectPlayBtn_[slot1] then
		slot0.selectPlayBtn_[slot1] = true

		slot0:RefreshPlayRedPoint(slot1)
	end
end

function slot0.RefreshPieceRedPoint(slot0, slot1)
	slot3 = PuzzleNewCfg[slot1].fragment_id[1]
	slot6 = 0

	if slot3[2] <= ItemTools.getItemNum(slot3[1]) and PuzzleNewTools.CheckWrongSide(true, slot1) then
		slot6 = 1
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, slot1), slot6)
end

function slot0.SetPutBtnSelected(slot0, slot1)
	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, slot1), 0)
end

function slot0.SetSelecteCheckPoint(slot0, slot1, slot2, slot3)
	saveData("puzzle_new", string.format("select_check_point_%d_%d", slot1, slot2), slot3)
end

function slot0.GetSelecteCheckPoint(slot0, slot1, slot2)
	return getData("puzzle_new", string.format("select_check_point_%d_%d", slot1, slot2))
end

return slot0
