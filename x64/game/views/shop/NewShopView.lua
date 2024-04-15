slot0 = class("NewShopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Shop/ShopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.updateDirty_ = true

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.GetTreeDataByParams(slot0)
	slot1 = {}

	if slot0.params_.showShops then
		slot1 = slot0.params_.showShops
	else
		for slot6, slot7 in ipairs(ShopListCfg.get_id_list_by_system[1]) do
			if ShopListCfg[slot7].show_in_shop == 1 then
				table.insert(slot1, slot7)
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if ShopTools.IsShopOpen(slot7) then
			table.insert(slot2, slot7)
		end
	end

	slot0.groups = {}
	slot0.groupIndexes = {}
	slot3 = UITreeData.New()

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.groups[ShopListCfg[slot8].display_group] then
			slot0.groups[slot9.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(slot0.groupIndexes, slot9.display_group)
		end

		slot0.groups[slot9.display_group][slot9.display_index] = slot9

		table.insert(slot0.groups[slot9.display_group].itemIndexes_, slot9.display_index)
	end

	for slot7, slot8 in pairs(slot0.groups) do
		table.sort(slot8.itemIndexes_, function (slot0, slot1)
			return slot0 < slot1
		end)
	end

	function slot7(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot0.groupIndexes, slot7)

	for slot7, slot8 in pairs(slot0.groupIndexes) do
		slot9 = UITreeGroupData.New()
		slot9.text = GetI18NText(ShopListCfg.get_id_list_by_system_and_group[1][slot8][1].group_name)
		slot9.controllerStateValue = tostring(slot8)
		slot9.id = slot8

		slot3.groupDatas:Add(slot9)
	end

	return slot3
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.shopController = slot0.controller_:GetController("shop")
	slot0.stateController = slot0.controller_:GetController("state")
	slot0.colorController = slot0.sortController_:GetController("color")
	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))

	slot0.list1 = LuaList.New(handler(slot0, slot0.SetItem1), slot0.list1Go_, ExchangeItemView)
	slot0.equipList = LuaList.New(handler(slot0, slot0.SetEquipItem), slot0.equipListGo_, EquipSiftShopItem)
	slot0.bindingHeroPeiceRed_ = false
	slot0.titleTogList = {
		RechargeTitleItem.New(slot0.tag01_),
		RechargeTitleItem.New(slot0.tag02_),
		RechargeTitleItem.New(slot0.tag03_),
		RechargeTitleItem.New(slot0.tag04_),
		RechargeTitleItem.New(slot0.tag05_)
	}
	slot0.selectSuitTable = {}
	slot0.selectSiftList = {}
	slot0.loopScrollView_ = LoopScrollView.New(slot0, slot0.diaScrollEx_, slot0.diaGridTrs_, slot0.diaViewPortTrs_, slot0.diaViewPortTrs_.rect.height, slot0.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
	slot0.filterBottomView_ = CommonFilterBottom.New(slot0.fillListGo_)

	slot0.filterBottomView_:RegisteClearBtnListener(handler(slot0, slot0.ClearFilter))

	slot0.itemListPool = {}
	slot0.itemEquipPool = {}
	slot0.itemEquipBuyPool = {}
end

function slot0.SetItem1(slot0, slot1, slot2)
	slot2:SetData(slot0.shopDataList[slot1])
end

function slot0.SetEquipItem(slot0, slot1, slot2)
	slot2:SetData(slot0.suitList[slot1], slot0.selectSuitTable, handler(slot0, slot0.EquipCallback), slot0.isClickClean)
end

function slot0.ClearFilter(slot0)
	slot0.isClickClean = true
	slot0.selectSuitTable = {}
	slot0.selectSiftList = {}

	slot0.equipList:StartScrollWithoutAnimator(#slot0.suitList, slot0.equipList:GetScrolledPosition())
	slot0.filterBottomView_:Refresh({})
end

function slot0.EquipCallback(slot0, slot1, slot2)
	slot0.isClickClean = nil

	if slot0.selectSuitTable[slot1] then
		slot0.selectSuitTable[slot1] = nil

		slot2:SetSelectedState("false")

		slot3 = nil

		for slot7, slot8 in ipairs(slot0.selectSiftList) do
			if slot8.id == slot1 then
				slot3 = slot7
			end
		end

		table.remove(slot0.selectSiftList, slot3)
	else
		slot0.selectSuitTable[slot1] = true

		table.insert(slot0.selectSiftList, {
			type = 1,
			id = slot1
		})
		slot2:SetSelectedState("select")
	end

	slot0:RefreshBottom()
end

function slot0.RefreshBottom(slot0)
	slot1 = {}
	slot2 = 1

	for slot6 = 1, #slot0.selectSiftList do
		table.insert(slot1, {
			name = GetI18NText(EquipSuitCfg[slot0.selectSiftList[slot6].id].name),
			id = slot2
		})

		slot2 = slot2 + 1
	end

	slot0.filterBottomView_:Refresh(slot1)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.groupInfo = slot0.groups[slot0.groupIndexes[slot1]]

	for slot9, slot10 in ipairs(slot0.titleTogList) do
		if slot9 <= #slot0.groupInfo.itemIndexes_ then
			SetActive(slot10.gameObject_, #slot0.groupInfo.itemIndexes_ ~= 1)

			slot11 = slot0.groupInfo[slot0.groupInfo.itemIndexes_[slot9]].id

			slot10:SetData(slot0.groupInfo[slot0.groupInfo.itemIndexes_[slot9]], slot9, handler(slot0, slot0.ClickTitle), slot11)
			SetActive(slot0["newGo" .. slot9 .. "_"], slot0:CheckShopRedPoint(slot11))
			SetActive(slot0["redGo" .. slot9 .. "_"], slot0:SpecialShop(slot11))
		else
			SetActive(slot10.gameObject_, false)
		end
	end

	for slot9 = 1, 4 do
		SetActive(slot0["line" .. slot9 .. "Go_"], slot9 < #slot0.groupInfo.itemIndexes_)
	end

	if #slot0.groupInfo.itemIndexes_ == 1 then
		if #ShopListCfg[slot0.groupInfo[slot0.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
			slot0.stateController:SetSelectedState("state2")
		else
			slot0.stateController:SetSelectedState("state1")
		end
	else
		slot0.stateController:SetSelectedState("normal")
	end

	if slot0.currentGroupIndex_ == slot1 then
		slot0:ClickTitle(slot0.itemToSelect_ or slot0.currentItemIndex_)
	else
		slot0:ClickTitle(slot0.itemToSelect_ or 1)
	end

	slot0.currentGroupIndex_ = slot1
	slot0.itemToSelect_ = nil
end

function slot0.ClickTitle(slot0, slot1)
	slot0.currentItemIndex_ = slot1

	if not ShopTools.CheckShopIsUnLock(slot0.groupInfo[slot0.groupInfo.itemIndexes_[slot1]].id, slot0.curShopId_) and not string.isNullOrEmpty(ShopTools.GetShopIsUnLockDesc(slot2, slot0.curShopId_)) then
		ShowTips(slot3)
	end

	for slot6, slot7 in ipairs(slot0.titleTogList) do
		slot7.controller:SetSelectedState(slot6 == slot1 and "false" or "true")
	end

	if slot0.curShopId_ ~= slot2 then
		slot0.selectSuitTable = {}
		slot0.selectSiftList = {}
	else
		return
	end

	TimeTools.StartAfterSeconds(0.1, function ()
		uv0.loopScrollView_:SetContentHeight(uv0.diaViewPortTrs_.rect.height)
	end, {})

	slot0.equipData = nil
	slot0.clickIndex = nil
	slot0.isClickClean = nil
	slot0.copyList1 = nil
	slot0.copyList2 = nil

	if ShopData.GetRedPointData()[slot2] then
		ShopAction.RemoveShopRedPoint(slot2)
		SetActive(slot0["newGo" .. slot1 .. "_"], false)
	end

	slot0:UpdateBarByShopId(slot2)

	slot0.params_.shopId = slot2
	slot0.inSelect = false

	slot0.colorController:SetSelectedState("normal")
	slot0:UpdateShopList(slot2)
end

function slot0.UpdateBottomView(slot0)
	if slot0.curShopId_ == ShopConst.SHOP_ID.DAILY_SHOP then
		slot0.shopController:SetSelectedState("state0")
		slot0:SetTimer()

		if slot0:GetRefreshCount() ~= ShopListCfg[slot0.curShopId_].refresh_num_limit then
			slot0.refreshTimesTxt_.text = GetTips("CLUB_REFRES_TEXT") .. string.format("(%d/%d)", ShopListCfg[slot0.curShopId_].refresh_num_limit - slot0:GetRefreshCount(), ShopListCfg[slot0.curShopId_].refresh_num_limit)
		else
			slot0.refreshTimesTxt_.text = GetTips("CLUB_REFRES_TEXT") .. string.format("(<color=#FF000B>%d</color>/%d)", ShopListCfg[slot0.curShopId_].refresh_num_limit - slot0:GetRefreshCount(), ShopListCfg[slot0.curShopId_].refresh_num_limit)
		end

		if ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id) < slot0:GetDiamondCount() then
			slot0.refreshCostTxt_.text = "<color=#FF000B>" .. slot0:GetDiamondCount() .. "</color>"
		else
			slot0.refreshCostTxt_.text = slot0:GetDiamondCount()
		end

		SetActive(slot0.costGo_, slot0:GetRefreshCount() ~= ShopListCfg[slot0.curShopId_].refresh_num_limit)
	elseif slot0.curShopId_ == ShopConst.SHOP_ID.REPORT_SHOP then
		slot0.shopController:SetSelectedState("state2")
	elseif slot0.curShopId_ == ShopConst.SHOP_ID.COHOMOLOGY_TRACKS then
		slot0.shopController:SetSelectedState("state3")
	elseif slot0.curShopId_ == ShopConst.SHOP_ID.BLACK_AREA or slot0.curShopId_ == ShopConst.SHOP_ID.EQUIP_DEVELOP then
		slot0.shopController:SetSelectedState("state4")
	else
		slot0.shopController:SetSelectedState("state1")
	end
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if slot0 == 0 or uv0.curShopId_ == slot0 then
			uv0:UpdateShopList(uv0.curShopId_)
		end
	end)
	slot0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function (slot0)
		uv0.needKeepPos1 = true

		uv0:OnRefreshAllShop(slot0)
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		if uv0.curShopId_ ~= slot0 then
			return
		end

		uv0.needKeepPos1 = true

		uv0:RefreshList()
	end)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if getShopIDListByCurrency(slot0) ~= nil and #slot1 > 0 then
			uv0.needKeepPos1 = true

			uv0:UpdateShopList(uv0.curShopId_, true)
		end
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.refreshBtn_, nil, function ()
		if ShopListCfg[uv0.curShopId_].refresh_num_limit <= uv0:GetRefreshCount() then
			ShowTips("SHOP_REFRESH_LIMIT")

			return
		end

		if _G.SkipTip.SkipShopRefreshTip then
			ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, uv0:GetDiamondCount())

			return
		end

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			itemId = MaterialConst.MYTHIC_REFRESH_ITEM_ID,
			popCostCallBack = function ()
				OperationRecorder.Record("shop", "okRefresh")
				ShopAction.RefreshSingleShop(ShopConst.SHOP_ID.DAILY_SHOP, uv0:GetDiamondCount())

				_G.SkipTip.SkipShopRefreshTip = uv0.skipShopRefreshTip_
			end,
			ToggleCallback = function (slot0)
				uv0.skipShopRefreshTip_ = slot0

				if slot0 then
					OperationRecorder.Record("shop", "toggle")
				end
			end,
			content = string.format(GetTips("MATRIX_SHOP_REFRESH"), ItemTools.getItemName(CurrencyConst.CURRENCY_TYPE_DIAMOND), uv0:GetDiamondCount())
		})
	end)
	slot0:AddBtnListener(slot0.heroPieceExchangeBtn_, nil, function ()
		JumpTools.OpenPopUp("fragmentExchange", nil, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.quashBtn_, nil, function ()
		JumpTools.OpenPageByJump("moduleItemResolveView")
	end)
	slot0:AddBtnListener(slot0.siftBtn_, nil, function ()
		SetActive(uv0.siftGo_, true)

		if uv0.isClickClean then
			uv0.inSelect = false
			uv0.selectSuitTable = {}
			uv0.selectSiftList = {}
		else
			uv0.inSelect = true
		end

		if uv0.copyList1 then
			uv0.selectSiftList = uv0.copyList1
		end

		if uv0.copyList2 then
			uv0.selectSuitTable = uv0.copyList2
		end

		uv0.equipList:StartScroll(#uv0.suitList)
		uv0:RefreshBottom(true)
	end)
	slot0:AddBtnListener(slot0.siftSuitBtn_, nil, function ()
		SetActive(uv0.siftGo_, false)

		if uv0.isClickClean then
			uv0.inSelect = false
			uv0.isClickClean = nil
		else
			uv0.inSelect = true
		end

		uv0.selectList = uv0:GetSelectList()
		uv0.clickIndex = nil
		uv0.equipData = nil
		uv0.clickItem = nil

		uv0:RefreshList()

		uv0.copyList1 = clone(uv0.selectSiftList)
		uv0.copyList2 = clone(uv0.selectSuitTable)

		uv0.colorController:SetSelectedState(#uv0.selectSiftList == 0 and "normal" or "orange")
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		SetActive(uv0.siftGo_, false)

		uv0.isClickClean = nil

		if uv0.colorController:GetSelectedState() == "normal" then
			uv0.selectSuitTable = {}
			uv0.selectSiftList = {}
			uv0.isClickClean = nil
		end
	end)
end

function slot0.BindRedPoints(slot0)
	for slot4, slot5 in pairs(slot0.groups) do
		if slot0.tree_:GetGroupRedPointContainerById(slot4) then
			SetActive(slot6, true)

			slot7 = false
			slot8 = false
			slot9 = slot6.transform:Find("notice_img/Default")
			slot10 = slot6.transform:Find("notice_img/NewRed")

			for slot14, slot15 in pairs(slot5) do
				if slot0:CheckShopRedPoint(slot15.id) then
					slot7 = true
				end

				if slot0:SpecialShop(slot15.id) then
					slot8 = true
				end
			end

			SetActive(slot10, slot7)
			SetActive(slot9, slot8)
		end
	end

	manager.redPoint:bindUIandKey(slot0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)

	slot0.updateTimer_ = Timer.New(function ()
		for slot3, slot4 in ipairs(uv0.titleTogList) do
			if slot3 <= #uv0.groupInfo.itemIndexes_ then
				slot5 = uv0.groupInfo[uv0.groupInfo.itemIndexes_[slot3]].id

				SetActive(uv0["newGo" .. slot3 .. "_"], uv0:CheckShopRedPoint(slot5))
				SetActive(uv0["redGo" .. slot3 .. "_"], uv0:SpecialShop(slot5))
			end
		end

		for slot3, slot4 in pairs(uv0.groups) do
			if uv0.tree_:GetGroupRedPointContainerById(slot3) then
				SetActive(slot5, true)

				slot6 = false
				slot7 = false
				slot8 = slot5.transform:Find("notice_img/Default")
				slot9 = slot5.transform:Find("notice_img/NewRed")

				for slot13, slot14 in pairs(slot4) do
					if uv0:CheckShopRedPoint(slot14.id) then
						slot6 = true
					end

					if uv0:SpecialShop(slot14.id) then
						slot7 = true
					end
				end

				SetActive(slot9, slot6)
				SetActive(slot8, slot7)
			end
		end
	end, 1, -1, 1)

	slot0.updateTimer_:Start()
end

function slot0.SpecialShop(slot0, slot1)
	if ShopConst.SHOP_ID_TO_RED_CONST[slot1] then
		return manager.redPoint:getTipValue(ShopConst.SHOP_ID_TO_RED_CONST[slot1]) == 1
	else
		return false
	end
end

function slot0.CheckShopRedPoint(slot0, slot1)
	return ShopData.GetRedPointData()[slot1] == true
end

function slot0.UnBindRedPoints(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.heroPieceExchangeBtn_.transform, RedPointConst.HERO_PIECE_EXCHANGE)
end

function slot0.OnRefreshOneShop(slot0, slot1)
	slot0:RefreshList()
end

function slot0.UpdateShopList(slot0, slot1)
	slot0.curShopId_ = slot1
	slot2 = ShopListCfg[slot1]
	slot5 = slot0.list1
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:CloseTimer()
	end

	for slot6, slot7 in ipairs(slot0.itemListPool) do
		slot7.itemView:OnExit()
	end

	for slot6, slot7 in ipairs(slot0.itemEquipPool) do
		slot7.itemView:OnExit()
	end

	for slot6, slot7 in ipairs(slot0.itemEquipBuyPool) do
		slot7.itemView:OnExit()
	end

	slot0.list = slot0.list1
	slot0.RefreshList = slot0.RefreshListType1

	if #slot2.shop_label >= 1 then
		slot0.RefreshList = slot0.RefreshListType2
	end

	slot0:RefreshList()
	slot0:UpdateBottomView()
	slot0:UpdateTimer()
end

function slot0.RefreshListType1(slot0)
	SetActive(slot0.list1Go_, true)
	SetActive(slot0.proofGo_, false)

	slot0.shopDataList = ShopTools.FilterShopDataList(slot0.curShopId_, ShopListCfg[slot0.curShopId_].chain_last_visible == 1)
	slot0.shopDataList = ShopTools.CommonSort(slot0.shopDataList)

	if slot0.needKeepPos1 then
		slot0.pos = slot0.list:GetScrolledPosition()
	else
		slot0.pos = nil
	end

	slot0.list:StartScrollWithoutAnimator(#slot0.shopDataList, slot0.pos)

	slot0.needKeepPos1 = nil

	slot0:UpdateBarByShopId(slot0.curShopId_)
end

function slot0.RefreshListType2(slot0)
	SetActive(slot0.proofGo_, true)
	SetActive(slot0.list1Go_, false)

	slot1 = ShopListCfg[slot0.curShopId_]

	if slot0.isFist == nil then
		slot0.isFist = true
	end

	slot0.shopDataList = ShopTools.FilterShopDataList(slot0.curShopId_, slot1.chain_last_visible == 1)
	slot0.shopDataList = ShopTools.CommonSort(slot0.shopDataList)
	slot0.shopDataList, slot0.titleList, slot0.suitList = ShopTools.SplitDataByShopID(slot0.shopDataList, slot0.curShopId_)

	slot0:UpdateBarByShopId(slot0.curShopId_)

	slot2 = slot0.diaScrollEx_.verticalNormalizedPosition

	if slot0.needKeepPos1 then
		slot0.needKeepPos1 = false

		slot0.loopScrollView_:RefreshScrollView(false)

		slot0.diaScrollEx_.verticalNormalizedPosition = slot2

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.diaScrollEx_.transform)

		slot0.diaScrollEx_.verticalNormalizedPosition = slot2
	else
		slot0.loopScrollView_:NavigateIndex(1)

		if slot0.isFist then
			slot0.isFist = false

			TimeTools.StartAfterSeconds(0.1, function ()
				uv0.loopScrollView_:NavigateIndex(1)
			end, {})
		end
	end

	slot0:UpdateBottomView()
end

function slot0.GetShowList(slot0, slot1)
	slot2 = {
		{}
	}
	slot0.indexList = {}

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.item1Trs_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.shopItemTrs_.transform)

	slot7 = slot0.shopItemTrs_.rect.width
	slot0.lineCount = math.floor(slot0.item1Trs_.rect.width / slot7)

	for slot7 = 1, #slot1 do
		slot0.indexList[slot7] = 0 + 1

		for slot11, slot12 in ipairs(slot1[slot7]) do
			if slot2[slot3] == nil then
				slot2[slot3] = {}
			end

			if slot0.lineCount <= #slot2[slot3] then
				slot3 = slot3 + 1
			end

			if slot2[slot3] == nil then
				slot2[slot3] = {}
			end

			table.insert(slot2[slot3], slot12)
		end
	end

	if slot0.clickIndex and slot0.equipData then
		table.insert(slot2, slot0.clickIndex + 1, slot0.equipData)
	end

	return slot2, slot3
end

function slot0.UpdateBarByShopId(slot0, slot1)
	table.insert({}, BACK_BAR)

	if slot0.params_.hideHomeBtn ~= 1 then
		table.insert(slot2, HOME_BAR)
		manager.windowBar:RegistHomeCallBack(function ()
			gameContext:Go("/home", nil, , true)
		end)
	end

	table.insert(slot2, NAVI_BAR)

	slot3 = {}

	for slot8 = 1, #ShopListCfg[slot1].cost_id do
		slot9 = nil

		if ((not CurrencyIdMapCfg[slot4.cost_id[slot8]] or CurrencyIdMapCfg[slot4.cost_id[slot8]].item_id) and slot4.cost_id[slot8]) == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			slot9 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(slot2, slot9)
		table.insert(slot3, slot9)
	end

	slot8 = slot2

	manager.windowBar:SwitchBar(slot8)

	for slot8 = 1, #slot3 do
		manager.windowBar:SetBarCanAdd(slot3[slot8], ShopConst.ADD_CURRENCY[slot3[slot8]] == true)
		manager.windowBar:SetBarCanClick(slot3[slot8], true)
	end

	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back()
	end)
end

function slot0.SelectTreeByShopId(slot0, slot1)
	if next(slot0.groupIndexes) == nil then
		return
	end

	slot2 = -1
	slot3 = ShopListCfg[slot1].display_group

	for slot7, slot8 in ipairs(slot0.groupIndexes) do
		if slot8 == slot3 then
			slot2 = slot7
		end
	end

	slot4 = -1

	for slot8, slot9 in ipairs(slot0.groups[slot3].itemIndexes_) do
		if slot0.groups[slot3][slot9].id == slot1 then
			slot4 = slot8

			break
		end
	end

	if slot4 > 0 then
		slot0.itemToSelect_ = slot4
	end

	slot0.tree_:SelectGroup(slot2)
end

function slot0.OnEnter(slot0)
	slot0:UpdateViewByParams()
	slot0:InitShopByParams()
	slot0:AddEventListeners()
	slot0:BindRedPoints()
end

function slot0.InitShopByParams(slot0)
	if not slot0.updateDirty_ then
		return
	end

	slot2 = slot0.params_.shopId

	if slot0.params_.goodId then
		slot0.curShopId_ = ShopListCfg[getShopCfg(slot1).shop_id].id
	else
		slot0.curShopId_ = tonumber(slot2 or 2)
	end

	slot0.currentGroupIndex_ = ShopListCfg[slot0.curShopId_].display_group
end

function slot0.UpdateViewByParams(slot0)
	slot1 = slot0:GetTreeDataByParams()

	if next(slot0.groupIndexes) == nil then
		return
	end

	slot0.tree_:SetData(slot1)

	slot2 = slot0.params_.goodId

	if slot0.params_.shopId == nil and slot0.params_.goodId then
		slot0.params_.shopId = getShopCfg(slot2).shop_id
	end

	slot0:SelectTreeByShopId(slot0.params_.shopId)

	if slot2 and ShopTools.IsGoodCanBuy(slot0.curShopId_, slot2) then
		slot0.timer_ = FrameTimer.New(function ()
			uv0.params_.goodId = nil
			slot0 = getShopCfg(uv1)

			JumpTools.OpenPopUp("shopBuy", {
				mainShopID = uv0.curShopId_,
				goodInfo = {
					id = uv1,
					shopId = slot0.shop_id,
					buyTime = ShopData.GetShop(slot0.shop_id)[uv1] ~= nil and ShopData.GetShop(slot0.shop_id)[uv1].buy_times or 0
				}
			})

			uv0.timer_ = nil
		end, 1, 1)

		slot0.timer_:Start()
	end

	slot0.updateDirty_ = false
end

function slot0.OnTop(slot0)
	if slot0.params_.shopId == slot0.curShopId_ then
		slot0:UpdateBarByShopId(slot0.curShopId_)

		return
	end

	if slot0.curShopId_ ~= nil then
		slot0.needKeepPos1 = true

		slot0:UpdateViewByParams()
	end
end

function slot0.OnBehind(slot0)
	slot0.updateDirty_ = true
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot4 = false

	SetActive(slot0.siftGo_, slot4)

	slot3 = slot0.list1
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.itemListPool) do
		slot5.itemView:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.itemEquipPool) do
		slot5.itemView:OnExit()
	end

	for slot4, slot5 in ipairs(slot0.itemEquipBuyPool) do
		slot5.itemView:OnExit()
	end

	slot0.isFist = nil

	slot0:StopTimer()
	slot0:RemoveAllEventListener()
	slot0:UnBindRedPoints()
