local var_0_0 = import("game.views.stage.bossChallenge.normal.info.ReservesView")
local var_0_1 = class("ActivityRaceReservesView", var_0_0)

function var_0_1.IndexItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = arg_1_0.reservesTempTeams_[arg_1_1].hero_list

	arg_1_2:RefreshUI(arg_1_0.reservesTempTeams_[arg_1_1], arg_1_0:IsCurTeam(arg_1_0.reservesTempTeams_[arg_1_1]), arg_1_0:IsInList(arg_1_1, arg_1_0.reservesTempTeams_[arg_1_1]), arg_1_1 == arg_1_0.setCurTeamIndex_)
	arg_1_2:RegistChangeBtn(function(arg_2_0)
		local var_2_0 = BattleTeamData:GetReservesTeam(arg_2_0)

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			if iter_2_1 ~= 0 and table.indexof(arg_1_0.lockList_, iter_2_1) then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end

			if arg_1_0.params_.race and iter_2_1 ~= 0 and HeroCfg[iter_2_1].race ~= arg_1_0.params_.race then
				ShowTips("FORMATION_PLAN_CHANGE_FAILED")

				return
			end
		end

		local var_2_1 = BattleTeamData:GetReservesTeamList()[arg_2_0]

		ReserveTools.SetTeam(arg_1_0.reserveParams_, var_2_0, {
			0,
			0,
			0
		}, var_2_1.comboSkill, var_2_1.chipInfo.id, var_2_1.chipInfo.list)
		arg_1_0:Back(1, {
			isReserves = true,
			index = arg_2_0
		})
		ShowTips("FORMATION_PLAN_CHANGED")
	end)
end

return var_0_1
