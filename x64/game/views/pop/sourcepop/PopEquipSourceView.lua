slot0 = class("PopEquipSourceView", import("game.views.pop.PopItemView"))

function slot0.OnEnter(slot0)
	slot0.equipInfo_ = slot0.params_.equip_info or {}

	uv0.super.OnEnter(slot0)

	slot0.itemList_ = {}

	slot0:RefreshItem()

	if slot0.params_.suitID then
		slot0:CustomizeForSuit(slot0.params_.suitID)
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	uv0.super.OnExit(slot0)
end

function slot0.CustomInitUI(slot0)
	uv0.super.CustomInitUI(slot0)
	slot0.btnShowControllerController:SetSelectedState("hide")
	slot0.tabControllerController:SetSelectedState("source")
end

function slot0.CustomizeForSuit(slot0, slot1)
	slot0.nameText_.text = GetI18NText(EquipSuitCfg[slot1].name)
end

function slot0.RefreshItem(slot0)
	slot0.sourceList = ItemTools.GetItemSourceList(slot0:GetItemID())

	slot0.sourceScroll_:StartScroll(#slot0.sourceList)
end

function slot0.OnTop(slot0)
	slot2 = ItemTools.GetItemSourceList(slot0:GetItemID())
	slot0.sourceList = slot2

	if #slot2 > 0 then
		slot0.sourceScroll_:Refresh()
	end
end

function slot0.OnJumpCallback(slot0)
	OperationRecorder.Record(slot0.lastRecord_, "jump")
end

return slot0
