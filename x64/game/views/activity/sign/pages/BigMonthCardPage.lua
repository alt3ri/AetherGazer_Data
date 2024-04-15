slot0 = class("BigMonthCardPage", BaseSignPage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/ActivitySign/BigMonthCard/BigMonthcard"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.num_ = {}
	slot0.icon_ = {}
	slot0.goal_ = {}
	slot0.reward_ = {}
	slot0.stateCon_ = {}
	slot0.itemAni = {}
	slot4 = "Animator"
	slot0.btnAni = slot0.btnGo_:GetComponent(slot4)
	slot0.animPlaying = false

	for slot4 = 1, 4 do
		slot0.num_[slot4] = slot0["num_" .. slot4]
		slot0.icon_[slot4] = slot0["icon_" .. slot4]
		slot0.goal_[slot4] = slot0["goal_" .. slot4]
		slot0.reward_[slot4] = slot0["reward_" .. slot4]
		slot0.stateCon_[slot4] = ControllerUtil.GetController(slot0["item_" .. slot4].transform, "state")
		slot0.itemAni[slot4] = slot0["giftpanelitemAni_" .. slot4]
	end

	slot0.slider_ = {}

	for slot4 = 1, 3 do
		slot0.slider_[slot4] = slot0["slider_" .. slot4]
	end

	slot0.btnCon_ = ControllerUtil.GetController(slot0.transform_, "btn")
	slot0.dayCon_ = ControllerUtil.GetController(slot0.transform_, "day")

	slot0:RefreshReward()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.buyBtn_, nil, function ()
		if GameSetting.big_monthly_card_cost.value[2] <= CurrencyData:GetRechargeDiamond() then
			ShowMessageBox({
				isTop = true,
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(GameSetting.big_monthly_card_cost.value[1]), slot0, GetTips("SIGN_TITLE_BIGMONTHCARD"), 1),
				OkCallback = function ()
					BigMonthCardAction.BuyBigMonthCard()
				end
			})
		elseif AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
			ShopTools.DiamondEnoughMessageBox()
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_DIAMOND")
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		manager.ui:UIEventEnabledByUI(false, true)
		BigMonthCardAction.SignToday()
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		uv0:ClickInfoFunc()
	end)

	function slot6()
		uv0:ClickInfoFunc()
	end

	slot0:AddBtnListener(slot0.imgBtn_, nil, slot6)

	for slot6 = 1, 4 do
		slot8 = BigMonthCardAccumulationCfg[BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()][slot6]]

		slot0:AddBtnListener(slot0.reward_[slot6], nil, function ()
			slot1 = uv0.reward[1]

			if uv0.accumulation <= BigMonthCardData:GetSignDays() then
				BigMonthCardAction.AccumulateSign(uv1)
			else
				ShowPopItem(POP_ITEM, {
					slot1
				})
			end
		end)
	end
end

function slot0.RefreshReward(slot0)
	for slot6, slot7 in ipairs(BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]) do
		slot9 = BigMonthCardAccumulationCfg[slot2[slot6]]
		slot0.icon_[slot6].sprite = ItemTools.getItemSprite(slot9.reward[1])
		slot0.num_[slot6].text = "x" .. slot9.reward[2]
		slot0.goal_[slot6].text = slot9.accumulation
	end
end

function slot0.ClickInfoFunc(slot0)
	JumpTools.OpenPageByJump("bigMonthPop")
end

function slot0.AutoGetReward(slot0)
	if BigMonthCardData:IsExpireTip() == 1 then
		BigMonthCardAction.FirstLoginSinceMonthCardFinish()
	else
		manager.ui:UIEventEnabledByUI(false, true)

		if BigMonthCardData:HaveMonthCard() and not BigMonthCardData:IsSignToday() then
			BigMonthCardAction.SignToday()
		else
			slot0:AutoGetAccumlateSign()
		end
	end
end

function slot0.AutoGetAccumlateSign(slot0)
	for slot8, slot9 in ipairs(BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]) do
		if BigMonthCardAccumulationCfg[slot9].accumulation <= BigMonthCardData:GetSignDays() and not table.indexof(BigMonthCardData:GetHaveSign(), slot9) then
			manager.ui:UIEventEnabledByUI(false, true)
			BigMonthCardAction.AccumulateSign(slot9)

			return
		end
	end

	manager.ui:UIEventEnabledByUI(true, false)
	slot0.hander_:CheckSign()
