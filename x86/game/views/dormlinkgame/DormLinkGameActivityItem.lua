local var_0_0 = class("DormLinkGameActivityItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.count = 0
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListenerScale(arg_4_0.rewardBtn_, nil, function()
		arg_4_0.getAward(arg_4_0.ID)
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.ID = arg_6_1

	local var_6_0 = ActivityLinkGameRewardCfg[arg_6_1].condition

	if not ConditionCfg[var_6_0] then
		return
	end

	arg_6_0.text_.text = DormLinkGameTools:GetAwardDesc(arg_6_1)

	local var_6_1 = DormLinkGameData:CheckLevelRewardState(arg_6_1)

	if var_6_1 == DormLinkGameConst.RewardItemState.unComplete then
		arg_6_0.stateController:SetSelectedState("uncomplete")
	elseif var_6_1 == DormLinkGameConst.RewardItemState.complete then
		arg_6_0.stateController:SetSelectedState("complete")
	elseif var_6_1 == DormLinkGameConst.RewardItemState.received then
		arg_6_0.stateController:SetSelectedState("received")
	end

	arg_6_0:UpdataReward()
end

function var_0_0.UpdataReward(arg_7_0)
	if not arg_7_0.rewardList then
		arg_7_0.rewardList = {}
	end

	local var_7_0 = ActivityLinkGameRewardCfg[arg_7_0.ID].item_list

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if arg_7_0.rewardList[iter_7_0] then
			arg_7_0.rewardList[iter_7_0]:SetData(iter_7_1)
		else
			arg_7_0.rewardList[iter_7_0] = RewardPoolItem.New(arg_7_0.rewardParent_, iter_7_1, true)
		end
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0.rewardList) do
		arg_7_0.rewardList[iter_7_2]:Show(true)
	end
end

function var_0_0.GetLevelAward(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.getAward = arg_8_1
	end
end

function var_0_0.Dispose(arg_9_0)
	if arg_9_0.rewardList then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.rewardList) do
			arg_9_0.rewardList[iter_9_0]:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
