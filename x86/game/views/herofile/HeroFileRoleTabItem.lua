local var_0_0 = class("HeroFileRoleTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onClick_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectController_ = arg_3_0.roleControllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selectBtn_, nil, arg_4_0.onClick_)
end

function var_0_0.Show(arg_5_0, arg_5_1)
	local var_5_0 = HeroTools.HeroUsingSkinInfo(arg_5_1).id

	arg_5_0.iconImg_.sprite = getSpriteViaConfig("HeroLittleIcon", var_5_0)

	SetActive(arg_5_0.gameObject_, true)
end

function var_0_0.Hide(arg_6_0)
	SetActive(arg_6_0.gameObject_, false)
end

function var_0_0.SetSelectState(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedState(arg_7_1 and "select" or "cancel")
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
