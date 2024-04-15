slot1 = nil

return {
	SetUpZuma = function ()
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("X108"))
		manager.uiInit()
		gameContext:SetSystemLayer("battle")
		manager.ui:SetMainCamera("zuma")
		JumpTools.OpenPageByJump("ZumaGameView")
		ZumaToLuaBridge.CameraAdaptive()
	end,
	CameraAdaptive = function ()
		slot1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
		slot2 = UnityEngine.Camera.main
		slot3 = manager.ui:GetCanvasSize()
		slot6 = _G.SCREEN_WIDTH / _G.SCREEN_HEIGHT
		slot7 = 1.8888888888888888

		manager.ui:SetMainCameraFieldOfView(CameraCfg.zuma.fieldOfView)

		slot10 = GameObject.Find("ZumaPlayEnter/Bg")
		slot12 = slot10.transform:GetComponent("SpriteRenderer").sprite.bounds
		slot16 = math.abs(slot2.transform:InverseTransformPoint(slot10.transform.position).z)
		slot18 = 2 * slot16 * Mathf.Tan(slot2.fieldOfView * 0.5 * Mathf.Deg2Rad)
		slot20 = slot12.max - slot12.min
		slot25 = slot16
		slot2.transform.position = Vector3(0, 0, -(slot20.x - slot18 * slot2.aspect < slot20.y - slot18 and 0.5 * slot22 / slot17 or 0.5 * slot21 / slot17 / slot2.aspect))

		manager.notify:CallUpdateFunc(ZUMA_CAMERA_UPDATE)
	end,
	OnZumaSceneLoaded = function ()
		uv0 = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

		if uv0 == 0 then
			SettingAction.ChangePicSetting("frame", 1)
		end
	end,
	OnZumaSceneExit = function ()
		if uv0 == 0 then
			SettingAction.ChangePicSetting("frame", 0)
		end

		gameContext:SetSystemLayer("home")
	end,
	OnZumaOver = function (slot0)
		JumpTools.OpenPageByJump("ZumaGameSettle", {
			isWin = slot0
		})
	end,
	ZumaballHit = function (slot0)
		ZumaData:SetZumaScore(slot0)
		manager.notify:CallUpdateFunc(ZUMA_BALL_HIT)
	end,
	ZumaBallCountsUpdate = function (slot0)
		ZumaData:SetZumaBallCount(slot0)
		manager.notify:CallUpdateFunc(ZUMA_BALL_COUNT_UPDATE)
	end,
	ZumaCombo = function (slot0)
		manager.notify:CallUpdateFunc(ZUMA_COMBO_UPDATE, slot0)
	end,
	ZumaStop = function (slot0)
		manager.notify:CallUpdateFunc(ZUMA_STOP_SHOW, slot0)
	end,
	GetZumaGamePlayTime = function ()
		return math.floor(ZumaLuaBridge.GetCurTime())
	end
}
