return {
	CalHeroEquipAttribute = function (slot0, slot1, slot2)
		slot3 = {
			0,
			0,
			0,
			0,
			0
		}
		slot4 = slot0:GetEquipDataList(slot1)
		slot5 = {}

		if slot2 then
			slot4 = slot2
			slot5 = EquipData:GetEquipList()
		end

		for slot9, slot10 in ipairs(slot4) do
			slot11 = {}

			if (not slot2 or slot5[slot10.equip_id]) and slot10 and slot11.prefab_id ~= 0 then
				slot16 = slot11

				for slot15, slot16 in pairs(EquipTools.CountEquipAttribute(slot16, nil, slot1)) do
					if slot3[slot15] == nil then
						slot3[slot15] = 0
					end

					slot3[slot15] = slot3[slot15] + slot16
				end
			end
		end

		return slot3
	end
}
