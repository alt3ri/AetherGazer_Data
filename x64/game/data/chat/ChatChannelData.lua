slot0 = import(".ChatNormalData")
slot1 = import(".MoonCakeChatData")
slot2 = singletonClass("ChatChannelData")

function slot2.Init(slot0)
	slot0.chatChannelList_ = {}
end

function slot2.CheckChatChannelList(slot0, slot1)
	if slot0.chatChannelList_[slot1] == nil then
		if slot1 == ChatConst.CHAT_CHANNEL_MOON_CAKE then
			slot0.chatChannelList_[slot1] = uv0.New(slot1)
		else
			slot0.chatChannelList_[slot1] = uv1.New(slot1)
		end
	end
end

function slot2.GetContent(slot0, slot1)
	slot0:CheckChatChannelList(slot1)

	return slot0.chatChannelList_[slot1]:GetContent()
end

function slot2.AddChat(slot0, slot1, slot2)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:AddChat(slot2)
end

function slot2.RemoveChatData(slot0, slot1)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:RemoveChatData()
end

function slot2.RemoveChatContent(slot0, slot1)
	slot2 = slot1.channel_type

	slot0:CheckChatChannelList(slot2)

	return slot0.chatChannelList_[slot2]:RemoveChatContent(slot1)
end

function slot2.InitCacheContent(slot0, slot1)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:InitCacheContent()
end

function slot2.GetCacheContent(slot0, slot1)
	slot0:CheckChatChannelList(slot1)

	return slot0.chatChannelList_[slot1]:GetCacheContent()
end

function slot2.SaveRecordCnt(slot0, slot1, slot2)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:SaveRecordCnt(slot2)
end

function slot2.GetUnreadMsgCnt(slot0, slot1)
	slot0:CheckChatChannelList(slot1)

	return slot0.chatChannelList_[slot1]:GetUnreadMsgCnt()
end

function slot2.GetSaveRecordList(slot0, slot1)
	slot0:CheckChatChannelList(slot1)

	return slot0.chatChannelList_[slot1]:GetSaveRecordList()
end

function slot2.SetSaveRecordList(slot0, slot1, slot2)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:SetSaveRecordList(slot2)
end

function slot2.InitChannelContnent(slot0, slot1, slot2)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:InitChannelContnent(slot2)
end

function slot2.SetLastRequireMsgTimestamp(slot0, slot1, slot2)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:SetLastRequireMsgTimestamp(slot2)
end

function slot2.GetLastRequireMsgTimestamp(slot0, slot1)
	slot0:CheckChatChannelList(slot1)

	return slot0.chatChannelList_[slot1]:GetLastRequireMsgTimestamp()
end

function slot2.SortMsg(slot0, slot1)
	slot0:CheckChatChannelList(slot1)
	slot0.chatChannelList_[slot1]:SortMsg()
end

return slot2
