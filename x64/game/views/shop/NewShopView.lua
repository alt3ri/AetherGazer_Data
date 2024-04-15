local var_0_0 = class("NewShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Shop/ShopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.updateDirty_ = true

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.GetTreeDataByParams(arg_4_0)
	local var_4_0 = {}

	if arg_4_0.params_.showShops then
		var_4_0 = arg_4_0.params_.showShops
	else
		local var_4_1 = ShopListCfg.get_id_list_by_system[1]

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if ShopListCfg[iter_4_1].show_in_shop == 1 then
				table.insert(var_4_0, iter_4_1)
			end
		end
	end

	local var_4_2 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		if ShopTools.IsShopOpen(iter_4_3) then
			table.insert(var_4_2, iter_4_3)
		end
	end

	arg_4_0.groups = {}
	arg_4_0.groupIndexes = {}

	local var_4_3 = UITreeData.New()

	for iter_4_4, iter_4_5 in ipairs(var_4_2) do
		local var_4_4 = ShopListCfg[iter_4_5]

		if not arg_4_0.groups[var_4_4.display_group] then
			arg_4_0.groups[var_4_4.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(arg_4_0.groupIndexes, var_4_4.display_group)
		end

		arg_4_0.groups[var_4_4.display_group][var_4_4.display_index] = var_4_4

		table.insert(arg_4_0.groups[var_4_4.display_group].itemIndexes_, var_4_4.display_index)
	end

	for iter_4_6, iter_4_7 in pairs(arg_4_0.groups) do
		table.sort(iter_4_7.itemIndexes_, function(arg_5_0, arg_5_1)
			return arg_5_0 < arg_5_1
		end)
	end

	table.sort(arg_4_0.groupIndexes, function(arg_6_0, arg_6_1)
		return arg_6_0 < arg_6_1
	end)

	for iter_4_8, iter_4_9 in pairs(arg_4_0.groupIndexes) do
		local var_4_5 = UITreeGroupData.New()
		local var_4_6 = ShopListCfg.get_id_list_by_system_and_group[1][iter_4_9][1].group_name

		var_4_5.text = GetI18NText(var_4_6)
		var_4_5.controllerStateValue = tostring(iter_4_9)
		var_4_5.id = iter_4_9

		var_4_3.groupDatas:Add(var_4_5)
	end

	return var_4_3
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.shopController = arg_7_0.controller_:GetController("shop")
	arg_7_0.stateController = arg_7_0.controller_:GetController("state")
	arg_7_0.colorController = arg_7_0.sortController_:GetController("color")
	arg_7_0.tree_ = LuaTree.New(arg_7_0.treeGo_)

	arg_7_0.tree_:SetSelectedHandler(handler(arg_7_0, arg_7_0.OnGroupSelect))

	arg_7_0.list1 = LuaList.New(handler(arg_7_0, arg_7_0.SetItem1), arg_7_0.list1Go_, ExchangeItemView)
	arg_7_0.equipList = LuaList.New(handler(arg_7_0, arg_7_0.SetEquipItem), arg_7_0.equipListGo_, EquipSiftShopItem)
	arg_7_0.bindingHeroPeiceRed_ = false
	arg_7_0.titleTogList = {
		RechargeTitleItem.New(arg_7_0.tag01_),
		RechargeTitleItem.New(arg_7_0.tag02_),
		RechargeTitleItem.New(arg_7_0.tag03_),
		RechargeTitleItem.New(arg_7_0.tag04_),
		(RechargeTitleItem.New(arg_7_0.tag05_))
	}
	arg_7_0.selectSuitTable = {}
	arg_7_0.selectSiftList = {}

	local var_7_0 = arg_7_0.diaViewPortTrs_.rect.height
	local var_7_1 = arg_7_0.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_7_0.loopScrollView_ = LoopScrollView.New(arg_7_0, arg_7_0.diaScrollEx_, arg_7_0.diaGridTrs_, arg_7_0.diaViewPortTrs_, var_7_0, var_7_1, true)
	arg_7_0.filterBottomView_ = CommonFilterBottom.New(arg_7_0.fillListGo_)

	arg_7_0.filterBottomView_:RegisteClearBtnListener(handler(arg_7_0, arg_7_0.ClearFilter))

	arg_7_0.itemListPool = {}
	arg_7_0.itemEquipPool = {}
	arg_7_0.itemEquipBuyPool = {}
end

function var_0_0.SetItem1(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:SetData(arg_8_0.shopDataList[arg_8_1])
end

function var_0_0.SetEquipItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:SetData(arg_9_0.suitList[arg_9_1], arg_9_0.selectSuitTable, handler(arg_9_0, arg_9_0.EquipCallback), arg_9_0.isClickClean)
end

function var_0_0.ClearFilter(arg_10_0)
	arg_10_0.isClickClean = true
	arg_10_0.selectSuitTable = {}
	arg_10_0.selectSiftList = {}

	arg_10_0.equipList:StartScrollWithoutAnimator(#arg_10_0.suitList, arg_10_0.equipList:GetScrolledPosition())
	arg_10_0.filterBottomView_:Refresh({})
end

function var_0_0.EquipCallback(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.isClickClean = nil

	if arg_11_0.selectSuitTable[arg_11_1] then
		arg_11_0.selectSuitTable[arg_11_1] = nil

		arg_11_2:SetSelectedState("false")

		local var_11_0

		for iter_11_0, iter_11_1 in ipairs(arg_11_0.selectSiftList) do
			if iter_11_1.id == arg_11_1 then
				var_11_0 = iter_11_0
			end
		end

		table.remove(arg_11_0.selectSiftList, var_11_0)
	else
		arg_11_0.selectSuitTable[arg_11_1] = true

		table.insert(arg_11_0.selectSiftList, {
			type = 1,
			id = arg_11_1
		})
		arg_11_2:SetSelectedState("select")
	end

	arg_11_0:RefreshBottom()
end

function var_0_0.RefreshBottom(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = 1

	for iter_12_0 = 1, #arg_12_0.selectSiftList do
		table.insert(var_12_0, {
			name = GetI18NText(EquipSuitCfg[arg_12_0.selectSiftList[iter_12_0].id].name),
			id = var_12_1
		})

		var_12_1 = var_12_1 + 1
	end

	arg_12_0.filterBottomView_:Refresh(var_12_0)
end

function var_0_0.OnGroupSelect(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_0.groupIndexes[arg_13_1]

	arg_13_0.groupInfo = arg_13_0.groups[var_13_0]

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.titleTogList) do
		if iter_13_0 <= #arg_13_0.groupInfo.itemIndexes_ then
			SetActive(iter_13_1.gameObject_, #arg_13_0.groupInfo.itemIndexes_ ~= 1)

			local var_13_1 = arg_13_0.groupInfo[arg_13_0.groupInfo.itemIndexes_[iter_13_0]].id

			iter_13_1:SetData(arg_13_0.groupInfo[arg_13_0.groupInfo.itemIndexes_[iter_13_0]], iter_13_0, handler(arg_13_0, arg_13_0.ClickTitle), var_13_1)
			SetActive(arg_13_0["newGo" .. iter_13_0 .. "_"], arg_13_0:CheckShopRedPoint(var_13_1))
			SetActive(arg_13_0["redGo" .. iter_13_0 .. "_"], arg_13_0:SpecialShop(var_13_1))
		else
			SetActive(iter_13_1.gameObject_, false)
		end
	end

	for iter_13_2 = 1, 4 do
		SetActive(arg_13_0["line" .. iter_13_2 .. "Go_"], iter_13_2 < #arg_13_0.groupInfo.itemIndexes_)
	end

	if #arg_13_0.groupInfo.itemIndexes_ == 1 then
		if #ShopListCfg[arg_13_0.groupInfo[arg_13_0.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
			arg_13_0.stateController:SetSelectedState("state2")
		else
			arg_13_0.stateController:SetSelectedState("state1")
		end
	else
		arg_13_0.stateController:SetSelectedState("normal")
	end

	if arg_13_0.currentGroupIndex_ == arg_13_1 then
		arg_13_0:ClickTitle(arg_13_0.itemToSelect_ or arg_13_0.currentItemIndex_)
	else
		arg_13_0:ClickTitle(arg_13_0.itemToSelect_ or 1)
	end

	arg_13_0.currentGroupIndex_ = arg_13_1
	arg_13_0.itemToSelect_ = nil
end

function var_0_0.ClickTitle(arg_14_0, arg_14_1)
	arg_14_0.currentItemIndex_ = arg_14_1

	local var_14_0 = arg_14_0.groupInfo[arg_14_0.groupInfo.itemIndexes_[arg_14_1]].id

	if not ShopTools.CheckShopIsUnLock(var_14_0, arg_14_0.curShopId_) then
		local var_14_1 = ShopTools.GetShopIsUnLockDesc(var_14_0, arg_14_0.curShopId_)

		if not string.isNullOrEmpty(var_14_1) then
			ShowTips(var_14_1)
		end
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.titleTogList) do
		iter_14_1.controller:SetSelectedState(iter_14_0 == arg_14_1 and "false" or "true")
	end

	if arg_14_0.curShopId_ ~= var_14_0 then
		arg_14_0.selectSuitTable = {}
		arg_14_0.selectSiftList = {}
	else
		return
	end

	TimeTools.StartAfterSeconds(0.1, function()
		arg_14_0.loopScrollView_:SetContentHeight(arg_14_0.diaViewPortTrs_.rect.height)
	end, {})

	arg_14_0.equipData = nil
	arg_14_0.clickIndex = nil
	arg_14_0.isClickClean = nil
	arg_14_0.copyList1 = nil
	arg_14_0.copyList2 = nil

	if ShopData.GetRedPointData()[var_14_0] then
		ShopAction.RemoveShopRedPoint(var_14_0)
		SetActive(arg_14_0["newGo" .. arg_14_1 .. "_"], false)
	end

	arg_14_0:UpdateBarByShopId(var_14_0)

	arg_14_0.params_.shopId = var_14_0
	arg_14_0.inSelect = false

	arg_14_0.colorController:SetSelectedState("normal")
	arg_14_0:UpdateShopList(var_14_0)
end

function var_0_0.UpdateBottomView(arg_16_0)
	if arg_16_0.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
		arg_16_0.shopController:SetSelectedState("state0")
		arg_16_0:SetTimer()

		if arg_16_0:GetRefreshCount() ~= ShopListCfg[arg_16_0.curShopId_].refresh_num_limit then
			arg_16_0.refreshTimesTxt_.text = GetTips("CLUB_REFRES_TEXT") .. string.format("(%d/%d)", ShopListCfg[arg_16_0.curShopId_].refresh_num_limit - arg_16_0:GetRefreshCount(), ShopListCfg[arg_16_0.curShopId_].refresh_num_limit)
		else
			arg_16_0.refreshTimesTxt_.text = GetTips("CLUB_REFRES_TEXT") .. string.format("(<color=#FF000B>%d</color>/%d)", ShopListCfg[arg_16_0.curShopId_].refresh_num_limit - arg_16_0:GetRefreshCount(), ShopListCfg[arg_16_0.curShopId_].refresh_num_limit)
		end

		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id) < arg_16_0:GetDiamondCount() then
			arg_16_0.refreshCostTxt_.text = "<color=#FF000B>" .. arg_16_0:GetDiamondCount() .. "</color>"
		else
			arg_16_0.refreshCostTxt_.text = arg_16_0:GetDiamondCount()
		end

		SetActive(arg_16_0.costGo_, arg_16_0:GetRefreshCount() ~= ShopListCfg[arg_16_0.curShopId_].refresh_num_limit)
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		arg_16_0.shopController:SetSelectedState("state2")
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.COHOMOLOGY_TRACKS then
		arg_16_0.shopController:SetSelectedState("state3")
	elseif arg_16_0.curShopId_ == ShopConst.SHOP_ID.BLACK_AREA or arg_16_0.curShopId_ == ShopConst.SHOP_ID.EQUIP_DEVELOP then
		arg_16_0.shopController:SetSelectedState("state4")
	else
		arg_16_0.shopController:SetSelectedState("state1")
	end
end

function var_0_0.AddEventListeners(arg_17_0)
	arg_17_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_18_0)
		if arg_18_0 == 0 or arg_17_0.curShopId_ == arg_18_0 then
			arg_17_0:UpdateShopList(arg_17_0.curShopId_)
		end
	end)
	arg_17_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_19_0)
		arg_17_0.needKeepPos1 = true

		arg_17_0:OnRefreshAllShop(arg_19_0)
	end)
	arg_17_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_20_0, arg_20_1)
		if arg_17_0.curShopId_ ~= arg_20_0 then
			return
		end

		arg_17_0.needKeepPos1 = true

		arg_17_0:RefreshList()
	end)
	arg_17_0:RegistEventListener(CURRENCY_UPDATE, function(arg_21_0)
		local var_21_0 = getShopIDListByCurrency(arg_21_0)

		if var_21_0 ~= nil and #var_21_0 > 0 then
			arg_17_0.needKeepPos1 = true

			arg_17_0:UpdateShopList(arg_17_0.curShopId_, true)
		end
	end)
