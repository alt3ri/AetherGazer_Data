local var_0_0 = class("ReservesChipManagerItem", ChipManagerItem)

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		arg_1_0:Go("/reservesChipManager", {
			index = arg_1_0.index_,
			chipManagerID = arg_1_0.chipManagerID_
		})
	end)
end

function var_0_0.SetIndex(arg_3_0, arg_3_1)
	arg_3_0.index_ = arg_3_1
end

return var_0_0
