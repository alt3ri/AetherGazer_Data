slot0 = class("HeroRaiseModel")

function slot0.Ctor(slot0)
	slot0.skinID = nil
	slot0.modelID = nil
	slot0.weaponID = nil
	slot0.heroLoaded = false
	slot0.tpose = nil
	slot0.ui_tpose = nil
	slot0.weaponLoaded = false
	slot0.weapon_tpose = nil
	slot0.state = HeroRaiseTrackConst.ModelState.none
	slot0.lastState = HeroRaiseTrackConst.ModelState.none
	slot0.animator_ = nil
	slot0.lastAni_ = HeroRaiseTrackConst.HeroAniName[21]
	slot0.rotateGo_ = nil
	slot0.weapon_rotateGo_ = nil
	slot0.talkTimer_ = nil
end

function slot0.PlayTalk(slot0)
	if slot0.skinID then
		if SkinCfg[slot0.skinID] and slot1.hero then
			slot0:StopTimer()

			slot0.talkTimer_ = Timer.New(function ()
				HeroTools.PlayTalk(uv0.hero, "choose")
			end, 1)

			slot0.talkTimer_:Start()
		end
	end
end

function slot0.GetCurTransform(slot0)
	if slot0.state == HeroRaiseTrackConst.ModelState.none then
		return nil
	elseif slot0.state == HeroRaiseTrackConst.ModelState.hero then
		if slot0.tpose then
			return slot0.tpose.transform
		end
	elseif slot0.state == HeroRaiseTrackConst.ModelState.weapon and slot0.weapon_tpose then
		return slot0.weapon_tpose.transform
	end
end

function slot0.GetRotateGo(slot0)
	if slot0.state == HeroRaiseTrackConst.ModelState.none then
		return nil
	elseif slot0.state == HeroRaiseTrackConst.ModelState.hero then
		return slot0.rotateGo_
	elseif slot0.state == HeroRaiseTrackConst.ModelState.weapon then
		return slot0.weapon_rotateGo_
	end
end

function slot0.GetSkinID(slot0)
	return slot0.skinID
end

function slot0.GetModelID(slot0)
	return slot0.modelID
end

function slot0.GetWeaponID(slot0)
	return slot0.weaponID
end

function slot0.GetState(slot0)
	return slot0.state
end

function slot0.SetSkinID(slot0, slot1)
	if slot1 and slot0.skinID ~= slot1 then
		slot2 = SkinCfg[slot1]
		slot0.skinID = slot1
		slot0.modelID = slot2.modelId
		slot0.weaponID = slot2.weapon_modelId

		slot0:RefreshModel()

		return true
	end

	return false
end

function slot0.SetState(slot0, slot1)
	if slot1 ~= slot0.state then
		slot0.state = slot1

		slot0:RefreshActive()
	end
end

