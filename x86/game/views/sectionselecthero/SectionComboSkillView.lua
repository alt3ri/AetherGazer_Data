local var_0_0 = class("SectionComboSkillView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.comboSkillController_ = ControllerUtil.GetController(arg_1_0.transform_, "teamwork")

	arg_1_0:AddBtnListener(arg_1_0.buttonComboSkill_, nil, function()
		if arg_1_0.isCustom_ then
			ShowTips("CANNOT_CHANGE_COMBO_SKILL")

			return
		end

		arg_1_0:ClickComboSkillBtn()
	end)

	arg_1_0.handler_ = handler(arg_1_0, arg_1_0.OnComboSkillSelect)

	manager.notify:RegistListener(COMBO_SKILL_SELECT, arg_1_0.handler_)
end

function var_0_0.ClickComboSkillBtn(arg_3_0)
	JumpTools.OpenPageByJump("comboSkillSelect", {
		stageType = arg_3_0.stageType_,
		stageID = arg_3_0.stageID_,
		activityID = arg_3_0.activityID_,
		heroList = arg_3_0.heroList_,
		trialList = arg_3_0.trialList_,
		comboSkillID = arg_3_0.comboSkillID_,
		reserveParams = arg_3_0.reserveParams_
	})
end

function var_0_0.RefreshUI(arg_4_0)
	if arg_4_0.comboSkillID_ == 0 then
		arg_4_0.comboSkillController_:SetSelectedState("off")
	else
		arg_4_0.comboSkillController_:SetSelectedState("on")

		local var_4_0 = ComboSkillCfg[arg_4_0.comboSkillID_]

		arg_4_0.imageSkillIcon_.sprite = getSpriteViaConfig("ComboSkill", var_4_0.skill_id)

		for iter_4_0, iter_4_1 in ipairs(var_4_0.cooperate_role_ids) do
			SetActive(arg_4_0[string.format("goHeroItem%s_", iter_4_0)], true)

			arg_4_0[string.format("imageHeroIcon%s_", iter_4_0)].sprite = getSpriteViaConfig("HeroLittleIcon", iter_4_1)
		end

		for iter_4_2 = #var_4_0.cooperate_role_ids + 1, 3 do
			SetActive(arg_4_0[string.format("goHeroItem%s_", iter_4_2)], false)
		end
	end
end

function var_0_0.SetHeroList(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_0.isCustom_ = false
	arg_5_0.stageType_ = arg_5_1
	arg_5_0.stageID_ = arg_5_2
	arg_5_0.activityID_ = arg_5_3
	arg_5_0.reserveParams_ = arg_5_7

	local var_5_0 = BattleStageTools.GetStageCfg(arg_5_1, arg_5_2)

	if var_5_0 and var_5_0.combo_skill_id and var_5_0.combo_skill_id ~= 0 then
		arg_5_0.comboSkillID_ = var_5_0.combo_skill_id

		SetActive(arg_5_0.gameObject_, true)
		arg_5_0:RefreshUI()

		arg_5_0.isCustom_ = true

		return
	end

	local var_5_1 = BattleStageTools.GetRestrictHeroList(arg_5_1, arg_5_2)

	if type(var_5_1) == "table" then
		SetActive(arg_5_0.gameObject_, false)

		arg_5_0.isCustom_ = true

		return
	end

	local var_5_2 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_4) do
		if iter_5_1 ~= 0 then
			var_5_2 = var_5_2 + 1
		end
	end

	if var_5_2 < 2 then
		SetActive(arg_5_0.gameObject_, false)
		arg_5_0:SetComboSkillID(0)

		arg_5_0.comboSkillID_ = 0

		arg_5_0:RefreshUI()

		return
	end

	SetActive(arg_5_0.gameObject_, true)

	arg_5_0.heroList_ = arg_5_4
	arg_5_0.trialList_ = arg_5_5
	arg_5_0.comboSkillID_ = arg_5_0:GetComboSkillID()

	arg_5_0:RefreshUI()
end

function var_0_0.GetComboSkillID(arg_6_0)
	return ReserveTools.GetComboSkillID(arg_6_0.reserveParams_)
end

function var_0_0.SetComboSkillID(arg_7_0, arg_7_1)
	ReserveTools.SetComboSkillID(arg_7_0.reserveParams_, arg_7_1)
end

function var_0_0.GetNeedRefresh(arg_8_0)
	return ComboSkillData:GetNeedRefresh(arg_8_0.stageType_, arg_8_0.activityID_)
end

function var_0_0.SetNeedRefresh(arg_9_0, arg_9_1)
	ComboSkillData:SetNeedRefresh(arg_9_1)
end

function var_0_0.OnComboSkillSelect(arg_10_0, arg_10_1)
	arg_10_0.comboSkillID_ = arg_10_1

	arg_10_0:RefreshUI()
end

function var_0_0.GetCurComboSkill(arg_11_0)
	return arg_11_0.comboSkillID_ or 0
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
	manager.notify:RemoveListener(COMBO_SKILL_SELECT, arg_12_0.handler_)

	arg_12_0.handler_ = nil
end

return var_0_0
