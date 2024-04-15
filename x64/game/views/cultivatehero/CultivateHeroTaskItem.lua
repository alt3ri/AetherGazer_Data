local var_0_0 = class("CultivateHeroTaskItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.rewardState_ = ControllerUtil.GetController(arg_2_0.transform_, "status")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.receiveBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		CultivateHeroAction.RequireReceiveHeroTaskList(arg_4_0.activityID_, {
			arg_4_0.taskID_
		}, function()
			arg_4_0.onReceived_()
		end)
	end)
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.onReceived_ = nil

	arg_7_0.commonItem_:Dispose()

	arg_7_0.commonItem_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.activityID_ = arg_8_1
	arg_8_0.taskID_ = arg_8_2

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshDesc()
	arg_9_0:RefreshState()
	arg_9_0:RefreshItem()
end

function var_0_0.RefreshDesc(arg_10_0)
	local var_10_0 = CultivateHeroTaskCfg[arg_10_0.taskID_]

	arg_10_0.descText_.text = GetI18NText(var_10_0.desc)

	local var_10_1 = var_10_0.condition
	local var_10_2 = CultivateHeroData:GetHeroTaskInfoList(arg_10_0.activityID_)[arg_10_0.taskID_]
	local var_10_3 = var_10_1

	if var_10_2 and var_10_2.progress and var_10_1 > var_10_2.progress then
		var_10_3 = var_10_2.progress
	end

	arg_10_0.progressText_.text = string.format("%d/%d", var_10_3, var_10_1)

	local var_10_4 = var_10_3 / var_10_1

	arg_10_0.progressSlider_.value = var_10_4
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.rewardCfg_ = CultivateHeroTaskCfg[arg_11_0.taskID_].reward[1]

	if arg_11_0.commonItem_ == nil then
		arg_11_0.commonItem_ = CommonItemView.New(arg_11_0.rewardItemGo_)
		arg_11_0.itemData_ = clone(ItemTemplateData)

		function arg_11_0.itemData_.clickFun(arg_12_0)
			ShowPopItem(POP_ITEM, arg_12_0)
		end
	end

	arg_11_0.itemData_.id = arg_11_0.rewardCfg_[1]
	arg_11_0.itemData_.number = arg_11_0.rewardCfg_[2]

	arg_11_0.commonItem_:SetData(arg_11_0.itemData_)
end

function var_0_0.RefreshState(arg_13_0)
	local var_13_0 = CultivateHeroData:GetHeroTaskInfoList(arg_13_0.activityID_)
	local var_13_1 = var_13_0[arg_13_0.taskID_].isCompleted
	local var_13_2 = var_13_0[arg_13_0.taskID_].isReceived

	if not var_13_1 then
		arg_13_0.rewardState_:SetSelectedState("uncomplete")
	elseif not var_13_2 then
		arg_13_0.rewardState_:SetSelectedState("unreceive")
	else
		arg_13_0.rewardState_:SetSelectedState("received")
	end
end

function var_0_0.SetReveivedHandler(arg_14_0, arg_14_1)
	arg_14_0.onReceived_ = arg_14_1
end

return var_0_0
