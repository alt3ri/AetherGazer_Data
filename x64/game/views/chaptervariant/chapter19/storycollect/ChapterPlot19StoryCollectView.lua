slot0 = class("ChapterPlot19StoryCollectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationVerStoryUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemList_ = {}
end

function slot0.OnEnter(slot0)
	slot0.chapterID_ = slot0.params_.chapterID

	slot0:RefreshItemList()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.RefreshItemList(slot0)
	for slot5, slot6 in ipairs(slot0:GetItemDataList()) do
		if slot0.itemList_[slot5] == nil then
			slot0.itemList_[slot5] = ChapterPlot19StoryCollectItem.New(slot0.item_, slot0.itemParent_)
		end

		slot0.itemList_[slot5]:SetData(slot6)
	end

	for slot5 = #slot0.itemList_, #slot1 + 1, -1 do
		slot0.itemList_[slot5]:Dispose()

		slot0.itemList_[slot5] = nil
	end
end

function slot0.GetItemDataList(slot0)
	slot1 = {}
	slot5 = slot0.chapterID_

	for slot5, slot6 in ipairs(ChapterStoryCollectCfg.get_id_list_by_chapter_id[slot5]) do
		if ChapterTools.HasReadEvent(slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

return slot0
