local var_0_0 = class("AlphaRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/PopupPhaseActivityUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardList_ = {}
	arg_4_0.itemPool_ = Pool.New(arg_4_0.rewardItemTemplate_, arg_4_0.rewardItemParent_, 0)
	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.rewardItemScroll_, AlphaRewardItem)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.rewardList_ do
		arg_7_0.rewardList_[iter_7_0]:OnEnter()
	end

	arg_7_0.generalTaskList_ = arg_7_0:GetTaskList()

	arg_7_0.scrollHelper_:StartScroll(#arg_7_0.generalTaskList_)
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2:RefreshReward(arg_8_0.generalTaskList_[arg_8_1])
end

function var_0_0.GetTaskList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.ALPHA]) do
		local var_9_1 = AssignmentCfg[iter_9_1].phase

		if not var_9_0[var_9_1] and AssignmentCfg[iter_9_1].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[iter_9_1].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
			var_9_0[var_9_1] = iter_9_1
		end
	end

	return var_9_0
end

function var_0_0.OnExit(arg_10_0)
	for iter_10_0 = 1, #arg_10_0.rewardList_ do
		arg_10_0.rewardList_[iter_10_0]:OnExit()
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0 = 1, #arg_11_0.rewardList_ do
		arg_11_0.rewardList_[iter_11_0]:Dispose()

		arg_11_0.rewardList_[iter_11_0] = nil
	end

	arg_11_0.rewardList_ = nil

	arg_11_0.itemPool_:Dispose()
	arg_11_0.scrollHelper_:Dispose()
	arg_11_0.super.Dispose(arg_11_0)
end

return var_0_0
