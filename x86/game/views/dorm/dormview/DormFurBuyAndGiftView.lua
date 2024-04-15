slot0 = class("DormFurBuyAndGiftView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureInfoPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.heroScroll = LuaList.New(handler(slot0, slot0.indexHeroList), slot0.uilistGo_, DormCharacterItem)
	slot0.canBuyController = slot0.btn_okControllerexcollection_:GetController("default0")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.giveController = ControllerUtil.GetController(slot0.transform_, "given")
	slot0.commonItem_ = CommonItemView.New(slot0.commonitemGo_1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.furID = slot0.params_.furID
	slot0.furCfg = BackHomeFurniture[slot0.furID]
	slot0.state = slot0.params_.state
	slot0.params_.state = nil
	slot0.needNum = slot0.params_.needNum or 100
	slot0.params_.needNum = nil
	slot0.num = slot0.params_.defaultNum
	slot0.roomID = DormData:GetCurrectSceneID()

	slot0:RegisterEvents()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	slot0:RefreshView()
	slot0:RefreshBar()
end

function slot0.RefreshBar(slot0)
	if slot0.state == "gift" then
		manager.windowBar:HideBar()
	elseif slot0.state == "buy" then
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DORM_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetAsLastSibling()
	end
end

function slot0.RefreshView(slot0)
	slot0:RefreshFurInfo()

	if BackHomeFurniture[slot0.furID].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
		slot0:RefreshHeroList()
		slot0:RefreshGiftDesc()
	end

	slot0:RefreshBuyNum()

	if slot0.state == "gift" then
		slot0.stateController:SetSelectedState("gift")

		slot0.buyDesc.text = GetTips("DORM_CAN_GITF_NUM")
	elseif slot0.state == "buy" then
		slot0.stateController:SetSelectedState("buy")

		if slot1.is_give ~= DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			slot0.giveController:SetSelectedState("true")
			slot0:RefreshCantGiftFurInfo()

			slot0.buyDesc.text = GetTips("DORM_CAN_BUY_AND_GITF_NUM")
		else
			slot0.giveController:SetSelectedState("false")

			slot0.buyDesc.text = GetTips("DORM_CAN_BUY_NUM")
		end

		slot0:RefreshCurrencyItemList()

		slot3 = 1

		slot0:SelectCurrencyItemList(DormitoryData:GetBuyFurCurrencyID() == DormConst.DORM_CURRENCY_ID and 1 or 2)
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function ()
		JumpTools.Back()
	end)
	slot0:RegistEventListener(SHOP_BUY_SUCCESS, function ()
		DormitoryData:SetBuyFurCurrencyID(uv0.curItmeID)

		if uv0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			if HeroRecordCfg.get_id_list_by_hero_id[uv0.selHeroID][1] then
				DormAction:GiftFurToHero(slot0, {
					[uv0.furID] = uv0.progressSlr_.value
				})
			end
		else
			JumpTools.Back()
		end
	end)
end

function slot0.RefreshFurInfo(slot0)
	slot0.commonItem_:SetData({
		id = slot0.furID
	})

	slot0.holdNum.text = tostring(DormData:GetFurNumInfo(slot0.furID).num)
	slot0.titletextText_.text = ItemTools.getItemName(slot0.furID)
end

function slot0.SelectCurrencyItemList(slot0, slot1)
	slot0["item" .. slot1].isOn = true

	if slot1 == 1 then
		slot0.curItmeID = DormConst.DORM_CURRENCY_ID
	elseif slot1 == 2 then
		slot0.curItmeID = 1
	end

	slot0.singleCost, slot0.goodID = slot0:GetLowPriceByFurID(slot0.furID, slot0.curItmeID)
	slot0.chooseIconImg_.sprite = ItemTools.getItemSprite(slot0.curItmeID)

	slot0:SetfurNum(slot0.num or 1)
	slot0:RefreshCost()
end

function slot0.RefreshHeroList(slot0)
	slot0.heroList = {}

	if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		table.insert(slot0.heroList, DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot1)[1]):GetHeroId())
	else
		for slot6, slot7 in pairs(DormData:GetHeroInfoList()) do
			table.insert(slot0.heroList, DormData:GetHeroInfo(slot6):GetHeroId())
		end
	end

	CommonTools.UniversalSortEx(slot0.heroList, {
		ascend = true,
		map = function (slot0)
			if uv0.state == "gift" then
				if DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0)) then
					if DormData:GetHeroTemplateInfo(slot0):GetCanGiftNum(uv0.furID) > 0 then
						return 1
					else
						return 2
					end
				else
					return 3
				end
			elseif uv0.state == "buy" then
				if DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0)) then
					if DormData:GetHeroTemplateInfo(slot0):GetCanBuyAndGiftNum(uv0.furID) > 0 then
						return 1
					else
						return 2
					end
				else
					return 3
				end
			end
		end
	})

	slot0.selHeroID = slot0.heroList[1]

	slot0.heroScroll:StartScroll(#slot0.heroList)
end

function slot0.RefreshCurrencyItemList(slot0)
	slot1 = DormConst.DORM_CURRENCY_ID
	slot2 = 1
	slot0.cur1Text.text = ItemTools.getItemName(slot1)
	slot0.cur1icon.sprite = ItemTools.getItemSprite(slot1)
	slot0.cur2Text.text = ItemTools.getItemName(slot2)
	slot0.cur2icon.sprite = ItemTools.getItemSprite(slot2)
end

function slot0.RefreshBuyNum(slot0)
	if slot0.selHeroID then
		slot1 = DormData:GetHeroTemplateInfo(slot0.selHeroID)
		slot2 = slot1:GetGiftNum(slot0.furID)
		slot5 = BackHomeFurniture[slot0.furID].give_max

		if slot0.state == "gift" then
			if slot1:GetRoomID() then
				slot0.furNumMax = math.min(slot0.needNum, slot1:GetCanGiftNum(slot0.furID))
				slot0.progressSlr_.maxValue = slot0.furNumMax

				slot0:SetfurNum(slot0.furNumMax)
			else
				slot0.furNumMax = 0
				slot0.progressSlr_.maxValue = slot0.furNumMax

				slot0:SetfurNum(0)
			end
		elseif slot0.state == "buy" then
			if slot3 then
				slot0.furNumMax = math.min(slot0.needNum, slot5 - slot2)
				slot0.progressSlr_.maxValue = slot0.furNumMax

				slot0:SetfurNum(slot0.furNumMax)
			else
				slot0.furNumMax = 0
				slot0.progressSlr_.maxValue = slot0.furNumMax

				slot0:SetfurNum(slot0.furNumMax)
			end
		end
	else
		if slot0.state == "buy" and slot0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			slot0.furNumMax = slot0.needNum
		else
			slot0.furNumMax = 0
		end

		slot0.progressSlr_.maxValue = slot0.furNumMax
	end
end

function slot0.RefreshGiftDesc(slot0)
	slot0.descText.text = string.format(GetTips("DORM_FURNITURE_GIFT_CONFIRM"), ItemTools.getItemName(slot0.furID), HeroRecordCfg[DormData:GetHeroArchiveID(slot0.selHeroID)].name)
end

function slot0.RefreshCantGiftFurInfo(slot0)
	slot0.furTypeDesc.text = DormTools:GetFurGiftTypeDesc(slot0.furID)

	for slot6, slot7 in ipairs(BackHomeFurniture[slot0.furID].scene_id) do
		slot1 = "" .. DormTools:GetRoomTypeName(slot7) .. " "
	end

	slot0.sceneDesc.text = slot1
	slot0.giftMaxText.text = ""
	slot0.comfortDesc.text = tostring(BackHomeFurniture[slot0.furID].dorm_exp)
	slot0.furDesc.text = ItemTools.getItemDesc(slot0.furID)
end

function slot0.SetfurNum(slot0, slot1)
	slot1 = math.min(slot1, slot0.furNumMax)
	slot0.num = slot1
	slot0.numText_.text = slot1 .. "/" .. slot0.furNumMax
	slot0.progressSlr_.value = slot1

	if DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0.selHeroID)) then
		slot0.comfortText_.text = GetTips("DORM_FATIGUE_INFO") .. DormitoryData:GetDormExp(slot4) .. string.format("<color=#0089E2>+%d</color>", slot1 * BackHomeFurniture[slot0.furID].dorm_exp)
	else
		slot0.comfortText_.text = GetTips("DORM_FATIGUE_INFO") .. string.format("<color=#0089E2>+%d</color>", slot2)
	end

	if slot0.state == "buy" then
		slot0:RefreshCost()
	elseif slot0.state == "gift" then
		if (slot0.selHeroID and DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0.selHeroID)) or slot0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT) and slot0.num and slot0.num > 0 and slot0.furNumMax > 0 then
			slot0.canBuyController:SetSelectedState("on")
		else
			slot0.canBuyController:SetSelectedState("off")
		end
	end
