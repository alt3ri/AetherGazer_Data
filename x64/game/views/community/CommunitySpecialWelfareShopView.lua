local var_0_0 = class("CommunitySpecialWelfareShopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/showpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.refreshUIHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.useNumTriggerListener_ = arg_4_0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	arg_4_0.bgController = arg_4_0.controller_:GetController("bg")
	arg_4_0.timeController = arg_4_0.controller_:GetController("time")
	arg_4_0.viewController = arg_4_0.controller_:GetController("view")
	arg_4_0.starController = arg_4_0.controller_:GetController("star")
	arg_4_0.ndtabController = arg_4_0.controller_:GetController("ndtab")
	arg_4_0.consumeController = arg_4_0.controller_:GetController("consume")
	arg_4_0.numController = arg_4_0.controller_:GetController("showNum")
	arg_4_0.furnitureController = arg_4_0.controller_:GetController("Furniture")
	arg_4_0.groupController = arg_4_0.controller_:GetController("group")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		if CommunityData:GetWelfareExchangeCnt() < arg_5_0.useNum_ then
			ShowTips("EXCEED_MAX_CNT")

			return
		end

		CommunityAction:BuySpecialWelfare(arg_5_0.useNum_)
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.useNumSlider_.value < arg_5_0.canUseMaxNum_ then
			arg_5_0.useNumSlider_.value = arg_5_0.useNumSlider_.value + 1

			if arg_5_0.useNumSlider_.value >= arg_5_0.canUseMaxNum_ then
				arg_5_0.useNumSlider_.value = arg_5_0.canUseMaxNum_
			end

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		if arg_5_0.useNumSlider_.value >= 1 then
			arg_5_0.useNumSlider_.value = arg_5_0.useNumSlider_.value - 1

			return true
		end

		return false
	end)
	arg_5_0.useNumSlider_.onValueChanged:AddListener(function()
		if arg_5_0.canUseMaxNum_ then
			arg_5_0.useNum_ = math.floor(arg_5_0.useNumSlider_.value)

			if arg_5_0.useNum_ < 1 then
				arg_5_0.useNum_ = 1
			elseif arg_5_0.useNum_ > arg_5_0.canUseMaxNum_ then
				arg_5_0.useNum_ = arg_5_0.canUseMaxNum_
			end

			if arg_5_0.useNum_ <= 0 then
				arg_5_0.useNum_ = 1
			end

			arg_5_0:UpdateCnt()
		end
	end)
	arg_5_0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_11_0, arg_11_1)
		arg_5_0.useNumSlider_.value = math.floor(arg_5_0.useNumSlider_.value)
	end))
end

function var_0_0.OnEnter(arg_12_0)
	CommunityAction:RefreshCurrencyA()
	manager.windowBar:SetAsLastSibling()
	arg_12_0.numController:SetSelectedState("none")
	arg_12_0.viewController:SetSelectedState("false")
	arg_12_0.consumeController:SetSelectedState("normal")
	arg_12_0.furnitureController:SetSelectedState("false")

	arg_12_0.identity_ = CommunityData:GetIdentity()

	manager.notify:RegistListener(GUILD_WELFRE_CNT_REFRESH, arg_12_0.refreshUIHandler_)

	arg_12_0.okBtn_.interactable = CommunityData:GetCurrenyA() >= GameSetting.club_special_welfare_cost.value[1]

	arg_12_0:RefreshUI()
end

function var_0_0.RefreshGood(arg_13_0)
	local var_13_0 = ItemCfg[GameSetting.club_special_welfare.value[1]]

	arg_13_0.ndtabController:SetSelectedState("off")

	arg_13_0.itemIcon_.sprite = ItemTools.getItemSprite(var_13_0.id)

	arg_13_0.bgController:SetSelectedState(tostring(var_13_0.rare))

	arg_13_0.nameText_.text = GetI18NText(var_13_0.name)
	arg_13_0.descText_.text = GetI18NText(var_13_0.desc) .. "\n\n" .. GetTips("CLUB_SPECIAL_WELFARE")
	arg_13_0.costIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)
end

function var_0_0.RefreshSlider(arg_14_0)
	local var_14_0 = CommunityData:GetCurrenyA()
	local var_14_1 = GameSetting.club_special_welfare_cost.value[1]
	local var_14_2 = CommunityData:GetWelfareExchangeCnt()

	arg_14_0.canUseMaxNum_ = var_14_2
	arg_14_0.useNumSlider_.minValue = 1
	arg_14_0.useNumSlider_.maxValue = math.max(var_14_2, 1)
	arg_14_0.useNumSlider_.value = math.min(arg_14_0.useNumSlider_.maxValue, 1)

	arg_14_0:UpdateDelAddBtn()
	arg_14_0:UpdatePreview()
end

function var_0_0.UpdateDelAddBtn(arg_15_0)
	return
end

function var_0_0.UpdatePreview(arg_16_0)
	arg_16_0.useNum_ = arg_16_0.useNumSlider_.value
	arg_16_0.useNumText_.text = arg_16_0.useNum_

	local var_16_0 = arg_16_0.useNum_ * GameSetting.club_special_welfare_cost.value[1]

	if var_16_0 > CommunityData:GetCurrenyA() then
		arg_16_0.totalCostText_.text = "<color=#FF0000>" .. var_16_0 .. "</color>"
	else
		arg_16_0.totalCostText_.text = var_16_0
	end
end

function var_0_0.UpdateCnt(arg_17_0)
	arg_17_0:UpdateDelAddBtn()
	arg_17_0:UpdatePreview()
end

function var_0_0.OnBuyCommunitySpecialWelfare(arg_18_0)
	arg_18_0:Back()
	ShowTips("TIP_CLUB_SPECIAL_WELFARE_BUY")
end

function var_0_0.OnExit(arg_19_0)
	manager.notify:RemoveListener(GUILD_WELFRE_CNT_REFRESH, arg_19_0.refreshUIHandler_)
end

function var_0_0.OnExitInput(arg_20_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.refreshUIHandler_ = nil

	arg_21_0:RemoveAllListeners()
	arg_21_0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.RefreshUI(arg_22_0)
	arg_22_0:RefreshGood()
	arg_22_0:RefreshSlider()
	arg_22_0.groupController:SetSelectedState("false")
	SetActive(arg_22_0.limitGo_, true)

	local var_22_0 = GameSetting.club_special_reward_buy_limit_weekly.value[1]

	arg_22_0.limitText_.text = GetTips("LIMIT_WEEK") .. string.format("%s/%s", var_22_0 - CommunityData:GetWelfareExchangeCnt(), var_22_0)
end

return var_0_0
