local var_0_0 = class("SectionSelectHeroMatrixChip", import("..SectionSelectHeroChip"))

function var_0_0.AddListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		if arg_1_0:GetChipManagerID() == 0 then
			-- block empty
		else
			arg_1_0:Go("/chipMatrixManager")
		end
	end)
end

function var_0_0.GetChipManagerID(arg_3_0)
	return MatrixData:GetChipManagerID()
end

function var_0_0.GetChipList(arg_4_0)
	return MatrixData:GetChipList()
end

return var_0_0
