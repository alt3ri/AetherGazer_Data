slot0 = class("SpringPreheatLetterSelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreePopUI2"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.textItemList_ = LuaList.New(handler(slot0, slot0.IndexTextItem), slot0.textListGo_, SpringPreheatLetterSelectTextItem)
	slot0.stickerList_ = LuaList.New(handler(slot0, slot0.IndexStickerItem), slot0.stickerListGo_, SpringPreheatLetterSelectStickerItem)
	slot0.textToggleList_ = LuaList.New(handler(slot0, slot0.IndexTextToggle), slot0.textToggleListGo_, SpringPreheatLetterSelectTextToggleItem)
	slot0.previewTextItem_ = SpringPreheatLetterTextItem.New(slot0.previewTextGo_)

	slot0.previewTextItem_:SetPreviewMode(true)

	slot0.viewController_ = ControllerUtil.GetController(slot0.transform_, "view")
	slot0.btnController_ = ControllerUtil.GetController(slot0.transform_, "btn")
end

function slot0.OnEnter(slot0)
	if slot0:IsStickerMode() then
		slot0.stickerUsedList_ = slot0.params_.usedList
		slot0.stickerIndex_ = slot0.params_.index
		slot0.oldStickerId_ = slot0.params_.info.stickerId
		slot0.oldStickerSize_ = slot0.params_.info.size
		slot0.allStickerList_ = slot0:GetAllSticker()
	else
		slot0.paragIdx_ = slot0.params_.paragIdx

		slot0.previewTextItem_:SetData(slot0.paragIdx_, nil, , true)

		if slot0.params_.letterInfo then
			slot0.previewTextItem_:SetLetterInfo(slot0.params_.letterInfo)
		end

		slot0.previewTextItem_:UpdateAnim(false)
		slot0:SetToggleIndex(slot0.params_.optionIdx or 1)
	end

	slot0.lastClickItem_ = nil
	slot0.lastClickToggle_ = nil

	slot0:RefreshUI()
end

function slot0.OnTop(slot0)
	if not slot0:IsStickerMode() then
		if slot0.params_.updateAni then
			slot0.playPreviewTextAni_ = true
			slot0.params_.updateAni = false
		end

		slot0:SetToggleIndex(slot0.params_.optionIdx or 1)

		slot0.lastClickItem_ = nil
		slot0.lastClickToggle_ = nil

		slot0:RefreshUI()
	end
end

function slot0.OnExit(slot0)
	if slot0.lastClickItem_ then
		slot0.lastClickItem_:SetSelected(false)
	end

	if slot0.lastClickToggle_ then
		slot0.lastClickToggle_:SetSelected(false)
		slot0.lastClickToggle_:RefreshUI()
	end

	slot0.playPreviewTextAni_ = false
end

function slot0.Dispose(slot0)
	slot0.textItemList_:Dispose()
	slot0.textToggleList_:Dispose()
	slot0.stickerList_:Dispose()
	slot0.previewTextItem_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		uv0:OnClickOkBtn()
	end)
end

function slot0.OnClickOkBtn(slot0)
	if slot0:IsStickerMode() then
		if slot0.params_.onChangeSticker and slot0.stickerId_ ~= slot0.oldStickerID_ then
			slot0.params_.onChangeSticker(slot0.stickerIndex_, slot0.stickerId_, slot0.oldStickerSize_)
		end

		slot0:Back()
	else
		slot0:OnClickChangeLetterBtn()
	end
end

function slot0.IndexTextItem(slot0, slot1, slot2)
	slot2:SetLetterTextId(SpringPreheatData:GetLetterOptionText(SpringPreheatData:GetPlayerLetter().id, slot0.paragIdx_, slot0.sentenceIdx_, slot1))
	slot2:SetClickHandler(handler(slot0, slot0.OnClickTextItem))

	if slot0.previewTextItem_:GetLetterInfo()[slot0.sentenceIdx_] == slot2.textId or slot6 == 0 and slot1 == 1 and slot0.lastClickItem_ == nil then
		slot0.lastClickItem_ = slot2
		slot0.textId_ = slot2.textId

		slot2:SetSelected(true)
		slot0:RefreshPreviewTextUI()
	end

	slot2:SetSelected(slot0.textId_ == slot2.textId)
	slot2:RefreshUI()
end

function slot0.OnClickTextItem(slot0, slot1, slot2)
	if slot0.lastClickItem_ and slot0.lastClickItem_ ~= slot1 then
		slot0.lastClickItem_:SetSelected(false)
		slot0.lastClickItem_:RefreshUI()
	end

	slot1:SetSelected(true)
	slot1:RefreshUI()

	slot0.textId_ = slot2
	slot0.lastClickItem_ = slot1
	slot0.playPreviewTextAni_ = true

	slot0:RefreshPreviewTextUI()
end

function slot0.IndexTextToggle(slot0, slot1, slot2)
	slot2:SetIndex(slot1)
	slot2:SetClickHandler(handler(slot0, slot0.OnClickTextToggle))

	if slot1 == slot0.toggleIndex_ and slot0.lastClickToggle_ == nil then
		slot0.lastClickToggle_ = slot2

		slot0:SetToggleIndex(slot1)
	end

	slot2:SetSelected(slot1 == slot0.toggleIndex_)
	slot2:RefreshUI()
end

