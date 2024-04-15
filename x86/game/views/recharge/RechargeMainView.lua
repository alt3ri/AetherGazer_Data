slot0 = class("RechargeMainView", ReduxView)
slot1 = 2
slot2 = {
	[ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS] = true,
	[ShopConst.SHOP_ID.SKIN_TARGET] = true
}

function slot0.UIName(slot0)
	return "Widget/System/Recharge/RechargeSystemUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.prefabList_ = ShopConst.prefabList
	slot0.ClassList_ = {
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

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.pages_ = {}
	slot0.tree_ = LuaTree.New(slot0.treeGo_)
	slot0.titleList = {
		RechargeTitleItem.New(slot0.tag01_),
		RechargeTitleItem.New(slot0.tag02_),
		RechargeTitleItem.New(slot0.tag03_),
		RechargeTitleItem.New(slot0.tag04_)
	}
	slot0.redBindingGroupIndex_ = 0
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cumulativeBtn_, nil, function ()
		JumpTools.OpenPageByJump("/rechargeTotalRecharge")
	end)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	slot0.groupInfo = slot0.groups_[slot1]

	for slot8, slot9 in ipairs(slot0.titleList) do
		if slot8 <= #slot0.groupInfo.itemIndexes_ then
			slot10 = slot0.groupInfo[slot8].id

			SetActive(slot9.gameObject_, true)
			slot9:SetData(slot0.groupInfo[slot8], slot8, handler(slot0, slot0.ClickTitle), slot10)
			SetActive(slot0["newGo" .. slot8 .. "_"], slot0:CheckShopRedPoint(slot10))
			SetActive(slot0["redGo" .. slot8 .. "_"], slot0:SpecialShop(slot10))
		else
			SetActive(slot9.gameObject_, false)
		end
	end

	for slot8 = 1, 3 do
		SetActive(slot0["line" .. slot8 .. "Go_"], slot8 < #slot0.groupInfo.itemIndexes_)
	end

	slot0.params_.page = slot1

	if slot0.currentGroupIndex_ == slot1 then
		slot0:ClickTitle(slot0.itemToSelect_ or slot0.currentItemIndex_)
	else
		slot0:ClickTitle(slot0.itemToSelect_ or 1)
	end

	slot0.itemToSelect_ = nil
	slot0.currentGroupIndex_ = slot1
end

function slot0.ClickTitle(slot0, slot1)
	OperationRecorder.RecordButtonTouch("shop_recharge_gifts" .. slot0.params_.page .. "_type" .. slot1)

	if ShopConst.PC_LOCK_SHOP[slot0.groupInfo[slot1].id] and ShopTools.IsPC() then
		ShowTips("PC_SHOP_TIPS1")

		return
	end

	slot0.currentItemIndex_ = slot1
	slot0.params_.childShopIndex = slot1

	slot0:SwitchToShop(slot2)

	for slot6, slot7 in ipairs(slot0.titleList) do
		slot7.controller:SetSelectedState(slot6 == slot1 and "false" or "true")
	end

	if ShopData.GetRedPointData()[slot2] then
		ShopAction.RemoveShopRedPoint(slot2)
		SetActive(slot0["newGo" .. slot1 .. "_"], false)
		SetActive(slot0["redGo" .. slot1 .. "_"], slot0:SpecialShop(slot2))
	end

	if slot2 == ShopConst.SHOP_ID.MIGRATION_OBSERVATIONS then
		RedPointAction.HandleRedPoint(RED_POINT_ID.RECHARGE)
		manager.redPoint:setTip(RED_POINT_ID.RECHARGE, 0)
		SetActive(slot0.redGo2_, false)
	end
end

function slot0.UpdateBar(slot0)
	if slot0.shopListId_ == ShopConst.SHOP_ID.SKIN_SHOP or slot0.shopListId_ == ShopConst.SHOP_ID.SKIN_TARGET then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_SKIN
		}, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, uv0[slot0.shopListId_] ~= true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, uv0[slot0.shopListId_] ~= true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId()
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), uv0[slot0.shopListId_] ~= true)
	end
end

function slot0.RefreshTree(slot0)
	slot1 = slot0.tree_

	slot1:SetSelectedHandler(nil, )

	slot2 = slot0:GetTreeDataByParams()

	slot1:SetData(slot2)
	slot1:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))

	slot0.treeData_ = slot2

	slot0:BindRedPoint()
end

