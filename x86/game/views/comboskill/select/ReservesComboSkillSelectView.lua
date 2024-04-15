local var_0_0 = class("ReservesComboSkillSelectView", ComboSkillSelectView)

function var_0_0.RefreshItemSelect(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.comboSkillIDList_[arg_1_1]

	arg_1_2:RefreshUI(var_1_0, arg_1_0.comboSkillID_ == var_1_0, arg_1_0.heroList_, arg_1_0.index_)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.index_ = arg_2_0.params_.index
	arg_2_0.heroList_ = arg_2_0.params_.heroList
	arg_2_0.comboSkillID_ = arg_2_0.params_.comboSkillID
	arg_2_0.comboSkillIDList_ = arg_2_0:GetComboSkillList()

	arg_2_0.comboSkillUIList_:StartScroll(#arg_2_0.comboSkillIDList_, 1)
end

function var_0_0.GetComboSkillItemView(arg_3_0)
	return ReservesComboSkillSelectItem
end

return var_0_0
