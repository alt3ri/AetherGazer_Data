slot0 = class("HeroRaiseTrackMgr")

function slot0.Ctor(slot0)
	slot0.view_ui = nil
	slot0.view_data = nil
	slot0.isForce = false
	slot0.brain = nil
	slot0.last_view_ui = nil
	slot0.last_view_data = nil
	slot0.skinID = nil
	slot0.track = nil
	slot0.raiseModel = nil
	slot0.needTalk = nil
	slot0.displayGo_ = nil
	slot0.servantTrackController = nil
	slot0.astrolableController = nil

	slot0:Init()

	slot0.sceneTxAni_ = nil
	slot0.breakFx_ = nil
end

function slot0.Init(slot0)
	slot0.view_ui = HeroRaiseTrackConst.ViewType.null
	slot0.view_data = {}
	slot0.isForce = false
	slot0.brain = nil
	slot0.last_view_ui = HeroRaiseTrackConst.ViewType.null
	slot0.last_view_data = {}
	slot0.skinID = nil
	slot0.track = HeroRaiseTrack.New()
	slot0.raiseModel = HeroRaiseModel.New()
	slot0.astrolableController = NormalAstrolabe.New()
	slot0.needTalk = false
end

function slot0.SetModelState(slot0, slot1)
	slot2 = false

	if not slot0.skinID or slot0.skinID ~= slot1 then
		slot0.skinID = slot1
		slot0.needTalk = true

		slot0:RefreshTrackState()
		slot0:RefreshCameraState()
		slot0:RemainAni()
		slot0:RefreshTouchHero()
		slot0:RefreshSceneAni()
	end
end

function slot0.SetViewState(slot0, slot1, slot2, slot3)
	slot4 = false

	if slot1 and slot0.view_ui ~= slot1 then
		slot0.last_view_ui = slot0.view_ui
		slot0.view_ui = slot1
		slot4 = true
	end

	if slot2 then
		if not slot2[3] then
			slot2[3] = 0
		end

		if slot0.view_data[1] ~= slot2[1] or slot0.view_data[2] ~= slot2[2] or slot0.view_data[3] ~= slot2[3] then
			if slot2[1] then
				if slot0.view_data then
					slot0.last_view_data[1] = slot0.view_data[1] or nil
				end

				slot0.view_data[1] = slot2[1]
				slot4 = true
			end

			if slot2[2] then
				if slot0.view_data then
					slot0.last_view_data[2] = slot0.view_data[2] or nil
				end

				slot0.view_data[2] = slot2[2]
				slot4 = true
			end

			if slot2[3] then
				if slot0.view_data then
					slot0.last_view_data[3] = slot0.view_data[3] or nil
				end

				slot0.view_data[3] = slot2[3]
				slot4 = true
			else
				slot0.last_view_data[3] = slot0.view_data[3] or nil
				slot0.view_data[3] = 0
			end
		end
	end

	if slot4 then
		slot0:RefreshCameraState()
		slot0:RefreshAni()
		slot0:RefreshSceneAni()
	end

	if slot3 then
		slot0:RefreshTouchView(slot3)
		slot0:RefreshTouchHero()
	else
		slot0:RefreshTouchView(nil)
	end
end

function slot0.CheckEffect(slot0)
	if slot0.view_data and slot0.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon and (slot0.view_data[1] == HeroRaiseTrackConst.HeroRaiseType.attr or slot1 == HeroRaiseTrackConst.HeroRaiseType.skill) then
		slot0.raiseModel:PlayEffect()
	end
end

function slot0.PlayTalk(slot0)
	if slot0.raiseModel then
		slot0.raiseModel:PlayTalk()
	end
end

function slot0.RefreshTrackState(slot0)
	slot2 = HeroPosAndRotCfg[SkinCfg[slot0.skinID].hero]
	slot3 = slot2.hero_view_height

	slot0.raiseModel:SetSkinID(slot0.skinID)
	slot0.raiseModel:PlayEffect()
	slot0.track:SetTrackData(slot2.hero_view_height)
end

