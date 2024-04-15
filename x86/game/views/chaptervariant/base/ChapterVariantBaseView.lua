slot0 = class("ChapterVariantBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Stage/ChaptePlot/ChaptePlot12UI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chapterItemList_ = {}
end

function slot0.OnEnter(slot0)
	slot4 = HOME_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		slot4
	})

	slot0.chapterClientID_ = slot0.params_.chapterClientID

	for slot4, slot5 in ipairs(ChapterClientCfg[slot0.chapterClientID_].chapter_list) do
		if slot0.chapterItemList_[slot4] == nil then
			slot0.chapterItemList_[slot4] = slot0:GetItemClass().New(slot0[string.format("chapterBtn%s_", slot4)], slot5)
		end

		slot0.chapterItemList_[slot4]:OnEnter(slot5)
	end

	for slot4 = #slot0.chapterItemList_, #ChapterClientCfg[slot0.chapterClientID_].chapter_list + 1, -1 do
		slot0.chapterItemList_[slot4]:Dispose()

		slot0.chapterItemList_[slot4] = nil
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in ipairs(slot0.chapterItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.chapterItemList_) do
		slot5:Dispose()
	end

	slot0.chapterItemList_ = nil
end

function slot0.GetItemClass(slot0)
	return ChapterVariantBaseItem
end

function slot0.AddListeners(slot0)
end

return slot0
