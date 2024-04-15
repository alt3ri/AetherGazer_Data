local var_0_0 = import("game.views.newHero.skin.NewHeroSkinView")
local var_0_1 = class("NewHeroSkinPreview", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero/HeroSkinUI_new"
end

function var_0_1.InitBtnState(arg_2_0)
	arg_2_0.btnState = {
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

function var_0_1.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.portraitBtn_, nil, function()
		if arg_3_0.showDlcState_ == 1 then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = arg_3_0.dlcID_
			})
		else
			arg_3_0:Go("heroPortrait", {
				skinID = arg_3_0.skinID_
			})
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.replaceBtn_, nil, function()
		HeroAction.SelectSkin(arg_3_0.heroID_, arg_3_0.skinID_)
		arg_3_0:PlayVoice()
	end)
	arg_3_0:AddBtnListener(arg_3_0.goBtn_, nil, function()
		arg_3_0.params_.skinID = arg_3_0.skinID_

		local var_6_0 = HeroTools.GetShopIdBySkinId(arg_3_0.skinID_)
		local var_6_1 = JumpTools.IsSystemLocked(501)

		if var_6_1 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_6_1))
		elseif arg_3_0.showDlcState_ == 1 then
			if arg_3_0:CheckIsSpecial() == 0 then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = false,
					goodID = var_6_0,
					heroID = arg_3_0.heroID_,
					skinID = arg_3_0.skinID_
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			else
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = true,
					goodID = var_6_0,
					heroID = arg_3_0.heroID_,
					skinID = arg_3_0.skinID_
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			end
		else
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				onlySkin = true,
				goodID = var_6_0,
				heroID = arg_3_0.heroID_,
				skinID = arg_3_0.skinID_
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.pcRmbBtn_, nil, function()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.unlockBtn_, nil, function()
		if arg_3_0.isCanUnlock_ then
			HeroAction.UnLockSkin(arg_3_0.skinID_)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.giftBtn_, nil, function()
		if arg_3_0:isUnlock(arg_3_0.skinID_) then
			PlayerAction.ReceiveSkinGift(arg_3_0.skinID_)
		else
			local var_9_0 = (SkinCfg[arg_3_0.skinID_] or {}).gift or {}

			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = var_9_0
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.battleBtn_, nil, function()
		arg_3_0.params_.skinID = arg_3_0.skinID_

		local var_10_0 = 0
		local var_10_1 = SkinTagCfg[arg_3_0.skinID_]
		local var_10_2 = var_10_1.trial_activity
		local var_10_3 = var_10_2[1]

		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			local var_10_4 = ActivitySkinTrialCfg[iter_10_1].activity_id

			if ActivityData:GetActivityIsOpen(var_10_4) then
				var_10_0 = var_10_4
				var_10_3 = iter_10_1

				break
			end
		end

		SkinTrialData:SaveStageID(var_10_3)
		arg_3_0:SaveRoute()
		arg_3_0:Go("/sectionSelectHero", {
			activityID = var_10_0,
			section = var_10_1.trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
	arg_3_0:AddBtnListener(arg_3_0.plotBtn_, nil, function()
		if not arg_3_0.isOpenPlotTalk then
			arg_3_0:IndexPlotItem()
			arg_3_0.plotController_:SetSelectedState("on")
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.talkStateGo_.transform)

			arg_3_0.isOpenPlotTalk = true
		else
			arg_3_0.plotController_:SetSelectedState("off")

			arg_3_0.isOpenPlotTalk = false
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.plotTalkMaskBtn_, nil, function()
		arg_3_0.plotController_:SetSelectedState("off")

		arg_3_0.isOpenPlotTalk = false
	end)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.descBtn_) do
		arg_3_0:AddBtnListener(iter_3_1, nil, function()
			arg_3_0:ShowMessage()
		end)
	end

	arg_3_0:AddBtnListener(nil, arg_3_0.hideMessageBtn_, function()
		arg_3_0:HideMessage()
		SetActive(arg_3_0.hideMessageGo_, false)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.dlc_skinBtn_, function()
		arg_3_0.showDlc_ = false

		arg_3_0:ChangeShowDlcState(0)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.dlc_dlcBtn_, function()
		if arg_3_0.dlcID_ then
			local var_16_0 = getShopCfg(arg_3_0.dlcID_)

			if var_16_0 then
				local var_16_1 = var_16_0.give_id or var_16_0.description

				if var_16_1 then
					OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. var_16_1)
				end
			end
		end

		arg_3_0.showDlc_ = true

		arg_3_0:ChangeShowDlcState(1)
	end)
	arg_3_0:AddBtnListener(nil, arg_3_0.buyDlcBtn_, function()
		arg_3_0.params_.skinID = arg_3_0.skinID_

		local var_17_0 = HeroTools.GetShopIdBySkinId(arg_3_0.skinID_)
		local var_17_1 = JumpTools.IsSystemLocked(501)

		if var_17_1 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_17_1))
		else
			local var_17_2 = getShopCfg(arg_3_0.dlcID_)

			if var_17_2 == nil then
				return
			elseif ShopConst.SHOP_ID.DLC_SHOP == var_17_2.shop_id then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					goodID = var_17_0,
					heroID = arg_3_0.heroID_,
					skinID = arg_3_0.skinID_
				}, ViewConst.SYSTEM_ID.SHOP)
			else
				local var_17_3 = getShopCfg(arg_3_0.dlcID_)

				JumpTools.GoToSystem("/shop", {
					shopId = var_17_3.shop_id
				}, ViewConst.SYSTEM_ID.SHOP)
			end
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.btn_dlcSpecialExchangeBtn_, nil, function()
		local var_18_0 = getShopCfg(arg_3_0.dlcID_)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(var_18_0.give_id)),
			OkCallback = function()
				if var_18_0 then
					JumpTools.GoToSystem("/shop", {
						shopId = var_18_0.shop_id,
						goodId = var_18_0.goods_id
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_3_0.scrollView_.onValueChanged:AddListener(function()
		arg_3_0:RefreshItemScale()
	end)
	arg_3_0:AddBtnListener(arg_3_0.switchInfoBtn_, nil, function()
		if arg_3_0.infoController_:GetSelectedState() == "tag" then
			arg_3_0:SwitchInfoController("description")
		else
			arg_3_0:SwitchInfoController("tag")
		end
	end)
end

function var_0_1.OnTryToUseItem(arg_23_0, arg_23_1, arg_23_2)
	if isSuccess(arg_23_1.result) then
		local var_23_0 = arg_23_2.use_item_list[1].item_info.id
		local var_23_1 = ItemCfg[var_23_0].param[1]

		getReward({
			{
				num = 1,
				id = var_23_1
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})

		local var_23_2 = SkinCfg[var_23_1].hero

		HeroAction.UpdateSkinCouponRedPoint(var_23_2)
		HeroAction.SkinAdd(arg_23_0.skinID_)
		arg_23_0:SetButtonActive(8)
	else
		ShowTips(arg_23_1.result)
	end

	arg_23_0:RefreshUI()
end

function var_0_1.OnSelectSkin(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:SetButtonActive(8)
end

function var_0_1.CameraEnter(arg_25_0)
	if not arg_25_0.params_.isBack then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_25_0.displayGo_)
	elseif arg_25_0.showDlcState_ == 1 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	else
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_25_0.displayGo_)
	end
end

function var_0_1.OnEnter(arg_26_0)
	arg_26_0.descList_ = {}
	arg_26_0.showDlc_ = false

	local var_26_0 = HeroSkinRouteData:GetRoute()

	if not arg_26_0.params_.heroID then
		arg_26_0.heroID_ = var_26_0.heroID
	else
		arg_26_0.heroID_ = arg_26_0.params_.heroID
	end

	if not arg_26_0.params_.isBack then
		if not arg_26_0.params_.skinID then
			arg_26_0.skinID_ = HeroTools.HeroUsingSkinInfo(arg_26_0.heroID_).id
		else
			arg_26_0.skinID_ = arg_26_0.params_.skinID
		end
	end

	arg_26_0.plotController_:SetSelectedState("off")

	arg_26_0.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(arg_26_0.skinID_)
	arg_26_0:RefreshShop()
	arg_26_0:RegistEventListener(GET_SKIN_GIFT, handler(arg_26_0, arg_26_0.OnGetSkinGift))
	arg_26_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_27_0)
		arg_26_0:RefreshUI()
	end)
	arg_26_0:RefreshUI()

	if arg_26_0.params_.isDlc then
		arg_26_0:ChangeShowDlcState(1)
	elseif not arg_26_0.params_.isBack then
		arg_26_0:ChangeShowDlcState(0)
	else
		arg_26_0:ChangeShowDlcState(arg_26_0.showDlcState_)
	end

	arg_26_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_26_0, arg_26_0.BeginDragFun)))
	arg_26_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_26_0, arg_26_0.EndDragFun)))
	arg_26_0:Scroll2SelectItem(100)
