local var_0_0 = class("ActivityMainToggleBaseView", ReduxView)

var_0_0.IsCommonMainActivityPage = true

function var_0_0.UIName(arg_1_0)
	local var_1_0 = arg_1_0:GetActivityID()

	return ActivityEntraceCfg[var_1_0].prefab_path
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.toggleClickHandler_ = handler(arg_3_0, arg_3_0.ToggleOnClick)
	arg_3_0.toggleOverHandler_ = handler(arg_3_0, arg_3_0.ToggleOver)
	arg_3_0.toggleItemList_ = {}
	arg_3_0.panelItemList_ = {}
	arg_3_0.activeItemList_ = {}
	arg_3_0.activePanelList_ = {}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_CLICK, arg_4_0.toggleClickHandler_)
	manager.notify:RegistListener(ACTIVITY_MAIN_TOGGLE_OVER, arg_4_0.toggleOverHandler_)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.toggleItemList_) do
		iter_4_1:Show(false)
	end

	arg_4_0.activeItemList_ = {}

	for iter_4_2, iter_4_3 in ipairs(ActivityToggleCfg.get_id_list_by_activity_theme[arg_4_0:GetActivityTheme()]) do
		local var_4_0 = ActivityToggleCfg[iter_4_3]

		arg_4_0.toggleItemList_[var_4_0.activity_id] = arg_4_0.toggleItemList_[var_4_0.activity_id] or ActivityMainToggleItem.New(arg_4_0.itemGo_, arg_4_0.itemParentGo_, iter_4_3, var_4_0.activity_id)

		arg_4_0.toggleItemList_[var_4_0.activity_id]:Show(true)

		arg_4_0.activeItemList_[var_4_0.activity_id] = true
	end

	for iter_4_4, iter_4_5 in pairs(arg_4_0.activeItemList_) do
		arg_4_0.toggleItemList_[iter_4_4]:OnEnter()
	end

	arg_4_0.activePanelList_ = {}

	local var_4_1

	if arg_4_0.params_.isBack then
		var_4_1 = ActivityVersionData:GetSelectActivityID(arg_4_0:GetActivityID())
	elseif arg_4_0.params_.subActivityID then
		var_4_1 = arg_4_0.params_.subActivityID
	else
		var_4_1 = arg_4_0:GetOpenActivityID()
	end

	if var_4_1 == nil then
		arg_4_0:Go("/home")

		return
	end

	arg_4_0:ScrollToggle(var_4_1)
	arg_4_0:ToggleOnClick(var_4_1, true)
	arg_4_0:UpdateUIArrow()
end

function var_0_0.OnTop(arg_5_0)
	local var_5_0 = ActivityVersionData:GetSelectActivityID(arg_5_0:GetActivityID())

	if var_5_0 == nil then
		return
	end

	if arg_5_0.panelItemList_[var_5_0] then
		arg_5_0.panelItemList_[var_5_0]:OnTop()

		if arg_5_0.panelItemList_[var_5_0].UpdateBar then
			arg_5_0.panelItemList_[var_5_0]:UpdateBar()
		end
	end
end

function var_0_0.OnUpdate(arg_6_0)
	local var_6_0 = arg_6_0.params_.subActivityID
	local var_6_1 = ActivityVersionData:GetSelectActivityID(arg_6_0:GetActivityID())

	if not var_6_0 or var_6_1 == var_6_0 then
		return
	end

	arg_6_0:ScrollToggle(var_6_0)
	arg_6_0:ToggleOnClick(var_6_0, true)
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_CLICK, arg_7_0.toggleClickHandler_)
	manager.notify:RemoveListener(ACTIVITY_MAIN_TOGGLE_OVER, arg_7_0.toggleOverHandler_)

	for iter_7_0, iter_7_1 in pairs(arg_7_0.activeItemList_) do
		arg_7_0.toggleItemList_[iter_7_0]:OnExit()
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0.activePanelList_) do
		local var_7_0 = arg_7_0.panelItemList_[iter_7_2]

		var_7_0:Show(false)
		var_7_0:OnExit()
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	arg_8_0.toggleClickHandler_ = nil
	arg_8_0.toggleOverHandler_ = nil

	for iter_8_0, iter_8_1 in pairs(arg_8_0.panelItemList_) do
		iter_8_1:Dispose()
	end

	arg_8_0.panelItemList_ = nil

	for iter_8_2, iter_8_3 in pairs(arg_8_0.toggleItemList_) do
		iter_8_3:Dispose()
	end

	arg_8_0.toggleItemList_ = nil
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddToggleListener(arg_9_0.scrollView_, function(arg_10_0)
		arg_9_0:UpdateUIArrow()
	end)
end

function var_0_0.GetToggleCfg(arg_11_0)
	return {}
end

function var_0_0.GetActivityID(arg_12_0)
	return arg_12_0.params_.activityID
end

function var_0_0.GetActivityTheme(arg_13_0)
	return ActivityTools.GetActivityTheme(arg_13_0:GetActivityID())
end