end

function slot0.StopTimer(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

function slot0.SetTimer(slot0)
	slot0:StopTimer()

	if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() < 0 then
		slot1 = 0
	end

	slot0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime()))
	slot0.refreshTimer_ = Timer.New(function ()
		uv0:UpdateTimer()
	end, 1, slot1, 1)

	slot0.refreshTimer_:Start()
end

function slot0.UpdateTimer(slot0)
	if not slot0.waitingRefresh_ and (slot0.curShopId_ == 1 or slot0.curShopId_ == 2) then
		if _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime() <= 0 then
			slot0:Complete()
			slot0:StopTimer()

			slot0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))

			return
		end

		slot0.refreshTimeTxt_.text = string.format(GetTips("TIME_DISPLAY_8"), TimeMgr.GetInstance():GetLostTimeStrWith2Unit(_G.gameTimer:GetNextDayFreshTime(), true))
	end
end

function slot0.Complete(slot0)
	slot0.waitingRefresh_ = true

	ShopAction.RefreshAllShop()
end

function slot0.OnRefreshAllShop(slot0, slot1)
	if slot1.result == 0 then
		if slot0.resumeTimer_ == nil then
			slot0.resumeTimer_ = Timer.New(function ()
				uv0.waitingRefresh_ = false
				uv0.resumeTimer_ = nil

				uv0:SetTimer()
			end, 1, 1)
		end

		slot0.resumeTimer_:Start()
	else
		return
	end
