slot0 = class("ChessBagKeyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.emptyController_ = slot0.controllerExCollection_:GetController("empty")
	slot0.typeController_ = slot0.controllerExCollection_:GetController("type")
	slot0.bottomAmountController_ = slot0.controllerExCollection_:GetController("textcom")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.info_ = slot1

	slot0.emptyController_:SetSelectedState("off")
	slot0.typeController_:SetSelectedState("material")
	slot0.bottomAmountController_:SetSelectedState("on")

	slot0.iconImage_.sprite = getSpriteWithoutAtlas(slot0.info_.iconPath)
	slot0.bottomAmountText_.text = slot0.info_.number

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.bottomAmountText_.transform)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
