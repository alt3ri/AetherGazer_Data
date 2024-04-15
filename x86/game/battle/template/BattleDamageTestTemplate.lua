local var_0_0 = class("BattleDamageTestTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.damageTestId = arg_1_2
	arg_1_0.cfg = BattleDamageTestCfg[arg_1_0.id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST
end

function var_0_0.GetActivityID(arg_6_0)
	return arg_6_0.damageTestId
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = DamageTestData:GetAffixList(arg_11_0.damageTestId, BossConst.TYPE_AFFIX)

	for iter_11_0, iter_11_1 in pairs(var_11_3) do
		local var_11_4 = ActivityAffixPoolCfg[iter_11_1].affix

		table.insert(var_11_0, var_11_4[1])
		table.insert(var_11_1, var_11_4[2])
		table.insert(var_11_2, var_11_4[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.GetThreeStar(arg_12_0)
	if arg_12_0.cfg.three_star_need == "" then
		return {}
	end

	return arg_12_0.cfg.three_star_need
end

function var_0_0.GetAttributeFactor(arg_13_0)
	return Vector3.New(1.4, 1, 3.25)
end

return var_0_0
