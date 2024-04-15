slot1 = class("ChatJumpItemView", import("game.views.chat.loopScrollView.LoopScrollViewBaseItem"))

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
		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0:GetUserID())
	end)
	slot0:AddBtnListener(slot0.jumpBtn_, nil, function ()
		uv0:JumpFunc()
	end)
	slot0:AddBtnListener(slot0.buttonContent_, nil, function ()
		manager.notify:Invoke(CHAT_REPORT, {
			reportData = {
				nick = uv0:GetNick(),
				msgID = uv0.itemData_.msgID
			},
			parentRect = uv0.rectReportParent_,
			x = uv0:CalcOffsetX(),
			y = uv0:CalcOffsetY()
		})
	end)
end

function slot1.JumpFunc(slot0)
	JumpTools.JumpToPage2(slot0.jumpLink_)
end

function slot1.GetNick(slot0)
	return slot0.itemData_.nick
end

function slot1.SetText(slot0, slot1)
end

function slot1.SetData(slot0, slot1, slot2)
	slot0.itemData_ = slot1
	slot0.jumpLink_ = slot1.jumpLink
	slot0.index_ = slot2

	if slot1.id == USER_ID then
		slot3 = PlayerData:GetPlayerInfo()
		slot0.textName_.text = slot3.nick
		slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot3.portrait)
		slot0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot3.icon_frame)
	else
		slot0.textName_.text = slot1.nick
		slot0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot1.icon].icon)
		slot0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.iconFrame)
	end

	slot0.textContent_.text = slot1.content

	slot0:Show(true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rectContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot1.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot1.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot1.Show(slot0, slot1)
	if slot0.gameObject_.activeSelf == false and slot1 == true then
		manager.notify:Invoke(CHAT_REPORT_HIDE)
	end

	SetActive(slot0.gameObject_, slot1)
end

function slot1.CalcOffsetX(slot0)
	return slot0.rectReportParent_:InverseTransformPoint(slot0.rectBg_:TransformPoint(Vector3(slot0.rectBg_.rect.width / 2, 0, 0))).x
end

function slot1.CalcOffsetY(slot0)
	if slot0.rectReportParent_:InverseTransformPoint(slot0.rectScrollView_:TransformPoint(Vector3.zero)).y < slot0.rectReportParent_.rect.height / 2 then
		return slot1.y + slot2 - slot0.rectReportParent_:TransformPoint(Vector3(0, slot1.y + slot2, 0)).y - 20
	else
		return 0
	end
end

return slot1
