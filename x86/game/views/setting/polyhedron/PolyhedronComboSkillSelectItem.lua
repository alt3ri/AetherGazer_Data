local var_0_0 = import("game.views.comboSkill.select.ComboSkillSelectItem")
local var_0_1 = class("PolyhedronComboSkillSelectItem", var_0_0)

function var_0_1.ClickBtn(arg_1_0)
	BattleFieldAction.SetComboInfo(arg_1_0.stageType_, arg_1_0.activityID_, arg_1_0.comboSkillID_, 0, 0)
	manager.notify:Invoke(COMBO_SKILL_SELECT, arg_1_0.comboSkillID_)
end

return var_0_1