function slot0.RefreshTouchView(slot0, slot1)
	if isNil(slot1) then
		if slot0.touchView_ then
			slot0.touchView_:Dispose()

			slot0.touchView_ = nil
		end

		return
	end

	if slot0.touchView_ then
		slot0.touchView_:Dispose()

		slot0.touchView_ = nil
	end

	slot0.touchView_ = HeroRaiseModelToucherView.New(slot1)
end

function slot0.RefreshTouchHero(slot0)
	if slot0.touchView_ and slot0.raiseModel:GetRotateGo() then
		slot0.touchView_:SetRotateNode(slot1.transform)
	end
end

function slot0.RefreshAstrolabeColor(slot0, slot1)
	if manager.ui:GetSceneSettingBySceneName("X100") then
		if slot1 then
			slot0:CreateTimer(slot2, ASTROLABE_COLOR[1], ASTROLABE_COLOR[2], ASTROLABE_COLOR[3])
		else
			slot0:CreateTimer(slot2, 1, 1, 1)
		end
	end
end

function slot0.CreateTimer(slot0, slot1, slot2, slot3, slot4)
	slot0:RemoveTween()

	slot5 = slot1.probeLightingBase.r
	slot6 = slot1.probeLightingBase.g
	slot7 = slot1.probeLightingBase.b
	slot0.tweenValue_ = LeanTween.value(0, 1, ASTROLABE_COLOR_TIME):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		localR = Mathf.Lerp(uv0, uv1, slot0)
		localG = Mathf.Lerp(uv2, uv3, slot0)
		localB = Mathf.Lerp(uv4, uv5, slot0)
		uv6.probeLightingBase = Color.New(localR, localG, localB)
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0:RemoveTween()
	end))
end

function slot0.RemoveTween(slot0)
	if slot0.tweenValue_ then
		slot0.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(slot0.tweenValue_.id)

		slot0.tweenValue_ = nil
	end
end

function slot0.RefreshCameraState(slot0)
	if not slot0.view_ui then
		return
	end

	if isNil(slot0.brain) then
		slot0.brain = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end

	slot1 = slot0.raiseModel:SetSkinID(slot0.skinID)

	if slot0.view_ui == HeroRaiseTrackConst.ViewType.null then
		slot0:UnloadSceneAni()
		slot0:UnloadWeaponServant()

		if not isNil(slot0.brain) then
			slot0.brain.m_CustomBlends = nil
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", false)
		manager.ui:ResetMainCamera()
		slot0.track:SetActive(false)
		slot0:SetAstrolableAtive(false)

		slot0.lastState_ = HeroRaiseTrackConst.ModelState.none

		slot0.raiseModel:UnloadModel()

		slot0.view_ui = HeroRaiseTrackConst.ViewType.null
		slot0.view_data = {}
		slot0.last_view_ui = HeroRaiseTrackConst.ViewType.null
		slot0.last_view_data = {}
		slot0.needTalk = false
	elseif slot0.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		slot0:LoadSceneAni()

		if not isNil(slot0.brain) and isNil(slot0.brain.m_CustomBlends) then
			slot0.brain.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/MainCamera_Blends.asset")
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", true)
		manager.ui:SetMainCamera("hero")
		slot0.track:SetActive(true)

		if slot0.view_data then
			slot0.track:ChangeCamera(slot0.view_data[1] * 10 + slot0.view_data[2] or 10)

			slot5 = false
			slot6 = false

			if slot0.view_data[1] == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if (slot0.view_data[3] or 0) ~= HeroRaiseTrackConst.HeroServantType.weapon then
					slot5 = true
				else
					slot6 = true
				end
			end

			if slot5 then
				slot0:LoadWeaponServant()
			else
				slot0:UnloadWeaponServant(slot6)
			end

			slot0.lastState_ = slot0.raiseModel:GetState()

			if slot3 == HeroRaiseTrackConst.HeroRaiseType.attr then
				slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif slot3 == HeroRaiseTrackConst.HeroRaiseType.skill then
				slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif slot3 == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if slot4 == HeroRaiseTrackConst.HeroServantType.servant then
					slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
				else
					slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.weapon)
				end
			elseif slot3 == HeroRaiseTrackConst.HeroRaiseType.equip then
				slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
			elseif slot3 == HeroRaiseTrackConst.HeroRaiseType.transition then
				slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
			elseif slot3 == HeroRaiseTrackConst.HeroRaiseType.astrolabe then
				slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif slot3 == HeroRaiseTrackConst.HeroRaiseType.chip then
				slot0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			end

			if HeroRaiseTrackConst.HeroRaiseRotate[slot2] then
				slot0:PlayModelRotation(HeroRaiseTrackConst.HeroRaiseRotate[slot2])
			else
				slot0:PlayModelRotation()
			end
		end
	end
