return {
	LoadScene = function (slot0, slot1, slot2)
		slot0.activityId = slot1
		slot0.callback_ = slot2
		slot0.assetSetDone = false

		if SceneManager.GetSceneByName("X221") and slot3.isLoaded == true then
			return
		end

		slot0.operation_ = Asset.LoadLevelAsync("Levels/X221", true)

		if slot0.timer_ then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end

		manager.ui:SetMainCamera("flipcard")

		slot5 = Screen.width / Screen.height
		manager.ui.mainCameraCom_.fieldOfView = 1.77 / slot5 * CameraCfg.flipcard.fieldOfView

		if slot5 <= 1.34 then
			slot4.fieldOfView = slot4.fieldOfView - 3
		end

		slot0.timer_ = FrameTimer.New(handler(slot0, slot0.Process), 1, -1)

		slot0.timer_:Start()

		whereami = "battle"
	end,
	UnLoadScene = function (slot0)
		whereami = "home"

		if SceneManager.GetSceneByName("X221") and slot1.isLoaded == true then
			SceneManager.UnloadSceneAsync("X221")
		end
	end,
	Process = function (slot0)
		if SceneManager.GetSceneByName("X221") and slot1.isLoaded then
			slot0:SetAssetPath(slot0.activityId)

			slot0.assetSetDone = true
		end

		if slot0.assetSetDone then
			slot0.timer_:Stop()

			slot0.timer_ = nil
		end
	end,
	LevelIsDone = function (slot0)
		return not slot0.operation_ or slot0.operation_:IsDone()
	end,
	SetAssetPath = function (slot0, slot1)
		slot2 = FlipCardCfg[slot1]
		slot5 = slot2.special_card

		FlipCardGameController.Instance:SetCardFaceBack(slot2.atlas_name, slot2.normal_front_back_icon, slot2.atlas_name ~= "")
		FlipCardGameController.Instance:SetCardFaceBack(slot2.atlas_name, slot2.special_front_back_icon, slot2.atlas_name ~= "")

		for slot9, slot10 in pairs(slot2.normal_card) do
			FlipCardGameController.Instance:SetCardFaces(slot2.icon_path, slot10, false)
		end

		for slot9, slot10 in pairs(slot5) do
			FlipCardGameController.Instance:SetCardFaces(slot3, slot10, true)
		end
	end,
	StartGame = function (slot0)
		FlipCardGameController.Instance:StarCheckCardFace()
	end,
	GameOver = function (slot0, slot1)
		FlipCardGameController.Instance:GameOver(slot1)
	end,
	GetGameState = function (slot0)
		if not FlipCardGameController.Instance then
			return 0
		end

		return FlipCardGameController.Instance:GetGameState()
	end,
	StopObservingCard = function (slot0)
		FlipCardGameController.Instance:StopObservingCards()
	end,
	GetObservingLeftTime = function (slot0)
		return math.floor(FlipCardGameController.Instance.RemainingObservationTime + 0.5)
	end,
	GetFlippingLeftTime = function (slot0)
		return math.floor(FlipCardGameController.Instance.CurrentTimeValue + 0.5)
	end,
	GetFlipCardCount = function (slot0)
		return math.floor(FlipCardGameController.Instance.FlipCardCount)
	end,
	GiveUp = function (slot0)
		FlipCardGameController.Instance:GiveUp()
	end,
	ChangeStatus = function (slot0, slot1)
		FlipCardGameController.Instance:ChangeStatus(slot1)
	end,
	ResetGame = function (slot0, slot1)
		FlipCardGameController.Instance:ResetGame()
	end,
	GetIsSuccess = function (slot0)
		return FlipCardGameController.Instance:GetIsSuccess()
	end,
	GetUseTime = function (slot0)
		return math.floor(FlipCardGameController.Instance.TimerDuration - FlipCardGameController.Instance.CurrentTimeValue)
	end,
	GetHomeUI = function (slot0)
		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardHomeUI"
		elseif slot1 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardHomeUI"
		end
	end,
	GetGameUI = function (slot0)
		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardGameUI"
		elseif slot1 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardGameUI"
		end
	end,
	GetRewardUI = function (slot0)
		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardRewardUI"
		elseif slot1 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardRewardUI"
		end
	end,
	GetClueUI = function (slot0)
		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdFlipCardUI/XH3rdFlipCardClueUI"
		elseif slot1 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0FlipCardUI/NorseFlipCardClueUI"
		end
	end,
	GetHelpTips = function (slot0)
		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_2_2_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN")
		elseif slot1 == ActivityConst.ACTIVITY_3_0_FLIPCARD then
			return GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_0")
		end
	end
}
