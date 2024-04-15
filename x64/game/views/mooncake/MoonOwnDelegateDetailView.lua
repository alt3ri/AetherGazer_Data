slot0 = class("MoonOwnDelegateDetailView", ReduxView)

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
	slot0:AddBtnListener(slot0.dispatchBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetSelectDelegateDispatchBtn(uv0.activityID_)
		MoonCakeAction.UpdateDelegateDispatchPoint(uv0.activityID_)
		JumpTools.OpenPageByJump("moonCakeDispatchDelegate", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.addFriendBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if FriendsData:IsCanBeFriend(uv0.delegateData_.submiter_uid) then
			FriendsAction:TryToRequestToFriend(slot0, FriendConst.ADD_FRIEND_SOURCE.MOON_CAKE_DELEGATE)
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeAction.ReceiveDelegateReward(uv0.activityID_, uv0.delegateData_.delegateID)
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		slot0 = uv0.activityID_
		slot1 = uv0.delegateData_.delegateID

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("MID_AUTUMN_FESTIVAL_TASK_CANCEL_CONFIRM"),
			OkCallback = function ()
				if MoonCakeData:GetOwnDelegateData(uv0, uv1).isCompleted == true or slot0.isReceived == true then
					ShowTips("MID_AUTUMN_FESTIVAL_TASK_CANCEL_FAIL")

					return
				end

				MoonCakeAction.CancelDelegate(uv0, uv1)
			end
		})
	end)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.delegateData_.submiter_uid)
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(slot0.activityID_)

	slot0:RefreshStatus()
	slot0:RefreshTodayProgress()
	slot0:RefreshDelegate()
	slot0:RefreshGiver()
	slot0:RefreshFriend()
end

function slot0.RefreshStatus(slot0)
	if slot0.delegateData_.delegateID == nil then
		slot0.statusController_:SetSelectedState("none")
	elseif slot0.delegateData_.isCompleted ~= true then
		slot0.statusController_:SetSelectedState("running")
	elseif slot0.delegateData_.isReceived == false then
		slot0.statusController_:SetSelectedState("completed")
	end
end

function slot0.RefreshTodayProgress(slot0)
	slot2 = MoonCakeData:GetTodayDisptachTimes(slot0.activityID_) <= GameSetting.activity_mid_autumn_entrust_release_limit.value[1] and slot2 or slot1
	slot0.progressText_.text = string.format("%s/%s", slot1 - slot2, slot1)
	slot0.dispatchBtn_.interactable = slot2 < slot1
end

function slot0.RefreshGiver(slot0)
	if not slot0.delegateData_.isCompleted then
		return
	end

	slot1 = slot0.delegateData_.submiter_uid
	slot0.userName_.text = slot0.delegateData_.nick
	slot0.userIcon.sprite = ItemTools.getItemSprite(slot0.delegateData_.portrait)
	slot0.userFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.delegateData_.frame)
end

function slot0.RefreshFriend(slot0)
	if not slot0.delegateData_.isCompleted then
		return
	end

	if FriendsData:IsFriend(slot0.delegateData_.submiter_uid) == true then
		slot0.friendController_:SetSelectedState("myFriend")
	elseif FriendsData:IsInRequest(slot1) == true then
		slot0.friendController_:SetSelectedState("requested")
	else
		slot0.friendController_:SetSelectedState("add")
	end
end

function slot0.RefreshDelegate(slot0)
	if slot0.delegateData_.delegateID == nil then
		return
	end

	slot2 = MoonCakeCfg[slot0.delegateData_.targetID].moon_cakes
	slot0.moonCakeName_.text = ItemTools.getItemName(slot2) .. "X1"
	slot0.moonCakeIcon_.sprite = ItemTools.getItemSprite(slot2)
end

function slot0.PageRegisterEvent(slot0)
	slot0:RegistEventListener(MOON_DELEGATE_CALCEL, handler(slot0, slot0.OnCancelDelegate))
	slot0:RegistEventListener(MOON_DELEGATE_REWARD_RECEIVE, handler(slot0, slot0.OnReceiveDelegateReward))
	slot0:RegistEventListener(MOON_DELEGATE_UPDATE, handler(slot0, slot0.OnDelegateUpdate))
	manager.redPoint:bindUIandKey(slot0.dispatchBtn_.transform, string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, slot0.activityID_))
end

function slot0.PageRemoveEvent(slot0)
	slot0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(slot0.dispatchBtn_.transform, string.format("%s_%s", RedPointConst.MOON_DELEGATE_DISPATCH, slot0.activityID_))
end

function slot0.OnCancelDelegate(slot0)
	slot0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(slot0.activityID_)

	slot0:RefreshStatus()
end

function slot0.OnReceiveDelegateReward(slot0)
	slot0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(slot0.activityID_)

	slot0:RefreshStatus()
	slot0:RefreshTodayProgress()
end

function slot0.OnDelegateUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.OnFriendsListChange(slot0)
	slot0.delegateData_ = MoonCakeData:GetOwnRunningDelegate(slot0.activityID_)

	slot0:RefreshFriend()
end

return slot0
