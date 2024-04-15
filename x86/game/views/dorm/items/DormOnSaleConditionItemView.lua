local var_0_0 = class("DormOnSaleConditionItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.cfg_ = ConditionCfg[arg_5_1]

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	arg_6_0.contentLabel_.text = GetI18NText(arg_6_0.cfg_.desc)

	local var_6_0, var_6_1 = ConditionTools.GetConditionProgress(arg_6_0.cfg_.id)

	arg_6_0.checkbox_.isOn = var_6_1 <= var_6_0
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
