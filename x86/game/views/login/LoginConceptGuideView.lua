slot0 = class("LoginConceptGuideView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/LoginInterface/LoginConceptGuild"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.criManaExMultipleVideo_ = slot0.movieGo_:GetComponent("CriManaExMultipleVedio")
	slot0.criManaMovieController_ = slot0.movieGo_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criManaMovieController_.player
	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.StatusChangeCallback)

	slot0.criplayer_:SetVolume(manager.audio:GetEffectVolume())
	slot0.criplayer_:SetMaxPictureDataSize(600000)
	slot0:InitMovieData()

	slot0._timer = FrameTimer.New(handler(slot0, slot0.MovieProcess), 1, -1)
end

function slot0.InitMovieData(slot0)
	slot0.moviePath_ = {}
	slot0.movieTotalFrames_ = {}

	for slot6 = 1, 4 do
		table.insert(slot0.moviePath_, GameDisplayCfg.login_concept_guild_movie_path.value[slot6])

		slot0.movieTotalFrames_[slot6] = GameDisplayCfg.login_concept_guild_movie_frames.value[slot6]
	end

	slot0.movieEndFrames_ = {}

	slot0:CalcNextMovieData(0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.nextBtn_1, nil, function ()
		uv0:CalcNextMovieData(1, 1)
		uv0:StepPlayLoopMovie(2)
		SetActive(uv0.nextGo_1, false)
	end)
	slot0:AddBtnListener(slot0.nextBtn_2, nil, function ()
		uv0:CalcNextMovieData(3)
		SetActive(uv0.nextGo_2, false)
	end)
end

function slot0.OnEnter(slot0)
	gameContext:SetSystemLayer("login")

	_G.isLogining = false

	LoadingUIManager.inst:CloseLoadUI()
	SetActive(slot0.nextGo_1, false)
	SetActive(slot0.nextGo_2, false)

	slot0.curMovieIdx_ = 1

	slot0:StepPlayLoopMovie(1)
	slot0._timer:Start()

	slot0.movieExited_ = {}
end

function slot0.OnExit(slot0)
	GameLocalData:SaveToCommonModule("LoginConceptGuideData", "watched", true)
	slot0._timer:Stop()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.StatusChangeCallback(slot0, slot1)
	if tostring(slot1) == "PlayEnd" then
		slot0:OnMovieEnd(slot0.curMovieIdx_)
	elseif slot2 == "Playing" then
		slot0:FetchMovieTotalFrames()
	end
end

function slot0.OnMovieEnd(slot0, slot1)
	if slot0.movieExited_[slot1] then
		return
	end

	slot0.movieExited_[slot1] = true

	if slot1 == 1 then
		SetActive(slot0.nextGo_1, true)
	elseif slot1 == 2 then
		slot0:CalcNextMovieData(slot1)
	elseif slot1 == 3 then
		SetActive(slot0.nextGo_2, true)
	elseif slot1 == 4 then
		slot0:JumpToLoginPage()
	elseif slot1 == 5 then
		slot0:JumpToLoginPage()
	end

	slot0.curMovieIdx_ = slot0.curMovieIdx_ + 1
end

function slot0.StepPlayLoopMovie(slot0, slot1)
	slot2 = slot1 * 2 - 1

	slot0.criplayer_:SetFile(nil, slot0.moviePath_[slot2], CriMana.Player.SetMode.Append)
	slot0.criplayer_:SetFile(nil, slot0.moviePath_[slot2 + 1], CriMana.Player.SetMode.AppendRepeatedly)
	slot0.criManaMovieController_:Play()
end

function slot0.StepPlayExitMovie(slot0)
	slot0.criplayer_:SetFile(nil, slot0.moviePath_[5], CriMana.Player.SetMode.New)
	slot0.criManaMovieController_:Play()
end

function slot0.FetchMovieTotalFrames(slot0)
end

function slot0.MovieProcess(slot0)
	slot1 = slot0.criplayer_.status
	slot2 = slot0.criplayer_:GetDisplayedFrameNo()

	if slot0.movieEndFrames_[slot0.curMovieIdx_] == nil then
		return
	end

	if slot0.movieEndFrames_[slot3] <= slot2 then
		slot0:OnMovieEnd(slot3)
	end
end

function slot0.JumpToLoginPage(slot0)
	slot0:Back()
	gameContext:Go("/login", {
		isAutoLogin = slot0.params_.isAutoLogin
	})
end

function slot0.CalcNextMovieData(slot0, slot1, slot2)
	slot3 = slot1 + 1

	if slot1 == 0 then
		slot0.movieEndFrames_[slot3] = slot0.movieTotalFrames_[slot3]

		return
	end

	if slot2 == nil then
		slot2 = 0
	end

	slot5 = slot0.movieTotalFrames_[slot3]
	slot6 = slot0.movieEndFrames_[slot1]
	slot0.movieEndFrames_[slot3] = slot6 + slot5 * math.max(math.ceil((slot0.criplayer_:GetDisplayedFrameNo() - slot6) / slot5) + slot2, 1)
end

return slot0
