local var_0_0 = class("ReviseSignFoodNumView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dining/ShelfPresetUI"
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

	arg_4_0.sceneID = DormConst.CANTEEN_ID
	arg_4_0.foodMaterialScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, FoodMaterialItem)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.foodID = arg_6_0.params_.foodID

	if not arg_6_0.sellNum then
		arg_6_0.sellNum = 0
	end

	manager.windowBar:HideBar()
	arg_6_0:SetfurNum(arg_6_0.sellNum)

	arg_6_0.progressSlr_.maxValue = CanteenFoodData:CalculateFoodCanCookNum(arg_6_0.foodID)
	arg_6_0.furNumMax = CanteenFoodData:CalculateFoodCanCookNum(arg_6_0.foodID)

	arg_6_0:RegisterEvent()
	arg_6_0:RefreshView()
end

function var_0_0.RegisterEvent(arg_7_0)
	arg_7_0:RegistEventListener(CANTEEN_SET_SIGNFOOD_SUCCESS, function()
		ShowTips(GetTips("DORM_FOOD_SET_SUCCESS"))
		arg_7_0:SetfurNum(0)
		JumpTools:Back()
	end)
	arg_7_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_9_0)
		if arg_9_0 == 0 or arg_9_0 == ShopConst.SHOP_ID.CANTEEN_SHOP then
			arg_7_0.foodMaterialScroll:Refresh()
		end
	end)
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListenerScale(arg_11_0.signBtn_, nil, function()
		if arg_11_0.sellNum <= 0 then
			ShowTips(GetTips("DORM_FOOD_SET_NULL"))

			return
		end

		CanteenAction:SendSignFoodInfo(arg_11_0.foodID, arg_11_0.sellNum)
	end)
	arg_11_0:AddToggleListener(arg_11_0.progressSlr_, function()
		if arg_11_0.foodID then
			arg_11_0:SetfurNum(arg_11_0.progressSlr_.value)
		end
	end)
	arg_11_0:AddPressingByTimeListener(arg_11_0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_11_0.foodID and arg_11_0.sellNum > 0 then
			local var_14_0 = arg_11_0.progressSlr_.value - 1

			arg_11_0:SetfurNum(var_14_0)

			return true
		end

		return false
	end)
	arg_11_0:AddPressingByTimeListener(arg_11_0.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_11_0.foodID and arg_11_0.sellNum < arg_11_0.furNumMax then
			local var_15_0 = arg_11_0.progressSlr_.value + 1

			arg_11_0:SetfurNum(var_15_0)

			return true
		end

		return false
	end)
	arg_11_0:AddBtnListener(arg_11_0.bgmaskBtn_, nil, function()
		arg_11_0.sellNum = 0

		JumpTools.Back()
	end)
	arg_11_0:AddBtnListenerScale(arg_11_0.takeOffBtn_, nil, function()
		arg_11_0.sellNum = 0

		JumpTools.Back()
	end)
end

function var_0_0.SetfurNum(arg_18_0, arg_18_1)
	arg_18_0.sellNum = arg_18_1
	arg_18_0.numText_.text = arg_18_1
	arg_18_0.progressSlr_.value = arg_18_1

	arg_18_0:RefreshSellNumAndIncome()
end

function var_0_0.indexItem(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:RefreshItem(arg_19_0.foodMaterialList[arg_19_1], arg_19_0.foodID, arg_19_0.sellNum)
end

function var_0_0.RefreshView(arg_20_0)
	arg_20_0:RefreshFoodInfo()
	arg_20_0:RefreshFoodMaterialList()
	arg_20_0:RefreshSellNumAndIncome()
end

function var_0_0.RefreshFoodMaterialList(arg_21_0)
	arg_21_0.foodMaterialList = BackHomeCanteenFoodCfg[arg_21_0.foodID].ingredient_list

	if arg_21_0.foodMaterialList then
		arg_21_0.foodMaterialScroll:StartScroll(#arg_21_0.foodMaterialList)
	end
end

function var_0_0.RefreshSellNumAndIncome(arg_22_0)
	arg_22_0.sellNumTex_.text = arg_22_0.sellNum

	local var_22_0 = CanteenFoodData:GetFoodUnitCost(arg_22_0.foodID)
	local var_22_1 = BackHomeCanteenFoodCfg[arg_22_0.foodID].cook_type

	arg_22_0.incomeNumTex_.text = math.floor(var_22_0 * arg_22_0.sellNum)

	local var_22_2 = (100 - DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FoodCostQucik, nil, nil, var_22_1)) / 100

	arg_22_0.costTimeTex.text = DormTools:SecondSwitchTime(math.ceil(BackHomeCanteenFoodCfg[arg_22_0.foodID].cost_time * arg_22_0.sellNum * var_22_2))

	arg_22_0.foodMaterialScroll:Refresh()
end

function var_0_0.RefreshFoodInfo(arg_23_0)
	arg_23_0.iconImg_.sprite = CanteenTools.GetFoodSprite(arg_23_0.foodID)
	arg_23_0.foodName.text = GetI18NText(BackHomeCanteenFoodCfg[arg_23_0.foodID].name)
	arg_23_0.descText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_23_0.foodID].desc)
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.foodMaterialScroll then
		arg_24_0.foodMaterialScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