end

function slot0.RemainAni(slot0)
	if slot0.raiseModel:GetState() == HeroRaiseTrackConst.ModelState.hero and slot0.view_data and slot0.view_data[1] and slot0.view_data[2] then
		slot0.raiseModel:SwitchAni("", HeroRaiseTrackConst.HeroAniName[slot0.view_data[1] * 10 + slot0.view_data[2] or 10])
	end
end

function slot0.RefreshAni(slot0)
	slot0.raiseModel:ResetBlendShapes()

	if slot0.view_data and slot0.view_data[1] and slot0.view_data[2] then
		if slot0.breakFx_ == nil then
			slot0.breakFx_ = HeroRaiseCameraTx.New()

			slot0.breakFx_:Init("UI/HeroGodHood/TX_Property_Break_01.prefab")
		end

		slot1 = slot0.view_data[1] * 10 + slot0.view_data[2] or 10
		slot2 = 0

		if slot0.last_view_data and slot0.last_view_data[1] and slot0.last_view_data[2] then
			slot2 = slot0.last_view_data[1] * 10 + slot0.last_view_data[2] or 0
		end

		if slot1 == 12 then
			slot0.breakFx_:PlayAnim("TX_Property_Break_star")
		elseif slot2 == 12 then
			slot0.breakFx_:PlayAnim("TX_Property_Break_end")
		end

		slot3 = {}

		if (slot1 ~= 12 or slot2 ~= 21) and (slot1 ~= 21 or slot2 ~= 12) then
			table.insert(slot3, HeroRaiseTrackConst.HeroAniName[slot2] or "")
			table.insert(slot3, HeroRaiseTrackConst.HeroAniName[slot1] or "")
			slot0.raiseModel:SwitchAni(slot3[1], slot3[2])
		elseif slot1 == 12 and slot2 == 21 then
			slot0.raiseModel:RemainAni(HeroRaiseTrackConst.HeroAniName[21])
		end
	elseif slot0.breakFx_ then
		slot0.breakFx_:Dispose()

		slot0.breakFx_ = nil
	end
end

function slot0.RefreshSceneAni(slot0)
	if slot0.view_data and slot0.view_data[1] and slot0.view_data[2] then
		slot1 = slot0.view_data[1] * 10 + slot0.view_data[2] or 10
		slot2 = 0

		if slot0.last_view_data and slot0.last_view_data[1] and slot0.last_view_data[2] then
			slot2 = slot0.last_view_data[1] * 10 + slot0.last_view_data[2] or 0
		end

		if slot1 == 10 or slot1 == 20 then
			if slot2 ~= 10 and slot2 ~= 20 then
				slot0:PlaySceneAni("TX_Property_Corrector_star1")
			else
				slot0:PlaySceneAni("TX_Property_Corrector_stand")
			end
		elseif slot2 ~= 10 and slot2 ~= 20 then
			slot0:PlaySceneAni("TX_Property_Corrector_hide")
		else
			slot0:PlaySceneAni("TX_Property_Corrector_end1")
		end
	end
end

function slot0.RemainSceneAni(slot0)
	if slot0.view_data and slot0.view_data[1] and slot0.view_data[2] and ((slot0.view_data[1] * 10 + slot0.view_data[2] or 10) == 10 or slot1 == 20) then
		slot0:PlaySceneAni("TX_Property_Corrector_stand")
	end
end

function slot0.PlaySceneAni(slot0, slot1)
	if isNil(slot0.sceneTxAni_) then
		return
	end

	slot0.sceneTxAni_:Play(slot1)
	slot0.sceneTxAni_:Update(0)
