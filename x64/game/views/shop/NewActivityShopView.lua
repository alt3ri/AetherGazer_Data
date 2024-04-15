local var_0_0 = class("NewActivityShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ActiveStoreUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetItem), arg_4_0.listGo_, ExchangeItemView)
	arg_4_0.stateController = arg_4_0.controller_:GetController("state")
	arg_4_0.titleTogList = {
		RechargeTitleItem.New(arg_4_0.tag01_),
		RechargeTitleItem.New(arg_4_0.tag02_),
		(RechargeTitleItem.New(arg_4_0.tag03_))
	}
end

function var_0_0.SetItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.shopDataList[arg_5_1])
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.AddEventListeners(arg_7_0)
	arg_7_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_8_0)
		if arg_8_0 == 0 or arg_7_0.curShopId_ == arg_8_0 then
			arg_7_0:UpdateShopList(arg_7_0.curShopId_)
		end
	end)
	arg_7_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_9_0)
		arg_7_0.needKeepPos1 = true

		arg_7_0:UpdateShopList(arg_7_0.curShopId_)
	end)
	arg_7_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_10_0, arg_10_1)
		if arg_7_0.curShopId_ ~= arg_10_0 then
			return
		end

		arg_7_0.needKeepPos1 = true

		arg_7_0:UpdateShopList(arg_7_0.curShopId_)
	end)
	arg_7_0:RegistEventListener(CURRENCY_UPDATE, function(arg_11_0)
		local var_11_0 = getShopIDListByCurrency(arg_11_0)

		if var_11_0 ~= nil and #var_11_0 > 0 then
			arg_7_0.needKeepPos1 = true

			arg_7_0:UpdateShopList(arg_7_0.curShopId_, true)
		end
	end)
	arg_7_0:RegistEventListener(MATERIAL_MODIFY, function(arg_12_0)
		local var_12_0 = getShopIDListByCurrency(arg_12_0)

		if var_12_0 ~= nil and #var_12_0 > 0 then
			arg_7_0.needKeepPos1 = true

			arg_7_0:UpdateShopList(arg_7_0.curShopId_)
		end
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:InitShopByParams()
	arg_13_0:UpdateViewByParams()
	arg_13_0:UpdateTitle()
	arg_13_0:AddEventListeners()
	arg_13_0:SetTimer()
end

function var_0_0.OnTop(arg_14_0)
	if arg_14_0.params_.shopId == arg_14_0.curShopId_ then
		arg_14_0:UpdateBarByShopId(arg_14_0.curShopId_)

		return
	end

	arg_14_0.curShopId_ = arg_14_0.params_.shopId

	if arg_14_0.curShopId_ ~= nil then
		arg_14_0.needKeepPos1 = true

		arg_14_0:UpdateViewByParams()
	end
end

function var_0_0.UpdateTitle(arg_15_0)
	local var_15_0 = arg_15_0.groupIndexes[1]

	arg_15_0.groupInfo = arg_15_0.groups[var_15_0]

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.titleTogList) do
		if iter_15_0 <= #arg_15_0.groupInfo.itemIndexes_ then
			SetActive(iter_15_1.gameObject_, true)

			local var_15_1 = arg_15_0.groupInfo[arg_15_0.groupInfo.itemIndexes_[iter_15_0]].id

			iter_15_1:SetData(arg_15_0.groupInfo[arg_15_0.groupInfo.itemIndexes_[iter_15_0]], iter_15_0, handler(arg_15_0, arg_15_0.ClickTitle), var_15_1)
		else
			SetActive(iter_15_1.gameObject_, false)
		end
	end

	if #ShopListCfg[arg_15_0.groupInfo[arg_15_0.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
		arg_15_0.stateController:SetSelectedState("true")
	else
		arg_15_0.stateController:SetSelectedState("false")
	end

	for iter_15_2 = 1, 2 do
		SetActive(arg_15_0["line" .. iter_15_2 .. "Go_"], iter_15_2 < #arg_15_0.groupInfo.itemIndexes_)
	end

	if arg_15_0.currentGroupIndex_ == 1 then
		arg_15_0:ClickTitle(arg_15_0.itemToSelect_ or arg_15_0.currentItemIndex_)
	else
		arg_15_0:ClickTitle(arg_15_0.itemToSelect_ or 1)
	end
end

function var_0_0.ClickTitle(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.groupInfo[arg_16_0.groupInfo.itemIndexes_[arg_16_1]].id

	SetActive(arg_16_0.lockGo_, not ShopTools.CheckShopIsUnLock(var_16_0))

	local var_16_1 = ShopListCfg[var_16_0]

	arg_16_0.lockDescTxt_.text = ShopTools.GetShopIsUnLockDesc(var_16_0)
	arg_16_0.currentItemIndex_ = arg_16_1
	arg_16_0.titleTxt_.text = GetI18NText(var_16_1.remark)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.titleTogList) do
		iter_16_1.controller:SetSelectedState(iter_16_0 == arg_16_1 and "false" or "true")
	end

	arg_16_0.roleBg_.sprite = getSpriteWithoutAtlas(var_16_1.shop_background)

	arg_16_0:UpdateBarByShopId(var_16_0)

	arg_16_0.params_.shopId = var_16_0

	arg_16_0:UpdateShopList(var_16_0)
end

function var_0_0.UpdateViewByParams(arg_17_0)
	arg_17_0:GetTreeDataByParams()

	if next(arg_17_0.groupIndexes) == nil then
		return
	end

	local var_17_0 = arg_17_0.params_.goodId

	if var_17_0 and ShopTools.IsGoodCanBuy(arg_17_0.curShopId_, var_17_0) then
		arg_17_0.timer_ = FrameTimer.New(function()
			arg_17_0.params_.goodId = nil

			local var_18_0 = getShopCfg(var_17_0)
			local var_18_1 = {
				id = var_17_0,
				shopId = var_18_0.shop_id,
				buyTime = ShopData.GetShop(var_18_0.shop_id)[var_17_0] ~= nil and ShopData.GetShop(var_18_0.shop_id)[var_17_0].buy_times or 0
			}

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = arg_17_0.curShopId_,
				goodInfo = var_18_1
			})

			arg_17_0.timer_ = nil
		end, 1, 1)

		arg_17_0.timer_:Start()
	end
