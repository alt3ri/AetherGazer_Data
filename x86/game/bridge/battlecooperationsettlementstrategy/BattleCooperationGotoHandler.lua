BattleCooperationSettlementStrategyBase = require("game/bridge/BattleCooperationSettlementStrategy/BattleCooperationSettlementStrategyBase")
CooperationStageStrategyType = {
	GotoSnowBallStage = "GotoSnowBallStage",
	GotoCooperationStage = "GotoCooperationStage",
	GotoActivityWaterCooperationStage = "GotoActivityWaterCooperationStage",
	GotoStrongHoldStage = "GotoStrongHoldStage"
}

return {
	StrategyPathPrefix = "game/bridge/BattleCooperationSettlementStrategy/Impl/",
	CustomStageStrategy = {
		[BattleConst.STAGE_TYPE_NEW.STRONGHOLD] = CooperationStageStrategyType.GotoStrongHoldStage,
		[BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION] = CooperationStageStrategyType.GotoActivityWaterCooperationStage,
		[BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS] = CooperationStageStrategyType.GotoSnowBallStage,
		[BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL] = CooperationStageStrategyType.GotoSnowBallStage
	},
	Init = function (slot0)
		slot0.StrategyInstance = {}
	end,
	GetOrCreateGotoStageStartegy = function (slot0, slot1)
		slot2 = slot1 or CooperationStageStrategyType.GotoCooperationStage

		if not CooperationStageStrategyType[slot1] then
			slot2 = CooperationStageStrategyType.GotoCooperationStage
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
		slot7 = CooperationStageStrategyType.GotoCooperationStage

		if slot1:GetType() then
			slot7 = slot0.CustomStageStrategy[slot6] or CooperationStageStrategyType.GotoCooperationStage
		end

		slot0:GetOrCreateGotoStageStartegy(slot7):GotoSettlement(slot1, slot2, slot3, slot4, slot5)
	end
}