end

function var_0_0.AddUIListener(arg_22_0)
	arg_22_0:AddBtnListenerScale(arg_22_0.refreshBtn_, nil, function()
		if arg_22_0:GetRefreshCount() >= ShopListCfg[arg_22_0.curShopId_].refresh_num_limit then
			ShowTips("SHOP_REFRESH_LIMIT")

			return
		end

		if _G.SkipTip.SkipShopRefreshTip then
			ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, arg_22_0:GetDiamondCount())

			return
		end

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function()
				OperationRecorder.Record("shop", "okRefresh")
				ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, arg_22_0:GetDiamondCount())

				_G.SkipTip.SkipShopRefreshTip = arg_22_0.skipShopRefreshTip_
			end,
			ToggleCallback = function(arg_25_0)
				arg_22_0.skipShopRefreshTip_ = arg_25_0

				if arg_25_0 then
					OperationRecorder.Record("shop", "toggle")
				end
			end,
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), arg_22_0:GetDiamondCount())
		})
	end)
	arg_22_0:AddBtnListener(arg_22_0.heroPieceExchangeBtn_, nil, function()
		JumpTools.OpenPopUp("fragmentExchange", nil, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_22_0:AddBtnListener(arg_22_0.quashBtn_, nil, function()
		JumpTools.OpenPageByJump("moduleItemResolveView")
	end)
	arg_22_0:AddBtnListener(arg_22_0.siftBtn_, nil, function()
		SetActive(arg_22_0.siftGo_, true)

		if arg_22_0.isClickClean then
			arg_22_0.inSelect = false
			arg_22_0.selectSuitTable = {}
			arg_22_0.selectSiftList = {}
		else
			arg_22_0.inSelect = true
		end

		if arg_22_0.copyList1 then
			arg_22_0.selectSiftList = arg_22_0.copyList1
		end

		if arg_22_0.copyList2 then
			arg_22_0.selectSuitTable = arg_22_0.copyList2
		end

		arg_22_0.equipList:StartScroll(#arg_22_0.suitList)
		arg_22_0:RefreshBottom(true)
	end)
	arg_22_0:AddBtnListener(arg_22_0.siftSuitBtn_, nil, function()
		SetActive(arg_22_0.siftGo_, false)

		if arg_22_0.isClickClean then
			arg_22_0.inSelect = false
			arg_22_0.isClickClean = nil
		else
			arg_22_0.inSelect = true
		end

		arg_22_0.selectList = arg_22_0:GetSelectList()
		arg_22_0.clickIndex = nil
		arg_22_0.equipData = nil
		arg_22_0.clickItem = nil

		arg_22_0:RefreshList()

		arg_22_0.copyList1 = clone(arg_22_0.selectSiftList)
		arg_22_0.copyList2 = clone(arg_22_0.selectSuitTable)

		arg_22_0.colorController:SetSelectedState(#arg_22_0.selectSiftList == 0 and "normal" or "orange")
	end)
	arg_22_0:AddBtnListener(arg_22_0.maskBtn_, nil, function()
		SetActive(arg_22_0.siftGo_, false)

		arg_22_0.isClickClean = nil

		if arg_22_0.colorController:GetSelectedState() == "normal" then
			arg_22_0.selectSuitTable = {}
			arg_22_0.selectSiftList = {}
			arg_22_0.isClickClean = nil
		end
	end)
end

function var_0_0.BindRedPoints(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.groups) do
		local var_31_0 = arg_31_0.tree_:GetGroupRedPointContainerById(iter_31_0)

		if var_31_0 then
			SetActive(var_31_0, true)

			local var_31_1 = false
			local var_31_2 = false
			local var_31_3 = var_31_0.transform:Find("notice_img/Default")
			local var_31_4 = var_31_0.transform:Find("notice_img/NewRed")

			for iter_31_2, iter_31_3 in pairs(iter_31_1) do
				if arg_31_0:CheckShopRedPoint(iter_31_3.id) then
					var_31_1 = true
				end

				if arg_31_0:SpecialShop(iter_31_3.id) then
					var_31_2 = true
				end
			end

			SetActive(var_31_4, var_31_1)
			SetActive(var_31_3, var_31_2)
		end
	end

	manager.redPoint:bindUIandKey(arg_31_0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)

	arg_31_0.updateTimer_ = Timer.New(function()
		for iter_32_0, iter_32_1 in ipairs(arg_31_0.titleTogList) do
			if iter_32_0 <= #arg_31_0.groupInfo.itemIndexes_ then
				local var_32_0 = arg_31_0.groupInfo[arg_31_0.groupInfo.itemIndexes_[iter_32_0]].id

				SetActive(arg_31_0["newGo" .. iter_32_0 .. "_"], arg_31_0:CheckShopRedPoint(var_32_0))
				SetActive(arg_31_0["redGo" .. iter_32_0 .. "_"], arg_31_0:SpecialShop(var_32_0))
			end
		end

		for iter_32_2, iter_32_3 in pairs(arg_31_0.groups) do
			local var_32_1 = arg_31_0.tree_:GetGroupRedPointContainerById(iter_32_2)

			if var_32_1 then
				SetActive(var_32_1, true)

				local var_32_2 = false
				local var_32_3 = false
				local var_32_4 = var_32_1.transform:Find("notice_img/Default")
				local var_32_5 = var_32_1.transform:Find("notice_img/NewRed")

				for iter_32_4, iter_32_5 in pairs(iter_32_3) do
					if arg_31_0:CheckShopRedPoint(iter_32_5.id) then
						var_32_2 = true
					end

					if arg_31_0:SpecialShop(iter_32_5.id) then
						var_32_3 = true
					end
				end

				SetActive(var_32_5, var_32_2)
				SetActive(var_32_4, var_32_3)
			end
		end
	end, 1, -1, 1)

	arg_31_0.updateTimer_:Start()
end

function var_0_0.SpecialShop(arg_33_0, arg_33_1)
	if ShopConst.SHOP_ID_TO_RED_CONST[arg_33_1] then
		return manager.redPoint:getTipValue(ShopConst.SHOP_ID_TO_RED_CONST[arg_33_1]) == 1
	else
		return false
	end
end

function var_0_0.CheckShopRedPoint(arg_34_0, arg_34_1)
	return ShopData.GetRedPointData()[arg_34_1] == true
end

function var_0_0.UnBindRedPoints(arg_35_0)
	if arg_35_0.updateTimer_ then
		arg_35_0.updateTimer_:Stop()

		arg_35_0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_35_0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)
end

function var_0_0.OnRefreshOneShop(arg_36_0, arg_36_1)
	arg_36_0:RefreshList()
end

function var_0_0.UpdateShopList(arg_37_0, arg_37_1)
	arg_37_0.curShopId_ = arg_37_1

	local var_37_0 = ShopListCfg[arg_37_1]

	for iter_37_0, iter_37_1 in pairs(arg_37_0.list1:GetItemList()) do
		iter_37_1:CloseTimer()
	end

	for iter_37_2, iter_37_3 in ipairs(arg_37_0.itemListPool) do
		iter_37_3.itemView:OnExit()
	end

	for iter_37_4, iter_37_5 in ipairs(arg_37_0.itemEquipPool) do
		iter_37_5.itemView:OnExit()
	end

	for iter_37_6, iter_37_7 in ipairs(arg_37_0.itemEquipBuyPool) do
		iter_37_7.itemView:OnExit()
	end

	arg_37_0.list = arg_37_0.list1
	arg_37_0.RefreshList = arg_37_0.RefreshListType1

	if #var_37_0.shop_label >= 1 then
		arg_37_0.RefreshList = arg_37_0.RefreshListType2
	end

	arg_37_0:RefreshList()
	arg_37_0:UpdateBottomView()
	arg_37_0:UpdateTimer()
end

function var_0_0.RefreshListType1(arg_38_0)
	local var_38_0 = ShopListCfg[arg_38_0.curShopId_]

	SetActive(arg_38_0.list1Go_, true)
	SetActive(arg_38_0.proofGo_, false)

	arg_38_0.shopDataList = ShopTools.FilterShopDataList(arg_38_0.curShopId_, var_38_0.chain_last_visible == 1)
	arg_38_0.shopDataList = ShopTools.CommonSort(arg_38_0.shopDataList)

	if arg_38_0.needKeepPos1 then
		arg_38_0.pos = arg_38_0.list:GetScrolledPosition()
	else
		arg_38_0.pos = nil
	end

	arg_38_0.list:StartScrollWithoutAnimator(#arg_38_0.shopDataList, arg_38_0.pos)

	arg_38_0.needKeepPos1 = nil

	arg_38_0:UpdateBarByShopId(arg_38_0.curShopId_)
end

function var_0_0.RefreshListType2(arg_39_0)
	SetActive(arg_39_0.proofGo_, true)
	SetActive(arg_39_0.list1Go_, false)

	local var_39_0 = ShopListCfg[arg_39_0.curShopId_]

	if arg_39_0.isFist == nil then
		arg_39_0.isFist = true
	end

	arg_39_0.shopDataList = ShopTools.FilterShopDataList(arg_39_0.curShopId_, var_39_0.chain_last_visible == 1)
	arg_39_0.shopDataList = ShopTools.CommonSort(arg_39_0.shopDataList)
	arg_39_0.shopDataList, arg_39_0.titleList, arg_39_0.suitList = ShopTools.SplitDataByShopID(arg_39_0.shopDataList, arg_39_0.curShopId_)

	arg_39_0:UpdateBarByShopId(arg_39_0.curShopId_)

	local var_39_1 = arg_39_0.diaScrollEx_.verticalNormalizedPosition

	if arg_39_0.needKeepPos1 then
		arg_39_0.needKeepPos1 = false

		arg_39_0.loopScrollView_:RefreshScrollView(false)

		arg_39_0.diaScrollEx_.verticalNormalizedPosition = var_39_1

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_0.diaScrollEx_.transform)

		arg_39_0.diaScrollEx_.verticalNormalizedPosition = var_39_1
	else
		arg_39_0.loopScrollView_:NavigateIndex(1)

		if arg_39_0.isFist then
			arg_39_0.isFist = false

			TimeTools.StartAfterSeconds(0.1, function()
				arg_39_0.loopScrollView_:NavigateIndex(1)
			end, {})
		end
	end

	arg_39_0:UpdateBottomView()
end

function var_0_0.GetShowList(arg_41_0, arg_41_1)
	local var_41_0 = {
		{}
	}
	local var_41_1 = 0

	arg_41_0.indexList = {}

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_0.item1Trs_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_0.shopItemTrs_.transform)

	arg_41_0.lineCount = math.floor(arg_41_0.item1Trs_.rect.width / arg_41_0.shopItemTrs_.rect.width)

	for iter_41_0 = 1, #arg_41_1 do
		var_41_1 = var_41_1 + 1
		arg_41_0.indexList[iter_41_0] = var_41_1

		for iter_41_1, iter_41_2 in ipairs(arg_41_1[iter_41_0]) do
			if var_41_0[var_41_1] == nil then
				var_41_0[var_41_1] = {}
			end

			if #var_41_0[var_41_1] >= arg_41_0.lineCount then
				var_41_1 = var_41_1 + 1
			end

			if var_41_0[var_41_1] == nil then
				var_41_0[var_41_1] = {}
			end

			table.insert(var_41_0[var_41_1], iter_41_2)
		end
	end

	if arg_41_0.clickIndex and arg_41_0.equipData then
		table.insert(var_41_0, arg_41_0.clickIndex + 1, arg_41_0.equipData)
	end

	return var_41_0, var_41_1
end

function var_0_0.UpdateBarByShopId(arg_42_0, arg_42_1)
	local var_42_0 = {}

	table.insert(var_42_0, BACK_BAR)

	if arg_42_0.params_.hideHomeBtn ~= 1 then
		table.insert(var_42_0, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end

	table.insert(var_42_0, NAVI_BAR)

	local var_42_1 = {}
	local var_42_2 = ShopListCfg[arg_42_1]

	for iter_42_0 = 1, #var_42_2.cost_id do
		local var_42_3

		if CurrencyIdMapCfg[var_42_2.cost_id[iter_42_0]] then
			var_42_3 = CurrencyIdMapCfg[var_42_2.cost_id[iter_42_0]].item_id
		else
			var_42_3 = var_42_2.cost_id[iter_42_0]
		end

		if var_42_3 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_42_3 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_42_0, var_42_3)
		table.insert(var_42_1, var_42_3)
	end

	manager.windowBar:SwitchBar(var_42_0)

	for iter_42_1 = 1, #var_42_1 do
		manager.windowBar:SetBarCanAdd(var_42_1[iter_42_1], ShopConst.ADD_CURRENCY[var_42_1[iter_42_1]] == true)
		manager.windowBar:SetBarCanClick(var_42_1[iter_42_1], true)
	end

	manager.windowBar:RegistBackCallBack(function()
		JumpTools.Back()
	end)
end

function var_0_0.SelectTreeByShopId(arg_45_0, arg_45_1)
	if next(arg_45_0.groupIndexes) == nil then
		return
	end

	local var_45_0 = -1
	local var_45_1 = ShopListCfg[arg_45_1].display_group

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.groupIndexes) do
		if iter_45_1 == var_45_1 then
			var_45_0 = iter_45_0
		end
	end

	local var_45_2 = -1

	for iter_45_2, iter_45_3 in ipairs(arg_45_0.groups[var_45_1].itemIndexes_) do
		if arg_45_0.groups[var_45_1][iter_45_3].id == arg_45_1 then
			var_45_2 = iter_45_2

			break
		end
	end

	if var_45_2 > 0 then
		arg_45_0.itemToSelect_ = var_45_2
	end

	arg_45_0.tree_:SelectGroup(var_45_0)
end

function var_0_0.OnEnter(arg_46_0)
	arg_46_0:UpdateViewByParams()
	arg_46_0:InitShopByParams()
	arg_46_0:AddEventListeners()
	arg_46_0:BindRedPoints()
end

function var_0_0.InitShopByParams(arg_47_0)
	if not arg_47_0.updateDirty_ then
		return
	end

	local var_47_0 = arg_47_0.params_.goodId
	local var_47_1 = arg_47_0.params_.shopId

	if var_47_0 then
		local var_47_2 = getShopCfg(var_47_0)

		arg_47_0.curShopId_ = ShopListCfg[var_47_2.shop_id].id
	else
		arg_47_0.curShopId_ = tonumber(var_47_1 or 2)
	end

	arg_47_0.currentGroupIndex_ = ShopListCfg[arg_47_0.curShopId_].display_group
end

function var_0_0.UpdateViewByParams(arg_48_0)
	local var_48_0 = arg_48_0:GetTreeDataByParams()

	if next(arg_48_0.groupIndexes) == nil then
		return
	end

	arg_48_0.tree_:SetData(var_48_0)

	local var_48_1 = arg_48_0.params_.goodId

	if arg_48_0.params_.shopId == nil and arg_48_0.params_.goodId then
		local var_48_2 = getShopCfg(var_48_1)

		arg_48_0.params_.shopId = var_48_2.shop_id
	end

	arg_48_0:SelectTreeByShopId(arg_48_0.params_.shopId)

	if var_48_1 and ShopTools.IsGoodCanBuy(arg_48_0.curShopId_, var_48_1) then
		arg_48_0.timer_ = FrameTimer.New(function()
			arg_48_0.params_.goodId = nil

			local var_49_0 = getShopCfg(var_48_1)
			local var_49_1 = {
				id = var_48_1,
				shopId = var_49_0.shop_id,
				buyTime = ShopData.GetShop(var_49_0.shop_id)[var_48_1] ~= nil and ShopData.GetShop(var_49_0.shop_id)[var_48_1].buy_times or 0
			}

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = arg_48_0.curShopId_,
				goodInfo = var_49_1
			})

			arg_48_0.timer_ = nil
		end, 1, 1)

		arg_48_0.timer_:Start()
	end

	arg_48_0.updateDirty_ = false
