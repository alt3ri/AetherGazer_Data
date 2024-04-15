slot0 = class("ShopLabelItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot3 = ""

	if BackHomeFurniture[slot1] then
		slot3 = DormTools:GetFurLableDesc(slot1, slot2)
	end

	slot0.textText_.text = slot3
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
