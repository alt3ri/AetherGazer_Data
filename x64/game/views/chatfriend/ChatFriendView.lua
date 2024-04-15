local var_0_0 = class("ChatFriendView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Friends/FriendsChatUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
	arg_3_0:InitItemPool()

	local var_3_0 = arg_3_0.viewPort_.rect.height
	local var_3_1 = arg_3_0.goItemParent_:GetComponent("VerticalLayoutGroup").spacing

	arg_3_0.loopScrollView_ = LoopScrollView.New(arg_3_0, arg_3_0.scrollView_, arg_3_0.rectGrid_, arg_3_0.viewPort_, var_3_0, var_3_1, true)
	arg_3_0.chatFriendContentView_ = ChatFriendContentView.New(arg_3_0.goRigthPanel_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	local var_4_0 = 1

	arg_4_0.selectID_ = arg_4_0.params_.friendID or ChatFriendData:GetCacheHeroList()[1]

	if arg_4_0.selectID_ then
		var_4_0 = table.keyof(ChatFriendData:GetCacheHeroList(), arg_4_0.selectID_)
	end

	ChatFriendData:LockFriendID(arg_4_0.selectID_)
	arg_4_0.chatFriendContentView_:OnEnter(arg_4_0.selectID_)
	arg_4_0.loopScrollView_:NavigateIndex(var_4_0)

	arg_4_0.newMsgHandler_ = handler(arg_4_0, arg_4_0.OnReceiveMsg)

	manager.notify:RegistListener(CHAT_FRIEND_NEW_MESSAGE, arg_4_0.newMsgHandler_)

	arg_4_0.closeFriendItemHandler_ = handler(arg_4_0, arg_4_0.OnCloseFriendItem)

	manager.notify:RegistListener(CHAT_FRIEND_CLOSE_ITEM, arg_4_0.closeFriendItemHandler_)
end

function var_0_0.OnUpdate(arg_5_0)
	arg_5_0.selectID_ = arg_5_0.params_.friendID or ChatFriendData:GetCacheHeroList()[1]

	ChatFriendData:LockFriendID(arg_5_0.selectID_)
	arg_5_0.chatFriendContentView_:OnUpdate(arg_5_0.selectID_)
	arg_5_0:RefresItemList()
end

function var_0_0.OnExit(arg_6_0)
	ChatFriendData:LockFriendID(0)
	manager.notify:RemoveListener(CHAT_FRIEND_NEW_MESSAGE, arg_6_0.newMsgHandler_)
	manager.notify:RemoveListener(CHAT_FRIEND_CLOSE_ITEM, arg_6_0.closeFriendItemHandler_)
	arg_6_0.chatFriendContentView_:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.loopScrollView_:Dispose()

	arg_7_0.loopScrollView_ = nil

	arg_7_0.chatFriendContentView_:Dispose()

	arg_7_0.chatFriendContentView_ = nil

	arg_7_0:DisposeItemPool()
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	return
end

function var_0_0.OnReceiveMsg(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:LsGetItemData()
	local var_9_1 = arg_9_0.loopScrollView_:GetItemList()

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = table.keyof(var_9_0, iter_9_1.itemView:GetFriendID())

		iter_9_1.itemView:SetData(iter_9_1.itemView:GetFriendID(), var_9_2, arg_9_0.selectID_)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_1) do
		if iter_9_3.itemView:GetFriendID() == arg_9_1 then
			arg_9_0.loopScrollView_:DeleteIndex(iter_9_2)

			break
		end
	end

	arg_9_0.loopScrollView_:RefreshScrollView()
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.rectGrid_)
end

function var_0_0.OnCloseFriendItem(arg_10_0, arg_10_1)
	ChatFriendData:RemoveCacheHero(arg_10_1)
	arg_10_0.loopScrollView_:RefreshScrollView()

	if arg_10_1 == arg_10_0.selectID_ then
		local var_10_0 = ChatFriendData:GetCacheHeroList()

		if #var_10_0 <= 0 then
			arg_10_0:Back()
		else
			arg_10_0:Go("/chatFriend", {
				friendID = var_10_0[1]
			})
		end
	end
end

function var_0_0.InitItemPool(arg_11_0)
	arg_11_0.itemPool_ = {}
end

function var_0_0.RefresItemList(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.itemPool_) do
		if iter_12_1.isFree == false then
			iter_12_1.itemView:SetSelectID(arg_12_0.selectID_)
		end
	end
end

function var_0_0.GetFreeItem(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.itemPool_) do
		if iter_13_1.isFree == true then
			iter_13_1.isFree = false

			return iter_13_1
		end
	end

	local var_13_0 = ChatFriendItem.New(arg_13_0.goItem_, arg_13_0.goItemParent_)
	local var_13_1 = {
		isFree = false,
		itemView = var_13_0
	}

	table.insert(arg_13_0.itemPool_, var_13_1)

	return var_13_1
end

function var_0_0.DisposeItemPool(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.itemPool_) do
		iter_14_1.itemView:Dispose()
	end

	arg_14_0.itemPool_ = nil
end

function var_0_0.LsAddItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:GetFreeItem()

	var_15_0.itemView:SetData(arg_15_1, arg_15_2, arg_15_0.selectID_)

	return var_15_0
end

function var_0_0.LsUpdateItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1.itemView:SetData(arg_16_2, arg_16_3, arg_16_0.selectID_)
end

function var_0_0.LsRemoveItem(arg_17_0, arg_17_1)
	arg_17_1.itemView:Show(false)

	arg_17_1.isFree = true
end

function var_0_0.LsGetItemData(arg_18_0)
	return ChatFriendData:GetCacheHeroList()
end

return var_0_0
