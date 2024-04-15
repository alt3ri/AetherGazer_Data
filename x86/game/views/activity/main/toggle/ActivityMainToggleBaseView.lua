slot0 = class("ActivityMainToggleBaseView", ReduxView)
slot0.IsCommonMainActivityPage = true

function slot0.UIName(slot0)
	return ActivityEntraceCfg[slot0:GetActivityID()].prefab_path
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.toggleClickHandler_ = handler(slot0, slot0.ToggleOnClick)
	slot0.toggleOverHandler_ = handler(slot0, slot0.ToggleOver)
	slot0.toggleItemList_ = {}
	slot0.panelItemList_ = {}
	slot0.activeItemList_ = {}
	slot0.activePanelList_ = {}
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, slot0.toggleClickHandler_)

	slot4 = slot0.toggleOverHandler_

	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_OVER, slot4)

	for slot4, slot5 in pairs(slot0.toggleItemList_) do
		slot5:Show(false)
	end

	slot0.activeItemList_ = {}
	slot4 = slot0

	for slot4, slot5 in ipairs(ActivityToggleCfg.get_id_list_by_activity_theme[slot0.GetActivityTheme(slot4)]) do
		slot6 = ActivityToggleCfg[slot5]
		slot0.toggleItemList_[slot6.activity_id] = slot0.toggleItemList_[slot6.activity_id] or ActivityMainToggleItem.New(slot0.itemGo_, slot0.itemParentGo_, slot5, slot6.activity_id)

		slot0.toggleItemList_[slot6.activity_id]:Show(true)

		slot0.activeItemList_[slot6.activity_id] = true
	end

	for slot4, slot5 in pairs(slot0.activeItemList_) do
		slot0.toggleItemList_[slot4]:OnEnter()
	end

	slot0.activePanelList_ = {}
	slot1 = nil

	if ((not slot0.params_.isBack or ActivityVersionData:GetSelectActivityID(slot0:GetActivityID())) and (not slot0.params_.subActivityID or slot0.params_.subActivityID) and slot0:GetOpenActivityID()) == nil then
		slot0:Go("/home")

		return
	end

	slot0:ScrollToggle(slot1)
	slot0:ToggleOnClick(slot1, true)
	slot0:UpdateUIArrow()
end

function slot0.OnTop(slot0)
	if ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == nil then
		return
	end

	if slot0.panelItemList_[slot1] then
		slot0.panelItemList_[slot1]:OnTop()

		if slot0.panelItemList_[slot1].UpdateBar then
			slot0.panelItemList_[slot1]:UpdateBar()
		end
	end
end

function slot0.OnUpdate(slot0)
	if not slot0.params_.subActivityID or ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == slot1 then
		return
	end

	slot0:ScrollToggle(slot1)
	slot0:ToggleOnClick(slot1, true)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_CLICK, slot0.toggleClickHandler_)

	slot4 = slot0.toggleOverHandler_

	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_OVER, slot4)

	for slot4, slot5 in pairs(slot0.activeItemList_) do
		slot0.toggleItemList_[slot4]:OnExit()
	end

	for slot4, slot5 in pairs(slot0.activePanelList_) do
		slot6 = slot0.panelItemList_[slot4]

		slot6:Show(false)
		slot6:OnExit()
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.toggleClickHandler_ = nil
	slot0.toggleOverHandler_ = nil

	for slot4, slot5 in pairs(slot0.panelItemList_) do
		slot5:Dispose()
	end

	slot0.panelItemList_ = nil

	for slot4, slot5 in pairs(slot0.toggleItemList_) do
		slot5:Dispose()
	end

	slot0.toggleItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.scrollView_, function (slot0)
		uv0:UpdateUIArrow()
	end)
end

function slot0.GetToggleCfg(slot0)
	return {}
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityID
end

function slot0.GetActivityTheme(slot0)
	return ActivityTools.GetActivityTheme(slot0:GetActivityID())
end

