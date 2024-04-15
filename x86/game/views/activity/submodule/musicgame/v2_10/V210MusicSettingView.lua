slot0 = class("V210MusicSettingView", ReduxView)
slot1 = 5
slot2 = 1
slot3 = 50
slot4 = -50
slot5 = 50
slot6 = -50
slot7 = 100
slot8 = 0

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicSetUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.musicSetGo = Object.Instantiate(Asset.Load("Music/V210MusicSet"))
	slot0.musicSetController = slot0.musicSetGo:GetComponent("MusicSetController")
	slot0.isVertical = MusicData:GetVerical()
	slot0.spectralType = MusicData:GetSpectralType()

	slot0:SetMusicCamera()

	slot0.speedNum = 0
	slot0.judgeNum = 0
	slot0.screanNum = 0
	slot0.showMovie = true
	slot0.test = true
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.m_speedSlider.minValue = uv0
	slot0.m_speedSlider.maxValue = uv1
	slot0.m_judgeSlider.minValue = uv2
	slot0.m_judgeSlider.maxValue = uv3
	slot0.m_screanSlider.minValue = uv4
	slot0.m_screanSlider.maxValue = uv5
	slot0.m_volumeSlider.minValue = uv6
	slot0.m_volumeSlider.maxValue = uv7
	slot0.ratingController = ControllerUtil.GetController(slot0.transform_, "rating")
	slot0.testController = ControllerUtil.GetController(slot0.transform_, "test")
	slot0.pathController = ControllerUtil.GetController(slot0.transform_, "path")
	slot0.spectralController = ControllerUtil.GetController(slot0.transform_, "spectral")
end