end

function var_0_0.OnTop(arg_50_0)
	if arg_50_0.params_.shopId == arg_50_0.curShopId_ then
		arg_50_0:UpdateBarByShopId(arg_50_0.curShopId_)

		return
	end

	if arg_50_0.curShopId_ ~= nil then
		arg_50_0.needKeepPos1 = true

		arg_50_0:UpdateViewByParams()
	end
end

function var_0_0.OnBehind(arg_51_0)
	arg_51_0.updateDirty_ = true
end

function var_0_0.OnExit(arg_52_0)
	manager.windowBar:HideBar()
	SetActive(arg_52_0.siftGo_, false)

	for iter_52_0, iter_52_1 in pairs(arg_52_0.list1:GetItemList()) do
		iter_52_1:OnExit()
	end

	for iter_52_2, iter_52_3 in ipairs(arg_52_0.itemListPool) do
		iter_52_3.itemView:OnExit()
	end

	for iter_52_4, iter_52_5 in ipairs(arg_52_0.itemEquipPool) do
		iter_52_5.itemView:OnExit()
	end

	for iter_52_6, iter_52_7 in ipairs(arg_52_0.itemEquipBuyPool) do
		iter_52_7.itemView:OnExit()
	end

	arg_52_0.isFist = nil

	arg_52_0:StopTimer()
	arg_52_0:RemoveAllEventListener()
	arg_52_0:UnBindRedPoints()
