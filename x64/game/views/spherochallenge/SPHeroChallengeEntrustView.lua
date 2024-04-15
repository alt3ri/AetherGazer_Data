slot0 = class("SPHeroChallengeEntrustView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeEntrustView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.activityID = SPHeroChallengeData:GetActivityID()
	slot0.curEntrustItemList = {}
	slot2 = SPHeroChallengeTools
	slot4 = slot2

	for slot4 = 1, slot2.GetMaxStartEntrustPosNum(slot4, slot0.activityID) do
		slot5 = SPHeroChallengeEntrustStartItem.New(slot0["entrustitem" .. slot4 .. "Go_"], slot4)

		slot5:ClickEmptyFunc(handler(slot0, slot0.OpenChooseList))

		slot0.curEntrustItemList[slot4] = slot5
	end

	slot0.waitEntrustItemScroll = LuaList.New(handler(slot0, slot0.indexWaitEntrust), slot0.waitListGo_, SPHeroChallengeEntrustWaitItem)
end

function slot0.OnEnter(slot0)
	slot0.activityInfo = SPHeroChallengeData:GetCurActivityInfo()

	slot0:RefreshStartEntrust()
	slot0:RefreshWaitEntrustList()
	slot0:StartTimer()
	slot0:RefreshBar()
	slot0:RegisterEvents()
end

function slot0.OnTop(slot0)
	slot0:BindRedPonit()
	slot0:StartTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()
end

function slot0.BindRedPonit(slot0)
end

function slot0.UnBindRedPonit(slot0)
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_TICKET
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopTimer()
	slot0:UnBindRedPonit()
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if SPHeroChallengeData:GetCurActivityInfo() then
			if #slot0:GetCanGetRewardEntrustIndexList() > 0 then
				SPHeroChallengeAction:GetEntrustAward(slot1)
			else
				ShowTips("ACTIVITY_HERO_CHALLENGE_NONE_ENTRUST_FINISH")
			end
		end
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_START_ENTRUST, function ()
		uv0:RefreshStartEntrust()
		uv0:RefreshWaitEntrustList()
	end)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_FIN_ENTRUST, function ()
		uv0:RefreshStartEntrust()
		uv0:RefreshWaitEntrustList()
	end)
end

function slot0.Dispose(slot0)
	if slot0.curEntrustItemList then
		for slot4, slot5 in pairs(slot0.curEntrustItemList) do
			slot5:Dispose()
		end
	end

	if slot0.waitEntrustItemList then
		slot0.waitEntrustItemList:Dispose()
	end

	if slot0.waitEntrustItemScroll then
		slot0.waitEntrustItemScroll:Dispose()
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshStartEntrust(slot0)
	if slot0.curEntrustItemList then
		for slot4, slot5 in ipairs(slot0.curEntrustItemList) do
			if slot0.activityInfo:GetShowIndexEntrustInfo(slot4) then
				if slot0.activityInfo:GetEntrustEndTime(slot6.index) then
					-- Nothing
				else
					slot7.state = "start"
				end
			elseif SPHeroChallengeTools:GetEntrustPosState(slot0.activityID, slot4) == SpHeroChallengeConst.EntrustPosState.empty then
				slot7.state = "empty"
			else
				slot7.state = "lock"
			end

			slot5:RefreshUI({
				showIndex = slot4,
				state = "end"
			})
		end
	end
end

function slot0.RefreshWaitEntrustList(slot0)
	slot0.startWaitList = {}
	slot2 = SPHeroChallengeTools:GetMaxStartEntrustPosNum(slot0.activityID)

	for slot6 = 1, SPHeroChallengeTools:GetMaxWaitEntrustPosNum(slot0.activityID) do
		slot7 = {}
		slot7 = (not slot0.activityInfo:GetShowIndexEntrustInfo(slot6 + slot2) or {
			showIndex = slot6 + slot2,
			entrustIndex = slot8.index
		}) and (SPHeroChallengeTools:GetEntrustPosState(slot0.activityID, slot6 + slot2) ~= SpHeroChallengeConst.EntrustPosState.lock or {
			state = "lock"
		}) and {
			state = "empty"
		}
		slot7.showiIndex = slot6 + slot2
		slot0.startWaitList[slot6] = slot7
	end

	slot0.waitEntrustItemScroll:StartScroll(#slot0.startWaitList)
end

function slot0.indexCanEntrust(slot0, slot1, slot2)
	slot2:RefreshUI({
		index = slot1,
		id = slot0.canChooseList[slot1]
	})
end

function slot0.indexWaitEntrust(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.startWaitList[slot1])
	slot2:ClickEmptyFunc(handler(slot0, slot0.OpenChooseList))
end

function slot0.OpenChooseList(slot0)
	JumpTools.OpenPageByJump("spHeroChallengeChooseEntrustPop")
end

function slot0.StartTimer(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.timer = Timer.New(function ()
		if uv0.curEntrustItemList then
			for slot3, slot4 in pairs(uv0.curEntrustItemList) do
				slot4:RefreshTime()
			end
		end
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

return slot0
