local var_0_0 = class("RestaurantFoodMenuView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamRecipePop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.itemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.itemuilistGo_, FoodMenuItem)
	arg_4_0.bagScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.baguilistUilist_, FoodMenuItem)
	arg_4_0.tastScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexTastItem), arg_4_0.tasteuilistUilist_, CanteenFoodTasteitem)
	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.transform_, "state")
	arg_4_0.infoController = ControllerUtil.GetController(arg_4_0.transform_, "info")
	arg_4_0.materialItemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexMaterialItem), arg_4_0.materiallistUilist_, FoodMaterialItem)
	arg_4_0.btnController = {
		[3] = ControllerUtil.GetController(arg_4_0.fryingpanBtn_.transform, "name"),
		[4] = ControllerUtil.GetController(arg_4_0.steamerBtn_.transform, "name"),
		[5] = ControllerUtil.GetController(arg_4_0.grillBtn_.transform, "name"),
		[6] = ControllerUtil.GetController(arg_4_0.potBtn_.transform, "name")
	}
	arg_4_0.menuController = ControllerUtil.GetController(arg_4_0.recipeGo_.transform, "toggle")
	arg_4_0.bagController = ControllerUtil.GetController(arg_4_0.bagGo_.transform, "toggle")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.recipeBtn_, nil, function()
		arg_5_0.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		arg_5_0:UpdataFoodMenuView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.fryingpanBtn_, nil, function()
		arg_5_0.curChooseIndex = DormEnum.FurnitureTypeNum.Pan

		arg_5_0:UpdataFoodMenuView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.grillBtn_, nil, function()
		arg_5_0.curChooseIndex = DormEnum.FurnitureTypeNum.Oven

		arg_5_0:UpdataFoodMenuView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.steamerBtn_, nil, function()
		arg_5_0.curChooseIndex = DormEnum.FurnitureTypeNum.Steamer

		arg_5_0:UpdataFoodMenuView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.potBtn_, nil, function()
		arg_5_0.curChooseIndex = DormEnum.FurnitureTypeNum.Pot

		arg_5_0:UpdataFoodMenuView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.bagBtn_, nil, function()
		arg_5_0:UpdataBagView()
	end)
	arg_5_0:AddBtnListener(arg_5_0.proiconBtn_, nil, function()
		JumpTools.OpenPageByJump("canteenProDesView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.isEnter = true

	manager.windowBar:HideBar()

	arg_14_0.menuType = arg_14_0.params_.state

	if arg_14_0.menuType == DormEnum.MenuType.foodMenu then
		arg_14_0.curChooseIndex = arg_14_0.curChooseIndex or DormEnum.FurnitureTypeNum.Pan

		arg_14_0:UpdataFoodMenuView()
	elseif arg_14_0.menuType == DormEnum.MenuType.bag then
		arg_14_0:UpdataBagView()
	end

	arg_14_0:RegisterEvent()
	arg_14_0:BindFoodTypeRedPoint(arg_14_0.fryingpanBtn_.transform, DormEnum.FurnitureTypeNum.Pan)
	arg_14_0:BindFoodTypeRedPoint(arg_14_0.grillBtn_.transform, DormEnum.FurnitureTypeNum.Oven)
	arg_14_0:BindFoodTypeRedPoint(arg_14_0.steamerBtn_.transform, DormEnum.FurnitureTypeNum.Steamer)
	arg_14_0:BindFoodTypeRedPoint(arg_14_0.potBtn_.transform, DormEnum.FurnitureTypeNum.Pot)

	arg_14_0.isEnter = false
end

function var_0_0.OnTop(arg_15_0)
	return
end

function var_0_0.RegisterEvent(arg_16_0)
	arg_16_0:RegistEventListener(CANTEEN_CLICK_MENU_ITEM, function(arg_17_0, arg_17_1)
		if arg_17_1 == DormEnum.MenuType.bag then
			arg_16_0.bagScroll_:Refresh()
		else
			arg_16_0.itemScroll_:Refresh()
		end

		arg_16_0:RefreshInfoPage(arg_17_0)
	end)
	arg_16_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_18_0)
		if (arg_18_0 == 0 or arg_18_0 == ShopConst.SHOP_ID.CANTEEN_SHOP) and arg_16_0.menuType == DormEnum.MenuType.foodMenu then
			arg_16_0:UpdataFoodMenuView()
		end
	end)
end

