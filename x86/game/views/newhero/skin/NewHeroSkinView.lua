local var_0_0 = class("NewHeroSkinView", ReduxView)

function var_0_0.isUnlock(arg_1_0, arg_1_1)
	return HeroTools.GetHasOwnedSkin(arg_1_1)
end

function var_0_0.isUnlockOrCanChange(arg_2_0, arg_2_1)
	return arg_2_0:isUnlock(arg_2_1) or HeroTools.CanChangeSkin(arg_2_1)
end

function var_0_0.isSelect(arg_3_0, arg_3_1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[arg_3_1].hero).id == arg_3_1 then
		return true
	end

	return false
end

function var_0_0.UIName(arg_4_0)
	return "Widget/System/Hero/HeroSkinUI_new"
end

function var_0_0.UIParent(arg_5_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitBtnState(arg_6_0)
	arg_6_0.btnState = {
		"btn_now",
		"btn_replace",
		"btn_go",
		"sourcetext",
		"btn_change",
		"unlockinfo",
		"hero_donthave",
		"btn_now_shop",
		"hide",
		"limit_equipped",
		"limit_unequipped",
		"pc_cant_rmb"
	}
end

function var_0_0.InitDescBtn(arg_7_0)
	arg_7_0.descBtn_ = {
		arg_7_0.descBtn_1,
		arg_7_0.descBtn_2,
		arg_7_0.descBtn_3,
		arg_7_0.descBtn_4,
		arg_7_0.descBtn_5,
		arg_7_0.descBtn_6,
		arg_7_0.descBtn_7
	}
	arg_7_0.descBtnGo_ = {}

	for iter_7_0 = 1, 7 do
		arg_7_0.descBtnGo_[iter_7_0] = arg_7_0["descBtnGo_" .. iter_7_0]
	end
end

function var_0_0.Init(arg_8_0)
	arg_8_0.skinIdList_ = {}
	arg_8_0.skinItemList_ = {}
	arg_8_0.descInfoList_ = {}
	arg_8_0.btnState_ = nil
	arg_8_0.skinID_ = 1
	arg_8_0.selectIndex_ = 1
	arg_8_0.isCanUnlock_ = false
	arg_8_0.dlcMovie_ = nil
	arg_8_0.dlcPlayer_ = nil

	arg_8_0:InitUI()
	arg_8_0:AddUIListener()
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()
	arg_9_0:InitBtnState()
	arg_9_0:InitDescBtn()

	arg_9_0.haveDLCController_ = arg_9_0.controllerEx_:GetController("haveDLC")
	arg_9_0.timeController_ = arg_9_0.controllerEx_:GetController("Time")
	arg_9_0.giftController_ = arg_9_0.controllerEx_:GetController("Gift")
	arg_9_0.plotController_ = arg_9_0.controllerEx_:GetController("Plot")
	arg_9_0.infoController_ = arg_9_0.controllerEx_:GetController("Info")
	arg_9_0.statusController_ = arg_9_0.controllerEx_:GetController("Btn")
	arg_9_0.dlcController_ = arg_9_0.controllerEx_:GetController("DLC")
	arg_9_0.dlcBtnController_ = arg_9_0.controllerEx_:GetController("dlcBtn")
	arg_9_0.unlockController_ = arg_9_0.lockControllerEx_:GetController("clear")
	arg_9_0.taskController_1 = arg_9_0.lockControllerEx_:GetController("task01")
	arg_9_0.taskController_2 = arg_9_0.lockControllerEx_:GetController("task02")
	arg_9_0.dlc_skinController_ = arg_9_0.dlc_skinControllerEx_:GetController("get")
	arg_9_0.dlc_dlcController_ = arg_9_0.dlc_dlcControllerEx_:GetController("get")
end

function var_0_0.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.portraitBtn_, nil, function()
		if arg_10_0.showDlcState_ == 1 then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = arg_10_0.dlcID_
			})
		else
			arg_10_0:Go("heroPortrait", {
				skinID = arg_10_0.skinID_
			})
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.replaceBtn_, nil, function()
		HeroAction.SelectSkin(arg_10_0.heroID_, arg_10_0.skinID_)
		arg_10_0:PlayVoice()
	end)
	arg_10_0:AddBtnListener(arg_10_0.goBtn_, nil, function()
		arg_10_0.params_.skinID = arg_10_0.skinID_

		local var_13_0 = HeroTools.GetShopIdBySkinId(arg_10_0.skinID_)
		local var_13_1 = JumpTools.IsSystemLocked(501)

		if var_13_1 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_13_1))
		elseif arg_10_0.showDlcState_ == 1 then
			if arg_10_0:CheckIsSpecial() == 0 then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = false,
					goodID = var_13_0,
					heroID = arg_10_0.heroID_,
					skinID = arg_10_0.skinID_
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			else
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = true,
					goodID = var_13_0,
					heroID = arg_10_0.heroID_,
					skinID = arg_10_0.skinID_
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			end
		else
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				onlySkin = true,
				goodID = var_13_0,
				heroID = arg_10_0.heroID_,
				skinID = arg_10_0.skinID_
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.pcRmbBtn_, nil, function()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.changeBtn_, nil, function()
		arg_10_0.params_.skinID = arg_10_0.skinID_

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = HeroTools.GetSkinChangeItem(arg_10_0.skinID_)
				},
				use_list = {}
			}
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.unlockBtn_, nil, function()
		if arg_10_0.isCanUnlock_ then
			HeroAction.UnLockSkin(arg_10_0.skinID_)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.giftBtn_, nil, function()
		if arg_10_0:isUnlock(arg_10_0.skinID_) then
			PlayerAction.ReceiveSkinGift(arg_10_0.skinID_)
		else
			local var_17_0 = (SkinCfg[arg_10_0.skinID_] or {}).gift or {}

			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = var_17_0
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.battleBtn_, nil, function()
		arg_10_0.params_.skinID = arg_10_0.skinID_

		local var_18_0 = 0
		local var_18_1 = SkinTagCfg[arg_10_0.skinID_]
		local var_18_2 = var_18_1.trial_activity
		local var_18_3 = var_18_2[1]

		for iter_18_0, iter_18_1 in ipairs(var_18_2) do
			local var_18_4 = ActivitySkinTrialCfg[iter_18_1].activity_id

			if ActivityData:GetActivityIsOpen(var_18_4) then
				var_18_0 = var_18_4
				var_18_3 = iter_18_1

				break
			end
		end

		SkinTrialData:SaveStageID(var_18_3)
		arg_10_0:SaveRoute()
		arg_10_0:Go("/sectionSelectHero", {
			activityID = var_18_0,
			section = var_18_1.trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.plotBtn_, nil, function()
		if not arg_10_0.isOpenPlotTalk then
			arg_10_0:IndexPlotItem()
			arg_10_0.plotController_:SetSelectedState("on")
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.talkStateGo_.transform)

			arg_10_0.isOpenPlotTalk = true
		else
			arg_10_0.plotController_:SetSelectedState("off")

			arg_10_0.isOpenPlotTalk = false
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.plotTalkMaskBtn_, nil, function()
		arg_10_0.plotController_:SetSelectedState("off")

		arg_10_0.isOpenPlotTalk = false
	end)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.descBtn_) do
		arg_10_0:AddBtnListener(iter_10_1, nil, function()
			arg_10_0:ShowMessage()
		end)
	end

	arg_10_0:AddBtnListener(nil, arg_10_0.hideMessageBtn_, function()
		arg_10_0:HideMessage()
		SetActive(arg_10_0.hideMessageGo_, false)
	end)
	arg_10_0:AddBtnListener(nil, arg_10_0.dlc_skinBtn_, function()
		arg_10_0.showDlc_ = false

		arg_10_0:ChangeShowDlcState(0)
	end)
	arg_10_0:AddBtnListener(nil, arg_10_0.dlc_dlcBtn_, function()
		if arg_10_0.dlcID_ then
			local var_24_0 = getShopCfg(arg_10_0.dlcID_)

			if var_24_0 then
				local var_24_1 = var_24_0.give_id or var_24_0.description

				if var_24_1 then
					OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. var_24_1)
				end
			end
		end

		arg_10_0.showDlc_ = true

		arg_10_0:ChangeShowDlcState(1)
	end)
	arg_10_0:AddBtnListener(nil, arg_10_0.buyDlcBtn_, function()
		arg_10_0.params_.skinID = arg_10_0.skinID_

		local var_25_0 = HeroTools.GetShopIdBySkinId(arg_10_0.skinID_)
		local var_25_1 = JumpTools.IsSystemLocked(501)

		if var_25_1 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_25_1))
		else
			local var_25_2 = getShopCfg(arg_10_0.dlcID_)

			if var_25_2 == nil then
				return
			elseif ShopConst.SHOP_ID.DLC_SHOP == var_25_2.shop_id then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					goodID = var_25_0,
					heroID = arg_10_0.heroID_,
					skinID = arg_10_0.skinID_
				}, ViewConst.SYSTEM_ID.SHOP)
			else
				local var_25_3 = getShopCfg(arg_10_0.dlcID_)

				JumpTools.GoToSystem("/shop", {
					shopId = var_25_3.shop_id
				}, ViewConst.SYSTEM_ID.SHOP)
			end
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.btn_dlcSpecialExchangeBtn_, nil, function()
		local var_26_0 = getShopCfg(arg_10_0.dlcID_)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(var_26_0.give_id)),
			OkCallback = function()
				if var_26_0 then
					JumpTools.GoToSystem("/shop", {
						shopId = var_26_0.shop_id
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_10_0.scrollView_.onValueChanged:AddListener(function()
		arg_10_0:RefreshItemScale()
	end)
	arg_10_0:AddBtnListener(arg_10_0.switchInfoBtn_, nil, function()
		if arg_10_0.infoController_:GetSelectedState() == "tag" then
			arg_10_0:SwitchInfoController("description")
		else
			arg_10_0:SwitchInfoController("tag")
		end
	end)
end

function var_0_0.CheckIsSpecial(arg_31_0)
	if not arg_31_0.dlcID_ then
		arg_31_0:SetCurDlcID()
	end

	arg_31_0.shopDlcCfg = getShopCfg(arg_31_0.dlcID_)

	if arg_31_0.shopDlcCfg and arg_31_0.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		return 1
	end

	return 0
end

function var_0_0.SwitchInfoController(arg_32_0, arg_32_1)
	arg_32_0.infoController_:SetSelectedState(arg_32_1)
end

function var_0_0.OnTop(arg_33_0)
	arg_33_0:UpdateBar()
	arg_33_0:RefreshUIWithOutScroll()

	if arg_33_0.showDlcState_ == 1 then
		arg_33_0:RefreshDlcMovie()
	end
end

function var_0_0.OnBehind(arg_34_0)
	if arg_34_0.showDlcState_ == 1 then
		arg_34_0:PauseDlcMovie()
	end
end

function var_0_0.IndexPlotItem(arg_35_0)
	if not arg_35_0.plotItemList_ then
		arg_35_0.plotItemList_ = {}
	end

	local var_35_0 = SkinCfg[arg_35_0.skinID_]
	local var_35_1 = var_35_0.plot_title
	local var_35_2 = var_35_0.plot_id

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.plotItemList_) do
		SetActive(iter_35_1.gameObject_, false)
	end

	for iter_35_2 = 1, #var_35_1 do
		if not arg_35_0.plotItemList_[iter_35_2] then
			local var_35_3 = Object.Instantiate(arg_35_0.plotTalkBtn_.gameObject)
			local var_35_4 = PlotTalkItem.New(var_35_3)

			var_35_3.transform:SetParent(arg_35_0.plotTalkBasePanelGo_.transform, false)
			var_35_4:SetCallBack(function()
				arg_35_0.plotController_:SetSelectedState("off")

				arg_35_0.isOpenPlotTalk = false
			end)
			table.insert(arg_35_0.plotItemList_, var_35_4)
		end

		arg_35_0.plotItemList_[iter_35_2]:RefreshUI(var_35_1[iter_35_2], var_35_2[iter_35_2])
		SetActive(arg_35_0.plotItemList_[iter_35_2].gameObject_, true)
	end
end

function var_0_0.OnTryToUseItem(arg_37_0, arg_37_1, arg_37_2)
	if isSuccess(arg_37_1.result) then
		local var_37_0 = arg_37_2.use_item_list[1].item_info.id
		local var_37_1 = ItemCfg[var_37_0].param[1]

		getReward({
			{
				num = 1,
				id = var_37_1
			}
		}, {
			ItemConst.ITEM_TYPE.HERO_SKIN
		})

		local var_37_2 = SkinCfg[var_37_1].hero

		HeroAction.UpdateSkinCouponRedPoint(var_37_2)
		HeroAction.SkinAdd(arg_37_0.skinID_)
		arg_37_0:SetButtonActive(2)
		manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. var_37_1, 0, RedPointStyle.SHOW_NEW_TAG)
	else
		ShowTips(arg_37_1.result)
	end

	arg_37_0:RefreshUI()
