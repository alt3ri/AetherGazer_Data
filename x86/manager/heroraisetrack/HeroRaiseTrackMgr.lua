local var_0_0 = class("HeroRaiseTrackMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.view_ui = nil
	arg_1_0.view_data = nil
	arg_1_0.isForce = false
	arg_1_0.brain = nil
	arg_1_0.last_view_ui = nil
	arg_1_0.last_view_data = nil
	arg_1_0.skinID = nil
	arg_1_0.track = nil
	arg_1_0.raiseModel = nil
	arg_1_0.needTalk = nil
	arg_1_0.displayGo_ = nil
	arg_1_0.servantTrackController = nil
	arg_1_0.astrolableController = nil

	arg_1_0:Init()

	arg_1_0.sceneTxAni_ = nil
	arg_1_0.breakFx_ = nil
end

function var_0_0.Init(arg_2_0)
	arg_2_0.view_ui = HeroRaiseTrackConst.ViewType.null
	arg_2_0.view_data = {}
	arg_2_0.isForce = false
	arg_2_0.brain = nil
	arg_2_0.last_view_ui = HeroRaiseTrackConst.ViewType.null
	arg_2_0.last_view_data = {}
	arg_2_0.skinID = nil
	arg_2_0.track = HeroRaiseTrack.New()
	arg_2_0.raiseModel = HeroRaiseModel.New()
	arg_2_0.astrolableController = NormalAstrolabe.New()
	arg_2_0.needTalk = false
end

function var_0_0.SetModelState(arg_3_0, arg_3_1)
	local var_3_0 = false

	if not arg_3_0.skinID or arg_3_0.skinID ~= arg_3_1 then
		arg_3_0.skinID = arg_3_1
		arg_3_0.needTalk = true

		arg_3_0:RefreshTrackState()
		arg_3_0:RefreshCameraState()
		arg_3_0:RemainAni()
		arg_3_0:RefreshTouchHero()
		arg_3_0:RefreshSceneAni()
	end
end

function var_0_0.SetViewState(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = false

	if arg_4_1 and arg_4_0.view_ui ~= arg_4_1 then
		arg_4_0.last_view_ui = arg_4_0.view_ui
		arg_4_0.view_ui = arg_4_1
		var_4_0 = true
	end

	if arg_4_2 then
		if not arg_4_2[3] then
			arg_4_2[3] = 0
		end

		if arg_4_0.view_data[1] ~= arg_4_2[1] or arg_4_0.view_data[2] ~= arg_4_2[2] or arg_4_0.view_data[3] ~= arg_4_2[3] then
			if arg_4_2[1] then
				if arg_4_0.view_data then
					arg_4_0.last_view_data[1] = arg_4_0.view_data[1] or nil
				end

				arg_4_0.view_data[1] = arg_4_2[1]
				var_4_0 = true
			end

			if arg_4_2[2] then
				if arg_4_0.view_data then
					arg_4_0.last_view_data[2] = arg_4_0.view_data[2] or nil
				end

				arg_4_0.view_data[2] = arg_4_2[2]
				var_4_0 = true
			end

			if arg_4_2[3] then
				if arg_4_0.view_data then
					arg_4_0.last_view_data[3] = arg_4_0.view_data[3] or nil
				end

				arg_4_0.view_data[3] = arg_4_2[3]
				var_4_0 = true
			else
				arg_4_0.last_view_data[3] = arg_4_0.view_data[3] or nil
				arg_4_0.view_data[3] = 0
			end
		end
	end

	if var_4_0 then
		arg_4_0:RefreshCameraState()
		arg_4_0:RefreshAni()
		arg_4_0:RefreshSceneAni()
	end

	if arg_4_3 then
		arg_4_0:RefreshTouchView(arg_4_3)
		arg_4_0:RefreshTouchHero()
	else
		arg_4_0:RefreshTouchView(nil)
	end
end

function var_0_0.CheckEffect(arg_5_0)
	if arg_5_0.view_data and arg_5_0.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		local var_5_0 = arg_5_0.view_data[1]

		if var_5_0 == HeroRaiseTrackConst.HeroRaiseType.attr or var_5_0 == HeroRaiseTrackConst.HeroRaiseType.skill then
			arg_5_0.raiseModel:PlayEffect()
		end
	end
end

function var_0_0.PlayTalk(arg_6_0)
	if arg_6_0.raiseModel then
		arg_6_0.raiseModel:PlayTalk()
	end
end

function var_0_0.RefreshTrackState(arg_7_0)
	local var_7_0 = SkinCfg[arg_7_0.skinID].hero
	local var_7_1 = HeroPosAndRotCfg[var_7_0]
	local var_7_2 = var_7_1.hero_view_height

	arg_7_0.raiseModel:SetSkinID(arg_7_0.skinID)
	arg_7_0.raiseModel:PlayEffect()
	arg_7_0.track:SetTrackData(var_7_1.hero_view_height)
end

function var_0_0.RefreshTouchView(arg_8_0, arg_8_1)
	if isNil(arg_8_1) then
		if arg_8_0.touchView_ then
			arg_8_0.touchView_:Dispose()

			arg_8_0.touchView_ = nil
		end

		return
	end

	if arg_8_0.touchView_ then
		arg_8_0.touchView_:Dispose()

		arg_8_0.touchView_ = nil
	end

	arg_8_0.touchView_ = HeroRaiseModelToucherView.New(arg_8_1)
end

function var_0_0.RefreshTouchHero(arg_9_0)
	if arg_9_0.touchView_ then
		local var_9_0 = arg_9_0.raiseModel:GetRotateGo()

		if var_9_0 then
			arg_9_0.touchView_:SetRotateNode(var_9_0.transform)
		end
	end
end

function var_0_0.RefreshAstrolabeColor(arg_10_0, arg_10_1)
	local var_10_0 = manager.ui:GetSceneSettingBySceneName("X100")

	if var_10_0 then
		if arg_10_1 then
			arg_10_0:CreateTimer(var_10_0, ASTROLABE_COLOR[1], ASTROLABE_COLOR[2], ASTROLABE_COLOR[3])
		else
			arg_10_0:CreateTimer(var_10_0, 1, 1, 1)
		end
	end
end

function var_0_0.CreateTimer(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	arg_11_0:RemoveTween()

	local var_11_0 = arg_11_1.probeLightingBase.r
	local var_11_1 = arg_11_1.probeLightingBase.g
	local var_11_2 = arg_11_1.probeLightingBase.b

	arg_11_0.tweenValue_ = LeanTween.value(0, 1, ASTROLABE_COLOR_TIME):setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
		localR = Mathf.Lerp(var_11_0, arg_11_2, arg_12_0)
		localG = Mathf.Lerp(var_11_1, arg_11_3, arg_12_0)
		localB = Mathf.Lerp(var_11_2, arg_11_4, arg_12_0)
		arg_11_1.probeLightingBase = Color.New(localR, localG, localB)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_11_0:RemoveTween()
	end))
end

function var_0_0.RemoveTween(arg_14_0)
	if arg_14_0.tweenValue_ then
		arg_14_0.tweenValue_:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_14_0.tweenValue_.id)

		arg_14_0.tweenValue_ = nil
	end