end

function slot0.OnShow(slot0)
	slot0:RefreshUI()
	slot0:RegistEventListener(GET_BIG_MONTH_SIGN, function ()
		uv0:RefreshUI()
	end)
	slot0:RegistEventListener(GET_BIG_MONTH_ACCUMULATE_SIGN, function ()
		uv0:RefreshUI()
	end)
	slot0:RegistEventListener(BUY_BIG_MONTH_CARD, function ()
		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_big_monthcard = 1
		})
		uv0:RefreshUI()
		manager.ui:UIEventEnabledByUI(false, true)
		BigMonthCardAction.SignToday()
	end)
	SDKTools.SendPaymentMessageToSDK("payment_big_monthcard_click", {
		big_monthcard_click = 1
	})
end

function slot0.RefreshUI(slot0)
	if BigMonthCardData:HaveMonthCard() then
		slot0:RefreshUnlock()
	else
		slot0:RefreshLock()
	end

	slot0:RefreshReward()
end

function slot0.RefreshUnlock(slot0)
	slot1 = false

	if BigMonthCardData:IsSignToday() then
		slot0.btnCon_:SetSelectedState("signed")
	else
		slot0.btnCon_:SetSelectedState("unlock")
	end

	slot3 = BigMonthCardData:GetSignDays()
	slot0.lastDays_.text = BigMonthCardData:GetMonthCardLastDay() .. GetTips("DAY")
	slot4 = 0

	for slot11, slot12 in ipairs(BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardData:GetTemplateId()]) do
		if BigMonthCardAccumulationCfg[slot7[slot11]].accumulation <= slot3 then
			slot0.stateCon_[slot11]:SetSelectedState(table.indexof(BigMonthCardData:GetHaveSign(), slot13) and "received" or "complete")

			if slot11 ~= 1 then
				slot0.slider_[slot11 - 1].value = 1
			end

			if slot3 == slot15 and slot16 then
				slot1 = true
			end
		else
			slot17 = slot7[slot11 - 1] and BigMonthCardAccumulationCfg[slot16].accumulation or 0
			slot4 = slot4 ~= 0 and (slot4 < slot15 - slot3 and slot4 or slot15 - slot3) or slot15 - slot3

			if slot11 ~= 1 then
				slot0.slider_[slot11 - 1].value = (slot3 - slot17 <= 0 and 0 or slot18) / (slot15 - slot17)
			end
		end
	end

	if slot4 ~= 0 then
		slot0.next_.text = string.format(GetTips("SIGN_TITLE_BIGMONTHCARD_TIP"), slot4)

		slot0.dayCon_:SetSelectedState("true")
	else
		slot0.dayCon_:SetSelectedState("false")
	end

	if slot1 then
		slot0.tip_.text = GetTips("BIG_CARD_TIPS_4")
	elseif slot2 then
		slot0.tip_.text = GetTips("BIG_CARD_TIPS_3")
	else
		slot0.tip_.text = GetTips("BIG_CARD_TIPS_2")
	end

	slot0:ResetTipTimer()
end

function slot0.RefreshLock(slot0)
	slot0.btnCon_:SetSelectedState("lock")

	slot4 = "false"

	slot0.dayCon_:SetSelectedState(slot4)

	for slot4 = 1, 4 do
		slot0.stateCon_[slot4]:SetSelectedState("uncomplete")
	end

	for slot4 = 1, 3 do
		slot0.slider_[slot4].value = 0
	end

	slot0:StopTipTimer()

	if BigMonthCardData:IsExpireTip() == 1 then
		slot0.tip_.text = GetTips("BIG_CARD_TIPS_5")
	else
		slot0.tip_.text = GetTips("BIG_CARD_TIPS_1")
	end
end

function slot0.ResetTipTimer(slot0)
	slot0:StopTipTimer()
	SetActive(slot0.tipGo_, true)

	slot0.tipTimer_ = Timer.New(function ()
		SetActive(uv0.tipGo_, false)
		uv0:StopTipTimer()
	end, 5, 1)

	slot0.tipTimer_:Start()
end

function slot0.StopTipTimer(slot0)
	if slot0.tipTimer_ then
		slot0.tipTimer_:Stop()

		slot0.tipTimer_ = nil
	end
end

function slot0.OnHide(slot0)
	slot0:StopTipTimer()
	slot0:RemoveAllEventListener()
end

return slot0
