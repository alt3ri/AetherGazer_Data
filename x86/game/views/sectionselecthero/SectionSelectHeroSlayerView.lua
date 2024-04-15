local var_0_0 = class("SectionSelectHeroMythicView", SectionSelectHeroBaseView)

function var_0_0.StartBattle(arg_1_0)
	local var_1_0 = arg_1_0.params_.region_activity_id
	local var_1_1 = arg_1_0.params_.activityID

	if not ActivityData:GetActivityIsOpen(var_1_0) then
		ShowTips("TIP_EXPIRED")

		return
	end

	local var_1_2 = BattleStageFactory.Produce(arg_1_0.stageType_, var_1_0, var_1_1, arg_1_0.reserveParams_)

	BattleController.GetInstance():LaunchBattle(var_1_2)
end

return var_0_0
