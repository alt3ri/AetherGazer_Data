slot0 = class("ChapterClueView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationVerClueUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, ChapterClueItem)
end

function slot0.OnEnter(slot0)
	slot0.chapterID_ = slot0.params_.chapterID

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot1, slot2 = ChapterTools.GetChapterClueCnt(slot0.chapterID_)
	slot0.collectClueIDList_ = ChapterTools.GetChapterCollectClueList(slot0.chapterID_)

	slot0.uiList_:StartScroll(slot2)

	slot3, slot4 = ChapterTools.GetChapterClueCnt(slot0.chapterID_)
	slot0.cntText_.text = string.format("%s/%s", slot3, slot4)
end

function slot0.IndexItem(slot0, slot1, slot2)
	if slot1 > #slot0.collectClueIDList_ then
		slot2:SetData(0, slot1)
	else
		slot2:SetData(slot0.collectClueIDList_[slot1], slot1)
	end
end

function slot0.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil

	uv0.super.Dispose(slot0)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

return slot0
