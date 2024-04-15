FriendStruct = class("FriendStruct")

function FriendStruct.Ctor(slot0, slot1, slot2)
	slot0.user_id = slot1.user_id
	slot0.online_state = slot1.online_state or 0
	slot0.sign = slot1.sign or ""
	slot0.timestamp = slot1.timestamp or 0
	slot0.level = slot1.level
	slot0.bg = slot1.info_background or 0
	slot0.relationship = slot2
	slot0.nick = slot1.base_info and slot3.nick or ""
	slot0.icon = slot3 and slot3.icon or 0
	slot0.icon_frame = slot3 and slot3.icon_frame or 0
	slot0.ip = (slot1.ip_location == nil or slot4 == "") and GetTips("IP_UNKNOWN") or slot4
	slot0.bubbleID = slot1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
	slot0.lastChat, slot0.lastChatTime, slot0.unReadMsgCnt = FriendsData:GetChatInfo(slot1.user_id)
	slot0.isDeal = false
end

slot0 = singletonClass("FriendsData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = {}
slot8 = 100
slot9 = {}
slot10 = false
slot11 = false

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = {}
	uv4 = {}
	uv5 = {}
	uv6 = {}
	uv7 = false
end

function slot0.FriendsDataInit(slot0, slot1, slot2, slot3)
	uv0 = false
	uv1 = {}
	uv2 = {}
	uv3 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		if not uv4[slot8.user_id] or slot9.relationship ~= FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			uv4[slot8.user_id] = FriendStruct.New(slot8, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
		end

		table.insert(uv1, slot8.user_id)
		ChatTools.LoadFriendLocalChatCache(slot8.user_id)
	end

	for slot7, slot8 in ipairs(slot2) do
		if not uv4[slot8.user_id] or slot9.relationship ~= FriendsConst.FRIEND_TYPE.MY_FRIENDS then
			uv4[slot8.user_id] = FriendStruct.New(slot8, FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
		end

		table.insert(uv3, slot8.user_id)
	end

	for slot7, slot8 in ipairs(slot3) do
		if not uv4[slot8] or slot9.relationship ~= FriendsConst.FRIEND_TYPE.BLACKLIST then
			uv4[slot8] = FriendStruct.New({
				user_id = slot8
			}, FriendsConst.FRIEND_TYPE.BLACKLIST)
		end

		table.insert(slot3, slot8)
	end
end

function slot0.RefreshFriendsDataList(slot0, slot1, slot2)
	uv0 = true

	for slot6, slot7 in ipairs(slot1) do
		slot0:RefreshFriendsData(slot7, slot2)
	end
end

function slot0.RefreshFriendsData(slot0, slot1, slot2)
	if not uv0[slot1.user_id] then
		uv0[slot3] = FriendStruct.New(slot1, slot2)

		slot0:InsertID(slot3, slot2)
	else
		slot4.online_state = slot1.online_state
		slot4.sign = slot1.sign
		slot4.timestamp = slot1.timestamp
		slot4.level = slot1.level
		slot4.bg = slot1.info_background or 0
		slot4.bubbleID = slot1.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
		slot4.nick = slot1.base_info and slot5.nick or ""
		slot4.icon = slot5 and slot5.icon or 0
		slot4.icon_frame = slot5 and slot5.icon_frame or 0
		slot4.ip = (slot1.ip_location == nil or slot6 == "") and GetTips("IP_UNKNOWN") or slot6

		slot0:DelectID(slot3)
		slot0:InsertID(slot3, slot2)

		slot4.relationship = slot2
	end
end

function slot0.InsertID(slot0, slot1, slot2)
	if slot2 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		table.insert(uv0, slot1)
	elseif slot2 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		table.insert(uv1, slot1)
	elseif slot2 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		table.insert(uv2, slot1)
	elseif slot2 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		table.insert(uv3, slot1)
	elseif slot2 == FriendsConst.FRIEND_TYPE.SEARCH then
		table.insert(uv4, slot1)
	end
end

function slot0.DelectID(slot0, slot1)
	if not uv0[slot1] then
		return
	end

	slot3 = {}

	if slot2.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		slot3 = uv1
	elseif slot4 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		slot3 = uv2
	elseif slot4 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		slot3 = uv3
	elseif slot4 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		slot3 = uv4
	elseif slot4 == FriendsConst.FRIEND_TYPE.SEARCH then
		slot3 = uv5
	end

	if table.indexof(slot3, slot1) then
		table.remove(slot3, slot5)
	end
end

function slot0.DelectFriendsData(slot0, slot1)
	if not uv0[slot1] then
		return
	end

	slot0:DelectID(slot1)

	uv1[slot1] = nil
	uv0[slot1] = nil

	slot0:TryToRemoveRequest(slot1)
end

function slot0.TryToRemoveRequest(slot0, slot1)
	if table.indexof(uv0, slot1) then
		table.remove(uv0, slot2)
	end
end

function slot0.RequestToFriend(slot0, slot1)
	if uv0[slot1] and (slot2.relationship == FriendsConst.FRIEND_TYPE.NEW_FRIENDS or slot2.relationship == FriendsConst.FRIEND_TYPE.SEARCH) then
		slot2.isDeal = true
	end
end

function slot0.TryToAddRequest(slot0, slot1)
	if uv1 <= #uv0 then
		table.remove(uv0, 1)
	end

	table.insert(uv0, slot1)
end

function slot0.AllAcceptRequestList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot0:DealRequest(slot7.user_id, slot2, slot7)
	end
end

function slot0.AllRefuseRequestList(slot0)
	for slot4 = #uv0, 1, -1 do
		slot0:DelectFriendsData(uv0[slot4])
	end
end

function slot0.DealRequest(slot0, slot1, slot2, slot3)
	if slot2 == 1 then
		slot0:DelectID(slot1)

		if not uv0[slot1] then
			uv0[slot1] = FriendStruct.New(slot3, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
		else
			slot4.online_state = slot3.online_state
			slot4.sign = slot3.sign
			slot4.timestamp = slot3.timestamp
			slot4.level = slot3.level
			slot4.bg = slot3.info_background or 0
			slot4.bubbleID = slot3.chat_bubble or GameSetting.profile_chat_bubble_default.value[1]
			slot4.nick = slot3.base_info and slot5.nick or ""
			slot4.icon = slot5 and slot5.icon or 0
			slot4.icon_frame = slot5 and slot5.icon_frame or 0
			slot4.ip = (slot3.ip_location == nil or slot6 == "") and GetTips("IP_UNKNOWN") or slot6
			slot4.relationship = FriendsConst.FRIEND_TYPE.MY_FRIENDS
		end

		slot0:InsertID(slot1, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	else
		slot0:DelectFriendsData(slot1)
	end
end

function slot0.IsRequesting(slot0)
	slot2 = 0

	for slot6, slot7 in ipairs(uv0) do
		if manager.time:GetServerTime() - (uv1[slot7].timestamp or 0) < 604800 then
			return true
		end
	end

	return false
end

function slot0.DelectFromBlackList(slot0, slot1, slot2)
	if slot2 == 1 then
		ShowTips("FRIEND_APPLY_SEND")

		if uv0[slot1] then
			slot0:RefreshFriendsData(slot3, FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
			slot0:RequestToFriend(slot1)
			slot0:TryToAddRequest(slot1)
		end
	else
		slot0:DelectFriendsData(slot1)
	end
end

function slot0.SetSearchList(slot0, slot1)
	if uv1[uv0[1]] and slot3.relationship == FriendsConst.FRIEND_TYPE.SEARCH then
		slot0:DelectFriendsData(slot2)
	end

	uv0 = {}

	if slot1 == nil then
		return
	end

	if not uv1[slot1.user_id] then
		uv1[slot4] = FriendStruct.New(slot1, FriendsConst.FRIEND_TYPE.SEARCH)
	end

	slot0:InsertID(slot4, FriendsConst.FRIEND_TYPE.SEARCH)
end

function slot0.RefreshNewFriendsList(slot0, slot1, slot2)
	if slot2 == 2 then
		for slot6 = #uv0, 1, -1 do
			slot0:DelectFriendsData(uv0[slot6])
		end
	end

	slot0:RefreshFriendsDataList(slot1, FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
end

function slot0.ChatInit(slot0)
	uv0 = {}

	for slot4, slot5 in ipairs(uv1) do
		if ChatFriendData:GetLastMsgData(slot5) ~= nil then
			slot7 = slot6.content

			if slot6.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
				slot7 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(slot6.content)].name))
			end

			uv0[slot5] = {
				lastChat = slot7,
				lastChatTime = slot6.timestamp,
				unReadMsgCnt = ChatFriendData:GetUnreadMsgCnt(slot5)
			}
		end
	end
end

function slot0.GetChatList(slot0)
	return uv0
end

function slot0.GetChatInfo(slot0, slot1)
	if uv0[slot1] ~= nil then
		return uv0[slot1].lastChat, uv0[slot1].lastChatTime, uv0[slot1].unReadMsgCnt
	end

	return "", nil, 0
end

function slot0.RefreshChat(slot0, slot1, slot2, slot3)
	if uv0[slot1] then
		uv0[slot1].lastChat = slot2
		uv0[slot1].lastChatTime = slot3
	else
		uv0[slot1] = {
			unReadMsgCnt = 0,
			lastChat = slot2,
			lastChatTime = slot3
		}
	end
end

function slot0.RefreshUnread(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].unReadMsgCnt = slot2
	else
		uv0[slot1] = {
			lastChat = "",
			unReadMsgCnt = slot2
		}
	end
end

function slot0.IsCanBeFriend(slot0, slot1)
	if slot1 == tostring(PlayerData:GetPlayerInfo().userID) then
		ShowTips("CANNOT_ADD_SELF")

		return false
	end

	if uv0[slot1] and slot2.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		ShowTips("ERROR_FRIEND_EXIST_FRIEND")

		return false
	end

	if GameSetting.user_friend_num_max.value[1] <= #uv1 then
		ShowTips("ERROR_FRIEND_NUM_LIMIT_ME")

		return false
	end

	if slot2 and slot2.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ADD_BLACKLIST_FRIEND_COMFIRMATION"),
			OkCallback = function ()
				FriendsAction:TryToDelectFromBlackList(uv0, 1)
			end
		})

		return false
	end

	return true
end

function slot0.IsCanBeBlackList(slot0, slot1)
	if GameSetting.user_black_num_max.value[1] <= #uv0 then
		ShowTips("FRIEND_MOVE_TO_BLACLIST_NOTE_LIMIT")

		return false
	end

	if uv1[slot1] and slot2.relationship == FriendsConst.FRIEND_TYPE.BLACKLIST then
		ShowTips("ERROR_FRIEND_EXIST_BLACK_TARGET")

		return false
	end

	return true
end

function slot0.GetList(slot0, slot1)
	if slot1 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		return uv0
	elseif slot1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		return uv1
	elseif slot1 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		slot2 = {}

		for slot7 = #uv2, 1, -1 do
			if manager.time:GetServerTime() - uv3[uv2[slot7]].timestamp > 604800 then
				slot0:DelectFriendsData(slot8)
			else
				table.insert(slot2, slot8)
			end
		end

		return uv2
	elseif slot1 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		return uv4
	elseif slot1 == FriendsConst.FRIEND_TYPE.SEARCH then
		return uv5
	end
end

function slot0.GetListLength(slot0, slot1)
	if slot1 == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		return #uv0
	elseif slot1 == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		return #uv1
	elseif slot1 == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		return #uv2
	elseif slot1 == FriendsConst.FRIEND_TYPE.BLACKLIST then
		return #uv3
	elseif slot1 == FriendsConst.FRIEND_TYPE.SEARCH then
		return #uv4
	end
end

function slot0.GetInfoByID(slot0, slot1)
	return uv0[slot1] ~= nil and slot2 or false
end

function slot0.GetFriendsOnLineCount(slot0)
	for slot5, slot6 in ipairs(uv0) do
		if uv1[slot6].online_state == 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.GetFreshFlag(slot0)
	return uv0
end

function slot0.IsInRequest(slot0, slot1)
	return table.indexof(uv0, slot1) ~= false
end

function slot0.IsFriend(slot0, slot1)
	return uv0[slot1] and uv0[slot1].relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS
end

function slot0.GetHadFreshNewFriend(slot0)
	return uv0
end

return slot0
