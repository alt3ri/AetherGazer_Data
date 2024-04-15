local var_0_0 = class("CultivateAccumulateRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return CultivateHeroTools.GetRewardUIName(arg_1_0.params_.activityID)
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, CultivateAccumulateRewardItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.activityID_ = arg_7_0.params_.activityID

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.scoreText_.text = ItemTools.getItemNum(ActivityCultivateHeroCfg[arg_8_0.activityID_].coin_id)
	arg_8_0.icon_.sprite = ItemTools.getItemSprite(ActivityCultivateHeroCfg[arg_8_0.activityID_].coin_id)

	arg_8_0:RefreshScroll()
end

function var_0_0.RefreshScroll(arg_9_0)
	arg_9_0.scrollHelper_:StartScroll(arg_9_0:GetAwardListLength())
end

function var_0_0.GetAwardListLength(arg_10_0)
	arg_10_0.taskIDList_ = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_10_0.activityID_]
	arg_10_0.maxRewardNum_ = 0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.taskIDList_) do
		local var_10_0 = #ActivityPointRewardCfg[iter_10_1].reward_item_list

		arg_10_0.maxRewardNum_ = var_10_0 > arg_10_0.maxRewardNum_ and var_10_0 or arg_10_0.maxRewardNum_
	end

	return #arg_10_0.taskIDList_
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, arg_11_0.taskIDList_[arg_11_1], arg_11_0.activityID_, arg_11_0.maxRewardNum_)
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.scrollHelper_ then
		arg_12_0.scrollHelper_:Dispose()

		arg_12_0.scrollHelper_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
