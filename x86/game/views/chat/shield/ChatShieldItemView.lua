local var_0_0 = class("ChatShieldItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0:FindGo("ScrollView/Viewport/Content", arg_1_1.transform).transform

	arg_1_0.gameObject_ = Object.Instantiate(arg_1_0:FindGo("ScrollView/Viewport/Content/wordItem", arg_1_1.transform), var_1_0)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:SetViewProp("itemIndex", arg_1_2)
	arg_1_0:CreateSelector()
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemModel_ = arg_2_0.selector_.compute(gameStore.getState(), arg_2_0:GetViewProp("itemIndex"))

	arg_2_0:RefreshItem(arg_2_0.itemModel_.word)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.unsubscribeFun = gameStore.subscribe(function(arg_4_0)
		arg_3_0:OnSubscribe()
	end)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.unsubscribeFun()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0:RemoveListeners()
	Object.Destroy(arg_6_0.gameObject_)

	arg_6_0.gameObject_ = nil
	arg_6_0.transform_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0.closeBtn_ = arg_7_0:FindCom(typeof(Button), "closeBtn")
	arg_7_0.context_ = arg_7_0:FindCom(typeof(Text), "Text")
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		local var_9_0 = arg_8_0.itemModel_.word

		ActionCreators.DeleteShieldWord(var_9_0):next(function(arg_10_0)
			if arg_10_0.result == 0 then
				ActionCreators.DeleteShieldWordSuccess(arg_8_0:GetViewProp("itemIndex"))
			else
				ShowTips(arg_10_0.result)
			end
		end, function(arg_11_0)
			print(arg_11_0)
		end)
	end)
end

function var_0_0.RemoveListeners(arg_12_0)
	arg_12_0.closeBtn_.onClick:RemoveAllListeners()
end

function var_0_0.CreateSelector(arg_13_0)
	arg_13_0.selector_ = createStructuredSelector({
		word = function(arg_14_0, arg_14_1)
			return arg_14_0.chat.shieldWordList[arg_14_1]
		end
	})
end

function var_0_0.OnSubscribe(arg_15_0)
	local var_15_0 = arg_15_0.selector_.compute(gameStore.getState(), arg_15_0:GetViewProp("itemIndex"))

	if var_15_0.word ~= arg_15_0.itemModel_.word then
		arg_15_0.itemModel_.word = var_15_0.word

		arg_15_0:RefreshItem(arg_15_0.itemModel_.word)
	end
end

function var_0_0.RefreshItem(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return
	end

	arg_16_0.context_.text = shortenString(arg_16_1, 15)
end

return var_0_0
