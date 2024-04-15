slot1 = class("PolyhedronComboSkillSelectView", import("game.views.sectionSelectHero.SectionComboSelectView"))

function slot1.SetComboSkillID(slot0, slot1)
	BattleFieldAction.SetComboInfo(slot0.stageType_, slot0.params_.activityID, slot1, 0, 0)
end

return slot1
