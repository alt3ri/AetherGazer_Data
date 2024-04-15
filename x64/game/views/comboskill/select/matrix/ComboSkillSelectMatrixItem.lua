local var_0_0 = class("ComboSkillSelectMatrixItem", import("..ComboSkillSelectItem"))

function var_0_0.ClickBtn(arg_1_0)
	local var_1_0 = GetHeroTeamActivityID(arg_1_0.stageType_)

	BattleFieldAction.SetComboInfo(arg_1_0.stageType_, var_1_0, arg_1_0.comboSkillID_)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_1_0.comboSkillID_)
end

function var_0_0.RefreshLevelText(arg_2_0, arg_2_1)
	local var_2_0 = ComboSkillTools.GetMatrixComboSkillLevel(arg_2_1, arg_2_0.heroList_)

	arg_2_0.textLv_.text = GetTips("LEVEL") .. string.format("%s", var_2_0)
end

return var_0_0
