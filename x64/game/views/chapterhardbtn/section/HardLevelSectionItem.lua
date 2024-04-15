slot0 = class("HardLevelSectionItem", import("..HardLevelBaseItem"))

function slot0.IsLock(slot0)
	if slot0.hardLevel_ ~= 1 and ChapterCfg[BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))].sub_type <= 1 then
		slot3 = 2
	end

	if getChapterNumList(slot3)[slot0.hardLevel_] then
		slot0.isLock_ = not ChapterTools.IsFinishPreChapter(getChapterNumList(slot3)[slot0.hardLevel_][1])
	else
		slot0.isLock_ = false
	end
end

function slot0.LockTips(slot0)
	slot6, slot7 = ChapterTools.IsFinishPreChapter(BattleFieldData:GetCacheChapter(getChapterClientCfgByChapterID(getChapterNumList(ChapterCfg[BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))].sub_type)[slot0.hardLevel_][1]).id))

	if not slot6 then
		ShowTips(ChapterTools.GetChapterLockText(slot5, slot7, true))

		return
	end

	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function slot0.ClickBtn(slot0)
	slot2 = BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))

	if slot2 ~= BattleFieldData:GetCacheChapter(getChapterClientCfgByChapterID(getChapterNumList(ChapterCfg[slot2].sub_type)[slot0.hardLevel_][1]).id) then
		slot0:Go("/chapterSection", {
			chapterID = slot5
		})
	end
end

function slot0.RefreshItem(slot0)
	uv0.super.RefreshItem(slot0)

	if slot0.hardLevel_ ~= 1 and ChapterCfg[BattleFieldData:GetCacheChapter(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT))].sub_type <= 1 then
		slot3 = 2
	end

	if getChapterNumList(slot3)[slot0.hardLevel_] then
		slot0.percentageText_.text = string.format("%s%%", math.floor(ChapterTools.GetChapterStarPercentage(getChapterNumList(slot3)[slot0.hardLevel_][1]) * 100))
	else
		slot0.percentageText_.text = "0%"
	end
end

return slot0
