slot0 = class("NewHeroChipListItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chipItemGo_ = slot2

	slot0:BindCfgUI()

	slot0.chipItemList_ = {}
end

function slot0.RefreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.chipList_) do
		if slot0.chipItemList_[slot4] == nil then
			slot6 = NewHeroChipItem.New(Object.Instantiate(slot0.chipItemGo_, slot0.chipContent_))
			slot0.chipItemList_[slot4] = slot6

			slot6:SetCallBack(slot0.chipClickCallBack_)
		end

		SetActive(slot6.gameObject_, true)
		slot6:SetData(slot0.chipList_[slot4], slot0.curChipID_)
	end

	for slot4 = #slot0.chipList_ + 1, #slot0.chipItemList_ do
		SetActive(slot0.chipItemList_[slot4].gameObject_, false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.chipContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.heroID_ = slot1
	slot0.chipList_ = slot2
	slot0.curChipID_ = slot3

	slot0:RefreshUI()
end

function slot0.SetChipClickCallBack(slot0, slot1)
	slot0.chipClickCallBack_ = slot1
end

function slot0.SetIsShow(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.chipItemList_) do
		slot5:Dispose()
	end

	slot0.chipItemList_ = nil
	slot0.chipClickCallBack_ = nil
end

return slot0
