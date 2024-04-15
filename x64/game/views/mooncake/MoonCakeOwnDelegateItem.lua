slot0 = class("MoonCakeOwnDelegateItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.friendController_ = ControllerUtil.GetController(slot0.transform_, "friend")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.addFriendBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if FriendsData:IsCanBeFriend(uv0.delegateData_.submiter_uid) then
			FriendsAction:TryToRequestToFriend(slot0, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
		end
	end)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.delegateData_.submiter_uid)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.delegateData_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDelegate()
	slot0:RefreshGiver()
	slot0:RefreshFriend()
end

function slot0.RefreshGiver(slot0)
	slot1 = slot0.delegateData_.submiter_uid
	slot0.userName_.text = slot0.delegateData_.nick
	slot0.userIcon.sprite = ItemTools.getItemSprite(slot0.delegateData_.portrait)
	slot0.userFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.delegateData_.frame)
end

function slot0.RefreshFriend(slot0)
	if FriendsData:IsFriend(slot0.delegateData_.submiter_uid) == true then
		slot0.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(slot1) == true then
		slot0.friendController_:SetSelectedState("requested")
	else
		slot0.friendController_:SetSelectedState("add")
	end
end

function slot0.RefreshDelegate(slot0)
	slot2 = MoonCakeCfg[slot0.delegateData_.targetID].moon_cakes
	slot0.moonCakeName_.text = ItemTools.getItemName(slot2) .. "X1"
	slot0.moonCakeIcon_.sprite = ItemTools.getItemSprite(slot2)
end

return slot0