end

function var_0_0.GetTreeDataByParams(arg_19_0)
	local var_19_0 = {}

	if arg_19_0.params_.showShops then
		var_19_0 = arg_19_0.params_.showShops
	else
		local var_19_1 = ShopListCfg.get_id_list_by_system[1]

		for iter_19_0, iter_19_1 in ipairs(var_19_1) do
			if ShopListCfg[iter_19_1].show_in_shop == 1 then
				table.insert(var_19_0, iter_19_1)
			end
		end
	end

	local var_19_2 = {}

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		if ShopTools.IsShopOpen(iter_19_3) then
			table.insert(var_19_2, iter_19_3)
		end
	end

	arg_19_0.groups = {}
	arg_19_0.groupIndexes = {}

	for iter_19_4, iter_19_5 in ipairs(var_19_2) do
		local var_19_3 = ShopListCfg[iter_19_5]

		if not arg_19_0.groups[var_19_3.display_group] then
			arg_19_0.groups[var_19_3.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(arg_19_0.groupIndexes, var_19_3.display_group)
		end

		arg_19_0.groups[var_19_3.display_group][var_19_3.display_index] = var_19_3

		table.insert(arg_19_0.groups[var_19_3.display_group].itemIndexes_, var_19_3.display_index)
	end

	for iter_19_6, iter_19_7 in pairs(arg_19_0.groups) do
		table.sort(iter_19_7.itemIndexes_, function(arg_20_0, arg_20_1)
			return arg_20_0 < arg_20_1
		end)
	end

	table.sort(arg_19_0.groupIndexes, function(arg_21_0, arg_21_1)
		return arg_21_0 < arg_21_1
	end)
end

function var_0_0.InitShopByParams(arg_22_0)
	local var_22_0 = arg_22_0.params_.goodId
	local var_22_1 = arg_22_0.params_.shopId

	if var_22_0 then
		local var_22_2 = getShopCfg(var_22_0)

		arg_22_0.curShopId_ = ShopListCfg[var_22_2.shop_id].id
	else
		arg_22_0.curShopId_ = tonumber(var_22_1 or 2)
	end

	arg_22_0.currentGroupIndex_ = ShopListCfg[arg_22_0.curShopId_].display_group
end

function var_0_0.UpdateBarByShopId(arg_23_0, arg_23_1)
	local var_23_0 = {}

	table.insert(var_23_0, BACK_BAR)

	if arg_23_0.params_.hideHomeBtn ~= 1 then
		table.insert(var_23_0, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end

	table.insert(var_23_0, NAVI_BAR)

	local var_23_1 = {}
	local var_23_2 = ShopListCfg[arg_23_1]

	for iter_23_0 = 1, #var_23_2.cost_id do
		local var_23_3

		if CurrencyIdMapCfg[var_23_2.cost_id[iter_23_0]] then
			var_23_3 = CurrencyIdMapCfg[var_23_2.cost_id[iter_23_0]].item_id
		else
			var_23_3 = var_23_2.cost_id[iter_23_0]
		end

		if var_23_3 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_23_3 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_23_0, var_23_3)
		table.insert(var_23_1, var_23_3)
	end

	manager.windowBar:SwitchBar(var_23_0)

	for iter_23_1 = 1, #var_23_1 do
		manager.windowBar:SetBarCanAdd(var_23_1[iter_23_1], ShopConst.ADD_CURRENCY[var_23_1[iter_23_1]] == true)
		manager.windowBar:SetBarCanClick(var_23_1[iter_23_1], true)
	end

	manager.windowBar:RegistHomeCallBack(function()
		gameContext:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function var_0_0.UpdateShopList(arg_27_0, arg_27_1)
	arg_27_0.curShopId_ = arg_27_1

	local var_27_0 = ShopListCfg[arg_27_1]

	arg_27_0.shopDataList = ShopTools.FilterShopDataList(arg_27_0.curShopId_, var_27_0.chain_last_visible == 1)

	if arg_27_0.needKeepPos1 then
		arg_27_0.pos = arg_27_0.list:GetScrolledPosition()
	else
		arg_27_0.pos = nil
	end

	arg_27_0.list:StartScrollWithoutAnimator(#arg_27_0.shopDataList, arg_27_0.pos)

	arg_27_0.needKeepPos1 = nil

	arg_27_0:UpdateBarByShopId(arg_27_0.curShopId_)
	arg_27_0:UpdateTimer()
end

function var_0_0.UpdateTimer(arg_28_0)
	local var_28_0, var_28_1 = ShopTools.IsShopOpen(arg_28_0.curShopId_)
	local var_28_2 = ShopListCfg[arg_28_0.curShopId_]

	arg_28_0.remainTimeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_28_2.activity_id).stopTime))
