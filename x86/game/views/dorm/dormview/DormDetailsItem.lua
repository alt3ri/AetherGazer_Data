local var_0_0 = class("DormDetailsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.levelNum.text = arg_3_3
	arg_3_0.comfortNum.text = arg_3_2
	arg_3_0.heroName.text = HeroRecordCfg[arg_3_1].name
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