end

function var_0_0.OnSelectSkin(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0:SetButtonActive(1)
end

function var_0_0.OnEnter(arg_39_0)
	arg_39_0.descList_ = {}
	arg_39_0.showDlc_ = false

	local var_39_0 = HeroSkinRouteData:GetRoute()

	if not arg_39_0.params_.heroID then
		arg_39_0.heroID_ = var_39_0.heroID
	else
		arg_39_0.heroID_ = arg_39_0.params_.heroID
	end

	if not arg_39_0.params_.isBack then
		if not arg_39_0.params_.skinID then
			arg_39_0.skinID_ = HeroTools.HeroUsingSkinInfo(arg_39_0.heroID_).id
		else
			arg_39_0.skinID_ = arg_39_0.params_.skinID
		end

		arg_39_0:ChangeShowDlcState(0)
	else
		arg_39_0:ChangeShowDlcState(arg_39_0.showDlcState_)
	end

	arg_39_0.plotController_:SetSelectedState("off")

	arg_39_0.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(arg_39_0.skinID_)
	arg_39_0:RefreshShop()
	arg_39_0:RegistEventListener(GET_SKIN_GIFT, handler(arg_39_0, arg_39_0.OnGetSkinGift))
	arg_39_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_40_0)
		arg_39_0:RefreshUI()
	end)
	arg_39_0:RefreshUI()
	arg_39_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_39_0, arg_39_0.BeginDragFun)))
	arg_39_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_39_0, arg_39_0.EndDragFun)))
	arg_39_0:Scroll2SelectItem(100)
