slot0 = class("ItemExchangeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/PopUp/XH2ndRecharge"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.refreshVitalityHandler_ = handler(slot0, slot0.RefreshVitality)
	slot0.okController_ = ControllerUtil.GetController(slot0.okBtn_.transform, "enabled")
end

function slot0.OnEnter(slot0)
	slot0.exchangeID_ = slot0.params_.exchangeID
	slot0.maxCnt_ = slot0.params_.maxCnt

	slot0:CalcMaxCnt()
	slot0:InitExchangeCurrency()
	slot0:RefreshVitality()
	slot0:RefreshCountdown()
	manager.notify:RegistListener(CURRENCY_UPDATE, slot0.refreshVitalityHandler_)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.notify:RemoveListener(CURRENCY_UPDATE, slot0.refreshVitalityHandler_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshVitalityHandler_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.uiMaxCnt_ < tonumber(uv0.cntText_.text) then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(ItemExchangeCfg[uv0.exchangeID_].cost[1][1])))

			return
		end

		CurrencyAction.ExchangeItem(uv0.exchangeID_, slot1, function (slot0)
			ShowTips("EXCHANGE_SUCCESS")
			uv0:Back()
		end)
	end)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if tonumber(uv0.cntText_.text) + 1 <= uv0.uiMaxCnt_ then
			uv0.cntText_.text = slot0 + 1

			uv0:RefreshExchangeCurrenty()
		end
	end)
	slot0:AddBtnListener(slot0.subBtn_, nil, function ()
		if tonumber(uv0.cntText_.text) > 1 then
			uv0.cntText_.text = slot0 - 1

			uv0:RefreshExchangeCurrenty()
		end
	end)
	slot0:AddBtnListener(slot0.maxBtn_, nil, function ()
		uv0.cntText_.text = uv0.uiMaxCnt_ < 1 and 1 or uv0.uiMaxCnt_

		uv0:RefreshExchangeCurrenty()
	end)
end

function slot0.CalcMaxCnt(slot0)
	slot0.uiMaxCnt_ = slot0.maxCnt_

	for slot6, slot7 in ipairs(ItemExchangeCfg[slot0.exchangeID_].cost) do
		if math.floor(ItemTools.getItemNum(slot7[1]) / slot7[2]) < slot0.uiMaxCnt_ then
			slot0.uiMaxCnt_ = slot10
		end
	end
end

function slot0.InitExchangeCurrency(slot0)
	slot1 = ItemExchangeCfg[slot0.exchangeID_]
	slot2 = slot1.cost[1][1]
	slot0.leftIconImage_.sprite = ItemTools.getItemLittleSprite(slot2)
	slot0.leftNameText_.text = ItemTools.getItemName(slot2)
	slot0.leftCntText_.text = slot1.cost[1][2]
	slot0.rightIconImage_.sprite = ItemTools.getItemLittleSprite(slot1.item_id)
	slot0.rightNameText_.text = ItemTools.getItemName(slot1.item_id)
	slot0.rightCntText_.text = 1
	slot0.cntText_.text = 1

	SetActive(slot0.currentyPanel_, slot2 == CurrencyConst.CURRENCY_TYPE_VITALITY)
end

function slot0.RefreshExchangeCurrenty(slot0)
	slot1 = tonumber(slot0.cntText_.text)
	slot0.leftCntText_.text = slot1 * ItemExchangeCfg[slot0.exchangeID_].cost[1][2]
	slot0.rightCntText_.text = slot1
	slot0.subBtn_.interactable = slot1 > 1
	slot0.addBtn_.interactable = slot1 < slot0.uiMaxCnt_
	slot0.maxBtn_.interactable = slot1 < slot0.uiMaxCnt_
end

function slot0.RefreshVitality(slot0)
	slot2 = GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max
	slot3 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	slot0.vitalityCntText_.text = string.format("%s/%s", slot3, slot2)
	slot4 = slot3 < slot2

	SetActive(slot0.singleCdGo_, slot4)
	SetActive(slot0.allCdGo_, slot4)

	slot5 = ItemExchangeCfg[slot0.exchangeID_]

	slot0:CalcMaxCnt()
	slot0.okController_:SetSelectedState(tostring(slot0.uiMaxCnt_ > 0))
	slot0:RefreshExchangeCurrenty()
end

function slot0.during(slot0)
	slot1 = GameSetting.fatigue_recovery.value[1] * 60

	return CurrencyData:GetLastFatigueRecoverTime() == 0 and slot1 or slot1 - (manager.time:GetServerTime() - CurrencyData:GetLastFatigueRecoverTime()) % slot1
end

function slot0.RefreshCountdown(slot0)
	slot0:StopTimer()

	slot1 = slot0:during()
	slot6 = (GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].fatigue_max - ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) - 1) * GameSetting.fatigue_recovery.value[1] * 60 + slot1
	slot0.singleCdText_.text = string.format("%02d:%02d:%02d", math.floor(slot1 / 3600), math.floor(slot1 % 3600 / 60), slot1 % 60)
	slot0.allCdText_.text = string.format("%02d:%02d:%02d", math.floor(slot6 / 3600), math.floor(slot6 % 3600 / 60), slot6 % 60)
	slot0.timer_ = Timer.New(function ()
		uv0 = uv1:during()
		uv2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
		uv3 = (uv4 - uv2 - 1) * uv5 + uv0
		uv1.singleCdText_.text = string.format("%02d:%02d:%02d", math.floor(uv0 / 3600), math.floor(uv0 % 3600 / 60), uv0 % 60)
		uv1.allCdText_.text = string.format("%02d:%02d:%02d", math.floor(uv3 / 3600), math.floor(uv3 % 3600 / 60), uv3 % 60)

		if uv0 <= 0 then
			uv1:StopTimer()
		end
	end, 0.2, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
