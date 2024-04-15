slot0 = singletonClass("HomeSceneSettingData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = 0
slot5 = 0
slot6 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = 0
	uv3 = GameSetting.home_sence_default.value[1]
	uv4 = {}
end

function slot0.InitData(slot0, slot1, slot2)
	uv0 = slot2

	for slot7, slot8 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.SCENE_NORMAL]) do
		uv1[slot8] = {
			timestamp = 0,
			unlock = 0,
			id = slot8
		}
	end

	for slot7, slot8 in ipairs(slot1) do
		if uv1[slot8.id] then
			uv1[slot9].unlock = 1
			uv1[slot9].timestamp = slot8.lasted_time
		end
	end
end

function slot0.InitOverdueSceneList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		table.insert(uv0, {
			id = slot6.id,
			timeValid = slot6.time_valid
		})
	end
end

function slot0.DealOverdueScene(slot0)
	if uv0 and #uv0 > 0 then
		ShowTips("HOME_SCENE_TIME_INVALID")
		HomeSceneSettingAction.DealOverdueScene()

		uv0 = {}
	end
end

function slot0.SetCurScene(slot0, slot1)
	uv0 = slot1

	if HomeSceneSettingCfg[slot1].limit_display == 1 then
		slot0:SetDefaultScene(slot1)
	end
end

function slot0.SetDefaultScene(slot0, slot1)
	saveData("scene", "default_scene", slot1)
end

function slot0.GetDefaultScene(slot0)
	slot1 = GameSetting.home_sence_default.value

	return getData("scene", "default_scene") or slot1[#slot1]
end

function slot0.GetCurScene(slot0)
	if HomeSceneSettingCfg[uv0] and slot1.limit_display == 0 then
		for slot7, slot8 in ipairs(SkinSceneActionCfg.all) do
			if uv0 == SkinSceneActionCfg[slot8].special_scene_id and HeroTools.HeroUsingSkinInfo(PlayerData:GetPlayerInfo().poster_girl).id ~= slot9.skin_id then
				return slot0:GetDefaultScene()
			end
		end
	end

	return uv0
end

function slot0.GetRealScene(slot0)
	return uv0
end

function slot0.IsHaveScene(slot0, slot1)
	if slot1 == ItemCfg[slot1].param[1] then
		return slot0:GetUsedState(slot1) == SceneConst.HOME_SCENE_TYPE.UNLOCK
	else
		return slot4 == SceneConst.HOME_SCENE_TYPE.TRIAL
	end
end

function slot0.IsUnlockScene(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].unlock == 1 and uv0[slot1].timestamp == 0
	end

	return false
end

function slot0.GetUsedState(slot0, slot1)
	if slot0:IsUnlockScene(ItemCfg[slot1].param[1]) then
		return SceneConst.HOME_SCENE_TYPE.UNLOCK
	end

	if uv0[slot3] and (HomeSceneSettingCfg[slot3].scene_trial == 1 or uv0[slot3].timestamp ~= 0) and uv0[slot3].unlock == 1 then
		slot4 = HomeSceneSettingCfg[slot3]
		slot5 = slot4.trial_condition
		slot6 = not table.isEmpty(slot4.obtain_way) and not JumpTools.NeedHide(slot4.obtain_way, slot0.curSceneID_) or uv0[slot3].timestamp > 0
		slot7 = true

		if uv0[slot3].timestamp < manager.time:GetServerTime() then
			slot7 = false
		end

		if slot6 and slot7 then
			return SceneConst.HOME_SCENE_TYPE.TRIAL
		end
	end

	return SceneConst.HOME_SCENE_TYPE.LOCK
end

function slot0.UnlockScene(slot0, slot1, slot2)
	if uv0[ItemCfg[slot1].param[1]] then
		if uv0[slot4].unlock == 0 and uv0[slot4].timestamp == 0 then
			slot0:RefreshRed(slot4)
		end

		uv0[slot4].unlock = 1
		uv0[slot4].timestamp = slot2
	end
end

function slot0.RefreshRed(slot0, slot1)
	saveData("scene", tostring(slot1), 1)
	manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. slot1, 1)
end

function slot0.SetPreviewScene(slot0, slot1)
	uv0 = slot1

	for slot8 = 1, 3 do
		if not table.indexof(HomeSceneSettingCfg[slot1].impact, slot8) then
			if slot8 == 1 then
				-- Nothing
			elseif slot8 == 2 then
				slot2.data = nil
			elseif slot8 == 3 then
				slot2.time = nil
			end
		end
	end

	return {
		data = "",
		weather = "",
		time = SceneConst.HOME_SCENE_TIME.DAY,
		weather = nil
	}
end

function slot0.SetPreviewSceneParams(slot0, slot1)
	preParams = deepClone(slot1)
end

function slot0.GetPreviewScene(slot0)
	return uv0, deepClone(preParams)
end

function slot0.GetIsPlay(slot0, slot1)
	return uv0[slot1] == 1
end

function slot0.SetIsPlay(slot0, slot1, slot2)
	slot2 = slot2 and slot2 or 1
	uv0[slot1] = 1
end

function slot0.GetSceneTimeStamp(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].timestamp
	else
		return nil
	end
end

function slot0.IsNeedSceenCheck(slot0)
	slot2 = GameSetting.home_sence_default.value

	if not getData("scenePop", "sceneID_" .. slot2[#slot2]) and table.indexof(slot2, slot0:GetCurScene()) then
		return true, slot3, slot2[#slot2 - 1] or slot2[1]
	end

	saveData("scenePop", "sceneID_" .. slot3, true)

	return false, nil, 
end

return slot0
