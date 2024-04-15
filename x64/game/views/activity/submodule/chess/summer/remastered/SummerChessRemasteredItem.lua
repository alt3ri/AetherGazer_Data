SummerStoryMainWarchessRemasteredItem = import("game.views.activity.Submodule.storyStage.summer.main.remastered.SummerStoryMainWarchessRemasteredItem")
slot0 = class("SummerChessRemasteredItem", SummerStoryMainWarchessRemasteredItem)

function slot0.RefreshUI(slot0)
	slot1 = ChessTools.GetChapterProgress(slot0.chapterID_)
	slot0.imageProgress_.fillAmount = slot1 / 100
	slot0.textProress_.text = slot1 .. "%"
	slot0.textName_.text = WarchessLevelCfg[slot0.chapterID_].name_level
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, 71012, slot0.chapterID_))
	slot0:RefreshState()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, 71012, slot0.chapterID_))
end

return slot0
