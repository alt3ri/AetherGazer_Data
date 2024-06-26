slot0 = class("WindowBarMgr", import("game.extend.ReduxView"))
slot1 = import("manager.windowBar.WindowCurrencyItem")
slot2 = import("manager.windowBar.WindowMaterialItem")
slot3 = import("manager.windowBar.WindowActivityMatrixCoinItem")
slot4 = import("manager.windowBar.WindowActivityCoinItem")
slot5 = import("manager.windowBar.WindowPopTipsItem")
BACK_BAR = "BACK_BAR"
HOME_BAR = "HOME_BAR"
NAVI_BAR = "NAVI_BAR"
INFO_BAR = "INFO_BAR"
EXTRA_BAR = "EXTRA_BAR"
INVITE_BAR = "INVITE_BAR"
ACTIVITY_MATRIX_COIN = "ACTIVITY_MATRIX_COIN"
ACTIVITY_COIN = "ACTIVITY_COIN"
slot6 = nil

function slot0.UIName(slot0)
	return "Widget/System/Com_dynamic/WindowBarUI"
end

function slot0.OnCtor(slot0)
	print("Initialize Window")
end

function slot0.Init(slot0)
	slot0.lastBarList_ = {}
	slot0.lastAddBarList_ = {}
	slot0.lastCanClickBarList_ = {}
	slot0.styleInfo_ = {}
	slot0.lastStyleInfo_ = {}

	slot0:InitUI()
	slot0:AddListeners()

	slot0.windowPopTipsItemView_ = uv0.New(slot0.goTips_)
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = GameObject.Instantiate(Asset.Load(slot0:UIName()), manager.ui.uiPop.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AdaptScreen()

	slot0.barGo_ = {
		[HOME_BAR] = slot0.homeBtn_.gameObject,
		[BACK_BAR] = slot0.backBtn_.gameObject,
		[INFO_BAR] = slot0.infoBtn_.gameObject
	}
	slot0.isShow_ = false
	slot0.cooperationInviteTip_ = CooperationInviteTipItem.New(slot0.m_cooperationInviteTip)
end

function slot0.SetWhereTag(slot0, slot1)
	uv0 = slot1
end

function slot0.ClearWhereTag(slot0)
	uv0 = nil
end

function slot0.GetWhereTag(slot0)
	return uv0
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.homeBtn_, nil, function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")

		if uv0.homeFunc_ then
			uv0.homeFunc_()
		elseif uv1 == "chess" then
			gameContext:Go("/warHome")
		elseif uv1 == "canteen" then
			gameContext:Go("/restaurantMain")
		elseif uv1 == "dorm" then
			gameContext:Go("/dorm")
		elseif uv1 == "newchess" then
			NewChessTools.ExitNewChessScene(true)
		elseif uv1 == "guildActivity" then
			slot1 = nil

			gameContext:Go("/guildActivityWarField", {
				level = (GuildActivityData:GetCurrentGrid() == nil or slot0 <= 0 or table.indexof(ActivityClubMapCfg.all, ActivityClubCfg[slot0].map_id)) and 1,
				activityID = ActivityConst.GUILD_ACTIVITY_START
			})
		elseif uv1 == "guildActivitySP" then
			slot1 = nil
			slot2 = GuildActivitySPData:GetCurRunActivityID()

			gameContext:Go("/guildActivitySPWarField", {
				level = (GuildActivitySPData:GetCurrentGrid() == nil or slot0 <= 0 or table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], ActivityClubSPCfg[slot0].map_id)) and 1,
				activityID = slot2,
				totalActivityID = slot2
			})
		elseif uv1 == "minigame" then
			DormMinigame.Exit()
		elseif whereami == "battleResult" then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/home")
		elseif uv1 == "danceGame" then
			gameContext:Go("/idolTraineeCamp")
		else
			gameContext:Go("/home", nil, , true)
		end
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "backBtn")
		uv0:CallBackFunc()
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		OperationRecorder.Record(gameContext:GetLastOpenPage(), "infoBtn")

		if uv0.infoFunc_ then
			uv0.infoFunc_()
		elseif type(uv0.gameHelpKey) == "table" then
			if uv0.gameHelpKey.type == "jump" then
				JumpTools.OpenPageByJump(uv0.gameHelpKey.view, uv0.gameHelpKey.params)
			end
		else
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(uv0.gameHelpKey),
				key = uv0.gameHelpKey
			})
		end
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:StopTimer()
		SetActive(uv0.countdownGo_, false)
		SetActive(uv0.bgBtn_.gameObject, false)
	end)