end

function slot0.GetRefreshCount(slot0)
	if ShopData.GetShop(slot0.curShopId_) then
		return ShopData.GetShop(slot1).refreshCount
	end

	return 0
end

function slot0.GetDiamondCount(slot0)
	slot3 = GameCurrencyBuySetting[#GameCurrencyBuySetting.all].shop_money_refresh

	if ShopData.GetShop(slot0.curShopId_).refreshCount < #GameCurrencyBuySetting.all then
		return GameCurrencyBuySetting[slot2.refreshCount + 1].shop_money_refresh
	else
		return slot3
	end
end

function slot0.Dispose(slot0)
	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	slot0.filterBottomView_:Dispose()

	if slot0.list1 then
		slot0.list1:Dispose()

		slot0.list1 = nil
	end

	if slot0.equipList then
		slot0.equipList:Dispose()

		slot0.equipList = nil
	end

	for slot4, slot5 in ipairs(slot0.itemListPool) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.itemEquipPool) do
		slot5.itemView:Dispose()
	end

	for slot4, slot5 in ipairs(slot0.itemEquipBuyPool) do
		slot5.itemView:Dispose()
	end

	slot0.itemListPool = nil
	slot0.itemEquipPool = nil
	slot0.itemEquipBuyPool = nil

	for slot4, slot5 in ipairs(slot0.titleTogList) do
		slot5:Dispose()
	end

	slot0:RemoveAllListeners()

	slot0.curShopId_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.LsGetItemData(slot0)
	slot0.detailList, slot0.count = slot0:GetShowList(slot0.shopDataList)
	slot1 = ShopListCfg[slot0.curShopId_]

	if slot0.inSelect then
		slot0.titleList = {}
		slot0.indexList = {}

		return slot0:GetSelectList()
	elseif slot1.shop_label ~= "" and #slot1.shop_label > 0 then
		return slot0.detailList
	else
		return {}
	end
