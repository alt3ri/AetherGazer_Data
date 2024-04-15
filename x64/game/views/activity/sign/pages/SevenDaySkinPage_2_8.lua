slot0 = {
	[106001] = {
		author = "HERO_LUWU_NAME",
		name = "hades",
		body = "LUWU_SKIN_WORD"
	}
}
ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot1 = class("SevenDaySkinPage_2_8", ActivityMainBasePanel)

function slot1.GetUIName(slot0)
	return ActivityCumulativeSignCfg[slot0.activityID_].ui_path
end

function slot1.Init(slot0)
	slot0:BindCfgUI()

	slot0.items = {}
	slot4 = slot0.activityID_
	slot0.max_sign_day = SevenDaySkinData:MaxSignDay(slot4)
	slot0.isResign = false

	for slot4 = 1, slot0.max_sign_day do
		table.insert(slot0.items, SevenDaySkinItem_2_8.New(slot0["btn_" .. slot4]))
	end

	slot0.onSignHandler = handler(slot0, slot0.OnSignSuccess)
	slot0.onClearHandler = handler(slot0, slot0.OnClearSuccess)

	slot0:AddListeners()
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.BtnSign, nil, handler(slot0, slot0.OnBtnSignClick))
	slot0:AddBtnListener(slot0.BtnInfo, nil, handler(slot0, slot0.OnBtnInfoClick))
end

function slot1.OnTop(slot0)
	slot0:UpdateBar()
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_CLEAR, slot0.onClearHandler)
	manager.notify:RegistListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, slot0.onSignHandler)
	manager.redPoint:bindUIandKey(slot0.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot0.activityID_))

	slot0.data = SevenDaySkinData:GetActivityData(slot0.activityID_)
	slot0.crossDay = false

	slot0:RefreshView()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, slot0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, slot0.onClearHandler)
	manager.redPoint:unbindUIandKey(slot0.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot0.activityID_))
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4 = 1, #slot0.items do
		slot0.items[slot4]:Dispose()
	end
end

function slot1.RefreshView(slot0)
	slot0:RefreshSignInfo()
	slot0:RefreshItems()

	slot0.descText_.text = GetTips("LUWU_SIGN_DESCRIPTION")
end

function slot1.RefreshSignInfo(slot0)
	slot2 = slot0.max_sign_day <= slot0.data:SignDay()

	if slot0.TxtSign then
		slot0.TxtSign.text = GetTips(slot0.data:IsReSign() and "RESIGN" or "SIGN")
	end

	if slot0.BtnSign then
		slot0.BtnSign:SetActive(not slot2)
	end

	if slot2 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot0.activityID_), 0)
	end
end

function slot1.RefreshItems(slot0)
	slot5 = nil

	for slot9 = 1, slot0.max_sign_day do
		slot0.items[slot9]:RefreshView(slot0.data:SignRewardList()[slot9], slot9 <= slot1 and 2 or slot9 <= slot0.data:SignDay() + slot0.data:LeftSignTimes() and 1 or 0)
	end
end

function slot1.OnBtnSignClick(slot0)
	if slot0.max_sign_day <= slot0.data:SignDay() then
		return
	end

	if slot0.data:LeftSignTimes() > 0 then
		SevenDaySkinAction.ReqSign(slot0.activityID_)

		return
	end

	if slot0.data:IsReSign() then
		slot0:ShowCheckDialog()

		return
	end

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function slot1.OnSignSuccess(slot0, slot1)
	if uv0[slot0.data:SignRewardList()[slot1.sign_num][1]] then
		JumpTools.OpenPageByJump("sevenDaySkinPopView_2_8", {
			msg = slot5,
			reward = {
				slot3
			}
		})
	else
		getReward({
			slot3
		})
	end

	slot0:RefreshView()

	slot0.crossDay = false
end

function slot1.ShowCheckDialog(slot0)
	slot1 = GameSetting.activity_supplementary_sign_new.value
	slot2 = slot1[1]
	slot4 = CurrencyData:GetCurrencyNum(slot2)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = {
			GetTips("WHETHER_TO_CONSUME"),
			{
				slot2,
				slot1[2]
			},
			GetTips("WHETHER_TO_SUPPLEMENTARY_SIGN")
		},
		OkCallback = function ()
			slot1, slot2 = ActivityData:GetActivityTime(uv0.activityID_)

			if slot2 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			elseif uv0.crossDay then
				ShowTips("SUPPLEMENTARY_SIGN_FAIL")

				uv0.crossDay = false
			elseif uv1 < uv2 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				CurrencyAction.CurrencyModify(CurrencyConst.CURRENCY_TYPE_DIAMOND, -uv2)
				SevenDaySkinAction.ReqSign(uv0.activityID_)
			end
		end
	})
end

function slot1.OnBtnInfoClick(slot0)
	JumpTools.OpenPageByJump("gameHelp", {
		content = GetTips("ACTIVITY_INSTRUSCTIONS")
	})
end

function slot1.OnClearSuccess(slot0)
	slot0.data = SevenDaySkinData:GetActivityData(slot0.activityID_)

	slot0:RefreshView()

	slot0.crossDay = true
end

return slot1
