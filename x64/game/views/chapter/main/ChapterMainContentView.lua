slot0 = class("ChapterMainContentView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterToggle_ = slot2

	slot0:BindCfgUI()

	slot0.mainPlotPanelView_ = ChapterMainPlotPanelView.New(slot0.chapterGo_)
	slot0.subPlotPanelView_ = ChapterSubPlotPanelView.New(slot0.subPlotGo_)
	slot0.lnkView_ = ChapterChallengeLnkView.New(slot0.lnkPanelGo_)
end

function slot0.OnEnter(slot0)
	slot0.mainPlotPanelView_:OnEnter()
	slot0.subPlotPanelView_:OnEnter()

	slot2 = {
		RedPointConst.COMBAT_PLOT,
		RedPointConst.COMBAT_SUB_PLOT
	}

	for slot6, slot7 in ipairs(ChapterTools.GetChapterChallengeLnkList()) do
		table.insert(slot2, ChapterTools.GetRedPoint(slot7))
	end

	manager.redPoint:addGroup(RedPointConst.COMBAT_MAIN, slot2, true)
	manager.redPoint:bindUIandKey(slot0.chapterNameGo_.transform, RedPointConst.COMBAT_PLOT)
	slot0.lnkView_:OnEnter(slot1)
end

function slot0.OnExit(slot0)
	slot0.mainPlotPanelView_:OnExit()
	slot0.subPlotPanelView_:OnExit()
	manager.redPoint:unbindUIandKey(slot0.chapterNameGo_.transform, RedPointConst.COMBAT_PLOT)
	slot0.lnkView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.mainPlotPanelView_:Dispose()

	slot0.mainPlotPanelView_ = nil

	slot0.subPlotPanelView_:Dispose()

	slot0.subPlotPanelView_ = nil

	slot0.lnkView_:Dispose()

	slot0.lnkView_ = nil

	uv0.super.Dispose(slot0)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
	SetActive(slot0.plotExPanel_, slot1)
end

return slot0
