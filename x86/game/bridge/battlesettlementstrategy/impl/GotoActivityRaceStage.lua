slot0 = class("GotoActivityRaceStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoActivityRaceStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoActivityRaceStage(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = GetResultReward()
	slot10 = ActivityRaceCfg[slot2:GetActivityID()].stage_list

	if not (slot2:GetStageId() == slot10[#slot10]) then
		if isSuccess(slot1) or not slot5 and slot4.challengedNumber >= 1 then
			function BattleCallLuaCallBack()
				ActivityRaceData:SetCompleteStage(uv0, uv1)
				gameContext:Go("/battleActivityRaceResult", {
					stageData = uv2,
					rewardList = uv3,
					affixList = ActivityRaceData:GetDropAffixes(),
					battleResult = uv4
				})
				EndBattleLogic(uv5)
			end
		else
			slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
		end
	elseif slot1 + 1 ~= BattleConst.BATTLE_RESULT.QUIT then
		function BattleCallLuaCallBack()
			slot2, slot3, slot4 = BattleTools.GetBattleStatisticsData()
			slot5 = slot3.damage
			slot6 = ActivityRaceCfg[uv0].boss_hp[1]
			slot7 = GameSetting.race_boss_point_cal.value
			slot8 = 0

			if isSuccess(uv1) then
				slot8 = math.max(slot7[2] - math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime) * slot7[3], 0)
			end

			slot9 = math.floor(math.min(tonumber(tostring(slot5)) / slot6, 1) * slot7[1] + slot8)

			ActivityRaceData:SetScore(uv0, slot9)
			ActivityRaceData:SetCompleteStage(uv0, uv2)
			gameContext:Go("/battleScorResult", {
				stageData = uv3,
				battleResult = uv4,
				score = slot9
			})
			EndBattleLogic(uv1)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