end

function slot0.SetGameHelpKey(slot0, slot1)
	slot0.gameHelpKey = slot1
end

function slot0.RegistExtraTextAndCallBack(slot0, slot1, slot2)
	slot0.clickExtraFunc_ = slot2
end

function slot0.GetBackBtnIsShow(slot0)
	if slot0.barGo_ == nil or slot0.barGo_[BACK_BAR] == nil then
		return false
	end

	return slot0.barGo_[BACK_BAR].activeInHierarchy
end

function slot0.CallBackFunc(slot0)
	if slot0.backFunc_ then
		slot0.backFunc_()
	else
		JumpTools.Back()
	end
end

slot7 = {
	BACK_BAR,
	HOME_BAR
}

function slot0.GetBackBtnIsShow(slot0)
	if slot0.barGo_ == nil or slot0.barGo_[BACK_BAR] == nil then
		return false
	end

	return slot0.barGo_[BACK_BAR].activeInHierarchy
end

function slot0.CallBackFunc(slot0)
	if slot0.backFunc_ then
		slot0.backFunc_()
	else
		JumpTools.Back()
	end
end

function slot0.SwitchBar(slot0, slot1, slot2, slot3)
	if isNil(slot0.gameObject_) then
		slot0:Init()
	end

	if slot2 then
		slot0:HideBar()
	end

	SetActive(slot0.gameObject_, true)

	slot0.isShow_ = true
	slot1 = slot1 or uv0
	slot0.lastStyleInfo_ = slot0.styleInfo_ or slot0.lastStyleInfo_ or {}
	slot0.styleInfo_ = slot3 or {}

	if CooperationData:CheckInRoom() then
		slot4 = {}

		for slot8, slot9 in ipairs(slot1) do
			if slot9 == BACK_BAR or slot9 == INFO_BAR then
				table.insert(slot4, slot9)
			end
		end

		slot1 = slot4
	end

	for slot7, slot8 in ipairs(slot1) do
		if slot8 == HOME_BAR then
			if manager.guide:IsPlaying() and whereami == "battleResult" then
				slot0:SetActive(slot0.barGo_[slot8], false)
			else
				slot0:SetActive(slot0.barGo_[slot8], true)
			end
		elseif slot8 == BACK_BAR or slot8 == INFO_BAR then
			uv1:SetActive(slot0.barGo_[slot8], true)
		elseif slot8 ~= EXTRA_BAR then
			if slot8 == NAVI_BAR then
				-- Nothing
			elseif slot8 == ACTIVITY_MATRIX_COIN then
				slot9 = slot0:getOrAddBarGo_(slot8, slot0.styleInfo_)

				uv1:SetActive(slot9, true)
				slot9:SetCanAdd(false)
			elseif slot8 == ACTIVITY_COIN then
				slot9 = slot0:getOrAddBarGo_(slot8, slot0.styleInfo_)

				uv1:SetActive(slot9, true)
				slot9:SetCanAdd(false)
				slot9:SetType("black")
			elseif slot8 == INVITE_BAR then
				if slot0.cooperationInviteTip_ then
					slot0.cooperationInviteTip_:Show()
				end
			elseif ItemCfg[slot8] and ItemCfg[slot8].type == ItemConst.ITEM_TYPE.MATERIAL then
				slot9 = slot0:getOrAddBarGo_(slot8, slot0.styleInfo_)

				uv1:SetActive(slot9, true)
				slot9:SetCanAdd(false)
			else
				slot9 = slot0:getOrAddBarGo_(slot8, slot0.styleInfo_)

				uv1:SetActive(slot9, true)
				slot9:SetCanAdd(false)
			end
		end
	end

	for slot9, slot10 in ipairs(slot0:getMappedBarList_(slot0.lastBarList_, slot0.lastStyleInfo_)) do
		if not table.keyof(slot0:getMappedBarList_(slot1, slot0.styleInfo_), slot10) and slot0.barGo_[slot10] then
			uv1:SetActive(slot0.barGo_[slot10], false)
		end
	end

	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 0 then
		uv1:SetActive(slot0.barGo_[CurrencyConst.GetPlatformDiamondId()], false)
	end

	slot0.lastBarList_ = slot1
	slot0.lastAddBarList_ = {}
	slot0.lastCanClickBarList_ = {}
