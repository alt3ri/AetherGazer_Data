local var_0_0 = singletonClass("ChatGuildData")

function var_0_0.Init(arg_1_0)
	arg_1_0.chatRecordData_ = getModule("chatGuild")
	arg_1_0.chatSaveRecordList_ = {}
	arg_1_0.readMsgID_ = 0
	arg_1_0.historyTipsFlag_ = false
	arg_1_0.chatRecordList_ = {}
	arg_1_0.cacheContentList_ = {}

	arg_1_0:InitCacheGuildContent()
end

function var_0_0.GetContent(arg_2_0)
	return arg_2_0.chatRecordList_
end

function var_0_0.AddChat(arg_3_0, arg_3_1)
	if arg_3_0:IsOldMsg(arg_3_1.msg_id) then
		return
	end

	local var_3_0 = arg_3_0:ParseChat(arg_3_1)

	arg_3_0:SaveRecord(var_3_0)
	table.insert(arg_3_0.chatRecordList_, var_3_0)
	arg_3_0:UpdateCacheGuildContent(arg_3_1)
end

function var_0_0.IsOldMsg(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.chatRecordList_ and #arg_4_0.chatRecordList_ or 0

	for iter_4_0 = 0, 9 do
		local var_4_1 = arg_4_0.chatRecordList_[var_4_0 - iter_4_0]

		if var_4_1 and var_4_1.msgID == arg_4_1 then
			return true
		end
	end

	return false
end

function var_0_0.ParseChat(arg_5_0, arg_5_1)
	return {
		recall = false,
		msgID = arg_5_1.msg_id,
		id = arg_5_1.id,
		nick = arg_5_1.user_profile_base.nick,
		icon = arg_5_1.user_profile_base.icon,
		iconFrame = arg_5_1.user_profile_base.icon_frame,
		timestamp = arg_5_1.timestamp,
		contentType = arg_5_1.type,
		content = arg_5_1.content,
		ip = (arg_5_1.ip_location == nil or arg_5_1.ip_location == "") and GetTips("IP_UNKNOWN") or arg_5_1.ip_location,
		bubbleID = arg_5_1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
	}
end

function var_0_0.RemoveChatData(arg_6_0)
	arg_6_0.chatRecordList_ = {}
	arg_6_0.cacheContentList_ = {}
	arg_6_0.historyTipsFlag_ = false
	arg_6_0.readMsgID_ = 0

	saveData("chatGuild", "readMsgID", 0)
	ChatTools.DeleteGuildChatCache()
end

function var_0_0.SaveRecord(arg_7_0, arg_7_1)
	arg_7_0.chatSaveRecordList_ = arg_7_0.chatSaveRecordList_ or {}

	table.insert(arg_7_0.chatSaveRecordList_, arg_7_1)
end

function var_0_0.SaveRecordCnt(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or 0
	local var_8_1 = arg_8_0.cacheContentList_[#arg_8_0.cacheContentList_ - var_8_0]

	if var_8_1 and (var_8_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_8_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER) then
		arg_8_0.readMsgID_ = var_8_1.msgID

		local var_8_2 = #arg_8_0.chatSaveRecordList_

		for iter_8_0 = #arg_8_0.chatSaveRecordList_, 1, -1 do
			if arg_8_0.chatSaveRecordList_[iter_8_0] and arg_8_0.chatSaveRecordList_[iter_8_0].msgID == var_8_1.msgID then
				var_8_2 = iter_8_0

				break
			end
		end

		local var_8_3 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

		for iter_8_1 = var_8_2 + 1, #arg_8_0.chatSaveRecordList_ do
			local var_8_4 = arg_8_0.chatSaveRecordList_[iter_8_1]

			if var_8_4 and table.keyof(var_8_3, var_8_4.id) then
				arg_8_0.readMsgID_ = arg_8_0.chatSaveRecordList_[iter_8_1].msgID
			else
				break
			end
		end

		saveData("chatGuild", "readMsgID", arg_8_0.readMsgID_)
	end
end

function var_0_0.RemoveGuildChatContent(arg_9_0, arg_9_1)
	local var_9_0 = 0

	if arg_9_0.chatRecordList_ == nil then
		return var_9_0
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.chatRecordList_) do
		if iter_9_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and iter_9_1.msgID == arg_9_1 then
			iter_9_1.recall = true

			ChatTools.ResaveGuildChatCache()

			var_9_0 = iter_9_0

			break
		end
	end

	for iter_9_2 = #arg_9_0.cacheContentList_, 1, -1 do
		local var_9_1 = arg_9_0.cacheContentList_[iter_9_2]

		if var_9_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and var_9_1.msgID == arg_9_1 then
			if arg_9_0.cacheContentList_[iter_9_2 + 1] == nil then
				table.remove(arg_9_0.cacheContentList_, iter_9_2)

				if arg_9_0.cacheContentList_[iter_9_2 - 1] then
					if arg_9_0.cacheContentList_[iter_9_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or arg_9_0.cacheContentList_[iter_9_2 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(arg_9_0.cacheContentList_, iter_9_2 - 1)

						if cacheContentList_[iter_9_2 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(arg_9_0.cacheContentList_, iter_9_2 - 2)
						end
					end

					arg_9_0.historyTipsFlag_ = false
				end

				break
			end

			table.remove(arg_9_0.cacheContentList_, iter_9_2)

			break
		end
	end

	return var_9_0
end

function var_0_0.InitCacheGuildContent(arg_10_0)
	local var_10_0 = clone(arg_10_0.chatRecordList_ or {})

	arg_10_0.historyTipsFlag_ = false

	if arg_10_0.readMsgID_ == 0 then
		arg_10_0.historyTipsFlag_ = true
	end

	local var_10_1 = 0

	for iter_10_0 = #var_10_0, 1, -1 do
		if var_10_0[iter_10_0].recall == true then
			table.remove(var_10_0, iter_10_0)
		end
	end

	arg_10_0.cacheContentList_ = {}

	local var_10_2 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	for iter_10_1, iter_10_2 in ipairs(var_10_0) do
		if iter_10_1 == 1 or iter_10_2.timestamp - var_10_0[iter_10_1 - 1].timestamp > ChatConst.MESSAGE_SPACE then
			local var_10_3 = {
				timestamp = iter_10_2.timestamp,
				contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
			}

			if not table.keyof(var_10_2, iter_10_2.id) then
				table.insert(arg_10_0.cacheContentList_, var_10_3)
			end
		end

		if not table.keyof(var_10_2, iter_10_2.id) then
			table.insert(arg_10_0.cacheContentList_, iter_10_2)
		end

		if arg_10_0.readMsgID_ ~= 0 and var_10_0[iter_10_1].msgID == arg_10_0.readMsgID_ and var_10_0[iter_10_1 + 1] and not table.keyof(var_10_2, var_10_0[iter_10_1 + 1].id) then
			arg_10_0.historyTipsFlag_ = true

			table.insert(arg_10_0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = var_10_0[iter_10_1].timestamp
			})

			var_10_1 = #arg_10_0.cacheContentList_
		end
	end

	return var_10_1 ~= 0 and var_10_1 or #arg_10_0.cacheContentList_
end

function var_0_0.UpdateCacheGuildContent(arg_11_0, arg_11_1)
	local var_11_0 = USER_ID
	local var_11_1 = FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST)

	if table.keyof(var_11_1, arg_11_1.id) then
		return
	end

	if arg_11_0.historyTipsFlag_ ~= true then
		if arg_11_1.id ~= var_11_0 then
			table.insert(arg_11_0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = arg_11_1.timestamp
			})
		end

		arg_11_0.historyTipsFlag_ = true
	end

	if #arg_11_0.cacheContentList_ <= 0 or arg_11_1.timestamp - arg_11_0.cacheContentList_[#arg_11_0.cacheContentList_].timestamp > ChatConst.MESSAGE_SPACE then
		local var_11_2 = {
			timestamp = arg_11_1.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		}

		table.insert(arg_11_0.cacheContentList_, var_11_2)
	end

	table.insert(arg_11_0.cacheContentList_, arg_11_0:ParseChat(arg_11_1))
end

function var_0_0.GetCacheContent(arg_12_0)
	return arg_12_0.cacheContentList_
end

function var_0_0.GetUnreadMsgCnt(arg_13_0)
	if arg_13_0.chatRecordList_ then
		local var_13_0 = 0

		for iter_13_0 = #arg_13_0.chatRecordList_, 1, -1 do
			if arg_13_0.chatRecordList_[iter_13_0].msgID == arg_13_0.readMsgID_ then
				break
			end

			if arg_13_0.chatRecordList_[iter_13_0].recall == false then
				var_13_0 = var_13_0 + 1
			end
		end

		return var_13_0
	else
		return 0
	end
end

function var_0_0.GetLastMsgData(arg_14_0)
	if arg_14_0.chatRecordList_ then
		for iter_14_0 = #arg_14_0.chatRecordList_, 1, -1 do
			if arg_14_0.chatRecordList_[iter_14_0].recall == false then
				return arg_14_0.chatRecordList_[iter_14_0]
			end
		end
	end

	return {
		content = ""
	}
end

function var_0_0.GetSaveRecordList(arg_15_0)
	return arg_15_0.chatSaveRecordList_ or {}
end

function var_0_0.SetSaveRecordList(arg_16_0, arg_16_1)
	arg_16_0.chatSaveRecordList_ = arg_16_1
end

function var_0_0.InitGuildContnent(arg_17_0, arg_17_1)
	arg_17_0.chatRecordList_ = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		table.insert(arg_17_0.chatRecordList_, iter_17_1)
	end

	arg_17_0.readMsgID_ = arg_17_0.chatRecordData_.readMsgID or 0
end

return var_0_0
