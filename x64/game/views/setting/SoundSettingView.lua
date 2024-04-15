slot0 = class("SoundSettingView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.info_ = slot3

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.soundSlider_ = {}
	slot0.soundText_ = {}
	slot0.soundCutBtn_ = {}
	slot0.soundAddBtn_ = {}
	slot0.fillImg_ = {}

	for slot4 = 1, 3 do
		slot0.soundSlider_[slot4] = slot0["slider" .. slot4 .. "Slr_"]
		slot0.soundText_[slot4] = slot0["num" .. slot4 .. "Text_"]
		slot0.soundCutBtn_[slot4] = slot0["cut" .. slot4 .. "Btn_"]
		slot0.soundAddBtn_[slot4] = slot0["add" .. slot4 .. "Btn_"]
		slot0.fillImg_[slot4] = slot0["fill" .. slot4 .. "Img_"]
	end

	slot0:InitTextLanguageOption()
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0.soundSlider_[slot4].onValueChanged:AddListener(function (slot0)
			uv0:SetSoundValue(uv1, uv0.soundSlider_[uv1].value)
		end)
		slot0:AddPressingByTimeListener(slot0.soundCutBtn_[slot4].gameObject, 3, 0.5, 0.5, function ()
			if uv0.soundCutBtn_[uv1].interactable and uv0.soundSlider_[uv1].value > 0 then
				uv0:SetSoundValue(uv1, uv0.soundSlider_[uv1].value - 1)

				return true
			end

			return false
		end)
		slot0:AddPressingByTimeListener(slot0.soundAddBtn_[slot4].gameObject, 3, 0.5, 0.5, function ()
			if uv0.soundAddBtn_[uv1].interactable and uv0.soundSlider_[uv1].value < 100 then
				uv0:SetSoundValue(uv1, uv0.soundSlider_[uv1].value + 1)

				return true
			end

			return false
		end)

		slot5 = slot0:GetOrAddComponent(slot0.soundSlider_[slot4].gameObject, typeof(EventTriggerListener))

		slot5:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function ()
			OperationRecorder.Record("setting", "setting_audio_slide")
		end))
		slot0:SetListener(slot5)
	end

	slot0:AddToggleListener(slot0.switchTeammateTgl_, function (slot0)
		slot1 = 0

		if slot0 then
			slot1 = 1
		end

		if uv0.settingData_.teammate_sound_open ~= slot1 then
			SettingAction.ChangeSoundSetting("teammate_sound_open", slot1)
		end
	end)
	slot0:AddToggleListener(slot0.switchTgl_, function (slot0)
		slot1 = 0

		if slot0 then
			slot1 = 1
		end

		if uv0.settingData_.sound_open ~= slot1 then
			SettingAction.ChangeSoundSetting("sound_open", slot1)
		end

		uv0:ChangeVoiceEnable(slot0)
	end)
	slot0:AddBtnListener(slot0.packageBtn_, nil, function ()
		JumpTools.OpenPageByJump("languagePackage")
	end)
	slot0:AddBtnListener(slot0.voiceBtn_, nil, function ()
		JumpTools.OpenPageByJump("voiceSwitch")
	end)
	slot0:AddBtnListener(slot0.languageBtn_, nil, function ()
		JumpTools.OpenPageByJump("languageSwitch")
	end)
end

function slot0.ChangeVoiceEnable(slot0, slot1)
	for slot5 = 1, 3 do
		slot0.soundSlider_[slot5].interactable = slot1
		slot0.soundCutBtn_[slot5].interactable = slot1
		slot0.soundAddBtn_[slot5].interactable = slot1

		manager.effect:SetGrey(slot0.fillImg_[slot5], not slot1)
	end
end

function slot0.OnDownloaded(slot0, slot1)
	for slot7 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		if VoiceLanguageCfg[slot2.voice_list[slot7]].affix == slot1 then
			SettingAction.ChangeSoundSetting("voice_language", slot7)
		end
	end
end

