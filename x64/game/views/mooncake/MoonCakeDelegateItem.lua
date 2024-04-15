slot0 = class("MoonCakeDelegateItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.friendController_ = ControllerUtil.GetController(slot0.transform_, "friend")
end

function slot0.AddUIListener(slot0)
	if slot0.submitBtn_ then
		slot0:AddBtnListener(slot0.submitBtn_, nil, function ()
			if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			if GameSetting.activity_mid_autumn_entrust_finish_limit.value[1] <= MoonCakeData:GetTodaySubmitTimes(uv0.activityID_) then
				ShowTips("MID_AUTUMN_FESTIVAL_TASK_FINISH_LIMIT")

				return
			end

			MoonCakeAction.SubmitDelegate(uv0.activityID_, uv0.delegateData_.uid, uv0.delegateData_.delegateID)
		end)
	end

	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.delegateData_.uid)
	end)

	if slot0.addFriendBtn_ then
		slot0:AddBtnListener(slot0.addFriendBtn_, nil, function ()
			if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
				ShowTips("TIME_OVER")

				return
			end

			if FriendsData:IsCanBeFriend(uv0.delegateData_.uid) then
				FriendsAction:TryToRequestToFriend(slot0, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
			end
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.delegateData_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshPrincipal()
	slot0:RefreshFriend()
	slot0:RefreshDelegate()
	slot0:RefreshStatus()
end

function slot0.RefreshPrincipal(slot0)
	slot0.userName_.text = slot0.delegateData_.nick
	slot0.userLevel_.text = "LV." .. slot0.delegateData_.level
	slot0.userUid_.text = slot0.delegateData_.uid
	slot0.userIcon_.sprite = ItemTools.getItemSprite(slot0.delegateData_.portrait)
	slot0.userFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.delegateData_.frame)
end

function slot0.RefreshFriend(slot0)
	if FriendsData:IsFriend(slot0.delegateData_.uid) == true then
		slot0.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(slot0.delegateData_.uid) == true then
		slot0.friendController_:SetSelectedState("requested")
	else
		slot0.friendController_:SetSelectedState("add")
	end
end

function slot0.RefreshDelegate(slot0)
	slot0.curNum_ = ItemTools.getItemNum(MoonCakeCfg[slot0.delegateData_.targetID].moon_cakes) or 0

	if slot0.curNum_ > 0 then
		slot0.moonCakeCurNum_.text = string.format(GetTips("MID_AUTUMN_FESTIVAL_MOONCAKE_QUANTITY"), slot0.curNum_)
	else
		slot0.moonCakeCurNum_.text = GetTips("MID_AUTUMN_FESTIVAL_TASK_MOONCAKE_NOT_ENOUGH")
	end

	slot0.moonCakeName_.text = ItemTools.getItemName(slot2)
	slot0.moonCakeIcon_.sprite = ItemTools.getItemSprite(slot2)
	slot0.moonCakeNeedNum_.text = "x1"
end

function slot0.RefreshStatus(slot0)
	if slot0.delegateData_.isCompleted == true then
		slot0.statusController_:SetSelectedState("complete")
	elseif slot0.curNum_ <= 0 then
		slot0.statusController_:SetSelectedState("notEnough")

		slot0.submitBtn_.interactable = false
	else
		slot0.statusController_:SetSelectedState("enough")

		slot0.submitBtn_.interactable = true
	end
end

function slot0.SetStatus(slot0, slot1)
	slot0.statusController_:SetSelectedState(slot1)
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.OnSubmitDelegate(slot0)
	slot0.delegateData_ = MoonCakeData:GetDelegateData(slot0.activityID_, slot0.delegateID_)

	slot0:RefreshStatus()
end

return slot0
