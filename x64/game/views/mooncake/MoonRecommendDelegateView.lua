slot0 = class("MoonRecommendDelegateView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.delegateList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, MoonCakeDelegateItem)
end

function slot0.Dispose(slot0)
	slot0.delegateList_:Dispose()

	slot0.delegateList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1

	slot0:RefreshList(slot2)
	slot0:RefreshProgress()
end

function slot0.RefreshList(slot0, slot1)
	slot0.delegateDataList_ = MoonCakeData:GetSortRecommendDelegateList(slot0.activityID_)

	if not slot1 then
		slot0.delegateList_:StartScroll(#slot0.delegateDataList_)
	else
		slot0.delegateList_:StartScrollByPosition(#slot0.delegateDataList_, slot1)
	end
end

function slot0.RefreshProgress(slot0)
	slot0.progressText_.text = string.format("%s/%s", slot1 - (MoonCakeData:GetTodaySubmitTimes(slot0.activityID_) <= GameSetting.activity_mid_autumn_entrust_finish_limit.value[1] and slot2 or slot1), slot1)
end

function slot0.GetScrollPos(slot0)
	return slot0.delegateList_:GetScrolledPosition()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.delegateDataList_[slot1], slot0.activityID_)
end

function slot0.PageRegisterEvent(slot0)
	slot0:RegistEventListener(MOON_DELEGATE_SUBMIT, handler(slot0, slot0.OnSubmitDelegate))
	slot0:RegistEventListener(MOON_RECOMMEND_DELEGATE_UPDATE, handler(slot0, slot0.OnRefreshRecommendDelegate))
end

function slot0.PageRemoveEvent(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnSubmitDelegate(slot0)
	for slot5, slot6 in pairs(slot0.delegateList_:GetItemList()) do
		slot6:RefreshUI()
	end

	slot0:RefreshProgress()
end

function slot0.OnRefreshRecommendDelegate(slot0)
	slot0:RefreshList()
end

function slot0.OnFriendsListChange(slot0)
	for slot5, slot6 in pairs(slot0.delegateList_:GetItemList()) do
		slot6:RefreshFriend()
	end
end

return slot0
