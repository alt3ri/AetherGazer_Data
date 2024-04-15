local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroBaseView")
local var_0_1 = class("SectionSelectHeroPushBoxView", var_0_0)

function var_0_1.StartBattle(arg_1_0)
	local var_1_0 = BattleActivityPushBoxTemplate.New(arg_1_0.stageID_, arg_1_0.params_.activityID, arg_1_0.params_.dest_id)

	BattleController.GetInstance():LaunchBattle(var_1_0)
end

return var_0_1
