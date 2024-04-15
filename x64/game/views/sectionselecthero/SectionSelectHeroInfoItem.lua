local var_0_0 = class("SectionSelectHeroInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.pos_ = arg_1_2

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.postController_ = arg_2_0.controllerExCollection_:GetController("post")
	arg_2_0.emptyController_ = arg_2_0.controllerExCollection_:GetController("empty")
	arg_2_0.hpController_ = arg_2_0.controllerExCollection_:GetController("HP")
	arg_2_0.assistantController_ = arg_2_0.controllerExCollection_:GetController("assistant")
	arg_2_0.powerController_ = arg_2_0.controllerExCollection_:GetController("power")
	arg_2_0.energyController_ = arg_2_0.controllerExCollection_:GetController("energy")
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.stateComtroller_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.SetProxy(arg_5_0, arg_5_1)
	arg_5_0.sectionProxy_ = arg_5_1
end

function var_0_0.OnEnter(arg_6_0, arg_6_1)
	arg_6_0:BindRedPoint()

	local var_6_0 = GameObject.Find(string.format("X104/X104_SceneSteps/X104_Formation_HeroPos_%s", arg_6_1))

	if var_6_0 then
		arg_6_0.stateComtroller_ = var_6_0:GetComponent("ControllerExCollection"):GetController("state")
	end
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0:UnBindRedPoint()
end

function var_0_0.SetData(arg_8_0, arg_8_1)
	arg_8_0.pos_ = arg_8_1
	arg_8_0.isCaptain_ = arg_8_1 == 1
	arg_8_0.heroID_ = arg_8_0.sectionProxy_.heroInfoList[arg_8_0.pos_].heroID
	arg_8_0.trialID_ = arg_8_0.sectionProxy_.heroInfoList[arg_8_0.pos_].trialID
	arg_8_0.isLock_ = arg_8_0.sectionProxy_.heroInfoList[arg_8_0.pos_].isLock

	arg_8_0:RefreshUI()
	arg_8_0:RefreshCustomUI()
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshAddBtn()

	if not arg_9_0.heroID_ or arg_9_0.heroID_ == 0 then
		arg_9_0.emptyController_:SetSelectedState("true")

		return
	else
		arg_9_0.emptyController_:SetSelectedState("false")
	end

	arg_9_0:RefershPower()
	arg_9_0:RefreshRace()
	arg_9_0:RefreshPost()
	arg_9_0:RefreshAttackType()
	arg_9_0:RefreshHP()
	arg_9_0:RefreshAssistant()
	arg_9_0:RefreshEnergy()
end

function var_0_0.RefreshCustomUI(arg_10_0)
	return
end

function var_0_0.RefershPower(arg_11_0)
	arg_11_0.powerController_:SetSelectedState(tostring(arg_11_0.sectionProxy_.needHeroPower))

	if arg_11_0.sectionProxy_.needHeroPower then
		arg_11_0:RefreshPowerUI()
	end
end

function var_0_0.RefreshPowerUI(arg_12_0)
	arg_12_0.powerText_.text = arg_12_0:GetHeroPower()
end

function var_0_0.RefreshRace(arg_13_0)
	arg_13_0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_13_0.heroID_)
end

function var_0_0.RefreshPost(arg_14_0)
	arg_14_0.postController_:SetSelectedState(tostring(arg_14_0.isCaptain_))
end

function var_0_0.RefreshAttackType(arg_15_0)
	local var_15_0 = HeroTools.GetHeroSkillAttributeIcon(arg_15_0.heroID_)

	if var_15_0 then
		SetActive(arg_15_0.attackTypeIcon_.gameObject, true)

		arg_15_0.attackTypeIcon_.sprite = var_15_0
	else
		SetActive(arg_15_0.attackTypeIcon_.gameObject, false)
	end
end

function var_0_0.RefreshAddBtn(arg_16_0)
	if arg_16_0.stateComtroller_ then
		if arg_16_0.heroID_ and arg_16_0.heroID_ ~= 0 then
			arg_16_0.stateComtroller_:SetSelectedState("selected")
		elseif arg_16_0.isLock_ == true or not arg_16_0.sectionProxy_.canChangeTeam then
			arg_16_0.stateComtroller_:SetSelectedState("lock")
		else
			arg_16_0.stateComtroller_:SetSelectedState("empty")
		end
	end
end

function var_0_0.RefreshHP(arg_17_0)
	arg_17_0.hpController_:SetSelectedState(tostring(arg_17_0.sectionProxy_.needHeroHP))

	if arg_17_0.sectionProxy_.needHeroHP then
		arg_17_0:RefreshHPUI()
	end
end

function var_0_0.RefreshHPUI(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0:GetHeroHP()

	arg_18_0.hpImg_.fillAmount = var_18_1 / 100
	arg_18_0.hpText_.text = var_18_1 .. "%"
end

function var_0_0.RefreshAssistant(arg_19_0)
	arg_19_0.assistantController_:SetSelectedState(tostring(arg_19_0.sectionProxy_.needHeroAssistant))

	if arg_19_0.sectionProxy_.needHeroAssistant then
		arg_19_0:RefreshAssistantUI()
	end
end

function var_0_0.RefreshAssistantUI(arg_20_0)
	local var_20_0 = arg_20_0.sectionProxy_.heroInfoList[arg_20_0.pos_].isAssistant

	arg_20_0.assistantController_:SetSelectedState(tostring(var_20_0))
end

function var_0_0.RefreshEnergy(arg_21_0)
	arg_21_0.energyController_:SetSelectedState(tostring(arg_21_0.sectionProxy_.needHeroEnergy))

	if arg_21_0.sectionProxy_.needHeroEnergy then
		arg_21_0:RefreshEnergyUI()
	end
end

function var_0_0.RefreshEnergyUI(arg_22_0)
	if arg_22_0.heroID_ ~= 0 then
		arg_22_0.energyController_:SetSelectedState("true")

		arg_22_0.energyText_.text = arg_22_0:GetHeroEnergy()

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_0.energyBgTrans_)
	else
		arg_22_0.energyController_:SetSelectedState("false")
	end
end

function var_0_0.BindRedPoint(arg_23_0)
	arg_23_0.sectionProxy_:CustomHeroBindRedPoint(arg_23_0.pos_, arg_23_0)
end

function var_0_0.UnBindRedPoint(arg_24_0)
	arg_24_0.sectionProxy_:CustomHeroUnBindRedPoint(arg_24_0.pos_, arg_24_0)
end

function var_0_0.GetHeroPower(arg_25_0)
	return arg_25_0.sectionProxy_:CustomGetHeroPower(arg_25_0.pos_, arg_25_0.heroID_, arg_25_0.trialID_)
end

function var_0_0.GetHeroHP(arg_26_0)
	return arg_26_0.sectionProxy_:CustomGetHeroHP(arg_26_0.pos_, arg_26_0.heroID_, arg_26_0.trialID_)
end

function var_0_0.GetHeroEnergy(arg_27_0)
	return arg_27_0.sectionProxy_:CustomGetHeroEnergy(arg_27_0.pos_, arg_27_0.heroID_, arg_27_0.trialID_)
end

return var_0_0
