slot0 = class("SummerStorySeabedRemasterdItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0.unLockState_ = BattleStageData:GetStageData()[ChapterCfg[slot0.chapterID_].section_id_list[1]] ~= nil

	manager.redPoint:bindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
	slot0:RefreshState()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0.chapterID_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if not uv0.unLockState_ then
			ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")

			return
		end

		slot0 = getChapterClientCfgByChapterID(uv0.chapterID_)

		BattleFieldData:SetCacheChapterClient(getChapterToggle(slot0.id), slot0.id)
		BattleFieldData:SetCacheChapter(slot0.id, uv0.chapterID_)
		BattleStageAction.ClickSubPlot(uv0.chapterID_)
		uv0:Go("/summerSeabedStoryRemastered", {
			chapterID = uv0.chapterID_
		})
	end)
end

function slot0.RefreshState(slot0)
	slot0.timeText_.text = ""

	if slot0.unLockState_ then
		slot0.controller_:SetSelectedState("on")
	else
		slot0.controller_:SetSelectedState("off")
	end
end

return slot0
