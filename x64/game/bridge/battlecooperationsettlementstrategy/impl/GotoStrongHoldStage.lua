slot0 = class("GotoStrongHoldStage", BattleCooperationSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	if LuaExchangeHelper.GetBattleStatisticsData() then
		for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRONGHOLD] or {}) do
			if table.indexof(ActivityCfg[slot7].sub_activity_list, activity_id) then
				for slot14 = 0, slot2.choosedEffectID.Count - 1 do
					StrongholdAction.UpgradeAltas(slot7, slot2.choosedEffectID[slot14])
				end
			end
		end
	end

	slot0:GotoStrongholdResult(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoStrongholdResult(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:GetResultReward()

	function BattleCallLuaCallBack()
		JumpTools.OpenPageByJump("/strongholdBattleResult", {
			result = uv0,
			rewardList = uv1,
			stageData = uv2,
			starMissionData = uv3,
			battleResult = uv4
		})
		EndBattleLogic(uv0)
	end
end

return slot0
