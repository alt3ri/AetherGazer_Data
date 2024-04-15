slot0 = class("PopItemSourceView", import("game.views.pop.PopItemView"))

function slot0.Init(slot0)
	uv0.super.Init(slot0)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot1 = nil

	if slot0.itemInfo_.number then
		slot1 = slot0.itemInfo_.number
	end

	if ItemCfg[slot0.itemInfo_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		slot0.tabControllerController:SetSelectedState("source")
	end

	slot0.itemList_ = {}

	slot0:RefreshItem()

	if ItemCfg[slot0:GetItemID()] and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == slot3.sub_type then
		slot0.probabilityController:SetSelectedState("show")
	else
		slot0.probabilityController:SetSelectedState("notshow")
	end
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil
end

function slot0.CustomInitUI(slot0)
	uv0.super.CustomInitUI(slot0)
	slot0.btnShowControllerController:SetSelectedState("show")
	slot0.tabControllerController:SetSelectedState("source")
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		uv0.tabControllerController:SetSelectedState("descripe")
		OperationRecorder.Record(uv0.lastRecord_, "popSourceItem_sourceBtn")
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		uv0.tabControllerController:SetSelectedState("source")
	end)
	slot0:AddBtnListener(nil, slot0.m_probabilityBtn, function ()
		JumpTools.OpenPageByJump("popFukubukuroProbability", {
			itemId = uv0:GetItemID()
		})
	end)
end

function slot0.RefreshItem(slot0)
	slot2 = ItemTools.GetItemSourceList(slot0:GetItemID())
	slot0.sourceList = slot2

	if #slot2 > 0 then
		slot0.btnShowControllerController:SetSelectedState("show")
	else
		slot0:ShowInfo()
	end

	slot0.sourceScroll_:StartScroll(#slot2)
end

function slot0.OnTop(slot0)
	slot2 = ItemTools.GetItemSourceList(slot0:GetItemID())
	slot0.sourceList = slot2

	if #slot2 > 0 then
		slot0.btnShowControllerController:SetSelectedState("show")
	else
		slot0:ShowInfo()
	end

	slot0.sourceScroll_:Refresh()
end

function slot0.OnJumpCallback(slot0)
	OperationRecorder.Record(slot0.lastRecord_, "jump")
end

return slot0
