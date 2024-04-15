return {
	Enter = function (slot0)
		manager.ui:SetMainCamera("lianliankan")
		manager.windowBar:SetWhereTag("lianliankan")

		slot1 = DormLinkGameData:GetCurLevelID()

		LianLianKanGameManager.GetInstance():Init(slot1)

		if slot1 then
			DormLinkGameData:InitCustomerInfo()
			gameContext:Go("/dormLinkGamePlayView")
		end

		uv0:UpSetCameraFOV()
	end,
	UpSetCameraFOV = function (slot0)
		slot2 = CameraCfg.lianliankan.fieldOfView
		manager.ui.mainCameraCom_.fieldOfView = math.max(1.7777777777777777 / (Screen.width / Screen.height) * slot2, slot2)
	end,
	Exit = function (slot0)
		LianLianKanGameManager.GetInstance():Reset()
		DormLinkGameData:DisposeGameInfo()
	end
}
