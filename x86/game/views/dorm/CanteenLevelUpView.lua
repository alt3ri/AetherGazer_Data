local var_0_0 = class("CanteenLevelUpView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenLvUpPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.chooseTasteItemScroll = LuaList.New(handler(arg_4_0, arg_4_0.refreshItem), arg_4_0.awarduilistUilist_, FoodMenuItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmaskBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.refreshItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:RefreshItem(arg_7_0.materialItemList_[arg_7_1][1], DormEnum.MenuType.levelAward, arg_7_0.materialItemList_[arg_7_1][2])
	arg_7_2:RegisterClickCallBack(function(arg_8_0, arg_8_1)
		ShowPopItem(POP_ITEM, {
			arg_8_0
		})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	manager.audio:PlayEffect("ui_system", "hero_levelup", "")
	arg_9_0:UpdataView()
end

function var_0_0.UpdataView(arg_10_0)
	arg_10_0.materialItemList_ = arg_10_0.params_.awardList
	arg_10_0.lvText_.text = CanteenData:GetInfoCanteenLevel()

	if arg_10_0.materialItemList_ then
		arg_10_0.chooseTasteItemScroll:StartScroll(#arg_10_0.materialItemList_)
	end
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.chooseTasteItemScroll then
		arg_11_0.chooseTasteItemScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
