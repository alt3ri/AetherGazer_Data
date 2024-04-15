slot0 = class("GotoMardukSpecialStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoMardukSpecialStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoMardukSpecialStage(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot5 then
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)

		return
	end

	function BattleCallLuaCallBack()
		manager.story:RemovePlayer()

		slot0 = 1
		slot1 = math.floor(GameSetting.activity_quick_training_point_calculate_time.value[1] / 1000)
		slot5 = 0

		if isSuccess(uv0) then
			slot5 = (slot1 - math.floor(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)) / slot1 * GameSetting.quick_training_time_param.value[1]
		end

		slot6 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas
		slot7 = 0

		for slot13, slot14 in ipairs(ActivityQuickTrainingCfg[uv1:GetActivityID()].monster_id_list) do
			slot16 = 0

			if slot6:TryGetValue(slot14[1], nil) then
				slot16 = slot6[slot14[1]] or 0
			end

			slot7 = slot7 + slot16 * (slot14[2] or 0)
		end

		gameContext:Go("/battleScorResult", {
			stageData = uv1,
			battleResult = uv2,
			score = math.floor(slot7 + slot5)
		})
		EndBattleLogic(uv0)
	end
end

return slot0
