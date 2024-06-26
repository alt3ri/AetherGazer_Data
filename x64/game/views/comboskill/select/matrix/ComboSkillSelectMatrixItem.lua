slot0 = class("ComboSkillSelectMatrixItem", import("..ComboSkillSelectItem"))

function slot0.ClickBtn(slot0)
	BattleFieldAction.SetComboInfo(slot0.stageType_, GetHeroTeamActivityID(slot0.stageType_), slot0.comboSkillID_)
	manager.notify:Invoke(COMBO_SKILL_SELECT, slot0.comboSkillID_)
end

function slot0.RefreshLevelText(slot0, slot1)
	slot0.textLv_.text = GetTips("LEVEL") .. string.format("%s", ComboSkillTools.GetMatrixComboSkillLevel(slot1, slot0.heroList_))
end

return slot0
