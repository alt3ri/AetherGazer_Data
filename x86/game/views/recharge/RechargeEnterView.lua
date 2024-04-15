slot0 = class("RechargeEnterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeEnterUI_new"
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

	slot0.bgList_ = {}
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, RechargeEnterListItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.recommendIdList_[slot1])

	if slot2:GetIndex() == slot0.pageIndex_ then
		slot2:SetSelect(true)
	else
		slot2:SetSelect(false)
	end

	slot2:RegisterClickListener(function (slot0)
		OperationRecorder.RecordButtonTouch("shop_recommend_left_" .. uv0.recommendIdList_[slot0])

		if uv0.pageIndex_ ~= slot0 then
			uv0.uiList_:SwitchToPage(slot0)
			uv0:OnPageChange(slot0)
		end

		ShopAction.ReadRedPoint(uv0.recommendIdList_[slot0])
		uv0.timer_:Reset()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DAILY_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.rechargeBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("shop_recharge")
		JumpTools.GoToSystem("/rechargeMain", {
			page = 1
		}, ViewConst.SYSTEM_ID.RECHARGE)
	end)
end

function slot0.OnPageChange(slot0, slot1)
	if slot0.pageIndex_ == slot1 then
		return
	end

	CustomLog.Log(debug.traceback(string.format("OnPageChange, index = %s", tostring(slot1))))

	if slot0.bgList_[slot0.recommendIdList_[slot0.pageIndex_]] then
		slot0.bgList_[slot2]:Hide()
	end

	slot0.pageIndex_ = slot1

	slot0.uiList_:Refresh()
	slot0:UpdatePageView()
end

function slot0.UpdatePageView(slot0)
	slot1 = slot0.recommendIdList_[slot0.pageIndex_]
	slot0.cfg_ = RechargeRecommendCfg[slot1]

	if not slot0.bgList_[slot1] then
		slot0.bgList_[slot1] = slot0:CreatedRecommendBgItem(slot1)
	else
		slot0.bgList_[slot1]:Show()
	end

	slot0.bgList_[slot1]:SetData(slot0.pageIndex_, slot0.cfg_)
end

function slot0.CreatedRecommendBgItem(slot0, slot1)
	slot2 = RechargeRecommendCfg[slot1]

	if slot2.show_type == 1 then
		return RechargeRecommendFukubukuroItemView.New(Object.Instantiate(Asset.Load("Widget/System/Shop/RechargeShopRecommend/" .. slot2.prefab), slot0.bgContainer_))
	else
		return RechargeRecommendBgItemView.New(slot4)
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot0.OnEnter(slot0)
	slot0.recommendIdList_ = {}

	for slot4, slot5 in ipairs(RechargeRecommendCfg.all) do
		slot8 = false

		if not RechargeRecommendCfg[slot5].time[1] or #slot7[1] < 3 or #slot7[2] < 3 then
			slot8 = true
		end

		if not slot6.time[2] or #slot9[1] < 3 or #slot9[2] < 3 then
			slot8 = true
		end

		if slot8 or TimeMgr.GetInstance():GetServerTime() < TimeMgr.GetInstance():parseTimeFromConfig(slot6.time[2]) and TimeMgr.GetInstance():parseTimeFromConfig(slot6.time[1]) <= slot12 and true or false then
			table.insert(slot0.recommendIdList_, slot5)
		end
	end

	table.sort(slot0.recommendIdList_, function (slot0, slot1)
		return RechargeRecommendCfg[slot0].order < RechargeRecommendCfg[slot1].order
	end)
	slot0.uiList_:StartScroll(#slot0.recommendIdList_)
	manager.redPoint:bindUIandKey(slot0.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:bindUIandKey(slot0.shopBtn_.transform, RedPointConst.SHOP)
	slot0:OnPageChange(1)
	slot0:StartTimer()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.rechargeBtn_.transform, RedPointConst.RECHARGE)
	manager.redPoint:unbindUIandKey(slot0.shopBtn_.transform, RedPointConst.SHOP)
	manager.windowBar:HideBar()
	slot0:StopTimer()

	if slot0.bgList_[slot0.recommendIdList_[slot0.pageIndex_]] then
		slot0.bgList_[slot1]:Hide()
	end

	slot0.pageIndex_ = 0
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:ScrollToNextPage()
		end, 10, -1)
	end

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.ScrollToNextPage(slot0)
	if #slot0.recommendIdList_ <= 1 then
		return
	end

	slot1 = slot0.pageIndex_ % #slot0.recommendIdList_ + 1

	slot0.uiList_:SwitchToPage(slot1)
	slot0:OnPageChange(slot1)
	CustomLog.Log(debug.traceback(string.format("ScrollToNextPage, newIndex = %s", tostring(slot1))))
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	slot0:UpdatePageView()
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	if slot0.bgList_ then
		for slot4, slot5 in pairs(slot0.bgList_) do
			slot5:Dispose()
		end

		slot0.bgList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
