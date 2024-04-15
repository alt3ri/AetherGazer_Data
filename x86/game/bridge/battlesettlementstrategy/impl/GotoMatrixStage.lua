slot0 = class("GotoMatrixStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	if isSuccess(slot1.num) then
		MatrixAction.DoAfterEvnet(MatrixData:GetBattleTier())
	end

	slot0:GotoMatrix(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoMatrix(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleMatrixResult", {
				multiple = 1,
				stageData = uv0,
				rewardList = uv1,
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battleMatrixFailed", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv3)
		end
	end
end

return slot0
