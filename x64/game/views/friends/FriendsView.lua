slot0 = class("FriendsView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Friends/FriendsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.contentView_ = FriendsRightContentView.New(slot0.rightContentPanel_)
	slot0.toggle_ = {}
	slot0.toggleCon_ = {}

	for slot4 = 1, 4 do
		slot0.toggle_[slot4] = slot0["tgl_" .. slot4]
		slot0.toggleCon_[slot4] = ControllerUtil.GetController(slot0.toggle_[slot4].transform, "name")
	end

	slot0.pageCon_ = ControllerUtil.GetController(slot0.gameObject_.transform, "pageCon")
end

function slot0.AddUIListeners(slot0)
	for slot4, slot5 in ipairs(slot0.toggle_) do
		slot0:AddBtnListener(slot5, nil, function ()
			if uv0 ~= uv1.curPageIndex_ then
				uv1:RefreshUI(uv0)
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.contentView_:OnEnter()

	slot0.params_.friendPage = slot0.params_.friendPage or FriendsConst.FRIEND_TYPE.MY_FRIENDS
	slot0.curPageIndex_ = slot0.params_.friendPage == FriendsConst.FRIEND_TYPE.SEARCH and FriendsConst.FRIEND_TYPE.NEW_FRIENDS or slot0.params_.friendPage

	slot0:BindRedPoint()
	slot0:RefreshUI(slot0.curPageIndex_)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.isRefreshing_ = true
	slot0.curPageIndex_ = slot1
	slot0.params_.friendPage = slot0.curPageIndex_

	if slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		FriendsAction:TryToRefreshFriendsView(1)
	elseif slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.NEW_FRIENDS then
		if not FriendsData:GetHadFreshNewFriend() then
			FriendsAction:TryToRefreshNewFriendsList(1)
		else
			slot0.isRefreshing_ = false

			slot0.contentView_:RefreshUI(slot0.curPageIndex_)
			slot0.pageCon_:SetSelectedState(slot0.curPageIndex_)
			slot0:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
		end
	elseif slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.SEARCH then
		slot0.isRefreshing_ = false

		slot0.contentView_:RefreshUI(slot0.curPageIndex_)
		slot0.pageCon_:SetSelectedState(slot0.curPageIndex_)
		slot0:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
	elseif slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.FRIEND_REQUESTS then
		FriendsAction:TryToRefreshFriendsView(2)
	elseif slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.BLACKLIST then
		FriendsAction:TryToRefreshFriendsView(3)
	end
end

function slot0.RefreshTgl(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.toggleCon_) do
		slot6:SetSelectedState(slot5 == slot1 and "false" or "true")
	end
end

function slot0.OnFriendsListChange(slot0, slot1)
	slot1 = slot1 or slot0.curPageIndex_

	if slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.NEW_FRIENDS and slot1 == FriendsConst.FRIEND_TYPE.SEARCH then
		slot0.curPageIndex_ = FriendsConst.FRIEND_TYPE.SEARCH
		slot0.params_.friendPage = slot0.curPageIndex_
	end

	if slot1 == FriendsConst.FRIEND_TYPE.SEARCH then
		slot0:RefreshTgl(FriendsConst.FRIEND_TYPE.NEW_FRIENDS)
	else
		slot0:RefreshTgl(slot1)
	end

	slot0.isRefreshing_ = false

	slot0.contentView_:RefreshUI(slot0.curPageIndex_)
	slot0.pageCon_:SetSelectedState(slot0.curPageIndex_)
end

function slot0.OnFriendsChatChange(slot0, slot1, slot2, slot3)
	if slot0.isRefreshing_ then
		return
	end

	if slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		slot0.contentView_:OnFriendsChatChange(slot1, slot2, slot3)
	end
end

function slot0.OnFriendsUnreadChange(slot0, slot1, slot2)
	if slot0.isRefreshing_ then
		return
	end

	if slot0.curPageIndex_ == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
		slot0.contentView_:OnFriendsUnreadChange(slot1, slot2)
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.toggle_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.toggle_[3].transform, RedPointConst.FRIEND_FRIEND_REQUESTS)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:UnbindRedPoint()
	slot0.contentView_:OnExit()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.contentView_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
