slot0 = class("GotoKagutsuchiStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult

	if isSuccess(slot1.num) and ActivityTools.GetActivityStatus(slot1.stageData:GetActivityID()) == 1 then
		if slot3:GetDay() == KagutsuchiWorkData:GetDay() then
			KagutsuchiWorkData:SetGridClear(KagutsuchiWorkData:GetIndexByStageId(slot3:GetStageId()))
		end

		slot0:GotoStage(slot2, slot3, slot4, slot5)

		return
	end

	function BattleCallLuaCallBack()
		manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
			gameContext:Go("/battlefailedWithButton", {
				stageData = uv0,
				battleResult = uv1
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv2)
		end)
	end
end

return slot0
