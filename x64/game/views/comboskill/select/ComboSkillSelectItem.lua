local var_0_0 = class("ComboSkillSelectItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.selectBtnController_ = ControllerUtil.GetController(arg_1_0.transformSelectBtn_, "conName")
	arg_1_0.iconController_ = {}

	for iter_1_0 = 1, 3 do
		arg_1_0.iconController_[iter_1_0] = ControllerUtil.GetController(arg_1_0[string.format("transformItem%s_", iter_1_0)], "conName")
	end

	arg_1_0:AddBtnListener(arg_1_0.buttonSelect_, nil, function()
		if arg_1_0.comboSkillID_ ~= 0 and not arg_1_0.canUse_ then
			return
		end

		arg_1_0:ClickBtn()
		arg_1_0:Back()
	end)
end

function var_0_0.ClickBtn(arg_3_0)
	ReserveTools.SetComboSkillID(arg_3_0.reserveParams_, arg_3_0.comboSkillID_)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_3_0.comboSkillID_)
end

function var_0_0.CanUse(arg_4_0)
	local var_4_0 = arg_4_0.comboSkillID_

	if var_4_0 == 0 then
		return true
	end

	local var_4_1 = ComboSkillCfg[var_4_0]

	for iter_4_0, iter_4_1 in ipairs(var_4_1.cooperate_role_ids) do
		if not table.keyof(arg_4_0.heroList_, iter_4_1) then
			return false
		end
	end

	return true
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_0.stageType_ = arg_5_1
	arg_5_0.stageID_ = arg_5_2
	arg_5_0.activityID_ = arg_5_3
	arg_5_0.comboSkillID_ = arg_5_4
	arg_5_0.heroList_ = arg_5_6
	arg_5_0.reserveParams_ = arg_5_7

	local var_5_0 = arg_5_4 == 0

	if not var_5_0 then
		arg_5_0:RefreshInfo()
	end

	arg_5_0.canUse_ = arg_5_0:CanUse()

	SetActive(arg_5_0.goEmpty_, var_5_0)
	SetActive(arg_5_0.goInfo_, not var_5_0)
	arg_5_0:ShowSelect(arg_5_5)
end

function var_0_0.RefreshInfo(arg_6_0)
	local var_6_0 = arg_6_0.comboSkillID_
	local var_6_1 = ComboSkillCfg[var_6_0]
	local var_6_2 = HeroSkillCfg[var_6_1.skill_id]

	arg_6_0:RefreshLevelText(var_6_0)

	arg_6_0.textName_.text = GetI18NText(var_6_2.name)
	arg_6_0.imageSkillIcon_.sprite = getSpriteViaConfig("ComboSkill", var_6_1.skill_id)

	for iter_6_0, iter_6_1 in ipairs(var_6_1.cooperate_role_ids) do
		SetActive(arg_6_0[string.format("transformItem%s_", iter_6_0)].gameObject, true)

		arg_6_0[string.format("imageHeroIcon%s_", iter_6_0)].sprite = getSpriteViaConfig("HeroLittleIcon", iter_6_1)

		if table.keyof(arg_6_0.heroList_, iter_6_1) then
			arg_6_0.iconController_[iter_6_0]:SetSelectedState("on")
		else
			arg_6_0.iconController_[iter_6_0]:SetSelectedState("in")
		end
	end

	for iter_6_2 = #var_6_1.cooperate_role_ids + 1, 3 do
		SetActive(arg_6_0[string.format("transformItem%s_", iter_6_2)].gameObject, false)
	end
end

function var_0_0.RefreshLevelText(arg_7_0, arg_7_1)
	local var_7_0 = ComboSkillData:GetCurComboSkillLevel(arg_7_1)

	arg_7_0.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_7_0)
end

function var_0_0.ShowSelect(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.selectBtnController_:SetSelectedState("current")
	elseif arg_8_0.canUse_ then
		arg_8_0.selectBtnController_:SetSelectedState("change_1")
	else
		arg_8_0.selectBtnController_:SetSelectedState("unclick")
	end
end

function var_0_0.OnComboSkillSelect(arg_9_0, arg_9_1)
	arg_9_0:ShowSelect(arg_9_0.comboSkillID_ == arg_9_1)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	arg_10_0.selectBtnController_ = nil
	arg_10_0.iconController_ = nil
end

return var_0_0
