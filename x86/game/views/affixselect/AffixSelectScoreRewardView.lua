local var_0_0 = class("AffixSelectScoreRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/DarkFlameUI/DFQualsDrilUI/DFQualsDrillRewardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uiListGo_, AffixSelectScoreRewardItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.rewardIdList_[arg_6_1], arg_6_0.activityId)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnReceivePointReward(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if table.indexof(arg_9_0.rewardIdList_, iter_9_1) then
			arg_9_0:UpdateList()

			break
		end
	end
end

function var_0_0.AddEventListeners(arg_10_0)
	return
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0:UpdateBar()
end

function var_0_0.OnBehind(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.activityId = arg_14_0.params_.affixActivityId

	arg_14_0:AddEventListeners()
	arg_14_0:UpdateList()
end

function var_0_0.OnExit(arg_15_0)
	arg_15_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateList(arg_16_0)
	arg_16_0.scoreLabel_.text = ActivityAffixSelectData:GetTotalScore(arg_16_0.activityId)
	arg_16_0.rewardIdList_ = deepClone(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_16_0.activityId])
	arg_16_0.haveGetLabel_.text = ActivityAffixSelectData:ScoreRewardGetCount(arg_16_0.activityId) .. "/" .. #arg_16_0.rewardIdList_

	table.sort(arg_16_0.rewardIdList_, function(arg_17_0, arg_17_1)
		local var_17_0 = ActivityAffixSelectData:GetRewardStatus(arg_16_0.activityId, arg_17_0)
		local var_17_1 = ActivityAffixSelectData:GetRewardStatus(arg_16_0.activityId, arg_17_1)

		if var_17_0 ~= var_17_1 then
			return var_17_1 < var_17_0
		end

		return arg_17_0 < arg_17_1
	end)
	arg_16_0.uiList_:StartScroll(#arg_16_0.rewardIdList_)
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.uiList_ then
		arg_19_0.uiList_:Dispose()

		arg_19_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
