local var_0_0 = class("ReservesComboSkillSelectItem", ComboSkillSelectItem)

function var_0_0.RefreshUI(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.comboSkillID_ = arg_1_1
	arg_1_0.heroList_ = arg_1_3
	arg_1_0.index_ = arg_1_4

	local var_1_0 = arg_1_1 == 0

	if not var_1_0 then
		arg_1_0:RefreshInfo()
	end

	arg_1_0.canUse_ = arg_1_0:CanUse()

	SetActive(arg_1_0.goEmpty_, var_1_0)
	SetActive(arg_1_0.goInfo_, not var_1_0)
	arg_1_0:ShowSelect(arg_1_2)
end

function var_0_0.ClickBtn(arg_2_0)
	BattleTeamData:ChangeComboSkillID(arg_2_0.index_, arg_2_0.comboSkillID_)
end

return var_0_0