function slot0.AddUIListener(slot0)
	slot0.m_speedSlider.onValueChanged:AddListener(function ()
		uv0.speedNum = tonumber(string.format("%.1f", uv0.m_speedSlider.value))
		uv0.m_speedLab.text = uv0.speedNum

		uv0:ChangeSpeed()
	end)
	slot0:AddPressingByTimeListener(slot0.m_speedAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.speedNum < uv1 then
			uv0.speedNum = uv0.speedNum + 0.1
			uv0.speedNum = math.min(uv0.speedNum, uv1)
			uv0.m_speedSlider.value = uv0.speedNum
			uv0.m_speedLab.text = uv0.speedNum

			uv0:ChangeSpeed()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_speedDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.speedNum then
			uv0.speedNum = uv0.speedNum - 0.1
			uv0.speedNum = math.max(uv0.speedNum, uv1)
			uv0.m_speedSlider.value = uv0.speedNum
			uv0.m_speedLab.text = uv0.speedNum

			uv0:ChangeSpeed()

			return true
		end

		return false
	end)
	slot0.m_judgeSlider.onValueChanged:AddListener(function ()
		uv0.judgeNum = tonumber(string.format("%.0f", uv0.m_judgeSlider.value))
		uv0.m_judgeLab.text = uv0.judgeNum

		uv0:ChangeJudge()
	end)
	slot0:AddPressingByTimeListener(slot0.m_judgeAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.judgeNum < uv1 then
			uv0.judgeNum = uv0.judgeNum + 1
			uv0.judgeNum = math.min(uv0.judgeNum, uv1)
			uv0.m_judgeSlider.value = uv0.judgeNum
			uv0.m_judgeLab.text = uv0.judgeNum

			uv0:ChangeJudge()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_judgeDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.judgeNum then
			uv0.judgeNum = uv0.judgeNum - 1
			uv0.judgeNum = math.max(uv0.judgeNum, uv1)
			uv0.m_judgeSlider.value = uv0.judgeNum
			uv0.m_judgeLab.text = uv0.judgeNum

			uv0:ChangeJudge()

			return true
		end

		return false
	end)
	slot0.m_screanSlider.onValueChanged:AddListener(function ()
		uv0.screanNum = tonumber(string.format("%.0f", uv0.m_screanSlider.value))
		uv0.m_screanLab.text = uv0.screanNum

		uv0:ChangeScreen()
	end)
	slot0:AddPressingByTimeListener(slot0.m_screanAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.screanNum < uv1 then
			uv0.screanNum = uv0.screanNum + 1
			uv0.screanNum = math.min(uv0.screanNum, uv1)
			uv0.m_screanSlider.value = uv0.screanNum
			uv0.m_screanLab.text = uv0.screanNum

			uv0:ChangeScreen()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_screanDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.screanNum then
			uv0.screanNum = uv0.screanNum - 1
			uv0.screanNum = math.max(uv0.screanNum, uv1)
			uv0.m_screanSlider.value = uv0.screanNum
			uv0.m_screanLab.text = uv0.screanNum

			uv0:ChangeScreen()

			return true
		end

		return false
	end)
	slot0.m_volumeSlider.onValueChanged:AddListener(function ()
		uv0.volumeNum = tonumber(string.format("%.0f", uv0.m_volumeSlider.value))
		uv0.m_volumeLab.text = uv0.volumeNum

		uv0:ChangeVolume()
	end)
	slot0:AddPressingByTimeListener(slot0.m_volumeAddBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv0.volumeNum < uv1 then
			uv0.volumeNum = uv0.volumeNum + 1
			uv0.volumeNum = math.min(uv0.volumeNum, uv1)
			uv0.m_volumeSlider.value = uv0.volumeNum
			uv0.m_volumeLab.text = uv0.volumeNum

			uv0:ChangeVolume()

			return true
		end

		return false
	end)
	slot0:AddPressingByTimeListener(slot0.m_volumeDelBtn.gameObject, 3, 0.5, 0.2, function ()
		if uv1 < uv0.volumeNum then
			uv0.volumeNum = uv0.volumeNum - 1
			uv0.volumeNum = math.max(uv0.volumeNum, uv1)
			uv0.m_volumeSlider.value = uv0.volumeNum
			uv0.m_volumeLab.text = uv0.volumeNum

			uv0:ChangeVolume()

			return true
		end

		return false
	end)
	slot0:AddBtnListener(slot0.m_testOn, nil, function ()
		uv0:ChangeTestBool(true)
	end)
	slot0:AddBtnListener(slot0.m_testOff, nil, function ()
		uv0:ChangeTestBool(false)
	end)
	slot0:AddBtnListener(slot0.m_pathOn, nil, function ()
		uv0:ChangeVericalBool(false)
	end)
	slot0:AddBtnListener(slot0.m_pathOff, nil, function ()
		uv0:ChangeVericalBool(true)
	end)
	slot0:AddBtnListener(slot0.m_mirrorOn, nil, function ()
		uv0:ChangeSpectralType(MusicConst.MusicSpectralType.Mirror)
	end)
	slot0:AddBtnListener(slot0.m_mirrorOff, nil, function ()
		uv0:ChangeSpectralType(MusicConst.MusicSpectralType.None)
	end)
	slot0:AddBtnListener(slot0.m_RandomOn, nil, function ()
		uv0:ChangeSpectralType(MusicConst.MusicSpectralType.Random)
	end)
	slot0:AddBtnListener(slot0.m_RandomOff, nil, function ()
		uv0:ChangeSpectralType(MusicConst.MusicSpectralType.None)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:SetMusicCamera()
	slot0.ratingController:SetSelectedIndex(0)
	slot0:InitBackScene()

	slot0.isVertical = MusicData:GetVerical()
	slot0.spectralType = MusicData:GetSpectralType()
	slot0.speedNum = MusicData:GetSpeedValue(slot0.isVertical)
	slot0.m_speedSlider.value = slot0.speedNum
	slot0.m_speedLab.text = slot0.speedNum

	slot0:ChangeSpeed()

	slot0.judgeNum = MusicData:GetJudgeValue()
	slot0.m_judgeSlider.value = slot0.judgeNum
	slot0.m_judgeLab.text = slot0.judgeNum

	slot0:ChangeJudge()

	slot0.screanNum = MusicData:GetScreanValue()
	slot0.m_screanSlider.value = slot0.screanNum
	slot0.m_screanLab.text = slot0.screanNum

	slot0:ChangeScreen()

	slot0.volumeNum = MusicData:GetVolumeValue()
	slot0.m_volumeSlider.value = slot0.volumeNum
	slot0.m_volumeLab.text = slot0.volumeNum

	slot0:ChangeVolume()
	slot0:ChangeVericalBool(slot0.isVertical, true)
	slot0:ChangeSpectralType(slot0.spectralType)

	slot0.test = slot0.musicSetController.autoClick

	slot0.testController:SetSelectedIndex(slot0.test and 1 or 0)
	SetActive(slot0.musicSetGo, true)

	slot0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))

	slot0.musicSetController:Begain()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.raycaster then
		Object.Destroy(slot0.raycaster_)
	end

	slot0.musicSetController:End()
	SetActive(slot0.musicSetGo, false)
	MusicData:SetSpeedValue(slot0.speedNum, slot0.isVertical)
	MusicData:SetJudgeValue(slot0.judgeNum)
	MusicData:SetScreanValue(slot0.screanNum)
	MusicData:SetVolumeValue(slot0.volumeNum)
	MusicData:SetShoMovie(slot0.showMovie)
	MusicData:SetVerical(slot0.isVertical)
	MusicData:SetSpectralType(slot0.spectralType)
	SDKTools.SendMessageToSDK("activity_music_setting", {
		activity_id = ActivityConst.VOLUME_MUSIC,
		speed = tostring(slot0.speedNum),
		time = tostring(slot0.judgeNum),
		other_data = MusicData:GetSpectralAndVercialSDKKey()
	})

	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end
