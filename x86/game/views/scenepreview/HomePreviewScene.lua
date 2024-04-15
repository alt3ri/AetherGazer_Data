slot0 = class("HomePreviewScene", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Main/SceneChange3"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.showBtn_, nil, function ()
		uv0.isOff_ = 1 - uv0.isOff_

		uv0.selectCon_:SetSelectedState(uv0.isOff_ == 1 and "off" or "on")
	end)
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("homePreview")
	manager.loadScene:SetPreviewHomeSceneSoundEffect()
	slot0:RefreshUI()
	slot0:PlayBgm()
end

function slot0.RefreshUI(slot0)
	slot0.isOff_ = 1

	slot0.selectCon_:SetSelectedState("off")
end

function slot0.PlayBgm(slot0)
	slot2 = HomeSceneSettingCfg[HomeSceneSettingData:GetPreviewScene()]

	if slot2.default_music ~= 0 and SettingData:GetHomeSceneSettingData().home_scene_scene_bgm == 1 and table.indexof(slot2.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		slot6 = MusicRecordCfg[slot4]

		manager.audio:PlayBGM(slot6.cuesheet, slot6.cueName, slot6.awbName)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function slot0.OnExit(slot0)
	manager.loadScene:StopSceneSoundEffect()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
