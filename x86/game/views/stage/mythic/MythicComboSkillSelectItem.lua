slot0 = class("MythicComboSkillSelectItem", ComboSkillSelectItem)

function slot0.SetTeamID(slot0, slot1)
	slot0.teamID_ = slot1
end

function slot0.ShowSelect(slot0, slot1)
	if MythicData:GetIsBattleIng() then
		slot0.selectBtnController_:SetSelectedState("unclick")
	elseif slot1 then
		slot0.selectBtnController_:SetSelectedState("current")
	elseif slot0.canUse_ then
		slot0.selectBtnController_:SetSelectedState("change_1")
	else
		slot0.selectBtnController_:SetSelectedState("unclick")
	end
end

return slot0
