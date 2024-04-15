slot0 = class("NewHeroSkinView", ReduxView)

function slot0.isUnlock(slot0, slot1)
	return HeroTools.GetHasOwnedSkin(slot1)
end

function slot0.isUnlockOrCanChange(slot0, slot1)
	return slot0:isUnlock(slot1) or HeroTools.CanChangeSkin(slot1)
end

function slot0.isSelect(slot0, slot1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[slot1].hero).id == slot1 then
		return true
	end

	return false
end

function slot0.UIName(slot0)
	return "Widget/System/Hero/HeroSkinUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.InitBtnState(slot0)
	slot0.btnState = {
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

function slot0.InitDescBtn(slot0)
	slot0.descBtn_ = {
		slot0.descBtn_1,
		slot0.descBtn_2,
		slot0.descBtn_3,
		slot0.descBtn_4,
		slot0.descBtn_5,
		slot0.descBtn_6,
		slot0.descBtn_7
	}
	slot0.descBtnGo_ = {}

	for slot4 = 1, 7 do
		slot0.descBtnGo_[slot4] = slot0["descBtnGo_" .. slot4]
	end
end

function slot0.Init(slot0)
	slot0.skinIdList_ = {}
	slot0.skinItemList_ = {}
	slot0.descInfoList_ = {}
	slot0.btnState_ = nil
	slot0.skinID_ = 1
	slot0.selectIndex_ = 1
	slot0.isCanUnlock_ = false
	slot0.dlcMovie_ = nil
	slot0.dlcPlayer_ = nil

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitBtnState()
	slot0:InitDescBtn()

	slot0.haveDLCController_ = slot0.controllerEx_:GetController("haveDLC")
	slot0.timeController_ = slot0.controllerEx_:GetController("Time")
	slot0.giftController_ = slot0.controllerEx_:GetController("Gift")
	slot0.plotController_ = slot0.controllerEx_:GetController("Plot")
	slot0.infoController_ = slot0.controllerEx_:GetController("Info")
	slot0.statusController_ = slot0.controllerEx_:GetController("Btn")
	slot0.dlcController_ = slot0.controllerEx_:GetController("DLC")
	slot0.dlcBtnController_ = slot0.controllerEx_:GetController("dlcBtn")
	slot0.unlockController_ = slot0.lockControllerEx_:GetController("clear")
	slot0.taskController_1 = slot0.lockControllerEx_:GetController("task01")
	slot0.taskController_2 = slot0.lockControllerEx_:GetController("task02")
	slot0.dlc_skinController_ = slot0.dlc_skinControllerEx_:GetController("get")
	slot0.dlc_dlcController_ = slot0.dlc_dlcControllerEx_:GetController("get")
end

function slot0.AddUIListener(slot0)
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
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		uv0.params_.skinID = uv0.skinID_

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = HeroTools.GetSkinChangeItem(uv0.skinID_)
				},
				use_list = {}
			}
		})
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

	slot4 = slot0.plotTalkMaskBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0.plotController_:SetSelectedState("off")

		uv0.isOpenPlotTalk = false
	end)

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
						shopId = uv0.shop_id
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

function slot0.CheckIsSpecial(slot0)
	if not slot0.dlcID_ then
		slot0:SetCurDlcID()
	end

	slot0.shopDlcCfg = getShopCfg(slot0.dlcID_)

	if slot0.shopDlcCfg and slot0.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		return 1
	end

	return 0
end

function slot0.SwitchInfoController(slot0, slot1)
	slot0.infoController_:SetSelectedState(slot1)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
	slot0:RefreshUIWithOutScroll()

	if slot0.showDlcState_ == 1 then
		slot0:RefreshDlcMovie()
	end
end

function slot0.OnBehind(slot0)
	if slot0.showDlcState_ == 1 then
		slot0:PauseDlcMovie()
	end
end