end

function var_0_0.RefreshShop(arg_41_0)
	arg_41_0:RefreshCurrencyToken(false)
end

function var_0_0.RefreshCurrencyToken(arg_42_0, arg_42_1)
	SetActive(arg_42_0.tokenGo_, arg_42_1)
	SetActive(arg_42_0.dlctokenGo_, arg_42_1)
	SetActive(arg_42_0.tokenNumGo_, arg_42_1)
end

function var_0_0.CameraEnter(arg_43_0)
	if not arg_43_0.params_.isBack then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_43_0.displayGo_)
	elseif arg_43_0.showDlcState_ == 1 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	else
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_43_0.displayGo_)
	end
end

function var_0_0.OnExit(arg_44_0)
	if arg_44_0.delayPlayTimer_ then
		arg_44_0.delayPlayTimer_:Stop()

		arg_44_0.delayPlayTimer_ = nil
	end

	arg_44_0:StopMovieStopTimer()
	arg_44_0:StopMovieTimer()
	arg_44_0:StopMoveTimer()
	arg_44_0:CleanMessage()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_44_0:RemoveAllEventListener()
	arg_44_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_44_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	if arg_44_0.dlcPlayer_ then
		arg_44_0.dlcPlayer_.statusChangeCallback = nil
	end

	if arg_44_0.dlcMovie_ then
		arg_44_0.dlcMovie_:Stop()
	end

	arg_44_0.dlcPlayer_ = nil
	arg_44_0.dlcMovie_ = nil
	arg_44_0.movieSkinId_ = 0

	local var_44_0 = {
		heroID = arg_44_0.heroID_,
		skinID = arg_44_0.skinID_
	}

	HeroSkinRouteData:SaveRoute(var_44_0)
end

