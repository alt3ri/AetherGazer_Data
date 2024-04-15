slot0 = class("GotoActivityMatrixStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoActivityMatrix(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoActivityMatrix(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	for slot12, slot13 in ipairs(slot5) do
		if slot13[1] == 26 then
			if ActivityTools.GetActivityType(slot2:GetActivityID()) == ActivityTemplateConst.SUB_SINGLE_MATRIX then
				slot13[1] = ActivityMatrixTools.GetCoinItem(slot7)
			elseif slot8 == ActivityTemplateConst.STRATEGY_MATRIX then
				slot13[1] = StrategyMatrixTools.GetCoinItem(slot7)
			end
		end

		if slot13[2] == 0 then
			slot5[slot12] = nil
		end
	end

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			if uv0 == ActivityTemplateConst.STRATEGY_MATRIX then
				if (StrategyMatrixTierTemplateCfg[uv1.tier or 0].level == 10 and StrategyMatrixCfg[uv2].tier_story_list[slot2.tier] or nil) and not manager.story:IsStoryPlayed(slot3) then
					PlayerAction.ChangeStoryList(slot3)
					manager.story:StartStoryById(slot3, function (slot0)
						gameContext:Go("/battleActivityMatrixResult", {
							multiple = 1,
							stageData = uv0,
							rewardList = uv1,
							battleResult = uv2
						})
					end)
				else
					gameContext:Go("/battleActivityMatrixResult", {
						multiple = 1,
						stageData = uv1,
						rewardList = uv3,
						battleResult = uv4
					})
				end
			else
				gameContext:Go("/battleActivityMatrixResult", {
					multiple = 1,
					stageData = uv1,
					rewardList = uv3,
					battleResult = uv4
				})
			end

			EndBattleLogic(uv5)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
