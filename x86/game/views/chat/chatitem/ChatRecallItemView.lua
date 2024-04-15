slot1 = class("ChatRecallItemView", import("game.views.chat.loopScrollView.LoopScrollViewBaseItem"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:Show(true)
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot1.GetUserID(slot0)
	return slot0.itemData_.id
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonHead_, nil, function ()
		if CooperationData:CheckInRoom() then
			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0:GetUserID())
	end)
	slot0:AddBtnListener(slot0.copyBtn_, nil, function ()
		ShowTips("COPY_SUCCESS")

		UnityEngine.GUIUtility.systemCopyBuffer = uv0.textContent_.text
	end)
end

function slot1.GetNick(slot0)
	return slot0.itemData_.nick
end

function slot1.SetText(slot0, slot1)
	if slot1.id == USER_ID then
		slot2 = PlayerData:GetPlayerInfo()
		slot0.textName_.text = GetI18NText(slot2.nick)
		slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot2.portrait)
		slot0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)
	else
		slot0.textName_.text = GetI18NText(slot1.nick)
		slot0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot1.icon].icon)
		slot0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.iconFrame)
	end

	slot0.textContent_.text = GetI18NText(slot1.content)
	slot0.tipsText_.text = GetTips("RECALLED_SHARE_TIPS")

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectGo_)
end

function slot1.SetData(slot0, slot1, slot2)
	slot0.itemData_ = slot1
	slot0.index_ = slot2

	slot0:Show(true)
	slot0:SetText(slot1)
	slot0:SetIP(slot0.itemData_)
end

function slot1.SetIP(slot0, slot1)
	if not slot0.ipGo_ then
		return
	end

	slot0.ip_.text = slot1.ip

	SetActive(slot0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if slot0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.ipGo_.transform)
	end
end

function slot1.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot1.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot1.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot1
