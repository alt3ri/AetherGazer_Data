slot0 = class("GotoEquipBreakThroughStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:GotoEquipBreakThroughStage(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.GotoEquipBreakThroughStage(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	if isSuccess(slot1) then
		function BattleCallLuaCallBack()
			JumpTools.OpenPageByJump("/equipBreakThroughResult", {
				result = uv0,
				rewardList = uv1,
				stageData = uv2,
				starMissionData = uv3,
				battleResult = uv4
			})
			EndBattleLogic(uv0)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
