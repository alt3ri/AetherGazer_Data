manager.net:Bind(19001, function (slot0)
	if #(slot0.friend_list or {}) > 0 then
		FriendsData:RefreshFriendsDataList(slot1, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	end

	if #(slot0.request_list or {}) > 0 then
		FriendsData:RefreshFriendsDataList(slot2, FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
	end

	if #(slot0.black_list or {}) > 0 then
		FriendsData:RefreshFriendsDataList(slot3, FriendsConst.FRIEND_TYPE.BLACKLIST)
	end

	FriendsAction:OnFriendsDataChange()
	FriendsAction:UpdateFriendsRedTip()
end)
manager.net:Bind(19019, function (slot0)
	FriendsData:RefreshFriendsData(slot0.request, FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
	FriendsAction:UpdateFriendsRequestRedTip()
end)
manager.net:Bind(19021, function (slot0)
	FriendsData:RefreshFriendsData(slot0.friend, FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:UpdateFriendsRedTip()
end)
manager.net:Bind(19023, function (slot0)
	FriendsData:DelectFriendsData(slot0.friend_id)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:UpdateChatRedTip()
	FriendsAction:OnFriendsDelect(slot0.friend_id)
	ChatAction.DeleteFriendChat(slot0.friend_id)
end)
manager.net:Bind(19027, function (slot0)
	FriendsData:DelectFriendsData(slot0.friend_id)
	FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	FriendsAction:UpdateFriendsRedTip()
	FriendsAction:OnFriendsDelect(slot0.friend_id)
	ChatAction.DeleteFriendChat(slot0.friend_id)
	ChatAction.RefreshWorldChatData()
end)
manager.net:Bind(19029, function (slot0)
	slot2 = slot0.request_list or {}

	FriendsData:FriendsDataInit(slot0.brief_friend_list or {}, slot2, slot0.black_list or {})
	manager.redPoint:setTip(RedPointConst.FRIEND_FRIEND_REQUESTS, #slot2)
end)
manager.net:Bind(19033, function (slot0)
	FriendsData:RefreshFriendsData(slot0.recommend, FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
end)

return {
	RequestToFriendSrc = {
		MidAutumnActivity = 5,
		MultiPlayerGameRoom = 1,
		MultiPlayerGameResult = 2,
		AddFriend = 0,
		DormInfo = 4,
		PlayerInfo = 3,
		Activity = 6,
		IdolDanceGame = 7
	},
	TryToRequestToFriend = function (slot0, slot1, slot2, slot3)
		manager.net:SendWithLoadingNew(19002, {
			request_user_id = slot1,
			source = slot2,
			activity_id = slot3 or 0
		}, 19003, handler(slot0, slot0.OnTryToRequestToFriend))
	end,
	OnTryToRequestToFriend = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			ShowTips("FRIEND_APPLY_SEND")
			FriendsData:RequestToFriend(slot2.request_user_id)
			FriendsData:TryToAddRequest(slot2.request_user_id)
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		else
			ShowTips(slot1.result)
		end
	end,
	TryToDealRequest = function (slot0, slot1, slot2)
		if slot2 == 1 then
			if not FriendsData:IsCanBeFriend(slot1) then
				return
			end
		else
			ShowTips("FRIEND_APPLY_REJECT")
		end

		manager.net:SendWithLoadingNew(19004, {
			request_user_id = slot1,
			deal = slot2
		}, 19005, handler(slot0, slot0.OnTryToDealRequest))
	end,
	OnTryToDealRequest = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DealRequest(slot2.request_user_id, slot2.deal, slot1.friend)

			if slot2.deal == 1 then
				SendMessageManagerToSDK("add_friend")
			end

			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
			FriendsAction:UpdateFriendsRequestRedTip()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToDelectFromMyFriendsList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19006, {
			friend_id = slot1
		}, 19007, handler(slot0, slot0.OnTryToDelectFromMyFriendsList))
	end,
	OnTryToDelectFromMyFriendsList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DelectFriendsData(slot2.friend_id)
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
			FriendsAction:UpdateChatRedTip()
			ChatAction.DeleteFriendChat(slot2.friend_id)
		else
			ShowTips(slot1.result)
		end
	end,
	TryToAddToBlacklist = function (slot0, slot1)
		if FriendsData:IsCanBeBlackList(slot1) then
			manager.net:SendWithLoadingNew(19008, {
				black_user_id = slot1
			}, 19009, handler(slot0, slot0.OnTryToAddToBlacklist))
		end
	end,
	OnTryToAddToBlacklist = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:RefreshFriendsData(slot1.black, FriendsConst.FRIEND_TYPE.BLACKLIST)
			FriendsData:TryToRemoveRequest(slot2.friend_id)
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
			FriendsAction:UpdateFriendsRedTip()
			ChatAction.DeleteFriendChat(slot2.black_user_id)
			ChatAction.RefreshWorldChatData()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToDelectFromBlackList = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(19010, {
			black_user_id = slot1,
			is_request = slot2
		}, 19011, handler(slot0, slot0.OnTryToDelectFromBlackList))
	end,
	OnTryToDelectFromBlackList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:DelectFromBlackList(slot2.black_user_id, slot2.is_request)

			if slot2.isRequest == 1 then
				FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
			else
				FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.BLACKLIST)
			end

			ChatAction.RefreshWorldChatData()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToSearchFriend = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19012, {
			user_id = slot1
		}, 19013, handler(slot0, slot0.OnTryToSearchFriend))
	end,
	OnTryToSearchFriend = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:SetSearchList(slot1.user_info)
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.SEARCH)
		else
			FriendsData:SetSearchList()
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.SEARCH)
			ShowTips(slot1.result)
		end
	end,
	TryToDealRequestList = function (slot0, slot1)
		if FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS) == 0 then
			return
		end

		manager.net:SendWithLoadingNew(19014, {
			deal = slot1
		}, 19015, handler(slot0, slot0.OnTryToDealRequestList))
	end,
	OnTryToDealRequestList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			if slot2.deal == 1 then
				FriendsData:AllAcceptRequestList(slot1.friend_list or {}, slot2.deal)
				SendMessageManagerToSDK("add_friend")
			else
				FriendsData:AllRefuseRequestList(list, slot2.deal)
				ShowTips("IGNORE_ALL_FRIEND_REQUEST")
			end

			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS)
			FriendsAction:UpdateFriendsRequestRedTip()
		else
			ShowTips(slot1.result)
		end
	end,
	TryToRefreshNewFriendsList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(19016, {
			cmd = slot1
		}, 19017, handler(slot0, slot0.OnTryToRefreshNewFriendsList))
	end,
	OnTryToRefreshNewFriendsList = function (slot0, slot1, slot2)
		if isSuccess(slot1.result) then
			FriendsData:RefreshNewFriendsList(slot1.recommend_list or {}, slot2.cmd)
			FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		else
			ShowTips(slot1.result)

			if slot2.cmd == 1 then
				FriendsData:RefreshNewFriendsList({}, 2)
				FriendsAction:OnFriendsDataChange(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
			end
		end
	end,
	TryToRefreshFriendsView = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(19030, {
			type = slot1
		}, 19031, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ChatInit = function (slot0)
		FriendsData:ChatInit()
	end,
	RefreshChat = function (slot0, slot1, slot2, slot3)
		FriendsData:RefreshChat(slot1, slot2, slot3)
		manager.notify:CallUpdateFunc(FRIENDS_CHAT_CHANGE, slot1, slot2, slot3)
	end,
	RefreshUnread = function (slot0, slot1, slot2)
		FriendsData:RefreshUnread(slot1, slot2)
		manager.notify:CallUpdateFunc(FRIENDS_UNREAD_CHANGE, slot1, slot2)

		if slot2 == 0 then
			FriendsAction:UpdateChatRedTip()
		elseif manager.redPoint:getTipValue(RedPointConst.FRIEND_MY_FRIENDS) == 0 then
			manager.redPoint:setTip(RedPointConst.FRIEND_MY_FRIENDS, 1)
		end
	end,
	OnFriendsDataChange = function (slot0, slot1)
		manager.notify:CallUpdateFunc(FRIENDS_LIST_CHANGE, slot1)
	end,
	OnFriendsDelect = function (slot0, slot1)
		manager.notify:CallUpdateFunc(FRIENDS_DELECT, slot1)
	end,
	UpdateFriendsRedTip = function (slot0)
		slot0:UpdateChatRedTip()
		slot0:UpdateFriendsRequestRedTip()
	end,
	UpdateChatRedTip = function (slot0)
		slot1 = false

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
			slot1 = false
		end

		for slot6, slot7 in pairs(FriendsData:GetChatList() or {}) do
			if slot7.unReadMsgCnt > 0 then
				slot1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.FRIEND_MY_FRIENDS, slot1 and 1 or 0)
	end,
	UpdateFriendsRequestRedTip = function (slot0)
		slot1 = false

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.FRIEND) then
			slot1 = false
		end

		if FriendsData:IsRequesting() then
			slot1 = true
		end

		manager.redPoint:setTip(RedPointConst.FRIEND_FRIEND_REQUESTS, slot1 and 1 or 0)
		manager.redPoint:setTip(RedPointConst.FRIEND, slot1 and 1 or 0)
	end
}
