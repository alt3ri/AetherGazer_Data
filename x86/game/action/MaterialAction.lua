manager.net:Bind(17007, function (slot0)
	MaterialData:InitExpiredMaterialList(slot0.invalid_item_list)
end)
manager.net:Bind(17009, function (slot0)
	MaterialData:InitMaterialList(slot0.material_list)
end)

return {
	MaterialModify = function (slot0, slot1, slot2)
		print("TODO: 废弃接口", debug.traceback())
	end,
	ReadExpiredMaterial = function ()
		manager.net:SendWithLoadingNew(17018, {
			nothing = 0
		}, 17019, uv0.OnReadExpiredMaterialCallback)
	end,
	OnReadExpiredMaterialCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = {}

			for slot7, slot8 in ipairs(MaterialData:CheckExpiredMaterialList()) do
				if ItemTimeLimitExchangeCfg[slot8.id] then
					if not slot2[slot11.exchange_item[1]] then
						slot2[slot11.exchange_item[1]] = slot11.exchange_item[2] * slot8.num
					else
						slot2[slot11.exchange_item[1]] = slot2[slot11.exchange_item[1]] + slot11.exchange_item[2] * slot10
					end
				end
			end

			MaterialData:ClearExpiredMaterialList()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SetMaterialValue = function (slot0, slot1, slot2)
		MaterialData:SetMaterialValue(slot0, slot1, slot2)
	end
}
