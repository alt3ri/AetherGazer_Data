ChapterVariantSubPlotBaseItem = import("game.views.chapterVariant.base.ChapterVariantSubPlotBaseItem")
slot0 = class("ChapterVariantThothItem", ChapterVariantSubPlotBaseItem)

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.redPointParentTf_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.RefreshControllerState(slot0)
	if slot0.isLock_ or slot0.timeLock_ then
		slot0.controller_:SetSelectedState("timeLock")

		if slot0.timeLock_ == false and slot0.isLock_ then
			slot0.timerText_.text = GetTips("NEED_FINISH_PRE_NORMAL_STAGE")
		end
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
