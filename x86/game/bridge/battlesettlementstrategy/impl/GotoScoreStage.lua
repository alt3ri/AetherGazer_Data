slot0 = class("GotoScoreStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot3 = slot1.num
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult
	slot6 = slot1.isHalfWay_

	if slot1.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION then
		slot0:GotoScoreStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
	elseif slot7 == BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT then
		slot0:GotoScoreResult(ActivityAffixSelectData:GetLevelScore(slot2:GetActivityID()), slot3, slot2, slot4, slot5, slot6, true)
	elseif slot7 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD then
		slot0:GotoScoreResult(ActivityPt2Data:GetHardScore(), slot3, slot2, slot4, slot5, slot6, true)
	elseif slot7 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		slot0:GotoScoreResult(AdvanceTestData:GetBattleResultScore(), slot3, slot2, slot4, slot5, slot6, true)
	end
end

function slot0.GotoScoreStage(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	function slot7()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			stageData = uv0,
			rewardList = uv1,
			battleResult = uv2
		})
		EndBattleLogic(uv3)
	end

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
		end
	else
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
		end
	end
end

function slot0.GotoScoreResult(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot6 == true then
		slot2 = 3
	end

	slot8, slot9 = GetResultReward()

	if isSuccess(slot2) then
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
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
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
			end)
		end
	end
end

return slot0