function slot0.OnCancalDownload(slot0)
	slot0:RefreshVoiceLanguage()
end

function slot0.RefreshUI(slot0)
	slot0.soundSlider_[1].value = slot0.settingData_.music
	slot0.soundText_[1].text = slot0.settingData_.music .. "%"
	slot0.soundSlider_[2].value = slot0.settingData_.effect
	slot0.soundText_[2].text = slot0.settingData_.effect .. "%"
	slot0.soundSlider_[3].value = slot0.settingData_.voice
	slot0.soundText_[3].text = slot0.settingData_.voice .. "%"

	slot0:RefreshSoundSwitch()
	slot0:RefreshVoiceLanguage()
	slot0:RefreshTextLanguage()
	slot0:RefreshTeammateSoundSwitch()
end

function slot0.RefreshTeammateSoundSwitch(slot0)
	slot0.switchTeammateTgl_.isOn = slot0.settingData_.teammate_sound_open == 1

	slot0.switchTeammateTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(slot1)
end

function slot0.RefreshSoundSwitch(slot0)
	slot0.switchTgl_.isOn = slot0.settingData_.sound_open == 1

	slot0.switchTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(slot1)
end

function slot0.InitTextLanguageOption(slot0)
	if #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list < 2 then
		slot0.languageBtn_.enabled = false

		SetActive(slot0.languageIconGo_, false)
	else
		slot0.languageBtn_.enabled = true

		SetActive(slot0.languageIconGo_, true)
	end
end

function slot0.RefreshTextLanguage(slot0)
	slot1 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
	slot0.languageText_.text = slot1.language_in_list[table.indexof(slot1.language_list, slot0.settingData_.text_language)]
end

function slot0.RefreshVoiceLanguage(slot0)
	slot0.voiceText_.text = VoiceLanguageCfg[table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list, slot0.settingData_.voice_language)].name
end

function slot0.SetSoundValue(slot0, slot1, slot2)
	if slot1 == 1 then
		SettingAction.ChangeSoundSetting("music", slot2)
	elseif slot1 == 2 then
		SettingAction.ChangeSoundSetting("effect", slot2)
	elseif slot1 == 3 then
		SettingAction.ChangeSoundSetting("voice", slot2)
	end
end

function slot0.CheckDataChange(slot0, slot1)
	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		return true
	end

	return false
end

function slot0.SaveData(slot0)
	if slot0:CheckDataChange() then
		slot0.json_ = require("cjson")
		slot1 = deepClone(slot0.settingData_)
		slot1.type = 2

		SDKTools.SendMessageToSDK("audio_setting", {
			bg_audio_setting = slot0.settingData_.music,
			effect_setting = slot0.settingData_.effect,
			sound_setting = slot0.settingData_.voice,
			language = slot0.settingData_.voice_language
		})

		slot2 = slot0.json_.encode(slot1)

		manager.net:SendWithLoadingNew(12100, {
			language = slot0.settingData_.text_language
		}, 12101, function (slot0)
			if not isSuccess(slot0.result) then
				ShowTips(slot0.result)
			end
		end)
	end

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
end

function slot0.RecoverTmpData(slot0)
	if slot0:CheckDataChange() then
		if not VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[slot0.tmpSettingData_.voice_language].affix) then
			slot0.tmpSettingData_.voice_language = slot0.settingData_.voice_language
		end

		SettingAction.ChangeSoundSetting("allData", slot0.tmpSettingData_)
	end
end

function slot0.OnSoundSettingChange(slot0, slot1, slot2)
	slot0:RefreshUI()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.settingData_ = SettingData:GetSoundSettingData()

	slot0:RefreshUI()

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
	slot1 = slot0.hander_.params_.setType or SettingConst.SETTING_TYPE.SYSTEM

	SetActive(slot0.languageGo_, slot1 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(slot0.voiceGo_, slot1 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(slot0.packageGo_, slot1 == SettingConst.SETTING_TYPE.SYSTEM)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.hander_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
