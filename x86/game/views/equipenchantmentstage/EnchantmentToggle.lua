local var_0_0 = class("EnchantmentToggle", ReduxView)
local var_0_1 = {
	"lock",
	"unLock",
	"finish"
}
local var_0_2 = {
	"select",
	"general"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1

	SetActive(arg_1_0.gameObject_, true)

	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.difficulty_ = arg_1_2

	arg_1_0:CreateSelector()
	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0.toggle_ = arg_2_0:FindCom(typeof(Toggle), "")
	arg_2_0.label_ = arg_2_0:FindCom(typeof(Text), "Label")
	arg_2_0.label_.text = GetTips("HARDLEVEL") .. GetI18NText(arg_2_0.difficulty_)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.unsubscribeFun = gameStore.subscribe(function(arg_4_0)
		arg_3_0:OnSubscribe()
	end)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.unsubscribeFun()
end

function var_0_0.ChangeToggle(arg_6_0, arg_6_1)
	return
end

function var_0_0.OnSubscribe(arg_7_0)
	return
end

function var_0_0.CreateSelector(arg_8_0)
	return
end

function var_0_0.AddListener(arg_9_0, arg_9_1)
	arg_9_0:AddToggleListener(arg_9_0.toggle_, arg_9_1)
end

function var_0_0.ChangeSelect(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.toggle_.isOn = true
	else
		arg_10_0.toggle_.isOn = false
	end
end

function var_0_0.ShowNotice(arg_11_0, arg_11_1)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	Object.Destroy(arg_12_0.gameObject_)

	arg_12_0.gameObject_ = nil

	arg_12_0.unsubscribeFun()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
