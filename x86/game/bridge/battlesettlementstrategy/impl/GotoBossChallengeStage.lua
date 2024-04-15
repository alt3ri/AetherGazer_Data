slot0 = class("GotoBossChallengeStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	if slot1.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		slot0:GotoNormalBossChallenge(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
	elseif slot3 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE then
		slot0:GotoAdvanceBossChallenge(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
	end
end

function slot0.GotoNormalBossChallenge(slot0, slot1, slot2, slot3, slot4)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			JumpTools.OpenPageByJump("/battleBossChallengeResult", {
				result = uv0,
				rewardList = {},
				stageData = uv1,
				starMissionData = uv2,
				battleResult = uv3
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = uv1,
				battleResult = uv3
			})
		end

		EndBattleLogic(uv0)
	end
end

function slot0.GotoAdvanceBossChallenge(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			gameContext:Go("/battleScorResult", {
				stageData = uv1,
				rewardList = uv2,
				battleResult = uv3
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = uv1,
				battleResult = uv3
			})
		end

		EndBattleLogic(uv0)
	end
end

return slot0
