local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroBaseView")
local var_0_1 = class("KagutsuchiSectionSelectHeroView", var_0_0)

function var_0_1.GoHeroInfoUI(arg_1_0, arg_1_1)
	local var_1_0 = BattleStageTools.GetRestrictHeroList(arg_1_0.stageType_, arg_1_0.stageID_)

	if type(var_1_0) == "table" then
		local var_1_1 = var_1_0[arg_1_1]

		if var_1_1[1] == 0 or var_1_1[1] ~= 0 and HeroCfg[var_1_1[1]] and not table.keyof(HeroCfg.get_id_list_by_private[0], var_1_1[1]) then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end
	end

	arg_1_0:Go("/kagutsuchiTeamInfo", {
		isEnter = true,
		selectHeroPos = arg_1_1,
		stageID = arg_1_0.stageID_,
		activityID = arg_1_0.params_.activityID,
		stageType = arg_1_0.stageType_,
		reserveParams = arg_1_0.reserveParams_
	})
end

return var_0_1