end

function var_0_0.StopTimer(arg_53_0)
	if arg_53_0.refreshTimer_ then
		arg_53_0.refreshTimer_:Stop()

		arg_53_0.refreshTimer_ = nil
	end
end

function var_0_0.SetTimer(arg_54_0)
	arg_54_0:StopTimer()

	local var_54_0 = _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()

	if var_54_0 < 0 then
		var_54_0 = 0
	end

	arg_54_0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime()))
	arg_54_0.refreshTimer_ = Timer.New(function()
		arg_54_0:UpdateTimer()
	end, 1, var_54_0, 1)

	arg_54_0.refreshTimer_:Start()
end

function var_0_0.UpdateTimer(arg_56_0)
	if not arg_56_0.waitingRefresh_ and (arg_56_0.curShopId_ == 1 or arg_56_0.curShopId_ == 2) then
		if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() <= 0 then
			arg_56_0:Complete()
			arg_56_0:StopTimer()

			arg_56_0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))

			return
		end

		arg_56_0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))
	end
end

function var_0_0.Complete(arg_57_0)
	arg_57_0.waitingRefresh_ = true

	ShopAction.RefreshAllShop()
end

function var_0_0.OnRefreshAllShop(arg_58_0, arg_58_1)
	if arg_58_1.result == 0 then
		if arg_58_0.resumeTimer_ == nil then
			arg_58_0.resumeTimer_ = Timer.New(function()
				arg_58_0.waitingRefresh_ = false
				arg_58_0.resumeTimer_ = nil

				arg_58_0:SetTimer()
			end, 1, 1)
		end

		arg_58_0.resumeTimer_:Start()
	else
		return
	end
