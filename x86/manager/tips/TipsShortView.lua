slot0 = import("manager.tips.TipsShortItemView")
slot1 = 1
slot2 = class("TipsShortView")

function slot2.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()

	slot0.itemList_ = {}
	slot0.queue_ = {}
end

function slot2.InitUI(slot0)
	slot0.tips_ = slot0.transform_:Find("shortTip").gameObject
	slot0.grid_ = slot0.transform_:Find("shortGrid").gameObject
end

function slot2.ShowTips(slot0, slot1, slot2, slot3)
	if slot0.itemList_ == nil then
		return
	end

	slot0:GetFreeItem():RefreshUI(slot1, slot2, slot3)
end

function slot2.GetFreeItem(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		if slot5:IsFree() then
			table.insert(slot0.queue_, slot4)

			return slot5
		end
	end

	if #slot0.itemList_ < uv0 then
		slot1 = uv1.New(slot0, slot0.tips_, slot0.grid_)

		table.insert(slot0.itemList_, slot1)
		table.insert(slot0.queue_, #slot0.itemList_)

		return slot1
	end

	slot1 = slot0.queue_[1]

	table.remove(slot0.queue_, 1)
	table.insert(slot0.queue_, slot1)
	slot0.itemList_[slot1]:FastFinish()

	return slot0.itemList_[slot1]
end

function slot2.Finish(slot0)
	table.remove(slot0.queue_, 1)
	slot0.itemList_[slot0.queue_[1]]:SetFree(true)
end

function slot2.Dispose(slot0)
	if slot0.itemList_ then
		for slot4, slot5 in ipairs(slot0.itemList_) do
			slot5:Dispose()
		end

		slot0.itemList_ = nil
	end

	slot0.tips_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.grid_ = nil
end

return slot2