end

function slot0.RegistHomeCallBack(slot0, slot1)
	slot0.homeFunc_ = slot1
	slot0.lastHomeFunc_ = slot1
end

function slot0.RegistBackCallBack(slot0, slot1)
	slot0.backFunc_ = slot1
	slot0.lastBackFunc_ = slot1
end

function slot0.RegistInfoCallBack(slot0, slot1)
	slot0.infoFunc_ = slot1
	slot0.lastInfoFunc_ = slot1
end

function slot0.SetBarCanAdd(slot0, slot1, slot2)
	if slot0.barGo_[slot0:getMappedKey_(slot1, slot0.styleInfo_)] then
		slot3:SetCanAdd(slot2)

		if slot2 then
			table.insert(slot0.lastAddBarList_, slot1)
		end
	end
end

function slot0.SetActivityId(slot0, slot1, slot2)
	if slot0.barGo_[slot0:getMappedKey_(slot1, slot0.styleInfo_)] and slot3.SetActivityId then
		slot3:SetActivityId(slot2)
	end
end

function slot0.SetBarCanClick(slot0, slot1, slot2)
	if slot0.barGo_[slot0:getMappedKey_(slot1, slot0.styleInfo_)] then
		slot3:SetCanClick(slot2)

		if slot2 then
			table.insert(slot0.lastCanClickBarList_, slot1)
		end
	end
end

function slot0.SetAsLastSibling(slot0)
	slot0.transform_:SetAsLastSibling()
end

function slot0.SetAsFirstSibling(slot0)
	slot0.transform_:SetAsFirstSibling()
end

function slot0.HideBar(slot0)
	slot0.homeFunc_ = nil
	slot0.backFunc_ = nil
	slot0.infoFunc_ = nil

	SetActive(slot0.gameObject_, false)

	if slot0.windowPopTipsItemView_ then
		slot0.windowPopTipsItemView_:Hide()
	end

	if slot0.cooperationInviteTip_ then
		slot0.cooperationInviteTip_:Hide()
	end

	slot0.isShow_ = false

	slot0:UnBindListener()

	slot0.lastStyleInfo_ = slot0.styleInfo_
	slot0.styleInfo_ = nil
end

function slot0.GetIsShow(slot0)
	return slot0.isShow_
end

function slot0.GetLastHomeFunc(slot0)
	return slot0.lastHomeFunc_
end

function slot0.GetLastBackFunc(slot0)
	return slot0.lastBackFunc_
end

function slot0.GetLastInfoFunc(slot0)
	return slot0.lastInfoFunc_
end

function slot0.GetLastBarList(slot0)
	return slot0.lastBarList_
end

function slot0.GetLastAddBarList(slot0)
	return slot0.lastAddBarList_
end

function slot0.GetLastCanClickBarList(slot0)
	return slot0.lastCanClickBarList_
end

function slot0.UnBindListener(slot0)
	for slot4, slot5 in pairs(slot0.barGo_ or {}) do
		if slot4 ~= BACK_BAR and slot4 ~= HOME_BAR and slot4 ~= NAVI_BAR and slot4 ~= INFO_BAR then
			if slot4 ~= EXTRA_BAR then
				slot5:UnBindListener()
			end
		end
	end
end

function slot0.IsInited(slot0)
	return not isNil(slot0.gameObject_)
end