end

function var_0_0.GetRefreshCount(arg_60_0)
	local var_60_0 = arg_60_0.curShopId_

	if ShopData.GetShop(var_60_0) then
		return ShopData.GetShop(var_60_0).refreshCount
	end

	return 0
end

function var_0_0.GetDiamondCount(arg_61_0)
	local var_61_0 = arg_61_0.curShopId_
	local var_61_1 = ShopData.GetShop(var_61_0)
	local var_61_2 = GameCurrencyBuySetting[#GameCurrencyBuySetting.all].shop_money_refresh

	if var_61_1.refreshCount < #GameCurrencyBuySetting.all then
		return GameCurrencyBuySetting[var_61_1.refreshCount + 1].shop_money_refresh
	else
		return var_61_2
	end
end

function var_0_0.Dispose(arg_62_0)
	if arg_62_0.tree_ then
		arg_62_0.tree_:Dispose()

		arg_62_0.tree_ = nil
	end

	arg_62_0.filterBottomView_:Dispose()

	if arg_62_0.list1 then
		arg_62_0.list1:Dispose()

		arg_62_0.list1 = nil
	end

	if arg_62_0.equipList then
		arg_62_0.equipList:Dispose()

		arg_62_0.equipList = nil
	end

	for iter_62_0, iter_62_1 in ipairs(arg_62_0.itemListPool) do
		iter_62_1.itemView:Dispose()
	end

	for iter_62_2, iter_62_3 in ipairs(arg_62_0.itemEquipPool) do
		iter_62_3.itemView:Dispose()
	end

	for iter_62_4, iter_62_5 in ipairs(arg_62_0.itemEquipBuyPool) do
		iter_62_5.itemView:Dispose()
	end

	arg_62_0.itemListPool = nil
	arg_62_0.itemEquipPool = nil
	arg_62_0.itemEquipBuyPool = nil

	for iter_62_6, iter_62_7 in ipairs(arg_62_0.titleTogList) do
		iter_62_7:Dispose()
	end

	arg_62_0:RemoveAllListeners()

	arg_62_0.curShopId_ = nil

	var_0_0.super.Dispose(arg_62_0)
end

function var_0_0.LsGetItemData(arg_63_0)
	arg_63_0.detailList, arg_63_0.count = arg_63_0:GetShowList(arg_63_0.shopDataList)

	local var_63_0 = ShopListCfg[arg_63_0.curShopId_]

	if arg_63_0.inSelect then
		arg_63_0.titleList = {}
		arg_63_0.indexList = {}

		return arg_63_0:GetSelectList()
	elseif var_63_0.shop_label ~= "" and #var_63_0.shop_label > 0 then
		return arg_63_0.detailList
	else
		return {}
	end
end

function var_0_0.LsAddItem(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0

	if arg_64_0.equipData and arg_64_2 - 1 == arg_64_0.clickIndex then
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemEquipBuyPool, function()
			return ExchangEquipBuyItem.New(arg_64_0.item3Go_, arg_64_0.diaGridGo_)
		end)
	elseif arg_64_1[1][1] == nil then
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemListPool, function()
			return ExchangeSplitItem.New(arg_64_0.item1Go_, arg_64_0.diaGridGo_)
		end)
	else
		var_64_0 = arg_64_0:GetFreeItem(arg_64_0.itemEquipPool, function()
			return ExchangeEquipItem.New(arg_64_0.item2Go_, arg_64_0.diaGridGo_)
		end)
	end

	var_64_0.itemView:SetData(arg_64_1, arg_64_0.titleList, arg_64_0.indexList, arg_64_2, handler(arg_64_0, arg_64_0.ClickCallBack), arg_64_0.loopScrollView_)

	return var_64_0