end

function var_0_0.RefreshCameraState(arg_15_0)
	if not arg_15_0.view_ui then
		return
	end

	if isNil(arg_15_0.brain) then
		arg_15_0.brain = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))
	end

	local var_15_0 = arg_15_0.raiseModel:SetSkinID(arg_15_0.skinID)

	if arg_15_0.view_ui == HeroRaiseTrackConst.ViewType.null then
		arg_15_0:UnloadSceneAni()
		arg_15_0:UnloadWeaponServant()

		if not isNil(arg_15_0.brain) then
			arg_15_0.brain.m_CustomBlends = nil
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", false)
		manager.ui:ResetMainCamera()
		arg_15_0.track:SetActive(false)
		arg_15_0:SetAstrolableAtive(false)

		arg_15_0.lastState_ = HeroRaiseTrackConst.ModelState.none

		arg_15_0.raiseModel:UnloadModel()

		arg_15_0.view_ui = HeroRaiseTrackConst.ViewType.null
		arg_15_0.view_data = {}
		arg_15_0.last_view_ui = HeroRaiseTrackConst.ViewType.null
		arg_15_0.last_view_data = {}
		arg_15_0.needTalk = false
	elseif arg_15_0.view_ui == HeroRaiseTrackConst.ViewType.heroRaiseCommon then
		arg_15_0:LoadSceneAni()

		if not isNil(arg_15_0.brain) and isNil(arg_15_0.brain.m_CustomBlends) then
			arg_15_0.brain.m_CustomBlends = Asset.Load("UI/HeroCamera/CameraData/MainCamera_Blends.asset")
		end

		manager.ui:SetMainCameraCom("CinemachineBrain", true)
		manager.ui:SetMainCamera("hero")
		arg_15_0.track:SetActive(true)

		if arg_15_0.view_data then
			local var_15_1 = arg_15_0.view_data[1] * 10 + arg_15_0.view_data[2] or 10
			local var_15_2 = arg_15_0.view_data[1]
			local var_15_3 = arg_15_0.view_data[3] or 0

			arg_15_0.track:ChangeCamera(var_15_1)

			local var_15_4 = false
			local var_15_5 = false

			if var_15_2 == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if var_15_3 ~= HeroRaiseTrackConst.HeroServantType.weapon then
					var_15_4 = true
				else
					var_15_5 = true
				end
			end

			if var_15_4 then
				arg_15_0:LoadWeaponServant()
			else
				arg_15_0:UnloadWeaponServant(var_15_5)
			end

			arg_15_0.lastState_ = arg_15_0.raiseModel:GetState()

			if var_15_2 == HeroRaiseTrackConst.HeroRaiseType.attr then
				arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_15_2 == HeroRaiseTrackConst.HeroRaiseType.skill then
				arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_15_2 == HeroRaiseTrackConst.HeroRaiseType.weapon then
				if var_15_3 == HeroRaiseTrackConst.HeroServantType.servant then
					arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
				else
					arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.weapon)
				end
			elseif var_15_2 == HeroRaiseTrackConst.HeroRaiseType.equip then
				arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
			elseif var_15_2 == HeroRaiseTrackConst.HeroRaiseType.transition then
				arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.none)
			elseif var_15_2 == HeroRaiseTrackConst.HeroRaiseType.astrolabe then
				arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			elseif var_15_2 == HeroRaiseTrackConst.HeroRaiseType.chip then
				arg_15_0.raiseModel:SetState(HeroRaiseTrackConst.ModelState.hero)
			end

			if HeroRaiseTrackConst.HeroRaiseRotate[var_15_1] then
				arg_15_0:PlayModelRotation(HeroRaiseTrackConst.HeroRaiseRotate[var_15_1])
			else
				arg_15_0:PlayModelRotation()
			end
		end
	end