function var_0_0.RefreshUI(arg_45_0)
	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_45_0.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)
	arg_45_0:RefreshInfo()
	arg_45_0:RefreshDlcBtn()
	arg_45_0:SetButtonActive(arg_45_0:SkinState(arg_45_0.skinID_))
	arg_45_0:RefreshDescBtn()
	arg_45_0:RefreshGiftBtn()
	arg_45_0:HideMessage()
	arg_45_0:RefreshItemData()
	arg_45_0:RefreshSkinItemList()
	SetActive(arg_45_0.plotBtn_, #SkinCfg[arg_45_0.skinID_].plot_title > 0)

	for iter_45_0, iter_45_1 in ipairs(arg_45_0.skinItemList_) do
		if iter_45_1.isActive and iter_45_1:GetSkinID() == arg_45_0.skinID_ then
			arg_45_0.selectIndex_ = iter_45_0
		end
	end
end

function var_0_0.RefreshSkinItemList(arg_46_0)
	if arg_46_0.skinIdList_ and #arg_46_0.skinIdList_ > 0 then
		for iter_46_0, iter_46_1 in pairs(arg_46_0.skinItemList_) do
			iter_46_1:SetActive(false)
		end

		for iter_46_2, iter_46_3 in ipairs(arg_46_0.skinIdList_) do
			local var_46_0

			if arg_46_0.skinItemList_[iter_46_2] then
				var_46_0 = arg_46_0.skinItemList_[iter_46_2]
			else
				var_46_0 = NewHeroSkinItem.New(arg_46_0.itemGo_, arg_46_0.contentTf_)

				table.insert(arg_46_0.skinItemList_, var_46_0)
				var_46_0:SetDelegate(handler(arg_46_0, arg_46_0.RefreshButton))
			end

			var_46_0:Show(arg_46_0.skinIdList_[iter_46_2], iter_46_2)
			var_46_0:ShowSelect(arg_46_0.selectIndex_ == iter_46_2)
			var_46_0:CheckDLC(arg_46_0:JudgeDLC(arg_46_0.skinIdList_[iter_46_2]))
			var_46_0:SetActive(true)
		end
	end

	arg_46_0:Scroll2SelectItem(5)
end

function var_0_0.RefreshDlcBtn(arg_47_0)
	arg_47_0.dlc_skinImage_.sprite = HeroTools.GetHeadSprite(arg_47_0.skinID_)

	if arg_47_0:JudgeDLC(arg_47_0.skinID_) then
		arg_47_0:SetCurDlcID()

		local var_47_0 = getShopCfg(arg_47_0.dlcID_)

		if var_47_0 then
			local var_47_1 = var_47_0.give_id or var_47_0.description

			if var_47_1 then
				arg_47_0.dlc_dlcImage_.sprite = ItemTools.getItemSprite(var_47_1)
			end
		end
	else
		arg_47_0:SetCurDlcID()
	end
end

function var_0_0.RefreshLimitTime(arg_48_0, arg_48_1)
	local var_48_0 = HeroData:GetHeroData(arg_48_0.heroID_)
	local var_48_1 = 0
	local var_48_2 = 0

	for iter_48_0, iter_48_1 in ipairs(var_48_0.unlocked_skin) do
		if iter_48_1.skin_id == arg_48_1 then
			var_48_1 = iter_48_1.time

			if arg_48_0:JudgeDLC(arg_48_1) then
				local var_48_3 = HeroTools.GetShopIdBySkinId(arg_48_1)

				if not var_48_3 then
					return false
				end

				local var_48_4 = getShopCfg(var_48_3)
				local var_48_5 = var_48_4 and var_48_4.dlc

				if var_48_5 and var_48_5 ~= 0 then
					var_48_2 = HomeSceneSettingData:GetSceneTimeStamp(ShopCfg[var_48_5].description) or 0
				end
			end
		end
	end

	if var_48_1 ~= 0 then
		arg_48_0.skinLimitTimeText_.text = string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", var_48_1) .. " ")
	else
		arg_48_0.skinLimitTimeText_.text = string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", var_48_2) .. " ")
	end

	SetActive(arg_48_0.LimitTimeGo_, var_48_1 ~= 0 or var_48_2 ~= 0)
	SetActive(arg_48_0.skinLimitTimeGo_, var_48_1 ~= 0)
	SetActive(arg_48_0.dlcLimitTimeGo_, var_48_2 ~= 0)
end

function var_0_0.RefreshUIWithOutScroll(arg_49_0)
	arg_49_0:RefreshInfo()
	arg_49_0:SetButtonActive(arg_49_0:SkinState(arg_49_0.skinID_))
end

function var_0_0.RefreshItemData(arg_50_0)
	arg_50_0.skinIdList_ = {}

	for iter_50_0, iter_50_1 in ipairs(SkinCfg.get_id_list_by_hero[arg_50_0.heroID_]) do
		if not HeroTools.GetIsSkinHide(iter_50_1) then
			if arg_50_0:isUnlock(iter_50_1) then
				table.insert(arg_50_0.skinIdList_, iter_50_1)
			elseif HeroTools.CanChangeSkin(iter_50_1) then
				table.insert(arg_50_0.skinIdList_, iter_50_1)
			elseif HeroTools.GetIsLimitTimeSkin(iter_50_1) then
				table.insert(arg_50_0.skinIdList_, iter_50_1)
			elseif SDKTools.GetIsOverSea() then
				table.insert(arg_50_0.skinIdList_, iter_50_1)
			elseif SkinCfg[iter_50_1].display_type == 1 then
				table.insert(arg_50_0.skinIdList_, iter_50_1)
			end
		end
	end

	if arg_50_0.params_.skinID and not table.indexof(arg_50_0.skinIdList_, arg_50_0.params_.skinID) then
		table.insert(arg_50_0.skinIdList_, arg_50_0.params_.skinID)
	end
end

function var_0_0.RefreshButton(arg_51_0, arg_51_1)
	arg_51_0.selectIndex_ = arg_51_1.index_

	local var_51_0 = arg_51_1:SkinState()
	local var_51_1 = arg_51_1.skinID_
	local var_51_2 = SkinCfg[arg_51_1.skinID_].hero

	if var_51_1 == arg_51_0.skinID_ then
		arg_51_0:Scroll2SelectItem(5)

		return
	end

	arg_51_0.skinID_ = var_51_1

	arg_51_0:ChangeShowDlcState(0)

	local var_51_3 = SkinCfg[var_51_1]

	arg_51_0:SetButtonActive(var_51_0)
	manager.heroRaiseTrack:SetModelState(arg_51_0.skinID_)
	SetActive(arg_51_0.plotBtn_, #var_51_3.plot_title > 0)
	arg_51_0.plotController_:SetSelectedState("off")

	arg_51_0.isOpenPlotTalk = false

	arg_51_0:RefreshInfo()
	arg_51_0:CheckDlc(var_51_1, var_51_0)
	arg_51_0:RefreshDlcBtn()
	arg_51_0:RefreshDescBtn()
	arg_51_0:RefreshGiftBtn()
	arg_51_0:HideMessage()
	arg_51_0:RefreshUI()
	arg_51_0:Scroll2SelectItem(5)
	arg_51_0:RefreshLimitTime(arg_51_0.skinID_)
end

function var_0_0.CheckDlc(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0.haveDLCController_:SetSelectedIndex(0)

	if arg_52_0:JudgeDLC(arg_52_1) then
		arg_52_0.haveDLCController_:SetSelectedIndex(1)
	end
end

function var_0_0.JudgeDLC(arg_53_0, arg_53_1)
	if arg_53_1 == nil then
		return false
	end

	local var_53_0 = HeroTools.GetShopIdBySkinId(arg_53_1)

	if not var_53_0 then
		return false
	end

	local var_53_1 = getShopCfg(var_53_0)
	local var_53_2 = var_53_1 and var_53_1.dlc

	if var_53_2 and var_53_2 ~= 0 then
		return true
	end

	return false
end

function var_0_0.SetCurDlcID(arg_54_0)
	local var_54_0 = HeroTools.GetShopIdBySkinId(arg_54_0.skinID_)
	local var_54_1 = getShopCfg(var_54_0)

	arg_54_0.dlcID_ = var_54_1 and var_54_1.dlc
end

function var_0_0.UpdateBar(arg_55_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.SetButtonActive(arg_56_0, arg_56_1)
	arg_56_0:CheckDlc(arg_56_0.skinID_, arg_56_1)

	if arg_56_0:JudgeDLC(arg_56_0.skinID_) then
		arg_56_0.dlc_dlcController_:SetSelectedState(tostring(ShopTools.CheckDlcPurchased(arg_56_0.dlcID_)))
	end

	arg_56_0.dlc_skinController_:SetSelectedState(tostring(HeroTools.GetHasOwnedSkin(arg_56_0.skinID_)))

	if arg_56_0.btnState_ == arg_56_1 then
		return
	end

	arg_56_0.statusController_:SetSelectedIndex(arg_56_1 - 1)

	arg_56_0.btnState_ = arg_56_1

	arg_56_0:UpdateBar()
end

function var_0_0.ChangeShowDlcState(arg_57_0, arg_57_1)
	arg_57_0.showDlcState_ = arg_57_1

	arg_57_0.dlcController_:SetSelectedIndex(arg_57_1)

	if arg_57_1 == 0 then
		arg_57_0.dlc_skinBtn_.interactable = false
		arg_57_0.dlc_dlcBtn_.interactable = true

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_57_0.displayGo_)
		arg_57_0:PauseDlcMovie()
	elseif arg_57_1 == 1 then
		arg_57_0.dlc_skinBtn_.interactable = true
		arg_57_0.dlc_dlcBtn_.interactable = false

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		arg_57_0:RefreshDlcMovie()
	end

	arg_57_0:ChangeDlcBtn()
	arg_57_0:SetButtonActive(arg_57_0:SkinState(arg_57_0.skinID_))
	arg_57_0:RefreshInfo()
end

function var_0_0.SkinState(arg_58_0, arg_58_1)
	arg_58_0:ChangeDlcBtn()

	if arg_58_0:isUnlock(arg_58_1) then
		if arg_58_0:isSelect(arg_58_1) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(arg_58_1) then
			if arg_58_0:isSelect(arg_58_1) then
				if HeroTools.IsSkinOutOfDate(arg_58_1) or arg_58_0.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(arg_58_1) or arg_58_0.showDlcState_ == 1 then
				return 2
			else
				return 11
			end
		end

		if HeroTools.CanChangeSkin(arg_58_1) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(arg_58_1) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(arg_58_1) then
			return 4
		end

		if ShopTools.IsPC() then
			local var_58_0 = HeroTools.GetShopIdBySkinId(arg_58_0.skinID_)

			if ShopTools.IsRMB(var_58_0) then
				return 12
			end
		end

		return 3
	end
end

function var_0_0.CheckSpecicalTable(arg_59_0, arg_59_1, arg_59_2)
	for iter_59_0 = 1, #arg_59_1 do
		if arg_59_1[iter_59_0] ~= arg_59_2[iter_59_0] then
			return false
		end
	end

	return true
end

function var_0_0.ChangeDlcBtnSpecial(arg_60_0)
	local var_60_0 = arg_60_0:isUnlock(arg_60_0.skinID_) and 1 or 0
	local var_60_1 = ShopTools.CheckDlcPurchased(arg_60_0.dlcID_) and 1 or 0
	local var_60_2 = arg_60_0.showDlcState_
	local var_60_3 = {
		var_60_0,
		var_60_1,
		var_60_2
	}

	if arg_60_0:CheckSpecicalTable(var_60_3, {
		0,
		0,
		0
	}) then
		arg_60_0:SetButtonActive(3)
		arg_60_0.dlcBtnController_:SetSelectedIndex(0)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		0,
		0,
		1
	}) then
		arg_60_0:SetButtonActive(3)
		arg_60_0.dlcBtnController_:SetSelectedIndex(2)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		0,
		1,
		0
	}) then
		arg_60_0:SetButtonActive(3)
		arg_60_0.dlcBtnController_:SetSelectedIndex(0)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		0,
		1,
		1
	}) then
		arg_60_0:SetButtonActive(3)
		arg_60_0.dlcBtnController_:SetSelectedIndex(3)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		1,
		0,
		0
	}) then
		arg_60_0:SetButtonActive(8)
		arg_60_0.dlcBtnController_:SetSelectedIndex(2)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		1,
		0,
		1
	}) then
		arg_60_0:SetButtonActive(9)
		arg_60_0.dlcBtnController_:SetSelectedIndex(2)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		1,
		1,
		0
	}) then
		arg_60_0:SetButtonActive(8)
		arg_60_0.dlcBtnController_:SetSelectedIndex(0)
	elseif arg_60_0:CheckSpecicalTable(var_60_3, {
		1,
		1,
		1
	}) then
		arg_60_0:SetButtonActive(8)
		arg_60_0.dlcBtnController_:SetSelectedIndex(0)
	end
