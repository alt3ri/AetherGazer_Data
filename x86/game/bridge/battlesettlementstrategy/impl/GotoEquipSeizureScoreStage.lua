slot0 = class("GotoEquipSeizureScoreStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoEquipSeizureScoreStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoEquipSeizureScoreStage(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot5 == true then
		slot1 = 3
	end

	slot6, slot7 = GetResultReward()
	slot8 = EquipSeizureData:GetResultScore()

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleScorResult", {
				stageData = uv0,
				rewardList = uv1,
				score = uv2,
				battleResult = uv3
			})
			EndBattleLogic(uv4)
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battlefailedEquipSeizure", {
				stageData = uv0,
				starMissionData = uv1,
				rewardList = uv2,
				score = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv5)
		end
	end
end

return slot0
