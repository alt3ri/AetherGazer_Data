NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
slot0 = class("NewBattleMultipleResultView", NewBattleSettlementView)

function slot0.OnAddListner(slot0)
	slot0:AddBtnListener(slot0.nextStageBtn_, nil, function ()
		uv0:OnceMoreFunc()
	end)
	SetActive(slot0.costImage_.gameObject, false)
end

function slot0.ShowCost(slot0)
	slot1 = slot0.stageData:GetCost()
	slot2 = slot0.stageData:GetMultiple()
	slot4 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if slot0.stageType ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE and slot0.stageType ~= BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		SetActive(slot0.costImage_.gameObject, true)

		if CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= slot1 * slot2 then
			slot0.vitalityCostText_.text = string.format("<color=#%s>%s</color>", ColorConst.BLACK_HEX, slot1 * slot2)
		else
			slot0.vitalityCostText_.text = string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, slot1 * slot2)
		end
	else
		SetActive(slot0.costImage_.gameObject, false)
	end
end

function slot0.ShowContent(slot0)
	slot0:onRenderMultiResultContent()
end

function slot0.onRenderMultiResultContent(slot0)
	if not slot0.multiView then
		slot0.multiView = BattleSettlementMultiResultModule.New(slot0.contentContainer_)
	end

	slot0.multiView:RenderView({
		stageData = slot0.stageData,
		rewardList = slot0.params_.rewardList,
		rewardTimes = slot0.params_.multiple
	})
	slot0:SetBtnOnceMore()
end

function slot0.SetBtnOnceMore(slot0)
	if slot0.stageType == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		SetActive(slot0.nextStageBtn_.gameObject, false)
	else
		SetActive(slot0.nextStageBtn_.gameObject, slot0:NeedOnceMore())
	end
end

function slot0.NeedOnceMore(slot0)
	if slot0.params_.notOnceMore then
		return false
	end

	return true
end

function slot0.Dispose(slot0)
	slot0.multiView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
