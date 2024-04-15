local var_0_0 = class("MythicChipManagerView", ChipManagerView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.stageType_ = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	arg_1_0.teamID_ = arg_1_0.params_.chessTeamID
	arg_1_0.activityID_ = arg_1_0.params_.activityID

	arg_1_0.chipManagerUnlockView_:SetTeamInfo(arg_1_0.stageType_, arg_1_0.activityID_, nil, arg_1_0.teamID_)
	var_0_0.super.OnEnter(arg_1_0)
end

function var_0_0.GetManagerUnlockView(arg_2_0)
	return MythicChipManagerUnlockView
end

function var_0_0.RefreshChipManagerItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_2:SetTeamID(arg_3_0.teamID_)
	var_0_0.super.RefreshChipManagerItem(arg_3_0, arg_3_1, arg_3_2)
end

function var_0_0.GetChipManagerItem(arg_4_0)
	return MythicChipManagerItem
end

function var_0_0.GetChipManagerList(arg_5_0)
	local var_5_0 = BattleTeamData:GetMimirInfo(arg_5_0.stageType_, arg_5_0.activityID_, nil, arg_5_0.teamID_)

	return ChipTools.SortChipManager(var_5_0)
end

function var_0_0.EnableChipIDFunc(arg_6_0, arg_6_1)
	BattleTeamData:SetMimirIDInfo(arg_6_0.stageType_, arg_6_0.activityID_, arg_6_1, nil, arg_6_0.teamID_)
end

return var_0_0
