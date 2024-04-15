slot0 = class("ChapterMainPlotItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
end

return slot0
