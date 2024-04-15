local var_0_0 = class("HeroSkillUpgradeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/HeroSkillUpgradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.btnStateController_ = ControllerUtil.GetController(arg_5_0.upgradeGo_.transform, "btnState")
	arg_5_0.isSelfController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "isSelf")
	arg_5_0.descBtnController_ = ControllerUtil.GetController(arg_5_0.descBtnPanelGo_.transform, "btnState")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.maskBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.costIconBtn_, nil, function()
		if arg_6_0.costCfg_ then
			ShowPopItem(POP_SOURCE_ITEM, arg_6_0.costCfg_)
		end
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.upgradeBtn_.gameObject, 2, 0.4, 0.2, function()
		if SkillTools.GetIsDodgeSkill(arg_6_0.params_.skillId) or arg_6_0.level_ == HeroConst.MAX_SKILL_LEVEL then
			arg_6_0:SendSkillUpgrade()

			return false
		end

		local var_9_0 = SkillTools.GetSkillIdIndex(arg_6_0.params_.skillId)

		if SkillCfg[arg_6_0.level_]["skill_limit" .. var_9_0] > HeroData:GetHeroData(arg_6_0.params_.heroId).break_level then
			arg_6_0:SendSkillUpgrade()

			return false
		end

		if not arg_6_0.costEnough_ then
			arg_6_0:SendSkillUpgrade()
			ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

			return false
		end

		arg_6_0.tempAddLevel_ = (arg_6_0.tempAddLevel_ or 0) + 1

		arg_6_0:RefreshMessage()

		return true
	end, handler(arg_6_0, arg_6_0.SendSkillUpgrade))
	arg_6_0:AddBtnListener(arg_6_0.simpleDescBtn_, nil, function()
		arg_6_0:RefreshDesc(1)
	end)
	arg_6_0:AddBtnListener(arg_6_0.detailDescBtn_, nil, function()
		arg_6_0:RefreshDesc(2)
	end)
end

function var_0_0.SendSkillUpgrade(arg_12_0)
	if arg_12_0.tempAddLevel_ and arg_12_0.tempAddLevel_ > 0 then
		HeroAction.HeroSkillUpgrade(arg_12_0.params_.heroId, arg_12_0.params_.skillId, arg_12_0.tempAddLevel_)
	end
end

function var_0_0.GetRealSkillId(arg_13_0)
	if arg_13_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return arg_13_0.params_.skillId
	else
		return arg_13_0.heroViewProxy_:GetRealSkillId(arg_13_0.params_.heroId, arg_13_0.params_.skillId)
	end
end

function var_0_0.RefreshSkill(arg_14_0)
	arg_14_0.realSkillId_ = arg_14_0:GetRealSkillId()

	local var_14_0 = HeroSkillCfg[arg_14_0.realSkillId_]

	arg_14_0.iconImg_.sprite = getSprite("Atlas/" .. arg_14_0.params_.heroId, arg_14_0.realSkillId_)
	arg_14_0.nameText_.text = GetI18NText(var_14_0.name)

	if var_14_0.cd == 0 then
		arg_14_0.cdText_.text = " - "
	else
		arg_14_0.cdText_.text = var_14_0.cd / 1000 .. "s"
	end

	local var_14_1 = HeroCfg[arg_14_0.params_.heroId]
	local var_14_2 = table.indexof(var_14_1.skills, arg_14_0.params_.skillId)

	arg_14_0.subnameText_.text = GetI18NText(var_14_1.skill_subhead[var_14_2])

	local var_14_3 = var_14_0.element_type[1]

	arg_14_0.typeText_.text = GetI18NText(SkillElementCfg[var_14_3].name)
	arg_14_0.listSrex_.verticalNormalizedPosition = 1

	SetActive(arg_14_0.skillCostGo_, var_14_0.EnergyChange < 0)

	if var_14_0.EnergyChange < 0 then
		arg_14_0.skillCostText_.text = math.abs(var_14_0.EnergyChange) .. " " .. GetTips("NOTE_ENERGYTYPE_" .. CharactorParamCfg[arg_14_0.params_.heroId].EnergyType)
	end

	local var_14_4 = HeroConst.SKILL_SHOW_ICON[arg_14_0.realSkillId_]

	SetActive(arg_14_0.rcpPanel_, var_14_4 ~= nil)

	if var_14_4 then
		arg_14_0.rcpIcon1_.sprite = getSprite("Atlas/" .. arg_14_0.params_.heroId, var_14_4[1])
		arg_14_0.rcpIcon2_.sprite = getSprite("Atlas/" .. arg_14_0.params_.heroId, var_14_4[2])
	end

	local var_14_5 = PublicSkillCfg[arg_14_0.params_.skillId].skill_sub_type

	if var_14_5 == nil then
		var_14_5 = 0
	end

	SetActive(arg_14_0.goSkillType_, var_14_5 ~= 0)

	local var_14_6 = SkillSubTypeCfg.get_id_list_by_value[var_14_5]

	arg_14_0.textSkillType_.text = GetI18NText(SkillSubTypeCfg[var_14_6[1]].annotation)
