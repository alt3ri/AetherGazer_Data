slot0 = class("GotoSequentialBattleStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoSequentialBattleStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoSequentialBattleStage(slot0, slot1, slot2, slot3, slot4, slot5)
	function BattleCallLuaCallBack()
		if isSuccess(uv0) then
			slot0 = uv1:GetActivityID()
			slot4 = SequentialBattleData:GetChapterData(slot0).team[table.indexof(SequentialBattleChapterCfg[slot0].stage_id, uv1:GetStageId())].enabledBuff or {}

			for slot9, slot10 in ipairs(slot4) do
				if slot9 ~= #slot4 then
					slot5 = "[" .. slot10 .. ","
				end
			end

			SDKTools.SendMessageToSDK("combat_over", {
				activity_cb_buff_list = slot5 .. "]"
			})
			SequentialBattleData:ClearStage(uv1:GetActivityID())
			gameContext:Go("/sequentialBattleResult", {
				stageData = uv1,
				rewardList = {},
				battleResult = uv2
			})
		else
			gameContext:Go("/sequentialBattleFailed", {
				stageData = uv1,
				battleResult = uv2
			})
		end

		EndBattleLogic(uv0)
	end
end

return slot0
