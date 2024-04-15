slot1 = class("MoonCakeChatData", import(".ChatNormalData"))

function slot1.Ctor(slot0, slot1)
	slot0.chatType_ = slot1
	slot0.chatRecordData_ = getModule("chatGuild" .. slot1)
	slot0.chatSaveRecordList_ = {}
	slot0.chatRecordList_ = {}
	slot0.readMsgID_ = 0
	slot0.historyTipsFlag_ = false
	slot0.cacheContentList_ = {}
	slot0.tempChatData_ = {}
end

function slot1.AddChat(slot0, slot1)
	slot0.tempChatData_[#slot0.tempChatData_ + 1] = slot0:ParseChat(slot1)
end

function slot1.SortMsg(slot0)
	function slot4(slot0, slot1)
		return slot0.timestamp < slot1.timestamp
	end

	table.sort(slot0.tempChatData_, slot4)

	slot0.chatSaveRecordList_ = {}
	slot0.chatRecordList_ = {}
	slot0.cacheContentList_ = {}

	for slot4 = 1, #slot0.tempChatData_ do
		slot5 = slot0.tempChatData_[slot4]

		slot0:SaveRecord(slot5)

		slot0.chatRecordList_[#slot0.chatRecordList_ + 1] = slot5

		slot0:UpdateCacheContent(slot5)
	end

	slot0.tempChatData_ = {}
end

function slot1.RemoveChatContent(slot0, slot1)
	slot2 = slot1.sender_uid

	if slot0.chatRecordList_ == nil then
		return 0
	end

	for slot7, slot8 in ipairs(slot0.chatRecordList_) do
		if slot8.id == slot2 then
			slot8.recall = true
			slot3 = slot7

			break
		end
	end

	for slot7 = #slot0.cacheContentList_, 1, -1 do
		if slot0.cacheContentList_[slot7].id == slot2 then
			if slot0.cacheContentList_[slot7 + 1] == nil then
				table.remove(slot0.cacheContentList_, slot7)

				if slot0.cacheContentList_[slot7 - 1] then
					if slot0.cacheContentList_[slot7 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS or slot0.cacheContentList_[slot7 - 1].contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
						table.remove(slot0.cacheContentList_, slot7 - 1)

						if slot0.cacheContentList_[slot7 - 2] and slot0.cacheContentList_[slot7 - 2].contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
							table.remove(slot0.cacheContentList_, slot7 - 2)
						end
					end

					slot0.historyTipsFlag_ = false
				end

				break
			end

			table.remove(slot0.cacheContentList_, slot7)

			break
		end
	end

	return slot3
end

function slot1.UpdateCacheContent(slot0, slot1)
	slot2 = USER_ID

	if table.keyof(FriendsData:GetList(FriendsConst.FRIEND_TYPE.BLACKLIST), slot1.id) then
		return
	end

	if slot0.historyTipsFlag_ ~= true then
		if slot1.id ~= slot2 then
			table.insert(slot0.cacheContentList_, {
				contentType = ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS,
				timestamp = slot1.timestamp
			})
		end

		slot0.historyTipsFlag_ = true
	end

	if #slot0.cacheContentList_ <= 0 or ChatConst.MESSAGE_SPACE < slot1.timestamp - slot0.cacheContentList_[#slot0.cacheContentList_].timestamp then
		table.insert(slot0.cacheContentList_, {
			timestamp = slot1.timestamp,
			contentType = ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP
		})
	end

	table.insert(slot0.cacheContentList_, slot1)
end

return slot1
