slot0 = class("FriendsRightContentView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:InitDropdownData()
end

function slot0.InitDropdownData(slot0)
	slot0.dropDown_.options:Clear()

	for slot5, slot6 in ipairs({
		"DEFAULT_SORT",
		"LAST_CHAT",
		"LAST_LOGIN",
		"USER_NAME"
	}) do
		slot0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips(slot6), nil))
	end

	slot0.dropDown_:RefreshShownValue()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.friendType_ = {
		myFriends = FriendsConst.FRIEND_TYPE.MY_FRIENDS,
		newFriends = FriendsConst.FRIEND_TYPE.NEW_FRIENDS,
		friendsRequest = FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS,
		blackList = FriendsConst.FRIEND_TYPE.BLACKLIST,
		search = FriendsConst.FRIEND_TYPE.SEARCH
	}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.itemScroll_, FriendsItem)
	slot0.nothingController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "nothing")
	slot0.inputController_ = ControllerUtil.GetController(slot0.transform_, "input")
	slot0.orderController_ = slot0.sortBtn_.transform:GetComponent("ControllerExCollection"):GetController("sort")
	slot0.dropDown_ = slot0.dropGo_:GetComponent("Dropdown")
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.dropDown_, function (slot0)
		uv0.sortType_ = uv0.dropDown_.value

		uv0:SortList()
		uv0.scrollHelper_:StartScroll(#uv0.curList_)
	end)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		uv0.order_ = 1 - uv0.order_

		uv0:SortList()
		uv0.scrollHelper_:StartScroll(#uv0.curList_)
	end)
	slot0:AddBtnListener(slot0.searchBtn_, nil, function ()
		if uv0.inputField_.text == "" then
			return
		end

		slot1, slot2 = textLimit(slot0, 15)
		uv0.inputField_.text = slot1
		uv0.curPageIndex_ = uv0.friendType_.search

		FriendsAction:TryToSearchFriend(slot1)
	end)
	slot0:AddBtnListener(slot0.ignoreAllBtn_, nil, function ()
		FriendsAction:TryToDealRequestList(2)
	end)
	slot0:AddBtnListener(slot0.acceptAllBtn_, nil, function ()
		FriendsAction:TryToDealRequestList(1)
	end)
	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		FriendsAction:TryToRefreshNewFriendsList(2)
	end)
	slot0:AddBtnListener(slot0.deleteBtn_, nil, function ()
		uv0.inputField_.text = ""
	end)
	slot0:AddBtnListener(slot0.pasteBtn_, nil, function ()
		uv0.inputField_.text = GetI18NText(UnityEngine.GUIUtility.systemCopyBuffer)
	end)
	slot0.inputField_.onValueChanged:AddListener(function ()
		uv0.inputController_:SetSelectedState(uv0.inputField_.text ~= "" and "delete" or "add")
	end)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDrag)))
end

function slot0.EndDrag(slot0, slot1, slot2)
	if slot0.curPageIndex_ ~= slot0.friendType_.newFriends then
		return
	end

	if slot0.template_.transform.sizeDelta.y < -1 * slot0.content_.transform.anchoredPosition.y then
		FriendsAction:TryToRefreshNewFriendsList(2)
	end
end

