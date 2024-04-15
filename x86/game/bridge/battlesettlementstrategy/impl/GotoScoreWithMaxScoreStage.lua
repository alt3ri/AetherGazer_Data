slot0 = class("GotoScoreWithMaxScoreStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot2 = slot1.num
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult

	if slot1.isHalfWay_ == true then
		slot2 = 3
	end

	slot6 = DestroyBoxGameCfg.get_id_list_by_activity_id[slot3:GetActivityID()][1]

	slot0:GotoScoreWithMaxScoreResult(DestroyBoxGameData:GetStageData(slot3:GetDest()) and slot8.score or 0, slot8 and slot8.historyMaxScore or 0, slot2, slot3, slot4, slot5, true)
end

function slot0.GotoScoreWithMaxScoreResult(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8, slot9 = GetResultReward()

	if isSuccess(slot3) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleScorWithMaxScoreResult", {
				stageData = uv0,
				rewardList = uv1,
				score = uv2,
				maxScore = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv5)
		end
	else
		function BattleCallLuaCallBack()
			if uv0 then
				JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
					stageData = uv1,
					starMissionData = uv2,
					battleResult = uv3,
					isHalfWay_ = uv4.tempData.isHalfWay_
				})
			else
				JumpTools.OpenPageByJump("/battlefailed", {
					stageData = uv1,
					starMissionData = uv2,
					battleResult = uv3,
					isHalfWay_ = uv4.tempData.isHalfWay_
				})
			end

			manager.story:RemovePlayer()
			EndBattleLogic(uv5)
		end
	end
end

return slot0
