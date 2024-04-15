local var_0_0 = class("ReservesChipManagerView", ChipManagerView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.index_ = arg_1_0.params_.index

	var_0_0.super.OnEnter(arg_1_0)
	manager.windowBar:RegistBackCallBack(function()
		arg_1_0:Back(1, {
			isInit = false
		})
	end)
end

function var_0_0.RefreshChipManagerItem(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.chipManagerList_[arg_3_1]

	arg_3_2:SetIndex(arg_3_0.index_)
	arg_3_2:SetTemplateData(arg_3_0.chipManagerDataTemplate_)
	arg_3_2:SetChipManagerID(var_3_0)
	arg_3_2:RefreshUI(var_3_0 == arg_3_0.defaultSelectID_)
end

function var_0_0.GetChipManagerList(arg_4_0)
	local var_4_0 = BattleTeamData:GetReservesTempTeamList()[arg_4_0.index_].chipInfo.id

	return ChipTools.SortChipManager(var_4_0)
end

function var_0_0.GetChipManagerInfoView(arg_5_0)
	return BattleChipManagerInfoView
end

function var_0_0.GetChipDataTemplate(arg_6_0)
	local var_6_0 = ChipManagerDataTemplate.New({
		id = arg_6_0.defaultSelectID_,
		unlockChipManagerIDList_ = arg_6_0:GetUnlockChipManagerList(),
		unlockChipIDList_ = arg_6_0:GetUnlockChipList()
	})

	var_6_0:SetUseChipmanagerId(arg_6_0.defaultSelectID_)
	var_6_0:SetReservesIndex(arg_6_0.index_)
	var_6_0:SetUseChipmanagerId(BattleTeamData:GetReservesTempTeamList()[arg_6_0.index_].chipInfo.id or 0)
	var_6_0:SetChipInfoViewPath("/reservesChipInfo")

	var_6_0.useChipIdList = BattleTeamData:GetReservesTempTeamList()[arg_6_0.index_].chipInfo.list

	return var_6_0
end

function var_0_0.EnableChipManagerIDFunc(arg_7_0, arg_7_1)
	BattleTeamData:SetReservesTempTeamChip(arg_7_0.index_, arg_7_1)
	arg_7_0:RefreshUI()
	arg_7_0.chipManagerUIList_:Refresh()
end

function var_0_0.GetChipManagerItem(arg_8_0)
	return ReservesChipManagerItem
end

function var_0_0.OnSchemeBtn(arg_9_0)
	arg_9_0:Go("/reservesChipScheme", {
		chipManagerID = arg_9_0.chipManagerID_,
		template = arg_9_0.chipManagerDataTemplate_,
		index = arg_9_0.index_
	})
end

return var_0_0
