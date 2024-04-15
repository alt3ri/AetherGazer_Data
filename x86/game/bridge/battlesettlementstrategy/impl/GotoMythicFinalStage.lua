slot0 = class("GotoMythicFinalStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoMythicFinalStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoMythicFinalStage(slot0, slot1, slot2, slot3, slot4, slot5)
	if isSuccess(slot1) and not slot5 then
		function BattleCallLuaCallBack()
			manager.story:RemovePlayer()
			gameContext:Go("/battleMythicFinalResultView", {
				multiple = 1,
				stageData = uv0,
				battleResult = uv1
			})
			EndBattleLogic(uv2)
		end
	else
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/battlefailedWithButton", {
				stageData = uv0,
				battleResult = uv1,
				isHalfWay_ = uv2.tempData.isHalfWay_
			})
			EndBattleLogic(uv3)
		end
	end
end

return slot0
