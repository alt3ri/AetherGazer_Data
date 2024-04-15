slot0 = class("PassportMainView", ReduxView)
slot1 = {
	pay = 201,
	free = 0,
	vip = 202
}

function slot0.UIName(slot0)
	return "Widget/System/Passport/PassportMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = Object.Instantiate(Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path), slot0.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	slot0.controller:SetSelectedState("PassportMainUI")

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, PassportRewardItemView)
	slot0.nextCommonItem1_ = CommonItemView.New(slot0.rightCommonItem1_)
	slot0.nextCommonItem2_ = CommonItemView.New(slot0.rightCommonItem2_)
	slot0.CommonData1 = clone(ItemTemplateData)
	slot0.CommonData2 = clone(ItemTemplateData)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.rewardIdList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0.list_:SetHeadTailChangeHandler(handler(slot0, slot0.HeadTailChangeHandler))
	slot0:AddBtnListener(slot0.buyLevelBtn_, nil, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", {
			notRemainLevel = true
		}, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("/passportTask")
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("bp_shop")
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.PASSPORT_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.unlockBtn_, nil, function ()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	slot0:AddBtnListener(slot0.oneKeyGetBtn_, nil, function ()
		if #PassportData:GetCanGetBonusList() > 0 then
			PassportAction.OneKeyGet(slot0)
		end
	end)
	slot0:AddBtnListener(slot0.commonItem2_, nil, function ()
		JumpTools.OpenPageByJump("passportShow", {
			type = 2
		})
	end)
	slot0:AddBtnListener(slot0.commonItem1_, nil, function ()
		JumpTools.OpenPageByJump("passportShow", {
			type = 1
		})
	end)

	function slot0.CommonData1.clickFun(slot0)
		if PassportData:GetRewardStatus(uv0.nearestBonusIndex_, BattlePassCfg[uv0.rewardIdList_[uv0.nearestBonusIndex_]].id) ~= "freeCanGet" and slot2 ~= "payCanGet" then
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})

			return
		end

		PassportAction.RequestGetBonus(slot1.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end

	function slot0.CommonData2.clickFun(slot0)
		if PassportData:GetRewardStatus(uv0.nearestBonusIndex_, BattlePassCfg[uv0.rewardIdList_[uv0.nearestBonusIndex_]].id) ~= "payCanGet" and slot2 ~= "payHalfCanGet" then
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})

			return
		end

		PassportAction.RequestGetBonus(slot1.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end
end

function slot0.HeadTailChangeHandler(slot0, slot1, slot2)
	slot2 = math.max(1, slot2 + 1)

	if not slot0.minEndIndex_ then
		slot0.minEndIndex_ = slot2
	end

	slot0.nearestBonusIndex_ = slot0:GetNextBonusIndex(slot2)

	slot0:UpdateNextBonus()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "passportNote",
		type = "jump",
		params = {}
	})
end

function slot0.UpdateView(slot0)
	slot0.levelLabel_.text = PassportData:GetLevel()
	slot1 = PassportData:GetCurrentExp()
	slot2 = PassportData:GetUpgradeNeedExp()

	if PassportData:GetMaxLevel() <= PassportData:GetLevel() then
		slot1 = slot2
	end

	slot1 = math.min(slot1, slot2)
	slot0.expProgress_.value = slot1 / slot2
	slot0.expLabel_.text = string.format("%d/%d", slot1, slot2)
	slot0.expLimitLabel_.text = string.format("%d/%d", PassportData:GetExpWeekly(), GameSetting.battlepass_exp_limit_weekly.value[1])

	SetActive(slot0.buyLevelBtn_.gameObject, PassportData:GetLevel() < PassportData:GetMaxLevel())
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.bglvTransform_)
end

function slot0.UpdateNextBonus(slot0, slot1)
	slot2 = BattlePassCfg[slot0.rewardIdList_[slot0.nearestBonusIndex_]]
	slot0.nextBonusLevelLabel_.text = string.format("%d", slot0.nearestBonusIndex_)
	slot0.nextBonusBottomLabel_.text = string.format("%d", slot0.nearestBonusIndex_)
	slot3 = slot0.CommonData1.animatorType

	if (slot1 or false) == false then
		slot3 = ItemConst.ITEM_ANIMATOR_TYPE.STOP
	end

	slot4 = PassportData:GetRewardStatus(slot0.nearestBonusIndex_, slot2.id)
	slot5 = {
		id = slot2.reward_free[1][1],
		number = slot2.reward_free[1][2],
		highLight = false,
		completedFlag = false
	}

	if PassportData:GetPayLevel() <= 0 then
		-- Nothing
	end

	if slot4 == "payHaveGet" then
		slot6.completedFlag = true
		slot5.completedFlag = true
	elseif slot4 == "payCanGet" then
		slot6.highLight = true
		slot5.highLight = true
	elseif slot4 == "freeHaveGet" then
		slot5.completedFlag = true
	elseif slot4 == "freeCanGet" then
		slot5.highLight = true
	end

	CommonTools.SetCommonData(slot0.nextCommonItem1_, slot5, slot0.CommonData1)
	CommonTools.SetCommonData(slot0.nextCommonItem2_, {
		id = slot2.reward_pay[1][1],
		number = slot2.reward_pay[1][2],
		highLight = false,
		completedFlag = false,
		locked = false,
		locked = true
	}, slot0.CommonData2)
