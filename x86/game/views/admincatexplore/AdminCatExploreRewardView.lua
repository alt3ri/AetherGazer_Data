slot0 = class("AdminCatExploreRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploCalculusPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.SetItemData), slot0.listGo_, AdminCatExploreRewardItem)
	slot0.rateController = ControllerUtil.GetController(slot0.gameObject_.transform, "rate")
	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.buttonBtn_, nil, function ()
		if uv0.stateController:GetSelectedState() == "go" then
			uv0:Back()
			JumpTools.GoToSystem("/adminCatExploreRewardAni", {})
		end
	end)
end

function slot0.SetItemData(slot0, slot1, slot2)
	slot2:SetItemData(slot0.reward[slot1], slot1)
end

function slot0.UpdateBar(slot0)
end

function slot0.UpdateView(slot0)
	slot0.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	slot0.handle_.fillAmount = slot0.exploreDay / 7
	slot0.dayTxt_.text = string.format(GetTips("EXPLORE_ACCUMULATE_TIME"), slot0.exploreDay)
	slot0.isGet = AdminCatExploreData:GetDataByPara("getWeeklyReward") == 1
	slot0.rate = AdminCatExploreData:GetDataByPara("rate")
	slot0.reward = {}
	slot0.rateTxt_.text = "x" .. slot0.rate[slot0.exploreDay]

	for slot6, slot7 in ipairs(ExploreLevelCfg[AdminCatExploreData:GetDataByPara("level")].accumulate_rewards) do
		table.insert(slot0.reward, {
			slot7[1],
			slot7[2] * slot0.rate[slot0.exploreDay]
		})
	end

	if AdminCatExploreData:CheckCanGetWeeklyReward() then
		slot0.stateController:SetSelectedState(slot0.isGet and "get" or "go")
	else
		slot0.stateController:SetSelectedState("normal")
	end

	for slot6 = 1, 7 do
		slot0["txt" .. slot6].text = "x" .. slot0.rate[slot6]
	end

	slot0.rewardList_:StartScroll(#slot0.reward)
	slot0.rateController:SetSelectedState(tostring(slot0.exploreDay))
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()

	slot1 = AdminCatExploreData:CheckCanGetWeeklyReward()
	slot0.updateTimer_ = Timer.New(function ()
		if AdminCatExploreData:CheckCanGetWeeklyReward() ~= uv0 then
			uv1:UpdateView()
			uv1.updateTimer_:Stop()
		end
	end, 1, -1, 1)

	slot0.updateTimer_:Start()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	if slot0.rewardList_ then
		slot0.rewardList_:Dispose()

		slot0.rewardList_ = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
