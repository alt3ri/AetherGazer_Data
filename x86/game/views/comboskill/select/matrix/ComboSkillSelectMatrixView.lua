local var_0_0 = class("ComboSkillSelectMatrixView", import("..ComboSkillSelectView"))

function var_0_0.GetComboSkillList(arg_1_0)
	return ComboSkillTools.GetComboSkillList(arg_1_0.heroList_, false)
end

function var_0_0.GetComboSkillItemView(arg_2_0)
	return ComboSkillSelectMatrixItem
end

return var_0_0
