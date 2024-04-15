slot0 = class("ChapterEquipContentView", import("..ChapterBaseContentView"))

function slot0.RefreshMapItems(slot0)
	for slot6 = #slot0.itemList_ + 1, #ChapterClientCfg.get_id_list_by_toggle[slot0.chapterToggle_] do
		slot7 = nil

		if (slot2[slot6] ~= 203 or ChapterEquipEnchantmentItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot1)) and (slot2[slot6] ~= 204 or ChapterEquipExperienceItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot1)) and (slot2[slot6] ~= 205 or ChapterEquipSeizureItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot1)) and ChapterEquipItemView.New(slot0.mapItem_, slot0.itemParent_, slot2[slot6], slot1) then
			table.insert(slot0.itemList_, {
				virtualItem = ChapterBaseVirtualItemView.New(slot0.mapVirtualItem_, slot0.itemParent_),
				renderItem = slot7
			})
		end
	end
end

return slot0
