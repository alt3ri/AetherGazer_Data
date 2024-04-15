local var_0_0 = class("SectionChipEquipBreakThroughView", import("..SectionSelectHeroChip"))

function var_0_0.AddListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.btn_, nil, function()
		if arg_1_0:GetChipManagerID() == 0 then
			-- block empty
		else
			arg_1_0:Go("/chipEquipBreakThroughManager")
		end
	end)
end

function var_0_0.GetChipManagerID(arg_3_0)
	return EquipBreakThroughMaterialData:GetChipManagerID()
end

function var_0_0.GetChipList(arg_4_0)
	return EquipBreakThroughMaterialData:GetChipList()
end

return var_0_0