function slot0.OnClickTextToggle(slot0, slot1, slot2)
	if slot0.lastClickToggle_ == slot1 then
		return
	end

	if slot0.lastClickToggle_ then
		slot0.lastClickToggle_:SetSelected(false)
		slot0.lastClickToggle_:RefreshUI()
	end

	slot1:SetSelected(true)
	slot1:RefreshUI()
	slot0:SetToggleIndex(slot2)

	slot0.lastClickToggle_ = slot1

	if slot0.lastClickItem_ then
		slot0.lastClickItem_:SetSelected(false)

		slot0.lastClickItem_ = nil
	end

	slot0.playPreviewTextAni_ = true

	slot0:RefreshTextListUI()
end

function slot0.IndexStickerItem(slot0, slot1, slot2)
	slot2:RefreshItem(slot1 == 1 and 0 or slot0.allStickerList_[slot1 - 1].id)

	if slot1 == 1 and slot0.lastClickItem_ == nil then
		slot0.lastClickItem_ = slot2
		slot0.stickerId_ = 0
	end

	if slot0.stickerId_ == slot3 then
		slot0.lastClickItem_ = slot2
	end

	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelected(slot3 == slot0.stickerId_)
	slot2:RegisterClickListener(function ()
		uv0:OnClickStickerItem(uv1, uv2, uv3)
	end)
end

function slot0.OnClickStickerItem(slot0, slot1, slot2)
	if not slot1:TrySelect() then
		ShowTips("SPRING_PREHEAT_STICKER_LOCKED")

		return
	end

	if slot0.lastClickItem_ and slot1 ~= slot0.lastClickItem_ then
		slot0.lastClickItem_:SetSelected(false)
	end

	slot0.stickerId_ = slot2
	slot0.lastClickItem_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0.viewController_:SetSelectedState(slot0:IsStickerMode() and "sticker" or "text")

	if slot0:IsStickerMode() then
		slot0:RefreshStickersUI()
	else
		slot0.textToggleList_:StartScroll(SpringPreheatData:GetOptionCount(slot0.paragIdx_))
		slot0.textToggleList_:Refresh()
		slot0:RefreshTextListUI()
		slot0:RefreshPreviewTextUI()

		slot0.titleText_.text = GetTips(string.format("SPRING_PREHEAT_WORD_TITLE_%d", slot0.paragIdx_))
	end
end

function slot0.RefreshTextListUI(slot0)
	slot0.textItemList_:StartScroll(#slot0:GetTextIdList(slot0.sentenceIdx_))
	slot0.textItemList_:Refresh()
	slot0:RefreshPreviewTextUI()
end

function slot0.RefreshStickersUI(slot0)
	slot0.stickerList_:StartScroll(#slot0.allStickerList_ + 1)

	slot0.titleText_.text = GetTips("SPRING_PREHEAT_STICKER_TITLE")
end

function slot0.RefreshPreviewTextUI(slot0)
	if slot0.previewTextItem_:GetLetterInfo()[slot0.sentenceIdx_] ~= slot0.textId_ then
		if slot0.playPreviewTextAni_ then
			slot0.previewTextItem_:UpdateAnim(true, "IndiaWishingTreePopUI2_text")

			slot0.playPreviewTextAni_ = false
		end

		slot0.previewTextItem_:SetLetterInfo({
			[slot0.sentenceIdx_] = slot0.textId_
		})
		slot0.previewTextItem_:RefreshUI()
	end

	slot0.btnController_:SetSelectedState(slot0.previewTextItem_:IsComplete() and "yes" or "no")
end

function slot0.OnClickChangeLetterBtn(slot0)
	if not slot0.previewTextItem_:IsComplete() then
		return
	end

	if slot0.params_.onChangeFullLetter then
		slot0.params_.onChangeFullLetter(slot0.previewTextItem_:GetLetterInfo())
	end

	slot0:Back()
end

function slot0.SetToggleIndex(slot0, slot1)
	slot0.toggleIndex_ = slot1
	slot0.sentenceIdx_ = SpringPreheatData:GetSentenceIdx(slot0.paragIdx_, slot0.toggleIndex_)
	slot0.textId_ = slot0.previewTextItem_:GetLetterInfo()[slot0.sentenceIdx_]
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityId
end

function slot0.IsStickerMode(slot0)
	return slot0.params_.isStickerMode
end

function slot0.GetTextIdList(slot0, slot1)
	return SpringPreheatData:GetLetterOptionList(SpringPreheatData:GetPlayerLetter().id, slot0.paragIdx_, slot1)
end

function slot0.GetAllSticker(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(PlayerData:GetStickerList()) do
		slot8 = PlayerData:GetSticker(slot6)

		if ItemCfg[slot6].sub_type ~= 1302 or slot8.unlock ~= 0 then
			table.insert(slot1, slot8)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if uv0:IsUsed(slot0.id) and uv0:IsUsed(slot1.id) then
			return table.indexof(uv0.stickerUsedList_, slot0.id) < table.indexof(uv0.stickerUsedList_, slot1.id)
		elseif slot2 or slot3 then
			return slot2
		end

		if slot0.unlock ~= slot1.unlock then
			return slot1.unlock < slot0.unlock
		end

		return slot0.id < slot1.id
	end)

	return slot1
end

function slot0.IsUsed(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.stickerUsedList_) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

return slot0
