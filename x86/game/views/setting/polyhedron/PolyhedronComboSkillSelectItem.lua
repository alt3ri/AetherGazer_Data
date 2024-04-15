slot1 = class("PolyhedronComboSkillSelectItem", import("game.views.comboSkill.select.ComboSkillSelectItem"))

function slot1.ClickBtn(slot0)
	BattleFieldAction.SetComboInfo(slot0.stageType_, slot0.activityID_, slot0.comboSkillID_, 0, 0)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

return slot1