end

function var_0_0.ChangeDlcBtn(arg_61_0)
	arg_61_0.dlcBtnController_:SetSelectedIndex(0)

	if arg_61_0:CheckIsSpecial() == 1 then
		arg_61_0:ChangeDlcBtnSpecial()

		return
	end

	if arg_61_0.showDlcState_ == 1 and (arg_61_0:isUnlock(arg_61_0.skinID_) or HeroTools.GetIsLimitTimeSkin(arg_61_0.skinID_)) and arg_61_0:JudgeDLC(arg_61_0.skinID_) and not ShopTools.CheckDlcPurchased(arg_61_0.dlcID_) then
		local var_61_0 = getShopCfg(arg_61_0.dlcID_)

		if ShopTools.CheckShopIsUnLock(var_61_0.shop_id) and ShopTools.IsGoodCanDisplay(var_61_0.shop_id, var_61_0.goods_id) then
			arg_61_0.dlcBtnController_:SetSelectedIndex(1)
		end
	end
end

function var_0_0.HaveMaterial(arg_62_0)
	local var_62_0 = getShopCfg(HeroTools.GetShopIdBySkinId(arg_62_0.skinID_))

	return ItemCfg[var_62_0.cost_id], ItemTools.getItemNum(var_62_0.cost_id)
