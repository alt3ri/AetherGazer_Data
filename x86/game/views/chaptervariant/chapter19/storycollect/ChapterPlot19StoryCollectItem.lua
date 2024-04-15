slot0 = class("ChapterPlot19StoryCollectItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:BindCfgUI()

	slot0.itemList_ = {}
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
end

function slot0.SetData(slot0, slot1)
	slot2 = ChapterStoryCollectCfg[slot1]
	slot0.titleText_.text = slot2.title_name
	slot3 = {}

	for slot7, slot8 in ipairs(slot2.story_id_list) do
		if ChapterTools.HasReadEventID(slot8) then
			table.insert(slot3, slot8)
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot0.itemList_[slot7] == nil then
			slot0.itemList_[slot7] = ChapterPlot19StoryCollectStoryItem.New(slot0.storyItem_, slot0.gameObject_)
		end

		slot0.itemList_[slot7]:SetData(slot8)
	end

	for slot7 = #slot0.itemList_, #slot3 + 1, -1 do
		slot0.itemList_[slot7]:Show(false)
	end
end

return slot0
