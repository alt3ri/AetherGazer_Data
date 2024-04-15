local var_0_0 = class("FishingExchangeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Fishing/FishingExchangeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.PrefabList_ = {
		"UI/Fishing/Pages/FishingGivePageUI",
		"UI/Fishing/Pages/FishingReceivePageUI",
		"UI/Fishing/Pages/FishingRequirePageUI"
	}
	arg_4_0.Classes_ = {
		FishingGivePageView,
		FishingReceivePageView,
		FishingRequirePageView
	}
	arg_4_0.pages_ = {}

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.toggles_ = {
		arg_5_0.toggle1_,
		arg_5_0.toggle2_,
		arg_5_0.toggle3_
	}
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.toggles_) do
		arg_6_0:AddToggleListener(iter_6_1, function(arg_7_0)
			if arg_7_0 then
				arg_6_0:SwitchToPage(iter_6_0)
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.closeBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.SwitchToPage(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0.curPageIndex_ then
		return
	end

	if arg_10_0.pages_[arg_10_0.curPageIndex_] then
		SetActive(arg_10_0.pages_[arg_10_0.curPageIndex_].gameObject_, false)
	end

	arg_10_0.curPageIndex_ = arg_10_1

	if not arg_10_0.pages_[arg_10_1] then
		local var_10_0 = Object.Instantiate(Asset.Load(arg_10_0.PrefabList_[arg_10_1]), arg_10_0.container_)

		arg_10_0.pages_[arg_10_1] = arg_10_0.Classes_[arg_10_1].New(var_10_0)

		arg_10_0:CheckPageEnter(arg_10_1)
	else
		SetActive(arg_10_0.pages_[arg_10_1].gameObject_, true)
	end

	arg_10_0.toggles_[arg_10_1].isOn = true
end

function var_0_0.AddEventListeners(arg_11_0)
	return
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_13_0)
	return
end

function var_0_0.OnEnter(arg_14_0)
	arg_14_0.enteredPage_ = {}

	FriendsAction:TryToRefreshFriendsView(1, function()
		arg_14_0:AddEventListeners()

		for iter_15_0, iter_15_1 in pairs(arg_14_0.pages_) do
			arg_14_0:CheckPageEnter(iter_15_0)
		end

		arg_14_0:SwitchToPage(arg_14_0.params_.page or 1)
	end)
	manager.redPoint:bindUIandKey(arg_14_0.redPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD, {
		x = 0,
		y = 0
	})
end

function var_0_0.CheckPageEnter(arg_16_0, arg_16_1)
	if not arg_16_0.enteredPage_[arg_16_1] then
		arg_16_0.pages_[arg_16_1]:OnEnter()

		arg_16_0.enteredPage_[arg_16_1] = true
	end
end

function var_0_0.OnExit(arg_17_0)
	manager.redPoint:unbindUIandKey(arg_17_0.redPointContainer_, RedPointConst.FISHING_RECEIVE_REWARD)
	arg_17_0:RemoveAllEventListener()

	for iter_17_0, iter_17_1 in pairs(arg_17_0.pages_) do
		iter_17_1:OnExit()
	end
end

function var_0_0.OnMainHomeViewTop(arg_18_0)
	return
end

function var_0_0.Dispose(arg_19_0)
	if arg_19_0.pages_ then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.pages_) do
			iter_19_1:Dispose()
		end

		arg_19_0.pages_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

return var_0_0
