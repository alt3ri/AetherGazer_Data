local var_0_0 = class("CoreVerificationMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_Verification/CoreVerificationMain"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.mainBossItem_ = CoreVerificationBossItem.New(arg_4_0.boss1Go_, 1)
	arg_4_0.subBossItem_ = CoreVerificationBossItem.New(arg_4_0.boss2Go_, 2)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationPre", {})
	end)
end

function var_0_0.OnEnter(arg_9_0)
	saveData("CoreVerification", "click_time", _G.gameTimer:GetNextDayFreshTime())
	CoreVerificationAction.UpdateChallengeRedPoints()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.redPoint:bindUIandKey(arg_9_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)
	arg_9_0:RefreshTitle()
end

function var_0_0.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)
	manager.windowBar:HideBar()
end

function var_0_0.RefreshTitle(arg_11_0)
	arg_11_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(CoreVerificationData:GetRefreshTime())

	arg_11_0.mainBossItem_:RefreshUI()
	arg_11_0.subBossItem_:RefreshUI()
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.subBossItem_ then
		arg_12_0.subBossItem_:Dispose()

		arg_12_0.subBossItem_ = nil
	end

	if arg_12_0.mainBossItem_ then
		arg_12_0.mainBossItem_:Dispose()

		arg_12_0.mainBossItem_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
