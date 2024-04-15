slot0 = class("GotoSoloSurviveStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoSoloSurviveStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoSoloSurviveStage(slot0, slot1, slot2, slot3, slot4, slot5)
	function BattleCallLuaCallBack()
		slot0 = uv0:GetStageId()
		slot2 = ActivityTools.GetActivityTheme(uv0:GetActivityID())

		gameContext:Go("/battleScorResult", {
			stageData = uv0,
			battleResult = uv1,
			title = GetTips("ACTIVITY_SOLO_SLAYER_FINISH")
		})
		EndBattleLogic(uv2)
	end
end

return slot0
