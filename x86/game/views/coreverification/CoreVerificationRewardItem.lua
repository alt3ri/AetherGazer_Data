local var_0_0 = class("CoreVerificationRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.receiveBtn_, nil, function()
		CoreVerificationAction.GetReward({
			reward_list = {
				arg_3_0.data_
			}
		})
		arg_3_0.controller_:SetSelectedState("complete")
	end)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.rewardItems_ = {}
	arg_5_0.controller_ = arg_5_0.allBtnController_:GetController("all")
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.data_ = arg_6_1
	arg_6_0.type_ = arg_6_2

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = CoreVerificationRewardCfg[arg_7_0.data_]
	local var_7_1 = ConditionCfg[var_7_0.condition]

	arg_7_0.titleText_.text = string.format(GetI18NText(var_7_1.desc), var_7_1.params[1])

	local var_7_2, var_7_3, var_7_4, var_7_5 = CoreVerificationData:GetTaskProcess(arg_7_0.data_)

	arg_7_0.progressBar_.value = var_7_2 / var_7_3
	arg_7_0.progressText_.text = string.format("%s/%s", var_7_2, var_7_3)

	if var_7_5 then
		arg_7_0.controller_:SetSelectedState("complete")
	elseif var_7_4 then
		arg_7_0.controller_:SetSelectedState("receive")
	else
		arg_7_0.controller_:SetSelectedState("lock")
	end

	local var_7_6 = var_7_0.reward or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_6) do
		local var_7_7 = formatReward(iter_7_1)
		local var_7_8 = clone(ItemTemplateData)

		if arg_7_0.rewardItems_[iter_7_0] == nil then
			arg_7_0.rewardItems_[iter_7_0] = CommonItemView.New(arg_7_0[string.format("awardItem%dObj_", iter_7_0)])
			arg_7_0.rewardItems_[iter_7_0].ResetTransform = function()
				return
			end
		end

		var_7_8.id = var_7_7.id
		var_7_8.number = var_7_7.num
		var_7_8.timeValid = iter_7_1.timeValid or 0
		var_7_8.completedFlag = arg_7_0.taskComplete_
		var_7_8.clickFun = handler(arg_7_0, arg_7_0.OnClickCommonItem)

		arg_7_0.rewardItems_[iter_7_0]:SetData(var_7_8)
	end

	for iter_7_2 = #var_7_0.reward + 1, #arg_7_0.rewardItems_ do
		arg_7_0.rewardItems_[iter_7_2]:SetData(nil)
	end
end

function var_0_0.OnClickCommonItem(arg_9_0, arg_9_1)
	ShowPopItem(POP_ITEM, {
		arg_9_1.id,
		arg_9_1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0:UpdateView()
end

function var_0_0.Dispose(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.rewardItems_) do
		iter_11_1:Dispose()
	end

	arg_11_0.rewardItems_ = {}

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
