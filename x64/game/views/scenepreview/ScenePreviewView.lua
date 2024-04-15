slot0 = class("ScenePreviewView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Main/SceneChange1"
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

	slot0.effectTgl_ = {}

	for slot4, slot5 in ipairs(HomeSceneTagCfg.all) do
		slot0.effectTgl_[slot5] = slot0["effectTgl_" .. slot5]
	end

	slot4 = "btn"
	slot0.btnCon_ = ControllerUtil.GetController(slot0.transform_, slot4)
	slot0.setting_ = {
		[HomeSceneSettingConst.SETTING.SOUND_EFFECT] = "sound_effect",
		[HomeSceneSettingConst.SETTING.CAMERA_FOLLOW] = "camera_follow",
		[HomeSceneSettingConst.SETTING.SCENE_BGM] = "scene_bgm"
	}
	slot0.settingBtn_ = {}
	slot0.settingCon_ = {}
	slot0.settingItem_ = {}

	for slot4, slot5 in ipairs(slot0.setting_) do
		slot0.settingBtn_[slot4] = slot0["settingBtn_" .. slot4]
		slot0.settingItem_[slot4] = slot0["settingItem_" .. slot4]
		slot0.settingCon_[slot4] = ControllerUtil.GetController(slot0.settingItem_[slot4].transform, "type")
	end

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ScenePreviewItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.list_[slot1]

	slot2:RefreshData(slot3, slot0.data_[slot3], slot3 == slot0.curSceneID_)
	slot2:RegistClickFunc(function ()
		uv0.curSceneID_ = uv1

		uv0:RefreshRight()
		uv0.scrollHelper_:Refresh()
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		HomeSceneSettingAction.SetHomeScene(uv0.curSceneID_)
	end)
	slot0:AddBtnListener(slot0.trialBtn_, nil, function ()
		HomeSceneSettingAction.SetHomeScene(uv0.curSceneID_)
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		if uv0:IsCanGet() then
			JumpTools.JumpToPage2(uv0.cfg_.obtain_way)
		else
			ShowTips("HOME_NO_GET_WAY")
		end
	end)
	slot0:AddBtnListener(slot0.noGetBtn_, nil, function ()
		if not uv0:IsCanGet() then
			ShowTips("HOME_NO_GET_WAY")
		end
	end)

	slot4 = slot0.previewBtn_
	slot5 = nil

	slot0:AddBtnListener(slot4, slot5, function ()
		uv0.params_.sceneID = uv0.curSceneID_
		slot0 = HomeSceneSettingData:SetPreviewScene(uv0.curSceneID_)

		HomeSceneSettingData:SetPreviewSceneParams(slot0)
		OpenPageUntilLoaded("/homePreview", slot0)
	end)

	for slot4, slot5 in ipairs(slot0.setting_) do
		slot0:AddBtnListener(slot0.settingBtn_[slot4], nil, function ()
			slot0 = "home_scene_" .. uv0

			SettingAction.ChangeHomeSceneSetting(slot0, 1 - uv1.settingData_[slot0])
		end)
	end

	for slot4, slot5 in ipairs(HomeSceneTagCfg.all) do
		slot0:AddToggleListener(slot0["effectTgl_" .. slot5], function (slot0)
			if slot0 then
				uv0:AddClickTimer()

				slot1 = HomeSceneTagCfg[uv1]
				uv0.tglTitle_.text = slot1.tag_desc
				uv0.tglDesc_.text = slot1.tag_detail

				uv0.tglPanelGo_.transform:SetParent(uv0["effectTgl_" .. uv1].transform)

				uv0.tglPanelGo_.transform:GetComponent("RectTransform").anchoredPosition = Vector3.New(0, 60, 0)

				SetActive(uv0.tglPanelGo_, true)
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	HomeSceneSettingData:DealOverdueScene()

	slot0.curSceneID_ = slot0.params_.sceneID

	if HomeSceneSettingCfg[slot0.curSceneID_] and slot1.limit_display == 0 then
		slot0.curSceneID_ = 6000
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshList()
	slot0:RefreshRight()
end

function slot0.RefreshList(slot0)
	slot0.data_ = {}
	slot0.list_ = {}

	for slot4, slot5 in ipairs(HomeSceneSettingCfg.all) do
		if HomeSceneSettingCfg[slot5].limit_display == 1 then
			table.insert(slot0.list_, slot5)

			slot0.data_[slot5] = HomeSceneSettingData:GetUsedState(slot5)
		end
	end

	table.sort(slot0.list_, function (slot0, slot1)
		if uv0.data_[slot0] ~= uv0.data_[slot1] then
			return uv0.data_[slot1] < uv0.data_[slot0]
		end

		return slot0 < slot1
	end)
	slot0.scrollHelper_:StartScroll(#slot0.list_, table.indexof(slot0.list_, slot0.curSceneID_))
end

function slot0.RefreshRight(slot0)
	slot0.cfg_ = HomeSceneSettingCfg[slot0.curSceneID_]
	slot0.title_.text = slot0.cfg_.title
	slot0.desc_.text = slot0.cfg_.desc
	slot0.bg_.sprite = getSpriteWithoutAtlas("TextureConfig/SceneChangeUI/bg/" .. slot0.curSceneID_)

	slot0:ResetTgl()
	slot0:RefreshSetting()
	slot0:RefreshType()
	slot0:RefreshRedPoint()
end

function slot0.ResetTgl(slot0)
	slot0:HideMessage()

	for slot5, slot6 in ipairs(HomeSceneTagCfg.all) do
		if slot0["effectTgl_" .. slot6] then
			if table.indexof(slot0.cfg_.scene_tag, slot6) then
				SetActive(slot0["effectTgl_" .. slot6].gameObject, true)
			else
				SetActive(slot0["effectTgl_" .. slot6].gameObject, false)
			end

			slot0["effectTgl_" .. slot6].isOn = false
		end
	end
end

function slot0.HideMessage(slot0)
	SetActive(slot0.tglPanelGo_, false)
end

function slot0.RefreshSetting(slot0)
	for slot5, slot6 in ipairs(slot0.setting_) do
		if table.indexof(slot0.cfg_.scene_setting, slot5) then
			SetActive(slot0.settingItem_[slot5], true)
		else
			SetActive(slot0.settingItem_[slot5], false)
		end
	end

	slot0.settingData_ = SettingData:GetHomeSceneSettingData()

	slot0:RefreshSoundEffect()
	slot0:RefreshSceneBgm()
end

function slot0.RefreshSoundEffect(slot0)
	slot0.settingCon_[1]:SetSelectedState(slot0.settingData_.home_scene_sound_effect == 1 and "on" or "off")
end

function slot0.RefreshCameraFollow(slot0)
	slot0.settingCon_[2]:SetSelectedState(slot0.settingData_.home_scene_camera_follow == 1 and "on" or "off")
end

function slot0.RefreshSceneBgm(slot0)
	slot0.settingCon_[3]:SetSelectedState(slot0.settingData_.home_scene_scene_bgm == 1 and "on" or "off")
end

function slot0.RefreshType(slot0)
	slot0:StopTimer()

	slot2 = HomeSceneSettingData:GetCurScene()

	if slot0.data_[slot0.curSceneID_] == 0 then
		slot0.btnCon_:SetSelectedState(slot0:IsCanGet() and "get" or "ban")

		slot0.tip_.text = slot0.cfg_.unlock_description
	elseif slot1 == 1 then
		slot0.btnCon_:SetSelectedState(slot0.curSceneID_ == slot2 and "trialing" or "trial")
		slot0:RefreshTime()
	elseif slot1 == 2 then
		slot0.btnCon_:SetSelectedState(slot0.curSceneID_ == slot2 and "using" or "use")
	end

	SetActive(slot0.unlockGo_, slot1 == 0 and slot0.cfg_.unlock_description ~= "")
	SetActive(slot0.timeGo_, slot1 == 1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.tglContent_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.tglContent_)
end

function slot0.IsCanGet(slot0)
	return slot0.cfg_.obtain_way and #slot0.cfg_.obtain_way > 0 and not JumpTools.NeedHide(slot0.cfg_.obtain_way, slot0.curSceneID_) and not JumpTools.GetLinkIsLocked(slot0.cfg_.obtain_way)
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	slot1 = manager.time:GetServerTime()
	slot0.time_.text = manager.time:GetLostTimeStr2(HomeSceneSettingData:GetSceneTimeStamp(slot0.curSceneID_))
	slot0.timer_ = Timer.New(function ()
		if uv0 and uv1 <= uv0 then
			uv2.time_.text = manager.time:GetLostTimeStr2(uv0)
		else
			HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[1])
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.RefreshRedPoint(slot0)
	slot1 = slot0.curSceneID_

	saveData("scene", tostring(slot1), 0)
	manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. slot1, 0)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.AddClickTimer(slot0)
	slot0:StopClickTimer()

	slot0.buttonUp_ = 0
	slot0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		if Input.GetMouseButtonUp(0) then
			uv0.buttonUp_ = uv0.buttonUp_ + 1

			if uv0.buttonUp_ >= 2 then
				for slot3, slot4 in ipairs(HomeSceneTagCfg.all) do
					if uv0["effectTgl_" .. slot4] then
						uv0["effectTgl_" .. slot4].isOn = false
					end
				end

				uv0:HideMessage()

				if uv0.clickTimer_ then
					FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

					uv0.clickTimer_ = nil
				end
			end
		end
	end, -1, true)
end

function slot0.StopClickTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.CheckPlayBgm(slot0)
	slot2 = HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()]

	if slot2.default_music ~= 0 and slot0.settingData_.home_scene_scene_bgm == 1 and table.indexof(slot2.scene_setting, HomeSceneSettingConst.SETTING.SCENE_BGM) then
		IllustratedAction.QuerySetBgm(slot4)
	end
end

function slot0.OnHomeSceneChange(slot0)
	slot0:RefreshUI()
end

function slot0.OnHomeSceneSettingChange(slot0, slot1, slot2)
	if slot2.key == "allData" then
		slot0:RefreshSoundEffect()
		slot0:RefreshCameraFollow()
	elseif slot2.key == "home_scene_sound_effect" then
		slot0:RefreshSoundEffect()
	elseif slot2.key == "home_scene_camera_follow" then
		slot0:RefreshCameraFollow()
	elseif slot2.key == "home_scene_scene_bgm" then
		slot0:RefreshSceneBgm()
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		gameContext:Go("/home", nil, , true)
	end)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end

	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
