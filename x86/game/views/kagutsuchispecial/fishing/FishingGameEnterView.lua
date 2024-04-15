slot0 = class("FishingGameEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0, ...)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.winBar = KagutsuchiSpecialWinBarItem.New(slot0, slot0.winBar_, {
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id,
		CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id
	})

	slot0:InitBtnListeners()

	slot0.tips_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_FATIGUE_TIPS", GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1])
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.winBar:Dispose()
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()
	slot0:RegisterEvents()
	slot0.winBar:SetGameHelpKey("ACTIVITY_KAGUTSUCHI_FISH_DESCRIBE")
	slot0.winBar:RegistBackCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		ActivityTools.JumpBackToActivityMainViewByActivityID(KagutsuchiFishingEventData.activityID)
	end)
	slot0:UpdateEventTime()
	slot0:UpdateFishingGameCount()

	if slot0.timer ~= nil then
		slot0.timer:Stop()
	end

	slot0.timer = Timer.New(function ()
		uv0:UpdateEventTime()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.UpdateFishingGameCount(slot0)
	slot0.gameCountText_.text = string.format("%d/%d", KagutsuchiFishingEventData:GetRestGameCount(), GameSetting.activity_kagutsuchi_fish_times_max.value[1])
end

function slot0.OnExit(slot0)
	if slot0.timer ~= nil then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0:RemoveAllEventListener()
end

function slot0.RegisterEvents(slot0)
end

function slot0.InitBtnListeners(slot0)
	slot0:AddBtnListener(slot0.gameStartBtn_, nil, uv0.StartGame)
	slot0:AddBtnListener(slot0.collectionBtn_, nil, uv0.GoToColloctionPage)
end

function slot1()
	slot0 = nil

	if KagutsuchiFishingEventData.fishRemain == nil or next(slot1) == nil then
		slot0 = HanafudaCardCfg.all
	else
		for slot5, slot6 in pairs(slot1) do
			table.insert({}, slot5)
		end
	end

	return slot0[math.random(#slot0)]
end

function slot2()
	manager.notify:Invoke(KAGUTSUCHI_FISHING_EVENT_GAME_START)
	JumpTools.OpenPageByJump("/kagutsuchiFishingGame", {
		fishID = uv0()
	})
end

function slot3()
	if KagutsuchiWorkData then
		return KagutsuchiWorkData:GetStamina()
	end

	return 0
end

function slot0.StartGame()
	slot0 = KagutsuchiFishingEventData.activityID

	if KagutsuchiFishingEventData.dailyGameCount < GameSetting.activity_kagutsuchi_fish_times_max.value[1] then
		if GameSetting.activity_kagutsuchi_battle_fatigue_max.value[1] < uv0() + GameSetting.activity_kagutsuchi_fatigue_fish_recover.value[1] then
			JumpTools.OpenPageByJump("kagutsuchiFishingStaminaWillOverflow", {
				OkCallback = uv1
			})
		elseif ActivityTools.GetActivityIsOpenWithTip(slot0, true) then
			uv1()
		end
	else
		ShowTips("ACTIVITY_KAGUTSUCHI_FISH_NO_GAME_COUNT")
	end
end

function slot0.UpdateEventTime(slot0)
	if ActivityData:GetActivityData(KagutsuchiFishingEventData.activityID).stopTime <= manager.time:GetServerTime() then
		slot0.timeText_.text = GetTips("TIME_OVER")

		return
	end

	slot0.timeText_.text = manager.time:GetLostTimeStr2(slot3)
end

function slot0.GoToColloctionPage()
	JumpTools.OpenPageByJump("/kagutsuchiFishingGameCollection")
end

return slot0