end

function slot0.LsAddItem(slot0, slot1, slot2)
	slot3 = nil
	slot3 = (not slot0.equipData or slot2 - 1 ~= slot0.clickIndex or slot0:GetFreeItem(slot0.itemEquipBuyPool, function ()
		return ExchangEquipBuyItem.New(uv0.item3Go_, uv0.diaGridGo_)
	end)) and (slot1[1][1] ~= nil or slot0:GetFreeItem(slot0.itemListPool, function ()
		return ExchangeSplitItem.New(uv0.item1Go_, uv0.diaGridGo_)
	end)) and slot0:GetFreeItem(slot0.itemEquipPool, function ()
		return ExchangeEquipItem.New(uv0.item2Go_, uv0.diaGridGo_)
	end)

	slot3.itemView:SetData(slot1, slot0.titleList, slot0.indexList, slot2, handler(slot0, slot0.ClickCallBack), slot0.loopScrollView_)

	return slot3
end

function slot0.ClickCallBack(slot0, slot1, slot2)
	if slot0.clickIndex == nil then
		slot0.clickIndex = slot1
		slot0.equipData = slot2

		slot0.loopScrollView_:NavigateIndex(slot0.clickIndex)
	elseif slot0.equipData ~= slot2 and slot2 ~= nil then
		slot0.equipData = slot2

		if slot0.clickIndex < slot1 then
			slot0.clickIndex = slot1 - 1
		else
			slot0.clickIndex = slot1
		end

		slot0.loopScrollView_:NavigateIndex(slot0.clickIndex)
	else
		slot0.clickIndex = nil
		slot0.equipData = nil

		slot0.loopScrollView_:RefreshScrollView(false, true)
	end