function slot0.ToggleOnClick(slot0, slot1, slot2)
	if ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == slot1 and slot2 ~= true then
		return
	end

	slot0.params_.subActivityID = slot1
	slot7 = slot1

	ActivityVersionData:SetSelectActivityID(slot0:GetActivityID(), slot7)

	for slot7, slot8 in pairs(slot0.panelItemList_) do
		if slot7 ~= slot1 then
			slot8:Show(false)
		end
	end

	if not slot0.panelItemList_[slot1] then
		slot0.panelItemList_[slot1] = ActivityTools.GetTogglePanelView(slot1).New(slot0.panelParentGo_, slot1)
	end

	if not slot0.activePanelList_[slot1] then
		slot0.panelItemList_[slot1]:OnEnter()

		slot0.activePanelList_[slot1] = true
	end

	slot0.panelItemList_[slot1]:UpdateBar()
	slot0.panelItemList_[slot1]:Show(true)

	for slot7, slot8 in pairs(slot0.toggleItemList_) do
		slot8:OnSelect(slot7 == slot1)
	end
end

function slot0.ScrollToggle(slot0, slot1)
	slot0.scrollTimer_ = FrameTimer.New(function ()
		if uv0.scrollView_ then
			slot0, slot1 = uv0:GetActivityIndex(uv1)

			if slot0 == nil then
				uv0.scrollView_.verticalNormalizedPosition = 1
			else
				if (slot0 - 1) / ((uv0.contentTf_.rect.height - uv0.viewTf_.rect.height) / (uv0.itemTf_.rect.height + uv0.contentLayout_.spacing)) > 1 then
					slot2 = 1
				elseif slot2 < 0 then
					slot2 = 0
				end

				uv0.scrollView_.verticalNormalizedPosition = 1 - slot2
			end
		end
	end, 1, 1)

	slot0.scrollTimer_:Start()
end

function slot0.UpdateUIArrow(slot0)
	if slot0.viewTf_.rect.height < slot0.contentTf_.rect.height and slot0.scrollView_.verticalNormalizedPosition > 0 then
		SetActive(slot0.arrowGo_, true)
	else
		SetActive(slot0.arrowGo_, false)
	end
end

function slot0.ToggleOver(slot0, slot1)
	if ActivityVersionData:GetSelectActivityID(slot0:GetActivityID()) == slot1 then
		if slot0:GetOpenActivityID() == nil then
			slot0:Go("/home")

			return
		end

		slot0:ToggleOnClick(slot3, true)
	end
end

function slot0.GetOpenActivityID(slot0)
	slot1 = manager.time:GetServerTime()

	for slot6, slot7 in ipairs(ActivityToggleCfg.get_id_list_by_activity_theme[slot0:GetActivityTheme()]) do
		slot8 = ActivityToggleCfg[slot7].activity_id
		slot9 = ActivityData:GetActivityData(slot8)
		slot10 = slot9.startTime
		slot11 = slot9.stopTime

		if ActivityShopCfg[slot8] then
			slot11 = ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot8].shop_id].activity_id).stopTime
		end

		if slot10 <= slot1 and slot1 < slot11 then
			return slot8
		end
	end
end

function slot0.GetActivityIndex(slot0, slot1)
	slot2 = manager.time:GetServerTime()
	slot4 = {}

	for slot8, slot9 in ipairs(ActivityToggleCfg.get_id_list_by_activity_theme[slot0:GetActivityTheme()]) do
		slot10 = ActivityToggleCfg[slot9].activity_id
		slot11 = ActivityData:GetActivityData(slot10)

		if ActivityShopCfg[slot10] then
			if ActivityData:GetActivityData(ShopListCfg[ActivityShopCfg[slot10].shop_id].activity_id):IsActivitying() then
				table.insert(slot4, slot10)
			end
		elseif slot11.startTime <= slot2 and slot2 < slot11.stopTime then
			table.insert(slot4, slot10)
		end
	end

	return table.keyof(slot4, slot1), #slot4
end

return slot0
