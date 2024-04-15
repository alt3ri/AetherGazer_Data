local var_0_0 = class("MythicChipManagerItem", ChipManagerItem)

function var_0_0.SetTeamID(arg_1_0, arg_1_1)
	arg_1_0.teamID_ = arg_1_1
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		arg_2_0:Go("/mythicChipManagerView", {
			chipManagerID = arg_2_0.chipManagerID_,
			chessTeamID = arg_2_0.teamID_
		})
	end)
end

function var_0_0.RefreshEnabledUI(arg_4_0)
	SetActive(arg_4_0.usingGo_, arg_4_0.chipManagerID_ == arg_4_0:GetEnabledChipManagerID())
end

function var_0_0.GetEnabledChipManagerID(arg_5_0)
	return (BattleTeamData:GetMimirInfo(BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL, nil, nil, arg_5_0.teamID_))
end

return var_0_0