end

function slot0.GetFirstIndex(slot0)
	slot1, slot2 = PassportData:GetCurrentStatus()

	if slot1 > 0 then
		return slot1
	end

	if slot2 > 0 then
		return slot2
	end

	return 1
end

function slot0.InitData(slot0)
	slot0.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	slot0.nearestBonusIndex_ = slot0:GetNextBonusIndex(slot0.minEndIndex_ or 1)
end

function slot0.GetNextBonusIndex(slot0, slot1)
	for slot5 = slot1, #slot0.rewardIdList_ do
		if not BattlePassCfg[slot0.rewardIdList_[slot5]] then
			print("rewardData is null")
		end

		if slot6.display == 1 then
			return slot5
		end
	end

	return slot0.nearestBonusIndex_
end

function slot0.UpdateRewardView(slot0)
	SetActive(slot0.unlockBtn_.gameObject, PassportData:GetPayLevel() ~= uv0.vip)
	SetActive(slot0.leftLockIconGo_, PassportData:GetPayLevel() <= 0)
	SetActive(slot0.oneKeyGetBtn_.gameObject, #PassportData:GetCanGetBonusList() > 0)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(GET_BONUS_SUCCESS, handler(slot0, slot0.OnGetBonus))
	slot0:RegistEventListener(CURRENCY_UPDATE, function (slot0)
		if slot0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			uv0:UpdateView()
			uv0:OnPassportBuyed()
		end
	end)
	slot0:RegistEventListener(PASSPORT_BUYED, handler(slot0, slot0.OnPassportBuyed))
end

function slot0.OnGetBonus(slot0, slot1)
	slot0:UpdateRewardView()

	if slot1 == BattlePassCfg[slot0.rewardIdList_[slot0.nearestBonusIndex_]].id or slot1 == 0 then
		slot0:UpdateNextBonus()
	end
end

function slot0.OnPassportBuyed(slot0)
	slot0.list_:Refresh()
	slot0:UpdateRewardView()
	slot0:UpdateNextBonus()
end

function slot0.OnEnter(slot0)
	slot0.enteredPage_ = {}

	if slot0:CheckOutofDate() then
		return
	end

	slot0:InitData()
	slot0:UpdateView()
	slot0:UpdateRewardView()
	slot0:UpdateNextBonus(true)
	slot0.list_:StartScroll(#slot0.rewardIdList_, slot0:GetFirstIndex())

	if not slot0.timer_ then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:UpdateTimer()
	slot0:AddEventListeners()

	if getData("passport", "poster_" .. PassportData:GetId()) ~= "1" then
		saveData("passport", "poster_" .. PassportData:GetId(), "1")
		manager.redPoint:setTip(RedPointConst.PASSPORT_NEW_SEASON, 0, RedPointStyle.SHOW_NEW_TAG)
		TimeTools.StartAfterSeconds(0.1, function ()
			JumpTools.OpenPageByJump("passportPoster")
		end, {})
	end

	slot0:RegisterRedPoint()
end

function slot0.UpdateTimer(slot0)
	slot0.duringLabel1_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp())) .. string.format("  %s-%s", manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S"), manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S"))

	slot0:CheckOutofDate()
end

function slot0.CheckOutofDate(slot0)
	if not PassportData:IsOpen() or PassportData:GetEndTimestamp() <= manager.time:GetServerTime() then
		TimeTools.StartAfterSeconds(0.1, function ()
			uv0:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function slot0.OnBuyPassportLevel(slot0)
	slot0:OnPassportBuyed()
end

function slot0.OnExit(slot0)
	slot0:UnRegisterRedPoint()
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegisterRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
	manager.redPoint:bindUIandKey(slot0.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function slot0.UnRegisterRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
	manager.redPoint:unbindUIandKey(slot0.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	slot0.CommonData1 = nil
	slot0.CommonData2 = nil

	uv0.super.Dispose(slot0)
end

return slot0
