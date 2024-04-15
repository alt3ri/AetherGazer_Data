local var_0_0 = class("ChatToggleBaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.chatToggleID_ = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController_ = ControllerUtil.GetController(arg_2_0.transform_, "name")
	arg_2_0.text_.text = ChatToggleCfg[arg_2_0.chatToggleID_].name
	arg_2_0.text2_.text = ChatToggleCfg[arg_2_0.chatToggleID_].name
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddToggleListener(arg_3_0.toggle_, function(arg_4_0)
		if arg_4_0 then
			arg_3_0:OnClickToggle()
		end
	end)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
	arg_6_0.lockController_:SetSelectedState(tostring(arg_6_0:IsLock()))
end

function var_0_0.IsOn(arg_7_0)
	arg_7_0.toggle_.isOn = true
end

function var_0_0.OnClickToggle(arg_8_0)
	arg_8_0:Go("chat", {
		chatToggleID = arg_8_0.chatToggleID_
	})
end

function var_0_0.IsLock(arg_9_0)
	return false
end

return var_0_0
