slot0 = class("RestaurantMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1(slot0)
	if slot0 == "back" then
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	elseif slot0 == "main" then
		BackHomeTools:BackHomeGotoMain()
	end
end

function slot2(slot0)
	uv0:UnUsualExitManualMode()
	uv1(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:InitAwardBubble()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitController()
	slot0:InitAnimation()
	slot0:InitAutoAward()

	slot0.signFoodListScroll_ = LuaList.New(handler(slot0, slot0.indexSignFoodList), slot0.signfoodlistUilist_, NeedCookFoodItem)
	slot0.autoScrollTime = GameDisplayCfg.canteen_roller_speed.value[1]
	slot0.quickView = BackHomeQuickJumpView.New(slot0.tempquickGo_)
end

function slot0.InitController(slot0)
	slot0.stateController = ControllerUtil.GetController(slot0.statusGo_.transform, "state")
	slot0.manualViewController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.switchBtnController = ControllerUtil.GetController(slot0.switchTrs_, "state")
	slot0.hideButtonController = ControllerUtil.GetController(slot0.transform_, "hide")
end

function slot0.InitAnimation(slot0)
	slot0.moneyAnimator = slot0:FindCom(typeof(Animator), "", slot0.emptydreamcanteenitemTrs_)
	slot0.leableAnimator = slot0:FindCom(typeof(Animator), "", slot0.labelTrs_)
	slot0.tipsAnimation = slot0.deficiencytipsGo_:GetComponent("Animation")
end

function slot0.InitAutoAward(slot0)
	slot0.offset = 200
	slot0.currencyiconImg_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_DORM_GOLD.item_id)
end

function slot0.OnEnter(slot0)
	slot0:RefreshBar()
	slot0:BindRedPoint()
	slot0:RegisterEvents()
	slot0:UpdateView()

	slot0.canJump = true

	slot0.moneyAnimator:Update(0)
	slot0.quickView:OnEnter()
	slot0.tempquickGo_.transform:SetAsLastSibling()
	slot0.quickView:ShowView(false)
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_DORM_GOLD
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_DORM_GOLD, true)

	if #GameSetting.canteen_festival_info_describe.value > 0 then
		manager.windowBar:SetGameHelpKey({
			view = "/gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				isPrefab = true,
				pages = slot1
			}
		})
	end

	manager.windowBar:RegistBackCallBack(function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CANTEEN_QUIT_CONFIRM"),
				OkCallback = function ()
					uv0("back")
				end,
				CancelCallback = function ()
				end
			})
		else
			uv1("back")
		end
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CANTEEN_QUIT_CONFIRM"),
				OkCallback = function ()
					uv0("main")
				end,
				CancelCallback = function ()
				end
			})
		else
			uv1("main")
		end
	end)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:bindUIandKey(slot0.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:bindUIandKey(slot0.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	manager.redPoint:bindUIandKey(slot0.recipebtnBtn_.transform, RedPointConst.CANTEEN_UNLOCK_FOOD)
end

function slot0.UpdateView(slot0)
	slot0:UpdataPopularity()
	slot0:UpdataSignFoodList()
	CanteenData:ChooseCanteenAutoState()
end

function slot0.UpdataPopularity(slot0)
	slot0.popnumText_.text = CanteenData:GetPopularityNum()
end

function slot0.UpdataSignFoodList(slot0)
	slot0.signFoodList = {}
	slot1 = 1

	if #CanteenFoodData:GetChooseFoodList() > 2 then
		while slot1 <= 2 do
			for slot6, slot7 in ipairs(slot2) do
				table.insert(slot0.signFoodList, slot7)
			end

			slot1 = slot1 + 1
		end
	else
		for slot6, slot7 in ipairs(slot2) do
			table.insert(slot0.signFoodList, slot7)
		end
	end

	slot0.signFoodListScroll_:StartScroll(#slot0.signFoodList)
	slot0:UpdateFoodScroll()
end

function slot0.indexSignFoodList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.signFoodList[slot1])
end

function slot0.UpdateFoodScroll(slot0)
	slot0.index = 1

	if #slot0.signFoodList >= 6 then
		slot0:StartAutoScroll()

		if not slot0.AutoScrollTimer then
			slot0.AutoScrollTimer = Timer.New(handler(slot0, slot0.StartAutoScroll), slot0.autoScrollTime, -1)

			slot0.AutoScrollTimer:Start()
		end
	end
end

function slot0.StartAutoScroll(slot0)
	slot0.index = slot0.index + 1

	if #slot0.signFoodList - 1 == slot0.index then
		slot0.index = slot1 / 2 - 2

		slot0.signFoodListScroll_:ScrollToIndex(slot0.index, false, false)

		slot0.index = slot0.index + 1

		slot0.signFoodListScroll_:ScrollToIndex(slot0.index, false, true, slot0.autoScrollTime)
	else
		slot0.signFoodListScroll_:ScrollToIndex(slot0.index, false, true, slot0.autoScrollTime)
	end

	slot0.signfoodlistUilist_:GetComponent("ScrollRectEx").horizontal = false
end

function slot0.EndAutoScroll(slot0)
	if slot0.AutoScrollTimer then
		slot0.AutoScrollTimer:Stop()

		slot0.AutoScrollTimer = nil

		slot0.signFoodListScroll_:RemoveTween()
	end
end

function slot0.InitAwardBubble(slot0)
	slot0:UpdataAwardBubble()

	slot0.atuoAwardTrsTimer = FrameTimer.New(function ()
		uv0:UpdataAwardBubbleTrs()
		uv0:UpdataAwardBubble()
	end, 0.03333333333333333, -1)

	slot0.atuoAwardTrsTimer:Start()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.startautomoduleBtn_, nil, function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantAuto)

			return
		end
	end)
	slot0:AddBtnListenerScale(slot0.manualbtnBtn_, nil, function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
			return
		end

		if not CanteenTools:AutoModeReadyForBusiness() then
			return
		end

		ShowMessageBox({
			isTop = true,
			content = GetTips("CANTEEN_MANNUALLY_OPT"),
			OkCallback = function ()
				CanteenData:SetCanteenState(DormEnum.RestaurantMode.RestaurantManual)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListenerScale(slot0.shopbtnBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.GoToSystem("/activityShop", {
				hideHomeBtn = 1,
				shopId = ShopConst.SHOP_ID.CANTEEN_SHOP,
				showShops = {
					ShopConst.SHOP_ID.CANTEEN_SHOP
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	slot0:AddBtnListenerScale(slot0.taskbtnBtn_, nil, function ()
		if uv0.canJump then
			DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_NONE, DormRedPointTools.RedPointType.Session)
			JumpTools.OpenPageByJump("/dormTaskDispatchView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.signfoodBtn_, nil, function ()
		if uv0.canJump then
			if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
				return
			end

			JumpTools.OpenPageByJump("/chooseSignFoodView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.recipebtnBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.foodMenu
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.warehousebtnBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantFoodMenuView", {
				state = DormEnum.MenuType.bag
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.hidebtnBtn_, nil, function ()
		if uv0.hideButtonController:GetSelectedState() == "false" then
			uv0.hideButtonController:SetSelectedState("true")
		else
			uv0.hideButtonController:SetSelectedState("false")
			uv0.leableAnimator:SetFloat("speed", 1)
			uv0.leableAnimator:Play("ShowLabel")
		end
	end)
	slot0:AddBtnListenerScale(slot0.autoAwardBtn_, nil, function ()
		slot0, slot1 = CanteenData:GetAutoNextAwardTime()

		if slot0 < 0 and slot1 < 0 then
			if CanteenData:GetAutoAwardNum() == 0 then
				ShowTips("CANTEEN_ADMITTED_NULL")

				return
			end

			if DormData:GetCurrectSceneID() then
				CanteenAction:ReceiveCanteenAutoAward(slot2)
			end

			uv0.moneyAnimator:Play("GetMoney", 0, 0)
			manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_coin", "")

			uv0.canJump = false

			if uv0.canJumpTimer then
				uv0.canJumpTimer:Stop()

				uv0.canJumpTimer = nil
			end

			uv0.canJumpTimer = Timer.New(function ()
				uv0.canJump = true
			end, 0.3, 1)

			uv0.canJumpTimer:Start()
		end
	end)
	slot0:AddBtnListenerScale(slot0.jobSetBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantJobSetView")
			DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_JOB_AVAILABLE, DormRedPointTools.RedPointType.Session)
		end
	end)
	slot0:AddBtnListenerScale(slot0.cookBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.lackBtn_, nil, function ()
		if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
			if BackHomeNpcData:CheckNpsIsWorkInCanteen() then
				slot1 = nil

				for slot5, slot6 in ipairs(DormNpcTools.BackHomeNpcType) do
					if DormNpcTools:CheckHasNpcWorkOnJob(slot6) then
						slot1 = slot6
					end
				end

				JumpTools.OpenPageByJump("/restaurantJobSetView", {
					jobType = slot1
				})
			end
		elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
			if not CanteenTools:CheckSignFoodNumCanOpen() then
				JumpTools.OpenPageByJump("/chooseSignFoodView", {
					type = DormEnum.FurnitureTypeNum.Pan1
				})
			elseif not CanteenTools:CheckCanteenJobCanOpen() then
				JumpTools.OpenPageByJump("/restaurantJobSetView")
				DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_JOB_AVAILABLE, DormRedPointTools.RedPointType.Session)
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.canteenInfoBtn_, nil, function ()
		if uv0.canJump then
			JumpTools.OpenPageByJump("/canteenAutoInfoView")
		end
	end)
	slot0.quickView:AddClickCallBack(function ()
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DORM_GOLD
		})
	end)
	slot0.quickView:CloseCallBack(function ()
		uv0:RefreshBar()
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_RESTAURANT_STATUS_EVENT, function (slot0)
		uv0:UpdataCanteenState()
	end)
	slot0:RegistEventListener(CANTEEN_UPDATE_STATE, function ()
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(CANTEEN_SIGN_FOOD_NUM_CHANGE, function ()
		uv0.signFoodListScroll_:Refresh()
	end)
	slot0:RegistEventListener(CANTEEN_MANUAL_REWARD_CALLBACK, function ()
		JumpTools.OpenPageByJump("/canteenManualRewardView")
	end)
	slot0:RegistEventListener(DORM_LOGIC_TICK, handler(slot0, slot0.UpdataTimeBar))
	slot0:RegistEventListener(DORM_REFRESH_POPULAR_EVENT, function ()
		uv0:UpdataPopularity()
	end)
	slot0:RegistEventListener(CANTEEN_FUR_LEVEL, function (slot0)
		if uv0.canJump then
			JumpTools.OpenPageByJump("/restaurantCookUpView", {
				type = BackHomeCanteenFurnitureCfg[BackHomeCanteenFurnitureIDCfg[slot0].type_id].type,
				furEID = slot0
			})
		end
	end)
end

function slot0.UpdataCanteenState(slot0)
	if CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantAuto then
		slot0.manualViewController:SetSelectedState("auto")

		if BackHomeNpcData:CheckNpsIsWorkInCanteen() then
			slot0.stateController:SetSelectedState("npcmode")

			slot0.closeText_.text = GetTips("CANTEEN_NPC_IS_WORK")
		else
			slot0.stateController:SetSelectedState("business")
		end

		slot0.switchBtnController:SetSelectedState("automatic")
		SetActive(slot0.emptydreamcanteenitemGo_1, true)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.RestaurantManual then
		slot0.stateController:SetSelectedState("ManualOperating")
		slot0.manualViewController:SetSelectedState("manual")
		slot0.switchBtnController:SetSelectedState("manual")
		SetActive(slot0.emptydreamcanteenitemGo_1, false)
	elseif CanteenData:GetCanteenState() == DormEnum.RestaurantMode.Close then
		slot0.stateController:SetSelectedState("closed")
		slot0.tipsAnimation:Play()

		if not CanteenTools:CheckSignFoodNumCanOpen() then
			slot0.closeText_.text = GetTips("CANTEEN_FOOD_NOT_SUFFICIENT")
		elseif not CanteenTools:CheckCanteenJobCanOpen() then
			slot0.closeText_.text = GetTips("CANTEEN_JOB_NOT_FIT")
		end
	end
end

function slot0.UpdataAwardBubble(slot0)
	slot1, slot2, slot3 = CanteenData:GetAutoNextAwardTime()
	slot5 = DormSkillData:GetInComeStorageMax()

	if slot1 < 0 or slot2 < 0 then
		slot0.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS2")

		if (CanteenData:GetAutoAwardNum() or 0) == 0 then
			slot0.awardtimetextText_.text = GetTips("CANTEEN_MONEY_TIPS3")
		end
	else
		slot6 = ""

		if slot1 > 0 then
			slot6 = string.format("%d", slot1) .. GetTips("HOUR") .. string.format("%d", slot2) .. GetTips("MINUTE")
		elseif slot1 == 0 and slot2 > 0 then
			slot6 = string.format("%d", slot2) .. GetTips("MINUTE")
		elseif slot2 == 0 and slot3 > 0 then
			slot6 = string.format("%d", slot3) .. GetTips("SECOND")
		end

		slot0.awardtimetextText_.text = string.format(GetTips("CANTEEN_MONEY_TIPS1"), slot6)
	end

	slot0.awardtotaltextText_.text = string.format("%d<size=26><color=#767878>/%d</color></size>", slot4, slot5)
end

function slot0.UpdataAwardBubbleTrs(slot0)
	slot8, slot9 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.transform_, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, Dorm.DormEntityManager.QueryPosition(CanteenAIFunction:GetAllEIDNameSpace(CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.CashierTable))[1])), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	if slot9 == nil then
		print("未找到对应的视口坐标")

		return
	end

	slot9.y = slot9.y + slot0.offset
	slot0.emptydreamcanteenitemTrs_.localPosition = slot9
end

function slot0.UpdataTimeBar(slot0)
	slot2 = 1

	if Dorm.storage:GetData(DormEnum.Namespace.RestaurantBusiness, "timer") and slot1:IsRunning() then
		slot2 = slot1:QueryTime() / slot1.duration
	end

	slot0.timebarImg_.fillAmount = 1 - slot2
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.taskbtnBtn_.transform, RedPointConst.CANTEEN_DISPATCH)
	manager.redPoint:unbindUIandKey(slot0.jobSetBtn_.transform, RedPointConst.CANTEEN_JOB_AVAILABLE)
	manager.redPoint:unbindUIandKey(slot0.cookBtn_.transform, RedPointConst.CANTEEN_UPGRADE_AVAILABLE)
	manager.redPoint:unbindUIandKey(slot0.recipebtnBtn_.transform, RedPointConst.CANTEEN_UNLOCK_FOOD)
	slot0:RemoveAllEventListener()
	slot0:EndAutoScroll()
	slot0.quickView:OnExit()
end

function slot0.UnUsualExitManualMode(slot0)
	CharacterBubbleManager:Dispose()
	CanteenAction:ChangeCanteenMode(CanteenData:GetCanteenState(), DormEnum.RestaurantMode.RestaurantAuto, true)
end

function slot0.Dispose(slot0)
	if slot0.signFoodListScroll_ then
		slot0.signFoodListScroll_:Dispose()

		slot0.signFoodListScroll_ = nil
	end

	if slot0.atuoAwardTrsTimer then
		slot0.atuoAwardTrsTimer:Stop()

		slot0.atuoAwardTrsTimer = nil
	end

	if slot0.canJumpTimer then
		slot0.canJumpTimer:Stop()

		slot0.canJumpTimer = nil
	end

	slot0.moneyAnimator = nil

	slot0.quickView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
