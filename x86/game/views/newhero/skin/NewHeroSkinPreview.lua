slot1 = class("NewHeroSkinPreview", import("game.views.newHero.skin.NewHeroSkinView"))

function slot1.UIName(slot0)
	return "Widget/System/Hero/HeroSkinUI_new"
end

function slot1.InitBtnState(slot0)
	slot0.btnState = {
		nil,
		nil,
		"btn_go",
		"sourcetext",
		nil,
		nil,
		"hero_donthave",
		"btn_now_shop",
		"hide",
		nil,
		nil,
		"pc_cant_rmb"
	}
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.portraitBtn_, nil, function ()
		if uv0.showDlcState_ == 1 then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = uv0.dlcID_
			})
		else
			uv0:Go("heroPortrait", {
				skinID = uv0.skinID_
			})
		end
	end)
	slot0:AddBtnListener(slot0.replaceBtn_, nil, function ()
		HeroAction.SelectSkin(uv0.heroID_, uv0.skinID_)
		uv0:PlayVoice()
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		uv0.params_.skinID = uv0.skinID_
		slot0 = HeroTools.GetShopIdBySkinId(uv0.skinID_)

		if JumpTools.IsSystemLocked(501) then
			ShowTips(JumpTools.GetSystemLockedTip(501, slot1))
		elseif uv0.showDlcState_ == 1 then
			if uv0:CheckIsSpecial() == 0 then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = false,
					goodID = slot0,
					heroID = uv0.heroID_,
					skinID = uv0.skinID_
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			else
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = true,
					goodID = slot0,
					heroID = uv0.heroID_,
					skinID = uv0.skinID_
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			end
		else
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				onlySkin = true,
				goodID = slot0,
				heroID = uv0.heroID_,
				skinID = uv0.skinID_
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	end)
	slot0:AddBtnListener(slot0.pcRmbBtn_, nil, function ()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		if uv0.isCanUnlock_ then
			HeroAction.UnLockSkin(uv0.skinID_)
		end
	end)
	slot0:AddBtnListener(slot0.giftBtn_, nil, function ()
		if uv0:isUnlock(uv0.skinID_) then
			PlayerAction.ReceiveSkinGift(uv0.skinID_)
		else
			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = (SkinCfg[uv0.skinID_] or {}).gift or {}
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		uv0.params_.skinID = uv0.skinID_
		slot0 = 0
		slot2 = SkinTagCfg[uv0.skinID_].trial_activity
		slot3 = slot2[1]

		for slot7, slot8 in ipairs(slot2) do
			if ActivityData:GetActivityIsOpen(ActivitySkinTrialCfg[slot8].activity_id) then
				slot0 = slot9
				slot3 = slot8

				break
			end
		end

		SkinTrialData:SaveStageID(slot3)
		uv0:SaveRoute()
		uv0:Go("/sectionSelectHero", {
			activityID = slot0,
			section = slot1.trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
	slot0:AddBtnListener(slot0.plotBtn_, nil, function ()
		if not uv0.isOpenPlotTalk then
			uv0:IndexPlotItem()
			uv0.plotController_:SetSelectedState("on")
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.talkStateGo_.transform)

			uv0.isOpenPlotTalk = true
		else
			uv0.plotController_:SetSelectedState("off")

			uv0.isOpenPlotTalk = false
		end
	end)

	slot4 = nil

	function slot5()
		uv0.plotController_:SetSelectedState("off")

		uv0.isOpenPlotTalk = false
	end

	slot0:AddBtnListener(slot0.plotTalkMaskBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(slot0.descBtn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			uv0:ShowMessage()
		end)
	end

	slot0:AddBtnListener(nil, slot0.hideMessageBtn_, function ()
		uv0:HideMessage()
		SetActive(uv0.hideMessageGo_, false)
	end)
	slot0:AddBtnListener(nil, slot0.dlc_skinBtn_, function ()
		uv0.showDlc_ = false

		uv0:ChangeShowDlcState(0)
	end)
	slot0:AddBtnListener(nil, slot0.dlc_dlcBtn_, function ()
		if uv0.dlcID_ and getShopCfg(uv0.dlcID_) and (slot0.give_id or slot0.description) then
			OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. slot1)
		end

		uv0.showDlc_ = true

		uv0:ChangeShowDlcState(1)
	end)
	slot0:AddBtnListener(nil, slot0.buyDlcBtn_, function ()
		uv0.params_.skinID = uv0.skinID_
		slot0 = HeroTools.GetShopIdBySkinId(uv0.skinID_)

		if JumpTools.IsSystemLocked(501) then
			ShowTips(JumpTools.GetSystemLockedTip(501, slot1))
		elseif getShopCfg(uv0.dlcID_) == nil then
			return
		elseif ShopConst.SHOP_ID.DLC_SHOP == slot2.shop_id then
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				goodID = slot0,
				heroID = uv0.heroID_,
				skinID = uv0.skinID_
			}, ViewConst.SYSTEM_ID.SHOP)
		else
			JumpTools.GoToSystem("/shop", {
				shopId = getShopCfg(uv0.dlcID_).shop_id
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	slot0:AddBtnListener(slot0.btn_dlcSpecialExchangeBtn_, nil, function ()
		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(getShopCfg(uv0.dlcID_).give_id)),
			OkCallback = function ()
				if uv0 then
					JumpTools.GoToSystem("/shop", {
						shopId = uv0.shop_id,
						goodId = uv0.goods_id
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0.scrollView_.onValueChanged:AddListener(function ()
		uv0:RefreshItemScale()
	end)
	slot0:AddBtnListener(slot0.switchInfoBtn_, nil, function ()
		if uv0.infoController_:GetSelectedState() == "tag" then
			uv0:SwitchInfoController("description")
		else
			uv0:SwitchInfoController("tag")
		end
	end)
end

function slot1.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot4 = ItemCfg[slot2.use_item_list[1].item_info.id].param[1]

		getReward({
			{
				num = 1,
				id = slot4
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[slot4].hero)
		HeroAction.SkinAdd(slot0.skinID_)
		slot0:SetButtonActive(8)
	else
		ShowTips(slot1.result)
	end

	slot0:RefreshUI()
end

function slot1.OnSelectSkin(slot0, slot1, slot2)
	slot0:SetButtonActive(8)
end

function slot1.CameraEnter(slot0)
	if not slot0.params_.isBack then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, slot0.displayGo_)
	elseif slot0.showDlcState_ == 1 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	else
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, slot0.displayGo_)
	end
end

function slot1.OnEnter(slot0)
	slot0.descList_ = {}
	slot0.showDlc_ = false

	if not slot0.params_.heroID then
		slot0.heroID_ = HeroSkinRouteData:GetRoute().heroID
	else
		slot0.heroID_ = slot0.params_.heroID
	end

	if not slot0.params_.isBack then
		if not slot0.params_.skinID then
			slot0.skinID_ = HeroTools.HeroUsingSkinInfo(slot0.heroID_).id
		else
			slot0.skinID_ = slot0.params_.skinID
		end
	end

	slot0.plotController_:SetSelectedState("off")

	slot0.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(slot0.skinID_)
	slot0:RefreshShop()
	slot0:RegistEventListener(GET_SKIN_GIFT, handler(slot0, slot0.OnGetSkinGift))
	slot0:RegistEventListener(RECHARGE_SUCCESS, function (slot0)
		uv0:RefreshUI()
	end)
	slot0:RefreshUI()

	if slot0.params_.isDlc then
		slot0:ChangeShowDlcState(1)
	elseif not slot0.params_.isBack then
		slot0:ChangeShowDlcState(0)
	else
		slot0:ChangeShowDlcState(slot0.showDlcState_)
	end

	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
	slot0:Scroll2SelectItem(100)
end

function slot1.RefreshShop(slot0)
	slot0:RefreshCurrencyToken(true)
end

function slot1.RefreshSkinItemList(slot0)
	if slot0.skinIdList_ and #slot0.skinIdList_ > 0 then
		for slot4, slot5 in pairs(slot0.skinItemList_) do
			slot5:SetActive(false)
		end

		for slot4, slot5 in ipairs(slot0.skinIdList_) do
			slot6 = nil

			if slot0.skinItemList_[slot4] then
				slot6 = slot0.skinItemList_[slot4]
			else
				slot6 = NewHeroSkinPreviewItem.New(slot0.itemGo_, slot0.contentTf_)

				table.insert(slot0.skinItemList_, slot6)
				slot6:SetDelegate(handler(slot0, slot0.RefreshButton))
			end

			slot6:Show(slot0.skinIdList_[slot4], slot4)
			slot6:ShowSelect(slot0.selectIndex_ == slot4)
			slot6:CheckDLC(slot0:JudgeDLC(slot0.skinIdList_[slot4]))
			slot6:SetActive(true)
		end
	end

	slot0:Scroll2SelectItem(5)
end

function slot1.RefreshUIWithOutScroll(slot0)
	slot0:RefreshInfo()
	slot0:RefreshCost()
	slot0:SetButtonActive(slot0:SkinState(slot0.skinID_))
end

function slot1.RefreshCost(slot0)
	SetActive(slot0.tokenPlusGo_, false)

	if getShopCfg(HeroTools.GetShopIdBySkinId(slot0.skinID_)) then
		slot2 = 0
		slot3 = 0
		slot4 = nil

		if (slot1.dlc or nil) and slot5 ~= 0 and getShopCfg(slot5) then
			slot2 = ShopTools.GetPrice(slot5)
		end

		if slot0:CheckIsSpecial() == 0 and slot0.showDlcState_ == 1 then
			SetActive(slot0.tokenPlusGo_, true)

			slot3 = ShopTools.GetPrice(slot1.goods_id, slot1.shop_id) + slot2
		end

		if slot1.cost_type == 1 then
			slot0.currencyImage_.sprite = nil
			slot0.currencyText_.text = ShopTools.GetMoneySymbol(slot1.goods_id) .. slot3

			SetActive(slot0.currencyGo_, false)
		else
			slot0.currencyImage_.sprite = ItemTools.getItemLittleSprite(slot1.cost_id)
			slot0.currencyText_.text = slot3

			SetActive(slot0.currencyGo_, true)
		end

		if slot2 and slot2 ~= 0 then
			if ShopTools.IsRMB(slot5) then
				slot0.dlccurrencyImage_.sprite = nil
				slot0.dlccurrencyText_.text = ShopTools.GetMoneySymbol(slot5) .. slot2

				SetActive(slot0.dlccurrencyGo_, false)
			else
				slot0.dlccurrencyImage_.sprite = ItemTools.getItemLittleSprite(slot1.cost_id)
				slot0.dlccurrencyText_.text = slot2

				SetActive(slot0.dlccurrencyGo_, true)
			end
		end
	end

	slot0:RefreshTokenNumText()
end

function slot1.RefreshButton(slot0, slot1)
	slot0.selectIndex_ = slot1.index_
	slot2 = slot1:SkinState()

	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. slot1.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)

	if slot1.skinID_ == slot0.skinID_ then
		slot0:Scroll2SelectItem(5)

		return
	end

	slot0.skinID_ = slot3

	slot0:ChangeShowDlcState(0)
	slot0:SetButtonActive(slot2)
	manager.heroRaiseTrack:SetModelState(slot0.skinID_)
	SetActive(slot0.plotBtn_, #SkinCfg[slot3].plot_title > 0)
	slot0.plotController_:SetSelectedState("off")

	slot0.isOpenPlotTalk = false

	slot0:RefreshInfo()
	slot0:RefreshCost()
	slot0:CheckDlc(slot3, slot2)
	slot0:RefreshDlcBtn()
	slot0:RefreshDescBtn()
	slot0:RefreshGiftBtn()
	slot0:HideMessage()
	slot0:RefreshUI()
	slot0:Scroll2SelectItem(5)
end

function slot1.UpdateBar(slot0)
	if slot0.btnState_ == 3 or slot0.dlcBtnController_:GetSelectedState() == "buyDlc" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId(),
			CurrencyConst.CURRENCY_TYPE_SKIN
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot1.SetButtonActive(slot0, slot1)
	slot0:CheckDlc(slot0.skinID_, slot1)

	if slot0:JudgeDLC(slot0.skinID_) then
		if not ShopTools.CheckDlcPurchased(slot0.dlcID_) then
			slot0.dlc_dlcController_:SetSelectedIndex(0)
		else
			slot0.dlc_dlcController_:SetSelectedIndex(1)
		end
	end

	if slot1 == 8 or slot1 == 7 and slot0.skinID_ ~= slot0.heroID_ or slot1 == 9 and slot0:CheckIsSpecial() then
		slot0.dlc_skinController_:SetSelectedIndex(1)
	else
		slot0.dlc_skinController_:SetSelectedIndex(0)
	end

	if slot0.btnState_ == slot1 then
		return
	end

	slot0.statusController_:SetSelectedIndex(slot1 - 1)

	slot0.btnState_ = slot1

	slot0:UpdateBar()
end

function slot1.ChangeShowDlcState(slot0, slot1)
	slot0.showDlcState_ = slot1

	slot0.dlcController_:SetSelectedIndex(slot1)

	if slot1 == 0 then
		slot0.dlc_skinBtn_.interactable = false
		slot0.dlc_dlcBtn_.interactable = true

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, slot0.displayGo_)
		slot0:PauseDlcMovie()
	elseif slot1 == 1 then
		slot0.dlc_skinBtn_.interactable = true
		slot0.dlc_dlcBtn_.interactable = false

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		slot0:RefreshDlcMovie()
	end

	slot0:RefreshCost()
	slot0:ChangeDlcBtn()
	slot0:RefreshInfo()
	slot0:SetButtonActive(slot0:SkinState(slot0.skinID_))
end

function slot1.SkinState(slot0, slot1)
	slot0:ChangeDlcBtn()

	if slot0:isUnlockOrCanChange(slot1) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[slot0.skinID_].hero) == false and slot0.skinID_ == SkinCfg[slot0.skinID_].hero then
			return 7
		end

		if slot0.showDlcState_ == 1 and not ShopTools.CheckDlcPurchased(slot0.dlcID_) then
			return 9
		end

		return 8
	else
		if HeroTools.IsSkinOutOfDate(slot1) then
			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB(HeroTools.GetShopIdBySkinId(slot0.skinID_)) then
			return 12
		end

		return 3
	end
end

function slot1.ChangeDlcBtn(slot0)
	slot0.dlcBtnController_:SetSelectedIndex(0)

	if slot0:CheckIsSpecial() == 1 then
		slot0:ChangeDlcBtnSpecial()

		return
	end

	if slot0:isUnlock(slot0.skinID_) and slot0:JudgeDLC(slot0.skinID_) and not ShopTools.CheckDlcPurchased(slot0.dlcID_) and ShopTools.CheckShopIsUnLock(getShopCfg(slot0.dlcID_).shop_id) and ShopTools.IsGoodCanDisplay(slot1.shop_id, slot1.goods_id) then
		slot0.dlcBtnController_:SetSelectedIndex(1)
	end
end

function slot1.RefreshTokenNumText(slot0)
	if ShopTools.IsPC() then
		SetActive(slot0.tokenNum1Go_, false)
		SetActive(slot0.tokenNum2Go_, false)

		return
	end

	if slot0:CheckIsSpecial() == 1 then
		SetActive(slot0.tokenNum1Go_, false)
		SetActive(slot0.tokenNum2Go_, false)

		return
	end

	if slot0.showDlcState_ == 1 and not slot0:isUnlock(slot0.skinID_) then
		SetActive(slot0.tokenNum1Go_, false)
		SetActive(slot0.tokenNum2Go_, true)

		return
	end

	if slot0.showDlcState_ == 0 and not slot0:isUnlockOrCanChange(slot0.skinID_) or slot0:isUnlockOrCanChange(slot0.skinID_) and not ShopTools.CheckDlcPurchased(slot0.dlcID_) then
		SetActive(slot0.tokenNum1Go_, true)
		SetActive(slot0.tokenNum2Go_, false)

		return
	end

	SetActive(slot0.tokenNum1Go_, false)
	SetActive(slot0.tokenNum2Go_, false)
end

function slot1.RefreshInfo(slot0)
	if slot0.showDlcState_ == 1 then
		if RechargeShopDescriptionCfg[getShopCfg(slot0.dlcID_).description] == nil then
			slot2 = ItemCfg[slot1.give_id]
		end

		slot0.nameText_.text = GetI18NText(string.format("%s", slot2.name))
		slot0.infoText_.text = GetI18NText(string.format("%s", slot2.desc))
	else
		slot0.nameText_.text = GetI18NText(SkinCfg[slot0.skinID_].name)
		slot0.infoText_.text = GetI18NText(SkinCfg[slot0.skinID_].desc)
	end

	slot0:CleanMessage()

	if HeroTools.GetSkinChangeItem(slot0.skinID_) then
		slot0.sourcetextText_.text = GetI18NText(ItemCfg[slot1].desc_source) or ""
		slot0.couponImg_.sprite = ItemTools.getItemLittleSprite(slot1)
	else
		slot0.sourcetextText_.text = GetI18NText(ItemCfg[slot0.skinID_].desc_source) or ""
	end

	slot0:RefreshLimitTime(slot0.skinID_)
end

function slot1.SaveRoute(slot0)
	SkinTrialData:SaveRoute({
		name = "heroSkinPreview",
		skinID = slot0.skinID_,
		heroID = slot0.heroID_
	})
end

return slot1
