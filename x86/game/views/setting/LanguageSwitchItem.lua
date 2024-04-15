slot0 = class("LanguageSwitchItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = slot0.comps_:GetController("status")
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.toggle_, function (slot0)
		if slot0 then
			manager.notify:CallUpdateFunc(GAME_LANGUAGE_SETTING, uv0.info_.language_list[uv0.index_])
		end
	end)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.Render(slot0)
	slot0:RefreshData(slot0.index_)
end

function slot0.RefreshData(slot0, slot1)
	if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER] then
		slot0.info_ = slot2
		slot0.index_ = slot1
		slot0.nameText_.text = GetI18NText(slot2.language_in_list[slot1])

		if SettingData:GetSoundSettingData().text_language == slot2.language_list[slot1] then
			slot0.statusController_:SetSelectedState("in_use")

			slot0.toggle_.isOn = true
		else
			slot0.statusController_:SetSelectedState("downloaded")
		end
	end
end

function slot0.Dispose(slot0)
	slot0.params_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
