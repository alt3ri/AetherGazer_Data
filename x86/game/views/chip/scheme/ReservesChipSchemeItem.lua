local var_0_0 = class("ReservesChipSchemeItem", ChipSchemeItem)

function var_0_0.OnEnabledBtn(arg_1_0)
	arg_1_0.dataTemplate.useChipIdList = arg_1_0.schemeData_.chipList

	local var_1_0 = arg_1_0.dataTemplate.reservesIndex_

	BattleTeamData:ReservesTempTeamEnabledSchemeID(var_1_0, arg_1_0.schemeData_.chipList)
end

return var_0_0
