slot0 = class("CultureGravureEquipPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.itemControl_:GetController("state")
	slot0.previewItems = {}

	for slot4 = 1, 2 do
		slot0.previewItems[slot4] = CultureGravureEquipPreviewItem.New(slot0["previewItem_" .. slot4])
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.previewItems[1]:SetData(slot1.equipedData, slot1.state, false, slot2)
	slot0.previewItems[2]:SetData(slot1.recommendData, slot1.state, true, slot2)
	slot0.stateController_:SetSelectedState(slot1.state == "had" and "had" or "nothad")
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.previewItems) do
		slot5:Dispose()
	end

	slot0.previewItems = nil

	uv0.super.Dispose(slot0)
end

return slot0
