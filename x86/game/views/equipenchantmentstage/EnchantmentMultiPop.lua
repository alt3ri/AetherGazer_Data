local var_0_0 = class("EnchantmentMultiPop", ReduxView)
local var_0_1 = #GameSetting.challenge_multiple_count_unlock_level.value

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/MultipleacquisitionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelbtnBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.okbtnBtn_, nil, function()
		if not checkVitality(arg_5_0.cost_ * arg_5_0.multiple_) then
			return
		end

		arg_5_0:Go("/sectionSelectHero", {
			section = arg_5_0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
			multiple = arg_5_0.multiple_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.leftBtn_, nil, function()
		arg_5_0.multiple_ = arg_5_0.multiple_ - 1

		arg_5_0:ChangeMultiple()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rightBtn_, nil, function()
		if arg_5_0.multiple_ >= arg_5_0.challengeCnt_ then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.challenge_multiple_count_unlock_level.value[arg_5_0.multiple_ + 1]))

			return
		end

		arg_5_0.multiple_ = arg_5_0.multiple_ + 1

		arg_5_0:ChangeMultiple()
	end)
	arg_5_0:AddBtnListener(arg_5_0.leftmaxBtn_, nil, function()
		arg_5_0.multiple_ = 1

		arg_5_0:ChangeMultiple()
	end)
	arg_5_0:AddBtnListener(arg_5_0.rightmaxBtn_, nil, function()
		local var_12_0 = arg_5_0.maxMultiple_

		if arg_5_0.challengeCnt_ < arg_5_0.maxMultiple_ then
			var_12_0 = arg_5_0.challengeCnt_
		end

		arg_5_0.multiple_ = var_12_0

		arg_5_0:ChangeMultiple()
	end)
end

function var_0_0.ChangeMultiple(arg_13_0)
	arg_13_0:RefreshMultiple()
	arg_13_0:RefreshCost()
end

function var_0_0.RefreshMultiple(arg_14_0)
	arg_14_0.usenumtextText_.text = "x" .. arg_14_0.multiple_

	if arg_14_0.multiple_ >= arg_14_0.maxMultiple_ or arg_14_0.multiple_ >= arg_14_0.challengeCnt_ then
		arg_14_0.rightmaxBtn_.interactable = false
		arg_14_0.leftmaxBtn_.interactable = true
		arg_14_0.leftBtn_.interactable = true
	elseif arg_14_0.multiple_ <= 1 then
		arg_14_0.rightmaxBtn_.interactable = true
		arg_14_0.leftmaxBtn_.interactable = false
		arg_14_0.leftBtn_.interactable = false
	else
		arg_14_0.rightmaxBtn_.interactable = true
		arg_14_0.leftmaxBtn_.interactable = true
		arg_14_0.leftBtn_.interactable = true
	end

	if arg_14_0.multiple_ == var_0_1 then
		arg_14_0.rightBtn_.interactable = false
	else
		arg_14_0.rightBtn_.interactable = true
	end

	if arg_14_0.multiple_ <= 1 then
		arg_14_0.leftmaxBtn_.interactable = false
		arg_14_0.leftBtn_.interactable = false
	end
end

function var_0_0.RefreshCost(arg_15_0)
	arg_15_0.totalText_.text = arg_15_0.cost_ * arg_15_0.multiple_
end

function var_0_0.RefreshData(arg_16_0)
	local var_16_0 = 1

	for iter_16_0 = var_0_1, 1, -1 do
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= arg_16_0.cost_ * iter_16_0 then
			var_16_0 = iter_16_0

			break
		end
	end

	arg_16_0.maxMultiple_ = var_16_0
	arg_16_0.multiple_ = arg_16_0.multiple_ or 1
	arg_16_0.challengeCnt_ = arg_16_0:GetUnlockChallengeCnt()
end

function var_0_0.OnEnter(arg_17_0)
	manager.windowBar:SwitchBar({
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	arg_17_0:RegistEventListener(CURRENCY_UPDATE, function()
		arg_17_0:RefreshData()
		arg_17_0:ChangeMultiple()
	end)

	arg_17_0.stageID_ = arg_17_0.params_.stageID
	arg_17_0.cost_ = BattleEnchantmentStageCfg[arg_17_0.stageID_].cost
	arg_17_0.multiple_ = 1

	arg_17_0:RefreshData()
	arg_17_0:ChangeMultiple()
end

function var_0_0.OnExit(arg_19_0)
	manager.windowBar:HideBar()
	arg_19_0:RemoveAllEventListener()
end

function var_0_0.GetUnlockChallengeCnt(arg_20_0)
	local var_20_0 = GameSetting.challenge_multiple_count_unlock_level.value
	local var_20_1 = PlayerData:GetPlayerInfo().userLevel

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if var_20_1 < iter_20_1 then
			return iter_20_0 - 1
		end
	end

	return #var_20_0
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
