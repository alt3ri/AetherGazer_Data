local var_0_0 = class("RechargeMainView", ReduxView)
local var_0_1 = 2
local var_0_2 = {
	[ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS] = true,
	[ShopConst.SHOP_ID.SKIN_TARGET] = true
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeSystemUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.prefabList_ = ShopConst.prefabList
	arg_3_0.ClassList_ = {
		[ShopConst.SHOP_ID.LIMIT_SUPPLY] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.DAILY_SUPPLY] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.NEWBIE_SHOP] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.DRAW_SHOP] = RechargeVoucherPageView,
		[ShopConst.SHOP_ID.SKIN_SHOP] = RechargeSkinDlcPageView,
		[ShopConst.SHOP_ID.DIRECT_SHOP] = RechargeSkinPageView,
		[ShopConst.SHOP_ID.REPURCHASE_SHOP] = RechargeSkinPageView,
		[ShopConst.SHOP_ID.SKIN_TARGET] = RechargeGiftPageView,
		[ShopConst.SHOP_ID.CONSTANT_OBSERVATIONS] = RechargeMonthCardPageView,
		[ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS] = RechargeRechargePageView,
		[ShopConst.SHOP_ID.SIX_SHOP] = RechargeFirstRechargePageView,
		[ShopConst.SHOP_ID.EIGHT_SHOP] = RechargeFirstRechargePageView,
		[ShopConst.SHOP_ID.OBSERVATION_SHOP] = RechargeFirstMonthlyCardPageView,
		[ShopConst.SHOP_ID.CONTRACT_BENEFITS] = RechargeFirstBpPageView
	}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.pages_ = {}
	arg_4_0.tree_ = LuaTree.New(arg_4_0.treeGo_)
	arg_4_0.titleList = {
		RechargeTitleItem.New(arg_4_0.tag01_),
		RechargeTitleItem.New(arg_4_0.tag02_),
		RechargeTitleItem.New(arg_4_0.tag03_),
		(RechargeTitleItem.New(arg_4_0.tag04_))
	}
	arg_4_0.redBindingGroupIndex_ = 0
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cumulativeBtn_, nil, function()
		JumpTools.OpenPageByJump("/rechargeTotalRecharge")
	end)
end

function var_0_0.OnGroupSelect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0.groupInfo = arg_7_0.groups_[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.titleList) do
		if iter_7_0 <= #arg_7_0.groupInfo.itemIndexes_ then
			local var_7_0 = arg_7_0.groupInfo[iter_7_0].id

			SetActive(iter_7_1.gameObject_, true)
			iter_7_1:SetData(arg_7_0.groupInfo[iter_7_0], iter_7_0, handler(arg_7_0, arg_7_0.ClickTitle), var_7_0)
			SetActive(arg_7_0["newGo" .. iter_7_0 .. "_"], arg_7_0:CheckShopRedPoint(var_7_0))
			SetActive(arg_7_0["redGo" .. iter_7_0 .. "_"], arg_7_0:SpecialShop(var_7_0))
		else
			SetActive(iter_7_1.gameObject_, false)
		end
	end

	for iter_7_2 = 1, 3 do
		SetActive(arg_7_0["line" .. iter_7_2 .. "Go_"], iter_7_2 < #arg_7_0.groupInfo.itemIndexes_)
	end

	arg_7_0.params_.page = arg_7_1

	if arg_7_0.currentGroupIndex_ == arg_7_1 then
		arg_7_0:ClickTitle(arg_7_0.itemToSelect_ or arg_7_0.currentItemIndex_)
	else
		arg_7_0:ClickTitle(arg_7_0.itemToSelect_ or 1)
	end

	arg_7_0.itemToSelect_ = nil
	arg_7_0.currentGroupIndex_ = arg_7_1
end

function var_0_0.ClickTitle(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.groupInfo[arg_8_1].id

	OperationRecorder.RecordButtonTouch("shop_recharge_gifts" .. arg_8_0.params_.page .. "_type" .. arg_8_1)

	if ShopConst.PC_LOCK_SHOP[var_8_0] and ShopTools.IsPC() then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	arg_8_0.currentItemIndex_ = arg_8_1
	arg_8_0.params_.childShopIndex = arg_8_1

	arg_8_0:SwitchToShop(var_8_0)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.titleList) do
		iter_8_1.controller:SetSelectedState(iter_8_0 == arg_8_1 and "false" or "true")
	end

	if ShopData.GetRedPointData()[var_8_0] then
		ShopAction.RemoveShopRedPoint(var_8_0)
		SetActive(arg_8_0["newGo" .. arg_8_1 .. "_"], false)
		SetActive(arg_8_0["redGo" .. arg_8_1 .. "_"], arg_8_0:SpecialShop(var_8_0))
	end

	if var_8_0 == ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS then
		RedPointAction.HandleRedPoint(RED_POINT_ID.RECHARGE)
		manager.redPoint:setTip(RED_POINT_ID.RECHARGE, 0)
		SetActive(arg_8_0.redGo2_, false)
	end
end

function var_0_0.UpdateBar(arg_9_0)
	if arg_9_0.shopListId_ == ShopConst.SHOP_ID.SKIN_SHOP or arg_9_0.shopListId_ == ShopConst.SHOP_ID.SKIN_TARGET then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, var_0_2[arg_9_0.shopListId_] ~= true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, var_0_2[arg_9_0.shopListId_] ~= true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), var_0_2[arg_9_0.shopListId_] ~= true)
	end
