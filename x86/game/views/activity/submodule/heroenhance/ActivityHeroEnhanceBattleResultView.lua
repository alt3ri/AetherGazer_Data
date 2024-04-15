NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
slot0 = class("ActivityHeroEnhanceBattleResultView", NewBattleSettlementView)

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.firstHeroModule = slot0.heroModule[1]

	SetActive(slot0.heroHead2Obj_, false)
	SetActive(slot0.heroHead3Obj_, false)
end

function slot0.OnAddListner(slot0)
	SetActive(slot0.emptyMaskBtn_.gameObject, true)
	slot0:AddBtnListener(slot0.emptyMaskBtn_, nil, function ()
		BattleInstance.QuitBattle(uv0.stageData)
	end)
end

function slot0.onRenderMissionResultContent(slot0)
	if not slot0.missionView then
		slot0.missionView = ActivityHeroEnhanceBattleSettlementModule.New(slot0.contentContainer_)
	end

	slot0.missionView:RenderView({
		stageData = slot0.stageData,
		rewardList = slot0.params_.rewardList
	})
end

function slot0.ShowContent(slot0)
	slot0:onRenderMissionResultContent()
end

function slot0.PostRenderView(slot0)
	slot0.btnController:SetSelectedState("nobtn")
end

function slot0.RenderTitleView(slot0)
	SetActive(slot0.titleObj_, true)

	slot0.titleTxt_.text = GetI18NText(BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).name)
end

function slot0.Dispose(slot0)
	slot0.missionView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
