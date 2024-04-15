slot0 = class("EnternalMusicStopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicPromptUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_goBtn, nil, function ()
		uv0:Back()
		MusicLuaBridge.ResumeMusicGame()

		if GameObject.Find("movie") and slot0:GetComponent("CriManaMovieMaterial") then
			slot1:Pause(false)
		end
	end)
	slot0:AddBtnListener(slot0.m_endBtn, nil, function ()
		uv0:Back()
		MusicLuaBridge.EndMusicGame()
	end)
	slot0:AddBtnListener(slot0.m_reBtn, nil, function ()
		uv0:Back()

		if ActivityMusicCfg[MusicData:GetGameId()] then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = true,
				activity_id = slot1.activity_id,
				difficulty_id = slot1.difficult,
				other_data = MusicData:GetSpectralAndVercialSDKKey()
			})
		end

		MusicLuaBridge.ReStartMusicGame()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

return slot0
