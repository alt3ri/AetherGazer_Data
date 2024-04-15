slot0 = class("GotoCooperationStage", BattleCooperationSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoCooperationResult(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

return slot0
