ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("SevenDayPage_3_0", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return ActivityCumulativeSignCfg[slot0.activityID_].ui_path
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.items = {}
	slot0.max_sign_day = SevenDaySkinData:MaxSignDay(slot0.activityID_)

	for slot4 = 1, slot0.max_sign_day do
		slot5 = SevenDaySkinItem_3_0.New(slot0["btn_" .. slot4])

		slot5:RegisterListener(function ()
			if uv0.max_sign_day <= uv0.data:SignDay() then
				return
			end

			if uv0.data:LeftSignTimes() > 0 then
				SevenDaySkinAction.ReqSign(uv0.activityID_)

				return
			end

			if uv0.data:IsReSign() then
				uv0:ShowCheckDialog()

				return
			end
		end)
		table.insert(slot0.items, slot5)
	end

	slot0.onSignHandler = handler(slot0, slot0.OnSignSuccess)
	slot0.onClearHandler = handler(slot0, slot0.OnClearSuccess)

	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.BtnSign, nil, handler(slot0, slot0.OnBtnSignClick))
	slot0:AddBtnListener(slot0.btn_desc, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("ACTIVITY_OPTIONAL_RANDOM_RULE")
		})
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.CURRENCY_RANDOM_TARGET_COIN
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_RANDOM_TARGET_COIN, true)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, slot0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, slot0.onSignHandler)
	manager.redPoint:bindUIandKey(slot0.BtnSign.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))

	slot0.data = SevenDaySkinData:GetActivityData(slot0.activityID_)
	slot0.crossDay = false

	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, slot0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, slot0.onClearHandler)
	manager.redPoint:unbindUIandKey(slot0.BtnSign.transform, string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW))
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4 = 1, #slot0.items do
		slot0.items[slot4]:Dispose()
	end
end

function slot0.RefreshView(slot0)
	slot0:RefreshSignInfo()
	slot0:RefreshItems()

	slot1 = slot0.data:LeftSignTimes()
end

function slot0.RefreshSignInfo(slot0)
	slot0.descText_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_BACKDROP")
end

function slot0.RefreshItems(slot0)
	slot0.receiveState = false
	slot1 = slot0.data:SignDay()
	slot3 = slot1 + slot0.data:LeftSignTimes()
	slot4 = slot0.data:SignRewardList()
	slot5 = slot1 + slot0.data:ReSignNum()

	for slot9 = 1, slot0.max_sign_day do
		if slot9 <= slot1 then
			slot0.receiveState = false
		elseif slot9 <= slot3 then
			slot0.receiveState = true
		else
			slot0.receiveState = false
		end
	end

	slot6 = nil

	for slot10 = 1, slot0.max_sign_day do
		if slot10 == slot1 + 1 and not slot0.receiveState then
			slot0.items[slot10]:RefreshView(slot4[slot10], slot10 <= slot1 and 2 or slot10 <= slot3 and 1 or 0, slot5 > 0)
		else
			slot0.items[slot10]:RefreshView(slot6, slot10 <= slot1 and 2 or slot10 <= slot3 and 1 or 0, false)
		end

		slot5 = slot5 - 1
	end
end

function slot0.OnBtnSignClick(slot0)
	JumpTools.OpenPageByJump("/norseSurpriseGiftMachinePage")
end

function slot0.OnSignSuccess(slot0, slot1)
	getReward(slot1.item_list)
	slot0:RefreshView()

	slot0.crossDay = false
end

function slot0.ShowCheckDialog(slot0)
	slot2 = ActivityCumulativeSignCfg[slot0.activityID_].cost_item_list[1]
	slot3 = slot2[1]
	slot5 = slot2[2]
	slot6 = ItemTools.getItemNum(slot3)

	JumpTools.OpenPageByJump("popCostItem", {
		costId = slot3,
		costCount = slot5,
		content = string.format(GetTips("ACTIVITY_OPTIONAL_RANDOM_SIGN_COST"), GetI18NText(ItemCfg[slot3].name), slot5),
		popCostCallBack = function ()
			slot1, slot2 = ActivityData:GetActivityTime(uv0.activityID_)

			if slot2 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif uv0.crossDay then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				uv0.crossDay = false
			elseif uv1 < uv2 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(uv0.activityID_)
			end
		end,
		CancelCallback = function ()
			manager.windowBar:HideBar()
			uv0:UpdateBar()
		end,
		MaskCallback = function ()
			manager.windowBar:HideBar()
			uv0:UpdateBar()
		end
	})
end

function slot0.OnBtnInfoClick(slot0)
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function slot0.OnClearSuccess(slot0)
	slot0.data = SevenDaySkinData:GetActivityData(slot0.activityID_)

	slot0:RefreshView()

	slot0.crossDay = true
end

return slot0
