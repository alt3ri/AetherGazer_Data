local var_0_0 = class("SectionThreeStarBar", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.enabledController_ = arg_1_0.controllerEx_:GetController("enabled")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.enabledController_:SetSelectedState(tostring(arg_2_1))
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

return var_0_0