end

function var_0_0.RefreshTree(arg_10_0)
	local var_10_0 = arg_10_0.tree_

	var_10_0:SetSelectedHandler(nil, nil)

	local var_10_1 = arg_10_0:GetTreeDataByParams()

	var_10_0:SetData(var_10_1)
	var_10_0:SetSelectedHandler(handler(arg_10_0, arg_10_0.OnGroupSelect))

	arg_10_0.treeData_ = var_10_1

	arg_10_0:BindRedPoint()
end

function var_0_0.SwitchToShop(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.shopListId_ then
		return
	end

	if arg_11_0.shopListId_ then
		local var_11_0 = arg_11_0.pages_[arg_11_0.shopListId_]

		if var_11_0 then
			var_11_0:Hide()
		end
	end

	arg_11_0.shopListId_ = arg_11_1
	arg_11_0.params_.shopListId = arg_11_1

	if not arg_11_0.pages_[arg_11_1] then
		local var_11_1 = Object.Instantiate(Asset.Load(arg_11_0.prefabList_[arg_11_1]), arg_11_0.container_)

		arg_11_0.pages_[arg_11_1] = arg_11_0.ClassList_[arg_11_1].New(var_11_1, {
			ShopConst.SIX_EIGHT[arg_11_1]
		}, arg_11_1)

		arg_11_0:CheckPageEnter(arg_11_1)
	else
		arg_11_0.pages_[arg_11_1]:Show()
	end

	if arg_11_0.pages_[arg_11_1].SwitchPage then
		arg_11_0.pages_[arg_11_1]:SwitchPage(arg_11_1)
	end

	arg_11_0:UpdateBar()
end

function var_0_0.SwitchPageByParams(arg_12_0)
	arg_12_0.currentGroupIndex_, arg_12_0.currentItemIndex_ = 1, 1

	local var_12_0 = 1

	if arg_12_0.params_.page then
		local var_12_1 = arg_12_0.params_.page

		arg_12_0.currentGroupIndex_ = var_12_1

		local var_12_2 = arg_12_0.groups_[var_12_1]
		local var_12_3 = arg_12_0.params_.shopId_ or arg_12_0.params_.shopListId

		for iter_12_0, iter_12_1 in ipairs(var_12_2.itemIndexes_) do
			local var_12_4 = var_12_2[iter_12_1]

			if var_12_3 and var_12_3 == var_12_4.id then
				arg_12_0.itemToSelect_ = iter_12_0

				break
			end
		end

		if arg_12_0.itemToSelect_ == nil and arg_12_0.params_.childShopIndex then
			arg_12_0.itemToSelect_ = arg_12_0.params_.childShopIndex
		end

		arg_12_0.tree_:SelectGroup(arg_12_0.currentGroupIndex_)

		if var_12_3 and arg_12_0.params_.goodId_ then
			local var_12_5 = arg_12_0.params_.goodId_

			if ShopTools.IsGoodCanBuyInShop(var_12_3, var_12_5) and ShopTools.CheckSoldOut(var_12_5) == false then
				if ShopTools.CheckGiftSkinOwn(var_12_5) then
					ShowTips("ALREADY_GET")
				elseif ShopTools.IsPC() then
					ShowTips("PC_SHOP_TIPS2")
				else
					JumpTools.OpenPageByJump("rechargeGiftPopLink", {
						goodId = var_12_5,
						shopId = var_12_3
					})
				end
			else
				ShowTips("SELL_OUT")
			end

			arg_12_0.params_.goodId_ = nil
		end

		arg_12_0.params_.shopId_ = nil
	end
end

function var_0_0.CheckPageEnter(arg_13_0, arg_13_1)
	if not arg_13_0.enteredPage_[arg_13_1] then
		arg_13_0.pages_[arg_13_1]:OnEnter()

		arg_13_0.enteredPage_[arg_13_1] = true
	end
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:UpdateBar()

	if arg_14_0.currentGroupIndex_ ~= arg_14_0.params_.page or arg_14_0.currentItemIndex_ ~= arg_14_0.params_.childShopIndex then
		arg_14_0:SwitchPageByParams()
	end
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.enteredPage_ = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.pages_) do
		arg_15_0:CheckPageEnter(iter_15_0)
	end

	arg_15_0:RefreshTree()
	arg_15_0:SwitchPageByParams()
	arg_15_0:RegistEventListener(SHOP_BUY_SUCCESS, function(arg_16_0, arg_16_1)
		for iter_16_0, iter_16_1 in pairs(arg_15_0.pages_) do
			if iter_16_1 ~= nil and iter_16_1.OnBuySuccess then
				iter_16_1:OnBuySuccess(arg_16_0, arg_16_1)
			end
		end
	end)

	if arg_15_0.pages_[arg_15_0.shopListId_] and arg_15_0.pages_[arg_15_0.shopListId_].RefreshList then
		arg_15_0.pages_[arg_15_0.shopListId_]:RefreshList()
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:RemoveAllEventListener()

	for iter_17_0, iter_17_1 in pairs(arg_17_0.pages_) do
		if iter_17_1 ~= nil then
			iter_17_1:OnExit()
		end
	end

	arg_17_0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.BindRedPoint(arg_18_0)
	manager.redPoint:bindUIandKey(arg_18_0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.groups_) do
		local var_18_0 = arg_18_0.tree_:GetGroupRedPointContainerById(iter_18_0)

		if var_18_0 then
			SetActive(var_18_0, true)

			local var_18_1 = false
			local var_18_2 = false
			local var_18_3 = var_18_0.transform:Find("notice_img/Default")
			local var_18_4 = var_18_0.transform:Find("notice_img/NewRed")

			for iter_18_2, iter_18_3 in pairs(iter_18_1) do
				if arg_18_0:CheckShopRedPoint(iter_18_3.id) then
					var_18_1 = true
				end

				if arg_18_0:SpecialShop(iter_18_3.id) then
					var_18_2 = true
				end
			end

			SetActive(var_18_4, var_18_1)
			SetActive(var_18_3, var_18_2)
		end
	end

	arg_18_0.updateTimer_ = Timer.New(function()
		for iter_19_0, iter_19_1 in ipairs(arg_18_0.titleList) do
			if iter_19_0 <= #arg_18_0.groupInfo.itemIndexes_ then
				local var_19_0 = arg_18_0.groupInfo[arg_18_0.groupInfo.itemIndexes_[iter_19_0]].id

				SetActive(arg_18_0["newGo" .. iter_19_0 .. "_"], arg_18_0:CheckShopRedPoint(var_19_0))
				SetActive(arg_18_0["redGo" .. iter_19_0 .. "_"], arg_18_0:SpecialShop(var_19_0))
			end
		end

		for iter_19_2, iter_19_3 in pairs(arg_18_0.groups_) do
			local var_19_1 = arg_18_0.tree_:GetGroupRedPointContainerById(iter_19_2)

			if var_19_1 then
				SetActive(var_19_1, true)

				local var_19_2 = false
				local var_19_3 = false
				local var_19_4 = var_19_1.transform:Find("notice_img/Default")
				local var_19_5 = var_19_1.transform:Find("notice_img/NewRed")

				for iter_19_4, iter_19_5 in pairs(iter_19_3) do
					if arg_18_0:CheckShopRedPoint(iter_19_5.id) then
						var_19_2 = true
					end

					if arg_18_0:SpecialShop(iter_19_5.id) then
						var_19_3 = true
					end
				end

				SetActive(var_19_5, var_19_2)
				SetActive(var_19_4, var_19_3)
			end
		end
	end, 1, -1, 1)

	arg_18_0.updateTimer_:Start()
