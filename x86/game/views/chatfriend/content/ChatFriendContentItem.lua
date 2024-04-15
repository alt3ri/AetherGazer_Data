slot1 = class("ChatFirendContentItem", import("game.views.chat.chatItem.ChatItemView"))

function slot1.GetUserID(slot0)
	return slot0.itemData_.senderID
end

function slot1.GetNick(slot0)
	return FriendsData:GetInfoByID(slot0.itemData_.senderID).nick
end

function slot1.SetText(slot0, slot1)
	slot0.textName_.text = GetI18NText(manager.time:FormatTime(slot1.timestamp))

	if slot1.senderID == tostring(PlayerData:GetPlayerInfo().userID) then
		slot0.imageIcon_.sprite = ItemTools.getItemSprite(slot2.portrait)
		slot0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)

		if not ChatBubbleCfg[PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]] then
			-- Nothing
		end

		slot7 = slot6.color2
		slot0.textContent_.color = Color(slot7[1], slot7[2], slot7[3])
		slot0.chatBubbleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. slot6.image2)
	else
		if FriendsData:GetInfoByID(slot4) == false then
			print("unfind friend data", slot4)
			slot0:Show(false)

			return
		end

		slot0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot5.icon].icon)
		slot0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot5.icon_frame)
		slot7 = ChatBubbleCfg[slot5.bubbleID or GameSetting.profile_chat_bubble_default.value[1]] or ChatBubbleCfg[GameSetting.profile_chat_bubble_default.value[1]]
		slot8 = slot7.color1
		slot0.textContent_.color = Color(slot8[1], slot8[2], slot8[3])
		slot0.chatBubbleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. slot7.image1)
	end
end

function slot1.CalcOffsetY(slot0)
	if slot0.rectReportParent_:InverseTransformPoint(slot0.rectScrollView_:TransformPoint(Vector3.zero)).y < -20 then
		return slot1.y + slot0.rectReportParent_.rect.height / 2
	else
		return 0
	end
end

return slot1
