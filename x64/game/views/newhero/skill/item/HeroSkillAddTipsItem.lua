local var_0_0 = class("HeroSkillAddTipsItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, true)

	arg_3_0.nametextText_.text = arg_3_1.titleName
	arg_3_0.messagetextText_.text = arg_3_1.showDesc
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
