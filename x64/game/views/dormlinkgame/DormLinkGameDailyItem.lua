local var_0_0 = class("DormLinkGameDailyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.rewardItems_ = {}
	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.receiveBtn_, nil, function()
		TaskAction:SubmitTask(arg_4_0.taskID_)
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.taskID_ = arg_6_1
	arg_6_0.activityID_ = arg_6_2
	arg_6_0.taskActivityID_ = DormLinkGameTools:GetTaskActivityID(arg_6_0.activityID_)
	arg_6_0.info_ = TaskData2:GetTask(arg_6_0.taskID_)
	arg_6_0.cfg_ = AssignmentCfg[arg_6_1]

	arg_6_0:RefreshReward()
	arg_6_0:RefreshTask()
end

function var_0_0.RefreshReward(arg_7_0)
	local var_7_0 = arg_7_0.cfg_.reward

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if not arg_7_0.rewardItems_[iter_7_0] then
			arg_7_0.rewardItems_[iter_7_0] = RewardItem.New(arg_7_0.rewardItem_, arg_7_0.rewardParent_)

			arg_7_0.rewardItems_[iter_7_0]:UpdateCommonItemAni()
		end

		arg_7_0.rewardItems_[iter_7_0]:SetData(iter_7_1)
	end

	for iter_7_2 = #var_7_0 + 1, #arg_7_0.rewardItems_ do
		arg_7_0.rewardItems_[iter_7_2]:Show(false)
	end
end

function var_0_0.RefreshTask(arg_8_0)
	arg_8_0.desc_.text = arg_8_0.cfg_.desc

	local var_8_0 = 0

	if arg_8_0.info_.progress >= arg_8_0.cfg_.need then
		var_8_0 = arg_8_0.cfg_.need
	else
		var_8_0 = arg_8_0.info_.progress
	end

	arg_8_0.progress_.text = var_8_0 .. "/" .. arg_8_0.cfg_.need
	arg_8_0.slider_.value = var_8_0 / arg_8_0.cfg_.need

	if arg_8_0.info_.complete_flag >= 1 then
		arg_8_0.stateCon_:SetSelectedState("received")
	elseif var_8_0 >= arg_8_0.cfg_.need then
		arg_8_0.stateCon_:SetSelectedState("complete")
	else
		arg_8_0.stateCon_:SetSelectedState("unfinish")
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()

	for iter_9_0 = 1, #arg_9_0.rewardItems_ do
		arg_9_0.rewardItems_[iter_9_0]:Dispose()
	end

	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
