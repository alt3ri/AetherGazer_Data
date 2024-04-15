local var_0_0 = import("game.views.chat.chatItem.ChatItemView")
local var_0_1 = class("ChatFirendContentItem", var_0_0)

function var_0_1.GetUserID(arg_1_0)
	return arg_1_0.itemData_.senderID
end

function var_0_1.GetNick(arg_2_0)
	return FriendsData:GetInfoByID(arg_2_0.itemData_.senderID).nick
end

function var_0_1.SetText(arg_3_0, arg_3_1)
	arg_3_0.textName_.text = GetI18NText(manager.time:FormatTime(arg_3_1.timestamp))

	local var_3_0 = PlayerData:GetPlayerInfo()
	local var_3_1 = tostring(var_3_0.userID)
	local var_3_2 = arg_3_1.senderID

	if var_3_2 == var_3_1 then
		arg_3_0.imageIcon_.sprite = ItemTools.getItemSprite(var_3_0.portrait)
		arg_3_0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_3_0.icon_frame)

		local var_3_3 = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]
		local var_3_4 = ChatBubbleCfg[var_3_3]

		if not var_3_4 then
			-- block empty
		end

		local var_3_5 = var_3_4.color2

		arg_3_0.textContent_.color = Color(var_3_5[1], var_3_5[2], var_3_5[3])
		arg_3_0.chatBubbleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. var_3_4.image2)
	else
		local var_3_6 = FriendsData:GetInfoByID(var_3_2)

		if var_3_6 == false then
			print("unfind friend data", var_3_2)
			arg_3_0:Show(false)

			return
		end

		arg_3_0.imageIcon_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[var_3_6.icon].icon)
		arg_3_0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_3_6.icon_frame)

		local var_3_7 = var_3_6.bubbleID or GameSetting.profile_chat_bubble_default.value[1]
		local var_3_8 = ChatBubbleCfg[var_3_7] or ChatBubbleCfg[GameSetting.profile_chat_bubble_default.value[1]]
		local var_3_9 = var_3_8.color1

		arg_3_0.textContent_.color = Color(var_3_9[1], var_3_9[2], var_3_9[3])
		arg_3_0.chatBubbleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ChatBubble/" .. var_3_8.image1)
	end
end

function var_0_1.CalcOffsetY(arg_4_0)
	local var_4_0 = arg_4_0.rectReportParent_:InverseTransformPoint(arg_4_0.rectScrollView_:TransformPoint(Vector3.zero))
	local var_4_1 = arg_4_0.rectReportParent_.rect.height / 2

	if var_4_0.y < -20 then
		return var_4_0.y + var_4_1
	else
		return 0
	end
end

return var_0_1
