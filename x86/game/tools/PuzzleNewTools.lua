return {
	GetTaskUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawUI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawUI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawUI"
		end
	end,
	GetPlayViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzleUI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzleUI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzleUI"
		end
	end,
	GetRewardViewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop2UI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzlePop2UI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop2UI"
		end
	end,
	GetPreviewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop1UI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzlePop1UI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop1UI"
		end
	end,
	GetCheckPreviewUIName = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_1 then
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop3UI"
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_8 then
			return "UI/VersionUI/IndiaUI_2_8/IndiaJigsawUI/IndiaJigsawPuzzlePop3UI"
		else
			return "UI/VersionUI/XuHeng2ndUI/XH2ndJigsawUI/XH2ndJigsawPuzzlePop3UI"
		end
	end,
	GetTaskItemClass = function (slot0)
		if ActivityTools.GetActivityTheme(slot0) == ActivityConst.THEME.ACTIVITY_2_1 then
			return PuzzleNewTaskItem
		elseif slot1 == ActivityConst.THEME.ACTIVITY_2_8 then
			return IndiaPuzzleNewTaskItem
		else
			return PuzzleNewTaskItem
		end
	end,
	InitConfig = function (slot0)
		slot1 = PuzzleNewCfg[slot0]
		uv0.puzzlePosDic = uv0.puzzlePosDic or {}
		uv0.puzzlePosDic[slot0] = {}

		for slot5, slot6 in ipairs(slot1.correct_array) do
			uv0.puzzlePosDic[slot0][slot6] = slot5
		end

		uv0.regionPosDic = uv0.regionPosDic or {}
		uv0.regionPosDic[slot0] = {}
		uv0.regionCfgList = uv0.regionCfgList or {}
		uv0.regionCfgList[slot0] = {}

		for slot6, slot7 in ipairs(slot1.area_fragment_list) do
			slot8 = slot7[1]
			uv0.regionPosDic[slot0][slot8] = slot6
			uv0.regionCfgList[slot0][slot8] = {
				reward = slot1.reward_area_list[slot6][2],
				puzzle = slot7[2]
			}
		end
	end,
	GetPuzzlePosDic = function (slot0)
		slot1 = nil

		return (not uv0.puzzlePosDic or not uv0.puzzlePosDic[slot0] or uv0.puzzlePosDic[slot0]) and {}
	end,
	GetRegionPosDic = function (slot0)
		slot1 = nil

		return (not uv0.regionPosDic or not uv0.regionPosDic[slot0] or uv0.regionPosDic[slot0]) and {}
	end,
	GetRegionCfgList = function (slot0)
		slot1 = nil

		return (not uv0.regionCfgList or not uv0.regionCfgList[slot0] or uv0.regionCfgList[slot0]) and {}
	end,
	FindPuzzleByScreenPos = function (slot0, slot1, slot2, slot3)
		slot4, slot5 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0, slot3.position, slot3.pressEventCamera, nil)
		slot6 = slot0.sizeDelta
		slot8 = slot6.y
		slot11 = math.ceil((slot8 - slot5.y) / slot8 * slot2)

		if math.ceil(slot5.x / slot6.x * slot1) < 1 or slot11 < 1 or slot1 < slot12 or slot2 < slot11 then
			return false, -1
		else
			return true, (slot11 - 1) * slot1 + slot12
		end
	end,
	CheckWrongSide = function (slot0, slot1)
		for slot8, slot9 in pairs(PuzzleNewCfg[slot1].correct_array) do
			if slot0 then
				if PuzzleNewData:GetCurPuzzleList(slot1)[slot8] == nil then
					return true
				end
			elseif slot4[slot8] ~= nil and slot4[slot8] ~= slot9 then
				return true
			end
		end

		return false
	end,
	CheckRegionResult = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in pairs(uv0.regionCfgList[slot0]) do
			if uv0.CheckRegionResultByRegionID(slot6, slot0) then
				table.insertto(slot2, slot7.reward)

				slot1[#slot1 + 1] = slot6
			end
		end

		return slot1, slot2
	end,
	CheckRegionResultByRegionID = function (slot0, slot1)
		if PuzzleNewData:GetRegionReceivedList(slot1)[slot0] then
			return false
		else
			slot3 = PuzzleNewData:GetCurPuzzleList(slot1)

			for slot8, slot9 in ipairs(uv0.regionCfgList[slot1][slot0].puzzle) do
				if not slot3[uv0.puzzlePosDic[slot1][slot9]] or slot3[slot10] ~= slot9 then
					return false
				end
			end
		end

		return true
	end
}
