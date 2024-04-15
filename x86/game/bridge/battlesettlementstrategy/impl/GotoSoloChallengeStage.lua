slot0 = class("GotoSoloChallengeStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoSoloChanllenge(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoSoloChanllenge(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/newSettlement", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
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
