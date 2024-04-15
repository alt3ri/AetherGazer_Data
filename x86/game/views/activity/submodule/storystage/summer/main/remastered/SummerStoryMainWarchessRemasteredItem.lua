SummerStoryMainWarchessItem = import("game.views.activity.Submodule.storyStage.summer.main.SummerStoryMainWarchessItem")
slot0 = class("SummerStoryMainWarchessRemasteredItem", SummerStoryMainWarchessItem)

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ChessConst.SUBPLOT_TAG.ISLAND, slot0.chapterID_))
	slot0:RefreshState()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, ChessConst.SUBPLOT_TAG.ISLAND, slot0.chapterID_))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0:IsPrestageLock() then
			slot1 = WarchessLevelCfg[uv0.chapterID_]

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(GetTips("CHESS_NAME_" .. slot1.tag)), WarchessLevelCfg[slot1.unlock_level].name_level))

			return
		end

		if uv0:IsLock() then
			if WarchessLevelCfg[uv0.chapterID_].unlock_condition[1] == 1 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[slot0[2][1]].name), BattleActivityStoryStageCfg[slot0[2][2]].name))
			elseif slot0[1] == 2 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ChapterCfg[slot0[2][1]].subhead), BattleActivityStoryStageCfg[slot0[2][2]].name))
			end

			return
		end

		ChessTools.EnterChessMap(uv0.chapterID_, true)
	end)
end

function slot0.IsLock(slot0)
	if WarchessLevelCfg[slot0.chapterID_].unlock_condition ~= "" then
		if slot2[1] == 1 then
			if not StoryStageActivityData:GetStageData(slot2[2][1])[slot2[2][2]] or slot3.clear_times < 1 then
				return true
			end
		elseif slot2[1] == 2 then
			return not ChapterTools.IsClearStage(slot2[2][2])
		end
	end

	return false
end

function slot0.RefreshState(slot0)
	slot2 = WarChessData:GetCurrentChapter(WarchessLevelCfg[slot0.chapterID_].type)

	if slot0:IsPrestageLock() or slot0:IsLock() then
		slot0.controller_:SetSelectedState("open")

		return
	end

	if slot2 == slot0.chapterID_ then
		slot0.controller_:SetSelectedState("challenge")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
