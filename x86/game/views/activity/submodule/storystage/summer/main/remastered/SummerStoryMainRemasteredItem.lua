SummerStoryMainItem = import("game.views.activity.Submodule.storyStage.summer.main.SummerStoryMainItem")
slot0 = class("SummerStoryMainRemasteredItem", SummerStoryMainItem)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		slot0 = getChapterClientCfgByChapterID(uv0.chapterID_)

		BattleFieldData:SetCacheChapterClient(getChapterToggle(slot0.id), slot0.id)
		BattleFieldData:SetCacheChapter(getChapterToggle(slot0.id), uv0.chapterID_)
		BattleStageAction.ClickSubPlot(uv0.chapterID_)
		uv0:Go("/summerStoryRemastered", {
			chapterID = uv0.chapterID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = #ChapterCfg[slot0.chapterID_].section_id_list
	slot2 = (slot1 - ChapterTools.GetUnclearStageCnt(slot0.chapterID_)) / slot1
	slot0.progressText_.text = string.format("%d%%", slot2 * 100)
	slot0.slider_.fillAmount = slot2

	if slot2 < 1 then
		slot0.controller_:SetSelectedState("enter")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

return slot0
