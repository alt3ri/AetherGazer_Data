slot0 = singletonClass("LoadSceneMgr")

function slot0.Ctor(slot0)
	slot0.loadScenePool_ = {}
	slot0.isLoading_ = false
	slot0.loadInit_ = SceneLoadAndUnloadManager.Instance
end

function slot0.GetNeedLoadSceneName(slot0, slot1)
	slot2 = nil

	for slot6 = #slot1, 1, -1 do
		if ViewConst.NEED_CHANGE_SCENE_URL_LIST[slot1[slot6]] then
			slot7, slot8 = slot0:GetShouldLoadSceneName(slot1[slot6])

			if not slot0.loadScenePool_[slot1[slot6]] or slot0:IsNeedLoadScene(slot1[slot6], slot8) then
				return slot1[slot6], slot1[slot6]
			end
		end
	end

	return nil, slot2
end

function slot0.ForceSetShouldLoadSceneName(slot0, slot1, slot2)
	if not ViewConst.NEED_CHANGE_SCENE_URL_LIST[slot1] then
		if slot2 then
			slot2()
		end

		return
	end

	slot3, slot4 = slot0:GetShouldLoadSceneName(slot1)

	if slot4 == slot0.loadScenePool_[slot1] then
		if slot2 then
			slot2()
		end

		return
	end

	slot0:TryStopSceneSoundEffect(slot1)
	SetForceShowQuanquan(true)

	slot0.isLoading_ = true

	slot0.loadInit_:ChangeScene(slot3, slot0.loadScenePool_[slot1], function ()
		uv0.isLoading_ = false

		uv0:SetLoadSceneTable(uv1, uv2)
		SetForceShowQuanquan(false)

		if uv3 then
			uv3()
		end
	end)
end

function slot0.SetShouldLoadSceneName(slot0, slot1)
	if not ViewConst.NEED_CHANGE_SCENE_URL_LIST[slot1] then
		return
	end

	slot2, slot3 = slot0:GetShouldLoadSceneName(slot1)

	if slot3 == slot0.loadScenePool_[slot1] then
		return
	end

	slot0:TryStopSceneSoundEffect(slot1)

	slot0.isLoading_ = true

	slot0.loadInit_:ChangeScene(slot2, slot0.loadScenePool_[slot1], function ()
		uv0.isLoading_ = false

		uv0:SetLoadSceneTable(uv1, uv2)
	end)
end

function slot0.SetLoadSceneTable(slot0, slot1, slot2)
	slot0.loadScenePool_[slot1] = slot2

	if slot1 == "sectionSelectHero" then
		return
	end

	slot3 = nil

	if SceneManager.GetSceneByName(slot2).rootCount > 0 then
		slot3 = SceneManager.GetSceneByName(slot2):GetRootGameObjects()
	end

	if slot3 ~= nil then
		for slot7 = 0, slot3.Length - 1 do
			if slot3[slot7].name == slot2 then
				SetActive(slot3[slot7], false)
			end
		end
	end
end

function slot0.GetShouldLoadSceneName(slot0, slot1)
	slot2 = ""
	slot3 = ""

	if slot1 == "home" or slot1 == "chat" or slot1 == "userinfo" or slot1 == "clubBoss" then
		slot2 = "Levels/" .. slot0:GetHomeShouldLoadSceneName()
	elseif slot1 == "homePreview" then
		slot2 = "Levels/" .. slot0:GetPreviewHomeShouldLoadSceneName()
	elseif slot1 == "sectionSelectHero" then
		slot3 = "X104"
		slot2 = "Levels/X104"
	else
		error("未实现界面场景获取途径")
	end

	slot0:DealCommonScene(slot1)

	return slot2, slot3
end

function slot0.GetShouldLoadSceneNameID(slot0, slot1)
	if slot1 == "home" or slot1 == "chat" or slot1 == "userinfo" or slot1 == "clubBoss" then
		return HomeSceneSettingData:GetCurScene()
	elseif slot1 == "homePreview" then
		return HomeSceneSettingData:GetPreviewScene()
	elseif slot1 == "sectionSelectHero" then
		return -1
	else
		error("未实现界面场景获取途径")
	end
end

function slot0.DealCommonScene(slot0, slot1)
	if not table.indexof({
		"home",
		"homePreview",
		"userinfo",
		"chat",
		"clubBoss"
	}, slot1) then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7 ~= slot1 and slot0.loadScenePool_[slot7] then
			slot0.loadScenePool_[slot1] = slot0.loadScenePool_[slot7]
			slot0.loadScenePool_[slot7] = nil
		end
	end
