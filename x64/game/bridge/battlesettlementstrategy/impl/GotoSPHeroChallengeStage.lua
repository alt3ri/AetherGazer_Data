slot0 = class("GotoSPHeroChallengeStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot4 = slot1.stageData:GetType()

	if slot1.isHalfWay_ then
		slot0:GotoBattleFaild(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)

		return
	end

	slot0:GotoSPHeroChallengeStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoSPHeroChallengeStage(slot0, slot1, slot2, slot3, slot4)
	slot5 = 1

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			slot0, slot1 = GetResultReward()

			gameContext:Go("/battleSPHeroChallengeResultView", {
				stageData = uv0,
				score = uv1,
				battleResult = uv2,
				rewardList = slot0
			})

			if BattleVerthandiExclusiveCfg[uv0:GetStageId()].sub_type == SpHeroChallengeConst.BattleSubType.story then
				SPHeroChallengeData:GetCurActivityInfo():FinishStoryStage(slot2)
			end

			if BattleVerthandiExclusiveCfg[slot2].sub_type == SpHeroChallengeConst.BattleSubType.train1 or BattleVerthandiExclusiveCfg[slot2].sub_type == SpHeroChallengeConst.BattleSubType.train2 or BattleVerthandiExclusiveCfg[slot2].sub_type == SpHeroChallengeConst.BattleSubType.train3 then
				slot3 = SPHeroChallengeData:GetCurActivityInfo()
			end
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
