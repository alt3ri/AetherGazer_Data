local var_0_0 = class("LoginBulletinView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Common/NoticeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.richText_ = arg_4_0:FindCom("RichText", "", arg_4_0.richTextTrs_)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0.richText_:AddListener(function(arg_6_0, arg_6_1)
		if arg_6_0 == "1" then
			Application.OpenURL(arg_6_1)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.sureButton_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_.content or ""

	if type(var_8_0) ~= "string" then
		arg_8_0.richText_.text = ""

		return
	end

	local var_8_1 = "< *a .-href *= *\"(.-)\".->(.-)< */a *>"
	local var_8_2 = string.gsub(var_8_0, var_8_1, function(arg_9_0, arg_9_1)
		arg_9_0 = arg_9_0 or ""
		arg_9_1 = arg_9_1 or ""

		local var_9_0 = "<material=underline h=2 event=1 args=%s>%s</material>"

		return string.format(var_9_0, arg_9_0, arg_9_1)
	end)

	arg_8_0.richText_.text = var_8_2
end

return var_0_0
