local var_0_0 = {}

function var_0_0.CreateClassDic()
	var_0_0.classDicCreatedFlag = true
	var_0_0.proxyClassDic = {
		[BattleConst.STAGE_TYPE_NEW.ABYSS] = AbyssSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX] = ActivityMatrixSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE] = ActivityRaceSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS] = ActivityWorldBossSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST] = AdvanceTestSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA] = AttributeArenaSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE] = BossChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE] = BossChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY] = GuildActivitySelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP] = GuildActivitySPSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = GuildBossSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = GuildBossSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME] = KagutsuchiSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL] = MythicFinalSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC] = MythicSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS] = NewWarChessSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE] = PushBoxSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.SLAYER] = SlayerSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE] = SoloChallengeSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX] = StrategyMatrixSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER] = XH3rdWaterSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE] = ActivityHeroEnhanceSelectHeroProxy,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION] = CoreVerificationSelectHeroProxy
	}
end

function var_0_0.GetProxy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.GetProxyClass(arg_2_0.sectionType)

	arg_2_1 = arg_2_1 or ReserveTools.GetReserveParams(arg_2_0.sectionType, arg_2_0.section, arg_2_0.activityID)
	arg_2_2 = arg_2_2 or HeroConst.HERO_DATA_TYPE.DEFAULT

	return var_2_0.New(arg_2_0, arg_2_1, arg_2_2)
end

function var_0_0.GetProxyClass(arg_3_0)
	if not var_0_0.classDicCreatedFlag then
		var_0_0.CreateClassDic()
	end

	if not arg_3_0 then
		return SelectHeroBaseProxy
	end

	return var_0_0.proxyClassDic[arg_3_0] or SelectHeroBaseProxy
end

function var_0_0.ReloadView(arg_4_0, arg_4_1)
	if arg_4_0.__cname ~= arg_4_1.__cname then
		local var_4_0 = arg_4_0.gameObject_
		local var_4_1 = arg_4_0.transform_.parent
		local var_4_2 = Object.Instantiate(var_4_0, var_4_1)
		local var_4_3 = arg_4_1.New(var_4_2, var_4_1)

		arg_4_0:Dispose()

		return var_4_3
	else
		return arg_4_0
	end
end

var_0_0.HeroTransform = {
	{
		position = Vector3(500, 0, 0),
		rotation = Vector3(0, 0, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(501.5, 0, -2.9),
		rotation = Vector3(0, -16.419, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(498.5, 0, -2.9),
		rotation = Vector3(0, 9.932, 0),
		scale = Vector3(1, 1, 1)
	}
}

local var_0_1 = 400
local var_0_2 = var_0_0.HeroTransform[2].position.z - var_0_0.HeroTransform[1].position.z
local var_0_3 = var_0_0.HeroTransform[2].position.x - var_0_0.HeroTransform[1].position.x

function var_0_0.GetModelOffesetPosition(arg_5_0, arg_5_1)
	local var_5_0 = Vector3(0, 0, 0)
	local var_5_1 = arg_5_1.x - arg_5_0.x

	if var_5_1 > 0 then
		var_5_0.x = -var_5_1 * var_0_3 / var_0_1
		var_5_0.z = var_5_1 * var_0_2 / var_0_1
	else
		var_5_0.x = -var_5_1 * var_0_3 / var_0_1
		var_5_0.z = -var_5_1 * var_0_2 / var_0_1
	end

	return var_5_0
end

function var_0_0.SetCurSelectHeroData(arg_6_0)
	var_0_0.curSelectHeroData = arg_6_0
end

function var_0_0.GetCurSelectHeroData()
	return var_0_0.curSelectHeroData
end

return var_0_0
