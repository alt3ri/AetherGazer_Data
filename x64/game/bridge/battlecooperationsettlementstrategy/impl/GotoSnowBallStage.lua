slot0 = class("GotoSnowBallStage", BattleCooperationSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot4 = slot1.starMissionData

	if BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == slot1.stageData:GetType() then
		slot0:GotoPushSnowBallTeamBossBattleResult(slot1.num, PushSnowBallData:GetTeamBattleResultInfo(), slot3, slot1.battleResult)
	elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == slot6 then
		slot0:GotoPushSnowBallTeamSurvivalBattleResult(slot2, PushSnowBallData:GetTeamBattleResultInfo(), slot3, slot5)
	end
end

function slot0.GotoPushSnowBallSingleBattleResult(slot0, slot1, slot2, slot3, slot4, slot5)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			JumpTools.OpenPageByJump("/battlePushSnowBallSingleResult", {
				score = uv1,
				useSecond = uv2,
				stageData = uv3,
				battleResult = uv4
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = uv3,
				battleResult = uv4
			})
		end

		EndBattleLogic(uv0)
	end
end

function slot0.GotoPushSnowBallTeamSurvivalBattleResult(slot0, slot1, slot2, slot3, slot4)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			JumpTools.OpenPageByJump("/battlePushSnowBallTeamSurvivalResult", {
				result = uv0,
				resultInfo = uv1,
				stageData = uv2,
				battleResult = uv3
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = uv2,
				battleResult = uv3
			})
		end

		EndBattleLogic(uv0)
	end
end

function slot0.GotoPushSnowBallTeamBossBattleResult(slot0, slot1, slot2, slot3, slot4)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			JumpTools.OpenPageByJump("/battlePushSnowBallTeamBossResult", {
				result = uv0,
				resultInfo = uv1,
				stageData = uv2,
				battleResult = uv3
			})
		else
			JumpTools.OpenPageByJump("/battlefailedBossChallenge", {
				stageData = uv2,
				battleResult = uv3
			})
		end

		EndBattleLogic(uv0)
	end
end

return slot0
