slot0 = class("DailyFatiguePage", BaseSignPage)
slot1 = 3600

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0.gameObject_:InjectUI(slot0)
	slot0:Init()
	slot0:RegisterUIEvent()
end

function slot0.OnEnter(slot0)
	slot0:Refresh()
end

function slot0.OnExit(slot0)
	slot0:OnUnSelect()
end

function slot0.Init(slot0)
	slot0.cfg = GameSetting.daily_free_physical_strength.value

	if slot0.cfg then
		slot0.hour_a = slot0.cfg[1][1] or 11
		slot0.hour_b = slot0.cfg[2][1] or 18
		slot0.morningGet = slot0.cfg[1][3] or 30
		slot0.afternoonGet = slot0.cfg[2][3] or 30
	end

	slot0.status_morning = DailyFatigueData:GetStatus(slot0.hour_a)
	slot0.status_afternoon = DailyFatigueData:GetStatus(slot0.hour_b)
	slot0.TxtTimeMorning.text = string.format("%s : 00", slot0.hour_a)
	slot0.TxtTimeAfternoon.text = string.format("%s : 00", slot0.hour_b)
	slot0.TxtMorningGet.text = string.format(GetTips("FATIGUE_GET_COUNT_TIP"), slot0.morningGet)
	slot0.TxtAfternoonGet.text = string.format(GetTips("FATIGUE_GET_COUNT_TIP"), slot0.afternoonGet)

	slot0:SetActive(true)
end

function slot0.RegisterUIEvent(slot0)
	slot0.BtnMorning:AddListener(handlerArg1(slot0, slot0.OnBtnClick, slot0.hour_a))
	slot0.BtnAfternoon:AddListener(handlerArg1(slot0, slot0.OnBtnClick, slot0.hour_b))
end

function slot0.OnBtnClick(slot0, slot1)
	if DailyFatigueData:GetStatus(slot1) ~= ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE then
		return
	end

	if DailyFatigueData:IsFatigueFull() then
		ShowTips("FATIGUE_FULL_TIP")

		return
	end

	DailyFatigueAction.ReqGetFatigue(slot1)
end

function slot0.OnSelect(slot0)
	if not slot0.timer then
		slot0.timer = Timer.New(handler(slot0, slot0.Tick), 1, -1)

		slot0.timer:Start()
	end

	slot0.Scroll.verticalNormalizedPosition = 1

	slot0:Tick()
	slot0:StopEffect()
	slot0:Refresh()
end

function slot0.OnUnSelect(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.Refresh(slot0)
	slot0.CtrlMorning:SetSelectedIndex(slot0.status_morning - 1)
	slot0.CtrlAfternoon:SetSelectedIndex(slot0.status_afternoon - 1)

	slot0.TxtTalk.text = GetTips("DAILY_FATIGUE_TIPS")

	slot0.MorningRedDot:SetActive(slot0.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE)
	slot0.AfternoonRedDot:SetActive(slot0.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE)
end

function slot0.Tick(slot0)
	if not slot0.cfg then
		return
	end

	slot2 = manager.time
	slot6 = DailyFatigueData:GetStatus(slot0.hour_b)

	if DailyFatigueData:GetStatus(slot0.hour_a) == ActivityConst.DAILY_FATIGUE_STATUS.NOT_AVAILABLE then
		slot0.TxtMorning.text = manager.time:DescCDTime(slot2:GetLastZeroTime() + slot0.hour_a * uv0 - slot2:GetServerTime())
	end

	if slot6 == slot1.NOT_AVAILABLE then
		slot0.TxtAfternoon.text = manager.time:DescCDTime(slot4 + slot0.hour_b * uv0 - slot3)
	end

	slot0.status_morning = slot5
	slot0.status_afternoon = slot6

	if slot0.status_morning ~= slot5 or slot0.status_afternoon ~= slot6 then
		slot0:Refresh()
	end
end

function slot0.CheckEnable(slot0)
	return slot0.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE or slot0.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.AVAILABLE
end

function slot0.AutoGetReward(slot0)
end

function slot0.OnGetFatigueSuccess(slot0, slot1)
	slot0.status_morning = DailyFatigueData:GetStatus(slot0.hour_a)
	slot0.status_afternoon = DailyFatigueData:GetStatus(slot0.hour_b)

	slot0:Refresh()
	slot0:PlayEffect(slot1)
end

function slot0.PlayEffect(slot0, slot1)
	slot0:StopEffect()

	if slot1 == slot0.hour_a then
		slot0.MorningEffect:SetActive(true)
	end

	if slot1 == slot0.hour_b then
		slot0.AfternoonEffect:SetActive(true)
	end

	Timer.New(handler(slot0, slot0.StopEffect), 2, 1)
end

function slot0.StopEffect(slot0)
	slot0.MorningEffect:SetActive(false)
	slot0.AfternoonEffect:SetActive(false)
end

function slot0.ResetAni(slot0, slot1, slot2)
	if slot0.status_morning == ActivityConst.DAILY_FATIGUE_STATUS.CLAIMED then
		slot0.MorningAni:Play(slot1, slot2)
	end

	if slot0.status_afternoon == ActivityConst.DAILY_FATIGUE_STATUS.CLAIMED then
		slot0.AfternoonAni:Play(slot1, slot2)
	end
end

function slot0.Dispose(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.BtnMorning:RemoveAllListener()
	slot0.BtnAfternoon:RemoveAllListener()
	uv0.super.Dispose(slot0)
end

return slot0
