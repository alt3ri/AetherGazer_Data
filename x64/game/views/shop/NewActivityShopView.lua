slot0 = class("NewActivityShopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Shop/ActiveStoreUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, ExchangeItemView)
	slot0.stateController = slot0.controller_:GetController("state")
	slot0.titleTogList = {
		RechargeTitleItem.New(slot0.tag01_),
		RechargeTitleItem.New(slot0.tag02_),
		RechargeTitleItem.New(slot0.tag03_)
	}
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData(slot0.shopDataList[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(SHOP_LIST_UPDATE, function (slot0)
		if slot0 == 0 or uv0.curShopId_ == slot0 then
			uv0:UpdateShopList(uv0.curShopId_)
		end
	end)
	slot0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function (slot0)
		uv0.needKeepPos1 = true

		uv0:UpdateShopList(uv0.curShopId_)
	end)
	slot0:RegistEventListener(SHOP_ITEM_UPDATE, function (slot0, slot1)
		if uv0.curShopId_ ~= slot0 then
			return
		end

		uv0.needKeepPos1 = true

		uv0:UpdateShopList(uv0.curShopId_)
	end)
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if getShopIDListByCurrency(slot0) ~= nil and #slot1 > 0 then
			uv0.needKeepPos1 = true

			uv0:UpdateShopList(uv0.curShopId_, true)
		end
	end)
	slot0:RegistEventListener(MATERIAL_MODIFY, function (slot0)
		if getShopIDListByCurrency(slot0) ~= nil and #slot1 > 0 then
			uv0.needKeepPos1 = true

			uv0:UpdateShopList(uv0.curShopId_)
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:InitShopByParams()
	slot0:UpdateViewByParams()
	slot0:UpdateTitle()
	slot0:AddEventListeners()
	slot0:SetTimer()
end

function slot0.OnTop(slot0)
	if slot0.params_.shopId == slot0.curShopId_ then
		slot0:UpdateBarByShopId(slot0.curShopId_)

		return
	end

	slot0.curShopId_ = slot0.params_.shopId

	if slot0.curShopId_ ~= nil then
		slot0.needKeepPos1 = true

		slot0:UpdateViewByParams()
	end
end

function slot0.UpdateTitle(slot0)
	slot0.groupInfo = slot0.groups[slot0.groupIndexes[1]]

	for slot5, slot6 in ipairs(slot0.titleTogList) do
		if slot5 <= #slot0.groupInfo.itemIndexes_ then
			SetActive(slot6.gameObject_, true)
			slot6:SetData(slot0.groupInfo[slot0.groupInfo.itemIndexes_[slot5]], slot5, handler(slot0, slot0.ClickTitle), slot0.groupInfo[slot0.groupInfo.itemIndexes_[slot5]].id)
		else
			SetActive(slot6.gameObject_, false)
		end
	end

	if #ShopListCfg[slot0.groupInfo[slot0.groupInfo.itemIndexes_[1]].id].shop_label >= 1 then
		slot0.stateController:SetSelectedState("true")
	else
		slot0.stateController:SetSelectedState("false")
	end

	for slot6 = 1, 2 do
		SetActive(slot0["line" .. slot6 .. "Go_"], slot6 < #slot0.groupInfo.itemIndexes_)
	end

	if slot0.currentGroupIndex_ == 1 then
		slot0:ClickTitle(slot0.itemToSelect_ or slot0.currentItemIndex_)
	else
		slot0:ClickTitle(slot0.itemToSelect_ or 1)
	end
end

function slot0.ClickTitle(slot0, slot1)
	slot2 = slot0.groupInfo[slot0.groupInfo.itemIndexes_[slot1]].id
	slot8 = slot2

	SetActive(slot0.lockGo_, not ShopTools.CheckShopIsUnLock(slot8))

	slot0.lockDescTxt_.text = ShopTools.GetShopIsUnLockDesc(slot2)
	slot0.currentItemIndex_ = slot1
	slot7 = ShopListCfg[slot2].remark
	slot0.titleTxt_.text = GetI18NText(slot7)

	for slot7, slot8 in ipairs(slot0.titleTogList) do
		slot8.controller:SetSelectedState(slot7 == slot1 and "false" or "true")
	end

	slot0.roleBg_.sprite = getSpriteWithoutAtlas(slot3.shop_background)

	slot0:UpdateBarByShopId(slot2)

	slot0.params_.shopId = slot2

	slot0:UpdateShopList(slot2)
end

function slot0.UpdateViewByParams(slot0)
	slot0:GetTreeDataByParams()

	if next(slot0.groupIndexes) == nil then
		return
	end

	if slot0.params_.goodId and ShopTools.IsGoodCanBuy(slot0.curShopId_, slot1) then
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

	for slot6, slot7 in ipairs(slot2) do
		if not slot0.groups[ShopListCfg[slot7].display_group] then
			slot0.groups[slot8.display_group] = {
				itemIndexes_ = {}
			}

			table.insert(slot0.groupIndexes, slot8.display_group)
		end

		slot0.groups[slot8.display_group][slot8.display_index] = slot8

		table.insert(slot0.groups[slot8.display_group].itemIndexes_, slot8.display_index)
	end

	for slot6, slot7 in pairs(slot0.groups) do
		table.sort(slot7.itemIndexes_, function (slot0, slot1)
			return slot0 < slot1
		end)
	end

	table.sort(slot0.groupIndexes, function (slot0, slot1)
		return slot0 < slot1
	end)
end

function slot0.InitShopByParams(slot0)
	slot2 = slot0.params_.shopId

	if slot0.params_.goodId then
		slot0.curShopId_ = ShopListCfg[getShopCfg(slot1).shop_id].id
	else
		slot0.curShopId_ = tonumber(slot2 or 2)
	end

	slot0.currentGroupIndex_ = ShopListCfg[slot0.curShopId_].display_group
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

	manager.windowBar:RegistHomeCallBack(function ()
		gameContext:Go("/home", nil, , true)
	end)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.Back()
	end)
end

function slot0.UpdateShopList(slot0, slot1)
	slot0.curShopId_ = slot1
	slot0.shopDataList = ShopTools.FilterShopDataList(slot0.curShopId_, ShopListCfg[slot1].chain_last_visible == 1)

	if slot0.needKeepPos1 then
		slot0.pos = slot0.list:GetScrolledPosition()
	else
		slot0.pos = nil
	end

	slot0.list:StartScrollWithoutAnimator(#slot0.shopDataList, slot0.pos)

	slot0.needKeepPos1 = nil

	slot0:UpdateBarByShopId(slot0.curShopId_)
	slot0:UpdateTimer()
end

function slot0.UpdateTimer(slot0)
	slot1, slot2 = ShopTools.IsShopOpen(slot0.curShopId_)
	slot0.remainTimeTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(ShopListCfg[slot0.curShopId_].activity_id).stopTime))
end

function slot0.SetTimer(slot0)
	if not ShopConst.NEED_HIDE_TIME[slot0.curShopId_] then
		SetActive(slot0.timebgGo_, true)
		slot0:StopTimer()
		slot0:UpdateTimer()

		slot0.refreshTimer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, leftTime, 1)

		slot0.refreshTimer_:Start()
	else
		SetActive(slot0.timebgGo_, false)
	end
end

function slot0.OnExit(slot0)
	slot3 = slot0.list
	slot5 = slot3

	for slot4, slot5 in pairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()

	slot0.params_.hideHomeBtn = nil

	slot0:StopTimer()
	slot0:RemoveAllEventListener()
end

function slot0.StopTimer(slot0)
	if slot0.refreshTimer_ then
		slot0.refreshTimer_:Stop()

		slot0.refreshTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	for slot4, slot5 in ipairs(slot0.titleTogList) do
		slot5:Dispose()
	end

	slot0:RemoveAllListeners()

	slot0.curShopId_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
