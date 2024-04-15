slot0 = class("VoiceSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/GameVoiceUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, VoiceSwitchItem)
end

function slot0.OnEnter(slot0)
	slot0.settingData_ = SettingData:GetSoundSettingData().voice_language

	slot0:RefreshUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.yesBtn_, nil, function ()
		uv0:SaveData()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.noBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[slot1]])
end

function slot0.RefreshUI(slot0)
	slot2 = #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list

	slot0.scrollHelper_:StartScroll(slot2)

	for slot7 = 1, slot2 do
		if VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[slot1.voice_list[slot7]].affix) then
			slot3 = 0 + VoicePackageManager.Instance:GetPackageSize(slot9.affix)
		end
	end

	slot0.numberText_.text = string.format("%.2fMB", slot3)
end

function slot0.OnGameVoiceSettingChange(slot0, slot1)
	slot0.settingData_ = slot1
end

function slot0.SaveData(slot0)
	SettingAction.ChangeSoundSetting("voice_language", slot0.settingData_)
end

function slot0.OnDownloaded(slot0, slot1)
	slot0:RefreshUI()
end

function slot0.OnLanguagePackageDeleted(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()

	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
