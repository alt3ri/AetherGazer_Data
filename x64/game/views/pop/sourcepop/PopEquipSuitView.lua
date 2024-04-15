slot0 = class("PopEquipSuitView", import("game.views.sectionSelect.equip.SuitSelectView"))

function slot0.InitUI(slot0)
	slot0.super.InitUI(slot0)

	slot0.popController = slot0.controller:GetController("state")
end

function slot0.OnEnter(slot0)
	slot0.super.OnEnter(slot0)
end

function slot0.UpdateData(slot0)
	slot0.suitList_ = {}

	table.insert(slot0.suitList_, slot0.params_.suitId)
end

function slot0.OnExit(slot0)
	slot0.super.OnExit(slot0)
end

return slot0