end

function var_0_1.RefreshShop(arg_28_0)
	arg_28_0:RefreshCurrencyToken(true)
end

function var_0_1.RefreshSkinItemList(arg_29_0)
	if arg_29_0.skinIdList_ and #arg_29_0.skinIdList_ > 0 then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.skinItemList_) do
			iter_29_1:SetActive(false)
		end

		for iter_29_2, iter_29_3 in ipairs(arg_29_0.skinIdList_) do
			local var_29_0

			if arg_29_0.skinItemList_[iter_29_2] then
				var_29_0 = arg_29_0.skinItemList_[iter_29_2]
			else
				var_29_0 = NewHeroSkinPreviewItem.New(arg_29_0.itemGo_, arg_29_0.contentTf_)

				table.insert(arg_29_0.skinItemList_, var_29_0)
				var_29_0:SetDelegate(handler(arg_29_0, arg_29_0.RefreshButton))
			end

			var_29_0:Show(arg_29_0.skinIdList_[iter_29_2], iter_29_2)
			var_29_0:ShowSelect(arg_29_0.selectIndex_ == iter_29_2)
			var_29_0:CheckDLC(arg_29_0:JudgeDLC(arg_29_0.skinIdList_[iter_29_2]))
			var_29_0:SetActive(true)
		end
	end

	arg_29_0:Scroll2SelectItem(5)