function slot0.IndexPlotItem(slot0)
	if not slot0.plotItemList_ then
		slot0.plotItemList_ = {}
	end

	slot1 = SkinCfg[slot0.skinID_]
	slot2 = slot1.plot_title
	slot3 = slot1.plot_id

	for slot7, slot8 in ipairs(slot0.plotItemList_) do
		SetActive(slot8.gameObject_, false)
	end

	for slot7 = 1, #slot2 do
		if not slot0.plotItemList_[slot7] then
			slot8 = Object.Instantiate(slot0.plotTalkBtn_.gameObject)
			slot9 = PlotTalkItem.New(slot8)

			slot8.transform:SetParent(slot0.plotTalkBasePanelGo_.transform, false)
			slot9:SetCallBack(function ()
				uv0.plotController_:SetSelectedState("off")

				uv0.isOpenPlotTalk = false
			end)
			table.insert(slot0.plotItemList_, slot9)
		end

		slot0.plotItemList_[slot7]:RefreshUI(slot2[slot7], slot3[slot7])
		SetActive(slot0.plotItemList_[slot7].gameObject_, true)
	end
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
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
		slot0:SetButtonActive(2)
		manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. slot4, 0, RedPointStyle.SHOW_NEW_TAG)
	else
		ShowTips(slot1.result)
	end

	slot0:RefreshUI()
end

function slot0.OnSelectSkin(slot0, slot1, slot2)
	slot0:SetButtonActive(1)
end

function slot0.OnEnter(slot0)
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

		slot0:ChangeShowDlcState(0)
	else
		slot0:ChangeShowDlcState(slot0.showDlcState_)
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
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
	slot0:Scroll2SelectItem(100)
end

function slot0.RefreshShop(slot0)
	slot0:RefreshCurrencyToken(false)
end

function slot0.RefreshCurrencyToken(slot0, slot1)
	SetActive(slot0.tokenGo_, slot1)
	SetActive(slot0.dlctokenGo_, slot1)
	SetActive(slot0.tokenNumGo_, slot1)
end

function slot0.CameraEnter(slot0)
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

