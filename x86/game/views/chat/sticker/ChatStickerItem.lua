slot0 = class("ChatStickerItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.RefreshData(slot0, slot1)
	if not ChatStickerCfg[slot1] then
		return
	end

	slot0.isLock_ = slot2.free == 0 and ChatStickerData:IsLockSticker(slot1) or false

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

	slot0:DestroySticker()

	if slot2.type == 1 then
		slot0.imageIcon_.sprite = getSpriteViaConfig("ChatSticker", slot2.icon .. SettingData:GetCurrentLanguageKey())
		slot0.imageIcon_.enabled = true
	else
		slot0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(slot3), slot0.dynamicTf_)
		slot0.imageIcon_.enabled = false
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonItem_, nil, function ()
		if uv0.id_ == 0 then
			ChatStickerData:InitStickerUIList()
			JumpTools.OpenPageByJump("chatCustomSticker")

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

		manager.notify:Invoke(CHAT_SEND_STICKER, uv0.id_)
	end)
end

function slot0.DestroySticker(slot0)
	if slot0.dynamicStickerGo_ then
		Object.Destroy(slot0.dynamicStickerGo_)

		slot0.dynamicStickerGo_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:DestroySticker()

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
