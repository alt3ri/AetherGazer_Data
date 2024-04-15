slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}

return {
	InitFromServer = function (slot0, slot1)
		for slot5, slot6 in ipairs(cleanProtoTable(slot1.astro)) do
			uv0[slot6.id] = {}

			for slot10, slot11 in pairs(cleanProtoTable(slot6.rate_list)) do
				slot12 = {}
				slot13 = slot11.rate

				for slot17, slot18 in pairs(cleanProtoTable(slot11.id_list)) do
					table.insert(slot12, slot18)
				end

				table.insert(uv0[slot6.id], {
					list = slot12,
					rate = slot13
				})
			end

			table.sort(uv0[slot6.id], function (slot0, slot1)
				return slot1.rate < slot0.rate
			end)
		end

		for slot5, slot6 in ipairs(cleanProtoTable(slot1.common_equip)) do
			uv1[slot6.id] = {}

			for slot10, slot11 in pairs(cleanProtoTable(slot6.rate_list)) do
				slot12 = {}
				slot13 = slot11.rate

				for slot17, slot18 in pairs(cleanProtoTable(slot11.id_list)) do
					table.insert(slot12, slot18)
				end

				table.insert(uv1[slot6.id], {
					list = slot12,
					rate = slot13
				})
			end

			table.sort(uv1[slot6.id], function (slot0, slot1)
				return slot1.rate < slot0.rate
			end)
		end

		for slot5, slot6 in ipairs(cleanProtoTable(slot1.omega_equip)) do
			uv2[slot6.id] = {}

			for slot10, slot11 in pairs(cleanProtoTable(slot6.rate_list)) do
				slot12 = {}
				slot13 = slot11.rate

				for slot17, slot18 in pairs(cleanProtoTable(slot11.id_list)) do
					table.insert(slot12, slot18)
				end

				table.insert(uv2[slot6.id], {
					list = slot12,
					rate = slot13
				})
			end

			table.sort(uv2[slot6.id], function (slot0, slot1)
				return slot1.rate < slot0.rate
			end)
		end

		uv3:InitServantList()
	end,
	InitServantList = function (slot0)
		for slot5, slot6 in pairs(EquipRecommendCfg.all) do
			slot7 = HeroCfg[slot6]
			uv0[slot7.id] = {}

			if WeaponServantData:GetPrivateWeaponServantIdByHeroID(slot7.id) ~= 0 then
				table.insert(uv0[slot7.id], slot8)
			end

			table.insert(uv0[slot7.id], WeaponServantData:GetPublicWeaponServantIdByRace(slot7.race))
			table.insert(uv0[slot7.id], EquipRecommendCfg[slot7.id].weapon[1])
		end
	end,
	GetServantListByID = function (slot0, slot1)
		return uv0[slot1] or {}
	end,
	GetAstroListByID = function (slot0, slot1)
		return uv0[slot1] or {}
	end,
	GetCommonEquiptListByID = function (slot0, slot1)
		return uv0[slot1] or {}
	end,
	GetOmegaEquiptListByID = function (slot0, slot1)
		return uv0[slot1] or {}
	end,
	GetServantIsEquipped = function (slot0, slot1, slot2)
		slot4 = ServantTools.GetServantMap()

		for slot8, slot9 in pairs(WeaponServantData:GetWeaponServantList()) do
			if slot4[slot9.uid] and slot4[slot9.uid] == slot1 and slot9.id == slot2 then
				return true
			end
		end

		return false
	end,
	GetHasServant = function (slot0, slot1)
		for slot7, slot8 in pairs(WeaponServantData:GetWeaponServantById(slot1)) do
			if not ServantTools.GetServantMap()[slot8.uid] then
				return true
			end
		end

		return false
	end,
	GetEquiptIsEquipped = function (slot0, slot1, slot2)
		for slot7, slot8 in pairs(HeroData.GetEquipMap()) do
			slot9 = EquipData:GetEquipData(slot7)

			for slot14, slot15 in pairs(uv0:GetEquiptPrefabListByEquiptID(slot2)) do
				if slot9 and slot9.prefab_id == slot15 and slot8 == slot1 then
					return true
				end
			end
		end

		return false
	end,
	GetHasEquipt = function (slot0, slot1)
		slot3 = HeroData:GetEquipMap()
		slot4 = {}

		for slot8, slot9 in ipairs(uv0:GetEquiptPrefabListByEquiptID(slot1)) do
			for slot14, slot15 in ipairs(EquipData:GetEquipPrefabMap(slot9)) do
				if not slot3[slot15] then
					table.insert(slot4, slot15)
				end
			end
		end

		return #slot4 ~= 0
	end,
	ReplaceAndInsert = function (slot0, slot1)
		slot2 = tostring(slot1)
		slot3 = {}

		for slot7 = 1, 9 do
			table.insert(slot3, tonumber(slot2:sub(1, 2) .. slot7 .. slot2:sub(4)))
		end

		table.insert(slot3, tonumber(5 .. slot2:sub(2, 2) .. 0 .. slot2:sub(4)))

		return slot3
	end,
	GetEquiptPrefabListByEquiptID = function (slot0, slot1)
		if EquipData:GetEquipCnt(slot1) ~= 0 then
			table.insert({}, slot1)
		end

		for slot7, slot8 in ipairs(uv0:ReplaceAndInsert(slot1)) do
			if slot8 ~= slot1 and EquipData:GetEquipCnt(slot8) ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end,
	GetIsNeedPopRecommendTipsByHeroID = function (slot0, slot1)
		slot2 = HeroData:GetHeroData(slot1)
		slot4 = true
		slot5 = slot2.servant_uid ~= 0
		slot6 = #slot2.using_astrolabe == 3

		for slot10, slot11 in pairs(slot2.equip) do
			if slot11.equip_id == 0 then
				slot4 = false
			end
		end

		return slot4 and slot5 and slot6
	end,
	GetHasEquippedAllAstro = function (slot0, slot1, slot2)
		if #HeroData:GetHeroData(slot1).using_astrolabe < #slot2 then
			return false
		end

		for slot8, slot9 in pairs(slot2) do
			for slot13, slot14 in pairs(slot4) do
				if slot14 == slot9 then
					break
				end

				if slot13 == #slot4 then
					return false
				end
			end
		end

		return true
	end,
	GetHasUnlockAllAstro = function (slot0, slot1, slot2)
		slot4 = HeroData:GetHeroData(slot1).unlocked_astrolabe

		for slot8, slot9 in pairs(slot2) do
			if #slot4 < 1 then
				return false, slot9
			end

			for slot13, slot14 in pairs(slot4) do
				if slot14 == slot9 then
					break
				end

				if slot13 == #slot4 then
					return false, slot9
				end
			end
		end

		return true, 0
	end
}