function slot0.OnExit(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	slot0:StopMovieStopTimer()
	slot0:StopMovieTimer()
	slot0:StopMoveTimer()
	slot0:CleanMessage()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0:RemoveAllEventListener()
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	if slot0.dlcPlayer_ then
		slot0.dlcPlayer_.statusChangeCallback = nil
	end

	if slot0.dlcMovie_ then
		slot0.dlcMovie_:Stop()
	end

	slot0.dlcPlayer_ = nil
	slot0.dlcMovie_ = nil
	slot0.movieSkinId_ = 0

	HeroSkinRouteData:SaveRoute({
		heroID = slot0.heroID_,
		skinID = slot0.skinID_
	})
end

function slot0.RefreshUI(slot0)
	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. slot0.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)
	slot0:RefreshInfo()
	slot0:RefreshDlcBtn()
	slot0:SetButtonActive(slot0:SkinState(slot0.skinID_))
	slot0:RefreshDescBtn()
	slot0:RefreshGiftBtn()
	slot0:HideMessage()
	slot0:RefreshItemData()
	slot0:RefreshSkinItemList()
	SetActive(slot0.plotBtn_, #SkinCfg[slot0.skinID_].plot_title > 0)

	for slot4, slot5 in ipairs(slot0.skinItemList_) do
		if slot5.isActive and slot5:GetSkinID() == slot0.skinID_ then
			slot0.selectIndex_ = slot4
		end
	end
end

function slot0.RefreshSkinItemList(slot0)
	if slot0.skinIdList_ and #slot0.skinIdList_ > 0 then
		for slot4, slot5 in pairs(slot0.skinItemList_) do
			slot5:SetActive(false)
		end

		for slot4, slot5 in ipairs(slot0.skinIdList_) do
			slot6 = nil

			if slot0.skinItemList_[slot4] then
				slot6 = slot0.skinItemList_[slot4]
			else
				slot6 = NewHeroSkinItem.New(slot0.itemGo_, slot0.contentTf_)

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

function slot0.RefreshDlcBtn(slot0)
	slot0.dlc_skinImage_.sprite = HeroTools.GetHeadSprite(slot0.skinID_)

	if slot0:JudgeDLC(slot0.skinID_) then
		slot0:SetCurDlcID()

		if getShopCfg(slot0.dlcID_) and (slot1.give_id or slot1.description) then
			slot0.dlc_dlcImage_.sprite = ItemTools.getItemSprite(slot2)
		end
	else
		slot0:SetCurDlcID()
	end
end

function slot0.RefreshLimitTime(slot0, slot1)
	slot3 = 0
	slot4 = 0

	for slot8, slot9 in ipairs(HeroData:GetHeroData(slot0.heroID_).unlocked_skin) do
		if slot9.skin_id == slot1 then
			slot3 = slot9.time

			if slot0:JudgeDLC(slot1) then
				if not HeroTools.GetShopIdBySkinId(slot1) then
					return false
				end

				if getShopCfg(slot10) and slot11.dlc and slot12 ~= 0 then
					slot4 = HomeSceneSettingData:GetSceneTimeStamp(ShopCfg[slot12].description) or 0
				end
			end
		end
	end

	if slot3 ~= 0 then
		slot0.skinLimitTimeText_.text = string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", slot3) .. " ")
	else
		slot0.skinLimitTimeText_.text = string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", slot4) .. " ")
	end

	SetActive(slot0.LimitTimeGo_, slot3 ~= 0 or slot4 ~= 0)
	SetActive(slot0.skinLimitTimeGo_, slot3 ~= 0)
	SetActive(slot0.dlcLimitTimeGo_, slot4 ~= 0)
end

function slot0.RefreshUIWithOutScroll(slot0)
	slot0:RefreshInfo()
	slot0:SetButtonActive(slot0:SkinState(slot0.skinID_))
end

function slot0.RefreshItemData(slot0)
	slot0.skinIdList_ = {}
	slot4 = slot0.heroID_

	for slot4, slot5 in ipairs(SkinCfg.get_id_list_by_hero[slot4]) do
		if not HeroTools.GetIsSkinHide(slot5) then
			if slot0:isUnlock(slot5) then
				table.insert(slot0.skinIdList_, slot5)
			elseif HeroTools.CanChangeSkin(slot5) then
				table.insert(slot0.skinIdList_, slot5)
			elseif HeroTools.GetIsLimitTimeSkin(slot5) then
				table.insert(slot0.skinIdList_, slot5)
			elseif SDKTools.GetIsOverSea() then
				table.insert(slot0.skinIdList_, slot5)
			elseif SkinCfg[slot5].display_type == 1 then
				table.insert(slot0.skinIdList_, slot5)
			end
		end
	end

	if slot0.params_.skinID and not table.indexof(slot0.skinIdList_, slot0.params_.skinID) then
		table.insert(slot0.skinIdList_, slot0.params_.skinID)
	end
end

function slot0.RefreshButton(slot0, slot1)
	slot0.selectIndex_ = slot1.index_
	slot2 = slot1:SkinState()
	slot4 = SkinCfg[slot1.skinID_].hero

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
	slot0:CheckDlc(slot3, slot2)
	slot0:RefreshDlcBtn()
	slot0:RefreshDescBtn()
	slot0:RefreshGiftBtn()
	slot0:HideMessage()
	slot0:RefreshUI()
	slot0:Scroll2SelectItem(5)
	slot0:RefreshLimitTime(slot0.skinID_)
end

function slot0.CheckDlc(slot0, slot1, slot2)
	slot0.haveDLCController_:SetSelectedIndex(0)

	if slot0:JudgeDLC(slot1) then
		slot0.haveDLCController_:SetSelectedIndex(1)
	end
end

function slot0.JudgeDLC(slot0, slot1)
	if slot1 == nil then
		return false
	end

	if not HeroTools.GetShopIdBySkinId(slot1) then
		return false
	end

	if getShopCfg(slot2) and slot3.dlc and slot4 ~= 0 then
		return true
	end

	return false
end

function slot0.SetCurDlcID(slot0)
	slot0.dlcID_ = getShopCfg(HeroTools.GetShopIdBySkinId(slot0.skinID_)) and slot2.dlc
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.SetButtonActive(slot0, slot1)
	slot0:CheckDlc(slot0.skinID_, slot1)

	if slot0:JudgeDLC(slot0.skinID_) then
		slot0.dlc_dlcController_:SetSelectedState(tostring(ShopTools.CheckDlcPurchased(slot0.dlcID_)))
	end

	slot0.dlc_skinController_:SetSelectedState(tostring(HeroTools.GetHasOwnedSkin(slot0.skinID_)))

	if slot0.btnState_ == slot1 then
		return
	end

	slot0.statusController_:SetSelectedIndex(slot1 - 1)

	slot0.btnState_ = slot1

	slot0:UpdateBar()
end

function slot0.ChangeShowDlcState(slot0, slot1)
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

	slot0:ChangeDlcBtn()
	slot0:SetButtonActive(slot0:SkinState(slot0.skinID_))
	slot0:RefreshInfo()
end

function slot0.SkinState(slot0, slot1)
	slot0:ChangeDlcBtn()

	if slot0:isUnlock(slot1) then
		if slot0:isSelect(slot1) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(slot1) then
			if slot0:isSelect(slot1) then
				if HeroTools.IsSkinOutOfDate(slot1) or slot0.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(slot1) or slot0.showDlcState_ == 1 then
				return 2
			else
				return 11
			end
		end

		if HeroTools.CanChangeSkin(slot1) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(slot1) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(slot1) then
			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB(HeroTools.GetShopIdBySkinId(slot0.skinID_)) then
			return 12
		end

		return 3
	end
end

function slot0.CheckSpecicalTable(slot0, slot1, slot2)
	for slot6 = 1, #slot1 do
		if slot1[slot6] ~= slot2[slot6] then
			return false
		end
	end

	return true
end

function slot0.ChangeDlcBtnSpecial(slot0)
	if slot0:CheckSpecicalTable({
		slot0:isUnlock(slot0.skinID_) and 1 or 0,
		ShopTools.CheckDlcPurchased(slot0.dlcID_) and 1 or 0,
		slot0.showDlcState_
	}, {
		0,
		0,
		0
	}) then
		slot0:SetButtonActive(3)
		slot0.dlcBtnController_:SetSelectedIndex(0)
	elseif slot0:CheckSpecicalTable(slot4, {
		0,
		0,
		1
	}) then
		slot0:SetButtonActive(3)
		slot0.dlcBtnController_:SetSelectedIndex(2)
	elseif slot0:CheckSpecicalTable(slot4, {
		0,
		1,
		0
	}) then
		slot0:SetButtonActive(3)
		slot0.dlcBtnController_:SetSelectedIndex(0)
	elseif slot0:CheckSpecicalTable(slot4, {
		0,
		1,
		1
	}) then
		slot0:SetButtonActive(3)
		slot0.dlcBtnController_:SetSelectedIndex(3)
	elseif slot0:CheckSpecicalTable(slot4, {
		1,
		0,
		0
	}) then
		slot0:SetButtonActive(8)
		slot0.dlcBtnController_:SetSelectedIndex(2)
	elseif slot0:CheckSpecicalTable(slot4, {
		1,
		0,
		1
	}) then
		slot0:SetButtonActive(9)
		slot0.dlcBtnController_:SetSelectedIndex(2)
	elseif slot0:CheckSpecicalTable(slot4, {
		1,
		1,
		0
	}) then
		slot0:SetButtonActive(8)
		slot0.dlcBtnController_:SetSelectedIndex(0)
	elseif slot0:CheckSpecicalTable(slot4, {
		1,
		1,
		1
	}) then
		slot0:SetButtonActive(8)
		slot0.dlcBtnController_:SetSelectedIndex(0)
	end
end

function slot0.ChangeDlcBtn(slot0)
	slot0.dlcBtnController_:SetSelectedIndex(0)

	if slot0:CheckIsSpecial() == 1 then
		slot0:ChangeDlcBtnSpecial()

		return
	end

	if slot0.showDlcState_ == 1 and (slot0:isUnlock(slot0.skinID_) or HeroTools.GetIsLimitTimeSkin(slot0.skinID_)) and slot0:JudgeDLC(slot0.skinID_) and not ShopTools.CheckDlcPurchased(slot0.dlcID_) and ShopTools.CheckShopIsUnLock(getShopCfg(slot0.dlcID_).shop_id) and ShopTools.IsGoodCanDisplay(slot1.shop_id, slot1.goods_id) then
		slot0.dlcBtnController_:SetSelectedIndex(1)
	end
end

function slot0.HaveMaterial(slot0)
	slot1 = getShopCfg(HeroTools.GetShopIdBySkinId(slot0.skinID_))

	return ItemCfg[slot1.cost_id], ItemTools.getItemNum(slot1.cost_id)
end

function slot0.RefreshDescBtn(slot0)
	slot0.typeNum_ = 0
	slot0.typeDes_ = {}

	SetActive(slot0.battleBtn_.gameObject, SkinTagCfg[slot0.skinID_] ~= nil)

	if not slot1 then
		for slot5, slot6 in ipairs(slot0.descBtnGo_) do
			SetActive(slot6, false)
			slot0:SwitchInfoController("description")
			SetActive(slot0.switchInfoIconGo_, false)

			slot0.switchInfoBtn_.interactable = false

			return
		end
	end

	for slot6, slot7 in ipairs(slot1.tag) do
		if not slot0.typeDes_[SkinTagDescCfg[slot7].type] then
			slot0.typeDes_[slot9] = {}
			slot0.typeNum_ = slot0.typeNum_ + 1
		end

		table.insert(slot0.typeDes_[slot9], slot7)
	end

	for slot6, slot7 in ipairs(slot0.descBtnGo_) do
		SetActive(slot7, slot0.typeDes_[slot6] ~= nil)
	end

	if slot0.typeNum_ == 0 then
		slot0:SwitchInfoController("description")
		SetActive(slot0.switchInfoIconGo_, false)

		slot0.switchInfoBtn_.interactable = false
	else
		slot0:SwitchInfoController("tag")
		SetActive(slot0.switchInfoIconGo_, true)

		slot0.switchInfoBtn_.interactable = true
	end
end

function slot0.RefreshInfo(slot0)
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

	if slot0.btnState_ == 5 then
		if HeroTools.CanChangeSkin(slot0.skinID_) then
			manager.redPoint:SetRedPointIndependent(slot0.changeBtn_.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(slot0.changeBtn_.transform, false)
		end
	end

	if slot0.btnState_ == 6 then
		slot0.isCanUnlock_ = true
		slot5 = slot0.skinID_

		for slot5, slot6 in pairs(SkinCfg[slot5].unlock_id_list) do
			slot7, slot8, slot9 = IsConditionAchieved(slot6, {
				heroId = slot0.heroID_
			})

			if slot7 then
				slot0["taskController_" .. slot5]:SetSelectedState("true")
			else
				slot0.isCanUnlock_ = false

				slot0["taskController_" .. slot5]:SetSelectedState("false")
			end

			slot0["tasktext_" .. slot5].text = GetI18NText(ConditionCfg[slot6].desc)
		end

		slot0.unlockController_:SetSelectedState(slot0.isCanUnlock_ and "false" or "true")
	end

	slot0:RefreshLimitTime(slot0.skinID_)
end

function slot0.OnShopBuyResult(slot0)
	slot0:RefreshUI()
end

function slot0.OnGetSkinGift(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshGiftBtn(slot0)
	if #((SkinCfg[slot0.skinID_] or {}).gift or {}) > 0 and PlayerData:IsNotReceived(slot0.skinID_) then
		SetActive(slot0.giftBtn_, true)
	else
		SetActive(slot0.giftBtn_, false)
	end

	SetActive(slot0.giftRedGo_, #slot2 > 0 and slot0:isUnlock(slot0.skinID_) and PlayerData:IsNotReceived(slot0.skinID_))
	slot0.giftController_:SetSelectedState(slot0:isUnlock(slot0.skinID_) and "take" or "check")
end

function slot0.HideMessage(slot0)
	SetActive(slot0.descPanel_, false)
end

function slot0.ShowMessage(slot0)
	if #slot0.descInfoList_ == 0 then
		for slot4, slot5 in pairs(slot0.typeDes_) do
			slot0.descInfoList_[slot4] = SkinDescInfoItem.New(Object.Instantiate(slot0.descContent_, slot0.descTipsContent_), slot5, slot4)

			slot0.descInfoList_[slot4]:RefreshUI()
			slot0.descInfoList_[slot4]:Show(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.descPanelRect_)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.descPanelRect_)
	SetActive(slot0.descPanel_, true)
	SetActive(slot0.hideMessageGo_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.descPanelRect_)
end

function slot0.CleanMessage(slot0)
	for slot4, slot5 in pairs(slot0.descInfoList_) do
		slot5:Dispose()
	end

	slot0.descInfoList_ = {}
end

function slot0.SaveRoute(slot0)
	SkinTrialData:SaveRoute({
		name = "heroSkin",
		skinID = slot0.skinID_,
		heroID = slot0.heroID_
	})
end

function slot0.Dispose(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	slot0:StopMovieStopTimer()
	slot0:StopMovieTimer()
	slot0:StopMoveTimer()
	slot0:RemoveAllListeners()
	slot0:CleanMessage()

	if slot0.plotItemList_ then
		for slot4, slot5 in ipairs(slot0.plotItemList_) do
			slot5:Dispose()
		end

		slot0.plotItemList_ = nil
	end

	if slot0.skinItemList_ then
		for slot4, slot5 in ipairs(slot0.skinItemList_) do
			slot5:Dispose()
		end

		slot0.skinItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.PlayVoice(slot0)
	if slot0.delayPlayTimer_ then
		return
	end

	HeroTools.PlayVoice(slot0.heroID_, "cloth")

	slot0.delayPlayTimer_ = Timer.New(function ()
		if uv0.delayPlayTimer_ then
			uv0.delayPlayTimer_:Stop()

			uv0.delayPlayTimer_ = nil
		end
	end, 10, -1)

	slot0.delayPlayTimer_:Start()
end

function slot0.SetReturnBtn(slot0, slot1)
	SetActive(slot0.hideMessageGo_, true)
	slot0:RemoveBtnListener(nil, slot0.hideMessageBtn_.transform)
	slot0:AddBtnListener(slot0.hideMessageBtn_, nil, function ()
		uv0()
		SetActive(uv1.hideMessageGo_, false)
	end)
end

function slot0.AdjustItem(slot0)
	slot0:RefreshButton(slot0:GetNearestItem())
end

function slot0.RefreshItemScale(slot0)
	for slot4, slot5 in pairs(slot0.skinItemList_) do
		if slot5.isActive then
			slot5:RefreshShow()
		end
	end
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	slot0:StopMoveTimer()
	slot0:StopScrollTimer()
	slot0.scrollView_:OnBeginDrag(slot2)
end

function slot0.EndDragFun(slot0, slot1, slot2)
	slot0.scrollView_:OnEndDrag(slot2)
	slot0:AddScrollTimer()
end

function slot0.Scroll2SelectItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.skinItemList_) do
		if slot6.isActive then
			if slot6:GetSkinID() == slot0.skinID_ then
				slot0:AddMoveTimer(slot6, slot1)
			end

			slot6:ShowSelect(slot7)
		end
	end
end

function slot0.GetNearestItem(slot0)
	slot2 = nil

	for slot7, slot8 in ipairs(slot0.skinItemList_) do
		if slot8.isActive and math.abs(slot0.contentTf_.localPosition.x + slot8:GetLocalPosition().x - slot0.scrollTf_.rect.width / 2) < 9999 then
			slot1 = slot9
			slot2 = slot8
		end
	end

	return slot2
end

function slot0.AddScrollTimer(slot0)
	slot0:StopScrollTimer()

	slot0.scrollTimer_ = nil
	slot0.scrollTimer_ = FrameTimer.New(function ()
		if math.abs(uv0.scrollView_.velocity.x) <= 100 then
			uv0.scrollTimer_:Stop()
			uv0:AdjustItem()
		end
	end, 1, -1)

	slot0.scrollTimer_:Start()
end

function slot0.StopScrollTimer(slot0)
	if slot0.scrollTimer_ then
		slot0.scrollTimer_:Stop()

		slot0.scrollTimer_ = nil
	end
end

function slot0.AddMoveTimer(slot0, slot1, slot2)
	slot0:StopMoveTimer()

	slot0.moveTimer_ = FrameTimer.New(function ()
		slot0 = uv0.contentTf_.rect.width / 2
		slot2 = uv0.contentTf_.localPosition
		slot3 = uv1:GetLocalPosition().x * -1 + uv0.scrollTf_.rect.width / 2
		uv0.contentTf_.localPosition = Vector3.Lerp(slot2, Vector3.New(slot3, slot2.y, slot2.z), uv2 * math.pow(uv0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(slot2.x - slot3) <= 1 then
			uv0.contentTf_.localPosition = Vector3(slot3, slot2.y, slot2.z)

			uv0:StopMoveTimer()
		end
	end, 1, -1)

	slot0.moveTimer_:Start()
end

function slot0.StopMoveTimer(slot0)
	if slot0.moveTimer_ then
		slot0.moveTimer_:Stop()

		slot0.moveTimer_ = nil
	end
end

function slot0.RefreshDlcMovie(slot0)
	if isNil(slot0.dlcMovie_) or isNil(slot0.dlcPlayer_) then
		slot0.dlcMovie_ = slot0.dlcMovieGo_:GetComponent("CriManaMovieControllerForUI")
		slot0.dlcPlayer_ = slot0.dlcMovie_.player

		slot0.dlcPlayer_:SetMaxPictureDataSize(300000)
	end

	if tostring(slot0.dlcPlayer_.status) == "Playing" and slot0.dlcPlayer_.IsPaused and slot0.skinID_ == slot0.movieSkinId_ then
		slot0.dlcMovie_:Pause(false)

		return
	end

	if slot0.movieSkinId_ and slot0.movieSkinId_ ~= 0 and slot0.skinID_ ~= slot0.movieSkinId_ then
		slot0.dlcMovie_:Stop()

		slot0.mainMovieRaw_.material = nil

		slot0:StopMovieStopTimer()

		slot0.stopTimer_ = Timer.New(function ()
			if tostring(uv0.dlcPlayer_.status) == "Stop" then
				uv0:StartMovie()
				uv0:StopMovieStopTimer()

				return
			end
		end, 0.033, -1)

		slot0.stopTimer_:Start()
	else
		slot0:StartMovie()
	end
end

function slot0.StartMovie(slot0)
	slot3 = slot1.give or 1
	slot4, slot5 = nil
	slot6 = true

	for slot10, slot11 in ipairs(SkinSceneActionCfg.all) do
		if SkinSceneActionCfg[slot11].special_scene_id == ((not slot1.description or RechargeShopDescriptionCfg[slot1.description]) and ItemCfg[getShopCfg(slot0.dlcID_).give_id or slot1.description]).param[1] then
			slot0.start_path = slot12.start_path

			slot0:Play()

			slot0.mainMovieRaw_.material = nil
			slot0.bgMovieRaw_.material = nil

			slot0:StopMovieTimer()

			slot0.timer_ = Timer.New(function ()
				if uv0.dlcMovie_.isMaterialAvailable then
					uv0.bgMovieRaw_.material = uv0.mainMovieRaw_.material

					uv0:StopMovieTimer()

					if not uv0:IsTop() then
						uv0:PauseDlcMovie()
					end

					return
				end
			end, 0.033, -1)

			slot0.timer_:Start()

			break
		end
	end
end

function slot0.PauseDlcMovie(slot0)
	if slot0.dlcMovie_ and slot0.dlcPlayer_ then
		slot0.dlcMovie_:Pause(true)
	end
end

function slot0.StopMovieTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.StopMovieStopTimer(slot0)
	if slot0.stopTimer_ then
		slot0.stopTimer_:Stop()

		slot0.stopTimer_ = nil
	end
end

function slot0.Play(slot0)
	slot0.dlcPlayer_:SetFile(nil, slot0.start_path, CriMana.Player.SetMode.New)
	slot0.dlcPlayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0:SetVideoTrack(slot0.dlcPlayer_, slot0.start_path)

	slot0.movieSkinId_ = slot0.skinID_

	slot0.dlcMovie_:Play()
end

function slot0.SetVideoTrack(slot0, slot1, slot2)
	slot3 = manager.audio:GetLocalizationFlag()
	slot4 = 0
	slot5 = nil
	slot9 = "[^/]+$"

	for slot9 in string.gmatch(slot2, slot9) do
		slot5 = slot9
	end

	if VideoTrackCfg[slot5] and slot6.has_tracks == 1 then
		if slot3 == "zh" then
			slot4 = 0
		elseif slot3 == "ja" then
			slot4 = 1
		elseif slot3 == "en" then
			slot4 = 2
		elseif slot3 == "kr" then
			slot4 = 3
		end
	end

	slot1:SetAudioTrack(slot4)
	slot1:SetSubtitleChannel(slot4)
end

return slot0