end

function slot0.RefreshCost(slot0)
	slot1 = 0

	if slot0.singleCost then
		slot1 = slot0.singleCost * (slot0.num or 0)
	end

	slot0.curNumText_.text = tostring(slot1)
	slot2 = 0

	if slot0.curItmeID then
		slot2 = ItemTools.getItemNum(slot0.curItmeID)
	end

	if (slot0.selHeroID and DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0.selHeroID)) or slot0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT) and slot1 <= slot2 and slot0.num and slot0.num > 0 and slot0.furNumMax > 0 then
		slot0.canBuyController:SetSelectedState("on")
	else
		slot0.canBuyController:SetSelectedState("off")
	end
end

function slot0.GetLowPriceByFurID(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in ipairs(getGoodListByGiveID(slot1)) do
		if getShopCfg(slot9).cost_id == slot2 then
			table.insert(slot4, slot9)
		end
	end

	slot5, slot6 = nil

	for slot10, slot11 in ipairs(slot4) do
		slot12 = getShopCfg(slot11).shop_id

		if ShopTools.GetPrice(slot11, slot12) <= (slot6 or ShopTools.GetPrice(slot11, slot12)) then
			slot5 = slot11
		end

		math.min(ShopTools.GetPrice(slot11, slot12), slot6)
	end

	return slot6, slot5
end

function slot0.OnExit(slot0)
	slot0.selHeroID = nil

	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.AddUIListener(slot0)
	slot0:AddPressingByTimeListener(slot0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.furID and uv0.progressSlr_.value > 0 then
			uv0:SetfurNum(uv0.progressSlr_.value - 1)

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.addNumBtn_.gameObject, 3, 0.5, 0.5, function ()
		if uv0.furID and uv0.progressSlr_.value < uv0.furNumMax then
			uv0:SetfurNum(uv0.progressSlr_.value + 1)

			return true
		end

		return false
	end)
	slot0:AddToggleListener(slot0.progressSlr_, function ()
		if uv0.furID then
			uv0:SetfurNum(uv0.progressSlr_.value)
		end
	end)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		uv0:ClickShowTips()

		if uv0.state == "buy" then
			if uv0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
				if uv0.progressSlr_.value > 0 and uv0.goodID then
					if uv0.curItmeID == 1 then
						ShowMessageBox({
							isTop = true,
							content = GetTips("DORM_BUY_FURNITURE_BY_DIAMOND"),
							OkCallback = function ()
								ShopAction.BuyItem({
									{
										goodID = uv0.goodID,
										buyNum = uv0.progressSlr_.value
									}
								})
							end,
							CancelCallback = function ()
							end
						})
					else
						ShopAction.BuyItem({
							{
								goodID = uv0.goodID,
								buyNum = uv0.progressSlr_.value
							}
						})
					end
				end
			elseif uv0.selHeroID and uv0.progressSlr_.value > 0 and uv0.goodID and DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(uv0.selHeroID)) then
				if uv0.curItmeID == 1 then
					ShowMessageBox({
						isTop = true,
						content = GetTips("DORM_BUY_FURNITURE_BY_DIAMOND"),
						OkCallback = function ()
							ShopAction.BuyItem({
								{
									goodID = uv0.goodID,
									buyNum = uv0.progressSlr_.value
								}
							})
						end,
						CancelCallback = function ()
						end
					})
				else
					ShopAction.BuyItem({
						{
							goodID = uv0.goodID,
							buyNum = uv0.progressSlr_.value
						}
					})
				end
			end
		elseif uv0.state == "gift" and uv0.selHeroID and uv0.progressSlr_.value > 0 and uv0.furID then
			if HeroRecordCfg.get_id_list_by_hero_id[uv0.selHeroID][1] then
				DormAction:GiftFurToHero(slot0, {
					[uv0.furID] = uv0.progressSlr_.value
				})
			end
		end
	end)

	slot4 = nil

	slot0:AddBtnListener(slot0.bgMaskBtn_, slot4, function ()
		JumpTools.Back()
	end)

	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0["item" .. slot4], function (slot0)
			if slot0 then
				uv0:SelectCurrencyItemList(uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.btnviewBtn_, nil, function ()
		ShowPopItem(POP_ITEM, {
			uv0.furID,
			DormData:GetFurNumInfo(uv0.furID).num
		})
	end)
