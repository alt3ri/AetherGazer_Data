slot0 = class("PosterGirlBaseActor")

function slot0.Ctor(slot0, slot1, slot2)
	slot0.skinId = slot1
	slot0.modelId = slot2
	slot0.tpose = nil
	slot0.ui_topse = nil

	slot0:LoadModel()

	slot0._currentState = nil
	slot0._inTransition = nil
	slot0._states = {}
end

function slot0.GetSkinId(slot0)
	return slot0.skinId
end

function slot0.GetModelId(slot0)
	return slot0.modelId
end

function slot0.GetTag(slot0)
	return PosterGirlConst.PosterGirlTag.null
end

function slot0.GetViewDirect(slot0)
	return 0
end

function slot0.LoadModel(slot0)
	slot0.tpose = manager.resourcePool:Get("Char/" .. slot0.modelId, ASSET_TYPE.TPOSE)
	slot0.ui_topse = slot0.tpose.transform:Find(string.format("%dui/%dui_tpose", slot0.skinId, slot0.skinId))
	slot2 = SkinCfg[slot0.skinId]

	if slot0.ui_topse then
		HeroTools.SetHeroModelWeaponActivity(slot0.ui_topse, slot2.home_weapon_show and slot2.home_weapon_show ~= 0)
	end
end

function slot0.PlayHeroTalk(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot0.tpose then
		slot4 = slot0.tpose.transform
	end

	HeroTools.PlayTalk(slot1, slot2, slot3, slot4)

	if HeroVoiceCfg.get_id_list_by_file[slot2] then
		manager.notify:Invoke(HOME_POSTER_TALK, slot1, slot6, manager.audio:GetVoiceLength(string.format("vo_sys_%d", slot1), string.format("v_s_%d_%s", slot1, slot2), string.format("vo_sys_%d.awb", slot1)))
	end
end

function slot0.UpdateViewTag(slot0, slot1)
	slot2 = nil

	if PosterGirlConst.ViewTag.home == slot1 then
		slot2 = "main"
	elseif PosterGirlConst.ViewTag.chat == slot1 then
		slot2 = "chat"
	elseif PosterGirlConst.ViewTag.playerInfo == slot1 or PosterGirlConst.ViewTag.playerInfo_other == slot1 then
		slot2 = "playerInfo"
	else
		error("UpdateViewParams")

		return
	end

	slot3 = slot0:GetHeroPosAndRotCfg()
	slot4 = slot3["position_" .. slot2]
	slot5 = slot3["rotation_" .. "main"]
	slot6 = slot3["scale_" .. "main"]
	slot7 = slot3.offset
	slot8 = Vector3.one

	if slot1 ~= PosterGirlConst.ViewTag.playerInfo_other then
		if HomeSceneSettingData:GetCurScene() and slot3["position_scene_" .. slot9] then
			slot4 = slot3["position_scene_" .. slot9]
		end

		if slot9 and slot3["rotation_scene_" .. slot9] then
			slot5 = slot3["rotation_scene_" .. slot9]
		end
	end

	if slot2 == "chat" or slot2 == "playerInfo" then
		slot9 = Screen.safeArea
		slot0.tpose.transform.localPosition = Vector3.New(slot4[1], slot4[2], slot4[3]) + Vector3(slot7 * slot9.width / slot9.height / 1.7777777777777777, 0, 0)
		slot8 = GameSetting.chat_model_rotation.value
	else
		slot0.tpose.transform.localPosition = Vector3.New(slot4[1], slot4[2], slot4[3])
	end

	if (slot2 == "chat" or slot2 == "playerInfo") and (slot0:GetViewDirect() == 0 or manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.playerInfo) then
		slot0.tpose.transform.localEulerAngles = Vector3.New(slot5[1] + slot8[1], slot5[2] + slot8[2], slot5[3] + slot8[3])
	else
		slot0.tpose.transform.localEulerAngles = Vector3.New(slot5[1], slot5[2], slot5[3])
	end

	slot0.tpose.transform.localScale = Vector3.New(slot6[1], slot6[2], slot6[3])

	slot0:ResetTpose()
end

function slot0.GetHeroPosAndRotCfg(slot0)
	return HeroPosAndRotCfg[SkinCfg[slot0.skinId].hero]
end

function slot0.ResetTpose(slot0)
	if slot0.tpose.transform:Find(slot0.skinId .. "ui") then
		slot1.localEulerAngles = Vector3.zero
	end

	if slot0.tpose.transform:Find(string.format("%dui/%dui_tpose", slot0.skinId, slot0.skinId)) then
		slot2.localEulerAngles = Vector3.zero
	end
end

function slot0.ResetBlendShapes(slot0)
	manager.resourcePool:ResetBlendShapes(slot0.tpose.transform)
end

function slot0.EnableEyeController(slot0, slot1)
	LuaForUtil.EnableEyeController(slot0.ui_topse.transform, slot1)
end

function slot0.GetCurrentState(slot0)
	return slot0._currentState
end

function slot0.ChangeState(slot0, slot1, slot2)
	slot3 = slot0:GetState(slot1)

	if slot2 == nil then
		slot2 = false
	end

	if slot3 then
		slot0:Transition(slot3, slot2)
	end
end

function slot0.Transition(slot0, slot1, slot2)
	if slot0._currentState == slot1 or slot0._inTransition then
		return
	end

	slot0._inTransition = true

	if slot0._currentState ~= nil then
		slot0._currentState:Exit(slot2)
	end

	slot0._currentState = slot1

	if slot0._currentState ~= nil then
		slot0._currentState:Enter()
	end

	slot0._inTransition = false
end

function slot0.GetState(slot0, slot1)
	return nil
end

function slot0.Dispose(slot0)
	if slot0._currentState then
		slot0._currentState:Exit(true)
	end

	slot0._currentState = nil

	if slot0.tpose then
		manager.resourcePool:DestroyOrReturn(slot0.tpose, ASSET_TYPE.TPOSE)
	end

	slot0.tpose = nil
	slot0.ui_topse = nil
end

function slot0.InitTouchHelp(slot0, slot1)
end

function slot0.TouchHelpIdle(slot0)
end

function slot0.TouchHelpSingleDrag(slot0, slot1, slot2)
end

function slot0.TouchHelpMutiDrag(slot0, slot1)
end

function slot0.CheckInitState(slot0)
	return slot0:GetCurrentState() and slot1:GetStateKey() == PosterGirlConst.StateKay.init or false
end

function slot0.CheckDebut(slot0)
	return false
end

function slot0.SkipDebut(slot0)
	return false
end

function slot0.IsPlayingDebut(slot0)
	return slot0:GetCurrentState() and slot1:GetStateKey() == PosterGirlConst.StateKay.debut or false
end

function slot0.GetInteractionCfg()
	return nil
end

function slot0.DoShacking(slot0)
end

function slot0.DoTouch(slot0)
end

function slot0.DoQuickTouch(slot0)
end

function slot0.DoShowing(slot0)
end

function slot0.DoGreeting(slot0)
end

function slot0.DoIdle(slot0)
end

function slot0.DoInit(slot0, slot1)
end

return slot0
