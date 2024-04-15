slot0 = class("SpringWelfareLetterBoxView", ReduxView)
slot1 = {
	PLAYER = 1,
	SYSTEM = 0
}

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeMailUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.page_ = uv0.SYSTEM
	slot0.pageController_ = ControllerUtil.GetController(slot0.transform_, "tap")
	slot0.letterUiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.letterListGo_, SpringWelfareLetterBoxItem)

	slot0:UpdateLetterList()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.OnBehind(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0.letterUiList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.systemBtn_, nil, function ()
		uv0:SwitchPage(uv1.SYSTEM)
	end)
	slot0:AddBtnListener(slot0.playerBtn_, nil, function ()
		uv0:SwitchPage(uv1.PLAYER)
	end)
end

function slot0.RefreshUI(slot0)
	if slot0.page_ == uv0.SYSTEM then
		slot0:RefreshSystemLetterUI()
	elseif slot0.page_ == uv0.PLAYER then
		slot0:RefreshPlayerLetterUI()
	end

	slot0.letterUiList_:Refresh()
end

function slot0.RefreshSystemLetterUI(slot0)
	slot0.letterUiList_:StartScroll(#slot0.systemLetterIdList_)
	slot0.pageController_:SetSelectedState("system")
end

function slot0.RefreshPlayerLetterUI(slot0)
	if SpringWelfareData:IsFetched() then
		slot0.letterUiList_:StartScroll(#slot0.playerLetterIdList_)
	else
		slot0.letterUiList_:StartScroll(0)
	end

	slot0.pageController_:SetSelectedState("player")
end

function slot0.OnLetterPlayerInfoFetched(slot0)
	slot0:RefreshPlayerLetterUI()
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.page_ == slot1 then
		return
	end

	slot0.page_ = slot1

	slot0:RefreshUI()
end

function slot0.UpdateLetterList(slot0)
	slot0.systemLetterIdList_ = SpringWelfareData:GetSystemLetterIdList()
	slot0.playerLetterIdList_ = SpringWelfareData:GetPlayerLetterIdList()
end

function slot0.IndexSystemLetter(slot0, slot1, slot2)
	slot2:SetLetterServerId(slot0.systemLetterIdList_[slot1])
	slot2:RefreshUI()
end

function slot0.IndexPlayerLetter(slot0, slot1, slot2)
	slot2:SetLetterServerId(slot0.playerLetterIdList_[slot1])
	slot2:RefreshUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	if slot0.page_ == uv0.SYSTEM then
		slot0:IndexSystemLetter(slot1, slot2)
	elseif slot0.page_ == uv0.PLAYER then
		slot0:IndexPlayerLetter(slot1, slot2)
	end
end

function slot0.OnNewDay(slot0)
	slot0:UpdateLetterList()
	slot0:RefreshUI()
end

function slot0.OnActivitySpringWelfareInit(slot0)
	slot0:OnNewDay()
end

function slot0.OnFriendsListChange(slot0)
	slot3 = slot0.letterUiList_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnFriendsListChange()
	end
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityId
end

return slot0