end

function var_0_0.RemainAni(arg_16_0)
	if arg_16_0.raiseModel:GetState() == HeroRaiseTrackConst.ModelState.hero and arg_16_0.view_data and arg_16_0.view_data[1] and arg_16_0.view_data[2] then
		local var_16_0 = arg_16_0.view_data[1] * 10 + arg_16_0.view_data[2] or 10

		arg_16_0.raiseModel:SwitchAni("", HeroRaiseTrackConst.HeroAniName[var_16_0])
	end
end

function var_0_0.RefreshAni(arg_17_0)
	arg_17_0.raiseModel:ResetBlendShapes()

	if arg_17_0.view_data and arg_17_0.view_data[1] and arg_17_0.view_data[2] then
		if arg_17_0.breakFx_ == nil then
			arg_17_0.breakFx_ = HeroRaiseCameraTx.New()

			arg_17_0.breakFx_:Init("UI/HeroGodHood/TX_Property_Break_01.prefab")
		end

		local var_17_0 = arg_17_0.view_data[1] * 10 + arg_17_0.view_data[2] or 10
		local var_17_1 = 0

		if arg_17_0.last_view_data and arg_17_0.last_view_data[1] and arg_17_0.last_view_data[2] then
			var_17_1 = arg_17_0.last_view_data[1] * 10 + arg_17_0.last_view_data[2] or 0
		end

		if var_17_0 == 12 then
			arg_17_0.breakFx_:PlayAnim("TX_Property_Break_star")
		elseif var_17_1 == 12 then
			arg_17_0.breakFx_:PlayAnim("TX_Property_Break_end")
		end

		local var_17_2 = {}

		if (var_17_0 ~= 12 or var_17_1 ~= 21) and (var_17_0 ~= 21 or var_17_1 ~= 12) then
			table.insert(var_17_2, HeroRaiseTrackConst.HeroAniName[var_17_1] or "")
			table.insert(var_17_2, HeroRaiseTrackConst.HeroAniName[var_17_0] or "")
			arg_17_0.raiseModel:SwitchAni(var_17_2[1], var_17_2[2])
		elseif var_17_0 == 12 and var_17_1 == 21 then
			arg_17_0.raiseModel:RemainAni(HeroRaiseTrackConst.HeroAniName[21])
		end
	elseif arg_17_0.breakFx_ then
		arg_17_0.breakFx_:Dispose()

		arg_17_0.breakFx_ = nil
	end
