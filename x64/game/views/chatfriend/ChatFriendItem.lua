local var_0_0 = import("game.views.chat.chatItem.ChatBaseItemView")
local var_0_1 = class("ChatFriendItem", var_0_0)

function var_0_1.Init(arg_1_0)
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.onlineController_ = ControllerUtil.GetController(arg_1_0.rectOnlineState_, "conName")
	arg_1_0.textExtension_ = arg_1_0.goContent_:GetComponent(typeof(TextExtension))
	arg_1_0.canRemoveFlag_ = true
	arg_1_0.refreshRedPointHandler_ = handler(arg_1_0, arg_1_0.RefreshRedPoint)
	arg_1_0.refreshAllHandler_ = handler(arg_1_0, arg_1_0.RefreshAll)
end

function var_0_1.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.buttonGo_, nil, function()
		arg_2_0:Go("/chatFriend", {
			friendID = arg_2_0.friendID_
		})
	end)
	arg_2_0.scrollView_.onValueChanged:AddListener(function(arg_4_0)
		if arg_4_0.x == 0 or arg_4_0.x == 1 then
			arg_2_0.canRemoveFlag_ = true
		end

		if arg_2_0.canRemoveFlag_ == false then
			arg_2_0.scrollView_.horizontalNormalizedPosition = 0

			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.rectScrollView_)
		end

		if math.abs(arg_4_0.x) > 350 and arg_2_0.canRemoveFlag_ then
			arg_2_0.canRemoveFlag_ = false

			arg_2_0:Show(false)
			manager.notify:Invoke(CHAT_FRIEND_CLOSE_ITEM, arg_2_0.friendID_)
			ChatFriendData:SaveRecordCnt(arg_2_0.friendID_)
			FriendsAction:RefreshUnread(arg_2_0.friendID_, 0)
		end
	end)
end

function var_0_1.RefreshText(arg_5_0, arg_5_1)
	local var_5_0 = ChatFriendData:GetFriendList(arg_5_1)
	local var_5_1 = ""
	local var_5_2 = var_5_0.timestamp
	local var_5_3 = ChatFriendData:GetLastMsgData(arg_5_1)

	if var_5_3 then
		if var_5_3.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_5_1 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_5_3.content)].name))
		else
			var_5_1 = var_5_3.content
		end

		if var_5_3.timestamp then
			var_5_2 = var_5_3.timestamp
		end
	end

	arg_5_0.textExtension_:SetText(var_5_1)

	arg_5_0.textTime_.text = manager.time:FormatChatTime(var_5_2)
end

function var_0_1.RefreshRedPoint(arg_6_0, arg_6_1)
	if arg_6_0.friendID_ == arg_6_1 then
		local var_6_0 = ChatFriendData:GetUnreadMsgCnt(arg_6_1)

		if var_6_0 <= 0 then
			SetActive(arg_6_0.goNotice_, false)
		else
			SetActive(arg_6_0.goNotice_, true)

			arg_6_0.textNoticeCnt_.text = var_6_0
		end
	end
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0, arg_7_1)

	if arg_7_1 then
		if not arg_7_0.isRegister_ then
			manager.notify:RegistListener(CHAT_FRIEND_READ_MESSAGE, arg_7_0.refreshRedPointHandler_)
			manager.notify:RegistListener(CHAT_FRIEND_CHAT_RESET, arg_7_0.refreshAllHandler_)

			arg_7_0.isRegister_ = true
		end
	elseif arg_7_0.isRegister_ then
		manager.notify:RemoveListener(CHAT_FRIEND_READ_MESSAGE, arg_7_0.refreshRedPointHandler_)
		manager.notify:RemoveListener(CHAT_FRIEND_CHAT_RESET, arg_7_0.refreshAllHandler_)

		arg_7_0.isRegister_ = false
	end
end

function var_0_1.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.friendID_ = arg_8_1
	arg_8_0.index_ = arg_8_2

	arg_8_0:RefreshHead(arg_8_1)
	arg_8_0:RefreshAll(arg_8_1)
	arg_8_0:SetSelectID(arg_8_3)
	arg_8_0:Show(true)

	arg_8_0.scrollView_.horizontalNormalizedPosition = 0

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.rectScrollView_)
end

function var_0_1.RefreshAll(arg_9_0, arg_9_1)
	if arg_9_0.friendID_ ~= arg_9_1 then
		return
	end

	arg_9_0:RefreshText(arg_9_1)
	arg_9_0:RefreshRedPoint(arg_9_1)
end

function var_0_1.RefreshHead(arg_10_0, arg_10_1)
	if arg_10_1 == USER_ID then
		local var_10_0 = PlayerData:GetPlayerInfo()

		arg_10_0.textNick_.text = GetI18NText(var_10_0.nick)
		arg_10_0.imageHead_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[var_10_0.portrait].icon)
		arg_10_0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_10_0.icon_frame)
	else
		local var_10_1 = FriendsData:GetInfoByID(arg_10_1)

		if var_10_1 == false then
			print("unfind friend data", arg_10_1)
			arg_10_0:Show(false)

			return
		end

		arg_10_0.textNick_.text = GetI18NText(var_10_1.nick)
		arg_10_0.imageHead_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[var_10_1.icon].icon)
		arg_10_0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_10_1.icon_frame)

		if var_10_1.online_state == 0 then
			arg_10_0.onlineController_:SetSelectedState("on")
		else
			arg_10_0.onlineController_:SetSelectedState("off")
		end
	end
end

function var_0_1.GetFriendID(arg_11_0)
	return arg_11_0.friendID_
end

function var_0_1.SetSelectID(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0.friendID_ then
		arg_12_0.selectController_:SetSelectedState("selected")
	else
		arg_12_0.selectController_:SetSelectedState("nor")
	end
end

function var_0_1.Dispose(arg_13_0)
	if arg_13_0.isRegister_ then
		manager.notify:RemoveListener(CHAT_FRIEND_READ_MESSAGE, arg_13_0.refreshRedPointHandler_)
		manager.notify:RemoveListener(CHAT_FRIEND_CHAT_RESET, arg_13_0.refreshAllHandler_)

		arg_13_0.isRegister_ = false
	end

	arg_13_0.refreshRedPointHandler_ = nil
	arg_13_0.refreshAllHandler_ = nil

	var_0_1.super.Dispose(arg_13_0)
end

return var_0_1
