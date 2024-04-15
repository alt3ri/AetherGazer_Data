slot0 = class("SkinDlcShowView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero/SkinDlcShowUI"
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

	slot0.criMovie_ = slot0.movie_:GetComponent("CriManaMovieControllerForUI")
	slot0.criplayer_ = slot0.criMovie_.player

	slot0.criplayer_:SetMaxPictureDataSize(300000)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.goodId

	if slot0.params_.dlcId then
		slot1 = slot0.params_.dlcId
		slot0.params_.dlcId = nil
	end

	slot4 = slot2.give or 1
	slot5, slot6 = nil
	slot7 = true

	for slot11, slot12 in ipairs(SkinSceneActionCfg.all) do
		if SkinSceneActionCfg[slot12].special_scene_id == ((not slot2.description or RechargeShopDescriptionCfg[slot2.description]) and ItemCfg[getShopCfg(slot1).give_id or slot2.description]).param[1] then
			slot0.start_path = slot13.start_path

			slot0:Play()

			break
		end
	end

	slot0.callBack = slot0.params_.callBack
	slot0.params_.callBack = nil
end

function slot0.OnExit(slot0)
	if slot0.callBack then
		slot0.callBack()

		slot0.callBack = nil
	end

	slot0.criplayer_.statusChangeCallback = nil

	slot0.criMovie_:Stop()
	manager.windowBar:HideBar()
end

function slot0.CirMovieStatusChange(slot0, slot1)
	if tostring(slot1) == "PlayEnd" or slot2 == "Stop" then
		slot0:Back()
	end
end

function slot0.Play(slot0)
	slot0.criplayer_:SetFile(nil, slot0.start_path, CriMana.Player.SetMode.New)
	slot0.criplayer_:SetVolume(manager.audio:GetMusicVolume())
	slot0:SetVideoTrack(slot0.criplayer_, slot0.start_path)
	slot0.criMovie_:Play()

	slot0.criplayer_.statusChangeCallback = handler(slot0, slot0.CirMovieStatusChange)
end

function slot0.SetVideoTrack(slot0, slot1, slot2)
	slot3 = manager.audio:GetLocalizationFlag()
	slot4 = 0
	slot5 = nil

	for slot9 in string.gmatch(slot2, "[^/]+$") do
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

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