end

function var_0_0.RefreshSceneAni(arg_18_0)
	if arg_18_0.view_data and arg_18_0.view_data[1] and arg_18_0.view_data[2] then
		local var_18_0 = arg_18_0.view_data[1] * 10 + arg_18_0.view_data[2] or 10
		local var_18_1 = 0

		if arg_18_0.last_view_data and arg_18_0.last_view_data[1] and arg_18_0.last_view_data[2] then
			var_18_1 = arg_18_0.last_view_data[1] * 10 + arg_18_0.last_view_data[2] or 0
		end

		if var_18_0 == 10 or var_18_0 == 20 then
			if var_18_1 ~= 10 and var_18_1 ~= 20 then
				arg_18_0:PlaySceneAni("TX_Property_Corrector_star1")
			else
				arg_18_0:PlaySceneAni("TX_Property_Corrector_stand")
			end
		elseif var_18_1 ~= 10 and var_18_1 ~= 20 then
			arg_18_0:PlaySceneAni("TX_Property_Corrector_hide")
		else
			arg_18_0:PlaySceneAni("TX_Property_Corrector_end1")
		end
	end
end

function var_0_0.RemainSceneAni(arg_19_0)
	if arg_19_0.view_data and arg_19_0.view_data[1] and arg_19_0.view_data[2] then
		local var_19_0 = arg_19_0.view_data[1] * 10 + arg_19_0.view_data[2] or 10

		if var_19_0 == 10 or var_19_0 == 20 then
			arg_19_0:PlaySceneAni("TX_Property_Corrector_stand")
		end
	end
end

function var_0_0.PlaySceneAni(arg_20_0, arg_20_1)
	if isNil(arg_20_0.sceneTxAni_) then
		return
	end

	arg_20_0.sceneTxAni_:Play(arg_20_1)
	arg_20_0.sceneTxAni_:Update(0)
end

function var_0_0.LoadSceneAni(arg_21_0)
	if isNil(arg_21_0.sceneTxTrans_) then
		local var_21_0 = SceneManager.GetSceneByName("X100")
		local var_21_1 = var_21_0:GetRootGameObjects()
		local var_21_2

		if var_21_1 ~= nil then
			for iter_21_0 = 0, var_21_1.Length - 1 do
				if var_21_1[iter_21_0].name == var_21_0.name then
					var_21_2 = var_21_1[iter_21_0]

					break
				end
			end
		end

		arg_21_0.sceneTxTrans_ = var_21_2.transform:Find("X100_base_003/TX_Property_Corrector")

		if arg_21_0.sceneTxTrans_ then
			arg_21_0.sceneTxAni_ = arg_21_0.sceneTxTrans_:GetComponentInChildren(typeof(Animator))
		end
	end
end

function var_0_0.UnloadSceneAni(arg_22_0)
	arg_22_0.sceneTxTrans_ = nil
	arg_22_0.sceneTxAni_ = nil
