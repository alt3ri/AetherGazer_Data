local var_0_0 = class("DormSaleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HouseUI/HouseonsaleUI"
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

	arg_5_0.saleList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.listGo_, DormOnSaleItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = DormData:GetCurrectSceneID()
	local var_6_1 = not DormData:IsGoodPosOpen(arg_6_1)
	local var_6_2 = DormData:GetDormSceneData(DormData:GetCurrectSceneID()).sales[arg_6_1]

	arg_6_2:SetData(arg_6_1, var_6_1, var_6_2)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	local var_9_0 = DormData:GetDormSceneData(DormData:GetCurrectSceneID()).sales

	arg_9_0.saleList_:StartScroll(#var_9_0)
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	if arg_11_0.saleList_ then
		arg_11_0.saleList_:Dispose()

		arg_11_0.saleList_ = nil
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
