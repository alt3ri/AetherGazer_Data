local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveProposalTemplate", var_0_0)

function var_0_1.UpdateServerData(arg_1_0, arg_1_1)
	var_0_1.super.UpdateServerData(arg_1_0, arg_1_1)

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data) do
		local var_1_0 = iter_1_1.cont_id

		if arg_1_0.cont_dic[var_1_0] then
			arg_1_0:GetContDataTemplateById(var_1_0):SetName(iter_1_1.name)
		end
	end
end

function var_0_1.GetProposalContIDList(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.cont_teams) do
		if not iter_2_1.isTemp and iter_2_1:GetName() ~= "" then
			var_2_0[#var_2_0 + 1] = iter_2_1.cont_id
		end
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		return arg_3_0 < arg_3_1
	end)

	return var_2_0
end

function var_0_1.GetTempContID(arg_4_0)
	local var_4_0 = GameSetting.default_formation_num_max.value[1]

	for iter_4_0 = 1, var_4_0 + 1 do
		local var_4_1 = arg_4_0.cont_dic[iter_4_0]

		if not var_4_1 then
			return iter_4_0
		elseif var_4_1.isTemp then
			return iter_4_0
		elseif var_4_1:GetName() == "" then
			var_4_1.isTemp = true

			return iter_4_0
		end
	end

	return var_4_0 + 1
end

function var_0_1.DeleteProposal(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.cont_dic[arg_5_1]
	local var_5_1 = table.indexof(arg_5_0.cont_teams, var_5_0)

	table.remove(arg_5_0.cont_teams, var_5_1)

	arg_5_0.cont_teams[#arg_5_0.cont_teams + 1] = var_5_0
end

return var_0_1
