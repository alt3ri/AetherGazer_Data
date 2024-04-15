slot0 = class("GotoPushSnowBallSingleBattleStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot2 = slot1.num
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult
	slot6 = PushSnowBallData:GetBattleResultScore()
	slot7 = PushSnowBallData:GetBattleResultSecond()

	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			JumpTools.OpenPageByJump("/battlePushSnowBallSingleResult", {
				score = uv1,
				useSecond = uv2,
				stageData = uv3,
				battleResult = uv4
			})
		else
			gameContext:Go("/battlePushSnowBallFail", {
				stageData = uv3,
				battleResult = uv4
			})
		end

		EndBattleLogic(uv0)
	end
end

return slot0
