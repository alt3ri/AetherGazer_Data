local var_0_0 = class("DormLinkGameItemTips", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGTips"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
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
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.bgmaskBtn_, nil, function()
		JumpTools:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.itemID = arg_8_0.params_.itemID

	arg_8_0:RefreshView()
end

function var_0_0.RefreshView(arg_9_0)
	local var_9_0 = ActivityLinkGameGoodsCfg[arg_9_0.itemID]

	if var_9_0 then
		arg_9_0.textText_.text = var_9_0.goods_des
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
