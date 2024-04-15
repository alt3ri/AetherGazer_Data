slot0 = class("GotoStage", BattleSettlementStrategyBase)

function slot0.Init(slot0)
	slot0.PreGotoFunc = {
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER] = handler(slot0, slot0.OnGotoTowerStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC] = handler(slot0, slot0.OnGotoMythicStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS] = handler(slot0, slot0.OnGotoChessStage),
		[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS] = handler(slot0, slot0.OnGotoNewChessStage),
		[BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE] = handler(slot0, slot0.OnGotoPushBoxStage)
	}
end

function slot0.OnGotoSettlement(slot0, slot1)
	slot2 = slot1.num
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult
	slot7 = slot3:GetStageId()

	if slot0.PreGotoFunc[slot3:GetType()] then
		slot8(slot1)
	end

	slot0:GotoStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.OnGotoTowerStage(slot0, slot1)
	slot4 = slot1.stageData:GetStageId()

	if isSuccess(slot1.num) then
		TowerData:UpdateOverTower(getChapterIDByStageID(slot4), slot4)
	end
end

function slot0.OnGotoMythicStage(slot0, slot1)
	if isSuccess(slot1.num) and not MythicData:GetIsNew() then
		MythicData:UpdatePartitionState(slot1.stageData:GetDest())
	end

	MythicAction:UpdateMythicRedTip()
end

function slot0.OnGotoChessStage(slot0, slot1)
	slot3 = slot1.stageData

	if isSuccess(slot1.num) then
		manager.ChessManager:BattleSuccess()
	end

	manager.ChessManager.forceBattle:BattleResult(isSuccess(slot2))
end

function slot0.OnGotoNewChessStage(slot0, slot1)
	slot3 = slot1.stageData

	if isSuccess(slot1.num) then
		manager.NewChessManager:BattleSuccess()
	end
end

function slot0.OnGotoPushBoxStage(slot0, slot1)
end

return slot0
