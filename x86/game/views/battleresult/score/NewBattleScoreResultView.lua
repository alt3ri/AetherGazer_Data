NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
slot0 = class("NewBattleScoreResultView", NewBattleSettlementView)

function slot0.OnAddListner(slot0)
	slot0:AddBtnListener(slot0.nextStageBtn_, nil, function ()
		uv0:ConfirmFunc()
	end)
	SetActive(slot0.costImage_.gameObject, false)

	slot0.confirmBtnTxt_.text = GetTips("CHALLENGE_ONCE_MORE")
end

function slot0.ShowContent(slot0)
	slot0:onRenderChallengeContent()
end

function slot0.onRenderChallengeContent(slot0)
	if not slot0.chanllengeView then
		slot0.chanllengeView = BattleSettlementChallengeModule.New(slot0.contentContainer_)
	end

	slot1 = nil

	if slot0.params_.title and slot0.params_.title ~= "" then
		slot1 = GetI18NText(slot0.params_.title)
	end

	slot0.chanllengeView:RenderView({
		score = slot0.params_.score,
		stageType = slot0.stageType,
		stageData = slot0.stageData,
		scoreTitle = slot1
	})
end

function slot0.ConfirmFunc(slot0)
	if slot0.params_.condition then
		slot1, slot2 = slot0.params_.condition()

		if slot1 then
			BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
		else
			ShowTips(slot2)
		end
	else
		BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
	end
end

function slot0.OnTop(slot0)
	uv0.super.OnTop(slot0)

	if slot0.chanllengeView then
		slot0.chanllengeView:OnTop()
	end
end

function slot0.NeedOnceMore(slot0)
	if slot0.params_.notOnceMore or slot0.params_.noOnceMore then
		return false
	end

	return true
end

function slot0.Dispose(slot0)
	slot0.chanllengeView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