end

function slot0.SetMusicCamera(slot0)
	if slot0.isVertical then
		manager.ui:SetMainCamera("musicSetVertical")
	else
		manager.ui:SetMainCamera("musicSet")
	end

	slot0:AdaptiveSetGo()
end

function slot0.AdaptiveSetGo(slot0)
	slot4 = UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, slot0.setPosTrs_.position)
	slot5 = manager.ui.mainCamera.transform.localPosition.z
	slot0.musicSetGo.transform.position = Vector3(manager.ui.mainCameraCom_:ScreenToWorldPoint(Vector3(slot4.x, slot4.y, 50)).x + (slot0.isVertical and 0 or 3), 0, 0)
end

function slot0.ChangeSpeed(slot0)
	slot4 = 350
	slot0.musicSetController.stayTime = slot4 + (5 - slot0.speedNum) * (1500 - slot4) / 4
end

function slot0.ChangeJudge(slot0)
	slot1 = slot0.judgeNum

	if slot1 < 0 then
		slot2 = -1 * math.abs(slot1) / 50 * 300
	end

	MusicGame.MusicSetController.latency = slot2 - 42
end

function slot0.ChangeScreen(slot0)
	slot1 = slot0.screanNum

	if slot1 < 0 then
		slot2 = -1 * math.abs(slot1) / 50 * 300
	end

	MusicGame.MusicSetController.judgeLatency = slot2
end

function slot0.ChangeVolume(slot0)
	manager.audio:SetEffectAisacControl("musicgame_hitsound_volume", math.abs(slot0.volumeNum) / 100)
end

function slot0.ChangeTestBool(slot0, slot1)
	if slot0.test == slot1 then
		return
	end

	slot0.test = slot1

	slot0.testController:SetSelectedIndex(slot0.test and 1 or 0)

	slot0.musicSetController.autoClick = slot1
end

function slot0.ChangeSpectralType(slot0, slot1)
	slot0.spectralType = slot1
	slot2 = nil

	if slot1 == MusicConst.MusicSpectralType.None then
		slot2 = 0
	elseif slot1 == MusicConst.MusicSpectralType.Mirror then
		slot2 = 1
	elseif slot1 == MusicConst.MusicSpectralType.Random then
		slot2 = 2
	end

	if slot2 then
		slot0.spectralController:SetSelectedIndex(slot2)
	end
end

function slot0.ChangeVericalBool(slot0, slot1, slot2)
	if not slot2 and slot1 == slot0.isVertical then
		return
	end

	MusicData:SetSpeedValue(slot0.speedNum, slot0.isVertical)

	slot0.isVertical = slot1
	slot0.speedNum = MusicData:GetSpeedValue(slot0.isVertical)
	slot0.m_speedSlider.value = slot0.speedNum
	slot0.m_speedLab.text = slot0.speedNum

	slot0.pathController:SetSelectedIndex(slot0.isVertical and 0 or 1)

	MusicGame.MusicSetController.isVertical = slot1

	slot0:ChangeSpeed()
	slot0:SetMusicCamera()
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot0.backGroundTrs_.localPosition = Vector3(0, 0, 100)
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot0.backGroundTrs_.localScale = Vector3(11, 11, 1)
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = slot0.bgImg_.sprite
end

function slot0.OnMusicSetNodeHit(slot0, slot1, slot2)
	SetActive(slot0.m_effect, false)
	SetActive(slot0.m_effect, true)

	if slot1 ~= MusicConst.MusicNodeHitRating.Miss and (MusicConst.MusicNodeHitType.Short == slot2 or MusicConst.MusicNodeHitType.Long == slot2) then
		manager.audio:PlayEffect("minigame_activity_2_0", "minigame_activity_2_0_musicgame_hitsound", "")
	end

	if MusicConst.MusicNodeHitRating.PerfectPlus == slot1 then
		slot0.ratingController:SetSelectedIndex(4)
	elseif MusicConst.MusicNodeHitRating.Perfect == slot1 then
		slot0.ratingController:SetSelectedIndex(3)
	elseif MusicConst.MusicNodeHitRating.Good == slot1 then
		slot0.ratingController:SetSelectedIndex(2)
	else
		slot0.ratingController:SetSelectedIndex(1)
	end
end

return slot0
