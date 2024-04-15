local var_0_0 = class("SkinDlcShowView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/SkinDlcShowUI"
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

	arg_4_0.criMovie_ = arg_4_0.movie_:GetComponent("CriManaMovieControllerForUI")
	arg_4_0.criplayer_ = arg_4_0.criMovie_.player

	arg_4_0.criplayer_:SetMaxPictureDataSize(300000)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.skipBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	local var_8_0 = arg_8_0.params_.goodId

	if arg_8_0.params_.dlcId then
		var_8_0 = arg_8_0.params_.dlcId
		arg_8_0.params_.dlcId = nil
	end

	local var_8_1 = getShopCfg(var_8_0)
	local var_8_2 = var_8_1.give_id or var_8_1.description

	if not var_8_1.give then
		local var_8_3 = 1
	end

	local var_8_4
	local var_8_5

	if var_8_1.description then
		local var_8_6 = var_8_1.description

		var_8_5 = RechargeShopDescriptionCfg[var_8_6]
	else
		var_8_5 = ItemCfg[var_8_2]
	end

	local var_8_7 = true

	for iter_8_0, iter_8_1 in ipairs(SkinSceneActionCfg.all) do
		local var_8_8 = SkinSceneActionCfg[iter_8_1]

		if var_8_8.special_scene_id == var_8_5.param[1] then
			arg_8_0.start_path = var_8_8.start_path

			arg_8_0:Play()

			break
		end
	end

	arg_8_0.callBack = arg_8_0.params_.callBack
	arg_8_0.params_.callBack = nil
end

function var_0_0.OnExit(arg_9_0)
	if arg_9_0.callBack then
		arg_9_0.callBack()

		arg_9_0.callBack = nil
	end

	arg_9_0.criplayer_.statusChangeCallback = nil

	arg_9_0.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function var_0_0.CirMovieStatusChange(arg_10_0, arg_10_1)
	local var_10_0 = tostring(arg_10_1)

	if var_10_0 == "PlayEnd" or var_10_0 == "Stop" then
		arg_10_0:Back()
	end
end

function var_0_0.Play(arg_11_0)
	arg_11_0.criplayer_:SetFile(nil, arg_11_0.start_path, CriMana.Player.SetMode.New)

	local var_11_0 = manager.audio:GetMusicVolume()

	arg_11_0.criplayer_:SetVolume(var_11_0)
	arg_11_0:SetVideoTrack(arg_11_0.criplayer_, arg_11_0.start_path)
	arg_11_0.criMovie_:Play()

	arg_11_0.criplayer_.statusChangeCallback = handler(arg_11_0, arg_11_0.CirMovieStatusChange)
end

function var_0_0.SetVideoTrack(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = manager.audio:GetLocalizationFlag()
	local var_12_1 = 0
	local var_12_2

	for iter_12_0 in string.gmatch(arg_12_2, "[^/]+$") do
		var_12_2 = iter_12_0
	end

	local var_12_3 = VideoTrackCfg[var_12_2]

	if var_12_3 and var_12_3.has_tracks == 1 then
		if var_12_0 == "zh" then
			var_12_1 = 0
		elseif var_12_0 == "ja" then
			var_12_1 = 1
		elseif var_12_0 == "en" then
			var_12_1 = 2
		elseif var_12_0 == "kr" then
			var_12_1 = 3
		end
	end

	arg_12_1:SetAudioTrack(var_12_1)
	arg_12_1:SetSubtitleChannel(var_12_1)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
