slot0 = class("GotoSkadiStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoSkadiStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoSkadiStage(slot0, slot1, slot2, slot3, slot4)
	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleLittleGameResultView", {
				stageData = uv0,
				rewardList = {},
				battleResult = uv1
			})
			EndBattleLogic(uv2)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
