EquipStruct = class("EquipStruct")

function EquipStruct.Ctor(slot0, slot1, slot2)
	slot0.equip_id = slot1
	slot0.prefab_id = slot2
	slot0.exp = 0
	slot0.is_lock = false
	slot0.now_break_level = 0
	slot0.enchant = {}
	slot0.enchant_preview = {}
	slot0.race = 0
	slot0.race_preview = 0
	slot0.equipConfig = EquipCfg[slot0.prefab_id]
	slot0.star = slot0.equipConfig and slot0.equipConfig.starlevel or 0
end

function EquipStruct.ParseServerData(slot0, slot1)
	slot0.equip_id = slot1.equip_id
	slot0.prefab_id = slot1.prefab_id
	slot0.exp = slot1.exp or 0
	slot0.is_lock = slot1.is_lock or false
	slot0.now_break_level = slot1.now_break_level or 0
	slot0.enchant = {}
	slot0.enchant_preview = {}

	for slot5, slot6 in ipairs(slot1.enchant_slot_list) do
		slot7 = slot6.id

		for slot12, slot13 in ipairs(slot6.effect_list) do
			table.insert({}, {
				id = slot13.id,
				num = slot13.level
			})
		end

		slot9 = {}

		for slot13, slot14 in ipairs(slot6.preview_list) do
			slot15 = {}

			for slot19, slot20 in ipairs(slot14.effect_list) do
				table.insert(slot15, {
					id = slot20.id,
					num = slot20.level
				})
			end

			table.insert(slot9, slot15)
		end

		slot0.enchant[slot7] = slot8
		slot0.enchant_preview[slot7] = slot9
	end

	slot0.race = slot1.race or 0
	slot0.race_preview = slot1.race_preview or 0
	slot0.equipConfig = EquipCfg[slot0.prefab_id]
	slot0.star = slot0.equipConfig and slot0.equipConfig.starlevel or 0
end

function EquipStruct.GetBreakCostReturn(slot0)
	slot4 = {}

	if (GameSetting.equip_break_cost_return and GameSetting.equip_break_cost_return.value or {})[slot0.equipConfig.starlevel] ~= nil then
		for slot8 = 1, slot0.now_break_level do
			if slot3[slot8] ~= nil then
				slot11 = EquipMaterialCfg[slot9].item_list or {}

				for slot15 = 2, #slot11 do
					table.insert(slot4, slot11[slot15])
				end
			end
		end
	end

	if slot1 > 4 and GameSetting.equip_resolve_num and GameSetting.equip_resolve_num.value[slot1 - 4] then
		table.insert(slot4, slot5)
	end

	return slot4
end

function EquipStruct.GetLevel(slot0)
	for slot7 = 2, slot0:GetMaxLv() do
		if (slot0.exp or 0) < EquipExpCfg[slot7]["exp_sum_" .. slot0.equipConfig.starlevel] then
			return slot7 - 1
		end
	end

	return slot2
end

function EquipStruct.GetMaxLv(slot0)
	return slot0.equipConfig.max_level[slot0.now_break_level + 1]
end

function EquipStruct.GetPos(slot0)
	return slot0.equipConfig and slot0.equipConfig.pos or 0
end

function EquipStruct.GetSuit(slot0)
	return slot0.equipConfig and slot0.equipConfig.suit or 0
end

function EquipStruct.GetEquipHero(slot0)
	return HeroData:GetEquipMap()[slot0.equip_id]
end

function EquipStruct.GetBaseSkill(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0.equipConfig.effect) do
		if slot7[1] then
			table.insert(slot1, {
				id = slot7[1],
				num = slot7[2],
				unlockLevel = slot2.effect_unlock_level[slot6] or 0
			})
		end
	end

	return slot1
end