end

function slot0.IsNeedLoadScene(slot0, slot1, slot2)
	if not table.indexof({
		"home",
		"homePreview",
		"userinfo",
		"chat",
		"clubBoss"
	}, slot1) then
		return slot0.loadScenePool_[slot1] ~= slot2
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot0.loadScenePool_[slot8] and slot0.loadScenePool_[slot8] ~= slot2 then
			return true
		end
	end

	return false
end

function slot0.CanEnd(slot0)
	return not slot0.isLoading_
end

function slot0.GetHomeShouldLoadSceneName(slot0, slot1)
	slot3 = HomeSceneSettingCfg[slot1 or HomeSceneSettingData:GetCurScene()]

	if not slot1 and HomeSceneSettingData:GetUsedState(slot2) == SceneConst.HOME_SCENE_TYPE.LOCK then
		slot2 = GameSetting.home_sence_default.value[1]
		slot3 = HomeSceneSettingCfg[slot2]

		HomeSceneSettingAction.SetHomeScene(slot2)
	end

	slot4 = manager.time:GetServerTime()
	slot5 = ""
	slot6 = ""
	slot7 = ""

	for slot11, slot12 in ipairs(slot3.impact) do
		if slot12 == SceneConst.HOME_SCENE_IMPACT.WEATHER then
			slot5 = slot0:GetWeatherScene()
		elseif slot12 == SceneConst.HOME_SCENE_IMPACT.DATA then
			slot6 = slot0:GetDataScene()
		elseif slot12 == SceneConst.HOME_SCENE_IMPACT.TIME then
			slot7 = slot0:GetTimeScene(manager.time:STimeDescS(slot4, "!%H"))
		end
	end

	return slot3.prefix .. slot5 .. slot6 .. slot7
end

function slot0.GetWeatherScene(slot0)
	return ""
end

function slot0.GetDataScene(slot0)
	return ""
end

function slot0.GetTimeScene(slot0, slot1)
	slot2 = tonumber(slot1)

	for slot7, slot8 in ipairs(HomeSceneCfg.get_id_list_by_type[SceneConst.HOME_SCENE_IMPACT.TIME]) do
		slot9 = HomeSceneCfg[slot8]

		if slot9.start_time <= slot2 and slot2 <= slot9.end_time then
			return slot9.scene
		end
	end

	return ""
end

function slot0.GetPreviewHomeShouldLoadSceneName(slot0)
	slot1, slot2 = HomeSceneSettingData:GetPreviewScene()
	slot3 = HomeSceneSettingCfg[slot1]
	slot4 = slot3.impact
	slot5 = ""
	slot6 = ""
	slot7 = ""

	for slot11, slot12 in ipairs(slot3.impact) do
		if slot12 == SceneConst.HOME_SCENE_IMPACT.WEATHER then
			slot5 = slot2.weather
		elseif slot12 == SceneConst.HOME_SCENE_IMPACT.DATA then
			slot6 = slot2.data
		elseif slot12 == SceneConst.HOME_SCENE_IMPACT.TIME then
			slot7 = slot2.time
		end
	end

	return slot3.prefix .. slot5 .. slot6 .. slot7
end

function slot0.SetHomeSceneSoundEffect(slot0)
	if not table.indexof(HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()].scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
		return
	end

	if not (SettingData:GetHomeSceneSettingData().home_scene_sound_effect == 1) then
		manager.audio:PlayEffect("ui_scene", "ui_scene_x201_stop", "")
	end
end

function slot0.SetPreviewHomeSceneSoundEffect(slot0)
	slot1, slot2 = HomeSceneSettingData:GetPreviewScene()

	if not table.indexof(HomeSceneSettingCfg[slot1].scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
		return
	end

	if not (SettingData:GetHomeSceneSettingData().home_scene_sound_effect == 1) then
		manager.audio:PlayEffect("ui_scene", "ui_scene_x201_stop", "")
	end
end

function slot0.TryStopSceneSoundEffect(slot0, slot1)
	if HomeSceneSettingCfg[slot0:GetShouldLoadSceneNameID(slot1)] then
		if not table.indexof(slot3.scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
			slot0:StopSceneSoundEffect()
		end
	else
		slot0:StopSceneSoundEffect()
	end
end

function slot0.StopSceneSoundEffect(slot0)
	manager.audio:PlayEffect("ui_scene", "ui_scene_x201_stop", "")
end

function slot0.Dispose(slot0)
	slot0.loadScenePool_ = {}
end

return slot0
