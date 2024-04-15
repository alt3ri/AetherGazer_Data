slot0 = class("AdminCatExploreRewardAniView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploCalculusAnimationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.SetItemData), slot0.listGo_, AdminCatExploreRewardItem)
	slot0.rateController = ControllerUtil.GetController(slot0.gameObject_.transform, "rate")
	slot0.itemList = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getRewardBtn_, nil, function ()
		if uv0.isOver ~= true then
			return
		end

		uv0.isOver = nil
		slot0 = LeanTween.value(uv0.nullGo_, uv0.exploreDay, 0, uv0.exploreDay * 0.2)

		slot0:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.handle_.fillAmount = slot0 / 7
			uv0.numTxt_.text = math.ceil(uv0.rate[uv0.exploreDay] / 7 * slot0 * 100) .. "<size=24>%</size>"

			uv0.rateController:SetSelectedState(tostring(math.floor(slot0)))
		end))
		slot0:setOnComplete(System.Action(function ()
			LeanTween.cancel(uv0.nullGo_)
			uv1:setOnUpdate(nil):setOnComplete(nil)
			AdminCatExploreAction.GetWeekReward()
		end))
		manager.audio:PlayEffect("ui_system_explore", "explore_calculus_0" .. uv0.exploreDay .. "_down", "")
	end)
end

function slot0.SetItemData(slot0, slot1, slot2)
	slot2:SetItemData(slot0.reward[slot1], slot1)
	table.insert(slot0.itemList, slot2)
end

function slot0.OnGetWeeklyReward(slot0)
	slot0:Back()
end

function slot0.UpdateView(slot0)
	slot0.rate = AdminCatExploreData:GetDataByPara("rate")
	slot0.exploreDay = AdminCatExploreData:GetDataByPara("exploreDay")
	slot0.reward = {}

	for slot6, slot7 in ipairs(ExploreLevelCfg[AdminCatExploreData:GetDataByPara("level")].accumulate_rewards) do
		table.insert(slot0.reward, {
			slot7[1],
			slot7[2] * slot0.rate[slot0.exploreDay]
		})
	end

	for slot6 = 1, 7 do
		slot0["txt" .. slot6].text = "x" .. slot0.rate[slot6]
	end

	slot0.rewardList_:StartScroll(#slot0.reward)

	if slot0.exploreDay == 0 then
		slot0.handle_.fillAmount = 0

		slot0.rateController:SetSelectedState("0")

		slot0.numTxt_.text = "0<size=24>%</size>"

		for slot6, slot7 in ipairs(slot0.itemList) do
			slot7:UpdateText(0)
		end

		return
	end

	slot3 = LeanTween.value(slot0.nullGo_, 0, slot0.exploreDay, slot0.exploreDay * 0.1)

	slot3:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.handle_.fillAmount = slot0 / 7
		slot4 = uv0.exploreDay
		uv0.numTxt_.text = math.ceil(uv0.rate[uv0.exploreDay] / slot4 * slot0 * 100) .. "<size=24>%</size>"

		for slot4, slot5 in ipairs(uv0.itemList) do
			slot5:UpdateText(math.ceil(uv0.reward[slot4][2] / uv0.exploreDay * slot0))
		end

		uv0.rateController:SetSelectedState(tostring(math.floor(slot0)))
	end))
	slot3:setOnComplete(System.Action(function ()
		LeanTween.cancel(uv0.nullGo_)

		uv0.isOver = true

		uv1:setOnUpdate(nil):setOnComplete(nil)
	end))
	manager.audio:PlayEffect("ui_system_explore", "explore_calculus_0" .. slot0.exploreDay .. "_up", "")
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0.isOver = nil
	slot0.itemList = {}
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
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