end

function var_0_0.RemoveTween(arg_23_0)
	if arg_23_0.tween then
		arg_23_0.tween:setOnComplete(nil)
		LeanTween.cancel(arg_23_0.m_arror.gameObject)

		arg_23_0.tween = nil
	end
end

function var_0_0.PlayModelRotation(arg_24_0, arg_24_1)
	arg_24_0.node = arg_24_0.raiseModel:GetRotateGo()

	if arg_24_0.node then
		LeanTween.cancel(arg_24_0.node)

		if not isNil(arg_24_0.node) then
			if arg_24_1 then
				LeanTween.rotateLocal(arg_24_0.node, arg_24_1, HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
			else
				LeanTween.rotateLocal(arg_24_0.node, Vector3(0, 0, 0), HERO_RAISE_ROTATE_TIME):setEase(LeanTweenType.easeOutQuart)
			end
		end
	end
end

function var_0_0.SetWeaponServantID(arg_25_0, arg_25_1)
	if arg_25_0.servantTrackController then
		arg_25_0.servantTrackController:SetServantID(arg_25_1)
	end
end

function var_0_0.LoadWeaponServant(arg_26_0)
	if arg_26_0.servantTrackController and arg_26_0.servantTrackController:CheckValid() then
		return
	end

	if arg_26_0.servantTrackController then
		arg_26_0.servantTrackController:Dispose()

		arg_26_0.servantTrackController = nil
	end

	local var_26_0 = Asset.Load("UI/HeroGodHood/TX_WeaponServant.prefab")
	local var_26_1 = Object.Instantiate(var_26_0, manager.ui.mainCamera.transform)

	if not isNil(var_26_1) then
		arg_26_0.servantTrackController = ServantTrackController.New()

		arg_26_0.servantTrackController:Init(var_26_1)
	end
end

function var_0_0.PlayServantAnim(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_0.servantTrackController then
		arg_27_0.servantTrackController:PlayAnim(arg_27_1, arg_27_2)
	end
end

function var_0_0.UnloadWeaponServant(arg_28_0, arg_28_1)
	if arg_28_0.servantTrackController then
		if arg_28_1 then
			arg_28_0:PlayServantAnim("Fade")
		else
			arg_28_0.servantTrackController:Dispose()

			arg_28_0.servantTrackController = nil
		end
	end
end

function var_0_0.UnloadAstrolabe(arg_29_0)
	if arg_29_0.astrolableController then
		arg_29_0.astrolableController:Dispose()
	end
end

function var_0_0.SetAstrolableAtive(arg_30_0, arg_30_1)
	if arg_30_0.astrolableController then
		arg_30_0.astrolableController:SetActive(arg_30_1)

		if not arg_30_1 then
			arg_30_0:RefreshAstrolableState(AstrolabeConst.AnimationState.Hide)
		end
	end
end

function var_0_0.RefreshAstrolableState(arg_31_0, arg_31_1)
	if arg_31_0.astrolableController then
		arg_31_0.astrolableController:RefreshAnimationState(arg_31_1)
	end
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.track then
		arg_32_0.track:Dispose()
	end

	if arg_32_0.raiseModel then
		arg_32_0.raiseModel:Dispose()
	end

	if arg_32_0.touchView_ then
		arg_32_0.touchView_:Dispose()
	end

	if arg_32_0.breakFx_ then
		arg_32_0.breakFx_:Dispose()

		arg_32_0.breakFx_ = nil
	end

	arg_32_0:UnloadSceneAni()
	arg_32_0:UnloadAstrolabe()
	arg_32_0:RemoveTween()

	arg_32_0.view_ui = HeroRaiseTrackConst.ViewType.null
	arg_32_0.view_data = {}
	arg_32_0.isForce = false
	arg_32_0.brain = nil
	arg_32_0.last_view_ui = HeroRaiseTrackConst.ViewType.null
	arg_32_0.last_view_data = {}
	arg_32_0.skinID = nil
	arg_32_0.needTalk = false
	arg_32_0.sceneTxAni_ = nil
end

return var_0_0
