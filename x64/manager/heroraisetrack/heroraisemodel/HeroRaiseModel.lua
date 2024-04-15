local var_0_0 = class("HeroRaiseModel")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.skinID = nil
	arg_1_0.modelID = nil
	arg_1_0.weaponID = nil
	arg_1_0.heroLoaded = false
	arg_1_0.tpose = nil
	arg_1_0.ui_tpose = nil
	arg_1_0.weaponLoaded = false
	arg_1_0.weapon_tpose = nil
	arg_1_0.state = HeroRaiseTrackConst.ModelState.none
	arg_1_0.lastState = HeroRaiseTrackConst.ModelState.none
	arg_1_0.animator_ = nil
	arg_1_0.lastAni_ = HeroRaiseTrackConst.HeroAniName[21]
	arg_1_0.rotateGo_ = nil
	arg_1_0.weapon_rotateGo_ = nil
	arg_1_0.talkTimer_ = nil
end

function var_0_0.PlayTalk(arg_2_0)
	if arg_2_0.skinID then
		local var_2_0 = SkinCfg[arg_2_0.skinID]

		if var_2_0 and var_2_0.hero then
			arg_2_0:StopTimer()

			arg_2_0.talkTimer_ = Timer.New(function()
				HeroTools.PlayTalk(var_2_0.hero, "choose")
			end, 1)

			arg_2_0.talkTimer_:Start()
		end
	end
end

function var_0_0.GetCurTransform(arg_4_0)
	if arg_4_0.state == HeroRaiseTrackConst.ModelState.none then
		return nil
	elseif arg_4_0.state == HeroRaiseTrackConst.ModelState.hero then
		if arg_4_0.tpose then
			return arg_4_0.tpose.transform
		end
	elseif arg_4_0.state == HeroRaiseTrackConst.ModelState.weapon and arg_4_0.weapon_tpose then
		return arg_4_0.weapon_tpose.transform
	end
end

function var_0_0.GetRotateGo(arg_5_0)
	if arg_5_0.state == HeroRaiseTrackConst.ModelState.none then
		return nil
	elseif arg_5_0.state == HeroRaiseTrackConst.ModelState.hero then
		return arg_5_0.rotateGo_
	elseif arg_5_0.state == HeroRaiseTrackConst.ModelState.weapon then
		return arg_5_0.weapon_rotateGo_
	end
end

function var_0_0.GetSkinID(arg_6_0)
	return arg_6_0.skinID
end

function var_0_0.GetModelID(arg_7_0)
	return arg_7_0.modelID
end

function var_0_0.GetWeaponID(arg_8_0)
	return arg_8_0.weaponID
end

function var_0_0.GetState(arg_9_0)
	return arg_9_0.state
end

function var_0_0.SetSkinID(arg_10_0, arg_10_1)
	if arg_10_1 and arg_10_0.skinID ~= arg_10_1 then
		local var_10_0 = SkinCfg[arg_10_1]

		arg_10_0.skinID = arg_10_1
		arg_10_0.modelID = var_10_0.modelId
		arg_10_0.weaponID = var_10_0.weapon_modelId

		arg_10_0:RefreshModel()

		return true
	end

	return false
end

function var_0_0.SetState(arg_11_0, arg_11_1)
	if arg_11_1 ~= arg_11_0.state then
		arg_11_0.state = arg_11_1

		arg_11_0:RefreshActive()
	end
end

function var_0_0.PlayEffect(arg_12_0)
	if arg_12_0.ui_tpose then
		manager.audio:PlayUIAudioByVoice("hero_change")
		LuaForUtil.PlayEffect(arg_12_0.ui_tpose.transform, "Effect/tongyong/fx_appear_UI", Vector3(0, 0, 0), Vector3(1, 1, 1), Vector3(0, 0, 0), Vector3(0, 0, 0), false, 1, 0, 0.8)
	end
end

local var_0_1 = 0.5

function var_0_0.RemainAni(arg_13_0, arg_13_1)
	arg_13_0.lastAni_ = arg_13_1
end

