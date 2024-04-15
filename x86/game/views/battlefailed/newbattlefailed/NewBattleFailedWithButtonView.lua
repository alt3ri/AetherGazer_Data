NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")
slot0 = class("NewBattleFailedWithButtonView", NewBattleFailedView)

function slot0.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	SetActive(slot0.btnMask_.gameObject, false)
	slot0.btnController:SetSelectedState("2btn")
end

function slot0.OnEnter(slot0)
	slot0.stageData_ = slot0.params_.stageData
	slot0.stageID_ = slot0.stageData_:GetStageId()
	slot0.stageType_ = slot0.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	slot0:RebuildUI()
end

return slot0