end

function var_0_0.GetSkillLv(arg_15_0)
	if not arg_15_0.skillLevel_ or arg_15_0.skillLevel_ == 0 then
		arg_15_0.skillLevel_ = arg_15_0.heroViewProxy_:GetSkillLv(arg_15_0.params_.heroId, arg_15_0.params_.skillId)
	end

	return arg_15_0.skillLevel_ + (arg_15_0.tempAddLevel_ or 0)
end

function var_0_0.RefreshMessage(arg_16_0)
	local var_16_0 = arg_16_0.heroViewProxy_:GetHeroData(arg_16_0.params_.heroId)

	arg_16_0.level_ = arg_16_0:GetSkillLv()
	arg_16_0.addEquipSkillLv_ = 0
	arg_16_0.addEquipSkillLv_ = arg_16_0.heroViewProxy_:GetTransitionAddLevel(var_16_0.id, arg_16_0.id_)
	arg_16_0.addSkillLv_ = HeroTools.GetHeroSkillAddLevel(var_16_0, arg_16_0.params_.skillId)

	if SkillTools.GetIsDodgeSkill(arg_16_0.params_.skillId) then
		arg_16_0.addSkillLv_ = 0
	end

	if arg_16_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
		arg_16_0.level_ = 1
		arg_16_0.addSkillLv_ = 0
		arg_16_0.addEquipSkillLv_ = 0

		SetActive(arg_16_0.addLvGo_, false)
	end

	if arg_16_0.addEquipSkillLv_ > 0 then
		arg_16_0.lvText_.text = string.format("<size=60>%d</size><color=#383838>+</color>", arg_16_0.level_ + arg_16_0.addSkillLv_) .. arg_16_0.addEquipSkillLv_
	else
		arg_16_0.lvText_.text = string.format("<size=60>%d</size>", arg_16_0.level_ + arg_16_0.addSkillLv_)
	end

	arg_16_0:RefreshShowType()

	local var_16_1 = arg_16_0.descType_ or 1

	arg_16_0:RefreshDesc(var_16_1)
end

function var_0_0.RefreshDesc(arg_17_0, arg_17_1)
	if arg_17_1 == 1 then
		arg_17_0.contentText_.text = GetI18NText(HeroSkillCfg[arg_17_0.realSkillId_].simpleDesc)
	else
		local var_17_0 = SkillTools.GetIsDodgeSkill(arg_17_0.params_.skillId)

		arg_17_0.contentText_.text = SkillTools.GetSkillDesc(arg_17_0.realSkillId_, arg_17_0.level_ + arg_17_0.addSkillLv_ + arg_17_0.addEquipSkillLv_, var_17_0, arg_17_0.extra_)
	end

	arg_17_0.descType_ = arg_17_1

	arg_17_0.descBtnController_:SetSelectedState(tostring(arg_17_1))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.contentText_.transform)
end