function var_0_0.SwitchAni(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.state ~= HeroRaiseTrackConst.ModelState.hero then
		return
	end

	local var_14_0 = true

	if arg_14_0.lastAni_ and arg_14_0.lastAni_ ~= "" and arg_14_1 == "" and arg_14_2 == HeroRaiseTrackConst.HeroAniName[12] then
		arg_14_0:PlayAni(arg_14_0.lastAni_ .. "_2", var_14_0, nil)

		return
	end

	if arg_14_1 == arg_14_2 then
		return
	end

	if arg_14_2 == "" then
		LuaForUtil.EnableEyeController(arg_14_0.tpose.transform, true)
		manager.resourcePool:ResetBlendShapes(arg_14_0.tpose.transform)
		arg_14_0:RemainAni(HeroRaiseTrackConst.HeroAniName[12])

		return
	end

	if arg_14_1 == "" then
		if arg_14_2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
			arg_14_0:PlayAni(arg_14_2, var_14_0, nil)
		else
			arg_14_0:PlayAni(arg_14_2 .. "_1", var_14_0, function()
				arg_14_0:PlayAni(arg_14_2 .. "_2", var_14_0, nil)
			end)
		end

		return
	end

	if arg_14_1 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		arg_14_0:PlayAni(arg_14_2 .. "_1", var_14_0, function()
			arg_14_0:PlayAni(arg_14_2 .. "_2", var_14_0, nil)
		end)

		return
	end

	if arg_14_2 == HeroRaiseTrackConst.HeroRaiseIdleAniName then
		arg_14_0:PlayAni(arg_14_1 .. "_3", var_14_0, function()
			arg_14_0:PlayAni(arg_14_2, var_14_0, nil)
		end)

		return
	end

	arg_14_0:PlayAni(arg_14_1 .. "_3", var_14_0, function()
		arg_14_0:PlayAni(arg_14_2 .. "_1", var_14_0, function()
			arg_14_0:PlayAni(arg_14_2 .. "_2", var_14_0, nil)
		end)
	end)
end

function var_0_0.ResetBlendShapes(arg_20_0)
	if arg_20_0.ui_tpose then
		LuaForUtil.EnableEyeController(arg_20_0.ui_tpose.transform, true)
		manager.resourcePool:ResetBlendShapes(arg_20_0.ui_tpose.transform)
	end
end

function var_0_0.PlayAni(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0.animator_ then
		local var_21_0 = arg_21_0.animator_:GetCurrentAnimatorStateInfo(0).length
		local var_21_1 = arg_21_2 and var_0_1 / var_21_0 or 0

		if arg_21_2 then
			arg_21_0.animator_:CrossFade(arg_21_1, var_21_1, 0)
		else
			arg_21_0.animator_:Play(arg_21_1)
		end

		arg_21_0.animator_:Update(0)
		arg_21_0:Stop()

		arg_21_0.timer_ = Timer.New(function()
			local var_22_0 = arg_21_0.animator_:GetCurrentAnimatorStateInfo(0)

			if var_22_0:IsName(arg_21_1) and var_22_0.normalizedTime >= 1 - var_21_1 then
				arg_21_0:Stop()

				if arg_21_3 ~= nil then
					arg_21_3()
				end
			end
		end, 0.033, -1)

		arg_21_0.timer_:Start()
	end
end

function var_0_0.CrossFade(arg_23_0, arg_23_1)
	local var_23_0 = animator:GetCurrentAnimatorStateInfo(0).length
	local var_23_1 = var_0_1 / var_23_0

	animator:CrossFade(arg_23_1, var_23_1, 0)
end

function var_0_0.Stop(arg_24_0)
	if arg_24_0.timer_ ~= nil then
		arg_24_0.timer_:Stop()

		arg_24_0.timer_ = nil
	end
end

function var_0_0.GetAnimator(arg_25_0)
	if arg_25_0.animator_ then
		return arg_25_0.animator_
	end

	return nil
end

function var_0_0.LoadHeroModel(arg_26_0)
	if not arg_26_0.modelID then
		return
	end

	local var_26_0 = manager.resourcePool:Get("Char/" .. arg_26_0.modelID, ASSET_TYPE.TPOSE)

	if not isNil(arg_26_0.tpose) then
		manager.resourcePool:DestroyOrReturn(arg_26_0.tpose, ASSET_TYPE.TPOSE)
	end

	arg_26_0.tpose = var_26_0
	arg_26_0.ui_tpose = arg_26_0.tpose.transform:Find(string.format("%dui/%dui_tpose", arg_26_0.skinID, arg_26_0.skinID)).gameObject
	arg_26_0.rotateGo_ = arg_26_0.tpose.transform:Find(string.format("%dui", arg_26_0.skinID)).gameObject
	arg_26_0.animator_ = arg_26_0.ui_tpose:GetComponent(typeof(Animator))

	arg_26_0:ResetHeroModel()

	arg_26_0.heroLoaded = true
end

function var_0_0.LoadWeaponModel(arg_27_0)
	if not arg_27_0.weaponID then
		return
	end

	if not isNil(arg_27_0.weapon_tpose) then
		manager.resourcePool:DestroyOrReturn(arg_27_0.weapon_tpose, ASSET_TYPE.WEAPON)
	end

	arg_27_0.weapon_tpose = manager.resourcePool:Get("Weapon/" .. arg_27_0.weaponID, ASSET_TYPE.WEAPON)
	arg_27_0.weapon_rotateGo_ = arg_27_0.weapon_tpose

	arg_27_0:ResetWeaponModel()

	arg_27_0.weaponLoaded = true
end

function var_0_0.RefreshActive(arg_28_0)
	arg_28_0:StopTimer()

	if arg_28_0.state == HeroRaiseTrackConst.ModelState.none then
		arg_28_0:Stop()
		SetActive(arg_28_0.tpose, false)
		SetActive(arg_28_0.weapon_tpose, false)
	elseif arg_28_0.state == HeroRaiseTrackConst.ModelState.hero then
		if not arg_28_0.heroLoaded then
			arg_28_0:LoadHeroModel()
		end

		SetActive(arg_28_0.tpose, true)
		arg_28_0:ResetHeroModel()
		SetActive(arg_28_0.weapon_tpose, false)
	elseif arg_28_0.state == HeroRaiseTrackConst.ModelState.weapon then
		arg_28_0:Stop()

		if not arg_28_0.weaponLoaded then
			arg_28_0:LoadWeaponModel()
		end

		SetActive(arg_28_0.tpose, false)
		SetActive(arg_28_0.weapon_tpose, true)
	end
end

function var_0_0.ResetHeroModel(arg_29_0)
	if arg_29_0.animator_ then
		arg_29_0.animator_:Play("action1_1", -1, 0)
		arg_29_0.animator_:Update(0)
	end

	if arg_29_0.tpose then
		local var_29_0 = arg_29_0.tpose:GetComponent("UIPoseMoveController")
		local var_29_1 = arg_29_0.tpose.transform

		var_29_1.localPosition = var_29_0:GetInitPosition()
		var_29_1.localEulerAngles = var_29_0:GetInitRotation()
		var_29_1.localScale = Vector3(1, 1, 1)
	end
end

function var_0_0.ResetWeaponModel(arg_30_0)
	local var_30_0 = arg_30_0.weapon_tpose.transform

	var_30_0.localPosition = Vector3(500, 0, 1)
	var_30_0.localEulerAngles = Vector3(0, 0, 0)
	var_30_0.localScale = Vector3(1, 1, 1)
end

function var_0_0.RefreshModel(arg_31_0)
	arg_31_0:StopTimer()

	if arg_31_0.state == HeroRaiseTrackConst.ModelState.none then
		arg_31_0.heroLoaded = false
		arg_31_0.weaponLoaded = false
	elseif arg_31_0.state == HeroRaiseTrackConst.ModelState.hero then
		arg_31_0:LoadHeroModel()

		arg_31_0.weaponLoaded = false
	elseif arg_31_0.state == HeroRaiseTrackConst.ModelState.weapon then
		arg_31_0:LoadWeaponModel()

		arg_31_0.heroLoaded = false
	end
end

function var_0_0.UnloadModel(arg_32_0)
	arg_32_0:Stop()
	arg_32_0:StopTimer()

	if not isNil(arg_32_0.tpose) then
		manager.resourcePool:DestroyOrReturn(arg_32_0.tpose, ASSET_TYPE.TPOSE)
	end

	if not isNil(arg_32_0.weapon_tpose) then
		manager.resourcePool:DestroyOrReturn(arg_32_0.weapon_tpose, ASSET_TYPE.WEAPON)
	end

	arg_32_0.skinID = nil
	arg_32_0.modelID = nil
	arg_32_0.weaponID = nil
	arg_32_0.heroLoaded = false
	arg_32_0.weaponLoaded = false
	arg_32_0.tpose = nil
	arg_32_0.ui_tpose = nil
	arg_32_0.weapon_tpose = nil
	arg_32_0.animator_ = nil
	arg_32_0.rotateGo_ = nil
	arg_32_0.weapon_rotateGo_ = nil
end

function var_0_0.StopTimer(arg_33_0)
	if arg_33_0.talkTimer_ then
		arg_33_0.talkTimer_:Stop()

		arg_33_0.talkTimer_ = nil
	end
end

function var_0_0.Dispose(arg_34_0)
	arg_34_0:StopTimer()
	arg_34_0:UnloadModel()
end

return var_0_0
