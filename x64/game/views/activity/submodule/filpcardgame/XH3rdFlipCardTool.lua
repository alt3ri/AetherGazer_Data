return {
	LoadScene = function(arg_1_0, arg_1_1, arg_1_2)
		arg_1_0.activityId = arg_1_1
		arg_1_0.callback_ = arg_1_2
		arg_1_0.assetSetDone = false

		local var_1_0 = SceneManager.GetSceneByName("X221")

		if var_1_0 and var_1_0.isLoaded == true then
			return
		end

		arg_1_0.operation_ = Asset.LoadLevelAsync("Levels/X221", true)

		if arg_1_0.timer_ then
			arg_1_0.timer_:Stop()

			arg_1_0.timer_ = nil
		end

		manager.ui:SetMainCamera("flipcard")

		local var_1_1 = manager.ui.mainCameraCom_
		local var_1_2 = Screen.width / Screen.height

		var_1_1.fieldOfView = 1.77 / var_1_2 * CameraCfg.flipcard.fieldOfView

		if var_1_2 <= 1.34 then
			var_1_1.fieldOfView = var_1_1.fieldOfView - 3
		end

		arg_1_0.timer_ = FrameTimer.New(handler(arg_1_0, arg_1_0.Process), 1, -1)

		arg_1_0.timer_:Start()

		whereami = "battle"
	end,
	UnLoadScene = function(arg_2_0)
		local var_2_0 = SceneManager.GetSceneByName("X221")

		whereami = "home"

		if var_2_0 and var_2_0.isLoaded == true then
			SceneManager.UnloadSceneAsync("X221")
		end
	end,
	Process = function(arg_3_0)
		local var_3_0 = SceneManager.GetSceneByName("X221")

		if var_3_0 and var_3_0.isLoaded then
			arg_3_0:SetAssetPath(arg_3_0.activityId)

			arg_3_0.assetSetDone = true
		end

		if arg_3_0.assetSetDone then
			arg_3_0.timer_:Stop()

			arg_3_0.timer_ = nil
		end
	end,
	LevelIsDone = function(arg_4_0)
		return not arg_4_0.operation_ or arg_4_0.operation_:IsDone()
	end,
	SetAssetPath = function(arg_5_0, arg_5_1)
		local var_5_0 = FlipCardCfg[arg_5_1]
		local var_5_1 = var_5_0.icon_path
		local var_5_2 = var_5_0.normal_card
		local var_5_3 = var_5_0.special_card

		FlipCardGameController.Instance:SetCardFaceBack(var_5_0.atlas_name, var_5_0.normal_front_back_icon, var_5_0.atlas_name ~= "")
		FlipCardGameController.Instance:SetCardFaceBack(var_5_0.atlas_name, var_5_0.special_front_back_icon, var_5_0.atlas_name ~= "")

		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			FlipCardGameController.Instance:SetCardFaces(var_5_1, iter_5_1, false)
		end

		for iter_5_2, iter_5_3 in pairs(var_5_3) do
			FlipCardGameController.Instance:SetCardFaces(var_5_1, iter_5_3, true)
		end
	end,
	StartGame = function(arg_6_0)
		FlipCardGameController.Instance:StarCheckCardFace()
	end,
	GameOver = function(arg_7_0, arg_7_1)
		FlipCardGameController.Instance:GameOver(arg_7_1)
	end,
	GetGameState = function(arg_8_0)
		if not FlipCardGameController.Instance then
			return 0
		end

		return FlipCardGameController.Instance:GetGameState()
	end,
	StopObservingCard = function(arg_9_0)
		FlipCardGameController.Instance:StopObservingCards()
	end,
	GetObservingLeftTime = function(arg_10_0)
		return math.floor(FlipCardGameController.Instance.RemainingObservationTime + 0.5)
	end,
	GetFlippingLeftTime = function(arg_11_0)
		return math.floor(FlipCardGameController.Instance.CurrentTimeValue + 0.5)
	end,
	GetFlipCardCount = function(arg_12_0)
		return math.floor(FlipCardGameController.Instance.FlipCardCount)
	end,
	GiveUp = function(arg_13_0)
		FlipCardGameController.Instance:GiveUp()
	end,
	ChangeStatus = function(arg_14_0, arg_14_1)
		FlipCardGameController.Instance:ChangeStatus(arg_14_1)
	end,
	ResetGame = function(arg_15_0, arg_15_1)
		FlipCardGameController.Instance:ResetGame()
	end,
	GetIsSuccess = function(arg_16_0)
		return FlipCardGameController.Instance:GetIsSuccess()
	end,
	GetUseTime = function(arg_17_0)
		local var_17_0 = FlipCardGameController.Instance.CurrentTimeValue
		local var_17_1 = FlipCardGameController.Instance.TimerDuration

		return math.floor(var_17_1 - var_17_0)
	end,
	GetHomeUI = function(arg_18_0)
		local var_18_0 = XH3rdFlipCardData:GetActivityID()

		if var_18_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardHomeUI"
		elseif var_18_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardHomeUI"
		end
	end,
	GetGameUI = function(arg_19_0)
		local var_19_0 = XH3rdFlipCardData:GetActivityID()

		if var_19_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardGameUI"
		elseif var_19_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardGameUI"
		end
	end,
	GetRewardUI = function(arg_20_0)
		local var_20_0 = XH3rdFlipCardData:GetActivityID()

		if var_20_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardRewardUI"
		elseif var_20_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardRewardUI"
		end
	end,
	GetClueUI = function(arg_21_0)
		local var_21_0 = XH3rdFlipCardData:GetActivityID()

		if var_21_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardClueUI"
		elseif var_21_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardClueUI"
		end
	end,
	GetHelpTips = function(arg_22_0)
		local var_22_0 = XH3rdFlipCardData:GetActivityID()

		if var_22_0 == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN")
		elseif var_22_0 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_0")
		end
	end
}