end

function slot0.LoadSceneAni(slot0)
	if isNil(slot0.sceneTxTrans_) then
		slot3 = nil

		if SceneManager.GetSceneByName("X100"):GetRootGameObjects() ~= nil then
			for slot7 = 0, slot2.Length - 1 do
				if slot2[slot7].name == slot1.name then
					slot3 = slot2[slot7]

					break
				end
			end
		end

		slot0.sceneTxTrans_ = slot3.transform:Find("X100_base_003/TX_Property_Corrector")

		if slot0.sceneTxTrans_ then
			slot0.sceneTxAni_ = slot0.sceneTxTrans_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function slot0.UnloadSceneAni(slot0)
	slot0.sceneTxTrans_ = nil
	slot0.sceneTxAni_ = nil
end

function slot0.RemoveTween(slot0)
	if slot0.tween then
		slot0.tween:setOnComplete(nil)
		LeanTween.cancel(slot0.m_arror.gameObject)

		slot0.tween = nil
	end
end

function slot0.PlayModelRotation(slot0, slot1)
	slot0.node = slot0.raiseModel:GetRotateGo()

	if slot0.node then
		LeanTween.cancel(slot0.node)

		if not isNil(slot0.node) then
			if slot1 then
				LeanTween.rotateLocal(slot0.node, slot1, HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
			else
				LeanTween.rotateLocal(slot0.node, Vector3(0, 0, 0), HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
			end
		end
	end
end

function slot0.SetWeaponServantID(slot0, slot1)
	if slot0.servantTrackController then
		slot0.servantTrackController:SetServantID(slot1)
	end
end

function slot0.LoadWeaponServant(slot0)
	if slot0.servantTrackController and slot0.servantTrackController:CheckValid() then
		return
	end

	if slot0.servantTrackController then
		slot0.servantTrackController:Dispose()

		slot0.servantTrackController = nil
	end

	if not isNil(Object.Instantiate(Asset.Load("UI/HeroGodHood/TX_WeaponServant.prefab"), manager.ui.mainCamera.transform)) then
		slot0.servantTrackController = ServantTrackController.New()

		slot0.servantTrackController:Init(slot2)
	end
end

function slot0.PlayServantAnim(slot0, slot1, slot2)
	if slot0.servantTrackController then
		slot0.servantTrackController:PlayAnim(slot1, slot2)
	end
end

function slot0.UnloadWeaponServant(slot0, slot1)
	if slot0.servantTrackController then
		if slot1 then
			slot0:PlayServantAnim("Fade")
		else
			slot0.servantTrackController:Dispose()

			slot0.servantTrackController = nil
		end
	end
end

function slot0.UnloadAstrolabe(slot0)
	if slot0.astrolableController then
		slot0.astrolableController:Dispose()
	end
end

function slot0.SetAstrolableAtive(slot0, slot1)
	if slot0.astrolableController then
		slot0.astrolableController:SetActive(slot1)

		if not slot1 then
			slot0:RefreshAstrolableState(AstrolabeConst.AnimationState.Hide)
		end
	end
end

function slot0.RefreshAstrolableState(slot0, slot1)
	if slot0.astrolableController then
		slot0.astrolableController:RefreshAnimationState(slot1)
	end
end

function slot0.Dispose(slot0)
	if slot0.track then
		slot0.track:Dispose()
	end

	if slot0.raiseModel then
		slot0.raiseModel:Dispose()
	end

	if slot0.touchView_ then
		slot0.touchView_:Dispose()
	end

	if slot0.breakFx_ then
		slot0.breakFx_:Dispose()

		slot0.breakFx_ = nil
	end

	slot0:UnloadSceneAni()
	slot0:UnloadAstrolabe()
	slot0:RemoveTween()

	slot0.view_ui = HeroRaiseTrackConst.ViewType.null
	slot0.view_data = {}
	slot0.isForce = false
	slot0.brain = nil
	slot0.last_view_ui = HeroRaiseTrackConst.ViewType.null
	slot0.last_view_data = {}
	slot0.skinID = nil
	slot0.needTalk = false
	slot0.sceneTxAni_ = nil
end

return slot0
