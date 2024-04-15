slot1 = class("SpringPreheatChooseStickersView", require("game.views.Sticker.ChooseStickersView"))

function slot1.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.sizeTgl_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0.curSize_ = uv1

			uv0:RefreshIcon()
			uv0:RefreshBtn()
			uv0:RefreshSize()

			if uv0.curID_ == uv0.oldStickerID_ then
				if uv0.params_.onChangeStickerSize then
					uv0.params_.onChangeStickerSize(uv0.curIndex_, uv0.curID_, uv0.curSize_)
				end

				uv0:Back()
			end
		end)
	end

	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		if uv0.curID_ == uv0.oldStickerID_ and uv0.curSize_ == uv0.info_.size then
			uv0.curID_ = 0
		end

		if uv0.params_.onChangeSticker then
			uv0.params_.onChangeSticker(uv0.curIndex_, uv0.curID_, uv0.curSize_)
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

return slot1
