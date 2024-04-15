local var_0_0 = class("BattleAdvanceTestStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.dest = arg_1_2.dest
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.cfg = BattleAdvanceTestStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetActivityID(arg_3_0)
	return arg_3_0.activityID_
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.dest
end

function var_0_0.GetRoleDatas(arg_5_0)
	return arg_5_0.roleDataInLua
end

function var_0_0.UpdateRoleDatas(arg_6_0, arg_6_1)
	arg_6_0.serverTeamPlayer = arg_6_1
	arg_6_0.roleDataInLua = {}

	local var_6_0 = arg_6_0:GetSystemHeroTeam()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.heroList) do
		local var_6_1 = iter_6_1.trialID ~= 0 and iter_6_1.trialID or var_6_0[iter_6_0] or 0
		local var_6_2 = BattleController.GetInstance():SetAdvanceTestHeroData(iter_6_1, var_6_1, arg_6_1.playerID, arg_6_1.level)

		table.insert(arg_6_0.roleDataInLua, var_6_2)
	end

	arg_6_0:SetMaxRaceData()
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

function var_0_0.GetStageId(arg_9_0)
	return arg_9_0.id
end

function var_0_0.GetMap(arg_10_0)
	return arg_10_0.cfg.map, false
end

function var_0_0.GetType(arg_11_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST
end

function var_0_0.GetHeroTeam(arg_12_0)
	return arg_12_0.heroList_, arg_12_0.heroTrialList_
end

return var_0_0
