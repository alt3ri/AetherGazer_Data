local var_0_0 = class("ZumaGameView", ReduxView)
local var_0_1 = {
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

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaGameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddBtnListener(arg_3_0.backBtn_, nil, function()
		ZumaLuaBridge.PauseZumaGame()
		JumpTools.OpenPageByJump("ZumaTips", {
			textContent = GetTips("ACTIVITY_ZUMA_EXIT_GAME"),
			titleContent = GetTips("PROMPT"),
			sureCallback = function()
				DestroyLua()
				LuaExchangeHelper.GoToMain()
			end,
			cancelCallback = function()
				ZumaLuaBridge.ReStartZumaGame()
				JumpTools.Back()
			end
		})
	end)
end

function var_0_0.ZumaAdaptiveMask(arg_7_0)
	local var_7_0 = GameObject.Find("ZumaPlayEnter/Bg").transform:GetComponent("SpriteRenderer").sprite.bounds
	local var_7_1 = manager.ui.canvas
	local var_7_2 = var_7_1:GetComponent(typeof(Canvas)).worldCamera
	local var_7_3 = UnityEngine.Camera.main
	local var_7_4, var_7_5 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_7_1.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_7_0.max), var_7_2, nil)
	local var_7_6, var_7_7 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(var_7_1.transform, UnityEngine.Camera.main:WorldToScreenPoint(var_7_0.min), var_7_2, nil)

	arg_7_0.rightmaskTrs_.anchoredPosition = Vector2(var_7_5.x, 0)
	arg_7_0.leftmaskTrs_.anchoredPosition = Vector2(var_7_7.x, 0)
	arg_7_0.topmaskTrs_.anchoredPosition = Vector2(0, var_7_5.y)
	arg_7_0.bottommaskTrs_.anchoredPosition = Vector2(0, var_7_7.y)
	arg_7_0.stopEffectImgTrs_.sizeDelta = Vector2(var_7_5.x - var_7_7.x, var_7_5.y - var_7_7.y)
end

function var_0_0.OnTop(arg_8_0)
	return
end

function var_0_0.InitUI(arg_9_0)
	arg_9_0:BindCfgUI()

	arg_9_0.progressStateController = arg_9_0.Controllerexcollection_:GetController(var_0_1.progressState.name)
	arg_9_0.showProgressStateController = arg_9_0.Controllerexcollection_:GetController(var_0_1.showProgressState.name)

	arg_9_0.comboEffect2Ani_:Play("Fx_x1_cx", 0, 1)
	arg_9_0.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 1)
	arg_9_0.comboEffect4Ani_:Play("Fx_x4_cx", 0, 1)
	arg_9_0.comboEffect5Ani_:Play("Fx_x5_cx", 0, 1)
	arg_9_0.comboEffect6Ani_:Play("Fx_x5_cx", 0, 1)
	arg_9_0.comboEffect7Ani_:Play("Fx_x5_cx", 0, 1)
	arg_9_0.comboEffect8Ani_:Play("Fx_x5_cx", 0, 1)
end

function var_0_0.PlayStartEffect(arg_10_0)
	if arg_10_0.startTimer then
		arg_10_0.startTimer:Stop()

		arg_10_0.startTimer = nil
	end

	arg_10_0.startTimer = Timer.New(function()
		ZumaLuaBridge.StartZumaGame()
		arg_10_0.startGo_:SetActive(false)
	end, 2)

	arg_10_0.startTimer:Start()
end

function var_0_0.OnZumaScoreUpdate(arg_12_0)
	local var_12_0 = ZumaData:GetZumaScore()

	arg_12_0.scoreTxt_.text = var_12_0

	arg_12_0:UpdateStarProgrss(var_12_0)
end

function var_0_0.UpdateStarProgrss(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.scoreStageList) do
		if arg_13_1 < iter_13_1 then
			break
		end

		var_13_0 = var_13_0 + 1
	end

	if var_13_0 == 0 then
		arg_13_0.progressStateController:SetSelectedState(var_0_1.progressState.star0)
	elseif var_13_0 == 1 then
		arg_13_0.progressStateController:SetSelectedState(var_0_1.progressState.star1)
	elseif var_13_0 == 2 then
		arg_13_0.progressStateController:SetSelectedState(var_0_1.progressState.star2)
	elseif var_13_0 == 3 then
		arg_13_0.progressStateController:SetSelectedState(var_0_1.progressState.star3)
	end

	if arg_13_0.scoreStageList and #arg_13_0.scoreStageList > 0 then
		arg_13_0.sliderSlr_.value = arg_13_1 / arg_13_0.scoreStageList[#arg_13_0.scoreStageList]
	else
		arg_13_0.sliderSlr_.value = 0
	end
end

function var_0_0.OnZumaBallCountUpdate(arg_14_0)
	arg_14_0.ballNumTxt_.text = ZumaData:GetZumaBallCount()
end

function var_0_0.OnZumaComboUpdate(arg_15_0, arg_15_1)
	if arg_15_1 == 2 then
		arg_15_0.comboEffect2Ani_:Play("Fx_x1_cx", 0, 0)
	elseif arg_15_1 == 3 then
		arg_15_0.comboEffect3Ani_:Play("Fx_x2_cx 1", 0, 0)
	elseif arg_15_1 == 4 then
		arg_15_0.comboEffect4Ani_:Play("Fx_x4_cx", 0, 0)
	elseif arg_15_1 >= 5 then
		arg_15_0:PlayMaxComboEffect()
	end
end

function var_0_0.PlayMaxComboEffect(arg_16_0)
	local var_16_0 = arg_16_0.comboEffect5Ani_:GetCurrentAnimatorStateInfo(0)

	if var_16_0.normalizedTime <= 0 or var_16_0.normalizedTime >= 1 then
		arg_16_0.comboEffect5Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	local var_16_1 = arg_16_0.comboEffect6Ani_:GetCurrentAnimatorStateInfo(0)

	if var_16_1.normalizedTime <= 0 or var_16_1.normalizedTime >= 1 then
		arg_16_0.comboEffect6Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	local var_16_2 = arg_16_0.comboEffect7Ani_:GetCurrentAnimatorStateInfo(0)

	if var_16_2.normalizedTime <= 0 or var_16_2.normalizedTime >= 1 then
		arg_16_0.comboEffect7Ani_:Play("Fx_x5_cx", 0, 0)

		return
	end

	arg_16_0.comboEffect8Ani_:Play("Fx_x5_cx", 0, 0)
end

function var_0_0.OnZumaStopShow(arg_17_0, arg_17_1)
	SetActive(arg_17_0.stopEffectObj_, arg_17_1)
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.scoreTxt_.text = 0

	arg_18_0:PlayStartEffect()

	arg_18_0.sliderSlr_.value = 0
	arg_18_0.zumaGameID = ZumaData:GetZumaGameId()
	arg_18_0.zumaCfg = ActivityZumaLevelCfg[arg_18_0.zumaGameID]
	arg_18_0.scoreStageList = {}

	local var_18_0 = arg_18_0.zumaCfg.activity_point_reward

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		arg_18_0.scoreStageList[iter_18_0] = ActivityPointRewardCfg[iter_18_1].need
	end

	if arg_18_0.zumaCfg.difficult == 3 then
		arg_18_0.showProgressStateController:SetSelectedState(var_0_1.showProgressState.hide)
	else
		arg_18_0.showProgressStateController:SetSelectedState(var_0_1.showProgressState.show)
	end
end

function var_0_0.OnExit(arg_19_0)
	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.startTimer then
		arg_20_0.startTimer:Stop()

		arg_20_0.startTimer = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
