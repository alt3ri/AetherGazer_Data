slot0 = class("StoreView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Bag/BagUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, CommonItemView)
	slot0.showEquipController_ = slot0.controllerEx_:GetController("equip")
	slot0.showNothingController_ = slot0.controllerEx_:GetController("nothing")
	slot0.equipPositionController_ = slot0.equipPositionControllerEx_:GetController("tab")
	slot0.leftBtnList_ = {
		[StoreConst.STORE_TYPE.MATERIAL] = StoreBtnView.New(slot0.materialGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.MATERIAL),
		[StoreConst.STORE_TYPE.HERO_PIECE] = StoreBtnView.New(slot0.heroPieceGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.HERO_PIECE),
		[StoreConst.STORE_TYPE.EQUIP] = StoreBtnView.New(slot0.equipGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.EQUIP),
		[StoreConst.STORE_TYPE.GIFT] = StoreBtnView.New(slot0.giftGo_, CommonBtnTypeConst.STORE, StoreConst.STORE_TYPE.GIFT)
	}
	slot0.OnSwitchStoreTypeHandler_ = handler(slot0, slot0.OnSwitchStoreType)
	slot0.OnSwitchSortEquipHandler_ = handler(slot0, slot0.OnSwitchSortEquip)
	slot0.OnSwitchSortEquipRareHandler_ = handler(slot0, slot0.OnSwitchSortEquipRare)
	slot0.OnMaterialUpdateHandler_ = handler(slot0, slot0.OnMaterialUpdate)
	slot0.OnMaterialListUpdateHandler_ = handler(slot0, slot0.OnMaterialListUpdate)
	slot0.OnEquipListUpdateHandler_ = handler(slot0, slot0.OnEquipListUpdate)
	slot0.OnEquipLockUpdateHandler_ = handler(slot0, slot0.OnEquipLockUpdate)
	slot0.OnEquipFilterUpdateHandler_ = handler(slot0, slot0.OnEquipFilterUpdate)
	slot0.OnMaterialExpriedHandler_ = handler(slot0, slot0.CheckExpiredList)
	slot0.storeItemInfoView_ = StoreItemInfo.New(slot0.itemInfoGo_)
	slot0.storeEquipInfoView_ = StoreEquipInfo.New(slot0.equipInfoGo_)
	slot0.storeEquipFilterPanel_ = StoreEquipFilterPanel.New(slot0.equipFilterGo_)

	slot0:InitEquipFilterParams()
end

function slot0.OnEnter(slot0)
	slot0:CheckExpiredList()
	manager.notify:RegistListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchStoreTypeHandler_)
	manager.notify:RegistListener(SWITCH_SORT, slot0.OnSwitchSortEquipHandler_)
	manager.notify:RegistListener(SWITCH_SORT_RARE, slot0.OnSwitchSortEquipRareHandler_)
	manager.notify:RegistListener(CURRENCY_UPDATE, slot0.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_MODIFY, slot0.OnMaterialUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_LIST_UPDATE, slot0.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(FUKUBURO_LIST_UPDATE, slot0.OnMaterialListUpdateHandler_)
	manager.notify:RegistListener(EQUIP_LIST_UPDATE, slot0.OnEquipListUpdateHandler_)
	manager.notify:RegistListener(EQUIP_LOCK, slot0.OnEquipLockUpdateHandler_)
	manager.notify:RegistListener(EQUIP_FILTER_SELECT_APPLY, slot0.OnEquipFilterUpdateHandler_)
	manager.notify:RegistListener(MATERIAL_EXPIRED, slot0.OnMaterialExpriedHandler_)

	if slot0.params_.isBack then
		slot0.selectStoreType_ = slot0.selectStoreType_ or slot0.params_.type or StoreConst.STORE_TYPE.MATERIAL
		slot0.params_.type = nil
	else
		slot0.lastPosition_ = nil
		slot0.selectID_ = nil
		slot0.selectIndex_ = 0
		slot0.selectStoreType_ = slot0.params_.type or StoreConst.STORE_TYPE.MATERIAL

		slot0:InitEquipFilterParams()
	end

	slot0:RefreshData()

	if slot0.params_.isBack then
		slot0:RevertLastSelectIndex()
	end

	slot0:RefreshUI(slot0.params_.isBack)

	slot0.params_.isBack = false

	slot0.storeItemInfoView_:OnEnter()
	slot0.storeEquipInfoView_:OnEnter()
	slot0:StartTimer()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()

	if slot0.params_.type and slot0.selectStoreType_ ~= slot0.params_.type then
		slot0.selectStoreType_ = slot0.params_.type
		slot0.lastPosition_ = nil
		slot0.selectID_ = nil
		slot0.selectIndex_ = 0

		slot0:RefreshData()
		slot0:RefreshUI()
	end
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(COMMON_BTN_TYPE_SWITCH, slot0.OnSwitchStoreTypeHandler_)
	manager.notify:RemoveListener(SWITCH_SORT, slot0.OnSwitchSortEquipHandler_)
	manager.notify:RemoveListener(SWITCH_SORT_RARE, slot0.OnSwitchSortEquipRareHandler_)
	manager.notify:RemoveListener(CURRENCY_UPDATE, slot0.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_MODIFY, slot0.OnMaterialUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_LIST_UPDATE, slot0.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(FUKUBURO_LIST_UPDATE, slot0.OnMaterialListUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_LIST_UPDATE, slot0.OnEquipListUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_LOCK, slot0.OnEquipLockUpdateHandler_)
	manager.notify:RemoveListener(EQUIP_FILTER_SELECT_APPLY, slot0.OnEquipFilterUpdateHandler_)
	manager.notify:RemoveListener(MATERIAL_EXPIRED, slot0.OnMaterialExpriedHandler_)

	slot0.lastPosition_ = slot0.uiList_:GetScrolledPosition()

	slot0.storeItemInfoView_:OnExit()
	slot0.storeEquipInfoView_:OnExit()
	slot0:StopTimer()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.OnSwitchStoreTypeHandler_ = nil
	slot0.OnSwitchSortEquipHandler_ = nil
	slot0.OnSwitchSortEquipRareHandler_ = nil
	slot0.OnMaterialUpdateHandler_ = nil
	slot0.OnMaterialListUpdateHandler_ = nil
	slot0.OnEquipListUpdateHandler_ = nil
	slot0.OnEquipLockUpdateHandler_ = nil
	slot0.OnEquipFilterUpdateHandler_ = nil
	slot0.OnMaterialExpriedHandler_ = nil

	slot0.storeEquipFilterPanel_:Dispose()

	slot0.storeEquipFilterPanel_ = nil

	slot0.storeItemInfoView_:Dispose()

	slot0.storeItemInfoView_ = nil

	slot0.storeEquipInfoView_:Dispose()

	slot0.storeEquipInfoView_ = nil

	for slot4, slot5 in ipairs(slot0.leftBtnList_) do
		slot5:Dispose()
	end

	slot0.leftBtnList_ = nil

	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
end

function slot0.AddListeners(slot0)
	for slot4 = 0, 6 do
		slot0:AddBtnListener(slot0[string.format("equipPositionBtn%s_", slot4)], nil, function ()
			if uv0.equipFilterParams_.position == uv1 then
				return
			end

			uv0.equipFilterParams_.position = uv1

			uv0.equipPositionController_:SetSelectedState(tostring(uv1))
			uv0:RefreshData()
			uv0:RefreshUI()
		end)
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot0.CheckExpiredList(slot0)
	slot2 = CurrencyData:CheckExpiredCurrencyList()

	for slot8, slot9 in ipairs(MaterialData:CheckExpiredMaterialList()) do
		if not table.keyof(slot0:GetHideItemList(), slot9.id) then
			table.insert({}, slot9)
		end
	end

	for slot8, slot9 in ipairs(slot2) do
		if not table.keyof(slot3, slot9.id) then
			table.insert(slot4, slot9)
		end
	end

	if #slot4 > 0 then
		JumpTools.OpenPageByJump("bagExpired", {
			expiredList = slot4
		})
		MaterialAction.ReadExpiredMaterial()
		CurrencyAction.ReadExpiredCurrency()

		return true
	end

	return false
end

function slot0.OnSwitchStoreType(slot0, slot1, slot2)
	if slot1 ~= CommonBtnTypeConst.STORE then
		return
	end

	if slot0.selectStoreType_ ~= slot2 then
		slot0.selectStoreType_ = slot2
		slot0.selectIndex_ = 1

		slot0:RefreshData()
		slot0:RefreshUI()
	end
end

function slot0.OnSwitchSortEquip(slot0)
	if slot0.equipFilterParams_.order == ItemConst.SORT_TYPE.DOWN then
		slot0.equipFilterParams_.order = ItemConst.SORT_TYPE.UP
	else
		slot0.equipFilterParams_.order = ItemConst.SORT_TYPE.DOWN
	end

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnSwitchSortEquipRare(slot0, slot1)
	if slot0.equipFilterParams_.priority ~= slot1 then
		if slot1 == 0 then
			slot0.equipFilterParams_.priority = EquipConst.EQUIP_SORT.LEVEL
		else
			slot0.equipFilterParams_.priority = EquipConst.EQUIP_SORT.RARE
		end
	end

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnMaterialUpdate(slot0, slot1, slot2, slot3)
	if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
		return
	end

	if slot0.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL and slot0.selectStoreType_ ~= StoreConst.STORE_TYPE.GIFT then
		return
	end

	for slot7, slot8 in pairs(slot0.itemList_) do
		if slot8.id == slot1 and slot8.timeValid == slot2 then
			slot8.number = slot3
		end
	end

	slot0:RefreshSelectItem()
end

function slot0.OnMaterialListUpdate(slot0)
	if slot0.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL and slot0.selectStoreType_ ~= StoreConst.STORE_TYPE.GIFT then
		return
	end

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnEquipListUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.OnEquipLockUpdate(slot0, slot1)
	if slot0.selectStoreType_ ~= StoreConst.STORE_TYPE.EQUIP then
		return
	end

	for slot8, slot9 in pairs(slot0.uiList_:GetItemList()) do
		if slot9:GetData().equip_id == slot1.equipID then
			slot9:RefreshEquipLock(slot1.lock)
		end
	end

	for slot8, slot9 in pairs(slot0.itemList_) do
		if slot9.equip_id == slot2 then
			slot9.equipedLocked = slot3
		end
	end
end

function slot0.OnEquipFilterUpdate(slot0, slot1)
	slot0.equipFilterParams_.suit = clone(slot1.suitList)
	slot0.equipFilterParams_.skill = clone(slot1.skillList)

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:RefreshTimeTag()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.UpdateTimer(slot0)
	slot0:RefreshTimeTag()

	if slot0.selectStoreType_ ~= StoreConst.STORE_TYPE.MATERIAL then
		return
	end

	for slot5, slot6 in pairs(slot0.uiList_:GetItemList()) do
		slot6:RefreshCountdown(slot6:GetData())
	end
end

function slot0.RefreshTimeTag(slot0)
	slot2 = manager.time:GetServerTime()

	for slot7, slot8 in ipairs(slot0.materialList_ or {}) do
		if ItemTools.GetItemExpiredTimeByInfo(slot8) > 0 then
			if nil == nil then
				slot1 = slot9
			elseif slot9 < slot1 then
				slot1 = slot9
			end
		end
	end

	if not slot1 then
		SetActive(slot0.timeGo_, false)

		return
	end

	slot0.timeText_.text = ItemTools.GetItemCountdownText(slot1)

	SetActive(slot0.timeGo_, true)
end

function slot0.UpdatePageItemDataList(slot0)
	slot0.itemList_ = {}
	slot0.materialList_ = clone(slot0:GetMaterialDataList())

	if slot0.selectStoreType_ == StoreConst.STORE_TYPE.MATERIAL then
		slot0.itemList_ = slot1
	elseif slot0.selectStoreType_ == StoreConst.STORE_TYPE.HERO_PIECE then
		slot0.itemList_ = slot0:GetHeroPieceData()
	elseif slot0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		slot0.itemList_ = slot0:GetEquipData()
	elseif slot0.selectStoreType_ == StoreConst.STORE_TYPE.GIFT then
		slot0.itemList_ = slot0:GetGiftData()
	end
end

function slot0.InitEquipFilterParams(slot0)
	slot0.equipFilterParams_ = {
		position = 0,
		order = ItemConst.SORT_TYPE.DOWN,
		priority = EquipConst.EQUIP_SORT.LEVEL,
		suit = {},
		skill = {}
	}
end

function slot0.GetMaterialDataList(slot0)
	slot1 = StoreTools.getMaterialList()

	table.sort(slot1, function (slot0, slot1)
		slot2 = ItemCfg[slot0.id]
		slot3 = ItemCfg[slot1.id]

		if ItemTools.GetItemExpiredTimeByInfo(slot0) == ItemTools.GetItemExpiredTimeByInfo(slot1) then
			if slot2.use == slot3.use then
				if slot2.type == ItemConst.ITEM_TYPE.CURRENCY and slot3.type ~= ItemConst.ITEM_TYPE.CURRENCY then
					return true
				elseif slot2.type ~= ItemConst.ITEM_TYPE.CURRENCY and slot3.type == ItemConst.ITEM_TYPE.CURRENCY then
					return false
				elseif slot2.rare == slot3.rare then
					return slot3.id < slot2.id
				else
					return slot3.rare < slot2.rare
				end
			else
				return slot3.use < slot2.use
			end
		elseif slot4 ~= 0 and slot5 ~= 0 then
			return slot4 < slot5
		elseif slot5 == 0 then
			return true
		else
			return false
		end
	end)

	return slot1
end

function slot0.GetHideItemList(slot0)
	return {
		InviteData:GetDataByPara("drawItemId")
	}
end

function slot0.GetHeroPieceData(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(HeroData:GetHeroList()) do
		if slot6.piece > 0 then
			slot7 = clone(ItemTemplateData)
			slot7.id = ItemCfg[slot6.id].fragment
			slot7.number = slot6.piece

			table.insert(slot1, slot7)
		end
	end

	table.sort(slot1, function (slot0, slot1)
		if ItemCfg[slot0.id].rare == ItemCfg[slot1.id].rare then
			return slot3.id < slot2.id
		else
			return slot3.rare < slot2.rare
		end
	end)

	return slot1
end

function slot0.GetEquipData(slot0)
	slot1 = {}
	slot7 = slot0.equipFilterParams_.suit
	slot8 = slot0.equipFilterParams_.skill
	slot3 = HeroTools.GetEquipMap(HeroData:GetHeroList())

	for slot7, slot8 in pairs(EquipData:GetEquipListComplex(slot0.equipFilterParams_.order, slot0.equipFilterParams_.priority, slot0.equipFilterParams_.position, slot7, slot8)) do
		slot9 = clone(ItemTemplateData)
		slot9.id = slot8.prefab_id
		slot9.equipLevel = EquipTools.CountEquipLevel(slot8)
		slot9.equip_id = slot8.equip_id
		slot9.equipEnchantCount = slot8:GetEnchantCount()

		if slot8.race == 0 or table.keyof(RaceEffectCfg.all, slot11) ~= nil then
			slot9.race = slot8.race or 0
			slot9.bindHeroID = 0
		else
			slot9.race = HeroCfg[slot11].race or 0
			slot9.bindHeroID = slot12
		end

		slot9.equipedLocked = slot8.is_lock or false
		slot9.equipedHeroID = slot3[slot8.equip_id] ~= nil and slot3[slot8.equip_id] or 0

		table.insert(slot1, slot9)
	end

	return slot1
end

function slot0.GetGiftData(slot0)
	slot2 = 30011
	slot6 = ItemConst.ITEM_TYPE.ARCHIVE_GIFT

	for slot6, slot7 in pairs(StoreTools.GetMaterialListByTypes({
		slot6
	})) do
		if slot7.num > 0 then
			slot8 = clone(ItemTemplateData)
			slot8.id = slot7.id
			slot8.number = slot7.num

			table.insert({}, slot8)
		end
	end

	if ItemTools.getItemNum(slot2) > 0 then
		slot3 = clone(ItemTemplateData)
		slot3.id = slot2
		slot3.number = ItemTools.getItemNum(slot2)

		table.insert(slot1, slot3)
	end

	table.sort(slot1, function (slot0, slot1)
		slot2 = ItemCfg[slot0.id]
		slot3 = ItemCfg[slot1.id]

		if slot0.id == uv0 and slot1.id ~= uv0 or slot0.id ~= uv0 and slot1.id == uv0 then
			return math.abs(slot0.id - uv0) < math.abs(slot1.id - uv0)
		end

		if slot2.rare == slot3.rare then
			return slot3.id < slot2.id
		else
			return slot3.rare < slot2.rare
		end
	end)

	return slot1
end

function slot0.RefreshData(slot0)
	slot0:UpdatePageItemDataList()
end

function slot0.RefreshUI(slot0, slot1)
	slot0:SetSelectItemIndex(slot0.selectIndex_ or 1)
	slot0:SwitchEquipPanel()

	if slot0.lastPosition_ ~= nil then
		slot0.uiList_:StartScrollByPosition(#slot0.itemList_, slot0.lastPosition_)

		slot0.lastPosition_ = nil
	else
		slot0.uiList_:StartScroll(#slot0.itemList_, slot0.selectIndex_)
	end

	slot0:RefreshEmptyPanel()
	slot0:RefreshStoreBtn()
	slot0:RefreshSelectItem(slot1)
end

function slot0.RefreshEmptyPanel(slot0)
	if #slot0.itemList_ <= 0 then
		slot0.showNothingController_:SetSelectedState("true")

		if slot0.selectStoreType_ == StoreConst.STORE_TYPE.MATERIAL then
			OperationRecorder.Record("BagView", "material")

			slot0.nothingText_.text = GetTips("NO_MATERIAL")
		elseif slot0.selectStoreType_ == StoreConst.STORE_TYPE.HERO_PIECE then
			OperationRecorder.Record("BagView", "qingbao")

			slot0.nothingText_.text = GetTips("NO_HERO_PIECE")
		elseif slot0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
			OperationRecorder.Record("BagView", "equip")

			slot0.nothingText_.text = GetTips("NO_EQUIP")
		elseif slot0.selectStoreType_ == StoreConst.STORE_TYPE.GIFT then
			OperationRecorder.Record("BagView", "gift")

			slot0.nothingText_.text = GetTips("NO_GIFT")
		end
	else
		slot0.showNothingController_:SetSelectedState("false")
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot0.itemList_[slot1].clickFun = function (slot0)
		OperationRecorder.Record("NewBagView", "bag_qingbao_item")
		uv0:SetSelectItemIndex(uv1)
		uv0:RefreshSelectItem()
	end

	slot0.itemList_[slot1].need_count_down = true

	slot2:SetData(slot0.itemList_[slot1])
end

function slot0.RevertLastSelectIndex(slot0)
	if slot0.selectID_ == nil then
		return
	end

	for slot4, slot5 in pairs(slot0.itemList_) do
		if slot0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
			if slot5.equip_id == slot0.selectID_ then
				if slot0.selectIndex_ ~= slot4 then
					slot0.lastPosition_ = nil
					slot0.selectIndex_ = slot4
				end

				return
			end
		elseif slot5.id == slot0.selectID_ then
			if slot0.selectIndex_ ~= slot4 then
				slot0.lastPosition_ = nil
				slot0.selectIndex_ = slot4
			end

			return
		end
	end

	slot0.selectIndex_ = 1
end

function slot0.SetSelectItemIndex(slot0, slot1)
	if slot1 > #slot0.itemList_ then
		slot1 = 1
	end

	if slot1 == 0 and #slot0.itemList_ > 0 then
		slot1 = 1
	end

	if #slot0.itemList_ <= 0 then
		slot1 = 0
	end

	slot0.selectIndex_ = slot1

	if slot1 == 0 then
		slot0.selectID_ = nil

		return
	end

	for slot5, slot6 in ipairs(slot0.itemList_) do
		if slot5 == slot1 then
			slot0.itemList_[slot5].selectStyle2 = true
		else
			slot0.itemList_[slot5].selectStyle2 = false
		end
	end

	if slot0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		slot0.selectID_ = slot0.itemList_[slot1].equip_id
	else
		slot0.selectID_ = slot0.itemList_[slot1].id
	end
end

function slot0.RefreshSelectItem(slot0, slot1)
	if slot0.selectIndex_ > #slot0.itemList_ or slot2 < 1 then
		return
	end

	if slot0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		slot0.storeEquipInfoView_:SetData(slot0.itemList_[slot2], slot1)
	else
		slot0.storeItemInfoView_:SetData(slot3, slot1)
	end

	for slot7, slot8 in pairs(slot0.uiList_:GetItemList()) do
		slot8:SetData(slot0.itemList_[slot7])
	end
end

function slot0.RefreshStoreBtn(slot0)
	for slot4, slot5 in pairs(slot0.leftBtnList_) do
		slot5:RefreshUI(slot0.selectStoreType_)
	end
end

function slot0.SwitchEquipPanel(slot0)
	if slot0.selectStoreType_ == StoreConst.STORE_TYPE.EQUIP then
		slot0.showEquipController_:SetSelectedState("true")
		slot0.storeEquipFilterPanel_:RefreshUI(slot0.equipFilterParams_, slot0.equipFilterParams_.position)
		slot0.equipPositionController_:SetSelectedState(tostring(slot0.equipFilterParams_.position))
	else
		slot0.showEquipController_:SetSelectedState("false")
	end
end

return slot0
