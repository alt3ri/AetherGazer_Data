slot0 = class("GotoActivityHeroEnhanceStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot4 = slot1.starMissionData
	slot5 = slot1.battleResult

	if isSuccess(slot1.num) then
		ActivityHeroEnhanceData:AddClearedStage(slot1.stageData:GetActivityID(), slot3:GetStageId())
	end

	slot7, slot8 = GetResultReward()

	if isSuccess(slot2) then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.WIN, function ()
				gameContext:Go("/activityHeroEnhanceBattleResult", {
					noOnceMore = true,
					stageData = uv0,
					rewardList = uv1,
					battleResult = uv2
				})
				manager.story:RemovePlayer()
				EndBattleLogic(uv3)
			end)
		end
	else
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(uv0:GetStageId(), manager.story.LOSE, function ()
				JumpTools.OpenPageByJump("/battlefailedWithButton", {
					stageData = uv0,
					battleResult = uv1
				})
				manager.story:RemovePlayer()
				EndBattleLogic(uv2)
			end)
		end
	end
end

return slot0
