local var_0_0 = class("SectionComboSkillBossChallengeView", import("..SectionComboSkillView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)
end

function var_0_0.SetBossIndex(arg_2_0, arg_2_1)
	arg_2_0.bossIndex_ = arg_2_1
end

function var_0_0.ClickComboSkillBtn(arg_3_0)
	JumpTools.OpenPageByJump("comboSkillSelectBoss", {
		stageType = arg_3_0.stageType_,
		stageID = arg_3_0.stageID_,
		bossIndex = arg_3_0.bossIndex_,
		heroList = arg_3_0.heroList_,
		comboSkillID = arg_3_0.comboSkillID_
	})
end

function var_0_0.GetComboSkillID(arg_4_0)
	local var_4_0 = BossTools.GetContID(arg_4_0.stageType_, arg_4_0.bossIndex_)

	return BattleTeamData:GetComboInfo(arg_4_0.stageType_, nil, var_4_0)
end

function var_0_0.SetComboSkillID(arg_5_0, arg_5_1)
	local var_5_0 = BossTools.GetContID(arg_5_0.stageType_, arg_5_0.bossIndex_)

	BattleFieldAction.SetComboInfo(arg_5_0.stageType_, nil, arg_5_1, var_5_0)
end

return var_0_0
