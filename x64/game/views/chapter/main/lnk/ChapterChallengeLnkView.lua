slot0 = class("ChapterChallengeLnkView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.lnkItemList_ = {}

	for slot5 = 1, 4 do
		slot0.lnkItemList_[slot5] = ChapterChallengeLnkItem.New(slot0[string.format("item%s_", slot5)])
	end
end

function slot0.OnEnter(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot0.lnkItemList_[slot5 + #slot0.lnkItemList_ - #slot1]:SetData(slot1[slot5])
	end

	for slot5 = 1, #slot0.lnkItemList_ - #slot1 do
		slot0.lnkItemList_[slot5]:Show(false)
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.lnkItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.lnkItemList_) do
		slot5:Dispose()
	end

	slot0.lnkItemList_ = nil
	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

return slot0
