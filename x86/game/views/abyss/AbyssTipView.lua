local var_0_0 = class("AbyssTipView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Abyss/AbyssTips"
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
	return
end

function var_0_0.AddEventListeners(arg_7_0)
	return
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
end

function var_0_0.OnBehind(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_10_0)
	arg_10_0:ShowDefaultBar()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.OnAbyssRefresh(arg_14_0)
	JumpTools.OpenPageByJump("/abyssMain", {
		refresh = true
	})
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