end

function var_0_0.ClickCallBack(arg_68_0, arg_68_1, arg_68_2)
	if arg_68_0.clickIndex == nil then
		arg_68_0.clickIndex = arg_68_1
		arg_68_0.equipData = arg_68_2

		arg_68_0.loopScrollView_:NavigateIndex(arg_68_0.clickIndex)
	elseif arg_68_0.equipData ~= arg_68_2 and arg_68_2 ~= nil then
		arg_68_0.equipData = arg_68_2

		if arg_68_1 > arg_68_0.clickIndex then
			arg_68_0.clickIndex = arg_68_1 - 1
		else
			arg_68_0.clickIndex = arg_68_1
		end

		arg_68_0.loopScrollView_:NavigateIndex(arg_68_0.clickIndex)
	else
		arg_68_0.clickIndex = nil
		arg_68_0.equipData = nil

		arg_68_0.loopScrollView_:RefreshScrollView(false, true)
	end
end

function var_0_0.LsRemoveItem(arg_69_0, arg_69_1)
	arg_69_1.itemView:Show(false)

	arg_69_1.isFree = true
end

function var_0_0.GetFreeItem(arg_70_0, arg_70_1, arg_70_2)
	for iter_70_0, iter_70_1 in pairs(arg_70_1) do
		if iter_70_1.isFree == true then
			iter_70_1.isFree = false

			return iter_70_1
		end
	end

	local var_70_0 = {
		isFree = false,
		itemView = arg_70_2()
	}

	table.insert(arg_70_1, var_70_0)

	return var_70_0
