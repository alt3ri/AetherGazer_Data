BattleSettlementStrategyBase = require("game/bridge/BattleSettlementStrategy/BattleSettlementStrategyBase")
StageStrategyType = {
	GotoAttributeArenaStage = "GotoAttributeArenaStage",
	GotoActivityRaceStage = "GotoActivityRaceStage",
	GotoActivityWaterStage = "GotoActivityWaterStage",
	GotoScoreStage = "GotoScoreStage",
	GotoAbyssStage = "GotoAbyssStage",
	GotoRaceTrialStage = "GotoRaceTrialStage",
	GotoSoloSurviveStage = "GotoSoloSurviveStage",
	GotoStage = "GotoStage",
	GotoSequentialBattleStage = "GotoSequentialBattleStage",
	GotoSkadiStage = "GotoSkadiStage",
	GotoSlayerStage = "GotoSlayerStage",
	GotoEquipSeizureScoreStage = "GotoEquipSeizureScoreStage",
	GotoActivityHeroEnhanceStage = "GotoActivityHeroEnhanceStage",
	GotoGuildActivityStage = "GotoGuildActivityStage",
	GotoMythicFinalStage = "GotoMythicFinalStage",
	GotoSPHeroChallengeStage = "GotoSPHeroChallengeStage",
	GotoActivityWorldBoss = "GotoActivityWorldBoss",
	GotoPushSnowBallSingleBattleStage = "GotoPushSnowBallSingleBattleStage",
	GotoSoloChallengeStage = "GotoSoloChallengeStage",
	GotoMardukSpecialStage = "GotoMardukSpecialStage",
	GotoMatrixStage = "GotoMatrixStage",
	GotoChapterStage = "GotoChapterStage",
	GotoScoreWithMaxScoreStage = "GotoScoreWithMaxScoreStage",
	GotoPolyhedronStage = "GotoPolyhedronStage",
	GotoGuildBossStage = "GotoGuildBossStage",
	GotoBossChallengeStage = "GotoBossChallengeStage",
	GotoEquipBreakThroughStage = "GotoEquipBreakThroughStage",
	GotoCoreVerificationStage = "GotoCoreVerificationStage",
	GotoActivityMatrixStage = "GotoActivityMatrixStage",
	GotoActivityReforgeStage = "GotoActivityReforgeStage",
	GotoMultipleResultStage = "GotoMultipleResultStage",
	GotoSoloHeartDemonStage = "GotoSoloHeartDemonStage",
	GotoKagutsuchiStage = "GotoKagutsuchiStage"
}

return {
	StrategyPathPrefix = "game/bridge/BattleSettlementStrategy/Impl/",
	CustomStageStrategy = {
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT] = StageStrategyType.GotoChapterStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT] = StageStrategyType.GotoChapterStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL] = StageStrategyType.GotoMultipleResultStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE] = StageStrategyType.GotoBossChallengeStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE] = StageStrategyType.GotoBossChallengeStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX] = StageStrategyType.GotoMatrixStage,
		[BattleConst.STAGE_TYPE_NEW.RACE_TRIAL] = StageStrategyType.GotoRaceTrialStage,
		[BattleConst.STAGE_TYPE_NEW.SLAYER] = StageStrategyType.GotoSlayerStage,
		[BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE] = StageStrategyType.GotoSoloChallengeStage,
		[BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION] = StageStrategyType.GotoScoreStage,
		[BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT] = StageStrategyType.GotoScoreStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD] = StageStrategyType.GotoScoreStage,
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST] = StageStrategyType.GotoScoreStage,
		[BattleConst.STAGE_TYPE_NEW.SKADI_GAME] = StageStrategyType.GotoSkadiStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX] = StageStrategyType.GotoActivityMatrixStage,
		[BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX] = StageStrategyType.GotoActivityMatrixStage,
		[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE] = StageStrategyType.GotoGuildBossStage,
		[BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE] = StageStrategyType.GotoGuildBossStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE] = StageStrategyType.GotoActivityRaceStage,
		[BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL] = StageStrategyType.GotoEquipBreakThroughStage,
		[BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE] = StageStrategyType.GotoEquipSeizureScoreStage,
		[BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL] = StageStrategyType.GotoMythicFinalStage,
		[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY] = StageStrategyType.GotoGuildActivityStage,
		[BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP] = StageStrategyType.GotoGuildActivityStage,
		[BattleConst.STAGE_TYPE_NEW.ABYSS] = StageStrategyType.GotoAbyssStage,
		[BattleConst.STAGE_TYPE_NEW.POLYHEDRON] = StageStrategyType.GotoPolyhedronStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS] = StageStrategyType.GotoActivityWorldBoss,
		[BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO] = StageStrategyType.GotoSoloSurviveStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER] = StageStrategyType.GotoActivityWaterStage,
		[BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL] = StageStrategyType.GotoMardukSpecialStage,
		[BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON] = StageStrategyType.GotoSoloHeartDemonStage,
		[BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME] = StageStrategyType.GotoScoreWithMaxScoreStage,
		[BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE] = StageStrategyType.GotoSequentialBattleStage,
		[BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE] = StageStrategyType.GotoPushSnowBallSingleBattleStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME] = StageStrategyType.GotoKagutsuchiStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA] = StageStrategyType.GotoAttributeArenaStage,
		[BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION] = StageStrategyType.GotoCoreVerificationStage,
		[BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1] = StageStrategyType.GotoSPHeroChallengeStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE] = StageStrategyType.GotoActivityReforgeStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE] = StageStrategyType.GotoActivityHeroEnhanceStage
	},
	Init = function (slot0)
		slot0.StrategyInstance = {}
		slot0.snapShot = nil
	end,
	GetOrCreateGotoStageStartegy = function (slot0, slot1)
		slot2 = slot1 or StageStrategyType.GotoStage

		if not StageStrategyType[slot1] then
			slot2 = StageStrategyType.GotoStage
		end

		if not slot0.StrategyInstance[slot2] then
			slot0.StrategyInstance[slot2] = require(slot0.StrategyPathPrefix .. slot2)

			if slot0.StrategyInstance[slot2].Init then
				slot0.StrategyInstance[slot2]:Init()
			end
		end

		return slot0.StrategyInstance[slot2]
	end,
	GotoResult = function (slot0, slot1, slot2, slot3, slot4, slot5)
		slot7 = StageStrategyType.GotoStage

		if slot1:GetType() then
			slot7 = slot0.CustomStageStrategy[slot6] or StageStrategyType.GotoStage
		end

		slot0:GetOrCreateGotoStageStartegy(slot7):GotoSettlement(slot1, slot2, slot3, slot4, slot5)
	end,
	SnapShot = function (slot0)
		slot0.snapShot = false

		if (SceneManager.sceneCount or 1) >= 2 and LuaForUtil.HasBattleWinPos() and not isNil(manager.ui.mainCamera:GetComponent("CameraExtension")) then
			slot2:CaptureSnapshot()

			slot0.snapShot = true
		end

		if not slot0.snapShot then
			slot0:ReleaseSnapShot()
		end
	end,
	GetSnapShot = function (slot0)
		return slot0.snapShot
	end,
	ReleaseSnapShot = function (slot0)
		slot0.snapShot = false

		if manager.ui.mainCamera ~= nil and not isNil(manager.ui.mainCamera) and not isNil(manager.ui.mainCamera:GetComponent("CameraExtension")) then
			slot1:FreeSnapshot()
		end
	end
}