end

function var_0_0.RefreshDescBtn(arg_63_0)
	arg_63_0.typeNum_ = 0
	arg_63_0.typeDes_ = {}

	local var_63_0 = SkinTagCfg[arg_63_0.skinID_]

	SetActive(arg_63_0.battleBtn_.gameObject, var_63_0 ~= nil)

	if not var_63_0 then
		for iter_63_0, iter_63_1 in ipairs(arg_63_0.descBtnGo_) do
			SetActive(iter_63_1, false)
			arg_63_0:SwitchInfoController("description")
			SetActive(arg_63_0.switchInfoIconGo_, false)

			arg_63_0.switchInfoBtn_.interactable = false

			return
		end
	end

	local var_63_1 = var_63_0.tag

	for iter_63_2, iter_63_3 in ipairs(var_63_1) do
		local var_63_2 = SkinTagDescCfg[iter_63_3].type

		if not arg_63_0.typeDes_[var_63_2] then
			arg_63_0.typeDes_[var_63_2] = {}
			arg_63_0.typeNum_ = arg_63_0.typeNum_ + 1
		end

		table.insert(arg_63_0.typeDes_[var_63_2], iter_63_3)
	end

	for iter_63_4, iter_63_5 in ipairs(arg_63_0.descBtnGo_) do
		local var_63_3 = arg_63_0.typeDes_[iter_63_4] ~= nil

		SetActive(iter_63_5, var_63_3)
	end

	if arg_63_0.typeNum_ == 0 then
		arg_63_0:SwitchInfoController("description")
		SetActive(arg_63_0.switchInfoIconGo_, false)

		arg_63_0.switchInfoBtn_.interactable = false
	else
		arg_63_0:SwitchInfoController("tag")
		SetActive(arg_63_0.switchInfoIconGo_, true)

		arg_63_0.switchInfoBtn_.interactable = true
	end
end

