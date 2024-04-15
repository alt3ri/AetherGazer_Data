slot0 = class("GotoAttributeArenaStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot3 = slot1.stageData
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult
	slot6, slot7 = GetResultReward()

	function slot8()
		manager.story:RemovePlayer()
		gameContext:Go("/battleScorResult", {
			noOnceMore = true,
			stageData = uv0,
			rewardList = uv1,
			battleResult = uv2
		})
		EndBattleLogic(uv3)
	end

	if isSuccess(slot1.num) then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, uv1)
		end
	else
		slot0:GotoBattleFaild(slot2, slot3, slot4, slot5)
	end
end

return slot0
