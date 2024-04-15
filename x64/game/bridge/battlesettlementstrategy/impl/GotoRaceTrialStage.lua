slot0 = class("GotoRaceTrialStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoRaceTrial(slot1)
end

function slot0.GotoRaceTrial(slot0, slot1)
	slot2 = slot1.num
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult

	if slot1.isHalfWay_ == true then
		slot2 = 3
	end

	slot7, slot8 = GetResultReward()

	if isSuccess(slot2) then
		function BattleCallLuaCallBack()
			slot3 = ActivityTools.GetActivityTheme(uv0:GetActivityID())

			gameContext:Go("/battleScorResult", {
				stageData = uv0,
				rewardList = uv1,
				score = RaceTrialData:GetBattleResultGoal(uv0:GetStageId()),
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	else
		slot0:GotoBattleFaild(slot2, slot3, slot4, slot5)
	end
end

return slot0