function var_0_0.ToggleOnClick(arg_14_0, arg_14_1, arg_14_2)
	if ActivityVersionData:GetSelectActivityID(arg_14_0:GetActivityID()) == arg_14_1 and arg_14_2 ~= true then
		return
	end

	arg_14_0.params_.subActivityID = arg_14_1

	ActivityVersionData:SetSelectActivityID(arg_14_0:GetActivityID(), arg_14_1)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.panelItemList_) do
		if iter_14_0 ~= arg_14_1 then
			iter_14_1:Show(false)
		end
	end

	if not arg_14_0.panelItemList_[arg_14_1] then
		arg_14_0.panelItemList_[arg_14_1] = ActivityTools.GetTogglePanelView(arg_14_1).New(arg_14_0.panelParentGo_, arg_14_1)
	end

	if not arg_14_0.activePanelList_[arg_14_1] then
		arg_14_0.panelItemList_[arg_14_1]:OnEnter()

		arg_14_0.activePanelList_[arg_14_1] = true
	end

	arg_14_0.panelItemList_[arg_14_1]:UpdateBar()
	arg_14_0.panelItemList_[arg_14_1]:Show(true)

	for iter_14_2, iter_14_3 in pairs(arg_14_0.toggleItemList_) do
		iter_14_3:OnSelect(iter_14_2 == arg_14_1)
	end
end

function var_0_0.ScrollToggle(arg_15_0, arg_15_1)
	arg_15_0.scrollTimer_ = FrameTimer.New(function()
		if arg_15_0.scrollView_ then
			local var_16_0, var_16_1 = arg_15_0:GetActivityIndex(arg_15_1)

			if var_16_0 == nil then
				arg_15_0.scrollView_.verticalNormalizedPosition = 1
			else
				local var_16_2 = (var_16_0 - 1) / ((arg_15_0.contentTf_.rect.height - arg_15_0.viewTf_.rect.height) / (arg_15_0.itemTf_.rect.height + arg_15_0.contentLayout_.spacing))

				if var_16_2 > 1 then
					var_16_2 = 1
				elseif var_16_2 < 0 then
					var_16_2 = 0
				end

				arg_15_0.scrollView_.verticalNormalizedPosition = 1 - var_16_2
			end
		end
	end, 1, 1)

	arg_15_0.scrollTimer_:Start()
end

function var_0_0.UpdateUIArrow(arg_17_0)
	if arg_17_0.contentTf_.rect.height > arg_17_0.viewTf_.rect.height and arg_17_0.scrollView_.verticalNormalizedPosition > 0 then
		SetActive(arg_17_0.arrowGo_, true)
	else
		SetActive(arg_17_0.arrowGo_, false)
	end
end

function var_0_0.ToggleOver(arg_18_0, arg_18_1)
	if ActivityVersionData:GetSelectActivityID(arg_18_0:GetActivityID()) == arg_18_1 then
		local var_18_0 = arg_18_0:GetOpenActivityID()

		if var_18_0 == nil then
			arg_18_0:Go("/home")

			return
		end

		arg_18_0:ToggleOnClick(var_18_0, true)
	end
end

function var_0_0.GetOpenActivityID(arg_19_0)
	local var_19_0 = manager.time:GetServerTime()
	local var_19_1 = ActivityToggleCfg.get_id_list_by_activity_theme[arg_19_0:GetActivityTheme()]

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		local var_19_2 = ActivityToggleCfg[iter_19_1].activity_id
		local var_19_3 = ActivityData:GetActivityData(var_19_2)
		local var_19_4 = var_19_3.startTime
		local var_19_5 = var_19_3.stopTime

		if ActivityShopCfg[var_19_2] then
			local var_19_6 = ActivityShopCfg[var_19_2].shop_id
			local var_19_7 = ShopListCfg[var_19_6].activity_id

			var_19_5 = ActivityData:GetActivityData(var_19_7).stopTime
		end

		if var_19_4 <= var_19_0 and var_19_0 < var_19_5 then
			return var_19_2
		end
	end
end

function var_0_0.GetActivityIndex(arg_20_0, arg_20_1)
	local var_20_0 = manager.time:GetServerTime()
	local var_20_1 = ActivityToggleCfg.get_id_list_by_activity_theme[arg_20_0:GetActivityTheme()]
	local var_20_2 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		local var_20_3 = ActivityToggleCfg[iter_20_1].activity_id
		local var_20_4 = ActivityData:GetActivityData(var_20_3)

		if ActivityShopCfg[var_20_3] then
			local var_20_5 = ActivityShopCfg[var_20_3].shop_id
			local var_20_6 = ShopListCfg[var_20_5].activity_id

			if ActivityData:GetActivityData(var_20_6):IsActivitying() then
				table.insert(var_20_2, var_20_3)
			end
		elseif var_20_0 >= var_20_4.startTime and var_20_0 < var_20_4.stopTime then
			table.insert(var_20_2, var_20_3)
		end
	end

	return table.keyof(var_20_2, arg_20_1), #var_20_2
end

return var_0_0
