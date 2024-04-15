slot0 = class("PosterGirlDlcActor", PosterGirlBaseActor)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)
	manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

	slot0.playable_list = {}

	slot0:Init()

	slot3, slot4 = PosterGirlTools.GetLoadLightEffect(slot0.view_direct, slot0.view_direct)

	if slot3 then
		manager.ui:SetSceneLightEffect(slot4)
	end

	slot0:UpdateCameraParams()
end

function slot0.Init(slot0)
	slot0.view_direct = PosterGirlConst.ViewDirect.center
end

function slot0.LoadModel(slot0)
	uv0.super.LoadModel(slot0)

	if slot0.tpose.transform:Find("camera") then
		slot0.cameraManager_ = slot1:GetComponent("CharacterCameraManager")
	else
		slot0.cameraManager_ = nil
	end
end

function slot0.GetHeroPosAndRotCfg(slot0)
	return HeroPosAndRotCfg[slot0.skinId * 100]
end

function slot0.GetTag(slot0)
	return PosterGirlConst.PosterGirlTag.t0
end

function slot0.CheckDebut(slot0)
	if HomeSceneSettingData:GetIsPlay(slot0.skinId) then
		return false
	end

	slot0:ChangeState(PosterGirlConst.StateKay.debut)

	return true
end

function slot0.SkipDebut(slot0)
	if not slot0:GetCurrentState() or slot1:GetStateKey() ~= PosterGirlConst.StateKay.debut then
		return false
	end

	slot0:ChangeState(PosterGirlConst.StateKay.init, true)

	return true
end

function slot0.CheckInitState(slot0)
	return slot0:GetCurrentState() and slot1:GetStateKey() == PosterGirlConst.StateKay.init or false
end

function slot0.InitTouchHelp(slot0, slot1)
	slot0.cameraManager_.touchHelper = slot1
end

function slot0.TouchHelpIdle(slot0)
	slot0.cameraManager_:TweenToDefaultCameraPos()
end

function slot0.TouchHelpSingleDrag(slot0, slot1, slot2)
	if not slot0:CheckInitState() then
		return
	end

	slot0.cameraManager_:RotateCamera(slot1, slot2)
end

function slot0.TouchHelpMutiDrag(slot0, slot1)
	if slot1 > (GameSetting.delta_to_zoom and GameSetting.delta_to_zoom.value[1] or 10) then
		slot0.cameraManager_:SetActiveCamera(1)
	elseif slot1 < -1 * slot2 then
		slot0.cameraManager_:SetActiveCamera(0)
	end
end

function slot0.SetSelfCamera(slot0, slot1)
	if slot1 == -1 then
		slot0.cameraManager_:RemoveActiveCamera()
	else
		slot0.cameraManager_:SetActiveCamera(slot1)
	end

	slot0:ResetCameraPos()
end

function slot0.ResetCameraPos(slot0)
	slot0.cameraManager_:ResetCameraDefaultCfg()
end

function slot0.UpdateCameraParams(slot0)
	slot0.cameraManager_:SetCameraParams(0)
	slot0:SetSelfCamera(0)
end

function slot0.MuteCamera(slot0, slot1)
	SetActive(slot0.cameraManager_.gameObject, not slot1)
end

function slot0.GetState(slot0, slot1)
	if slot0._states[slot1] then
		return slot0._states[slot1]
	end

	if PosterGirlTools.ProduceDlcState(slot1, slot0) ~= nil then
		slot2:SetStateKey(slot1)

		slot0._states[slot1] = slot2

		return slot2
	end
end

function slot0.GetInteractionCfg(slot0)
	return HeroTools:GetUnlockInteractionCfg(slot0.skinId)
end

function slot0.DoShacking(slot0)
	if not slot0:CheckInitState() or PosterGirlConst.ViewDirect.center ~= slot0.view_direct then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.shake)
end

function slot0.DoTouch(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.touch)
end

function slot0.DoQuickTouch(slot0)
	if not slot0:CheckInitState() or PosterGirlConst.ViewDirect.center ~= slot0.view_direct then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.quickclick)
end

function slot0.DoShowing(slot0)
	if not slot0:CheckInitState() or PosterGirlConst.ViewDirect.center ~= slot0.view_direct then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.show)
end

function slot0.DoInit(slot0, slot1)
	if slot1 == PosterGirlConst.ViewTag.home then
		slot0:ChangeState(PosterGirlConst.StateKay.init)
	else
		slot0:ChangeState(PosterGirlConst.StateKay.init_spec, true)
	end
end

function slot0.DoIdle(slot0)
	if not slot0:CheckInitState() then
		return
	end

	slot0:ChangeState(PosterGirlConst.StateKay.idle)
end

function slot0.GetPlayable(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.playable_list) do
		if slot1 == slot6.name then
			return slot6.playable, slot6.timeLintGo
		end
	end

	slot2, slot3 = slot0:CreatPlayable(slot1)

	if slot2 then
		table.insert(slot0.playable_list, {
			name = slot1,
			timeLintGo = slot3,
			playable = slot2
		})
	end

	if #slot0.playable_list > 2 then
		Object.Destroy(table.remove(slot0.playable_list, 1).timeLintGo)
	end

	return slot2, slot3
end

function slot0.CreatPlayable(slot0, slot1)
	if Object.Instantiate(Asset.Load(string.format("UITimeLine/Charactor/%s/%s", tostring(slot0.skinId), slot1)), slot0.tpose.transform):GetComponent("PlayableDirector") then
		for slot11 = 0, slot5.playableAsset.outputTrackCount - 1 do
			if slot5:GetGenericBinding(slot6:GetOutputTrack(slot11)) == nil then
				if string.sub(slot12.name, 1, 1) == "@" then
					slot15 = nil

					if slot0.tpose.transform:Find(string.sub(slot12.name, 2)) == nil then
						if GameObject.Find(slot14) ~= nil then
							slot15 = slot17:GetComponent(typeof(Animator))
						end
					else
						slot15 = slot16:GetComponent(typeof(Animator))
					end

					if slot15 ~= nil then
						slot5:SetGenericBinding(slot12, slot15)
					end
				elseif slot13 == "#" then
					slot15 = nil

					if slot0.tpose.transform:Find(string.sub(slot12.name, 2)):GetComponent("CharacterEffect") ~= nil then
						slot5:SetGenericBinding(slot12, slot15)
					end
				elseif slot13 == "&" then
					slot15 = nil

					if slot0.tpose.transform:Find(string.sub(slot12.name, 2)):GetComponent("CriLipsExPlayer") ~= nil then
						slot5:SetGenericBinding(slot12, slot15)
					end
				end
			end
		end
	end

	return slot5, slot4
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.playable_list) do
		Object.Destroy(slot5.timeLintGo)
	end

	uv0.super.Dispose(slot0)
end

return slot0
