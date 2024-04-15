ChapterVariantBaseItem = import("game.views.chapterVariant.base.ChapterVariantBaseItem")
slot0 = class("ChapterVariant16Item", ChapterVariantBaseItem)

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot0.chapterID_))
end

return slot0
