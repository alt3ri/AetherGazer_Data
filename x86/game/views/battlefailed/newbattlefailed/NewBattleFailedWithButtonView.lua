NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")

local var_0_0 = class("NewBattleFailedWithButtonView", NewBattleFailedView)

function var_0_0.AddUIListener(arg_1_0)
	var_0_0.super.AddUIListener(arg_1_0)
	SetActive(arg_1_0.btnMask_.gameObject, false)
	arg_1_0.btnController:SetSelectedState("2btn")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.stageData_ = arg_2_0.params_.stageData
	arg_2_0.stageID_ = arg_2_0.stageData_:GetStageId()
	arg_2_0.stageType_ = arg_2_0.stageData_:GetType()

	BattleInstance.hideBattlePanel()
	arg_2_0:RebuildUI()
end

return var_0_0
