slot0 = class("SectionInfoThreeStarBar", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.sectionTargets_ = {}

	for slot5 = 1, 3 do
		slot0.sectionTargets_[slot5] = SectionTargetItem.New(slot0[string.format("targetItem%s_", slot5)], slot5)
	end

	SetActive(slot0.targetPanel_, true)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.sectionTargets_) do
		slot5:Dispose()
	end

	slot0.sectionTargets_ = {}

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot0.sectionTargets_[slot5]:Refresh(slot6[1], slot6[2])
	end
end

return slot0
