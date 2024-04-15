slot0 = class("HeroMovieReplayView", ReduxView)
slot1 = require("game.views.obtain.ObtainHeroMovieView")

function slot0.UIName(slot0)
	return "Widget/System/ObtainUI/HeroMovie/ObtainHeroMovieUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.starController_ = ControllerUtil.GetController(slot0.transform_, "star")
	slot0.criMovie_ = slot0.movie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player
	slot0.cirMovieLoop_ = slot0.movieLoop_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayerLoop_ = slot0.cirMovieLoop_.player
	slot0.SimplePlayer_ = slot0:FindCom("VoiceOfObtainHeroSimplePlayer", "CriwareAudio")
	slot0.startDirectorStopCallBack = handler(slot0, slot0.StartDirectorStopCallBack)
	slot0.playableDirectorStart_.stopped = slot0.playableDirectorStart_.stopped + slot0.startDirectorStopCallBack

	slot0.criplayer_:SetMaxPictureDataSize(300000)

	slot0._timer = FrameTimer.New(handler(slot0, slot0.MovieProcess), 1, -1)
end

function slot0.AddUIListener(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.item = {
		id = slot0.params_.heroID
	}

	slot0:Show(slot0.item)
end

function slot0.OnExit(slot0)
	slot0._timer:Stop()
	manager.audio:StopVoice()
	slot0.criMovie_:Stop()
	slot0.cirMovieLoop_:Stop()
end

function slot0.Hide(slot0)
	uv0.super.Hide(slot0)
end

slot0.SetupCriPlayer = slot1.SetupCriPlayer

function slot0.Show(slot0, slot1)
	slot0.item = slot1

	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, true)
	end

	slot0:SetupCriPlayer(ObtainHeroMovieCfg[slot1.id])
	slot0:SetInfo(slot1)
	slot0.playableDirectorStart_:Evaluate()
	slot0.playableDirectorStart_:Play()
	SetActive(slot0.rebateGo_, false)
	SetActive(slot0.convertGo_, false)
	SetActive(slot0.m_endGo, false)

	slot0.SkipStart = true

	if slot0.SkipStart then
		slot0.playableDirectorStart_.time = slot0.playableDirectorStart_.duration
	end
end

function slot0.PlayGetHeroVoice(slot0)
	slot1 = slot0:GetHeroID()

	manager.audio:PlayVoice(string.format("vo_sys_%d", slot1), string.format("v_s_%d_%s", slot1, "get"), string.format("vo_sys_%d.awb", slot1))
end

function slot0.GetPlayable(slot0)
	return slot0.playableDirector_
end

function slot0.GetHeroID(slot0)
	return slot0.item.id
end

slot0.SetVideoTrack = slot1.SetVideoTrack

function slot0.PlayMovie(slot0, slot1)
	if slot0.isPlayMovie then
		if slot1 then
			slot0.isPlayMovieEnd = true

			slot0.criMovie_:Stop()

			slot0.movieTrs_.localPosition = Vector2(9999, 9999)

			slot0.cirMovieLoop_:Play()

			slot0.movieLoopTrs_.localPosition = Vector2(0, 0)
		end

		return
	end

	slot2 = slot0.item.id

	if slot0.start_voice_frames == 0 then
		manager.audio:PlayVoice(string.format("vo_sys_%d", slot2), string.format("v_s_%d_%s", slot2, "get"), string.format("vo_sys_%d.awb", slot2))
	end

	slot0.isPlayMovie = true

	if slot1 then
		slot0.cirMovieLoop_:Play()

		slot0.movieLoopTrs_.localPosition = Vector2(0, 0)
	else
		slot0.criMovie_:Play()

		slot0.movieTrs_.localPosition = Vector2(0, 0)
	end

	slot0._timer:Start()
end

function slot0.MovieProcess(slot0)
	slot1 = slot0.criplayer_.status
	slot2 = slot0.criplayer_:GetDisplayedFrameNo()

	if slot0.start_voice_frames ~= 0 and tostring(slot1) == "Playing" and slot0.start_voice_frames <= slot2 then
		slot0.start_voice_frames = 0

		slot0:PlayGetHeroVoice()
	end

	if tostring(slot1) == "Playing" and slot0.start_movie_frames < slot2 then
		SetActive(slot0.m_endGo, true)

		slot3 = slot0:GetPlayable()

		slot3:Evaluate()
		slot3:Play()
		slot0._timer:Stop()

		slot0.isPlayMovieEnd = true

		if slot0.showSkipHandler then
			slot0.showSkipHandler()
		end

		if slot0.refreshShareHandler_ then
			slot0.refreshShareHandler_()
		end
	end
end

function slot0.OnClick(slot0)
	slot1 = slot0:GetPlayable()

	if slot0.isPlayMovieEnd and (slot1.time == 0 or slot0:GetTimeLineEndTime() <= slot1.time) then
		return true
	end

	if not slot0.isPlayMovieEnd then
		slot0:PlayMovie(true)
	end

	slot0.isPlayMovieEnd = true

	slot0._timer:Stop()
	SetActive(slot0.m_endGo, true)

	slot0.playableDirectorStart_.time = slot0.playableDirectorStart_.duration
	slot1.time = slot0:GetTimeLineEndTime()

	slot1:Play()

	if slot0.showSkipHandler then
		slot0.showSkipHandler()
	end

	return false
end

slot0.Skip2End = slot1.Skip2End
slot0.GetTimeLineEndTime = slot1.GetTimeLineEndTime
slot0.RefreshContent = slot1.RefreshContent

function slot0.SetInfo(slot0, slot1)
	if not HeroCfg[slot1.id] then
		return
	end

	slot0:RefreshContent(slot2, slot3)
end

function slot0.Dispose(slot0)
	slot0.playableDirectorStart_.stopped = slot0.playableDirectorStart_.stopped - slot0.startDirectorStopCallBack

	uv0.super.Dispose(slot0)
end

function slot0.OnObtainHeroMovieAnimtionEvent(slot0)
	slot0:PlayMovie()
end

function slot0.StartDirectorStopCallBack(slot0)
	slot0:PlayMovie()
end

return slot0
