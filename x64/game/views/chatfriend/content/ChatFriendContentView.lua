local var_0_0 = class("ChatFriendContentView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:InitItemPool()

	local var_1_0 = arg_1_0.viewPort_.rect.height
	local var_1_1 = arg_1_0.goItemParent_:GetComponent("VerticalLayoutGroup").spacing

	arg_1_0.loopScrollView_ = LoopScrollView.New(arg_1_0, arg_1_0.scrollView_, arg_1_0.rectGrid_, arg_1_0.viewPort_, var_1_0, var_1_1, true)

	arg_1_0:AddListeners()

	arg_1_0.onlineController_ = ControllerUtil.GetController(arg_1_0.rectOnlineState_, "online")
	arg_1_0.chatStickerView_ = ChatStickerView.New(arg_1_0.goSticker_)
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	arg_2_0.friendID_ = arg_2_1

	arg_2_0.chatStickerView_:OnEnter()
	arg_2_0:RefreshContent()

	arg_2_0.sendStickerHandler_ = handler(arg_2_0, arg_2_0.OnSendSticker)

	manager.notify:RegistListener(CHAT_SEND_STICKER, arg_2_0.sendStickerHandler_)

	arg_2_0.newMsgHandler_ = handler(arg_2_0, arg_2_0.OnReceiveMsg)

	manager.notify:RegistListener(CHAT_FRIEND_NEW_MESSAGE, arg_2_0.newMsgHandler_)

	arg_2_0.chatReportHandler_ = handler(arg_2_0, arg_2_0.OnChatReport)

	manager.notify:RegistListener(CHAT_REPORT, arg_2_0.chatReportHandler_)

	arg_2_0.chatReportHideHandler_ = handler(arg_2_0, arg_2_0.OnHideChatReport)

	manager.notify:RegistListener(CHAT_REPORT_HIDE, arg_2_0.chatReportHideHandler_)

	arg_2_0.recallMsgHandler_ = handler(arg_2_0, arg_2_0.OnRecallMsg)

	manager.notify:RegistListener(CHAT_FRIEND_CHAT_RESET, arg_2_0.recallMsgHandler_)
end

function var_0_0.OnUpdate(arg_3_0, arg_3_1)
	if arg_3_0.friendID_ == arg_3_1 then
		return
	end

	arg_3_0.friendID_ = arg_3_1

	arg_3_0:RefreshContent()
end

function var_0_0.OnExit(arg_4_0)
	manager.notify:RemoveListener(CHAT_SEND_STICKER, arg_4_0.sendStickerHandler_)
	manager.notify:RemoveListener(CHAT_FRIEND_NEW_MESSAGE, arg_4_0.newMsgHandler_)
	manager.notify:RemoveListener(CHAT_REPORT, arg_4_0.chatReportHandler_)
	manager.notify:RemoveListener(CHAT_REPORT_HIDE, arg_4_0.chatReportHideHandler_)
	manager.notify:RemoveListener(CHAT_FRIEND_CHAT_RESET, arg_4_0.recallMsgHandler_)
	arg_4_0.chatStickerView_:OnExit()
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0:DisposeItemPool()

	arg_5_0.sendStickerHandler_ = nil
	arg_5_0.newMsgHandler_ = nil
	arg_5_0.chatReportHandler_ = nil
	arg_5_0.chatReportHideHandler_ = nil
	arg_5_0.recallMsgHandler_ = nil

	if arg_5_0.chatStickerView_ then
		arg_5_0.chatStickerView_:Dispose()

		arg_5_0.chatStickerView_ = nil
	end

	arg_5_0.loopScrollView_:Dispose()

	arg_5_0.loopScrollView_ = nil

	var_0_0.super.Dispose(arg_5_0)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.buttonSend_, nil, function()
		if arg_6_0.inputField_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if ChatData:IsMuted() then
			arg_6_0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if IsAllSpace(arg_6_0.inputField_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_6_0.inputField_.text = ""

			return
		end

		local var_7_0 = GameSetting.chat_length_max.value[1]
		local var_7_1, var_7_2 = textLimit(arg_6_0.inputField_.text, var_7_0)

		arg_6_0.inputField_.text = GetI18NText(var_7_1)

		if not var_7_2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_7_0))

			return
		end

		if not nameRule(var_7_1, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(arg_6_0.inputField_.text, function(arg_8_0, arg_8_1)
			if not arg_8_0 then
				ShowTips("SENSITIVE_WORD")
			else
				if arg_6_0.inputField_.text == "" then
					return
				end

				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				ChatAction.SendFriendMsg(arg_6_0.friendID_, arg_6_0.inputField_.text, arg_8_1, function(arg_9_0)
					if isSuccess(arg_9_0.result) then
						ChatData:SetSendTextTimestamp()

						arg_6_0.inputField_.text = ""
					elseif arg_9_0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
						arg_6_0.inputField_.text = ""

						JumpTools.OpenPageByJump("chatMuted")

						return
					else
						ShowTips(arg_9_0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.CHAT_FRIEND)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonSticker_, nil, function()
		SetActive(arg_6_0.goStickerHide_, true)
		arg_6_0.chatStickerView_:Show(true)
		SetActive(arg_6_0.bgGo_, true)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonStickerHide_, nil, function()
		arg_6_0:HideStickerPanel()
		SetActive(arg_6_0.goReportTips_, false)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonNewMsg_, nil, function()
		arg_6_0.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(arg_6_0.friendID_)
		SetActive(arg_6_0.goNewMsg_, false)
		ChatFriendData:SaveRecordCnt(arg_6_0.friendID_)
		manager.notify:Invoke(CHAT_FRIEND_READ_MESSAGE, arg_6_0.friendID_)
		FriendsAction:RefreshUnread(arg_6_0.friendID_, 0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonReport_, nil, function()
		SetActive(arg_6_0.goReportTips_, false)
		SetActive(arg_6_0.goStickerHide_, false)
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = arg_6_0.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	arg_6_0:AddBtnListener(arg_6_0.buttonHead_, nil, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_6_0.friendID_)
	end)
end

function var_0_0.HideStickerPanel(arg_15_0)
	SetActive(arg_15_0.goStickerHide_, false)
	arg_15_0.chatStickerView_:Show(false)
	SetActive(arg_15_0.bgGo_, false)
end

function var_0_0.RefreshContent(arg_16_0)
	arg_16_0:RefreshTitle()
	arg_16_0.loopScrollView_:Scroll2End()
end

function var_0_0.OnSendSticker(arg_17_0, arg_17_1)
	arg_17_0:HideStickerPanel()

	if ChatData:IsMuted() then
		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_STICKER_FREQUENTLY")

		return
	end

	ChatAction.SendFriendSticker(arg_17_0.friendID_, arg_17_1, function(arg_18_0)
		if isSuccess(arg_18_0.result) then
			ChatData:SetSendStickerTimestamp()

			arg_17_0.inputField_.text = ""
		elseif arg_18_0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
			arg_17_0.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		else
			ShowTips(arg_18_0.result)
		end
	end)
end

function var_0_0.OnReceiveMsg(arg_19_0, arg_19_1)
	if arg_19_0.friendID_ ~= arg_19_1 then
		return
	end

	for iter_19_0 = 0, ChatFriendData:GetUnreadMsgCnt(arg_19_1) - 1 do
		if arg_19_0:LsGetItemData()[#arg_19_0:LsGetItemData() - iter_19_0].senderID == USER_ID then
			arg_19_0.loopScrollView_:Scroll2End()
			ChatFriendData:UpdateSeek(arg_19_0.friendID_)

			return
		end
	end

	if not arg_19_0.loopScrollView_:IsFillContent() or arg_19_0.scrollView_.verticalNormalizedPosition <= 0.0001 then
		arg_19_0.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(arg_19_0.friendID_)

		return
	end

	SetActive(arg_19_0.goNewMsg_, true)
	arg_19_0.loopScrollView_:RefreshScrollView()
end

function var_0_0.OnRecallMsg(arg_20_0, arg_20_1)
	if arg_20_0.friendID_ ~= arg_20_1 then
		return
	end

	arg_20_0.loopScrollView_:RefreshScrollView(true)
	SetActive(arg_20_0.goNewMsg_, ChatFriendData:GetUnreadMsgCnt(arg_20_1) > 0)
end

function var_0_0.OnChatReport(arg_21_0, arg_21_1)
	arg_21_0.transformReport_:SetParent(arg_21_1.parentRect.transform, false)

	arg_21_0.transformReport_.localPosition = Vector2(arg_21_1.x, arg_21_1.y)
	arg_21_0.reportData_ = arg_21_1.reportData

	SetActive(arg_21_0.goReportTips_, true)
	SetActive(arg_21_0.goStickerHide_, true)
end

function var_0_0.OnHideChatReport(arg_22_0)
	SetActive(arg_22_0.goReportTips_, false)
end

function var_0_0.RefreshTitle(arg_23_0)
	local var_23_0 = FriendsData:GetInfoByID(arg_23_0.friendID_)

	SetActive(arg_23_0.ipGo_, GameToSDK.CURRENT_SERVER == AreaConst.CHINA)

	if arg_23_0.gameObject_.activeSelf then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_0.ipGo_.transform)
	end

	arg_23_0.textIp_.text = var_23_0.ip
	arg_23_0.textNick_.text = GetI18NText(var_23_0.nick)
	arg_23_0.imageHead_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[var_23_0.icon].icon)
	arg_23_0.imageFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. var_23_0.icon_frame)
	arg_23_0.textSign_.text = GetI18NText(var_23_0.sign)

	if var_23_0.online_state == 0 then
		arg_23_0.onlineController_:SetSelectedState("on")
	else
		arg_23_0.onlineController_:SetSelectedState("off")
	end
end

function var_0_0.InitItemPool(arg_24_0)
	arg_24_0.itemSelfPool_ = {}
	arg_24_0.itemFriendPool_ = {}
	arg_24_0.historyTipsPool_ = {}
end

function var_0_0.GetSelfFreeItem(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.itemSelfPool_) do
		if iter_25_1.isFree == true then
			iter_25_1.isFree = false

			return iter_25_1
		end
	end

	local var_25_0 = ChatFriendContentItem.New(arg_25_0.goSelfItem_, arg_25_0.goItemParent_)
	local var_25_1 = {
		isFree = false,
		itemView = var_25_0
	}

	table.insert(arg_25_0.itemSelfPool_, var_25_1)

	return var_25_1
end

function var_0_0.GetFriendFreeItem(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.itemFriendPool_) do
		if iter_26_1.isFree == true then
			iter_26_1.isFree = false

			return iter_26_1
		end
	end

	local var_26_0 = ChatFriendContentItem.New(arg_26_0.goFriendItem_, arg_26_0.goItemParent_)
	local var_26_1 = {
		isFree = false,
		itemView = var_26_0
	}

	table.insert(arg_26_0.itemFriendPool_, var_26_1)

	return var_26_1
end

function var_0_0.GetHistoryTipsFreeItem(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.historyTipsPool_) do
		if iter_27_1.isFree == true then
			iter_27_1.isFree = false

			return iter_27_1
		end
	end

	local var_27_0 = ChatFriendHistoryTipsItem.New(arg_27_0.goHistoryTips_, arg_27_0.goItemParent_)
	local var_27_1 = {
		isFree = false,
		itemView = var_27_0
	}

	table.insert(arg_27_0.historyTipsPool_, var_27_1)

	return var_27_1
end

function var_0_0.DisposeItemPool(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.itemSelfPool_) do
		iter_28_1.itemView:Dispose()
	end

	arg_28_0.itemSelfPool_ = nil

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.itemFriendPool_) do
		iter_28_3.itemView:Dispose()
	end

	arg_28_0.itemFriendPool_ = nil

	for iter_28_4, iter_28_5 in ipairs(arg_28_0.historyTipsPool_) do
		iter_28_5.itemView:Dispose()
	end

	arg_28_0.historyTipsPool_ = nil
