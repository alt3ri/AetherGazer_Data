slot0 = {
	CreateClassDic = function ()
		uv0.classDicCreatedFlag = true
		uv0.proxyClassDic = {
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
	end,
	GetProxy = function (slot0, slot1, slot2)
		return uv0.GetProxyClass(slot0.sectionType).New(slot0, slot1 or ReserveTools.GetReserveParams(slot0.sectionType, slot0.section, slot0.activityID), slot2 or HeroConst.HERO_DATA_TYPE.DEFAULT)
	end,
	GetProxyClass = function (slot0)
		if not uv0.classDicCreatedFlag then
			uv0.CreateClassDic()
		end

		if not slot0 then
			return SelectHeroBaseProxy
		end

		return uv0.proxyClassDic[slot0] or SelectHeroBaseProxy
	end,
	ReloadView = function (slot0, slot1)
		if slot0.__cname ~= slot1.__cname then
			slot4 = slot0.transform_.parent

			slot0:Dispose()

			return slot1.New(Object.Instantiate(slot0.gameObject_, slot4), slot4)
		else
			return slot0
		end
	end,
	HeroTransform = {
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
}
slot1 = 400
slot2 = slot0.HeroTransform[2].position.z - slot0.HeroTransform[1].position.z
slot3 = slot0.HeroTransform[2].position.x - slot0.HeroTransform[1].position.x

function slot0.GetModelOffesetPosition(slot0, slot1)
	slot2 = Vector3(0, 0, 0)

	if slot1.x - slot0.x > 0 then
		slot2.x = -slot3 * uv0 / uv1
		slot2.z = slot3 * uv2 / uv1
	else
		slot2.x = -slot3 * uv0 / uv1
		slot2.z = -slot3 * uv2 / uv1
	end

	return slot2
end

function slot0.SetCurSelectHeroData(slot0)
	uv0.curSelectHeroData = slot0
end

function slot0.GetCurSelectHeroData()
	return uv0.curSelectHeroData
end

return slot0
