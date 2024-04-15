return {
	GetTaskUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_4 then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionJigsawUI/JapanRegionJigsawUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionJigsawUI/JapanRegionJigsawUI"
		end
	end,
	GetPlayViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_4 then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionJigsawUI/JapanRegionJigsawPuzzleUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionJigsawUI/JapanRegionJigsawPuzzleUI"
		end
	end,
	GetRewardViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_4 then
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionJigsawUI/JapanRegionJigsawPuzzlePopUI"
		else
			return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionJigsawUI/JapanRegionJigsawPuzzlePopUI"
		end
	end,
	InitConfig = function (slot0)
		slot1 = TangramPuzzleCfg[slot0]
		uv0.regionCfgDic = uv0.regionCfgDic or {}
		uv0.regionCfgDic[slot0] = {}
		uv0.regionIndexDic = uv0.regionIndexDic or {}
		uv0.regionIndexDic[slot0] = {}
		uv0.regionIdDicByPuzzleID = uv0.regionIdDicByPuzzleID or {}
		uv0.regionIdDicByPuzzleID[slot0] = {}
		uv0.regionIdDicByPuzzleGlobalIndex = uv0.regionIdDicByPuzzleGlobalIndex or {}
		uv0.regionIdDicByPuzzleGlobalIndex[slot0] = {}
		uv0.puzzleGlobalIndexDic = uv0.puzzleGlobalIndexDic or {}
		uv0.puzzleGlobalIndexDic[slot0] = {}
		slot4 = 1
		uv0.puzzleLocalIndexDicByGlobalIndex = uv0.puzzleLocalIndexDicByGlobalIndex or {}
		uv0.puzzleLocalIndexDicByGlobalIndex[slot0] = {}
		uv0.puzzleLocalIndexDic = uv0.puzzleLocalIndexDic or {}
		uv0.puzzleLocalIndexDic[slot0] = {}
		uv0.puzzleGlobalIndexListByRegionID = uv0.puzzleGlobalIndexListByRegionID or {}
		uv0.puzzleGlobalIndexListByRegionID[slot0] = {}
		uv0.puzzlePictureIdDic = uv0.puzzlePictureIdDic or {}
		uv0.puzzlePictureIdDic[slot0] = {}

		for slot8, slot9 in ipairs(slot1.correct_array) do
			uv0.regionIndexDic[slot0][slot9[1]] = slot8
			slot13 = {}

			for slot17, slot18 in ipairs(slot9[2]) do
				uv0.regionIdDicByPuzzleID[slot0][slot18] = slot10
				uv0.regionIdDicByPuzzleGlobalIndex[slot0][slot4] = slot10
				uv0.puzzleLocalIndexDic[slot0][slot18] = slot17
				uv0.puzzleGlobalIndexDic[slot0][slot18] = slot4
				uv0.puzzleLocalIndexDicByGlobalIndex[slot0][slot4] = slot17

				table.insert(slot13, slot4)

				uv0.puzzlePictureIdDic[slot0][slot18] = slot1.picture_fragment_id[slot8][2][slot17]
				slot4 = slot4 + 1
			end

			uv0.puzzleGlobalIndexListByRegionID[slot0][slot10] = slot13
		end

		uv0.regionListByType = uv0.regionListByType or {}
		uv0.regionListByType[slot0] = {}

		for slot9, slot10 in ipairs(slot1.area_type_list) do
			uv0.regionListByType[slot0][slot10[1]] = {}

			for slot17, slot18 in ipairs(slot10[2]) do
				uv0.regionCfgDic[slot0][slot18] = uv0.regionCfgDic[slot0][slot18] or {}
				uv0.regionCfgDic[slot0][slot18].type = slot11
				uv0.regionCfgDic[slot0][slot18].rotateAngle = slot10[3]

				table.insert(uv0.regionListByType[slot0][slot11], slot18)
			end
		end

		slot6 = {}

		for slot11, slot12 in ipairs(PuzzleNewClueCfg.get_id_list_by_main_activity_id[slot0]) do
			slot6[slot14] = slot6[PuzzleNewClueCfg[slot12].area_type] or {}

			table.insert(slot6[slot14], slot12)
		end

		uv0.clueListByRegionType = uv0.clueListByRegionType or {}
		uv0.clueListByRegionType[slot0] = slot6
		uv0.cacheAllReceivedRegion = uv0.cacheAllReceivedRegion or {}
		uv0.cacheAllReceivedRegion[slot0] = {}
		uv0.cacheAllRightRegionType = uv0.cacheAllRightRegionType or {}
		uv0.cacheAllRightRegionType[slot0] = {}
	end,
	GetRegionIdDicByPuzzleID = function (slot0)
		slot1 = nil

		return (not uv0.regionIdDicByPuzzleID or not uv0.regionIdDicByPuzzleID[slot0] or uv0.regionIdDicByPuzzleID[slot0]) and {}
	end,
	GetPuzzleLocalIndexDic = function (slot0)
		slot1 = nil

		return (not uv0.puzzleLocalIndexDic or not uv0.puzzleLocalIndexDic[slot0] or uv0.puzzleLocalIndexDic[slot0]) and {}
	end,
	GetPuzzleGlobalIndexDic = function (slot0)
		slot1 = nil

		return (not uv0.puzzleGlobalIndexDic or not uv0.puzzleGlobalIndexDic[slot0] or uv0.puzzleGlobalIndexDic[slot0]) and {}
	end,
	GetPuzzleLocalIndexDicByGlobalIndex = function (slot0)
		slot1 = nil

		return (not uv0.puzzleLocalIndexDicByGlobalIndex or not uv0.puzzleLocalIndexDicByGlobalIndex[slot0] or uv0.puzzleLocalIndexDicByGlobalIndex[slot0]) and {}
	end,
	GetPuzzleGlobalIndexListByRegionID = function (slot0)
		slot1 = nil

		return (not uv0.puzzleGlobalIndexListByRegionID or not uv0.puzzleGlobalIndexListByRegionID[slot0] or uv0.puzzleGlobalIndexListByRegionID[slot0]) and {}
	end,
	GetCurServerPuzzleGlobalIndex = function (slot0, slot1)
		for slot6, slot7 in pairs(TangramPuzzleData:GetCurPuzzleDic(slot0)) do
			if slot1 == slot7 then
				return slot6
			end
		end

		return -1
	end,
	GetPuzzlePictureDic = function (slot0)
		slot1 = nil

		return (not uv0.puzzlePictureIdDic or not uv0.puzzlePictureIdDic[slot0] or uv0.puzzlePictureIdDic[slot0]) and {}
	end,
	FindClosestTarget = function (slot0, slot1)
		slot3 = slot1.position
		slot5 = 1

		for slot10 = 2, #slot0 do
			if (slot2:WorldToScreenPoint(slot0[slot10]) - slot3):Magnitude() < (slot1.pressEventCamera:WorldToScreenPoint(slot0[1]) - Vector3.New(slot3.x, slot3.y, 0)):Magnitude() then
				slot6 = slot11
				slot5 = slot10
			end
		end

		return slot5, slot6
	end,
	CheckWrongSideByRegionID = function (slot0, slot1)
		for slot8, slot9 in ipairs(uv0.GetRegionCorrectPuzzleList(slot0, slot1)) do
			if slot9 ~= TangramPuzzleData:GetCurPuzzleDic(slot0)[uv0.GetPuzzleGlobalIndexListByRegionID(slot0)[slot1][slot8]] then
				return true
			end
		end

		return false
	end,
	CheckRegionAllRight = function (slot0)
		for slot4, slot5 in pairs(uv0.regionListByType[slot0]) do
			if not uv0.CheckRegionAllRightByType(slot0, slot4) then
				return false
			end
		end

		return true
	end,
	CheckRegionAllRightByType = function (slot0, slot1)
		if uv0.cacheAllRightRegionType[slot0][slot1] == true then
			return true
		end

		for slot6, slot7 in ipairs(uv0.regionListByType[slot0][slot1]) do
			if uv0.CheckWrongSideByRegionID(slot0, slot7) == true then
				return false
			end
		end

		uv0.cacheAllRightRegionType[slot0][slot1] = true

		return true
	end,
	GetRegionCfg = function (slot0)
		return uv0.regionCfgDic[slot0]
	end,
	GetRegionType = function (slot0, slot1)
		return uv0.regionCfgDic[slot0][slot1].type
	end,
	GetRegionRotateAngle = function (slot0, slot1)
		return uv0.regionCfgDic[slot0][slot1].rotateAngle
	end,
	GetRegionCorrectPuzzleList = function (slot0, slot1)
		return TangramPuzzleCfg[slot0].correct_array[uv0.regionIndexDic[slot0][slot1]][2]
	end,
	GetRegionRewardList = function (slot0, slot1)
		return TangramPuzzleCfg[slot0].reward_area_list[uv0.regionIndexDic[slot0][slot1]][2]
	end,
	GetRegionListByType = function (slot0)
		return uv0.regionListByType[slot0]
	end,
	GetRegionIdByPuzzleGlobalIndex = function (slot0)
		slot1 = nil

		return (not uv0.regionIdDicByPuzzleGlobalIndex or not uv0.regionIdDicByPuzzleGlobalIndex[slot0] or uv0.regionIdDicByPuzzleGlobalIndex[slot0]) and {}
	end,
	CheckRegionReward = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot7, slot8 in pairs(uv0.regionCfgDic[slot0]) do
			if not uv0.CheckWrongSideByRegionID(slot0, slot7) and not TangramPuzzleData:GetRegionReceivedDic(slot0)[slot7] then
				table.insertto(slot2, uv0.GetRegionRewardList(slot0, slot7))

				slot1[#slot1 + 1] = slot7
			end
		end

		return slot1, slot2
	end,
	IsAllRegionReceived = function (slot0, slot1)
		if uv0.cacheAllReceivedRegion[slot0][slot1] then
			return true
		end

		for slot7, slot8 in ipairs(uv0.regionListByType[slot0][slot1]) do
			if not TangramPuzzleData:GetRegionReceivedDic(slot0)[slot8] then
				return false
			end
		end

		uv0.cacheAllReceivedRegion[slot0][slot1] = true

		return true
	end,
	IsAllRegionTypeReceived = function (slot0)
		for slot4, slot5 in pairs(uv0.regionListByType[slot0]) do
			if not uv0.IsAllRegionReceived(slot0, slot4) then
				return false
			end
		end

		return true
	end,
	GetClueListByRegionType = function (slot0)
		slot1 = nil

		return (not uv0.clueListByRegionType[slot0] or not uv0.clueListByRegionType[slot0] or uv0.clueListByRegionType[slot0]) and {}
	end,
	IsAllClueCompleted = function (slot0)
		for slot6, slot7 in ipairs(PuzzleNewClueCfg.get_id_list_by_main_activity_id[slot0]) do
			if not TangramPuzzleData:GetCurClueDic(slot0)[slot7] then
				return false
			end
		end

		return true
	end
}
