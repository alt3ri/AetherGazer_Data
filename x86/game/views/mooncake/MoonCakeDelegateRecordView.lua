slot0 = class("MoonCakeDelegateRecordView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeDelegateRecordUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.submitedDelegateList_ = LuaList.New(handler(slot0, slot0.IndexSubmitedItem), slot0.completedListGo_, MoonCakeDelegateItem)
	slot0.ownDelegateList_ = LuaList.New(handler(slot0, slot0.IndexOwnItem), slot0.ownListGo_, MoonCakeOwnDelegateItem)
	slot0.recordTypeConst_ = {
		other = 2,
		own = 1
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	slot0.submitedDelegateList_:Dispose()

	slot0.submitedDelegateList_ = nil

	slot0.ownDelegateList_:Dispose()

	slot0.ownDelegateList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	if slot0.params_.isBack then
		slot0.curType_ = MoonCakeTools.GetTempRecordViewType(slot0.activityID_)
		slot0.tempScrollPos_ = MoonCakeTools.GetTempRecordViewScrollPos(slot0.activityID_)
	else
		slot0.curType_ = slot0.params_.recoverType
		slot0.tempScrollPos_ = nil
	end

	if slot0.recordTypeConst_.own == slot0.curType_ then
		slot0:RefreshOwnDelegate(slot0.tempScrollPos_)
	else
		slot0:RefreshSubmitedDelegate(slot0.tempScrollPos_)
	end

	slot0.typeController_:SetSelectedIndex(slot0.curType_ - 1)
end

function slot0.OnExit(slot0)
	MoonCakeTools.SetTempRecordViewType(slot0.activityID_, slot0.curType_)

	slot1 = nil

	MoonCakeTools.SetTempRecordViewScrollPos(slot0.activityID_, (slot0.curType_ ~= slot0.recordTypeConst_.own or slot0.ownDelegateList_:GetScrolledPosition()) and slot0.submitedDelegateList_:GetScrolledPosition())

	slot0.tempScrollPos_ = nil
end

function slot0.RefreshSubmitedDelegate(slot0, slot1)
	slot0.submitedDelegateDataList_ = MoonCakeData:GetSubmitedDelegateList(slot0.activityID_)

	if not slot1 then
		slot0.submitedDelegateList_:StartScroll(#slot0.submitedDelegateDataList_)
	else
		slot0.submitedDelegateList_:StartScrollByPosition(#slot0.submitedDelegateDataList_, slot1)
	end
end

function slot0.RefreshOwnDelegate(slot0, slot1)
	slot0.ownDelegateDataList_ = MoonCakeData:GetOwnSubmitedDelegateList(slot0.activityID_)

	if not slot1 then
		slot0.ownDelegateList_:StartScroll(#slot0.ownDelegateDataList_)
	else
		slot0.ownDelegateList_:StartScrollByPosition(#slot0.ownDelegateDataList_, slot1)
	end
end

function slot0.IndexSubmitedItem(slot0, slot1, slot2)
	slot2:SetData(slot0.submitedDelegateDataList_[slot1], slot0.activityID_)
end

function slot0.IndexOwnItem(slot0, slot1, slot2)
	slot2:SetData(slot0.ownDelegateDataList_[slot1], slot0.activityID_)
end

function slot0.OnReceiveDelegateReward(slot0)
	slot0:RefreshOwnDelegate()
end

function slot0.OnFriendsListChange(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs((slot0.recordTypeConst_.own ~= slot0.curType_ or slot0.ownDelegateList_:GetItemList()) and slot0.submitedDelegateList_:GetItemList()) do
		slot6:RefreshFriend()
	end
end

return slot0
