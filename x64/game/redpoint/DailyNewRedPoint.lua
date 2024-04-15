return {
	Init = function (slot0)
		slot0.NewTagList = {
			[204.0] = true
		}
		slot0.newStageIdList = {}

		slot0:AddResourceToggleList()

		slot0.chapterSystemId = {}

		for slot4, slot5 in pairs(slot0.NewTagList) do
			slot0.chapterSystemId[GetSystemIdByClientChapterId(slot4)] = slot4
		end

		slot0.NewTagPrefix = "DailyChapterNewTag_"
		slot0.OldNewTagKeyList = {}
	end,
	AddResourceToggleList = function (slot0)
		for slot5 = 1, #ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE] do
			if GetSystemIdByClientChapterId(slot1[slot5]) and slot7 > 0 then
				slot0.NewTagList[slot6] = true

				for slot12, slot13 in ipairs(ChapterCfg[slot6].section_id_list or {}) do
					slot0.newStageIdList[slot13] = true
				end
			end
		end
	end,
	CheckNeedNewTag = function (slot0, slot1)
		if slot0.NewTagList[slot1] then
			return true
		end

		return false
	end,
	AlreadyPlayOnce = function (slot0, slot1)
		if BattleStageData:GetStageClearTimes(slot1) ~= 0 then
			return true
		end

		return false
	end,
	ClearOldNewTag = function (slot0)
		for slot4, slot5 in ipairs(slot0.OldNewTagKeyList) do
			manager.redPoint:setTip(slot5, 0, RedPointStyle.SHOW_NEW_TAG)
		end

		slot0.OldNewTagKeyList = {}
	end,
	InitNewTagData = function (slot0)
		slot0:ClearOldNewTag()

		for slot4, slot5 in pairs(slot0.NewTagList) do
			slot0:InitChapter(slot4)
		end
	end,
	InitChapter = function (slot0, slot1)
		if not ChapterCfg[slot1] then
			return
		end

		if ChapterClientCfg[slot1] and SystemData:ServerSystemIsLocked(GetSystemIdByClientChapterId(slot1)) then
			return
		end

		slot2 = ChapterCfg[slot1].section_id_list
		slot4 = {
			[slot9.stageId] = slot8
		}

		for slot8, slot9 in ipairs(getData("chapterDailyNewTag", "newTag" .. slot1) or {}) do
			-- Nothing
		end

		slot5 = {}

		for slot9, slot10 in ipairs(slot2) do
			if BattleStageData:GetStageIsOpen(slot10) then
				slot12 = false

				if slot4[slot10] then
					if slot0:AlreadyPlayOnce(slot10) then
						slot3[slot11].needNew = false
						slot12 = false
					else
						slot12 = slot3[slot11].needNew
					end
				else
					if not slot0:AlreadyPlayOnce(slot10) then
						slot12 = true
					end

					table.insert(slot3, {
						needNew = false,
						stageId = slot10,
						needNew = true
					})
				end

				if slot12 then
					slot0:AppendRedKey(slot10)
					slot0:DispatchNewTag(slot10)
					table.insert(slot0.OldNewTagKeyList, slot0:GetNewRedKey(slot10))
				end
			end
		end

		saveData("chapterDailyNewTag", "newTag" .. slot1, slot3)
	end,
	OnSystemUnlock = function (slot0, slot1)
		for slot5, slot6 in ipairs(slot1) do
			if slot0.chapterSystemId[slot6] then
				slot0:InitChapter(slot0.chapterSystemId[slot6])
			end
		end
	end,
	GetNewRedKey = function (slot0, slot1)
		return table.concat({
			slot0.NewTagPrefix,
			getChapterIDByStageID(slot1),
			"_",
			slot1
		})
	end,
	DispatchNewTag = function (slot0, slot1)
		manager.redPoint:setTip(slot0:GetNewRedKey(slot1), 1, RedPointStyle.SHOW_NEW_TAG)
	end,
	AppendRedKey = function (slot0, slot1)
		manager.redPoint:appendGroup(ChapterTools.GetRedPoint(getChapterIDByStageID(slot1)), slot0:GetNewRedKey(slot1))
	end,
	CancelNewTag = function (slot0, slot1)
		slot3 = getData("chapterDailyNewTag", "newTag" .. getChapterIDByStageID(slot1)) or {}
		slot4 = {
			[slot9.stageId] = slot8
		}

		for slot8, slot9 in ipairs(slot3) do
			-- Nothing
		end

		if slot3 and slot4[slot1] and slot3[slot4[slot1]].needNew == true then
			slot3[slot4[slot1]].needNew = false

			manager.redPoint:setTip(slot0:GetNewRedKey(slot1), 0, RedPointStyle.SHOW_NEW_TAG)
			saveData("chapterDailyNewTag", "newTag" .. slot2, slot3)
		end
	end
}
