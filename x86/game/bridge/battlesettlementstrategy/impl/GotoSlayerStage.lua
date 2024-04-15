slot0 = class("GotoSlayerStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoSlayerStage(slot1.num, slot1.stageData, slot1.battleResult)
end

function slot0.GotoSlayerResult(slot0, slot1, slot2, slot3)
	function BattleCallLuaCallBack()
		gameContext:Go("/battleSlayerResult", {
			stageData = uv0,
			rewardList = {},
			battleResult = uv1
		})
		EndBattleLogic(uv2)
	end
end

return slot0
