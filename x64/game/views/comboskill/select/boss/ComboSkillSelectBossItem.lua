local var_0_0 = class("ComboSkillSelectBossItem", import("..ComboSkillSelectItem"))

function var_0_0.ClickBtn(arg_1_0)
	local var_1_0 = BossTools.GetContID(arg_1_0.stageType_, arg_1_0.bossIndex_)

	BattleFieldAction.SetComboInfo(arg_1_0.stageType_, nil, arg_1_0.comboSkillID_, var_1_0)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_1_0.comboSkillID_)
end

function var_0_0.RefreshUI(arg_2_0, arg_2_1, ...)
	var_0_0.super.RefreshUI(arg_2_0, ...)

	arg_2_0.bossIndex_ = arg_2_1
end

return var_0_0
