slot0 = class("GotoMultipleResultStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	if slot1.stageData:GetType() == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL and isSuccess(slot1.num) then
		if not ActivityPtRouletteStageCfg[slot2:GetDest()].cost[1] or slot5 == CurrencyConst.CURRENCY_TYPE_VITALITY then
			ActivityPtScrollData:AddClearTime(slot2:GetActivityID(), slot2:GetMultiple())
		end

		ActivityPtScrollData:SetClearList(slot2:GetActivityID(), slot2:GetStageId())
	end

	slot0:GotoMultipleResult(slot1.num, slot2, slot1.starMissionData, slot1.battleResult, slot1.isHalfWay_)
end

function slot0.GotoMultipleResult(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot5 == true then
		slot1 = 3
	end

	slot6, slot7 = GetResultReward()

	if isSuccess(slot1) or not slot5 and slot4.challengedNumber >= 1 then
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot2:GetType() then
			BattleEquipAction.CaculateGuaranteeNum(slot2:GetStageId(), slot7)
		end

		function BattleCallLuaCallBack()
			gameContext:Go("/battleMultipleResult", {
				stageData = uv0,
				rewardList = uv1,
				multiple = uv2.challengedNumber or 0,
				battleResult = uv2
			})
			EndBattleLogic(uv3)
		end
	else
		slot0:GotoBattleFaild(slot1, slot2, slot3, slot4)
	end
end

return slot0