end

function var_0_0.LsAddItem(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0

	if arg_29_1.contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
		var_29_0 = arg_29_0:GetHistoryTipsFreeItem()
	elseif arg_29_1.senderID == tostring(PlayerData:GetPlayerInfo().userID) then
		var_29_0 = arg_29_0:GetSelfFreeItem()
	else
		var_29_0 = arg_29_0:GetFriendFreeItem()
	end

	var_29_0.itemView:SetData(arg_29_1, arg_29_2)

	local var_29_1 = ChatFriendData:GetUnreadMsgCnt(arg_29_0.friendID_)

	if arg_29_2 >= #arg_29_0:LsGetItemData() then
		SetActive(arg_29_0.goNewMsg_, false)
		ChatFriendData:SaveRecordCnt(arg_29_0.friendID_)
		FriendsAction:RefreshUnread(arg_29_0.friendID_, 0)
		manager.notify:Invoke(CHAT_FRIEND_READ_MESSAGE, arg_29_0.friendID_)
	else
		local var_29_2 = #arg_29_0:LsGetItemData() - arg_29_2

		if var_29_2 < var_29_1 then
			ChatFriendData:SaveRecordCnt(arg_29_0.friendID_, var_29_2)
			FriendsAction:RefreshUnread(arg_29_0.friendID_, var_29_2)
			manager.notify:Invoke(CHAT_FRIEND_READ_MESSAGE, arg_29_0.friendID_)
		end
	end

	return var_29_0
end

function var_0_0.LsUpdateItem(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_1.itemView:SetData(arg_30_2, arg_30_3)
end

function var_0_0.LsRemoveItem(arg_31_0, arg_31_1)
	arg_31_1.itemView:Show(false)

	arg_31_1.isFree = true
end

function var_0_0.LsGetItemData(arg_32_0)
	return ChatFriendData:GetCacheContent(arg_32_0.friendID_)
end

return var_0_0