function slot0.OnClickCurrencyBar(slot0)
	if slot0.countdownGo_.activeInHierarchy then
		return
	end

	slot0:StopTimer()

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max then
		slot4 = GameSetting.fatigue_recovery.value[1] * 60
		slot5 = CurrencyData:GetLastFatigueRecoverTime() == 0 and slot4 or slot4 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % slot4
		slot6 = (slot3 - slot1 - 1) * slot4 + slot5
		slot0.time_.text = string.format("%02d:%02d:%02d", math.floor(slot5 / 3600), math.floor(slot5 % 3600 / 60), slot5 % 60)
		slot0.allTime_.text = string.format("%02d:%02d:%02d", math.floor(slot6 / 3600), math.floor(slot6 % 3600 / 60), slot6 % 60)
		slot0.timer_ = Timer.New(function ()
			uv0 = CurrencyData:GetLastFatigueRecoverTime() == 0 and uv1 or uv1 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % uv1
			uv2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
			uv3 = (uv4 - uv2 - 1) * uv1 + uv0

			if uv0 <= 0 then
				uv0 = 0
			end

			if uv3 <= 0 then
				uv3 = 0
			end

			uv5.time_.text = string.format("%02d:%02d:%02d", math.floor(uv0 / 3600), math.floor(uv0 % 3600 / 60), uv0 % 60)
			uv5.allTime_.text = string.format("%02d:%02d:%02d", math.floor(uv3 / 3600), math.floor(uv3 % 3600 / 60), uv3 % 60)
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.time_.text = "00:00:00"
		slot0.allTime_.text = "00:00:00"
	end

	SetActive(slot0.countdownGo_, true)
	SetActive(slot0.bgBtn_.gameObject, true)
end

function slot0.OnStopTimer(slot0)
	slot0.time_.text = "00:00:00"
	slot0.allTime_.text = "00:00:00"

	slot0:StopTimer()
	SetActive(slot0.countdownGo_, false)
	SetActive(slot0.bgBtn_.gameObject, false)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()

	for slot4, slot5 in pairs(slot0.barGo_ or {}) do
		if slot4 ~= BACK_BAR and slot4 ~= HOME_BAR and slot4 ~= NAVI_BAR and slot4 ~= INFO_BAR then
			if slot4 ~= EXTRA_BAR then
				slot5:Dispose()
				Object.Destroy(slot5.gameObject_)
			end
		end
	end

	slot0.barGo_ = nil

	if slot0.windowPopTipsItemView_ then
		slot0.windowPopTipsItemView_:Dispose()

		slot0.windowPopTipsItemView_ = nil
	end

	if slot0.cooperationInviteTip_ then
		slot0.cooperationInviteTip_:Dispose()

		slot0.cooperationInviteTip_ = nil
	end

	if not isNil(slot0.gameObject_) then
		uv0.super.Dispose(slot0)
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
	end

	slot0.currencyItem_ = nil
	slot0.backBtn_ = nil
	slot0.homeBtn_ = nil
	slot0.infoBtn_ = nil
	slot0.currencyList_ = nil
	slot0.isShow_ = false
end

function slot0.SetActive(slot0, slot1, slot2)
	if type(slot1) == "table" then
		slot1:SetActive(slot2)
	elseif slot1 then
		SetActive(slot1, slot2)
	end
end

function slot0.getMappedKey_(slot0, slot1, slot2)
	if slot2 and slot2.prefix then
		return slot2.prefix .. slot1
	else
		return slot1
	end
end

function slot0.getOrAddBarGo_(slot0, slot1, slot2)
	if not slot0.barGo_[slot0:getMappedKey_(slot1, slot2)] then
		slot0.barGo_[slot3] = slot0:getBarClass_(slot1, slot2).New(Object.Instantiate(slot0:getBarTemplate_(slot2), slot0.currencyList_.transform), slot1)

		if slot1 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			slot0.countdownGo_.transform:SetParent(slot7.transform)

			slot0.countdownGo_.transform:GetComponent("RectTransform").anchoredPosition = Vector2(0, -50)

			slot4:RegistClickFunc(handler(slot0, slot0.OnClickCurrencyBar))
			slot4:RegistTimeFunc(handler(slot0, slot0.OnStopTimer))
		end
	end

	return slot4
end

function slot0.getBarTemplate_(slot0, slot1)
	if slot1 and slot1.prefix and slot1.prefix == "HOME:" then
		return slot0.currencyItemMainHome_ or slot0.currencyItem_
	end

	return slot0.currencyItem_
end

function slot0.getBarClass_(slot0, slot1, slot2)
	if slot1 == ACTIVITY_MATRIX_COIN then
		return uv0
	elseif slot1 == ACTIVITY_COIN then
		return uv1
	elseif ItemCfg[slot1] and ItemCfg[slot1].type == ItemConst.ITEM_TYPE.MATERIAL then
		return uv2
	else
		return uv3
	end
end

function slot0.getMappedBarList_(slot0, slot1, slot2)
	if slot2 == nil or slot2.prefix == nil then
		return slot1
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		table.insert(slot3, slot0:getMappedKey_(slot8, slot2))
	end

	return slot3
end

return slot0
