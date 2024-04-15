slot0 = class("LanguagePackageView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/LanguagePackageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, LanguagePackageItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.yesBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
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

function slot0.OnDownloaded(slot0, slot1)
	slot0:RefreshUI()
end

function slot0.OnLanguagePackageDeleted(slot0)
	slot0:RefreshUI()
end

function slot0.OnEnter(slot0)
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