function slot0.PlayEffect(slot0)
	if slot0.ui_tpose then
		manager.audio:PlayUIAudioByVoice("hero_change")
		LuaForUtil.PlayEffect(slot0.ui_tpose.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
	end
end

slot1 = 0.5

function slot0.RemainAni(slot0, slot1)
	slot0.lastAni_ = slot1
end

function slot0.SwitchAni(slot0, slot1, slot2)
	if slot0.state ~= HeroRaiseTrackConst.ModelState.hero then
		return
	end

	if slot0.lastAni_ and slot0.lastAni_ ~= "" and slot1 == "" and slot2 == HeroRaiseTrackConst.HeroAniName[12] then
		slot0:PlayAni(slot0.lastAni_ .. "_2", true, nil)

		return
	end

	if slot1 == slot2 then
		return
	end

	if slot2 == "" then
		LuaForUtil.EnableEyeController(slot0.tpose.transform, true)
		manager.resourcePool:ResetBlendShapes(slot0.tpose.transform)
		slot0:RemainAni(HeroRaiseTrackConst.HeroAniName[12])

		return
	end

	if slot1 == "" then
		if slot2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
			slot0:PlayAni(slot2, slot3, nil)
		else
			slot0:PlayAni(slot2 .. "_1", slot3, function ()
				uv0:PlayAni(uv1 .. "_2", uv2, nil)
			end)
		end

		return
	end

	if slot1 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		slot0:PlayAni(slot2 .. "_1", slot3, function ()
			uv0:PlayAni(uv1 .. "_2", uv2, nil)
		end)

		return
	end

	if slot2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		slot0:PlayAni(slot1 .. "_3", slot3, function ()
			uv0:PlayAni(uv1, uv2, nil)
		end)

		return
	end

	slot0:PlayAni(slot1 .. "_3", slot3, function ()
		uv0:PlayAni(uv1 .. "_1", uv2, function ()
			uv0:PlayAni(uv1 .. "_2", uv2, nil)
		end)
	end)
end

function slot0.ResetBlendShapes(slot0)
	if slot0.ui_tpose then
		LuaForUtil.EnableEyeController(slot0.ui_tpose.transform, true)
		manager.resourcePool:ResetBlendShapes(slot0.ui_tpose.transform)
	end
end

function slot0.PlayAni(slot0, slot1, slot2, slot3)
	if slot0.animator_ then
		if slot2 then
			slot0.animator_:CrossFade(slot1, slot2 and uv0 / slot0.animator_:GetCurrentAnimatorStateInfo(0).length or 0, 0)
		else
			slot0.animator_:Play(slot1)
		end

		slot0.animator_:Update(0)
		slot0:Stop()

		slot0.timer_ = Timer.New(function ()
			if uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 - uv2 then
				uv0:Stop()

				if uv3 ~= nil then
					uv3()
				end
			end
		end, 0.033, -1)

		slot0.timer_:Start()
	end
end

function slot0.CrossFade(slot0, slot1)
	animator:CrossFade(slot1, uv0 / animator:GetCurrentAnimatorStateInfo(0).length, 0)
end

function slot0.Stop(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.GetAnimator(slot0)
	if slot0.animator_ then
		return slot0.animator_
	end

	return nil
end

function slot0.LoadHeroModel(slot0)
	if not slot0.modelID then
		return
	end

	slot1 = manager.resourcePool:Get("Char/" .. slot0.modelID, ASSET_TYPE.TPOSE)

	if not isNil(slot0.tpose) then
		manager.resourcePool:DestroyOrReturn(slot0.tpose, ASSET_TYPE.TPOSE)
	end

	slot0.tpose = slot1
	slot0.ui_tpose = slot0.tpose.transform:Find(string.format("%dui/%dui_tpose", slot0.skinID, slot0.skinID)).gameObject
	slot0.rotateGo_ = slot0.tpose.transform:Find(string.format("%dui", slot0.skinID)).gameObject
	slot0.animator_ = slot0.ui_tpose:GetComponent(typeof(Animator))

	slot0:ResetHeroModel()

	slot0.heroLoaded = true
end

function slot0.LoadWeaponModel(slot0)
	if not slot0.weaponID then
		return
	end

	if not isNil(slot0.weapon_tpose) then
		manager.resourcePool:DestroyOrReturn(slot0.weapon_tpose, ASSET_TYPE.WEAPON)
	end

	slot0.weapon_tpose = manager.resourcePool:Get("Weapon/" .. slot0.weaponID, ASSET_TYPE.WEAPON)
	slot0.weapon_rotateGo_ = slot0.weapon_tpose

	slot0:ResetWeaponModel()

	slot0.weaponLoaded = true
end

function slot0.RefreshActive(slot0)
	slot0:StopTimer()

	if slot0.state == HeroRaiseTrackConst.ModelState.none then
		slot0:Stop()
		SetActive(slot0.tpose, false)
		SetActive(slot0.weapon_tpose, false)
	elseif slot0.state == HeroRaiseTrackConst.ModelState.hero then
		if not slot0.heroLoaded then
			slot0:LoadHeroModel()
		end

		SetActive(slot0.tpose, true)
		slot0:ResetHeroModel()
		SetActive(slot0.weapon_tpose, false)
	elseif slot0.state == HeroRaiseTrackConst.ModelState.weapon then
		slot0:Stop()

		if not slot0.weaponLoaded then
			slot0:LoadWeaponModel()
		end

		SetActive(slot0.tpose, false)
		SetActive(slot0.weapon_tpose, true)
	end
end

function slot0.ResetHeroModel(slot0)
	if slot0.animator_ then
		slot0.animator_:Play("action1_1", -1, 0)
		slot0.animator_:Update(0)
	end

	if slot0.tpose then
		slot1 = slot0.tpose:GetComponent("UIPoseMoveController")
		slot2 = slot0.tpose.transform
		slot2.localPosition = slot1:GetInitPosition()
		slot2.localEulerAngles = slot1:GetInitRotation()
		slot2.localScale = Vector3(1, 1, 1)
	end
end

function slot0.ResetWeaponModel(slot0)
	slot1 = slot0.weapon_tpose.transform
	slot1.localPosition = Vector3(500, 0, 1)
	slot1.localEulerAngles = Vector3(0, 0, 0)
	slot1.localScale = Vector3(1, 1, 1)
end

function slot0.RefreshModel(slot0)
	slot0:StopTimer()

	if slot0.state == HeroRaiseTrackConst.ModelState.none then
		slot0.heroLoaded = false
		slot0.weaponLoaded = false
	elseif slot0.state == HeroRaiseTrackConst.ModelState.hero then
		slot0:LoadHeroModel()

		slot0.weaponLoaded = false
	elseif slot0.state == HeroRaiseTrackConst.ModelState.weapon then
		slot0:LoadWeaponModel()

		slot0.heroLoaded = false
	end
end

function slot0.UnloadModel(slot0)
	slot0:Stop()
	slot0:StopTimer()

	if not isNil(slot0.tpose) then
		manager.resourcePool:DestroyOrReturn(slot0.tpose, ASSET_TYPE.TPOSE)
	end

	if not isNil(slot0.weapon_tpose) then
		manager.resourcePool:DestroyOrReturn(slot0.weapon_tpose, ASSET_TYPE.WEAPON)
	end

	slot0.skinID = nil
	slot0.modelID = nil
	slot0.weaponID = nil
	slot0.heroLoaded = false
	slot0.weaponLoaded = false
	slot0.tpose = nil
	slot0.ui_tpose = nil
	slot0.weapon_tpose = nil
	slot0.animator_ = nil
	slot0.rotateGo_ = nil
	slot0.weapon_rotateGo_ = nil
end

function slot0.StopTimer(slot0)
	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0:UnloadModel()
end

return slot0
