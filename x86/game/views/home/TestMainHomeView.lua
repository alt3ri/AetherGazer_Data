local var_0_0 = class("TestMainHomeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Main/TestMainHomeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.btn_ = arg_4_0.gameObject_:GetComponent(typeof(Button))
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		GameToSDK.Logout()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