end

function var_0_0.UnbindRedPoint(arg_20_0)
	manager.redPoint:unbindUIandKey(arg_20_0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS, {
		x = 0,
		y = 0
	})

	if arg_20_0.updateTimer_ then
		arg_20_0.updateTimer_:Stop()

		arg_20_0.updateTimer_ = nil
	end
end

function var_0_0.OnShopBuyResult(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	if arg_21_0.pages_[var_0_1] then
		arg_21_0.pages_[var_0_1]:OnShopBuyResult(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	end
end

function var_0_0.SpecialShop(arg_22_0, arg_22_1)
	if ShopConst.PC_LOCK_SHOP[arg_22_1] == true and ShopTools.IsPC() then
		return false
	end

	if ShopConst.SHOP_ID_TO_RED_CONST[arg_22_1] then
		return manager.redPoint:getTipValue(ShopConst.SHOP_ID_TO_RED_CONST[arg_22_1]) >= 1
	end

	return false
end

function var_0_0.CheckShopRedPoint(arg_23_0, arg_23_1)
	return ShopData.GetRedPointData()[arg_23_1] == true
end

function var_0_0.OnTryToUseItem(arg_24_0, arg_24_1, arg_24_2)
	if isSuccess(arg_24_1.result) then
		local var_24_0 = arg_24_2.use_item_list[1].item_id
		local var_24_1 = ItemCfg[var_24_0].param[1]

		getReward({
			{
				num = 1,
				id = var_24_1
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})

		local var_24_2 = SkinCfg[var_24_1].hero

		HeroAction.UpdateSkinCouponRedPoint(var_24_2)
		HeroAction.SkinAdd(var_24_1)
	else
		ShowTips(arg_24_1.result)
	end
end

function var_0_0.HaveActivityGift(arg_25_0)
	local var_25_0 = getShopIDListByShopID(ShopConst.SHOP_ID.LIMIT_SUPPLY)

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if not ShopData.IsGoodOutOfDate(iter_25_1, ShopConst.SHOP_ID.LIMIT_SUPPLY) then
			return true
		end
	end

	return false
end

function var_0_0.HaveNewbieGift(arg_26_0)
	local var_26_0 = ShopConst.SHOP_ID.NEWBIE_SHOP
	local var_26_1 = ShopData.GetShop(var_26_0)

	for iter_26_0, iter_26_1 in pairs(var_26_1.shopItemIDs) do
		if ShopTools.IsGoodCanDisplay(var_26_0, iter_26_1) and not ShopData.IsSoldout(var_26_0, iter_26_1) then
			return true
		end
	end

	return false
end

function var_0_0.OnMainHomeViewTop(arg_27_0)
	arg_27_0.params_.childShopIndex = 1
	arg_27_0.params_.page = 1
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.firstRechargeGroupGoList_ = nil

	if arg_28_0.tree_ then
		arg_28_0.tree_:Dispose()

		arg_28_0.tree_ = nil
	end

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.titleList) do
		iter_28_1:Dispose()
	end

	if arg_28_0.pages_ then
		for iter_28_2, iter_28_3 in pairs(arg_28_0.pages_) do
			iter_28_3:Dispose()
		end

		arg_28_0.pages_ = nil
	end

	var_0_0.super.Dispose(arg_28_0)
end

function var_0_0.RefreshFirstRechargeGroup(arg_29_0)
	arg_29_0.firstRechargeGroupGoList_ = {}
	arg_29_0.firstRechargeGroupGoList_[1] = arg_29_0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.SIX_SHOP)
	arg_29_0.firstRechargeGroupGoList_[2] = arg_29_0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.EIGHT_SHOP)
	arg_29_0.firstRechargeGroupGoList_[3] = arg_29_0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.OBSERVATION_SHOP)

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.firstRechargeGroupGoList_) do
		SetActive(iter_29_1, ActivityNewbieTools.GetRechargeIsOpen(iter_29_0))
	end

	local var_29_0 = ActivityNewbieTools.GetFirstRechargeStatus()

	if var_29_0 and var_29_0.firstGearStatus == 2 then
		arg_29_0.tree_:GetData().groupDatas[5].defaultIndex = 1
	end
