slot1 = class("SpringPreheatLetterSelectStickerItem", require("game.views.Sticker.StickerChooseItem"))

function slot1.RefreshItem(slot0, slot1)
	if slot1 == 0 then
		slot0.lockCon_:SetSelectedState("empty")

		slot0.itemID_ = 0

		return
	end

	uv0.super.RefreshItem(slot0, slot1)
end

function slot1.TrySelect(slot0)
	if slot0.itemID_ == 0 then
		slot0:SetSelected(true)

		return true
	end

	if PlayerData:GetSticker(slot0.itemID_).unlock == 0 then
		slot0:SetSelected(false)

		return false
	end

	slot0:SetSelected(true)

	return true
end

function slot1.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

return slot1
