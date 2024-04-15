local var_0_0 = class("ComboSkillSelectSequentialBattleItem", import("..ComboSkillSelectItem"))

function var_0_0.ClickBtn(arg_1_0)
	local var_1_0 = table.keyof(SequentialBattleChapterCfg[arg_1_0.activityID_].stage_id, arg_1_0.stageID_)

	SequentialBattleData:SetComboSkillID(arg_1_0.activityID_, var_1_0, arg_1_0.comboSkillID_, false)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_1_0.comboSkillID_)
end

return var_0_0