end

function slot0.LsRemoveItem(slot0, slot1)
	slot1.itemView:Show(false)

	slot1.isFree = true
end

function slot0.GetFreeItem(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot1) do
		if slot7.isFree == true then
			slot7.isFree = false

			return slot7
		end
	end

	slot3 = {
		isFree = false,
		itemView = slot2()
	}

	table.insert(slot1, slot3)

	return slot3
end

function slot0.GetSelectList(slot0)
	slot1 = {}
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.shopDataList) do
		if slot7[1][1] then
			slot2 = slot7
		end
	end

	if next(slot0.selectSuitTable) == nil then
		slot0.inSelect = false

		slot0.colorController:SetSelectedState("normal")

		return {}
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot0.selectSuitTable[EquipCfg[getShopCfg(slot7[1].id).give_id].suit] then
			table.insert(slot1, slot7)
		end
	end

	slot3 = {
		{}
	}
	slot4 = 1

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot3[slot4], slot9)

		if #slot3[slot4] >= 5 then
			slot3[slot4 + 1] = {}
		end
	end

	if slot0.equipData then
		table.insert(slot3, slot0.clickIndex + 1, slot0.equipData)
	end

	if next(slot3[1]) == nil then
		return {}
	else
		return slot3
	end
end

function slot0.LsUpdateItem(slot0, slot1, slot2, slot3)
	slot1.itemView:SetData(slot2, slot0.titleList, slot0.indexList, slot3, handler(slot0, slot0.ClickCallBack), slot0.loopScrollView_)
end

return slot0
