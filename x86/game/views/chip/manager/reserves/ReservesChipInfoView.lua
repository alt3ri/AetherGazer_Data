local var_0_0 = class("ReservesChipInfoView", ChipInfoView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.chipManagerDataTemplate_ = arg_1_0.params_.chipDataTemplate
	arg_1_0.index = arg_1_0.chipManagerDataTemplate_.reservesIndex_

	arg_1_0.super.OnEnter(arg_1_0)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.useBtn_, nil, function()
		BattleTeamData:SetReservesTempTeamChipList(arg_2_0.index, arg_2_0.defaultSelectID_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.unlockBtn_, nil, function()
		ChipAction.UnlockChip(arg_2_0.defaultSelectID_)
	end)
	arg_2_0:AddBtnListener(arg_2_0.unloadBtn_, nil, function()
		BattleTeamData:UnloadReservesTempTeamChipList(arg_2_0.index, arg_2_0.defaultSelectID_)
	end)
end

function var_0_0.OnEnabledChip(arg_6_0)
	arg_6_0.currentChipList_ = arg_6_0:GetChipData()

	arg_6_0:RefreshUI()
	arg_6_0.chipUIList_:Refresh()
end

function var_0_0.GetChipItem(arg_7_0)
	return ChipItem
end

function var_0_0.GetChipData(arg_8_0)
	return BattleTeamData:GetReservesTempTeamList()[arg_8_0.index].chipInfo.list
end

return var_0_0
