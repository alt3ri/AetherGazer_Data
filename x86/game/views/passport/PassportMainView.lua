local var_0_0 = class("PassportMainView", ReduxView)
local var_0_1 = {
	pay = 201,
	free = 0,
	vip = 202
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Passport/PassportMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	local var_5_0 = Asset.Load(BattlePassListCfg[PassportData:GetId()].prefab_path)

	arg_5_0.controller = Object.Instantiate(var_5_0, arg_5_0.container_.transform):GetComponent("ControllerExCollection"):GetController("default")

	arg_5_0.controller:SetSelectedState("PassportMainUI")

	arg_5_0.list_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.listGo_, PassportRewardItemView)
	arg_5_0.nextCommonItem1_ = CommonItemView.New(arg_5_0.rightCommonItem1_)
	arg_5_0.nextCommonItem2_ = CommonItemView.New(arg_5_0.rightCommonItem2_)
	arg_5_0.CommonData1 = clone(ItemTemplateData)
	arg_5_0.CommonData2 = clone(ItemTemplateData)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.rewardIdList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0.list_:SetHeadTailChangeHandler(handler(arg_7_0, arg_7_0.HeadTailChangeHandler))
	arg_7_0:AddBtnListener(arg_7_0.buyLevelBtn_, nil, function()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_bp_level = PassportData:GetLevel()
		})
		JumpTools.OpenPageByJump("passportBuyLevel", {
			notRemainLevel = true
		}, ViewConst.SYSTEM_ID.PASSPORT_BUY_LEVEL)
	end)
	arg_7_0:AddBtnListener(arg_7_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/passportTask")
	end)
	arg_7_0:AddBtnListener(arg_7_0.shopBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("bp_shop")
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.PASSPORT_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_7_0:AddBtnListener(arg_7_0.unlockBtn_, nil, function()
		JumpTools.OpenPageByJump("/passportBuy")
	end)
	arg_7_0:AddBtnListener(arg_7_0.oneKeyGetBtn_, nil, function()
		local var_12_0 = PassportData:GetCanGetBonusList()

		if #var_12_0 > 0 then
			PassportAction.OneKeyGet(var_12_0)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.commonItem2_, nil, function()
		JumpTools.OpenPageByJump("passportShow", {
			type = 2
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.commonItem1_, nil, function()
		JumpTools.OpenPageByJump("passportShow", {
			type = 1
		})
	end)

	function arg_7_0.CommonData1.clickFun(arg_15_0)
		local var_15_0 = BattlePassCfg[arg_7_0.rewardIdList_[arg_7_0.nearestBonusIndex_]]
		local var_15_1 = PassportData:GetRewardStatus(arg_7_0.nearestBonusIndex_, var_15_0.id)

		if var_15_1 ~= "freeCanGet" and var_15_1 ~= "payCanGet" then
			ShowPopItem(POP_ITEM, {
				arg_15_0.id,
				arg_15_0.number
			})

			return
		end

		PassportAction.RequestGetBonus(var_15_0.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end

	function arg_7_0.CommonData2.clickFun(arg_16_0)
		local var_16_0 = BattlePassCfg[arg_7_0.rewardIdList_[arg_7_0.nearestBonusIndex_]]
		local var_16_1 = PassportData:GetRewardStatus(arg_7_0.nearestBonusIndex_, var_16_0.id)

		if var_16_1 ~= "payCanGet" and var_16_1 ~= "payHalfCanGet" then
			ShowPopItem(POP_ITEM, {
				arg_16_0.id,
				arg_16_0.number
			})

			return
		end

		PassportAction.RequestGetBonus(var_16_0.id, PassportData:GetPayLevel() > 0 and 1 or 0)
	end
end

function var_0_0.HeadTailChangeHandler(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2 = arg_17_2 + 1
	arg_17_2 = math.max(1, arg_17_2)

	if not arg_17_0.minEndIndex_ then
		arg_17_0.minEndIndex_ = arg_17_2
	end

	arg_17_0.nearestBonusIndex_ = arg_17_0:GetNextBonusIndex(arg_17_2)

	arg_17_0:UpdateNextBonus()
end

function var_0_0.UpdateBar(arg_18_0)
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

function var_0_0.UpdateView(arg_19_0)
	arg_19_0.levelLabel_.text = PassportData:GetLevel()

	local var_19_0 = PassportData:GetCurrentExp()
	local var_19_1 = PassportData:GetUpgradeNeedExp()

	if PassportData:GetLevel() >= PassportData:GetMaxLevel() then
		var_19_0 = var_19_1
	end

	local var_19_2 = math.min(var_19_0, var_19_1)

	arg_19_0.expProgress_.value = var_19_2 / var_19_1
	arg_19_0.expLabel_.text = string.format("%d/%d", var_19_2, var_19_1)
	arg_19_0.expLimitLabel_.text = string.format("%d/%d", PassportData:GetExpWeekly(), GameSetting.battlepass_exp_limit_weekly.value[1])

	SetActive(arg_19_0.buyLevelBtn_.gameObject, PassportData:GetLevel() < PassportData:GetMaxLevel())
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_0.bglvTransform_)
end

function var_0_0.UpdateNextBonus(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or false

	local var_20_0 = BattlePassCfg[arg_20_0.rewardIdList_[arg_20_0.nearestBonusIndex_]]

	arg_20_0.nextBonusLevelLabel_.text = string.format("%d", arg_20_0.nearestBonusIndex_)
	arg_20_0.nextBonusBottomLabel_.text = string.format("%d", arg_20_0.nearestBonusIndex_)

	local var_20_1 = arg_20_0.CommonData1.animatorType

	if arg_20_1 == false then
		local var_20_2 = ItemConst.ITEM_ANIMATOR_TYPE.STOP
	end

	local var_20_3 = PassportData:GetRewardStatus(arg_20_0.nearestBonusIndex_, var_20_0.id)
	local var_20_4 = {
		id = var_20_0.reward_free[1][1],
		number = var_20_0.reward_free[1][2]
	}
	local var_20_5 = {
		id = var_20_0.reward_pay[1][1],
		number = var_20_0.reward_pay[1][2]
	}

	var_20_4.highLight = false
	var_20_4.completedFlag = false
	var_20_5.highLight = false
	var_20_5.completedFlag = false
	var_20_5.locked = false

	if PassportData:GetPayLevel() <= 0 then
		var_20_5.locked = true
	end

	if var_20_3 == "payHaveGet" then
		var_20_5.completedFlag = true
		var_20_4.completedFlag = true
	elseif var_20_3 == "payCanGet" then
		var_20_5.highLight = true
		var_20_4.highLight = true
	elseif var_20_3 == "freeHaveGet" then
		var_20_4.completedFlag = true
	elseif var_20_3 == "freeCanGet" then
		var_20_4.highLight = true
	end

	CommonTools.SetCommonData(arg_20_0.nextCommonItem1_, var_20_4, arg_20_0.CommonData1)
	CommonTools.SetCommonData(arg_20_0.nextCommonItem2_, var_20_5, arg_20_0.CommonData2)
end

function var_0_0.GetFirstIndex(arg_21_0)
	local var_21_0, var_21_1 = PassportData:GetCurrentStatus()

	if var_21_0 > 0 then
		return var_21_0
	end

	if var_21_1 > 0 then
		return var_21_1
	end

	return 1
end

function var_0_0.InitData(arg_22_0)
	arg_22_0.rewardIdList_ = BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
	arg_22_0.nearestBonusIndex_ = arg_22_0:GetNextBonusIndex(arg_22_0.minEndIndex_ or 1)
end

function var_0_0.GetNextBonusIndex(arg_23_0, arg_23_1)
	for iter_23_0 = arg_23_1, #arg_23_0.rewardIdList_ do
		local var_23_0 = BattlePassCfg[arg_23_0.rewardIdList_[iter_23_0]]

		if not var_23_0 then
			print("rewardData is null")
		end

		if var_23_0.display == 1 then
			return iter_23_0
		end
	end

	return arg_23_0.nearestBonusIndex_
end

function var_0_0.UpdateRewardView(arg_24_0)
	SetActive(arg_24_0.unlockBtn_.gameObject, PassportData:GetPayLevel() ~= var_0_1.vip)
	SetActive(arg_24_0.leftLockIconGo_, PassportData:GetPayLevel() <= 0)
	SetActive(arg_24_0.oneKeyGetBtn_.gameObject, #PassportData:GetCanGetBonusList() > 0)
end

function var_0_0.AddEventListeners(arg_25_0)
	arg_25_0:RegistEventListener(GET_BONUS_SUCCESS, handler(arg_25_0, arg_25_0.OnGetBonus))
	arg_25_0:RegistEventListener(CURRENCY_UPDATE, function(arg_26_0)
		if arg_26_0 == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
			arg_25_0:UpdateView()
			arg_25_0:OnPassportBuyed()
		end
	end)
	arg_25_0:RegistEventListener(PASSPORT_BUYED, handler(arg_25_0, arg_25_0.OnPassportBuyed))
end

function var_0_0.OnGetBonus(arg_27_0, arg_27_1)
	arg_27_0:UpdateRewardView()

	if arg_27_1 == BattlePassCfg[arg_27_0.rewardIdList_[arg_27_0.nearestBonusIndex_]].id or arg_27_1 == 0 then
		arg_27_0:UpdateNextBonus()
	end
end

function var_0_0.OnPassportBuyed(arg_28_0)
	arg_28_0.list_:Refresh()
	arg_28_0:UpdateRewardView()
	arg_28_0:UpdateNextBonus()
end

function var_0_0.OnEnter(arg_29_0)
	arg_29_0.enteredPage_ = {}

	if arg_29_0:CheckOutofDate() then
		return
	end

	arg_29_0:InitData()
	arg_29_0:UpdateView()
	arg_29_0:UpdateRewardView()
	arg_29_0:UpdateNextBonus(true)

	local var_29_0 = arg_29_0:GetFirstIndex()

	arg_29_0.list_:StartScroll(#arg_29_0.rewardIdList_, var_29_0)

	if not arg_29_0.timer_ then
		arg_29_0.timer_ = Timer.New(function()
			arg_29_0:UpdateTimer()
		end, 1, -1)
	end

	arg_29_0.timer_:Start()
	arg_29_0:UpdateTimer()
	arg_29_0:AddEventListeners()

	if getData("passport", "poster_" .. PassportData:GetId()) ~= "1" then
		saveData("passport", "poster_" .. PassportData:GetId(), "1")
		manager.redPoint:setTip(RedPointConst.PASSPORT_NEW_SEASON, 0, RedPointStyle.SHOW_NEW_TAG)
		TimeTools.StartAfterSeconds(0.1, function()
			JumpTools.OpenPageByJump("passportPoster")
		end, {})
	end

	arg_29_0:RegisterRedPoint()
end

function var_0_0.UpdateTimer(arg_32_0)
	local var_32_0 = manager.time:STimeDescS(PassportData:GetStartTimestamp(), "!%Y/%m/%d %H:%M:%S")
	local var_32_1 = manager.time:STimeDescS(PassportData:GetEndTimestamp(), "!%Y/%m/%d %H:%M:%S")

	arg_32_0.duringLabel1_.text = string.format(GetTips("TIME_DISPLAY_6"), manager.time:GetLostTimeStr(PassportData:GetEndTimestamp())) .. string.format("  %s-%s", var_32_0, var_32_1)

	arg_32_0:CheckOutofDate()
end

function var_0_0.CheckOutofDate(arg_33_0)
	local var_33_0 = manager.time:GetServerTime()

	if not PassportData:IsOpen() or var_33_0 >= PassportData:GetEndTimestamp() then
		TimeTools.StartAfterSeconds(0.1, function()
			arg_33_0:Go("/home")
			ShowTips("BATTLEPASS_EXPIRED")
		end, {})

		return true
	end

	return false
end

function var_0_0.OnBuyPassportLevel(arg_35_0)
	arg_35_0:OnPassportBuyed()
end

function var_0_0.OnExit(arg_36_0)
	arg_36_0:UnRegisterRedPoint()
	arg_36_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if arg_36_0.timer_ then
		arg_36_0.timer_:Stop()

		arg_36_0.timer_ = nil
	end
end

function var_0_0.RegisterRedPoint(arg_37_0)
	manager.redPoint:bindUIandKey(arg_37_0.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
	manager.redPoint:bindUIandKey(arg_37_0.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function var_0_0.UnRegisterRedPoint(arg_38_0)
	manager.redPoint:unbindUIandKey(arg_38_0.taskBtn_.transform, RedPointConst.PASSPORT_TASKS)
	manager.redPoint:unbindUIandKey(arg_38_0.oneKeyGetBtn_.transform, RedPointConst.PASSPORT_BONUS)
end

function var_0_0.OnTop(arg_39_0)
	arg_39_0:UpdateBar()
end

function var_0_0.OnBehind(arg_40_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_41_0)
	if arg_41_0.list_ then
		arg_41_0.list_:Dispose()

		arg_41_0.list_ = nil
	end

	arg_41_0.CommonData1 = nil
	arg_41_0.CommonData2 = nil

	var_0_0.super.Dispose(arg_41_0)
end

return var_0_0