function var_0_0.RefreshShowType(arg_18_0)
	if SkillTools.GetIsDodgeSkill(arg_18_0.params_.skillId) then
		SetActive(arg_18_0.gradeGo_, false)
		SetActive(arg_18_0.costGo_, false)

		arg_18_0.upgradeBtn_.enabled = false

		arg_18_0.btnStateController_:SetSelectedState("max")

		arg_18_0.btnText_.text = GetTips("TEXT_LEVEL_MAX")

		SetActive(arg_18_0.tipGo_, false)
	elseif arg_18_0.level_ >= HeroConst.MAX_SKILL_LEVEL then
		SetActive(arg_18_0.gradeGo_, false)
		SetActive(arg_18_0.costGo_, false)

		arg_18_0.upgradeBtn_.enabled = false

		arg_18_0.btnStateController_:SetSelectedState("max")

		arg_18_0.btnText_.text = GetTips("TEXT_LEVEL_MAX")

		SetActive(arg_18_0.tipGo_, false)
	else
		local var_18_0 = SkillTools.GetSkillIdIndex(arg_18_0.params_.skillId)
		local var_18_1 = SkillCfg[arg_18_0.level_]["skill_limit" .. var_18_0]
		local var_18_2 = HeroData:GetHeroData(arg_18_0.params_.heroId)

		if var_18_1 > var_18_2.break_level then
			SetActive(arg_18_0.gradeGo_, true)

			arg_18_0.gradeText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), var_18_1)
			arg_18_0.upgradeBtn_.enabled = false

			arg_18_0.btnStateController_:SetSelectedState("false")

			arg_18_0.btnText_.text = GetTips("TEXT_UPGRADE")
		else
			SetActive(arg_18_0.gradeGo_, false)

			arg_18_0.upgradeBtn_.enabled = true

			arg_18_0.btnStateController_:SetSelectedState("true")

			arg_18_0.btnText_.text = GetTips("TEXT_UPGRADE")
		end

		SetActive(arg_18_0.costGo_, true)
		arg_18_0:RefreshCost()
		SetActive(arg_18_0.tipGo_, arg_18_0.costEnough_ and var_18_1 <= var_18_2.break_level)
	end
end

function var_0_0.RefreshCost(arg_19_0)
	if not arg_19_0.isPreview_ then
		local var_19_0 = SkillTools.GetSkillIdIndex(arg_19_0.params_.skillId)

		arg_19_0.costCfg_ = SkillCfg[arg_19_0.level_]["skill_cost" .. var_19_0][1]
		arg_19_0.costIconImg_.sprite = ItemTools.getItemLittleSprite(arg_19_0.costCfg_[1])

		local var_19_1 = ItemTools.getItemNum(arg_19_0.costCfg_[1])

		if arg_19_0.tempAddLevel_ and arg_19_0.tempAddLevel_ > 0 then
			var_19_1 = var_19_1 - SkillTools.GetSkillUpCostNum(arg_19_0.params_.skillId, arg_19_0.skillLevel_, arg_19_0.tempAddLevel_)[arg_19_0.costCfg_[1]]
		end

		if var_19_1 < arg_19_0.costCfg_[2] then
			arg_19_0.costEnough_ = false
			arg_19_0.costNumText_.text = string.format("<color=#F43950>%d</color>/%d", var_19_1, arg_19_0.costCfg_[2])
		else
			arg_19_0.costEnough_ = true
			arg_19_0.costNumText_.text = string.format("%d/%d", var_19_1, arg_19_0.costCfg_[2])
		end
	end
end

function var_0_0.OnHeroSkillUpgrade(arg_20_0, arg_20_1, arg_20_2)
	if isSuccess(arg_20_1.result) then
		ShowTips("SKILL_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", arg_20_0.level_))
		arg_20_0:PlayHeroTalk(arg_20_0.params_.heroId)
	else
		ShowTips(arg_20_1.result)
	end

	arg_20_0.skillLevel_ = nil
	arg_20_0.tempAddLevel_ = 0

	arg_20_0:RefreshMessage()
end

function var_0_0.PlayHeroTalk(arg_21_0, arg_21_1)
	if arg_21_0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_21_1, "skillup")

	arg_21_0.isTalkCD_ = true
	arg_21_0.talkCDTimer_ = Timer.New(function()
		arg_21_0.isTalkCD_ = false
	end, HeroConst.SKILL_UPGRADE_VOICE_CD, 1)

	arg_21_0.talkCDTimer_:Start()
end

function var_0_0.OnEnter(arg_23_0)
	arg_23_0.id_ = arg_23_0.params_.skillId
	arg_23_0.heroViewProxy_ = arg_23_0.params_.proxy
	arg_23_0.skillLevel_ = nil
	arg_23_0.tempAddLevel_ = 0
	arg_23_0.isNeedPlayTalk_ = true

	arg_23_0:RefreshSkill()
	arg_23_0:RefreshMessage()

	if arg_23_0.params_.hide_option then
		arg_23_0.isSelfController_:SetSelectedState("true")
	else
		arg_23_0.isSelfController_:SetSelectedState(arg_23_0.extra_ and "true" or "false")
	end
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0.descType_ = nil

	arg_24_0:StopLongClickTimer()
end

function var_0_0.Dispose(arg_25_0)
	var_0_0.super.Dispose(arg_25_0)

	if arg_25_0.talkCDTimer_ then
		arg_25_0.talkCDTimer_:Stop()

		arg_25_0.talkCDTimer_ = nil
	end

	arg_25_0.isTalkCD_ = nil
end

return var_0_0