function slot0.SwitchToShop(slot0, slot1)
	if slot1 == slot0.shopListId_ then
		return
	end

	if slot0.shopListId_ and slot0.pages_[slot0.shopListId_] then
		slot2:Hide()
	end

	slot0.shopListId_ = slot1
	slot0.params_.shopListId = slot1

	if not slot0.pages_[slot1] then
		slot0.pages_[slot1] = slot0.ClassList_[slot1].New(Object.Instantiate(Asset.Load(slot0.prefabList_[slot1]), slot0.container_), {
			ShopConst.SIX_EIGHT[slot1]
		}, slot1)

		slot0:CheckPageEnter(slot1)
	else
		slot0.pages_[slot1]:Show()
	end

	if slot0.pages_[slot1].SwitchPage then
		slot0.pages_[slot1]:SwitchPage(slot1)
	end

	slot0:UpdateBar()
end

function slot0.SwitchPageByParams(slot0)
	slot0.currentItemIndex_ = 1
	slot0.currentGroupIndex_ = 1
	slot1 = 1

	if slot0.params_.page then
		slot1 = slot0.params_.page
		slot0.currentGroupIndex_ = slot1
		slot2 = slot0.groups_[slot1]
		slot3 = slot0.params_.shopId_ or slot0.params_.shopListId

		for slot7, slot8 in ipairs(slot2.itemIndexes_) do
			if slot3 and slot3 == slot2[slot8].id then
				slot0.itemToSelect_ = slot7

				break
			end
		end

		if slot0.itemToSelect_ == nil and slot0.params_.childShopIndex then
			slot0.itemToSelect_ = slot0.params_.childShopIndex
		end

		slot0.tree_:SelectGroup(slot0.currentGroupIndex_)

		if slot3 and slot0.params_.goodId_ then
			if ShopTools.IsGoodCanBuyInShop(slot3, slot0.params_.goodId_) and ShopTools.CheckSoldOut(slot4) == false then
				if ShopTools.CheckGiftSkinOwn(slot4) then
					ShowTips("ALREADY_GET")
				elseif ShopTools.IsPC() then
					ShowTips("PC_SHOP_TIPS2")
				else
					JumpTools.OpenPageByJump("rechargeGiftPopLink", {
						goodId = slot4,
						shopId = slot3
					})
				end
			else
				ShowTips("SELL_OUT")
			end

			slot0.params_.goodId_ = nil
		end

		slot0.params_.shopId_ = nil
	end
end

function slot0.CheckPageEnter(slot0, slot1)
	if not slot0.enteredPage_[slot1] then
		slot0.pages_[slot1]:OnEnter()

		slot0.enteredPage_[slot1] = true
	end
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()

	if slot0.currentGroupIndex_ ~= slot0.params_.page or slot0.currentItemIndex_ ~= slot0.params_.childShopIndex then
		slot0:SwitchPageByParams()
	end
end

function slot0.OnEnter(slot0)
	slot0.enteredPage_ = {}

	for slot4, slot5 in pairs(slot0.pages_) do
		slot0:CheckPageEnter(slot4)
	end

	slot0:RefreshTree()
	slot0:SwitchPageByParams()
	slot0:RegistEventListener(SHOP_BUY_SUCCESS, function (slot0, slot1)
		for slot5, slot6 in pairs(uv0.pages_) do
			if slot6 ~= nil and slot6.OnBuySuccess then
				slot6:OnBuySuccess(slot0, slot1)
			end
		end
	end)

	if slot0.pages_[slot0.shopListId_] and slot0.pages_[slot0.shopListId_].RefreshList then
		slot0.pages_[slot0.shopListId_]:RefreshList()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.pages_) do
		if slot5 ~= nil then
			slot5:OnExit()
		end
	end

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.BindRedPoint(slot0)
	slot4 = RedPointConst.TOTAL_CHARGE_BONUS

	manager.redPoint:bindUIandKey(slot0.totalRechargeNoticeContainer_, slot4)

	for slot4, slot5 in pairs(slot0.groups_) do
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

	slot0.updateTimer_ = Timer.New(function ()
		for slot3, slot4 in ipairs(uv0.titleList) do
			if slot3 <= #uv0.groupInfo.itemIndexes_ then
				slot5 = uv0.groupInfo[uv0.groupInfo.itemIndexes_[slot3]].id

				SetActive(uv0["newGo" .. slot3 .. "_"], uv0:CheckShopRedPoint(slot5))
				SetActive(uv0["redGo" .. slot3 .. "_"], uv0:SpecialShop(slot5))
			end
		end

		for slot3, slot4 in pairs(uv0.groups_) do
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

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.totalRechargeNoticeContainer_, RedPointConst.TOTAL_CHARGE_BONUS, {
		x = 0,
		y = 0
	})

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.OnShopBuyResult(slot0, slot1, slot2, slot3, slot4)
	if slot0.pages_[uv0] then
		slot0.pages_[uv0]:OnShopBuyResult(slot1, slot2, slot3, slot4)
	end
