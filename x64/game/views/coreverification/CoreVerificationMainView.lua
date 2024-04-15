slot0 = class("CoreVerificationMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Core_Verification/CoreVerificationMain"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mainBossItem_ = CoreVerificationBossItem.New(slot0.boss1Go_, 1)
	slot0.subBossItem_ = CoreVerificationBossItem.New(slot0.boss2Go_, 2)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.previewBtn_, nil, function ()
		JumpTools.OpenPageByJump("/coreVerificationPre", {})
	end)
end

function slot0.OnEnter(slot0)
	saveData("CoreVerification", "click_time", _G.gameTimer:GetNextDayFreshTime())
	CoreVerificationAction.UpdateChallengeRedPoints()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("CORE_VERIFICATION_DES")
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)
	slot0:RefreshTitle()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)
	manager.windowBar:HideBar()
end

function slot0.RefreshTitle(slot0)
	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(CoreVerificationData:GetRefreshTime())

	slot0.mainBossItem_:RefreshUI()
	slot0.subBossItem_:RefreshUI()
end

function slot0.Dispose(slot0)
	if slot0.subBossItem_ then
		slot0.subBossItem_:Dispose()

		slot0.subBossItem_ = nil
	end

	if slot0.mainBossItem_ then
		slot0.mainBossItem_:Dispose()

		slot0.mainBossItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