end

function var_0_1.RefreshUIWithOutScroll(arg_30_0)
	arg_30_0:RefreshInfo()
	arg_30_0:RefreshCost()
	arg_30_0:SetButtonActive(arg_30_0:SkinState(arg_30_0.skinID_))
end

function var_0_1.RefreshCost(arg_31_0)
	local var_31_0 = getShopCfg(HeroTools.GetShopIdBySkinId(arg_31_0.skinID_))

	SetActive(arg_31_0.tokenPlusGo_, false)

	if var_31_0 then
		local var_31_1 = 0
		local var_31_2 = 0
		local var_31_3
		local var_31_4 = var_31_0.dlc or nil

		if var_31_4 and var_31_4 ~= 0 and getShopCfg(var_31_4) then
			var_31_1 = ShopTools.GetPrice(var_31_4)
		end

		local var_31_5 = ShopTools.GetPrice(var_31_0.goods_id, var_31_0.shop_id)

		if arg_31_0:CheckIsSpecial() == 0 and arg_31_0.showDlcState_ == 1 then
			SetActive(arg_31_0.tokenPlusGo_, true)

			var_31_5 = var_31_5 + var_31_1
		end

		if var_31_0.cost_type == 1 then
			arg_31_0.currencyImage_.sprite = nil
			arg_31_0.currencyText_.text = ShopTools.GetMoneySymbol(var_31_0.goods_id) .. var_31_5

			SetActive(arg_31_0.currencyGo_, false)
		else
			arg_31_0.currencyImage_.sprite = ItemTools.getItemLittleSprite(var_31_0.cost_id)
			arg_31_0.currencyText_.text = var_31_5

			SetActive(arg_31_0.currencyGo_, true)
		end

		if var_31_1 and var_31_1 ~= 0 then
			if ShopTools.IsRMB(var_31_4) then
				arg_31_0.dlccurrencyImage_.sprite = nil
				arg_31_0.dlccurrencyText_.text = ShopTools.GetMoneySymbol(var_31_4) .. var_31_1

				SetActive(arg_31_0.dlccurrencyGo_, false)
			else
				arg_31_0.dlccurrencyImage_.sprite = ItemTools.getItemLittleSprite(var_31_0.cost_id)
				arg_31_0.dlccurrencyText_.text = var_31_1

				SetActive(arg_31_0.dlccurrencyGo_, true)
			end
		end
	end

	arg_31_0:RefreshTokenNumText()
