local var_0_0 = class("DormLinkGameActivityView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGStagePopUI"
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

	arg_5_0.activityScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexActivityItemList), arg_5_0.uilistGo_, DormLinkGameActivityItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.bgBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0:RegisterEvents()
	arg_8_0:RefreshView()

	arg_8_0.canGetAward = true
end

function var_0_0.RegisterEvents(arg_9_0)
	arg_9_0:RegistEventListener(DORM_LINK_REFRESH_LEVEL_AWARD, function(arg_10_0)
		arg_9_0.canGetAward = true

		arg_9_0:RefreshView()
		DormLinkGameData:CheckUnReciveLevelReward()
	end)
end

function var_0_0.indexActivityItemList(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(arg_11_0.activityList[arg_11_1])
	arg_11_2:GetLevelAward(function(arg_12_0)
		if arg_11_0.canGetAward then
			arg_11_0.canGetAward = false

			DormLinkGameAction:GetLevelAward(arg_12_0)
		end
	end)
end

function var_0_0.RefreshView(arg_13_0)
	local var_13_0 = ActivityLinkGameRewardCfg.all

	arg_13_0.activityList = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		table.insert(arg_13_0.activityList, iter_13_1)
	end

	CommonTools.UniversalSortEx(arg_13_0.activityList, {
		ascend = true,
		map = function(arg_14_0)
			local var_14_0 = DormLinkGameData:CheckLevelRewardState(arg_14_0)

			if var_14_0 == DormLinkGameConst.RewardItemState.unComplete then
				return 2
			elseif var_14_0 == DormLinkGameConst.RewardItemState.complete then
				return 1
			elseif var_14_0 == DormLinkGameConst.RewardItemState.received then
				return 3
			end
		end
	}, {
		ascend = true,
		map = function(arg_15_0)
			return arg_15_0
		end
	})
	arg_13_0.activityScroll:StartScroll(#arg_13_0.activityList)
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.activityScroll then
		arg_17_0.activityScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
