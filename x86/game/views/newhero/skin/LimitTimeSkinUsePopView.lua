local var_0_0 = class("LimitTimeSkinUsePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/LimitTimeSkinUsePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.skinOwnController_ = arg_4_0.skinController_:GetController("owned2")
	arg_4_0.dlcOwnController_ = arg_4_0.dlcController_:GetController("owned2")
	arg_4_0.stateController_ = arg_4_0.controller_:GetController("state")
	arg_4_0.tipsController_ = arg_4_0.controller_:GetController("tips")
	arg_4_0.btnController_ = arg_4_0.controller_:GetController("btn")
	arg_4_0.skinItem_ = CommonItemView.New(arg_4_0.skinItemGo_)
	arg_4_0.dlcItem_ = CommonItemView.New(arg_4_0.dlcItemGo_)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.tipsBtn_, nil, function()
		if arg_5_0:HasOwnAllItem() then
			return
		end

		if arg_5_0.showSkin_ then
			arg_5_0.showSkin_ = false
		else
			arg_5_0.showSkin_ = true
		end

		arg_5_0.tipsController_:SetSelectedState(tostring(arg_5_0.showSkin_))
	end)
	arg_5_0:AddBtnListener(arg_5_0.mask_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.noBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.hadBtn_, nil, function()
		arg_5_0:CheckCanUse()
	end)
	arg_5_0:AddBtnListener(arg_5_0.yesBtn_, nil, function()
		local var_10_0 = {
			item_info = {
				num = 1,
				id = arg_5_0.itemId_,
				time_valid = arg_5_0.timeValid
			},
			use_list = {}
		}

		if not arg_5_0:CheckCanUse() then
			return
		end

		CommonAction.TryToUseItemWitchCallback({
			var_10_0
		}, function(arg_11_0)
			arg_5_0:UseItemSuccess(arg_11_0)
		end)
	end)
end

function var_0_0.UseItemSuccess(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.drop_list

	arg_12_0:Back()
	getReward(var_12_0)
	HeroAction.SelectSkin(SkinCfg[arg_12_0.skinId_].hero, arg_12_0.skinId_)

	if arg_12_0.showSkin_ then
		PlayerAction.ChangePosterGirl(SkinCfg[arg_12_0.skinId_].hero)
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.itemId_ = arg_13_0.params_.itemData.id
	arg_13_0.timeValid = ItemTools.GetItemExpiredTimeByInfo(arg_13_0.params_.itemData)
	arg_13_0.cfg_ = ItemCfg[arg_13_0.itemId_]
	arg_13_0.reward_ = arg_13_0.cfg_.param
	arg_13_0.dlcId_ = nil
	arg_13_0.skinId_ = nil
	arg_13_0.LimitDlcId_ = nil
	arg_13_0.LimitskinItemId_ = nil

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.reward_) do
		local var_13_0 = ItemCfg[iter_13_1]

		if var_13_0.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			arg_13_0.LimitskinItemId_ = iter_13_1
		elseif var_13_0.type == ItemConst.ITEM_TYPE.SCENE then
			arg_13_0.LimitDlcId_ = iter_13_1
		end
	end

	if arg_13_0.LimitskinItemId_ then
		arg_13_0.LimitskinItemCfg_ = ItemCfg[arg_13_0.LimitskinItemId_]

		if arg_13_0.LimitskinItemCfg_ then
			arg_13_0.skinId_ = arg_13_0.LimitskinItemCfg_.param[1]
			arg_13_0.heroId_ = SkinCfg[arg_13_0.skinId_].hero
		end
	end

	if arg_13_0.LimitDlcId_ then
		arg_13_0.LimitDlcCfg_ = ItemCfg[arg_13_0.LimitDlcId_]

		if arg_13_0.LimitDlcCfg_ then
			arg_13_0.dlcId_ = arg_13_0.LimitDlcCfg_.param[1]
		end
	end

	arg_13_0.showSkin_ = true

	arg_13_0.tipsController_:SetSelectedState(tostring(arg_13_0.showSkin_))
	arg_13_0:UpdateView()
end

function var_0_0.HasOwnAllItem(arg_14_0)
	local var_14_0 = false
	local var_14_1 = false

	if arg_14_0.skinId_ and arg_14_0.dlcId_ then
		local var_14_2 = HeroTools.GetHasOwnedSkin(arg_14_0.skinId_)

		if HomeSceneSettingData:IsHaveScene(arg_14_0.dlcId_) and var_14_2 then
			return true
		end
	elseif not arg_14_0.skinId_ and arg_14_0.dlcId_ then
		if HomeSceneSettingData:IsHaveScene(arg_14_0.dlcId_) then
			return true
		end
	elseif arg_14_0.skinId_ and not arg_14_0.dlcId_ and HeroTools.GetHasOwnedSkin(arg_14_0.skinId_) then
		return true
	end

	return false
