slot0 = class("GotoActivityWaterCooperationStage", BattleCooperationSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult

	if isSuccess(slot1.num) then
		slot6 = slot0:GetResultReward()

		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/xH3rdWaterSettlementView", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
		end

		return
	end

	function BattleCallLuaCallBack()
		gameContext:Go("/xH3rdWaterBattleCooperationFailed", {
			stageData = uv0
		})
		EndBattleLogic(uv1)
	end
end

return slot0
