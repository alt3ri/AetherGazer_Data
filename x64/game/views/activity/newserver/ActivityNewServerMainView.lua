slot0 = class("ActivityNewServerMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/NewServer/NewServerMenuUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pageClass = {
		NewServerSignPage,
		NewServerTaskPage,
		NewServerCapsuleToysPage,
		NewServerBPTaskPage,
		NewServerSupplyPage
	}
	slot0.pages_ = {}
	slot0.selectIndex_ = -1
	slot0.clickItemHandler_ = handler(slot0, slot0.SwitchPage)
	slot0.switchItemList_ = {}

	for slot5 = 1, slot0.switchPanelTrans_.childCount do
		slot0.switchItemList_[slot5] = ActivityNewServerSwitchItem.New(slot0.switchPanelTrans_:GetChild(slot5 - 1).gameObject, slot5)

		slot0.switchItemList_[slot5]:SetClickCallBack(slot0.clickItemHandler_)
	end
end

function slot0.AddUIListener(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		uv0:ShopRefresh()
	end)
	slot0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function (slot0)
		if uv0.curPage_ then
			uv0.curPage_:SetData(uv0.activityID_)
		end
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		uv0:ShopRefresh()
	end)
end

function slot0.OnTop(slot0)
	slot0.curPage_:UpdateBar()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = ActivityConst.ACTIVITY_NEW_SERVER

	if slot0.params_.selectIndex then
		slot0.params_.selectIndex = nil
		slot0.params_.Inited = true
	elseif slot0.params_.isBack == true then
		slot0.selectIndex_ = -1

		slot0:SwitchPage(slot0.params_.lastIndex)
	elseif not slot0.params_.Inited then
		slot0.params_.Inited = true
		slot0.selectIndex_ = -1

		slot0:SwitchPage(1)
	end

	slot0:BindRedPoint()
	slot0:RefreshTime()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshTime()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.params_.lastIndex = slot0.selectIndex_

	slot0:RemoveAllEventListener()
	slot0:UnbindRedPoint()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.curPage_ and slot0.curPage_.OnExit then
		slot0.curPage_:OnExit()
		slot0.curPage_:SetActive(false)
	end
end

function slot0.Dispose(slot0)
	slot0.params_.Inited = nil

	if slot0.curPage_ then
		slot0.curPage_:SetActive(false)

		slot0.curPage_ = nil
	end

	for slot4, slot5 in pairs(slot0.pages_) do
		slot5:Dispose()
	end

	slot0.pages_ = nil

	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:Dispose()
	end

	slot0.switchItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SwitchPage(slot0, slot1)
	if slot1 == slot0.selectIndex_ then
		return
	end

	slot0.selectIndex_ = slot1

	slot0:RefreshSelect()

	if slot0.curPage_ then
		slot0.curPage_:OnExit()
		slot0.curPage_:SetActive(false)
	end

	if not slot0.pages_[slot1] then
		slot0.pages_[slot1] = slot0.pageClass[slot1].New(slot0.contentTrans_)
	end

	slot0.curPage_ = slot0.pages_[slot1]

	slot0.curPage_:SetActive(true)
	slot0.curPage_:OnEnter()

	if slot0.params_.isBack == true then
		if slot0.curPage_.SetIsBack then
			slot0.curPage_:SetIsBack(slot0.params_.isBack)
		end

		slot0.params_.isBack = false
	end

	slot0.curPage_:SetData(slot0.activityID_)
	slot0.curPage_:UpdateBar()
end

function slot0.RefreshSelect(slot0)
	for slot4, slot5 in ipairs(slot0.switchItemList_) do
		slot5:RefreshSelect(slot0.selectIndex_)
	end
end

function slot0.RefreshTime(slot0)
	slot0.remainTimeText_.text = string.format(GetTips("LEFT_TIME"), ActivityTools.GetActivityLostTimeStrWith2Unit(slot0.activityID_))

	if slot0.curPage_ and slot0.curPage_.RefreshTime then
		slot0.curPage_:RefreshTime()
	end
end

function slot0.OnTaskListChange(slot0)
	if slot0.curPage_ and slot0.curPage_.OnTaskListChange then
		slot0.curPage_:OnTaskListChange()
	end
end

function slot0.ShopRefresh(slot0)
	if slot0.curPage_ and slot0.curPage_.RefreshList then
		slot0.curPage_:RefreshList(true)
	end
end

function slot0.OnNewServerSign(slot0, slot1)
	if slot0.curPage_ and slot0.curPage_.OnNewServerSign then
		slot0.curPage_:OnNewServerSign(slot1)
	end
end

function slot0.OnShopBuyResult(slot0)
	slot0:ShopRefresh()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.switchItemList_[1].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SIGN)
	manager.redPoint:bindUIandKey(slot0.switchItemList_[2].transform_, RedPointConst.ACTIVITY_NEW_SERVER_TASK)
	manager.redPoint:bindUIandKey(slot0.switchItemList_[4].transform_, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.redPoint:bindUIandKey(slot0.switchItemList_[5].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE)
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[1].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SIGN)
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[2].transform_, RedPointConst.ACTIVITY_NEW_SERVER_TASK)
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[4].transform_, RedPointConst.ACTIVITY_NEW_SERVER_BP)
	manager.redPoint:unbindUIandKey(slot0.switchItemList_[5].transform_, RedPointConst.ACTIVITY_NEW_SERVER_SUPPLY_FREE)
end

return slot0
