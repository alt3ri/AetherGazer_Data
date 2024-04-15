local var_0_0 = class("VolumeMusicStopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/AthenaMusicGame/VolumeIIIDownMusicPauseUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_goBtn, nil, function()
		arg_5_0:Back()
		MusicLuaBridge.ResumeMusicGame()

		local var_6_0 = GameObject.Find("movie")

		if var_6_0 then
			var_6_0:GetComponent("CriManaMovieMaterial"):Pause(false)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_endBtn, nil, function()
		arg_5_0:Back()
		MusicLuaBridge.EndMusicGame()
	end)
	arg_5_0:AddBtnListener(arg_5_0.m_reBtn, nil, function()
		arg_5_0:Back()

		local var_8_0 = MusicData:GetGameId()
		local var_8_1 = ActivityMusicCfg[var_8_0]

		if var_8_1 then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = true,
				activity_id = var_8_1.activity_id,
				difficulty_id = var_8_1.difficult
			})
		end

		MusicLuaBridge.ReStartMusicGame()
	end)
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_10_0)
	return
end

function var_0_0.OnExit(arg_11_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
