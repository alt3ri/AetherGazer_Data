slot0 = class("PopItemMergeView", PopItemSourceView)

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.mergeBtn_, nil, function ()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[uv0:GetItemID()].compose_id
		})
	end)
	slot0:AddBtnListener(slot0.decomposeBtn_, nil, function ()
		JumpTools.OpenPageByJump("synthesise", {
			id = ItemCfg[uv0:GetItemID()].decompose_id
		})
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.equipInfo_ = slot0.params_.equip_info or {}
end

function slot0.CustomInitUI(slot0)
	uv0.super.CustomInitUI(slot0)
end

function slot0.OnEnter(slot0)
	slot0.super.OnEnter(slot0)
	slot0:RefreshBtn()
end

function slot0.RefreshBtn(slot0)
	SetActive(slot0.decomposeBtn_.gameObject, ItemCfg[slot0:GetItemID()].decompose_id ~= 0 and ItemExchangeCfg[slot1.decompose_id] ~= nil)
	SetActive(slot0.mergeBtn_.gameObject, slot1.compose_id ~= 0 and ItemExchangeCfg[slot1.compose_id] ~= nil)
end

function slot0.RefreshItem(slot0)
	uv0.super.RefreshItem(slot0)

	slot0.cntText_.text = string.format("x%d", NumberTools.RetractNumberForWindBar(ItemTools.getItemNum(slot0:GetItemID())))
end

return slot0
