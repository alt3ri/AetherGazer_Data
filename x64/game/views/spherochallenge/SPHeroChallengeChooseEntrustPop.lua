slot0 = class("SPHeroChallengeChooseEntrustPop", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeEntrustPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.canChooseEntrustScroll = LuaList.New(handler(slot0, slot0.indexCanEntrust), slot0.uilistGo_, SPHeroChallengeEntrustItem)
	slot0.refreshTimeController = slot0.descController:GetController("refreshState")
end

function slot0.OnEnter(slot0)
	slot0.activityInfo = SPHeroChallengeData:GetCurActivityInfo()
	slot0.activityID = SPHeroChallengeData:GetActivityID()

	slot0:RefreshOpenPage()
	slot0:RegisterEvents()
end

function slot0.OnTop(slot0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnExit(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMaskbtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.refreshBtn_, nil, function ()
		slot0 = uv0.activityInfo:GetRefreshFreeEntrustTime()

		if GameSetting.activity_hero_challenge_task_refresh_num.value[1] <= uv0.activityInfo.entrustTime then
			return
		end

		if slot0 <= 0 then
			slot2 = SPHeroChallengeData.activityCfg[uv0.activityID].refreshEntrustCost[1]

			if CurrencyData:GetCurrencyNum(slot2[1]) < slot2[2] then
				ShowTips(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_LACK"))

				return
			end
		end

		SPHeroChallengeAction:RefreshEntrustList()
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_REFRESH_ENTRUST, function ()
		uv0:RefreshOpenPage()
	end)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_START_ENTRUST, function ()
		uv0:RefreshOpenPage()
	end)
end

function slot0.Dispose(slot0)
	if slot0.canChooseEntrustScroll then
		slot0.canChooseEntrustScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshCanChooseEntrustList(slot0)
	slot0.canChooseList = {}

	if slot0.activityInfo then
		slot0.canChooseList = slot0.activityInfo.waitEntrustList or {}
	end

	slot0.canChooseEntrustScroll:StartScroll(#slot0.canChooseList)
end

function slot0.indexCanEntrust(slot0, slot1, slot2)
	slot2:RefreshUI({
		index = slot1,
		id = slot0.canChooseList[slot1]
	})
end

function slot0.RefreshOpenPage(slot0)
	slot0:RefreshCanChooseEntrustList()

	slot2 = slot0.activityInfo:GetRefreshTotalEntrustTime()

	if slot0.activityInfo:GetRefreshFreeEntrustTime() > 0 then
		slot0.refreshTimeController:SetSelectedState("free")

		slot0.freetextText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FREE_REFRESH"), slot1, GameSetting.activity_hero_challenge_task_free_refresh_num.value[1])
	elseif slot2 > 0 then
		slot0.refreshTimeController:SetSelectedState("charge")

		slot3 = SPHeroChallengeData.activityCfg[slot0.activityID].refreshEntrustCost[1]
		slot0.curiconImg_.sprite = ItemTools.getItemSprite(slot3[1])
		slot0.freetextText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_NEED"), slot3[2])
	else
		slot0.refreshTimeController:SetSelectedState("none")

		slot0.freetextText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_REFRESH_NONE")
	end
end

return slot0