end

function var_0_0.CheckCanUse(arg_15_0)
	if HeroData:GetHeroData(arg_15_0.heroId_).unlock == 0 then
		ShowTips("ERROR_HERO_NOT_UNLOCK")

		return false
	end

	if arg_15_0:HasOwnAllItem() then
		ShowTips(string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), ItemCfg[arg_15_0.itemId_].name))

		return false
	end

	return true
end

function var_0_0.UpdateItemView(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = clone(ItemTemplateData)

	var_16_0.id = arg_16_2
	var_16_0.number = nil

	arg_16_1:SetData(var_16_0)
end

function var_0_0.UpdateView(arg_17_0)
	if arg_17_0.skinId_ then
		arg_17_0:UpdateItemView(arg_17_0.skinItem_, arg_17_0.skinId_)
	end

	if arg_17_0.dlcId_ then
		arg_17_0:UpdateItemView(arg_17_0.dlcItem_, arg_17_0.dlcId_)
	end

	SetActive(arg_17_0.tipsBtnGo_, not arg_17_0:HasOwnAllItem())

	arg_17_0.skinImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_17_0.skinId_)
	arg_17_0.titleText_.text = SkinCfg[arg_17_0.skinId_].name
	arg_17_0.leftTimeText_.text = arg_17_0.LimitskinItemCfg_.time[2][1] .. GetTips("DAY")

	if arg_17_0.skinId_ and arg_17_0.dlcId_ then
		arg_17_0.stateController_:SetSelectedState("all")
	elseif arg_17_0.skinId_ and not arg_17_0.dlcId_ then
		arg_17_0.stateController_:SetSelectedState("skin")
	elseif not arg_17_0.skinId_ and arg_17_0.dlcId_ then
		arg_17_0.stateController_:SetSelectedState("dlc")
	end

	local var_17_0 = false

	if arg_17_0.dlcId_ then
		var_17_0 = HomeSceneSettingData:IsHaveScene(arg_17_0.dlcId_)
	end

	local var_17_1 = false

	if arg_17_0.skinId_ then
		var_17_1 = HeroTools.GetHasOwnedSkin(arg_17_0.skinId_)
	end

	if var_17_1 then
		arg_17_0.skinOwnController_:SetSelectedState("on")
	else
		arg_17_0.skinOwnController_:SetSelectedState("off")
	end

	if var_17_0 then
		arg_17_0.dlcOwnController_:SetSelectedState("on")
	else
		arg_17_0.dlcOwnController_:SetSelectedState("off")
	end

	arg_17_0.btnController_:SetSelectedState(tostring(arg_17_0:HasOwnAllItem()))

	local var_17_2 = HeroCfg[arg_17_0.heroId_].name .. "·" .. HeroCfg[arg_17_0.heroId_].suffix

	if arg_17_0.dlcId_ then
		if not var_17_1 and not var_17_0 then
			arg_17_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_1"), ItemCfg[arg_17_0.itemId_].name, var_17_2, SkinCfg[arg_17_0.skinId_].name, HomeSceneSettingCfg[arg_17_0.dlcId_].title)
		elseif var_17_1 and not var_17_0 then
			arg_17_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_2"), ItemCfg[arg_17_0.itemId_].name, SkinCfg[arg_17_0.skinId_].name, HomeSceneSettingCfg[arg_17_0.dlcId_].title)
		elseif not var_17_1 and var_17_0 then
			arg_17_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_3"), ItemCfg[arg_17_0.itemId_].name, var_17_2, SkinCfg[arg_17_0.skinId_].name)
		else
			arg_17_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), ItemCfg[arg_17_0.itemId_].name)
		end
	elseif not var_17_1 then
		arg_17_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_3"), ItemCfg[arg_17_0.itemId_].name, var_17_2, SkinCfg[arg_17_0.skinId_].name)
	else
		arg_17_0.descText_.text = string.format(GetTips("SKIN_LIMIT_TIME_DESC_4"), ItemCfg[arg_17_0.itemId_].name)
	end
end

function var_0_0.OnExit(arg_18_0)
	var_0_0.super.OnExit(arg_18_0)
end

return var_0_0
