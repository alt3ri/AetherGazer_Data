slot0 = class("ActivitySkinDrawMovieView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddBtnListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddBtnListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	SetActive(slot0.gameObject_, true)

	slot0.itemCfg_ = slot1
	slot0.backcall_ = slot2
	slot0.itemID_ = slot0.itemCfg_.id
	slot0.movieCfg_ = ObtainSkinMovieCfg[slot0.itemID_]
	slot0.moviePath_ = slot0.movieCfg_.start_path
	slot0.criMovie_ = slot0.movie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player
	slot0.isPlayMovie_ = false
	slot0.isPlayMovieEnd_ = false

	slot0.criMovie_:Stop()

	slot0.movieTrs_.localPosition = Vector2(9999, 9999)

	slot0.criplayer_:SetFile(nil, slot0.moviePath_, CriMana.Player.SetMode.New)
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0:SetVideoTrack(slot0.criplayer_, slot0.moviePath_)
	slot0:StopTimer()

	slot0.timer_ = FrameTimer.New(handler(slot0, slot0.MovieProcess), 1, -1)

	slot0:PlayMovie()
end

function slot0.SetVideoTrack(slot0, slot1, slot2)
	slot3 = manager.audio:GetLocalizationFlag()
	slot4 = 0
	slot5 = nil
	slot9 = "[^/]+$"

	for slot9 in string.gmatch(slot2, slot9) do
		slot5 = slot9
	end

	if VideoTrackCfg[slot5] and slot6.has_tracks == 1 then
		if slot3 == "zh" then
			slot4 = 0
		elseif slot3 == "ja" then
			slot4 = 1
		elseif slot3 == "en" then
			slot4 = 2
		elseif slot3 == "kr" then
			slot4 = 3
		end
	end

	slot1:SetAudioTrack(slot4)
	slot1:SetSubtitleChannel(slot4)
end

function slot0.PlayMovie(slot0, slot1)
	if slot0.isPlayMovie_ then
		if slot1 then
			slot0.isPlayMovieEnd_ = true

			slot0.criMovie_:Stop()

			slot0.movieTrs_.localPosition = Vector2(9999, 9999)

			slot0:Hide()

			if slot0.backcall_ then
				slot0.backcall_()
			end
		end

		return
	end

	manager.audio:PlayVoice(string.format("vo_sys_%d", slot0.itemID_), string.format("skin_v_getvideo_%d_%s", slot0.itemID_, "get"), string.format("vo_sys_%d.awb", slot0.itemID_))

	slot0.isPlayMovie_ = true

	if slot1 then
		slot0:Hide()

		if slot0.backcall_ then
			slot0.backcall_()
		end
	else
		slot0.criMovie_:Play()

		slot0.movieTrs_.localPosition = Vector2(0, 0)
	end

	slot0.timer_:Start()
end

function slot0.MovieProcess(slot0)
	if tostring(slot0.criplayer_.status) == "Playing" and slot0.movieCfg_.end_movie_frames < slot0.criplayer_:GetDisplayedFrameNo() then
		slot0.timer_:Stop()

		slot0.isPlayMovieEnd_ = true

		slot0:Hide()

		if slot0.backcall_ then
			slot0.backcall_()
		end
	end
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
	manager.audio:StopVoice()
	slot0:StopTimer()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