end

function var_0_0.GetSelectList(arg_71_0)
	local var_71_0 = {}
	local var_71_1

	for iter_71_0, iter_71_1 in ipairs(arg_71_0.shopDataList) do
		if iter_71_1[1][1] then
			var_71_1 = iter_71_1
		end
	end

	if next(arg_71_0.selectSuitTable) == nil then
		arg_71_0.inSelect = false

		arg_71_0.colorController:SetSelectedState("normal")

		return {}
	end

	for iter_71_2, iter_71_3 in ipairs(var_71_1) do
		local var_71_2 = EquipCfg[getShopCfg(iter_71_3[1].id).give_id]

		if arg_71_0.selectSuitTable[var_71_2.suit] then
			table.insert(var_71_0, iter_71_3)
		end
	end

	local var_71_3 = {
		{}
	}
	local var_71_4 = 1

	for iter_71_4, iter_71_5 in ipairs(var_71_0) do
		table.insert(var_71_3[var_71_4], iter_71_5)

		if #var_71_3[var_71_4] >= 5 then
			var_71_4 = var_71_4 + 1
			var_71_3[var_71_4] = {}
		end
	end

	if arg_71_0.equipData then
		table.insert(var_71_3, arg_71_0.clickIndex + 1, arg_71_0.equipData)
	end

	if next(var_71_3[1]) == nil then
		return {}
	else
		return var_71_3
	end
end

function var_0_0.LsUpdateItem(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	arg_72_1.itemView:SetData(arg_72_2, arg_72_0.titleList, arg_72_0.indexList, arg_72_3, handler(arg_72_0, arg_72_0.ClickCallBack), arg_72_0.loopScrollView_)
end

return var_0_0
