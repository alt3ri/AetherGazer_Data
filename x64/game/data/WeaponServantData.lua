slot0 = singletonClass("WeaponServantData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = nil

function slot5(slot0, slot1)
	for slot5, slot6 in ipairs(slot0) do
		if slot1 == slot6 then
			table.remove(slot0, slot5)

			return
		end
	end

	error("未找到需要删除的元素")
end

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
end

function slot0.InitServant(slot0, slot1)
	for slot6, slot7 in ipairs(cleanProtoTable(slot1.servant_list)) do
		slot0:AddServant(slot7)
	end

	manager.notify:Invoke(WEAPON_SERVANT_LIST_UPDATE)
end

function slot0.AddServant(slot0, slot1)
	uv0[slot2] = {
		uid = tonumber(slot1.uid),
		id = slot1.id,
		stage = slot1.stage or 1,
		locked = slot1.is_locked or 0
	}

	if not uv1[slot1.id] then
		uv1[slot1.id] = {}
	end

	uv1[slot1.id][slot2] = true
end

function slot0.RemoveServant(slot0, slot1)
	slot2 = tonumber(slot1.uid)
	uv0[slot1.item.id][slot2] = nil
	uv1[slot2] = nil
end

function slot0.GetServantNum(slot0)
	return table.length(uv0)
end

function slot0.GetWeaponServantList(slot0)
	return uv0
end

function slot0.ServantPromote(slot0, slot1)
	uv0[slot1].stage = uv0[slot1].stage + 1

	manager.notify:Invoke(WEAPON_SERVANT_LIST_UPDATE)
end

function slot0.ServantLock(slot0, slot1, slot2)
	uv0[slot1].locked = slot2

	manager.notify:Invoke(SERVANT_LOCK, slot1, slot2)
end

function slot0.GetServantDataByUID(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetWeaponServantById(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if slot7.id == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetServantSByID(slot0, slot1)
	return uv0[slot1]
end

function slot0.SetServantMergeMap(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetServantMergeMap(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetAllPrivateWeaponServantIdList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(WeaponServantCfg.all) do
		if (WeaponServantCfg[slot6].effect ~= nil or #slot7 > 0) and WeaponServantCfg[slot6].effect[1] ~= 0 and WeaponEffectCfg[slot8].spec_char[1] ~= nil and slot9 > 0 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.GetPrivateWeaponServantIdByHeroID(slot0, slot1)
	for slot5, slot6 in ipairs(WeaponServantCfg.all) do
		if (WeaponServantCfg[slot6].effect ~= nil or #slot7 > 0) and WeaponServantCfg[slot6].effect[1] ~= 0 and WeaponEffectCfg[slot8].spec_char[1] == slot1 then
			return slot6
		end
	end

	return 0
end

function slot0.GetPublicWeaponServantIdByRace(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in pairs(WeaponServantCfg.get_id_list_by_race[slot1]) do
		if (WeaponServantCfg[slot7].effect ~= nil or #slot8 > 0) and WeaponServantCfg[slot7].effect[1] ~= 0 and WeaponEffectCfg[slot9].spec_char[1] == nil and WeaponServantCfg[slot7].starlevel == 5 then
			slot2 = slot7
		end
	end

	return slot2
end

function slot0.GetSortConfig(slot0)
	if not uv0 then
		uv0 = {
			0,
			0
		}
	end

	return uv0
end

function slot0.SetSortConfig(slot0, slot1, slot2)
	uv0[1] = slot1 or uv0[1]
	uv0[2] = slot2 or uv0[2]
end

function slot0.GetDefaultData(slot0, slot1)
	return {
		locked = 0,
		stage = 1,
		uid = 0,
		id = slot1
	}
end

return slot0
