slot0 = class("GotoCoreVerificationStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	function BattleCallLuaCallBack()
		if isSuccess(uv0.num) then
			JumpTools.OpenPageByJump("/coreVerificationBattleResult", {
				result = uv0.num,
				rewardList = {},
				stageData = uv0.stageData,
				starMissionData = uv0.starMissionData,
				battleResult = uv0.battleResult
			})
		else
			JumpTools.OpenPageByJump("/battlefailedWithButton", {
				stageData = uv0.stageData,
				starMissionData = uv0.starMissionData,
				battleResult = uv0.battleResult,
				isHalfWay_ = uv1.tempData.isHalfWay_
			})
		end

		EndBattleLogic(uv0.num)
	end
end

return slot0
