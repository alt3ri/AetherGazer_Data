slot0 = class("ZumaGameView", ReduxView)
slot1 = {
	progressState = {
		name = "progress",
		star2 = "state2",
		star1 = "state1",
		star0 = "state0",
		star3 = "state3"
	},
	showProgressState = {
		name = "showProgress",
		hide = "hide",
		show = "show"
	}
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaGameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		ZumaLuaBridge.PauseZumaGame()
		JumpTools.OpenPageByJump("ZumaTips", {
			textContent = GetTips("ACTIVITY_ZUMA_EXIT_GAME"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function ()
				DestroyLua()
				LuaExchangeHelper.GoToMain()
			end,
			cancelCallback = function ()
				ZumaLuaBridge.ReStartZumaGame()
				JumpTools.Back()
			end
		})
	end)
end

function slot0.ZumaAdaptiveMask(slot0)
	slot3 = GameObject.Find("ZumaPlayEnter/Bg").transform:GetComponent("SpriteRenderer").sprite.bounds
	slot4 = manager.ui.canvas
	slot5 = slot4:GetComponent(typeof(Canvas)).worldCamera
	slot6 = UnityEngine.Camera.main
	slot7, slot8 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot4.transform, UnityEngine.Camera.main:WorldToScreenPoint(slot3.max), slot5, nil)
	slot9, slot10 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot4.transform, UnityEngine.Camera.main:WorldToScreenPoint(slot3.min), slot5, nil)
	slot0.rightmaskTrs_.anchoredPosition = Vector2(slot8.x, 0)
	slot0.leftmaskTrs_.anchoredPosition = Vector2(slot10.x, 0)
	slot0.topmaskTrs_.anchoredPosition = Vector2(0, slot8.y)
	slot0.bottommaskTrs_.anchoredPosition = Vector2(0, slot10.y)
	slot0.stopEffectImgTrs_.sizeDelta = Vector2(slot8.x - slot10.x, slot8.y - slot10.y)
end

function slot0.OnTop(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.progressStateController = slot0.Controllerexcollection_:GetController(uv0.progressState.name)
	slot0.showProgressStateController = slot0.Controllerexcollection_:GetController(uv0.showProgressState.name)

	slot0.comboEffect2Ani_:Play("Fx_x1_cx", 0, 1)
	slot0.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 1)
	slot0.comboEffect4Ani_:Play("Fx_x4_cx", 0, 1)
	slot0.comboEffect5Ani_:Play("Fx_x5_cx", 0, 1)
	slot0.comboEffect6Ani_:Play("Fx_x5_cx", 0, 1)
	slot0.comboEffect7Ani_:Play("Fx_x5_cx", 0, 1)
	slot0.comboEffect8Ani_:Play("Fx_x5_cx", 0, 1)
end

function slot0.PlayStartEffect(slot0)
	if slot0.startTimer then
		slot0.startTimer:Stop()

		slot0.startTimer = nil
	end

	slot0.startTimer = Timer.New(function ()
		ZumaLuaBridge.StartZumaGame()
		uv0.startGo_:SetActive(false)
	end, 2)

	slot0.startTimer:Start()
end

function slot0.OnZumaScoreUpdate(slot0)
	slot1 = ZumaData:GetZumaScore()
	slot0.scoreTxt_.text = slot1

	slot0:UpdateStarProgrss(slot1)
end

function slot0.UpdateStarProgrss(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in pairs(slot0.scoreStageList) do
		if slot1 < slot7 then
			break
		end

		slot2 = slot2 + 1
	end

	if slot2 == 0 then
		slot0.progressStateController:SetSelectedState(uv0.progressState.star0)
	elseif slot2 == 1 then
		slot0.progressStateController:SetSelectedState(uv0.progressState.star1)
	elseif slot2 == 2 then
		slot0.progressStateController:SetSelectedState(uv0.progressState.star2)
	elseif slot2 == 3 then
		slot0.progressStateController:SetSelectedState(uv0.progressState.star3)
	end

	if slot0.scoreStageList and #slot0.scoreStageList > 0 then
		slot0.sliderSlr_.value = slot1 / slot0.scoreStageList[#slot0.scoreStageList]
	else
		slot0.sliderSlr_.value = 0
	end
end

function slot0.OnZumaBallCountUpdate(slot0)
	slot0.ballNumTxt_.text = ZumaData:GetZumaBallCount()
end

function slot0.OnZumaComboUpdate(slot0, slot1)
	if slot1 == 2 then
		slot0.comboEffect2Ani_:Play("Fx_x1_cx", 0, 0)
	elseif slot1 == 3 then
		slot0.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 0)
	elseif slot1 == 4 then
		slot0.comboEffect4Ani_:Play("Fx_x4_cx", 0, 0)
	elseif slot1 >= 5 then
		slot0:PlayMaxComboEffect()
	end
end

function slot0.PlayMaxComboEffect(slot0)
	if slot0.comboEffect5Ani_:GetCurrentAnimatorStateInfo(0).normalizedTime <= 0 or slot1.normalizedTime >= 1 then
		slot0.comboEffect5Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	if slot0.comboEffect6Ani_:GetCurrentAnimatorStateInfo(0).normalizedTime <= 0 or slot2.normalizedTime >= 1 then
		slot0.comboEffect6Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	if slot0.comboEffect7Ani_:GetCurrentAnimatorStateInfo(0).normalizedTime <= 0 or slot3.normalizedTime >= 1 then
		slot0.comboEffect7Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	slot0.comboEffect8Ani_:Play("Fx_x5_cx", 0, 0)
end

function slot0.OnZumaStopShow(slot0, slot1)
	SetActive(slot0.stopEffectObj_, slot1)
end

function slot0.OnEnter(slot0)
	slot0.scoreTxt_.text = 0

	slot0:PlayStartEffect()

	slot0.sliderSlr_.value = 0
	slot0.zumaGameID = ZumaData:GetZumaGameId()
	slot0.zumaCfg = ActivityZumaLevelCfg[slot0.zumaGameID]
	slot0.scoreStageList = {}

	for slot5, slot6 in pairs(slot0.zumaCfg.activity_point_reward) do
		slot0.scoreStageList[slot5] = ActivityPointRewardCfg[slot6].need
	end

	if slot0.zumaCfg.difficult == 3 then
		slot0.showProgressStateController:SetSelectedState(uv0.showProgressState.hide)
	else
		slot0.showProgressStateController:SetSelectedState(uv0.showProgressState.show)
	end
end

function slot0.OnExit(slot0)
	manager.ui:ResetMainCamera()
end

function slot0.Dispose(slot0)
	if slot0.startTimer then
		slot0.startTimer:Stop()

		slot0.startTimer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
