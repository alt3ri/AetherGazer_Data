slot0 = class("SnowballGameInfoSubView", BaseView)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0)

	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.bubbleDisplayCountdown = 0

	slot0:BindCfgUI()

	slot0.modeController = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.hitList = {}
	slot0.scoreBubble = {}

	slot0:BindCfgUI(slot0.scoreBubble_, slot0.scoreBubble)

	slot0.scoreBubble.obj = slot0.scoreBubble_
	slot0.scoreBubble.trs = slot0.scoreBubble_.transform
	slot0.scoreBubble.modeController = ControllerUtil.GetController(slot0.scoreBubble_.transform, "type")

	function slot0.scoreBubble.Show(slot0, slot1, slot2, slot3)
		slot0.obj:SetActive(false)

		uv0.bubbleDisplayCountdown = 2.5
		slot4 = string.format("%+d", slot2)
		slot0.score1_.text = slot4
		slot0.score2_.text = slot4
		slot0.score3_.text = slot4

		slot0.modeController:SetSelectedState(slot1)

		slot7, slot0.trs.localPosition = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.trs.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, slot3), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

		slot0.obj:SetActive(true)
	end

	function slot0.scoreBubble.Hide(slot0)
		slot0.obj:SetActive(false)
	end
end

function slot0.Update(slot0, slot1)
	if not slot0.started then
		return
	end

	slot0.totalTime = math.max(0, slot0.totalTime - slot1)
	slot0.time_.text = string.format("%2d", math.ceil(slot0.totalTime))
	slot0.countdown = math.max(0, slot0.countdown - slot1)

	if slot0.countdown < 5 and slot0.modeController:GetSelectedState() == "times" then
		slot0.modeController:SetSelectedState("refresh")
	end

	if slot0.modeController:GetSelectedState() == "times" then
		slot0.waveTimeBar_.fillAmount = 1 - slot0.countdown / slot0.curWaveDuration
	else
		slot0.countdownText_.text = GetTipsF(slot0.hasNextWave and "ACTIVITY_SNOWBALL_REFRESH_ENEMY" or "ACTIVITY_SNOWBALL_GAME_END", math.ceil(slot0.countdown))
	end

	slot2 = slot0.bubbleDisplayCountdown - slot1

	if slot0.bubbleDisplayCountdown >= 0 and slot2 < 0 then
		slot0.scoreBubble:Hide()
	end

	slot0.bubbleDisplayCountdown = slot2
end

function slot0.OnEnter(slot0, slot1)
	slot0.score = 0
	slot0.started = false
	slot0.level = slot1.level
	slot0.totalTime = SnowballGameCfg[slot0.level].time_limit
	slot0.hitGuest = 0

	slot0:RegistEventListener(SNOWBALL_GAME_HIT, handler(slot0, slot0.UpdateScore))
	slot0:RegistEventListener(SNOWBALL_GAME_TARGET_NEW_WAVE, handler(slot0, slot0.UpdateWave))
	slot0:RegistEventListener(SNOWBALL_GAME_PLAYER_HIT_GUEST, function ()
		uv0.hitGuest = uv0.hitGuest + 1
	end)

	slot0.score_.text = string.format("%d", slot0.score)
end

function slot0.OnExit(slot0)
	slot0.hitList = {}

	slot0:RemoveAllEventListener()
	slot0.scoreBubble:Hide()
end

function slot0.OnGameStart(slot0)
	slot0.started = true
	slot0.hitGuest = 0
	slot0.score = 0
	slot0.score_.text = string.format("%d", slot0.score)
end

function slot0.UpdateScore(slot0, slot1, slot2, slot3)
	slot0.score = slot0.score + (GameSetting.activity_snowball_score.value[SnowballGameUnitCfg[slot1.cfgID].unit_type] or 0) + GameSetting.activity_snowball_score_acc_bonus.value[slot2 and 2 or 1] + (GameSetting.activity_snowball_score_row_bonus.value[slot1.row] or 0)

	if slot0.hitList[slot1.cfgID] == nil then
		slot0.hitList[slot1.cfgID] = 1
	else
		slot0.hitList[slot1.cfgID] = slot0.hitList[slot1.cfgID] + 1
	end

	slot0.score_.text = string.format("%d", slot0.score)

	slot0.scoreBubble:Show(slot6, slot8, slot3)
end

function slot0.UpdateWave(slot0, slot1)
	slot0.wave_.text = GetTipsF("ACTIVITY_SNOWBALL_ENEMY_WAVE_NUMS", slot1 + 1, #SnowballGameCfg[slot0.level].refresh_enemy + 1)
	slot0.curWaveDuration = nullable(SnowballGameCfg, slot0.level, "refresh_enemy", slot1 + 1, 4) or slot0.totalTime
	slot0.countdown = slot0.curWaveDuration
	slot0.hasNextWave = slot2 ~= nil

	slot0.modeController:SetSelectedState("times")
end

function slot0.RecordFinishTime(slot0)
	slot0.restTimeAfterFinish = slot0.totalTime
end

function slot0.CalcRestTimeAfterFinish(slot0)
	return slot0.restTimeAfterFinish or 0
end

return slot0