function var_0_0.UpdataBagView(arg_19_0)
	arg_19_0.menuType = DormEnum.MenuType.bag

	arg_19_0.stateController:SetSelectedState("bag")
	arg_19_0.menuController:SetSelectedState("off")
	arg_19_0.bagController:SetSelectedState("on")
	arg_19_0.infoController:SetSelectedState("off")

	for iter_19_0, iter_19_1 in pairs(arg_19_0.btnController) do
		iter_19_1:SetSelectedState("off")
	end

	arg_19_0:RefreshBag()
	arg_19_0.bagScroll_:StartScroll(#arg_19_0.itemList_)
	arg_19_0:RefreshItemInfo(arg_19_0.itemList_[1], DormEnum.MenuType.bag)
end

function var_0_0.UpdataFoodMenuView(arg_20_0)
	arg_20_0.menuType = DormEnum.MenuType.foodMenu

	arg_20_0:UpdateItemData(arg_20_0.curChooseIndex)
	arg_20_0.stateController:SetSelectedState("food")
	arg_20_0.bagController:SetSelectedState("off")
	arg_20_0.menuController:SetSelectedState("on")
	arg_20_0.infoController:SetSelectedState("off")
	arg_20_0.itemScroll_:StartScroll(#arg_20_0.itemList_)

	for iter_20_0, iter_20_1 in pairs(arg_20_0.btnController) do
		if iter_20_0 == arg_20_0.curChooseIndex then
			iter_20_1:SetSelectedState("on")
		else
			iter_20_1:SetSelectedState("off")
		end
	end

	local var_20_0

	if arg_20_0.selItem and BackHomeCanteenFoodCfg[arg_20_0.selItem] and BackHomeCanteenFoodCfg[arg_20_0.selItem].cook_type == arg_20_0.curChooseIndex then
		var_20_0 = arg_20_0.selItem
	else
		var_20_0 = arg_20_0.itemList_[1]
	end

	arg_20_0:RefreshItemInfo(var_20_0, DormEnum.MenuType.foodMenu)
end

function var_0_0.indexItem(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2:RefreshItem(arg_21_0.itemList_[arg_21_1], arg_21_0.menuType, arg_21_0.selItem)

	if arg_21_0.menuType == DormEnum.MenuType.foodMenu then
		arg_21_0.bindPointFlag = true

		arg_21_0:BindRedPoint(arg_21_1, arg_21_2)
	end

	arg_21_2:RegisterClickCallBack(function(arg_22_0, arg_22_1)
		if arg_21_0.selItem == arg_22_0 and not arg_21_0.isEnter then
			return
		end

		arg_21_0.selItem = arg_22_0

		arg_21_0:RefreshItemInfo(arg_22_0, arg_22_1)

		if arg_22_1 == DormEnum.MenuType.foodMenu then
			local var_22_0 = tostring(BackHomeCanteenFoodCfg[arg_22_0].cook_type)

			DormRedPointTools:ConsumeNotification(string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, var_22_0, arg_22_0), DormRedPointTools.RedPointType.LocalMachine)
		end
	end)
end

function var_0_0.BindFoodTypeRedPoint(arg_23_0, arg_23_1, arg_23_2)
	manager.redPoint:bindUIandKey(arg_23_1, string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, arg_23_2))
end

function var_0_0.UnBindFoodTypeRedPoint(arg_24_0, arg_24_1, arg_24_2)
	manager.redPoint:unbindUIandKey(arg_24_1, string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, arg_24_2))
end