end

function var_0_1.RefreshButton(arg_32_0, arg_32_1)
	arg_32_0.selectIndex_ = arg_32_1.index_

	local var_32_0 = arg_32_1:SkinState()
	local var_32_1 = arg_32_1.skinID_

	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_32_1.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)

	if var_32_1 == arg_32_0.skinID_ then
		arg_32_0:Scroll2SelectItem(5)

		return
	end

	arg_32_0.skinID_ = var_32_1

	arg_32_0:ChangeShowDlcState(0)

	local var_32_2 = SkinCfg[var_32_1]

	arg_32_0:SetButtonActive(var_32_0)
	manager.heroRaiseTrack:SetModelState(arg_32_0.skinID_)
	SetActive(arg_32_0.plotBtn_, #var_32_2.plot_title > 0)
	arg_32_0.plotController_:SetSelectedState("off")

	arg_32_0.isOpenPlotTalk = false

	arg_32_0:RefreshInfo()
	arg_32_0:RefreshCost()
	arg_32_0:CheckDlc(var_32_1, var_32_0)
	arg_32_0:RefreshDlcBtn()
	arg_32_0:RefreshDescBtn()
	arg_32_0:RefreshGiftBtn()
	arg_32_0:HideMessage()
	arg_32_0:RefreshUI()
	arg_32_0:Scroll2SelectItem(5)
end

function var_0_1.UpdateBar(arg_33_0)
	if arg_33_0.btnState_ == 3 or arg_33_0.dlcBtnController_:GetSelectedState() == "buyDlc" then
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

function var_0_1.SetButtonActive(arg_34_0, arg_34_1)
	arg_34_0:CheckDlc(arg_34_0.skinID_, arg_34_1)

	if arg_34_0:JudgeDLC(arg_34_0.skinID_) then
		if not ShopTools.CheckDlcPurchased(arg_34_0.dlcID_) then
			arg_34_0.dlc_dlcController_:SetSelectedIndex(0)
		else
			arg_34_0.dlc_dlcController_:SetSelectedIndex(1)
		end
	end

	if arg_34_1 == 8 or arg_34_1 == 7 and arg_34_0.skinID_ ~= arg_34_0.heroID_ or arg_34_1 == 9 and arg_34_0:CheckIsSpecial() then
		arg_34_0.dlc_skinController_:SetSelectedIndex(1)
	else
		arg_34_0.dlc_skinController_:SetSelectedIndex(0)
	end

	if arg_34_0.btnState_ == arg_34_1 then
		return
	end

	arg_34_0.statusController_:SetSelectedIndex(arg_34_1 - 1)

	arg_34_0.btnState_ = arg_34_1

	arg_34_0:UpdateBar()
end

function var_0_1.ChangeShowDlcState(arg_35_0, arg_35_1)
	arg_35_0.showDlcState_ = arg_35_1

	arg_35_0.dlcController_:SetSelectedIndex(arg_35_1)

	if arg_35_1 == 0 then
		arg_35_0.dlc_skinBtn_.interactable = false
		arg_35_0.dlc_dlcBtn_.interactable = true

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_35_0.displayGo_)
		arg_35_0:PauseDlcMovie()
	elseif arg_35_1 == 1 then
		arg_35_0.dlc_skinBtn_.interactable = true
		arg_35_0.dlc_dlcBtn_.interactable = false

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		arg_35_0:RefreshDlcMovie()
	end

	arg_35_0:RefreshCost()
	arg_35_0:ChangeDlcBtn()
	arg_35_0:RefreshInfo()
	arg_35_0:SetButtonActive(arg_35_0:SkinState(arg_35_0.skinID_))
end

function var_0_1.SkinState(arg_36_0, arg_36_1)
	arg_36_0:ChangeDlcBtn()

	if arg_36_0:isUnlockOrCanChange(arg_36_1) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[arg_36_0.skinID_].hero) == false and arg_36_0.skinID_ == SkinCfg[arg_36_0.skinID_].hero then
			return 7
		end

		if arg_36_0.showDlcState_ == 1 and not ShopTools.CheckDlcPurchased(arg_36_0.dlcID_) then
			return 9
		end

		return 8
	else
		if HeroTools.IsSkinOutOfDate(arg_36_1) then
			return 4
		end

		if ShopTools.IsPC() then
			local var_36_0 = HeroTools.GetShopIdBySkinId(arg_36_0.skinID_)

			if ShopTools.IsRMB(var_36_0) then
				return 12
			end
		end

		return 3
	end