function var_0_0.RefreshInfo(arg_64_0)
	if arg_64_0.showDlcState_ == 1 then
		local var_64_0 = getShopCfg(arg_64_0.dlcID_)
		local var_64_1 = RechargeShopDescriptionCfg[var_64_0.description]

		if var_64_1 == nil then
			var_64_1 = ItemCfg[var_64_0.give_id]
		end

		local var_64_2 = string.format("%s", var_64_1.name)
		local var_64_3 = string.format("%s", var_64_1.desc)

		arg_64_0.nameText_.text = GetI18NText(var_64_2)
		arg_64_0.infoText_.text = GetI18NText(var_64_3)
	else
		arg_64_0.nameText_.text = GetI18NText(SkinCfg[arg_64_0.skinID_].name)
		arg_64_0.infoText_.text = GetI18NText(SkinCfg[arg_64_0.skinID_].desc)
	end

	arg_64_0:CleanMessage()

	local var_64_4 = HeroTools.GetSkinChangeItem(arg_64_0.skinID_)

	if var_64_4 then
		arg_64_0.sourcetextText_.text = GetI18NText(ItemCfg[var_64_4].desc_source) or ""
		arg_64_0.couponImg_.sprite = ItemTools.getItemLittleSprite(var_64_4)
	else
		arg_64_0.sourcetextText_.text = GetI18NText(ItemCfg[arg_64_0.skinID_].desc_source) or ""
	end

	if arg_64_0.btnState_ == 5 then
		if HeroTools.CanChangeSkin(arg_64_0.skinID_) then
			manager.redPoint:SetRedPointIndependent(arg_64_0.changeBtn_.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(arg_64_0.changeBtn_.transform, false)
		end
	end

	if arg_64_0.btnState_ == 6 then
		arg_64_0.isCanUnlock_ = true

		for iter_64_0, iter_64_1 in pairs(SkinCfg[arg_64_0.skinID_].unlock_id_list) do
			local var_64_5, var_64_6, var_64_7 = IsConditionAchieved(iter_64_1, {
				heroId = arg_64_0.heroID_
			})

			if var_64_5 then
				arg_64_0["taskController_" .. iter_64_0]:SetSelectedState("true")
			else
				arg_64_0.isCanUnlock_ = false

				arg_64_0["taskController_" .. iter_64_0]:SetSelectedState("false")
			end

			arg_64_0["tasktext_" .. iter_64_0].text = GetI18NText(ConditionCfg[iter_64_1].desc)
		end

		arg_64_0.unlockController_:SetSelectedState(arg_64_0.isCanUnlock_ and "false" or "true")
	end

	arg_64_0:RefreshLimitTime(arg_64_0.skinID_)
end

function var_0_0.OnShopBuyResult(arg_65_0)
	arg_65_0:RefreshUI()
end

function var_0_0.OnGetSkinGift(arg_66_0)
	arg_66_0:RefreshUI()
end

function var_0_0.RefreshGiftBtn(arg_67_0)
	local var_67_0 = (SkinCfg[arg_67_0.skinID_] or {}).gift or {}

	if #var_67_0 > 0 and PlayerData:IsNotReceived(arg_67_0.skinID_) then
		SetActive(arg_67_0.giftBtn_, true)
	else
		SetActive(arg_67_0.giftBtn_, false)
	end

	SetActive(arg_67_0.giftRedGo_, #var_67_0 > 0 and arg_67_0:isUnlock(arg_67_0.skinID_) and PlayerData:IsNotReceived(arg_67_0.skinID_))
	arg_67_0.giftController_:SetSelectedState(arg_67_0:isUnlock(arg_67_0.skinID_) and "take" or "check")
end

function var_0_0.HideMessage(arg_68_0)
	SetActive(arg_68_0.descPanel_, false)
end

function var_0_0.ShowMessage(arg_69_0)
	if #arg_69_0.descInfoList_ == 0 then
		for iter_69_0, iter_69_1 in pairs(arg_69_0.typeDes_) do
			local var_69_0 = Object.Instantiate(arg_69_0.descContent_, arg_69_0.descTipsContent_)

			arg_69_0.descInfoList_[iter_69_0] = SkinDescInfoItem.New(var_69_0, iter_69_1, iter_69_0)

			arg_69_0.descInfoList_[iter_69_0]:RefreshUI()
			arg_69_0.descInfoList_[iter_69_0]:Show(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_0.descPanelRect_)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_0.descPanelRect_)
	SetActive(arg_69_0.descPanel_, true)
	SetActive(arg_69_0.hideMessageGo_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_0.descPanelRect_)
end

function var_0_0.CleanMessage(arg_70_0)
	for iter_70_0, iter_70_1 in pairs(arg_70_0.descInfoList_) do
		iter_70_1:Dispose()
	end

	arg_70_0.descInfoList_ = {}
end

function var_0_0.SaveRoute(arg_71_0)
	local var_71_0 = {
		name = "heroSkin",
		skinID = arg_71_0.skinID_,
		heroID = arg_71_0.heroID_
	}

	SkinTrialData:SaveRoute(var_71_0)
end

function var_0_0.Dispose(arg_72_0)
	if arg_72_0.delayPlayTimer_ then
		arg_72_0.delayPlayTimer_:Stop()

		arg_72_0.delayPlayTimer_ = nil
	end

	arg_72_0:StopMovieStopTimer()
	arg_72_0:StopMovieTimer()
	arg_72_0:StopMoveTimer()
	arg_72_0:RemoveAllListeners()
	arg_72_0:CleanMessage()

	if arg_72_0.plotItemList_ then
		for iter_72_0, iter_72_1 in ipairs(arg_72_0.plotItemList_) do
			iter_72_1:Dispose()
		end

		arg_72_0.plotItemList_ = nil
	end

	if arg_72_0.skinItemList_ then
		for iter_72_2, iter_72_3 in ipairs(arg_72_0.skinItemList_) do
			iter_72_3:Dispose()
		end

		arg_72_0.skinItemList_ = nil
	end

	var_0_0.super.Dispose(arg_72_0)
end

function var_0_0.PlayVoice(arg_73_0)
	if arg_73_0.delayPlayTimer_ then
		return
	end

	HeroTools.PlayVoice(arg_73_0.heroID_, "cloth")

	arg_73_0.delayPlayTimer_ = Timer.New(function()
		if arg_73_0.delayPlayTimer_ then
			arg_73_0.delayPlayTimer_:Stop()

			arg_73_0.delayPlayTimer_ = nil
		end
	end, 10, -1)

	arg_73_0.delayPlayTimer_:Start()
end

function var_0_0.SetReturnBtn(arg_75_0, arg_75_1)
	SetActive(arg_75_0.hideMessageGo_, true)
	arg_75_0:RemoveBtnListener(nil, arg_75_0.hideMessageBtn_.transform)
	arg_75_0:AddBtnListener(arg_75_0.hideMessageBtn_, nil, function()
		arg_75_1()
		SetActive(arg_75_0.hideMessageGo_, false)
	end)
end

function var_0_0.AdjustItem(arg_77_0)
	local var_77_0 = arg_77_0:GetNearestItem()

	arg_77_0:RefreshButton(var_77_0)
end

function var_0_0.RefreshItemScale(arg_78_0)
	for iter_78_0, iter_78_1 in pairs(arg_78_0.skinItemList_) do
		if iter_78_1.isActive then
			iter_78_1:RefreshShow()
		end
	end
end

function var_0_0.BeginDragFun(arg_79_0, arg_79_1, arg_79_2)
	arg_79_0:StopMoveTimer()
	arg_79_0:StopScrollTimer()
	arg_79_0.scrollView_:OnBeginDrag(arg_79_2)
end

function var_0_0.EndDragFun(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0.scrollView_:OnEndDrag(arg_80_2)
	arg_80_0:AddScrollTimer()
end

function var_0_0.Scroll2SelectItem(arg_81_0, arg_81_1)
	for iter_81_0, iter_81_1 in ipairs(arg_81_0.skinItemList_) do
		if iter_81_1.isActive then
			local var_81_0 = iter_81_1:GetSkinID() == arg_81_0.skinID_

			if var_81_0 then
				arg_81_0:AddMoveTimer(iter_81_1, arg_81_1)
			end

			iter_81_1:ShowSelect(var_81_0)
		end
	end
end

function var_0_0.GetNearestItem(arg_82_0)
	local var_82_0 = 9999
	local var_82_1
	local var_82_2 = arg_82_0.scrollTf_.rect.width / 2

	for iter_82_0, iter_82_1 in ipairs(arg_82_0.skinItemList_) do
		if iter_82_1.isActive then
			local var_82_3 = math.abs(arg_82_0.contentTf_.localPosition.x + iter_82_1:GetLocalPosition().x - var_82_2)

			if var_82_3 < var_82_0 then
				var_82_0 = var_82_3
				var_82_1 = iter_82_1
			end
		end
	end

	return var_82_1
end

function var_0_0.AddScrollTimer(arg_83_0)
	arg_83_0:StopScrollTimer()

	arg_83_0.scrollTimer_ = nil
	arg_83_0.scrollTimer_ = FrameTimer.New(function()
		if math.abs(arg_83_0.scrollView_.velocity.x) <= 100 then
			arg_83_0.scrollTimer_:Stop()
			arg_83_0:AdjustItem()
		end
	end, 1, -1)

	arg_83_0.scrollTimer_:Start()
end

function var_0_0.StopScrollTimer(arg_85_0)
	if arg_85_0.scrollTimer_ then
		arg_85_0.scrollTimer_:Stop()

		arg_85_0.scrollTimer_ = nil
	end
end

function var_0_0.AddMoveTimer(arg_86_0, arg_86_1, arg_86_2)
	arg_86_0:StopMoveTimer()

	arg_86_0.moveTimer_ = FrameTimer.New(function()
		local var_87_0 = arg_86_0.contentTf_.rect.width / 2
		local var_87_1 = arg_86_0.scrollTf_.rect.width / 2
		local var_87_2 = arg_86_0.contentTf_.localPosition
		local var_87_3 = arg_86_1:GetLocalPosition().x * -1 + var_87_1
		local var_87_4 = arg_86_2 * math.pow(arg_86_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_86_0.contentTf_.localPosition = Vector3.Lerp(var_87_2, Vector3.New(var_87_3, var_87_2.y, var_87_2.z), var_87_4)

		if math.abs(var_87_2.x - var_87_3) <= 1 then
			arg_86_0.contentTf_.localPosition = Vector3(var_87_3, var_87_2.y, var_87_2.z)

			arg_86_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_86_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_88_0)
	if arg_88_0.moveTimer_ then
		arg_88_0.moveTimer_:Stop()

		arg_88_0.moveTimer_ = nil
	end
end

function var_0_0.RefreshDlcMovie(arg_89_0)
	if isNil(arg_89_0.dlcMovie_) or isNil(arg_89_0.dlcPlayer_) then
		arg_89_0.dlcMovie_ = arg_89_0.dlcMovieGo_:GetComponent("CriManaMovieControllerForUI")
		arg_89_0.dlcPlayer_ = arg_89_0.dlcMovie_.player

		arg_89_0.dlcPlayer_:SetMaxPictureDataSize(300000)
	end

	if tostring(arg_89_0.dlcPlayer_.status) == "Playing" and arg_89_0.dlcPlayer_.IsPaused and arg_89_0.skinID_ == arg_89_0.movieSkinId_ then
		arg_89_0.dlcMovie_:Pause(false)

		return
	end

	if arg_89_0.movieSkinId_ and arg_89_0.movieSkinId_ ~= 0 and arg_89_0.skinID_ ~= arg_89_0.movieSkinId_ then
		arg_89_0.dlcMovie_:Stop()

		arg_89_0.mainMovieRaw_.material = nil

		arg_89_0:StopMovieStopTimer()

		arg_89_0.stopTimer_ = Timer.New(function()
			if tostring(arg_89_0.dlcPlayer_.status) == "Stop" then
				arg_89_0:StartMovie()
				arg_89_0:StopMovieStopTimer()

				return
			end
		end, 0.033, -1)

		arg_89_0.stopTimer_:Start()
	else
		arg_89_0:StartMovie()
	end
end

function var_0_0.StartMovie(arg_91_0)
	local var_91_0 = getShopCfg(arg_91_0.dlcID_)
	local var_91_1 = var_91_0.give_id or var_91_0.description

	if not var_91_0.give then
		local var_91_2 = 1
	end

	local var_91_3
	local var_91_4

	if var_91_0.description then
		local var_91_5 = var_91_0.description

		var_91_4 = RechargeShopDescriptionCfg[var_91_5]
	else
		var_91_4 = ItemCfg[var_91_1]
	end

	local var_91_6 = true

	for iter_91_0, iter_91_1 in ipairs(SkinSceneActionCfg.all) do
		local var_91_7 = SkinSceneActionCfg[iter_91_1]

		if var_91_7.special_scene_id == var_91_4.param[1] then
			arg_91_0.start_path = var_91_7.start_path

			arg_91_0:Play()

			arg_91_0.mainMovieRaw_.material = nil
			arg_91_0.bgMovieRaw_.material = nil

			arg_91_0:StopMovieTimer()

			arg_91_0.timer_ = Timer.New(function()
				if arg_91_0.dlcMovie_.isMaterialAvailable then
					local var_92_0 = arg_91_0.mainMovieRaw_.material

					arg_91_0.bgMovieRaw_.material = var_92_0

					arg_91_0:StopMovieTimer()

					if not arg_91_0:IsTop() then
						arg_91_0:PauseDlcMovie()
					end

					return
				end
			end, 0.033, -1)

			arg_91_0.timer_:Start()

			break
		end
	end
end

function var_0_0.PauseDlcMovie(arg_93_0)
	if arg_93_0.dlcMovie_ and arg_93_0.dlcPlayer_ then
		arg_93_0.dlcMovie_:Pause(true)
	end
end

function var_0_0.StopMovieTimer(arg_94_0)
	if arg_94_0.timer_ then
		arg_94_0.timer_:Stop()

		arg_94_0.timer_ = nil
	end
end

function var_0_0.StopMovieStopTimer(arg_95_0)
	if arg_95_0.stopTimer_ then
		arg_95_0.stopTimer_:Stop()

		arg_95_0.stopTimer_ = nil
	end
end

function var_0_0.Play(arg_96_0)
	arg_96_0.dlcPlayer_:SetFile(nil, arg_96_0.start_path, CriMana.Player.SetMode.New)

	local var_96_0 = manager.audio:GetMusicVolume()

	arg_96_0.dlcPlayer_:SetVolume(var_96_0)
	arg_96_0:SetVideoTrack(arg_96_0.dlcPlayer_, arg_96_0.start_path)

	arg_96_0.movieSkinId_ = arg_96_0.skinID_

	arg_96_0.dlcMovie_:Play()
end

function var_0_0.SetVideoTrack(arg_97_0, arg_97_1, arg_97_2)
	local var_97_0 = manager.audio:GetLocalizationFlag()
	local var_97_1 = 0
	local var_97_2

	for iter_97_0 in string.gmatch(arg_97_2, "[^/]+$") do
		var_97_2 = iter_97_0
	end

	local var_97_3 = VideoTrackCfg[var_97_2]

	if var_97_3 and var_97_3.has_tracks == 1 then
		if var_97_0 == "zh" then
			var_97_1 = 0
		elseif var_97_0 == "ja" then
			var_97_1 = 1
		elseif var_97_0 == "en" then
			var_97_1 = 2
		elseif var_97_0 == "kr" then
			var_97_1 = 3
		end
	end

	arg_97_1:SetAudioTrack(var_97_1)
	arg_97_1:SetSubtitleChannel(var_97_1)
end

return var_0_0
