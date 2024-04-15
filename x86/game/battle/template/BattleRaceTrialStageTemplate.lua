local var_0_0 = class("BattleRaceTrialStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg_ = BattleRaceTrialStageCfg[ActivityRaceTrialCfg[arg_1_1].stage_id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.id_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.RACE_TRIAL
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg_.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg_.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg_.monster_level
end

function var_0_0.GetStageAffix(arg_9_0)
	local var_9_0
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}
	local var_9_4 = RaceTrialData:GetCustomList(arg_9_0.activityID_)

	for iter_9_0, iter_9_1 in ipairs(var_9_4) do
		local var_9_5 = ActivityAffixPoolCfg[iter_9_1].affix

		table.insert(var_9_1, var_9_5[1])
		table.insert(var_9_2, var_9_5[2])
		table.insert(var_9_3, var_9_5[3])
	end

	return var_9_1, var_9_2, var_9_3
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetMaxRaceData(arg_11_0)
	return ActivityRaceTrialCfg[arg_11_0.id_].race, 3
end

return var_0_0
