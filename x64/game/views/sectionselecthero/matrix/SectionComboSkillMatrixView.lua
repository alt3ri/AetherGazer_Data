local var_0_0 = class("SectionComboSkillMatrixView", import("..SectionComboSkillView"))

function var_0_0.ClickComboSkillBtn(arg_1_0)
	JumpTools.OpenPageByJump("comboSkillSelectMatrix", {
		stageType = arg_1_0.stageType_,
		stageID = arg_1_0.stageID_,
		heroList = arg_1_0.heroList_,
		comboSkillID = arg_1_0.comboSkillID_
	})
end

function var_0_0.SetHeroList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	SetActive(arg_2_0.gameObject_, true)

	arg_2_0.stageType_ = arg_2_1
	arg_2_0.stageID_ = arg_2_2
	arg_2_0.activityID_ = arg_2_3
	arg_2_0.heroList_ = arg_2_4

	local var_2_0 = arg_2_0:GetComboSkillID()
	local var_2_1 = ComboSkillTools.CheckError(var_2_0, arg_2_4, false)

	if var_2_1 ~= var_2_0 or arg_2_0:GetNeedRefresh() == true then
		var_2_1 = ComboSkillTools.GetRecommendSkillID(arg_2_4, false)

		arg_2_0:SetComboSkillID(var_2_1)
		arg_2_0:SetNeedRefresh(false)
	end

	arg_2_0.comboSkillID_ = var_2_1

	arg_2_0:RefreshUI()
end

function var_0_0.GetComboSkillID(arg_3_0)
	return ComboSkillData:GetComboSkillID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, nil, 1)
end

function var_0_0.SetComboSkillID(arg_4_0, arg_4_1)
	local var_4_0 = GetHeroTeamActivityID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX)

	BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX, var_4_0, arg_4_1)
end

function var_0_0.GetNeedRefresh(arg_5_0)
	return ComboSkillData:GetMatrixNeedRefresh()
end

function var_0_0.SetNeedRefresh(arg_6_0, arg_6_1)
	ComboSkillData:SetMatrixNeedRefresh(arg_6_1)
end

return var_0_0