function var_0_0.BindRedPoint(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(BackHomeCanteenFoodCfg[arg_25_0.itemList_[arg_25_1]].cook_type), arg_25_0.itemList_[arg_25_1])

	if manager.redPoint:getTipBoolean(var_25_0) then
		manager.redPoint:SetRedPointIndependent(arg_25_2.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(arg_25_2.transform_, false)
	end
end

function var_0_0.RefreshItemInfo(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 then
		arg_26_0.selItem = arg_26_1

		if arg_26_2 == DormEnum.MenuType.bag then
			arg_26_0.bagScroll_:Refresh()
		else
			arg_26_0.itemScroll_:Refresh()
		end

		arg_26_0:RefreshInfoPage(arg_26_1)
	end
end

function var_0_0.indexMaterialItem(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2:RefreshItem(arg_27_0.materialItemList_[arg_27_1])
end

function var_0_0.indexTastItem(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2:RefreshUI(arg_28_0.tasteItemList_[arg_28_1])
end

function var_0_0.RefreshBag(arg_29_0)
	arg_29_0.itemList_ = {}

	for iter_29_0, iter_29_1 in pairs(CanteenFoodData:GetCateenIngredient()) do
		table.insert(arg_29_0.itemList_, iter_29_0)
	end
end

function var_0_0.RefreshInfoPage(arg_30_0, arg_30_1)
	if arg_30_0.menuType == DormEnum.MenuType.foodMenu then
		arg_30_0.infoController:SetSelectedState("food")

		local var_30_0 = BackHomeCanteenFoodCfg[arg_30_1]

		arg_30_0.tasteItemList_ = var_30_0.tag
		arg_30_0.foodnameText_.text = GetI18NText(var_30_0.name)
		arg_30_0.earningnumText_.text = CanteenFoodData:GetFoodUnitCost(arg_30_1)
		arg_30_0.fooddescribeText_.text = GetI18NText(var_30_0.desc)

		arg_30_0:UpdataMaterialItemData(arg_30_1)
		arg_30_0.materialItemScroll_:StartScroll(#arg_30_0.materialItemList_)

		arg_30_0.foodiconImg_.sprite = getSpriteWithoutAtlas(DormConst.CANTEEN_FOOD_PATH .. BackHomeCanteenFoodCfg[arg_30_1].icon)
		arg_30_0.progressnumText_.text = CanteenFoodData:GetFoodProficiency(arg_30_1)

		arg_30_0:UpdataTasteData(arg_30_1)
	elseif arg_30_0.menuType == DormEnum.MenuType.bag then
		arg_30_0.infoController:SetSelectedState("ingredient")

		local var_30_1 = ItemCfg[arg_30_1]

		arg_30_0.ingnameText_.text = ItemTools.getItemName(arg_30_1)
		arg_30_0.ingdestextText_.text = ItemTools.getItemDesc(arg_30_1)

		local var_30_2 = CanteenFoodData:GetCateenIngredient()[arg_30_1]

		arg_30_0.ingnumText_.text = string.format("x%s", NumberTools.RetractNumberForWindBar(var_30_2))
		arg_30_0.foodicon2Img_.sprite = ItemTools.getItemSprite(arg_30_1)
	end
end

function var_0_0.UpdataTasteData(arg_31_0, arg_31_1)
	arg_31_0.tasteList = BackHomeCanteenFoodCfg[arg_31_1].tag

	arg_31_0.tastScroll_:StartScroll(#arg_31_0.tasteList)
end

function var_0_0.UpdateItemData(arg_32_0, arg_32_1)
	arg_32_0.itemList_ = {}

	local var_32_0 = 0

	for iter_32_0, iter_32_1 in ipairs(BackHomeCanteenFoodCfg.all) do
		if BackHomeCanteenFoodCfg[iter_32_1].cook_type == arg_32_1 then
			if CanteenTools:CheckFoodUnLock(iter_32_1) then
				var_32_0 = var_32_0 + 1
			end

			table.insert(arg_32_0.itemList_, iter_32_1)
		end
	end

	CommonTools.UniversalSortEx(arg_32_0.itemList_, {
		ascend = true,
		map = function(arg_33_0)
			if CanteenTools:CheckFoodUnLock(arg_33_0) then
				return 1
			else
				return 2
			end
		end
	}, {
		ascend = true,
		map = function(arg_34_0)
			return (CanteenTools:GetFoodUnLockLevel(arg_34_0))
		end
	}, {
		ascend = true,
		map = function(arg_35_0)
			return arg_35_0
		end
	})

	arg_32_0.curnumText_.text = var_32_0
	arg_32_0.totlanumText_.text = "/" .. #arg_32_0.itemList_
	arg_32_0.cooktitleText_.text = GetI18NText(CanteenTools:GetCookCfgName(arg_32_1))

	for iter_32_2, iter_32_3 in pairs(arg_32_0.btnController) do
		if iter_32_2 == arg_32_1 then
			iter_32_3:SetSelectedState("on")
		else
			iter_32_3:SetSelectedState("off")
		end
	end
end

function var_0_0.UpdataMaterialItemData(arg_36_0, arg_36_1)
	arg_36_0.materialItemList_ = {}

	for iter_36_0, iter_36_1 in ipairs(BackHomeCanteenFoodCfg[arg_36_1].ingredient_list) do
		table.insert(arg_36_0.materialItemList_, iter_36_1)
	end
end

function var_0_0.OnExit(arg_37_0)
	arg_37_0.params_.state = arg_37_0.menuType
	arg_37_0.bindPointFlag = nil

	arg_37_0:RemoveAllEventListener()
	arg_37_0:UnBindFoodTypeRedPoint(arg_37_0.fryingpanBtn_.transform, DormEnum.FurnitureTypeNum.Pan)
	arg_37_0:UnBindFoodTypeRedPoint(arg_37_0.grillBtn_.transform, DormEnum.FurnitureTypeNum.Oven)
	arg_37_0:UnBindFoodTypeRedPoint(arg_37_0.steamerBtn_.transform, DormEnum.FurnitureTypeNum.Steamer)
	arg_37_0:UnBindFoodTypeRedPoint(arg_37_0.potBtn_.transform, DormEnum.FurnitureTypeNum.Pot)
end

function var_0_0.Dispose(arg_38_0)
	if arg_38_0.materialItemScroll_ then
		arg_38_0.materialItemScroll_:Dispose()
	end

	if arg_38_0.itemScroll_ then
		arg_38_0.itemScroll_:Dispose()
	end

	if arg_38_0.bagScroll_ then
		arg_38_0.bagScroll_:Dispose()
	end

	if arg_38_0.tastScroll_ then
		arg_38_0.tastScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_38_0)
end

return var_0_0