function EquipStruct.GetTotalSkill(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot8 = slot0

	table.insertto({}, slot0.GetBaseSkill(slot8))

	for slot8, slot9 in pairs(clone(slot0.enchant)) do
		table.insertto(slot1, slot9)
	end

	for slot8, slot9 in ipairs(slot1) do
		if slot2[slot9.id] then
			slot2[slot9.id].num = slot2[slot9.id].num + slot9.num
		else
			slot2[slot9.id] = slot9

			table.insert(slot4, slot9.id)
		end
	end

	for slot8 = 1, #slot4 do
		table.insert(slot3, slot2[slot4[slot8]])
	end

	return slot3
end

function EquipStruct.ContainSkill(slot0, slot1)
	slot2 = slot0:GetTotalSkill()

	for slot6, slot7 in pairs(slot1) do
		slot8 = false

		for slot12, slot13 in pairs(slot2) do
			if slot13.id == slot7 then
				slot8 = true

				break
			end
		end

		if slot8 == false then
			return false
		end
	end

	return true
end

function EquipStruct.GetSkillLevel(slot0, slot1)
	slot5 = EquipCfg[slot0.prefab_id].slot_open_level or {}

	for slot10, slot11 in pairs(slot0:GetBaseSkill()) do
		if slot11.id == slot1 and slot5[slot10] and slot5[slot10] <= slot0:GetLevel() then
			slot2 = 0 + slot11.num
		end
	end

	for slot10, slot11 in pairs(slot0.enchant) do
		for slot15, slot16 in pairs(slot11) do
			if slot16.id == slot1 then
				slot2 = slot2 + slot16.num
			end
		end
	end

	return slot2
end

function EquipStruct.GetUpgradeCost(slot0)
	if not EquipMaterialCfg[slot0.equipConfig.break_cost[slot0.now_break_level + 1]] then
		return {}
	end

	slot4 = 0
	slot5 = {}

	for slot9, slot10 in pairs(slot3.item_list) do
		if slot10[1] == 2 then
			slot4 = slot10[2]
		else
			table.insert(slot5, slot10)
		end
	end

	return {
		item_list = slot5,
		money = slot4
	}
end

function EquipStruct.GetEnchantCount(slot0)
	for slot5, slot6 in pairs(slot0.enchant) do
		if #slot6 > 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

slot0 = singletonClass("EquipData")
slot1 = {}
slot2 = {}
slot3 = false
slot4 = {}
slot5 = {}
slot6 = {}
slot7 = 1
slot8 = 0
slot9 = 0
slot10 = 0
slot11 = 1

function slot0.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = false
	uv3 = {}
	uv4 = {}
	uv5 = 1
	uv6 = {}
end

function slot0.EquipInit(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:AddEquip(slot6)
	end

	slot0:ResetEquipSort()
	manager.notify:Invoke(EQUIP_LIST_UPDATE)
end

function slot0.AddEquip(slot0, slot1)
	slot2 = EquipStruct.New(slot1.equip_id, slot1.prefab_id)

	slot2:ParseServerData(slot1)

	uv0[slot1.equip_id] = slot2
	uv1[slot3] = uv1[EquipCfg[slot1.prefab_id].suit] or {}
	uv1[slot3][slot1.equip_id] = true
	uv2[slot1.prefab_id] = uv2[slot1.prefab_id] and uv2[slot1.prefab_id] + 1 or 1

	if not uv3[slot1.prefab_id] then
		uv3[slot1.prefab_id] = {}
	end

	if not table.indexof(uv3[slot1.prefab_id], slot1.equip_id) then
		table.insert(uv3[slot1.prefab_id], slot1.equip_id)
	end
end

function slot0.ApplyEquipStrengthSuccess(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1
	slot6 = slot2
	uv0[slot5].exp = uv0[slot5].exp + slot4

	slot0:ResetEquipSort()
end

function slot0.ApplyLockEquipSuccess(slot0, slot1, slot2)
	uv0[slot1].is_lock = slot2
end

function slot0.ApplyUpgradeEquipSuccess(slot0, slot1)
	slot2 = slot1
	slot4 = EquipCfg[uv0[slot2].prefab_id]
	uv0[slot2].now_break_level = uv0[slot2].now_break_level + 1
	uv0[slot2].exp = EquipExpCfg[slot4.max_level[uv0[slot2].now_break_level + 1]]["exp_sum_" .. slot4.starlevel]

	slot0:ResetEquipSort()
end

function slot0.RemoveEquip(slot0, slot1)
	uv1[slot4] = uv1[EquipCfg[uv0[slot1.equip_id].prefab_id].suit] or {}
	uv1[slot4][slot2] = nil
	uv0[slot2] = nil
	uv2[slot3] = uv2[slot3] - 1

	for slot8, slot9 in pairs(uv3) do
		for slot13, slot14 in pairs(slot9) do
			if slot2 == slot14.equip_id then
				table.remove(slot9, slot13)

				break
			end
		end
	end

	uv4 = false
end

function slot0.EquipBagFull(slot0, slot1)
	uv0 = slot1
end

function slot0.AddPreEnchant(slot0, slot1, slot2, slot3)
	if uv0[slot1] and slot4.enchant_preview[slot2] then
		slot6 = {}

		for slot10, slot11 in ipairs(slot3.effect_list) do
			table.insert(slot6, {
				id = slot11.id,
				num = slot11.level
			})
		end

		table.insert(slot4.enchant_preview[slot2], slot6)
	end
end

function slot0.ConfirmEnchant(slot0, slot1, slot2, slot3, slot4)
	if uv0[slot1] and slot5.enchant_preview[slot2] then
		slot6 = table.remove(slot5.enchant_preview[slot2], slot4)

		if slot3 and slot6 then
			slot5.enchant[slot2] = slot6
		end
	end
end

function slot0.GiveUpAllEnchant(slot0, slot1, slot2)
	if uv0[slot1] and slot3.enchant_preview[slot2] then
		slot3.enchant_preview[slot2] = {}
	end
end

function slot0.SetPreRace(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].race_preview = slot2
	end
end

function slot0.ConfirmRace(slot0, slot1, slot2)
	if uv0[slot1] then
		if slot2 then
			uv0[slot1].race = uv0[slot1].race_preview
		end

		uv0[slot1].race_preview = 0

		slot0:ResetEquipSort()
	end
end

function slot0.GetEquipList(slot0)
	return uv0
end

function slot0.GetEquipData(slot0, slot1)
	if uv0[slot1] then
		return slot2
	else
		return nil
	end
end

function slot0.GetEquipPrefabMap(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetEquipBagFull(slot0)
	return uv0
end

function slot0.GetEquipListBySort(slot0, slot1, slot2)
	if uv0[slot1 .. slot2] then
		return uv0[slot3]
	end

	uv0[slot3] = EquipTools.EquipSort(uv1, slot1, slot2)

	return uv0[slot3]
end

function slot0.GetEquipListComplex(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = EquipTools.EquipSort(uv0, slot1, slot2)
	slot3 = slot3 or 0
	slot5 = slot5 or 0

	if type(slot4 or 0) == "table" and #slot4 == 0 then
		slot4 = 0
	end

	if type(slot5) == "table" and #slot5 == 0 then
		slot5 = 0
	end

	slot7 = {}
	slot8 = {}

	for slot12, slot13 in ipairs(slot6) do
		slot14 = EquipCfg[slot13.prefab_id]

		if (slot3 == 0 or slot14.pos == slot3) and (slot4 == 0 or slot14.suit == slot4 or type(slot4) == "table" and table.indexof(slot4, slot14.suit) or slot4 == EquipConst.EX_EQUIP_SUIT_ID and EquipConst.EX_EQUIP_SUIT_ID <= slot14.suit) and (slot5 == 0 or slot13:ContainSkill(slot5)) then
			table.insert(slot7, slot13)
			table.insert(slot8, slot13.equip_id)
		end
	end

	return slot7, slot8
end

function slot0.ResetEquipSort(slot0)
	uv0 = {}
end

function slot0.GetEnchantMaterial(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(GameSetting.equip_enchant_cost and GameSetting.equip_enchant_cost.value or {}) do
		slot8 = EquipMaterialCfg[slot7] or {}

		table.insert(slot2, {
			id = slot8.item_list[2][1],
			number = slot8.item_list[2][2],
			money = slot8.item_list[1][2]
		})
	end

	return slot2
end

function slot0.GetLockEnchantMaterial(slot0)
	slot3 = clone(slot0:GetEnchantMaterial())

	for slot7, slot8 in pairs(GameSetting.equip_enchant_lock_cost and GameSetting.equip_enchant_lock_cost.value or {}) do
		slot9 = EquipMaterialCfg[slot8] or {}
		slot11 = slot9.item_list[2][1]

		for slot16, slot17 in ipairs(slot3) do
			if slot17.id == slot11 then
				slot3[slot16].id = slot11
				slot3[slot16].number = slot9.item_list[2][2]
				slot3[slot16].money = slot9.item_list[1][2]
				slot3[slot16].lock = true
			end
		end
	end

	return slot3
end

function slot0.GetRaceMaterial(slot0, slot1)
	slot2 = nil
	slot4 = (slot1 == 1 and (GameSetting.equip_reset_cost and GameSetting.equip_reset_cost.value or {}) or GameSetting.equip_hero_reset_cost and GameSetting.equip_hero_reset_cost.value or {})[1] or 0
	slot4 = 0
	slot5 = 0
	slot6 = 0

	for slot10, slot11 in pairs(EquipMaterialCfg[slot4].item_list) do
		if slot11[1] == 2 then
			slot6 = slot11[2]
		else
			slot4 = slot11[1]
			slot5 = slot11[2]
		end
	end

	return {
		id = slot4,
		number = slot5,
		money = slot6
	}
end

function slot0.GetEquipCnt(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.GetSelectEnchantMaterialIndex(slot0)
	return uv0
end

function slot0.SetSelectEnchantMaterialIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.SetEnchatLockIndex(slot0, slot1, slot2, slot3)
	uv0 = slot1
	uv1 = slot2
	uv2 = slot3
end

function slot0.GetIsSetLockView(slot0, slot1, slot2)
	if uv0 == slot1 and uv1 == slot2 then
		return uv2
	end

	return false
end

function slot0.GetRaceIndex(slot0)
	return uv0
end

function slot0.SetRaceIndex(slot0, slot1)
	uv0 = slot1
end

function slot0.GetInheritCost(slot0, slot1)
	slot2 = GameSetting.equip_inherit_cost and GameSetting.equip_inherit_cost.value or {}
	slot3 = {}
	slot4 = 0

	if EquipSuitCfg[slot1] ~= nil then
		slot6 = nil

		for slot10, slot11 in pairs(((EquipSuitCfg[slot1].inherit_cost_type ~= 1 or EquipMaterialCfg[slot2[1] or 0]) and EquipMaterialCfg[slot2[2] or 0]).item_list) do
			slot12 = {}

			if slot11[1] == 2 then
				slot4 = slot11[2]
			else
				slot12.id = slot11[1]
				slot12.number = slot11[2]
				slot3[#slot3 + 1] = slot12
			end
		end
	end

	return slot3, slot4
end

return slot0
