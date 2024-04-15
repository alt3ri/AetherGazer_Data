local var_0_0 = class("ChatShieldSetView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Chat/ChatShieldSetUI"
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
	arg_5_0.wordItems_ = {}
	arg_5_0.shieldSetModel_ = arg_5_0.selector_.compute(gameStore.getState())

	arg_5_0:RefreshItem(arg_5_0.shieldSetModel_.wordCnt)

	arg_5_0.unsubscribeFun = gameStore.subscribe(function(arg_6_0)
		arg_5_0:OnSubscribe()
	end)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:RemoveAllItems()
	arg_7_0.unsubscribeFun()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveListeners()
	arg_8_0:RemoveAllItems()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0.closeBtn_ = arg_9_0:FindCom(typeof(Button), "closeBtn")
	arg_9_0.addBtn_ = arg_9_0:FindCom(typeof(Button), "addBtn")
	arg_9_0.inputField_ = arg_9_0:FindCom("InputField", "InputField")
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.closeBtn_, nil, function()
		arg_10_0:Back()
	end)
	arg_10_0:AddBtnListener(arg_10_0.addBtn_, nil, function()
		local var_12_0 = arg_10_0.inputField_.text

		if var_12_0 == "" then
			return ShowTips("INPUT_CHAT_CONTENT")
		end

		ActionCreators.AddShieldWord(var_12_0):next(function(arg_13_0)
			if arg_13_0.result == 0 then
				ActionCreators.AddShieldWordSuccess(var_12_0)
			else
				ShowTips(arg_13_0.result)
			end
		end, function(arg_14_0)
			print(arg_14_0)
		end)
	end)
end

function var_0_0.RemoveListeners(arg_15_0)
	arg_15_0.closeBtn_.onClick:RemoveAllListeners()
	arg_15_0.addBtn_.onClick:RemoveAllListeners()
end

function var_0_0.CreateSelector(arg_16_0)
	arg_16_0.selector_ = createStructuredSelector({
		wordCnt = function(arg_17_0)
			return #arg_17_0.chat.shieldWordList
		end
	})
end

function var_0_0.OnSubscribe(arg_18_0)
	local var_18_0 = arg_18_0.selector_.compute(gameStore.getState())

	if var_18_0.wordCnt ~= arg_18_0.shieldSetModel_.wordCnt then
		arg_18_0:RefreshItem(var_18_0.wordCnt)

		arg_18_0.shieldSetModel_.wordCnt = var_18_0.wordCnt
	end
end

function var_0_0.RefreshItem(arg_19_0, arg_19_1)
	for iter_19_0 = #arg_19_0.wordItems_, arg_19_1 + 1, -1 do
		arg_19_0.wordItems_[iter_19_0]:OnExit()
		arg_19_0.wordItems_[iter_19_0]:Dispose()
		table.remove(arg_19_0.wordItems_, iter_19_0)
	end

	for iter_19_1 = #arg_19_0.wordItems_ + 1, arg_19_1 do
		local var_19_0 = ChatShieldItemView.New(arg_19_0.gameObject_, iter_19_1)

		var_19_0:OnEnter()
		table.insert(arg_19_0.wordItems_, var_19_0)
	end
end

function var_0_0.RemoveAllItems(arg_20_0)
	for iter_20_0 = #arg_20_0.wordItems_, 1, -1 do
		arg_20_0.wordItems_[iter_20_0]:OnExit()
		arg_20_0.wordItems_[iter_20_0]:Dispose()
		table.remove(arg_20_0.wordItems_, iter_20_0)
	end
end

return var_0_0
