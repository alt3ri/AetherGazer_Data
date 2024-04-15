slot0 = {}
ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot1 = class("SevenDayPage_2_10", ActivityMainBasePanel)

function slot1.GetUIName(slot0)
	return ActivityCumulativeSignCfg[slot0.activityID_].ui_path
end

function slot1.Init(slot0)
	slot0:BindCfgUI()

	slot0.items = {}
	slot0.max_sign_day = SevenDaySkinData:MaxSignDay(slot0.activityID_)

	for slot4 = 1, slot0.max_sign_day do
		table.insert(slot0.items, SevenDaySkinItem_2_10.New(slot0["btn_" .. slot4]))
	end

	slot0.onSignHandler = handler(slot0, slot0.OnSignSuccess)
	slot0.onClearHandler = handler(slot0, slot0.OnClearSuccess)

	slot0:AddListeners()
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.BtnSign, nil, handler(slot0, slot0.OnBtnSignClick))
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
	slot0.random = 0

	slot0:RefreshView()
	slot0:ResetNum()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_SUCCESS, slot0.onSignHandler)
	manager.notify:RemoveListener(SEVEN_DAY_SKIN_SIGN_CLEAR, slot0.onClearHandler)
	manager.redPoint:unbindUIandKey(slot0.BtnSign.transform, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot0.activityID_))
	manager.windowBar:HideBar()

	if slot0.text4Timer then
		slot0.text4Timer:Stop()

		slot0.text4Timer = nil
	end

	if slot0.text3Timer then
		slot0.text3Timer:Stop()

		slot0.text3Timer = nil
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
	SetActive(slot0.signEfc, slot0.data:LeftSignTimes() > 0)
end

function slot1.RefreshSignInfo(slot0)
	slot1 = slot0.max_sign_day <= slot0.data:SignDay()

	if slot0.TxtSign then
		slot0.TxtSign.text = GetTips("SIGN")
	end

	if slot0.BtnSign then
		slot0.BtnSign:SetActive(not slot1)
	end

	if slot1 then
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

	ShowTips("SIGN_TIMES_EXHAUSTED")
end

function slot1.OnSignSuccess(slot0, slot1)
	if uv0[slot0.data:SignRewardList()[slot1.sign_num][1]] then
		JumpTools.OpenPageByJump("sevenDaySkinPopView", {
			msg = slot5,
			reward = {
				slot3
			}
		})
	else
		getReward(formatRewardCfgList({
			slot3
		}))
	end

	slot0:RefreshView()
	slot0:ResetNum()
end

function slot1.ShowCheckDialog(slot0)
	slot1 = GameSetting.activity_supplementary_sign_new.value
	slot2 = slot1[1]
	slot4 = ItemTools.getItemNum(slot2)

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
			if uv0 < uv1 then
				ShowTips("ITEM_NOT_ENOUGH_RETURN_MATERIAL")
			else
				SevenDaySkinAction.ReqSign(uv2.activityID_)
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
end

function slot1.ResetNum(slot0)
	if slot0.data:SignDay() > 0 then
		slot0.anim2:Play("num03", -1, 0)
		TimeTools.StartAfterSeconds(0.5, function ()
			uv0.text2.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. uv1)
		end, {})
		slot0:RefreshTimer(slot1)
	end
end

function slot1.TracaBack(slot0)
	if math.random(0, 5) == slot0.random then
		slot0:TracaBack()
	else
		slot0.random = slot1

		return
	end
end

function slot1.RefreshTimer(slot0, slot1)
	if slot0.text3Timer then
		slot0.text3Timer:Stop()

		slot0.text3Timer = nil
	end

	if slot0.text4Timer then
		slot0.text4Timer:Stop()

		slot0.text4Timer = nil
	end

	slot0.text4Timer = Timer.New(function ()
		uv0.anim4:Play("num02", -1, 0)
		uv0.anim5:Play("num04", -1, 0)
		uv0.anim6:Play("num", -1, 0)
		uv0.anim7:Play("num03", -1, 0)
		TimeTools.StartAfterSeconds(0.5, function ()
			uv0.text4.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
			uv0.text5.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
			uv0.text6.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
			uv0.text7.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. math.random(0, 9))
		end, {})
	end, 7, -1)
	slot0.text3Timer = Timer.New(function ()
		if math.random(0, 5) == uv0.random then
			uv0:TracaBack()
		else
			uv0.random = slot0
		end

		uv0.anim3:Play("num", -1, 0)
		TimeTools.StartAfterSeconds(0.5, function ()
			uv0.text3.sprite = getSprite("Atlas/JapanRegionUI_2_10", "JapanRegionUI_2_10_" .. uv0.random)
		end, {})
	end, GameSetting.activity_supplementary_sign_change_time.value[slot1], -1)

	slot0.text4Timer:Start()
	slot0.text3Timer:Start()
end

return slot1