end

function slot0.SpecialShop(slot0, slot1)
	if ShopConst.PC_LOCK_SHOP[slot1] == true and ShopTools.IsPC() then
		return false
	end

	if ShopConst.SHOP_ID_TO_RED_CONST[slot1] then
		return manager.redPoint:getTipValue(ShopConst.SHOP_ID_TO_RED_CONST[slot1]) >= 1
	end

	return false
end

function slot0.CheckShopRedPoint(slot0, slot1)
	return ShopData.GetRedPointData()[slot1] == true
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot4 = ItemCfg[slot2.use_item_list[1].item_id].param[1]

		getReward({
			{
				num = 1,
				id = slot4
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[slot4].hero)
		HeroAction.SkinAdd(slot4)
	else
		ShowTips(slot1.result)
	end
end

function slot0.HaveActivityGift(slot0)
	for slot5, slot6 in ipairs(getShopIDListByShopID(ShopConst.SHOP_ID.LIMIT_SUPPLY)) do
		if not ShopData.IsGoodOutOfDate(slot6, ShopConst.SHOP_ID.LIMIT_SUPPLY) then
			return true
		end
	end

	return false
end

function slot0.HaveNewbieGift(slot0)
	for slot6, slot7 in pairs(ShopData.GetShop(ShopConst.SHOP_ID.NEWBIE_SHOP).shopItemIDs) do
		if ShopTools.IsGoodCanDisplay(slot1, slot7) and not ShopData.IsSoldout(slot1, slot7) then
			return true
		end
	end

	return false
end

function slot0.OnMainHomeViewTop(slot0)
	slot0.params_.childShopIndex = 1
	slot0.params_.page = 1
end

function slot0.Dispose(slot0)
	slot0.firstRechargeGroupGoList_ = nil

	if slot0.tree_ then
		slot0.tree_:Dispose()

		slot0.tree_ = nil
	end

	for slot4, slot5 in ipairs(slot0.titleList) do
		slot5:Dispose()
	end

	if slot0.pages_ then
		for slot4, slot5 in pairs(slot0.pages_) do
			slot5:Dispose()
		end

		slot0.pages_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshFirstRechargeGroup(slot0)
	slot0.firstRechargeGroupGoList_ = {
		slot0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.SIX_SHOP),
		slot0.tree_:GetGroupGameObjectById(ShopConst.SHOP_ID.EIGHT_SHOP)
	}
	slot4 = ShopConst.SHOP_ID.OBSERVATION_SHOP
	slot0.firstRechargeGroupGoList_[3] = slot0.tree_:GetGroupGameObjectById(slot4)

	for slot4, slot5 in ipairs(slot0.firstRechargeGroupGoList_) do
		SetActive(slot5, ActivityNewbieTools.GetRechargeIsOpen(slot4))
	end

	if ActivityNewbieTools.GetFirstRechargeStatus() and slot1.firstGearStatus == 2 then
		slot0.tree_:GetData().groupDatas[5].defaultIndex = 1
	end
end

function slot0.GetTreeDataByParams(slot0)
	slot1 = {}

	if slot0.params_.showShops then
		slot1 = slot0.params_.showShops
	else
		for slot6, slot7 in ipairs(ShopListCfg.get_id_list_by_system[2]) do
			if ShopListCfg[slot7].show_in_shop == 1 then
				table.insert(slot1, slot7)
			end
		end
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, slot7)
	end

	slot0.groups_ = {}
	slot0.groupIndexes_ = {}
	slot3 = UITreeData.New()

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.groups_[ShopListCfg[slot8].display_group] then
			slot0.groups_[slot9.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(slot0.groupIndexes_, slot9.display_group)
		end

		slot0.groups_[slot9.display_group][slot9.display_index] = slot9

		table.insert(slot0.groups_[slot9.display_group].itemIndexes_, slot9.display_index)
	end

	for slot7, slot8 in pairs(slot0.groups_) do
		table.sort(slot8.itemIndexes_, function (slot0, slot1)
			return slot0 < slot1
		end)
	end

	table.sort(slot0.groupIndexes_, function (slot0, slot1)
		return slot0 < slot1
	end)

	for slot7, slot8 in pairs(slot0.groupIndexes_) do
		slot9 = UITreeGroupData.New()
		slot9.text = GetI18NText(ShopListCfg.get_id_list_by_system_and_group[2][slot8][1].group_name)
		slot9.controllerStateValue = tostring(slot8)
		slot9.id = slot8

		slot3.groupDatas:Add(slot9)
	end

	return slot3
end

return slot0