end

function slot0.indexHeroList(slot0, slot1, slot2)
	slot2:SetCanClickAndState(true, nil)
	slot2:ShowMaskCallBack(function (slot0)
		if not DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0)) then
			return true
		else
			if BackHomeFurniture[uv0.furID].give_max <= DormData:GetHeroTemplateInfo(slot0):GetGiftNum(uv0.furID) then
				return true
			end

			return false
		end
	end)
	slot2:OnPointerDown(function (slot0)
		if slot0 and BackHomeHeroCfg[slot0] then
			uv0.selHeroID = slot0

			uv0.heroScroll:Refresh()
			uv0:RefreshBuyNum()
			uv0:RefreshGiftDesc()

			if not DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0)) then
				ShowTips(GetTips("DORM_HERO_ROOM_LOCKED"))

				return
			elseif BackHomeFurniture[uv0.furID].give_max <= DormData:GetHeroTemplateInfo(slot0):GetGiftNum(uv0.furID) then
				ShowTips(GetTips("DORM_GIFT_MAX_TIPS"))
			end
		end
	end)
	slot2:SelCallBack(function (slot0, slot1, slot2)
		if slot0 == slot1 then
			slot2:SetSelectedState("select")
		else
			slot2:SetSelectedState("normal")
		end
	end)
	slot2:RefreshUI(slot0.heroList[slot1], slot0.selHeroID)
end

function slot0.ClickShowTips(slot0)
	if slot0.selHeroID then
		if not DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot0.selHeroID)) then
			ShowTips(GetTips("DORM_HERO_ROOM_LOCKED"))

			return false
		elseif BackHomeFurniture[slot0.furID].give_max <= DormData:GetHeroTemplateInfo(slot0.selHeroID):GetGiftNum(slot0.furID) then
			ShowTips(GetTips("DORM_GIFT_MAX_TIPS"))

			return false
		end

		return true
	end
end

function slot0.Dispose(slot0)
	if slot0.heroScroll then
		slot0.heroScroll:Dispose()
	end

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
