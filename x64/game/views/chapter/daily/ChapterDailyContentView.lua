slot0 = class("ChapterDailyContentView", import("..ChapterBaseContentView"))

function slot0.RefreshMapItems(slot0)
	for slot6 = #slot0.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[slot0.chapterToggle_] do
		if slot0:CreateItem(slot2[slot6]) then
			table.insert(slot0.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(slot0.mapVirtualItem_, slot0.itemParent_),
				renderItem = slot8
			})
		end
	end
end

function slot0.CreateItem(slot0, slot1)
	return ChapterDailyItemView.New(slot0.mapItem_, slot0.itemParent_, slot1, slot0.chapterToggle_)
end

return slot0
