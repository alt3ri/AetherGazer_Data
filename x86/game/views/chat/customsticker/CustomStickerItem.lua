slot0 = class("CustomStickerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.SetData(slot0, slot1)
	slot0.isLock_ = ChatStickerCfg[slot1].free == 0 and ChatStickerData:IsLockSticker(slot1) or false

	if slot0.isLock_ then
		slot0.lockController_:SetSelectedState("true")
	else
		slot0.lockController_:SetSelectedState("false")
	end

	if slot0.id_ == slot1 then
		return
	end

	slot0.id_ = slot1
	slot0.descSource_ = slot2.desc_source

	slot0:RefreshSelectState()
	slot0:DestroySticker()

	if slot2.type == 1 then
		slot0.lockController_:SetSelectedState("false")

		slot0.icon_.sprite = getSpriteViaConfig("ChatSticker", slot2.icon .. SettingData:GetCurrentLanguageKey())
		slot0.icon_.enabled = true
	else
		slot0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(slot2.icon .. SettingData:GetCurrentLanguageKey()), slot0.dynamicTf_)
		slot0.icon_.enabled = false
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:DestroySticker()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if not table.keyof(ChatStickerData:GetCustomStickerUIList(), uv0.id_) and GameSetting.chat_sticker_custom_max_cnt.value[1] <= #slot1 then
			ShowTips("CHAT_CUSTOM_STICKER_LIMIT_EXCEEDED")

			return
		end

		if uv0.isLock_ then
			if uv0.descSource_ == "" then
				ShowTips("CHAT_DYNAMIC_STICKER_LOCK")
			else
				ShowTips(uv0.descSource_)
			end

			return
		end

		ChatStickerData:ChangeCustomStickerUIList(uv0.id_)
		uv0:RefreshSelectState()
		manager.notify:Invoke(CHAT_CUSTOM_STICKER_CHANGED)
	end)
end

function slot0.RefreshSelectState(slot0)
	if table.keyof(ChatStickerData:GetCustomStickerUIList(), slot0.id_) then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
	end
end

function slot0.DestroySticker(slot0)
	if slot0.dynamicStickerGo_ then
		Object.Destroy(slot0.dynamicStickerGo_)

		slot0.dynamicStickerGo_ = nil
	end
end

return slot0
