return {
	Produce = function (slot0, slot1, slot2, slot3)
		slot4 = nil

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0 then
			slot4 = BattleChapterStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot0 then
			slot4 = BattleSubPlotStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot0 then
			slot4 = BattleDailyStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot0 then
			slot4 = BattleTowerStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot0 then
			slot4 = BattleEnchantmentStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot0 then
			slot4 = BattleEquipStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == slot0 then
			slot4 = BattleEquipBreakThroughMaterialStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE == slot0 then
			slot4 = BattleEquipSeizureStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0 then
			slot4 = BattleBossStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot0 then
			slot4 = BattleBossAdvanceStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot0 then
			slot4 = BattleMythicStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot0 then
			slot4 = BattleBaseTeachStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot0 then
			slot4 = BattleHeroTeachStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot0 then
			slot4 = BattleMatrixStageTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot0 then
			slot4 = BattleChessStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == slot0 then
			slot4 = BattleOsirisStoryStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == slot0 then
			slot4 = BattleOsirisDemonStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == slot0 then
			slot4 = BattleNewDemonStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.RACE_TRIAL == slot0 then
			slot4 = BattleRaceTrialStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == slot0 then
			slot4 = BattleHeroTrialStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == slot0 then
			slot4 = BattleSkinTrialStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SLAYER == slot0 then
			slot4 = BattleSlayerStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == slot0 then
			slot4 = BattleTowerDefenceStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == slot0 then
			slot4 = BattleParkourStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot0 then
			slot4 = BattleSoloChallengeStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == slot0 then
			slot4 = BattleArtifactStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == slot0 then
			slot4 = BattleLimitedCalculationStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == slot0 then
			slot4 = BattleSkadiLittleGameTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == slot0 then
			slot4 = BattleActivityPtGameTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == slot0 then
			slot4 = BattleGuildBossPrepareTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == slot0 then
			slot4 = BattleGuildBossChallengeTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == slot0 then
			slot4 = BattleActivityRaceStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot0 then
			slot4 = BattleMythicFinalTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == slot0 then
			slot4 = BattleGuildActivityStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP == slot0 then
			slot4 = BattleGuildActivitySPStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == slot0 then
			slot4 = BattleMardukSpecialTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot0 then
			slot4 = BattleSequentialBattleStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == slot0 then
			slot4 = BattleSurviveSoloStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == slot0 then
			slot4 = BattleActivityWorldBossTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == slot0 then
			slot4 = BattleAffixSelectTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == slot0 then
			slot4 = BattleDamageTestTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == slot0 then
			slot4 = BattleActivityPt2NormalTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == slot0 then
			slot4 = BattleActivityPt2ChallengeTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == slot0 then
			slot4 = BattleActivityPt2HardTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ABYSS == slot0 then
			slot4 = BattleAbyssTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER == slot0 then
			slot4 = BattleActivityWaterTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SAIL_GAME == slot0 then
			slot4 = BattleSailGameTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST == slot0 then
			slot4 = BattleAdvanceTestStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON == slot0 then
			slot4 = BattleSoloHeartDemonTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME == slot0 then
			slot4 = BattleDestroyBoxGameTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME == slot0 then
			slot4 = BattleActivityKagutsuchiTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL == slot0 then
			slot4 = BattleActivityPtScrollTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS == slot0 then
			slot4 = BattleNewWarChessStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == slot0 then
			slot4 = BattleActivityAttributeArenaTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE == slot0 then
			slot4 = BattlePushSnowBallSingleStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == slot0 then
			slot4 = BattlePushSnowBallTeamSurvivalStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == slot0 then
			slot4 = BattlePushSnowBallTeamBossStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN == slot0 then
			slot4 = BattleIndiaNianStageTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE == slot0 then
			slot4 = BattleActivityPushBoxTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION == slot0 then
			slot4 = BattleCoreVerificationTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 == slot0 then
			slot4 = BattleSPHeroChallengeTemplate.New(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE == slot0 then
			slot4 = BattleActivityReforgeTemplate.New(slot1, slot2)
		end

		slot4:SetReserveParams(slot3)
		slot4:Init()

		return slot4
	end,
	ProduceCooperation = function (slot0, slot1, slot2)
		slot3 = nil

		if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == slot0 then
			slot3 = BattleCooperationDemoTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == slot0 then
			slot3 = BattleCooperationStrongholdTemplate.New(slot1)
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == slot0 then
			slot3 = BattleActivityWaterCooperationTemplate.New(slot1, slot2)
		end

		return slot3
	end
}
