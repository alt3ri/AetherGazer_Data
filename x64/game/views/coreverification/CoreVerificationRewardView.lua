local var_0_0 = class("CoreVerificationRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_Verification/CoreVerificationQuest"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.selectIndex_ = 1
	arg_4_0.taskData_ = {}
	arg_4_0.taskUILuaList_ = LuaList.New(handler(arg_4_0, arg_4_0.SetRewardItem), arg_4_0.taskUilist_, CoreVerificationRewardItem)
	arg_4_0.pageIndexController_ = arg_4_0.mainControllerEx_:GetController("pageIndex")
	arg_4_0.getAllController_ = arg_4_0.mainControllerEx_:GetController("getAll")
	arg_4_0.firstController_ = arg_4_0.mainControllerEx_:GetController("first")
end

function var_0_0.SetRewardItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:SetData(arg_5_0.taskData_[arg_5_1], arg_5_0.selectIndex_)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.selectIndex_ = 1

	arg_6_0:ChangeButtonText()
	arg_6_0:UpdateView()
	manager.redPoint:bindUIandKey(arg_6_0.mainRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:bindUIandKey(arg_6_0.subRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:bindUIandKey(arg_6_0.diffRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD3)
	manager.redPoint:bindUIandKey(arg_6_0.firstRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD4)
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_7_0.mainRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD1)
	manager.redPoint:unbindUIandKey(arg_7_0.subRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD2)
	manager.redPoint:unbindUIandKey(arg_7_0.diffRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD3)
	manager.redPoint:unbindUIandKey(arg_7_0.firstRewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD4)
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.mainRewardBtn_, nil, function()
		if arg_8_0.selectIndex_ == 1 then
			return
		end

		arg_8_0.selectIndex_ = 1

		arg_8_0:UpdateView()
	end)
	arg_8_0:AddBtnListener(arg_8_0.subRewardBtn_, nil, function()
		if arg_8_0.selectIndex_ == 2 then
			return
		end

		arg_8_0.selectIndex_ = 2

		arg_8_0:UpdateView()
	end)
	arg_8_0:AddBtnListener(arg_8_0.diffRewardBtn_, nil, function()
		if arg_8_0.selectIndex_ == 3 then
			return
		end

		arg_8_0.selectIndex_ = 3

		arg_8_0:UpdateView()
	end)
	arg_8_0:AddBtnListener(arg_8_0.firstRewardBtn_, nil, function()
		if arg_8_0.selectIndex_ == 4 then
			return
		end

		arg_8_0.selectIndex_ = 4

		arg_8_0:UpdateView()
	end)
	arg_8_0:AddBtnListener(arg_8_0.allBtn_, nil, function()
		local var_13_0 = {
			reward_list = {}
		}

		for iter_13_0, iter_13_1 in ipairs(arg_8_0.taskData_) do
			local var_13_1, var_13_2, var_13_3, var_13_4 = CoreVerificationData:GetTaskProcess(iter_13_1)

			if var_13_3 and not var_13_4 then
				table.insert(var_13_0.reward_list, iter_13_1)
			end
		end

		if #var_13_0.reward_list == 0 then
			return
		end

		CoreVerificationAction.GetReward(var_13_0)
	end)
end

function var_0_0.UpdateView(arg_14_0)
	if CoreVerificationData:CheckFirstReward() == "false" and arg_14_0.selectIndex_ == 4 then
		arg_14_0.selectIndex_ = 1
	end

	arg_14_0.firstController_:SetSelectedState(CoreVerificationData:CheckFirstReward())
	arg_14_0.pageIndexController_:SetSelectedState(arg_14_0.selectIndex_)

	arg_14_0.taskData_ = CoreVerificationData:GetRewardListByType(arg_14_0.selectIndex_)

	table.sort(arg_14_0.taskData_, function(arg_15_0, arg_15_1)
		local var_15_0, var_15_1, var_15_2, var_15_3 = CoreVerificationData:GetTaskProcess(arg_15_0)
		local var_15_4, var_15_5, var_15_6, var_15_7 = CoreVerificationData:GetTaskProcess(arg_15_1)

		if var_15_3 ~= var_15_7 then
			return var_15_7
		end

		if var_15_2 ~= var_15_6 then
			return var_15_2
		end

		return arg_15_0 < arg_15_1
	end)
	arg_14_0.getAllController_:SetSelectedState("false")

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.taskData_) do
		local var_14_0, var_14_1, var_14_2, var_14_3 = CoreVerificationData:GetTaskProcess(iter_14_1)

		if var_14_2 and not var_14_3 then
			arg_14_0.getAllController_:SetSelectedState("true")

			break
		end
	end

	arg_14_0.taskUILuaList_:StartScroll(#arg_14_0.taskData_)
end

function var_0_0.ChangeButtonText(arg_16_0)
	arg_16_0.title1Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	arg_16_0.title11Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	arg_16_0.title2Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")
	arg_16_0.title22Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")
	arg_16_0.title3Text_.text = GetTips("CORE_VERIFICATION_LEVEL")
	arg_16_0.title33Text_.text = GetTips("CORE_VERIFICATION_LEVEL")
	arg_16_0.title4Text_.text = GetTips("CORE_VERIFICATION_FIRST_PASS")
	arg_16_0.title44Text_.text = GetTips("CORE_VERIFICATION_FIRST_PASS")
end

function var_0_0.OnTop(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnCoreVerificationGetReward(arg_18_0)
	arg_18_0:UpdateView()
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.taskUILuaList_ then
		arg_19_0.taskUILuaList_:Dispose()

		arg_19_0.taskUILuaList_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
