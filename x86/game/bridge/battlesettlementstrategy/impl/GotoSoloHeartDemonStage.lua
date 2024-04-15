slot0 = class("GotoSoloHeartDemonStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoSoloHeartDemonStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoSoloHeartDemonStage(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = 1

	if isSuccess(slot1) then
		slot0:GotoSoloHeartDemonSuccess(slot5, 10, slot1, slot2, slot3, slot4)
	else
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
				gameContext:Go("/SoloHeartDemonFail", {
					stageData = uv0,
					battleResult = uv1
				})
				manager.story:RemovePlayer()
				EndBattleLogic(uv2)
			end)
		end
	end
end

function slot0.GotoSoloHeartDemonSuccess(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if slot1 == true then
		slot3 = 3
	end

	if isSuccess(slot3) then
		function BattleCallLuaCallBack()
			gameContext:Go("/soloHeartDemonResult", {
				stageData = uv0,
				score = uv1,
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	end
end

return slot0
