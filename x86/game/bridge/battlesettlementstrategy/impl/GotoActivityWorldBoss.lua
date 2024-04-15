slot0 = class("GotoActivityWorldBossStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoActivityWorldBossStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoActivityWorldBossStage(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = GetResultReward()
	slot9 = ActivityWorldBossCfg[slot2:GetActivityID()]

	for slot13, slot14 in ipairs(slot6) do
		if slot9 and slot9.coin_id == slot14[1] then
			ActivityWorldBossData:UpdateCoinCount(slot8, slot14[2])
		end
	end

	if not slot5 then
		function BattleCallLuaCallBack()
			slot1 = uv1.end_story_id

			if ActivityWorldBossData:GetLeftHealthPoint(uv0:GetActivityID()) == 0 and not manager.story:IsStoryPlayed(slot1) then
				manager.story:StartStoryById(slot1, function (slot0)
					gameContext:Go("/battleActivityWorldBossResult", {
						stageData = uv0,
						rewardList = uv1,
						battleResult = uv2
					})
				end)
			else
				gameContext:Go("/battleActivityWorldBossResult", {
					stageData = uv0,
					rewardList = uv2,
					battleResult = uv3
				})
			end

			EndBattleLogic(uv4)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
