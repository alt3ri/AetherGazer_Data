manager.net:Bind(12097, function (slot0)
	CultureGravureData:InitFromServer(slot0)
end)

return {
	GetSortedEquipIDByEquipList = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			slot10 = EquipData
			slot12 = slot10
			slot13 = slot7

			for slot12, slot13 in ipairs(deepClone(slot10.GetEquipPrefabMap(slot12, slot13))) do
				table.insert(slot2, slot13)
			end
		end

		if #slot2 > 1 then
			table.sort(slot2, function (slot0, slot1)
				if EquipData:GetEquipData(slot0).race ~= EquipData:GetEquipData(slot1).race and (slot2.race == uv0 or slot3.race == uv0) then
					return slot2.race == uv0 and slot3.race ~= uv0
				elseif slot2:GetLevel() ~= slot3:GetLevel() then
					return slot3:GetLevel() < slot2:GetLevel()
				elseif slot2.race ~= slot3.race then
					return slot2.race == HeroCfg[uv0].race and slot3.race ~= HeroCfg[uv0].race
				else
					return #slot2.enchant[1] + #slot2.enchant[2] ~= 0 and #slot3.enchant[1] + #slot3.enchant[2] == 0
				end
			end)
		end

		return slot2
	end,
	EquipByEquiptID = function (slot0, slot1)
		if uv0.GetRecommendEquip(slot0, slot1) then
			HeroAction.EquipSwap(slot0, slot2.id, slot2.pos)

			return true
		end

		return false
	end,
	GetRecommendEquip = function (slot0, slot1)
		for slot9, slot10 in ipairs(uv0.GetSortedEquipIDByEquipList(slot0, CultureGravureData:GetEquiptPrefabListByEquiptID(slot1))) do
			if not HeroData:GetEquipMap()[slot10] then
				return {
					pos = EquipCfg[EquipData:GetEquipData(slot10).prefab_id].pos,
					id = slot10
				}
			end
		end

		return nil
	end,
	EquipByList = function (slot0, slot1)
		EquipAction.EquipQuickDressOn(slot0, uv0.GetRecommendEquipList(slot0, slot1))
	end,
	GetRecommendEquipList = function (slot0, slot1)
		slot2 = {}
		slot3 = HeroData:GetEquipMap()

		for slot7, slot8 in ipairs(slot1) do
			for slot14, slot15 in ipairs(uv0.GetSortedEquipIDByEquipList(slot0, CultureGravureData:GetEquiptPrefabListByEquiptID(slot8))) do
				if not slot3[slot15] or slot3[slot15] == slot0 then
					table.insert(slot2, {
						pos = EquipCfg[EquipData:GetEquipData(slot15).prefab_id].pos,
						equip_id = slot15
					})

					break
				end
			end
		end

		return slot2
	end,
	EquipByServantID = function (slot0, slot1)
		slot4 = {}

		for slot8, slot9 in ipairs(WeaponServantData:GetWeaponServantById(slot1)) do
			if not ServantTools.GetServantMap()[slot9.uid] then
				table.insert(slot4, slot9)
			end
		end

		table.sort(slot4, function (slot0, slot1)
			if slot0.stage ~= slot1.stage then
				return slot1.stage < slot0.stage
			else
				return slot0.uid < slot1.uid
			end
		end)
		ServantAction.ServantReplace(slot0, slot4[1].uid)
	end
}
