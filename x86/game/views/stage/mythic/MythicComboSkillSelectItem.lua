local var_0_0 = class("MythicComboSkillSelectItem", ComboSkillSelectItem)

function var_0_0.SetTeamID(arg_1_0, arg_1_1)
	arg_1_0.teamID_ = arg_1_1
end

function var_0_0.ShowSelect(arg_2_0, arg_2_1)
	if MythicData:GetIsBattleIng() then
		arg_2_0.selectBtnController_:SetSelectedState("unclick")
	elseif arg_2_1 then
		arg_2_0.selectBtnController_:SetSelectedState("current")
	elseif arg_2_0.canUse_ then
		arg_2_0.selectBtnController_:SetSelectedState("change_1")
	else
		arg_2_0.selectBtnController_:SetSelectedState("unclick")
	end
end

return var_0_0