end

function var_0_0.GetTreeDataByParams(arg_30_0)
	local var_30_0 = {}

	if arg_30_0.params_.showShops then
		var_30_0 = arg_30_0.params_.showShops
	else
		local var_30_1 = ShopListCfg.get_id_list_by_system[2]

		for iter_30_0, iter_30_1 in ipairs(var_30_1) do
			if ShopListCfg[iter_30_1].show_in_shop == 1 then
				table.insert(var_30_0, iter_30_1)
			end
		end
	end

	local var_30_2 = {}

	for iter_30_2, iter_30_3 in ipairs(var_30_0) do
		table.insert(var_30_2, iter_30_3)
	end

	arg_30_0.groups_ = {}
	arg_30_0.groupIndexes_ = {}

	local var_30_3 = UITreeData.New()

	for iter_30_4, iter_30_5 in ipairs(var_30_2) do
		local var_30_4 = ShopListCfg[iter_30_5]

		if not arg_30_0.groups_[var_30_4.display_group] then
			arg_30_0.groups_[var_30_4.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(arg_30_0.groupIndexes_, var_30_4.display_group)
		end

		arg_30_0.groups_[var_30_4.display_group][var_30_4.display_index] = var_30_4

		table.insert(arg_30_0.groups_[var_30_4.display_group].itemIndexes_, var_30_4.display_index)
	end

	for iter_30_6, iter_30_7 in pairs(arg_30_0.groups_) do
		table.sort(iter_30_7.itemIndexes_, function(arg_31_0, arg_31_1)
			return arg_31_0 < arg_31_1
		end)
	end

	table.sort(arg_30_0.groupIndexes_, function(arg_32_0, arg_32_1)
		return arg_32_0 < arg_32_1
	end)

	for iter_30_8, iter_30_9 in pairs(arg_30_0.groupIndexes_) do
		local var_30_5 = UITreeGroupData.New()

		var_30_5.text = GetI18NText(ShopListCfg.get_id_list_by_system_and_group[2][iter_30_9][1].group_name)
		var_30_5.controllerStateValue = tostring(iter_30_9)
		var_30_5.id = iter_30_9

		var_30_3.groupDatas:Add(var_30_5)
	end

	return var_30_3
end

return var_0_0