function slot0.OnEnter(slot0)
	slot0.order_ = 0
	slot0.dropDown_.value = 0
	slot0.sortType_ = slot0.dropDown_.value
	slot0.curList_ = {}
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.curList_[slot1], slot0.curPageIndex_)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = slot0.curPageIndex_ and slot0.curPageIndex_ == slot1

	slot0:clearText(slot0.curPageIndex_)

	slot0.curPageIndex_ = slot1
	slot0.curList_ = {}

	for slot7, slot8 in ipairs(FriendsData:GetList(slot0.curPageIndex_)) do
		table.insert(slot0.curList_, FriendsData:GetInfoByID(slot8))
	end

	if slot0.curPageIndex_ == slot0.friendType_.myFriends then
		slot0.myFriendsTxt_.text = FriendsData:GetFriendsOnLineCount() .. "/" .. FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS)
	elseif slot0.curPageIndex_ == slot0.friendType_.newFriends then
		slot0.inputField_.text = ""
		slot0.defaultTxt_.text = GetTips("NOT_ENTER_NICK_UID")
		slot0.newFriendsTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]
	elseif slot0.curPageIndex_ == slot0.friendType_.search then
		slot0.newFriendsTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]
	elseif slot0.curPageIndex_ == slot0.friendType_.friendsRequest then
		slot0.friendsRequestTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.MY_FRIENDS) .. "/" .. GameSetting.user_friend_num_max.value[1]

		SetActive(slot0.ignoreAllBtn_.gameObject, #slot0.curList_ > 0)
		SetActive(slot0.acceptAllBtn_.gameObject, #slot0.curList_ > 0)
	elseif slot0.curPageIndex_ == slot0.friendType_.blackList then
		slot0.blacklistTxt_.text = FriendsData:GetListLength(FriendsConst.FRIEND_TYPE.BLACKLIST) .. "/" .. GameSetting.user_black_num_max.value[1]
	end

	SetActive(slot0.refreshBtn_.gameObject, slot0.curPageIndex_ == slot0.friendType_.newFriends)
	slot0:SortList(slot2)
end

function slot0.SortList(slot0, slot1)
	if slot0.curPageIndex_ == slot0.friendType_.myFriends then
		slot0.orderController_:SetSelectedState(slot0.order_ == 0 and "down" or "up")

		if slot0.sortType_ == 0 then
			table.sort(slot0.curList_, function (slot0, slot1)
				if slot0.online_state == 0 and slot1.online_state ~= 0 then
					return true
				elseif slot0.online_state ~= 0 and slot1.online_state == 0 then
					return false
				end

				return (slot1.lastChatTime or slot1.timestamp) < (slot0.lastChatTime or slot0.timestamp)
			end)
		elseif slot0.sortType_ == 1 then
			table.sort(slot0.curList_, function (slot0, slot1)
				return (slot1.lastChatTime or slot1.timestamp) < (slot0.lastChatTime or slot0.timestamp)
			end)
		elseif slot0.sortType_ == 2 then
			table.sort(slot0.curList_, function (slot0, slot1)
				if slot0.online_state == 0 and slot1.online_state ~= 0 then
					return true
				elseif slot0.online_state ~= 0 and slot1.online_state == 0 then
					return false
				end

				if slot0.online_state ~= 0 and slot1.online_state ~= 0 then
					return slot1.online_state < slot0.online_state
				end

				return (slot1.lastChatTime or slot1.timestamp) < (slot0.lastChatTime or slot0.timestamp)
			end)
		elseif slot0.sortType_ == 3 then
			table.sort(slot0.curList_, function (slot0, slot1)
				return Hanzi2Pinyin.Sort(slot0.nick, slot1.nick)
			end)
		end

		if slot0.order_ == 1 then
			for slot6 = 1, #slot0.curList_ do
			end

			slot0.curList_ = {
				[slot6] = table.remove(slot0.curList_)
			}
		end
	elseif slot0.curPageIndex_ == slot0.friendType_.newFriends then
		-- Nothing
	elseif slot0.curPageIndex_ == slot0.friendType_.friendsRequest then
		table.sort(slot0.curList_, function (slot0, slot1)
			return slot1.timestamp < slot0.timestamp
		end)
	elseif slot0.curPageIndex_ == slot0.friendType_.blackList then
		table.sort(slot0.curList_, function (slot0, slot1)
			return slot1.timestamp < slot0.timestamp
		end)
	end

	if slot1 and slot0.curPageIndex_ == slot0.friendType_.newFriends then
		slot0.scrollHelper_:SetScrolledPosition(slot0.scrollHelper_:GetScrolledPosition())
	else
		slot0.scrollHelper_:StartScroll(#slot0.curList_)
	end

	if next(slot0.curList_) == nil then
		slot0.nothingController_:SetSelectedState(slot0.curPageIndex_)
	else
		slot0.nothingController_:SetSelectedState(0)
	end
end

function slot0.clearText(slot0, slot1)
	if slot1 == slot0.friendType_.myFriends then
		slot0.myFriendsTxt_.text = ""
	elseif slot0.curPageIndex_ == slot0.friendType_.newFriends then
		-- Nothing
	elseif slot0.curPageIndex_ == slot0.friendType_.search then
		-- Nothing
	elseif slot0.curPageIndex_ == slot0.friendType_.friendsRequest then
		slot0.friendsRequestTxt_.text = ""
	elseif slot0.curPageIndex_ == slot0.friendType_.blackList then
		slot0.blacklistTxt_.text = ""
	end
end

function slot0.OnFriendsChatChange(slot0, slot1, slot2, slot3)
	if slot0:ItemIndex(slot1) == 0 then
		return
	end

	slot0.curList_[slot4].lastChat = slot2
	slot0.curList_[slot4].timestamp = slot3
end

function slot0.OnFriendsUnreadChange(slot0, slot1, slot2)
	if slot0:ItemIndex(slot1) == 0 then
		return
	end

	slot0.curList_[slot3].unReadMsgCnt = slot2

	table.insert(slot0.curList_, 1, table.remove(slot0.curList_, slot3))
	slot0.scrollHelper_:Refresh()
end

function slot0.ItemIndex(slot0, slot1)
	for slot5 = 1, #slot0.curList_ do
		if slot0.curList_[slot5].user_id == slot1 then
			return slot5
		end
	end

	return 0
end

function slot0.OnFriendsListChange(slot0, slot1)
	slot0:RefreshUI(slot1)
end

function slot0.OnExit(slot0)
	slot0.curList_ = {}
	slot0.myFriendsTxt_.text = ""
	slot0.friendsRequestTxt_.text = ""
	slot0.blacklistTxt_.text = ""
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.dropDown_.onValueChanged:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
