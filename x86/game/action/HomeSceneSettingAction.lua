manager.net:Bind(32107, function (slot0)
	HomeSceneSettingData:InitOverdueSceneList(slot0.poster_background_list or {})
end)

return {
	DealOverdueScene = function ()
		manager.net:SendWithLoadingNew(32112, {}, 32113, uv0.OnDealOverdueScene)
	end,
	OnDealOverdueScene = function (slot0, slot1)
		if not isSuccess(slot0.result) then
			ShowTips(slot0.result)
		end
	end,
	SetHomeScene = function (slot0)
		if slot0 == HomeSceneSettingData:GetCurScene() then
			return
		end

		manager.net:SendWithLoadingNew(32108, {
			poster_background_id = slot0
		}, 32109, uv0.OnSetHomeScene)
	end,
	OnSetHomeScene = function (slot0, slot1)
		if isSuccess(slot0.result) then
			HomeSceneSettingData:SetCurScene(slot1.poster_background_id)
			manager.notify:CallUpdateFunc(HOME_SCENE_CHANGE)
		else
			ShowTips(slot0.result)
		end
	end,
	CheckMatchScene = function (slot0, slot1)
		slot3 = ItemCfg[slot0].param[1]

		if SkinSceneActionCfg[HeroTools.HeroUsingSkinInfo(PlayerData:GetPlayerInfo().poster_girl).id] and (slot1 == 0 or slot1 ~= 0 and manager.time:GetServerTime() < slot1) and slot6.special_scene_id == slot3 then
			HomeSceneSettingAction.SetHomeScene(slot3)

			return true
		end

		return false
	end,
	CheckPosterSceneCanUse = function (slot0)
		return HomeSceneSettingData:GetUsedState(slot0) == SceneConst.HOME_SCENE_TYPE.TRIAL or HomeSceneSettingData:GetUsedState(slot0) == SceneConst.HOME_SCENE_TYPE.UNLOCK
	end,
	CheckMatchSkin = function (slot0)
		if slot0 ~= PlayerData:GetPlayerInfo().poster_girl then
			return
		end

		slot5 = HomeSceneSettingCfg[HomeSceneSettingData:GetRealScene()]

		if SkinSceneActionCfg[HeroTools.HeroUsingSkinInfo(slot1.poster_girl).id] and uv0.CheckPosterSceneCanUse(slot3.special_scene_id) then
			HomeSceneSettingAction.SetHomeScene(slot3.special_scene_id)

			return true
		end

		if slot5.limit_display == 0 then
			HomeSceneSettingAction.SetHomeScene(HomeSceneSettingData:GetDefaultScene())

			return true
		end

		return false
	end,
	CheckMatchPosterGirl = function (slot0)
		slot4 = HomeSceneSettingCfg[HomeSceneSettingData:GetRealScene()]

		if SkinSceneActionCfg[HeroTools.HeroUsingSkinInfo(slot0).id] and uv0.CheckPosterSceneCanUse(slot2.special_scene_id) then
			HomeSceneSettingAction.SetHomeScene(slot2.special_scene_id)

			return true
		end

		if slot4.limit_display == 0 then
			HomeSceneSettingAction.SetHomeScene(HomeSceneSettingData:GetDefaultScene())

			return true
		end

		return false
	end,
	ChangeSceneTab = function (slot0)
		if SkinSceneActionCfg[slot0] and uv0.CheckPosterSceneCanUse(slot1.special_scene_id) then
			if HomeSceneSettingData:GetRealScene() ~= slot1.special_scene_id then
				HomeSceneSettingAction.SetHomeScene(slot1.special_scene_id)
			else
				HomeSceneSettingAction.SetHomeScene(HomeSceneSettingData:GetDefaultScene())
			end
		end
	end
}
