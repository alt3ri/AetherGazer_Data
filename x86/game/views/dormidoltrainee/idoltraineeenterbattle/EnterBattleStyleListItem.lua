local var_0_0 = class("EnterBattleStyleListItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.style_.text = GetTips("IDOL_DANCE_TYPE_TIPS_" .. arg_2_1)
	arg_2_0.color_.color = IdolTraineeConst.styleColor[arg_2_1]
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
end

return var_0_0
