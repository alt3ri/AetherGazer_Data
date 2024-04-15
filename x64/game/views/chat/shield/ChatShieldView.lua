local var_0_0 = class("ChatShieldView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Chat/ChatShieldUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0:CreateSelector()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.shieldModel_ = arg_5_0.selector_.compute(gameStore.getState())

	arg_5_0:RefreshToggle(arg_5_0.shieldModel_.openShieldWord)

	arg_5_0.unsubscribeFun = gameStore.subscribe(function(arg_6_0)
		arg_5_0:OnSubscribe()
	end)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.unsubscribeFun()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveListeners()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0.closeBtn_ = arg_9_0:FindCom(typeof(Button), "mask")
	arg_9_0.closeBtn1_ = arg_9_0:FindCom(typeof(Button), "bg/closeBtn")
	arg_9_0.cancelBtn_ = arg_9_0:FindCom(typeof(Button), "bg/cancelBtn")
	arg_9_0.managerBtn_ = arg_9_0:FindCom(typeof(Button), "bg/managerBtn")
	arg_9_0.btnToggle_ = arg_9_0:FindCom(typeof(Toggle), "bg/btnToggle")
	arg_9_0.offImg_ = arg_9_0:FindGo("bg/btnToggle/offImg")
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.closeBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.closeBtn1_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.cancelBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.managerBtn_, nil, function()
		arg_10_0:Go("/chatShieldSet")
	end)
	arg_10_0:AddToggleListener(arg_10_0.btnToggle_, function(arg_15_0)
		SetActive(arg_10_0.offImg_, not arg_15_0)

		if arg_10_0:GetViewProp("firstEnter") == nil then
			arg_10_0:SetViewProp("firstEnter", true)

			return
		end

		local var_15_0 = 1

		if arg_15_0 then
			var_15_0 = 0
		end

		if arg_15_0 == arg_10_0.shieldModel_.openShieldWord then
			return
		end

		ActionCreators.ShieldWordOperate(arg_15_0):next(function(arg_16_0)
			print(arg_16_0.result)

			if arg_16_0.result == 0 then
				ActionCreators.ShieldWordOperateSuccess(var_15_0)
			else
				ShowTips(arg_16_0.result)
			end
		end, function(arg_17_0)
			print(arg_17_0)
		end)
	end)
end

function var_0_0.RemoveListeners(arg_18_0)
	arg_18_0.closeBtn_.onClick:RemoveAllListeners()
	arg_18_0.closeBtn1_.onClick:RemoveAllListeners()
	arg_18_0.cancelBtn_.onClick:RemoveAllListeners()
	arg_18_0.managerBtn_.onClick:RemoveAllListeners()
	arg_18_0.btnToggle_.onValueChanged:RemoveAllListeners()
end

function var_0_0.CreateSelector(arg_19_0)
	arg_19_0.selector_ = createStructuredSelector({
		openShieldWord = function(arg_20_0)
			return arg_20_0.chat.openShieldWord
		end
	})
end

function var_0_0.OnSubscribe(arg_21_0)
	local var_21_0 = arg_21_0.selector_.compute(gameStore.getState())

	if var_21_0.openShieldWord ~= arg_21_0.shieldModel_.openShieldWord then
		arg_21_0.shieldModel_.openShieldWord = var_21_0.openShieldWord
	end
end

function var_0_0.RefreshToggle(arg_22_0, arg_22_1)
	local var_22_0 = false

	if arg_22_1 == 0 then
		var_22_0 = true
	end

	if arg_22_0.btnToggle_.isOn == var_22_0 then
		arg_22_0.btnToggle_.onValueChanged:Invoke(var_22_0)
	else
		arg_22_0.btnToggle_.isOn = var_22_0
	end
end

return var_0_0
