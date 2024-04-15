slot0 = class("VideoPlayMgr", import("game.extend.ReduxView"))

function slot0.Ctor(slot0)
end

function slot0.InitUI(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/Stage/VideoPlayUI"), manager.ui.uiStory.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.criManaMovieController_ = slot0.goMovie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criManaMovieController_.player
	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.StatusChangeCallback)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonClose_, nil, function ()
	end)
	slot0:AddBtnListener(slot0.buttonSkip_, nil, function ()
		if Time.realtimeSinceStartup == uv0.lastTime then
			return
		end

		uv0.lastTime = Time.realtimeSinceStartup

		uv0.criManaMovieController_:Pause(true)

		if uv0.onPauseCallback then
			uv0.onPauseCallback(true)
		end

		uv0:RemoveCaptionTimer()
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("TIP_SKIP_PLOT"),
			OkCallback = function ()
				if not isNil(uv0.criManaMovieController_) then
					uv0.criManaMovieController_:Pause(false)
					uv0.criManaMovieController_:Stop()
				end

				if uv0.onFinishCallback_ then
					uv0.onFinishCallback_(StoryOperDefine.PASS)
				end
			end,
			CancelCallback = function ()
				if not isNil(uv0.criManaMovieController_) then
					uv0.criManaMovieController_:Pause(false)
				end

				if uv0.onPauseCallback then
					uv0.onPauseCallback(false)
				end

				uv0:StartCaptionTimer()
			end,
			MaskCallback = function ()
				if not isNil(uv0.criManaMovieController_) then
					uv0.criManaMovieController_:Pause(false)
				end

				if uv0.onPauseCallback then
					uv0.onPauseCallback(false)
				end

				uv0:StartCaptionTimer()
			end
		})
	end)
end

function slot0.Play(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0.gameObject_ == nil then
		slot0:InitUI()
		slot0:AddListeners()
	end

	slot0.startStop_ = false

	if slot3 == nil then
		slot0.autoHide_ = true
	else
		slot0.autoHide_ = slot3
	end

	SetActive(slot0.goSkip_, true)
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())

	slot8 = manager.audio:GetLocalizationFlag()
	slot9 = 0
	slot10 = nil

	for slot14 in string.gmatch(slot1, "[^/]+$") do
		slot10 = slot14
	end

	if VideoTrackCfg[slot10] and slot11.has_tracks == 1 then
		if slot8 == "zh" then
			slot9 = 0
		elseif slot8 == "ja" then
			slot9 = 1
		elseif slot8 == "en" then
			slot9 = 2
		elseif slot8 == "ko" then
			slot9 = 3
		end
	end

	slot0.criplayer_:SetAudioTrack(slot9)
	slot0.criplayer_:SetSubtitleChannel(slot9)

	if slot4 == nil then
		slot0.criplayer_:Loop(false)
	else
		slot0.criplayer_:Loop(slot4)
	end

	slot0.criplayer_:SetFile(nil, slot1)

	slot0.onFinishCallback_ = slot2
	slot0.onPauseCallback = slot5
	slot0.videoId = slot6

	SetActive(slot0.gameObject_, true)

	if not isNil(slot0.criManaMovieController_) then
		slot0.criManaMovieController_:Play()
	end

	slot0:CaptionPlay()
	manager.windowBar:HideBar()
	slot0:AdaptScreen()
end

function slot0.CaptionPlay(slot0)
	slot0.time = 0
	slot0.currentPlayId = 1

	slot0:StartCaptionTimer()
end

function slot0.StartCaptionTimer(slot0)
	if slot0.videoId == nil or slot0.videoId == 0 then
		slot0.text_.text = ""

		return
	end

	slot1 = SettingData:GetCurrentLanguage()

	if import("game.subtitle.subtitle" .. slot0.videoId) == nil then
		slot0:RemoveCaptionTimer()

		return
	else
		slot2 = slot2[slot1]
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.start < slot1.start
	end)

	if not slot0.captionTimer then
		slot0.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
			uv0.text_.text = ""
			uv0.time = uv0.time + Time.deltaTime

			if uv1[uv0.currentPlayId] == nil then
				uv0:RemoveCaptionTimer()

				return
			end

			if uv0.time < slot0.endTime and slot0.start < uv0.time then
				uv0.text_.text = GetI18NText(slot0.content)
			elseif slot0.endTime < uv0.time then
				uv0.currentPlayId = uv0.currentPlayId + 1
			end
		end, -1, true)
	end
end

function slot0.PauseCaptionTimer(slot0)
	if slot0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.captionTimer)

		slot0.captionTimer = nil
	end
end

function slot0.RemoveCaptionTimer(slot0)
	if slot0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.captionTimer)

		slot0.captionTimer = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.gameObject_ then
		slot0.criplayer_.statusChangeCallback = nil

		slot0:RemoveCaptionTimer()
		Object.Destroy(slot0.gameObject_)

		slot0.gameObject_ = nil
		slot0.transform_ = nil
		slot0.onFinishCallback_ = nil
		slot0.onPauseCallback = nil
	end
end

function slot0.StatusChangeCallback(slot0, slot1)
	if tostring(slot1) == "PlayEnd" then
		if not isNil(slot0.criManaMovieController_) then
			slot0.criManaMovieController_:Stop()
		end

		slot0:RemoveCaptionTimer()

		if slot0.onFinishCallback_ then
			slot0.onFinishCallback_(StoryOperDefine.NORMAL)
		end
	elseif slot2 == "StopProcessing" then
		slot0.startStop_ = true

		return
	elseif slot2 == "Stop" and slot0.startStop_ and slot0.autoHide_ then
		SetActive(slot0.gameObject_, false)
	end

	slot0.startStop_ = false
end

function slot0.HidePlayer(slot0)
	if slot0.startStop_ then
		slot0.autoHide_ = true

		return
	end

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, false)
	end

	slot0.autoHide_ = true
end

function slot0.AdaptRight(slot0)
	if slot0.rightTrs_ == nil then
		slot0.rightGo_ = slot0.goSkip_
		slot0.rightTrs_ = slot0.rightGo_:GetComponent(typeof(RectTransform))
		slot0.needAdaptRight_ = false
	end

	uv0.super.AdaptRight(slot0)
end

return slot0
