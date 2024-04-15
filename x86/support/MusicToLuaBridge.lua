slot1 = nil

return {
	SetUpMusic = function ()
		SceneManager.SetActiveScene(SceneManager.GetSceneByName("X106"))
		manager.uiInit()
		JumpTools.OpenPageByJump(MusicData:GetMusicViewPathList(ActivityMusicCfg[MusicData:GetGameId()].activity_id).musicName)
		gameContext:SetSystemLayer("battle")
		manager.audio:DestoryCriAtom()
		manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", MusicData:GetVolumeData())

		if MusicLuaBridge.GetTrackNum() < 4 then
			for slot8 = 4, slot4 + 1, -1 do
				if GameObject.Find("Music/gameRoot/Track" .. slot8) then
					SetActive(slot9, false)
				end
			end
		end

		if MusicData:GetVerical() then
			manager.ui:SetMainCamera("musicVertical")
			MusicToLuaBridge.verticalAdapt(slot4)
		else
			manager.ui:SetMainCamera("music")
			MusicToLuaBridge.slantAdapt(slot4)
		end

		if GameObject.Find("movie") then
			slot6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Music/Music_bg/" .. ActivityMusicCfg[slot1].icon)
		end
	end,
	verticalAdapt = function (slot0)
		slot1 = manager.ui.mainCameraCom_
		slot3, slot4 = nil
		slot6 = 1
		slot7 = slot0 > 4 and slot0 - 1 or 0
		slot8 = (GameObject.Find("gameRoot/center") and 1.5 * math.abs(manager.ui.mainCamera.transform:InverseTransformPoint(slot5.transform.position).z) * Mathf.Tan(slot1.fieldOfView * 0.5 * Mathf.Deg2Rad) * slot1.aspect or 40) / (slot0 + 1) * 1.2
		slot10 = slot8 / 2
		slot11 = 0
		slot12 = -22.9
		slot13 = Vector3.New(slot8, 99, 0.2)
		cell_value_list = {}

		for slot17 = 0, slot0 - 1 do
			cell_value_list[slot17 + 1] = -((slot0 - 1) / 2) + slot17
		end

		slot14 = Vector3.New(0.1, 0, 0)
		slot15 = Vector3(0, -1, 0)

		for slot19 = 1, slot0 do
			slot20 = GameObject.Find("Music/gameRoot/Track" .. slot19)
			slot21 = slot20.transform
			slot21.localPosition = Vector3(slot9 * cell_value_list[slot19], slot12, 0)
			slot20:GetComponent("BoxCollider").size = slot13

			if slot21:Find("bg/leftLine") then
				slot23.localPosition = Vector3.New(-1 * slot10 + slot11, 0, 0)
			end

			if slot21:Find("bg/line") then
				slot24.localPosition = Vector3.New(slot10 + slot11 + 0.1, 0, 0)
			end

			if slot21:Find("bg/clickEffect/eff_glow/glow") then
				slot25:GetComponent("SpriteRenderer").size = Vector2.New(slot9, 5.12)
			end

			slot26 = slot21:Find("effectContent")
			slot26.localEulerAngles = Vector3.zero
			slot26.localPosition = slot15
			slot21:Find("nodeContent").localPosition = slot14
		end

		if GameObject.Find("Music/background/frame") then
			slot16:GetComponent("SpriteRenderer").size = Vector2.New(slot9 * slot0, 3.3)
		end

		if GameObject.Find("Music/background/mask") then
			slot17:GetComponent("SpriteRenderer").size = Vector2.New(slot9 * slot0 - 0.1, 999)
		end

		slot19 = 1 * Mathf.Tan(slot1.fieldOfView * 0.5 * Mathf.Deg2Rad) * slot1.aspect

		if GameObject.Find("movie") then
			if MusicData:GetShowMovie() then
				SetActive(slot20, true)

				slot21 = slot20.transform

				slot21:SetParent(manager.ui.mainCamera.transform)

				slot21.localPosition = Vector3(0, 0, 27)
				slot21.localEulerAngles = Vector3(0, 0, 0)
				slot21.localScale = Vector3.one
				slot21:GetComponent("SpriteRenderer").size = Vector2.New(slot3, slot3 * 0.5625)
			else
				SetActive(slot20, false)
			end
		end

		if GameObject.Find("object/long/bg") then
			slot21.transform.localScale = Vector3.New(slot9 / 3.9, 1, 1)
		end

		if GameObject.Find("object/short") then
			slot22.transform.localScale = Vector3.New(slot9 / 7.5, 1, 1)
		end

		slot24 = GameObject.Find("object/perfect_effect_chuizhi").transform

		for slot30 = 0, GameObject.Find("object/good_effect_chuizhi").transform.childCount - 1 do
			slot23:GetChild(slot30).localScale = Vector3.one * ({
				nil,
				nil,
				nil,
				1.8,
				1.7,
				1.6
			})[slot0]
		end

		for slot30 = 0, slot24.childCount - 1 do
			slot24:GetChild(slot30).localScale = slot26
		end

		for slot31 = 0, GameObject.Find("Pool").transform.childCount - 1 do
			if slot27:GetChild(slot31) then
				for slot36 = 0, slot32.childCount - 1 do
					slot32:GetChild(slot36).localScale = slot26
				end
			end
		end

		GameObject.Find("cubeLeft").transform.transform.localPosition = Vector3.New(-50, 0, 0)
		GameObject.Find("cubeRight").transform.transform.localPosition = Vector3.New(50, 0, 0)
	end,
	slantAdapt = function (slot0)
		slot1 = manager.ui.mainCameraCom_
		slot3 = nil
		slot5 = (GameObject.Find("gameRoot/center") and 2 * math.abs(manager.ui.mainCamera.transform:InverseTransformPoint(slot4.transform.position).z) * Mathf.Tan(slot1.fieldOfView * 0.5 * Mathf.Deg2Rad) * slot1.aspect or 40) / (slot0 + 1)
		slot6 = slot5 / 2
		slot7 = -22.9
		slot8 = 0
		slot9 = Vector3.New(slot5, 99, 0.2)
		slot10 = Vector3.New(slot5 * 1.3, 99, 0.2)
		slot11 = {
			[slot15] = 30 + (slot15 - slot0 * 0.5 + (slot15 - slot0 * 0.5 > 0 and 1 or -1)) * 5
		}

		for slot15 = 1, slot0 do
		end

		slot12 = {
			[slot16 + 1] = -((slot0 - 1) / 2) + slot16
		}

		for slot16 = 0, slot0 - 1 do
		end

		for slot16 = 1, slot0 do
			slot17 = GameObject.Find("Music/gameRoot/Track" .. slot16)
			slot17.transform.localPosition = Vector3.New(slot5 * slot12[slot16], slot7, 0)
			slot18 = slot17:GetComponent("BoxCollider")

			if slot16 == 1 then
				slot18.center = Vector3.New(-slot5 * 0.15, 0, 0)
				slot18.size = slot10
			elseif slot16 == slot0 then
				slot18.center = Vector3.New(slot5 * 0.15, 0, 0)
				slot18.size = slot10
			else
				slot18.size = slot9
			end

			if slot17.transform:Find("bg/leftLine") then
				slot20.localPosition = Vector3.New(-1 * slot6 - slot8, 0, 0)
			end

			if slot19:Find("bg/line") then
				slot21.localPosition = Vector3.New(slot6 + slot8, 0, 0)
			end

			if slot19:Find("bg/clickEffect/eff_glow/glow") then
				slot22:GetComponent("SpriteRenderer").size = Vector2.New(slot5 + 0.1, 5.12)
			end

			if slot11[slot16] then
				slot19:Find("effectContent").localEulerAngles = Vector3(0, slot11[slot16], 0)
			end
		end

		if GameObject.Find("Music/background/frame") then
			slot13:GetComponent("SpriteRenderer").size = Vector2.New(slot5 * slot0, 3.3)
		end

		if GameObject.Find("Music/background/mask") then
			slot14:GetComponent("SpriteRenderer").size = Vector2.New(slot5 * slot0 - 0.1, 999)
		end

		if GameObject.Find("movie") then
			if MusicData:GetShowMovie() then
				SetActive(slot15, true)

				slot16 = slot15.transform

				slot16:SetParent(manager.ui.mainCamera.transform)

				slot16.localPosition = Vector3(0, 0, 27)
				slot16.localEulerAngles = Vector3(0, 0, 0)
				slot16.localScale = Vector3.one
				slot17 = slot16:GetComponent("SpriteRenderer")
				slot19 = slot3
				slot21 = slot3

				if slot3 * 0.5625 < slot3 / slot1.aspect then
					slot21 = slot18 / 0.5625
				end

				slot17.size = Vector2.New(slot21, slot20)
			else
				SetActive(slot15, false)
			end
		end

		if GameObject.Find("object/long/bg") then
			slot16.transform.localScale = Vector3.New(slot5 / 3.9, 1, 1)
		end

		if GameObject.Find("object/short") then
			slot17.transform.localScale = Vector3.New(slot5 / 7.5, 1, 1)
		end
	end,
	OnMusicSceneLoaded = function ()
		uv0 = GameLocalData:GetCommonModule("userSetting").frame or PictureQualitySettingCfg[5].frame

		if uv0 == 0 then
			SettingAction.ChangePicSetting("frame", 1)
		end

		MusicLuaBridge.StartMusicGame()
		manager.notify:CallUpdateFunc(MUSIC_SCENE_LOADED)
	end,
	OnMusicSceneExit = function ()
		if uv0 == 0 then
			SettingAction.ChangePicSetting("frame", 0)
		end

		gameContext:SetSystemLayer("home")

		if SettingData:GetSoundSettingData() and slot0.music then
			manager.audio:SetVolume("music", slot0.music / 100)
		end
	end,
	MusicInitPlay = function ()
		MusicData:ResetGameData()
		manager.notify:CallUpdateFunc(MUSIC_INIT_PLAY)

		if SettingData:GetSoundSettingData() and slot0.music then
			manager.audio:SetVolume("music", slot0.music / 100)
		end
	end,
	MusicNodeHit = function (slot0, slot1)
		MusicData:ModifGameData(slot0)
		manager.notify:CallUpdateFunc(MUSIC_NODE_HIT, slot0, slot1)
	end,
	MusicSetNodeHit = function (slot0, slot1)
		MusicData:ModifGameData(slot0)
		manager.notify:CallUpdateFunc(MUSIC_SET_NODE_HIT, slot0, slot1)
	end,
	OnMusicOver = function ()
		slot0 = MusicData:GetGameScore()

		if MusicData:GetGameId() == 0 then
			MusicAction.GoToMusicMain()

			return
		end

		MusicAction.QueryCompelet(slot1, slot0)
	end,
	OnMusicActiveExit = function ()
		MusicAction.GoToMusicMain()
	end,
	OnMusicPause = function ()
		JumpTools.OpenPageByJump(MusicData:GetMusicViewPathList(ActivityMusicCfg[MusicData:GetGameId()].activity_id).musicStop)
	end
}