end

function var_0_1.ChangeDlcBtn(arg_37_0)
	arg_37_0.dlcBtnController_:SetSelectedIndex(0)

	if arg_37_0:CheckIsSpecial() == 1 then
		arg_37_0:ChangeDlcBtnSpecial()

		return
	end

	if arg_37_0:isUnlock(arg_37_0.skinID_) and arg_37_0:JudgeDLC(arg_37_0.skinID_) and not ShopTools.CheckDlcPurchased(arg_37_0.dlcID_) then
		local var_37_0 = getShopCfg(arg_37_0.dlcID_)

		if ShopTools.CheckShopIsUnLock(var_37_0.shop_id) and ShopTools.IsGoodCanDisplay(var_37_0.shop_id, var_37_0.goods_id) then
			arg_37_0.dlcBtnController_:SetSelectedIndex(1)
		end
	end
end

function var_0_1.RefreshTokenNumText(arg_38_0)
	if ShopTools.IsPC() then
		SetActive(arg_38_0.tokenNum1Go_, false)
		SetActive(arg_38_0.tokenNum2Go_, false)

		return
	end

	if arg_38_0:CheckIsSpecial() == 1 then
		SetActive(arg_38_0.tokenNum1Go_, false)
		SetActive(arg_38_0.tokenNum2Go_, false)

		return
	end

	if arg_38_0.showDlcState_ == 1 and not arg_38_0:isUnlock(arg_38_0.skinID_) then
		SetActive(arg_38_0.tokenNum1Go_, false)
		SetActive(arg_38_0.tokenNum2Go_, true)

		return
	end

	if arg_38_0.showDlcState_ == 0 and not arg_38_0:isUnlockOrCanChange(arg_38_0.skinID_) or arg_38_0:isUnlockOrCanChange(arg_38_0.skinID_) and not ShopTools.CheckDlcPurchased(arg_38_0.dlcID_) then
		SetActive(arg_38_0.tokenNum1Go_, true)
		SetActive(arg_38_0.tokenNum2Go_, false)

		return
	end

	SetActive(arg_38_0.tokenNum1Go_, false)
	SetActive(arg_38_0.tokenNum2Go_, false)
end

function var_0_1.RefreshInfo(arg_39_0)
	if arg_39_0.showDlcState_ == 1 then
		local var_39_0 = getShopCfg(arg_39_0.dlcID_)
		local var_39_1 = RechargeShopDescriptionCfg[var_39_0.description]

		if var_39_1 == nil then
			var_39_1 = ItemCfg[var_39_0.give_id]
		end

		local var_39_2 = string.format("%s", var_39_1.name)
		local var_39_3 = string.format("%s", var_39_1.desc)

		arg_39_0.nameText_.text = GetI18NText(var_39_2)
		arg_39_0.infoText_.text = GetI18NText(var_39_3)
	else
		arg_39_0.nameText_.text = GetI18NText(SkinCfg[arg_39_0.skinID_].name)
		arg_39_0.infoText_.text = GetI18NText(SkinCfg[arg_39_0.skinID_].desc)
	end

	arg_39_0:CleanMessage()

	local var_39_4 = HeroTools.GetSkinChangeItem(arg_39_0.skinID_)

	if var_39_4 then
		arg_39_0.sourcetextText_.text = GetI18NText(ItemCfg[var_39_4].desc_source) or ""
		arg_39_0.couponImg_.sprite = ItemTools.getItemLittleSprite(var_39_4)
	else
		arg_39_0.sourcetextText_.text = GetI18NText(ItemCfg[arg_39_0.skinID_].desc_source) or ""
	end

	arg_39_0:RefreshLimitTime(arg_39_0.skinID_)
end

function var_0_1.SaveRoute(arg_40_0)
	local var_40_0 = {
		name = "heroSkinPreview",
		skinID = arg_40_0.skinID_,
		heroID = arg_40_0.heroID_
	}

	SkinTrialData:SaveRoute(var_40_0)
end

return var_0_1
