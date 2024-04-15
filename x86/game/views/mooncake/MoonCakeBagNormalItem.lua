slot0 = class("MoonCakeBagNormalItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.info_, uv0.index_)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.itemID_ = slot1
	slot0.index_ = slot2
	slot0.nameText_.text = ItemTools.getItemName(slot1)
	slot0.numText_.text = ItemTools.getItemNum(slot1)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot1)
	slot0.info_ = slot0.info_ or {}
	slot0.info_.id = slot0.itemID_
	slot0.info_.number = slot3
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

return slot0
