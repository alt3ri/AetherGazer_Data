slot0 = class("LanguageSwitchView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Setting/GameLanguageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, LanguageSwitchItem)
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

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot1)
end

function slot0.RefreshUI(slot0)
	slot0.scrollHelper_:StartScroll(#AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list)

	slot0.languageList = {}
end

function slot0.OnGameLanguageSettingChange(slot0, slot1)
	slot0.settingData_ = slot1
end

function slot0.SaveData(slot0)
	SettingAction.ChangeSoundSetting("text_language", slot0.settingData_)
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
