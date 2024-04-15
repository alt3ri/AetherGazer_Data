local var_0_0 = class("SectionComboSkillEquipBreakThroughView", import("..SectionComboSkillView"))

function var_0_0.ClickComboSkillBtn(arg_1_0)
	JumpTools.OpenPageByJump("comboSkillSelectEquipBreakThrough", {
		stageType = arg_1_0.stageType_,
		stageID = arg_1_0.stageID_,
		bossIndex = arg_1_0.bossIndex_,
		heroList = arg_1_0.heroList_,
		comboSkillID = arg_1_0.comboSkillID_
	})
end

function var_0_0.SetHeroList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	var_0_0.super.SetHeroList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0:SetComboSkillID(arg_2_0.comboSkillID_)
end

function var_0_0.GetComboSkillID(arg_3_0)
	local var_3_0 = EquipBreakThroughMaterialData:GetComboSkillID()

	return var_3_0 ~= -1 and var_3_0 or var_0_0.super.GetComboSkillID(arg_3_0)
end

return var_0_0
