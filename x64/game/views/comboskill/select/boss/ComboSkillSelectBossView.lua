local var_0_0 = class("ComboSkillSelectBossView", import("..ComboSkillSelectView"))

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	arg_1_0.bossIndex_ = arg_1_0.params_.bossIndex
end

function var_0_0.GetComboSkillItemView(arg_2_0)
	return ComboSkillSelectBossItem
end

function var_0_0.RefreshItemSelect(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.comboSkillIDList_[arg_3_1]

	arg_3_2:RefreshUI(arg_3_0.bossIndex_, arg_3_0.stageType_, arg_3_0.stageID_, arg_3_0.activityID_, var_3_0, arg_3_0.comboSkillID_ == var_3_0, arg_3_0.heroList_)
end

return var_0_0
