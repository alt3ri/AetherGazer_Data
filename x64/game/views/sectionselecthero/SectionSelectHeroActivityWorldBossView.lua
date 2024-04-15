local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroBaseView")
local var_0_1 = class("SectionSelectHeroActivityWorldBossView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	var_0_1.super.OnEnter(arg_1_0)

	arg_1_0.activity_id = arg_1_0.params_.activityID
end

function var_0_1.OnExit(arg_2_0)
	var_0_1.super.OnExit(arg_2_0)
	arg_2_0:RemoveAllEventListener()
end

function var_0_1.StartBattle(arg_3_0)
	if not ActivityData:GetActivityIsOpen(arg_3_0.activity_id) then
		ShowTips("TIME_OVER")

		return
	end

	local var_3_0 = ActivityWorldBossData:GetStageId(arg_3_0.activity_id)
	local var_3_1 = BattleActivityWorldBossTemplate.New(var_3_0, arg_3_0.activity_id)

	BattleController.GetInstance():LaunchBattle(var_3_1)
end

return var_0_1