end

function var_0_0.SetTimer(arg_29_0)
	if not ShopConst.NEED_HIDE_TIME[arg_29_0.curShopId_] then
		SetActive(arg_29_0.timebgGo_, true)
		arg_29_0:StopTimer()
		arg_29_0:UpdateTimer()

		arg_29_0.refreshTimer_ = Timer.New(function()
			arg_29_0:UpdateTimer()
		end, 1, leftTime, 1)

		arg_29_0.refreshTimer_:Start()
	else
		SetActive(arg_29_0.timebgGo_, false)
	end
end

function var_0_0.OnExit(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.list:GetItemList()) do
		iter_31_1:OnExit()
	end

	manager.windowBar:HideBar()

	arg_31_0.params_.hideHomeBtn = nil

	arg_31_0:StopTimer()
	arg_31_0:RemoveAllEventListener()
end

function var_0_0.StopTimer(arg_32_0)
	if arg_32_0.refreshTimer_ then
		arg_32_0.refreshTimer_:Stop()

		arg_32_0.refreshTimer_ = nil
	end
end

function var_0_0.Dispose(arg_33_0)
	if arg_33_0.list then
		arg_33_0.list:Dispose()

		arg_33_0.list = nil
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.titleTogList) do
		iter_33_1:Dispose()
	end

	arg_33_0:RemoveAllListeners()

	arg_33_0.curShopId_ = nil

	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
