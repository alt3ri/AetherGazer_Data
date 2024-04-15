slot1 = import("bit")

return {
	GetAllSuits = function ()
		slot0 = {}

		for slot4, slot5 in pairs(EquipSuitCfg.get_id_list_by_suit) do
			table.insert(slot0, slot4)
		end

		return slot0
	end,
	GetEquipNum = function ()
		for slot5, slot6 in pairs(EquipData:GetEquipList()) do
			slot0 = 0 + 1
		end

		return slot0
	end,
	GetEquipListByPrefabId = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(EquipData:GetEquipList()) do
			if slot7.prefab_id == slot0 then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end,
	GetEquipListByEquipid = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(EquipData:GetEquipList()) do
			if EquipCfg[slot7.prefab_id].pos == EquipCfg[slot0].pos and slot9.suit == slot8.suit and slot9.starlevel == slot8.starlevel then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end,
	GetHaveSuitList = function (slot0)
		for slot7, slot8 in pairs(EquipData:GetEquipList()) do
			if not HideInfoData:GetEquipSuitHideList()[EquipCfg[slot8.prefab_id].suit] then
				-- Nothing
			end
		end

		for slot8, slot9 in pairs({
			[slot9.suit] = true
		}) do
			table.insert({}, tonumber(slot8))
		end

		if slot0 then
			for slot8, slot9 in ipairs(EquipSuitCfg.all) do
				if not slot2[slot9] and not slot3[slot9] then
					table.insert(slot4, slot9)
				end
			end
		end

		return slot4, slot2
	end,
	GetIsHaveExEquip = function ()
		for slot4, slot5 in pairs(EquipData:GetEquipList()) do
			if EquipConst.EX_EQUIP_SUIT_ID <= EquipCfg[slot5.prefab_id].suit then
				return true
			end
		end

		return false
	end,
	IsHaveEquip = function (slot0)
		slot1 = EquipData:GetEquipList()
		slot2 = {}
		slot3 = {
			[slot8] = false
		}

		for slot7, slot8 in ipairs(slot0) do
			-- Nothing
		end

		for slot7, slot8 in pairs(slot1) do
			if table.indexof(slot0, slot8.prefab_id) then
				slot3[slot8.prefab_id] = true
			end
		end

		return slot3
	end,
	GetFreeEquipByEquipId = function (slot0, slot1)
		slot2 = HeroTools.GetEquipMap(HeroData:GetHeroList())
		slot3 = {}
		slot4 = {}
		slot5 = false
		slot6 = false
		slot9 = EquipData
		slot11 = slot9

		for slot10, slot11 in pairs(slot9.GetEquipList(slot11)) do
			slot13 = slot11.equip_id
			slot14 = false
			slot15 = nil

			for slot19, slot20 in ipairs(slot0) do
				if EquipTools.IsSameEquip(slot20, slot11.prefab_id) then
					slot14 = true
					slot15 = slot20

					break
				end
			end

			if slot14 then
				if not slot4[slot15] then
					slot4[slot15] = {}
				end

				table.insert(slot4[slot15], slot11)

				slot6 = true

				if slot2[slot13] == nil or slot2[slot13] == slot1 then
					if not slot3[slot15] then
						slot3[slot15] = {}
					end

					table.insert(slot3[slot15], slot11)

					slot5 = true
				end
			end
		end

		return slot3, slot4, slot5, slot6, slot2
	end,
	IsSameEquip = function (slot0, slot1)
		if EquipCfg[slot0].pos == EquipCfg[slot1].pos and slot2.starlevel == slot3.starlevel and slot2.suit == slot3.suit then
			return true
		end

		return false
	end,
	GetHaveSkillList = function (slot0)
		slot2 = {}

		for slot6, slot7 in pairs(EquipData:GetEquipList()) do
			for slot12, slot13 in ipairs(EquipCfg[slot7.prefab_id].effect) do
				if slot13[1] then
					slot2[slot13[1]] = true
				end
			end

			for slot12, slot13 in pairs(slot7.enchant) do
				for slot17, slot18 in ipairs(slot13) do
					if slot18 and slot18.id then
						slot2[slot18.id] = true
					end
				end
			end
		end

		for slot7, slot8 in pairs(slot2) do
			table.insert({}, tonumber(slot7))
		end

		if slot0 then
			slot7 = EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT

			for slot7, slot8 in ipairs(EquipSkillCfg.get_id_list_by_skill_type[slot7]) do
				if not slot2[slot8] then
					table.insert(slot3, slot8)
				end
			end
		end

		return slot3
	end,
	GetHeroEquipSuitPos = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = 0

		if slot0 and slot0 ~= 0 then
			for slot10, slot11 in pairs(HeroData:GetHeroList()[slot0].equip) do
				if slot11.equip_id and slot12 ~= 0 and EquipCfg[EquipData:GetEquipList()[slot12].prefab_id].suit == slot1 then
					slot3[slot14.pos] = true
					slot4 = slot4 + 1
				end
			end
		elseif slot2 then
			slot3[slot2] = true
			slot4 = slot4 + 1
		end

		return slot3, slot4
	end,
	GetEquipedHeroId = function (slot0)
		for slot5, slot6 in pairs(HeroData:GetHeroList()) do
			for slot10, slot11 in pairs(slot6.equip) do
				if slot11.equip_id == slot0 then
					return slot5
				end
			end
		end

		return 0
	end,
	CountActiveSuit = function (slot0)
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if slot7.equip_id ~= 0 then
				slot8 = nil

				if slot2[EquipCfg[(not slot7.prefab_id or slot7.prefab_id) and EquipData:GetEquipList()[slot7.equip_id].prefab_id].suit] then
					slot2[slot9.suit].num = slot2[slot9.suit].num + 1
					slot2[slot9.suit].pos[slot9.pos] = true
				else
					slot2[slot9.suit] = {
						num = 1,
						id = slot9.suit,
						pos = {
							[slot9.pos] = true
						}
					}
				end
			end
		end

		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot8)
		end

		return slot3
	end,
	GetSuitNeedNum = function (slot0, slot1)
		if EquipSuitCfg[slot0].need < 3 or not slot1 then
			return slot2.need
		else
			return slot2.need - 1
		end
	end,
	CountHeroTotalSkill = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if slot9.equip_id and slot9.equip_id ~= 0 then
				slot12 = {}

				for slot16 = 1, #EquipCfg[slot9.prefab_id].effect do
					if slot10.effect[slot16] and slot10.effect_unlock_level[slot16] <= uv0.CountEquipLevel(slot9) then
						slot3[slot18] = (slot3[slot17[1]] or 0) + slot17[2]
						slot12[slot18] = (slot12[slot18] or 0) + slot17[2]
					end
				end

				for slot16, slot17 in pairs(slot9.enchant) do
					for slot21, slot22 in ipairs(slot17) do
						if slot22 and slot22.id then
							slot3[slot23] = (slot3[slot22.id] or 0) + slot22.num
							slot12[slot23] = (slot12[slot23] or 0) + slot22.num
						end
					end
				end

				for slot16, slot17 in pairs(slot12) do
					slot4[slot16] = slot4[slot16] or {}

					table.insert(slot4[slot16], {
						isEquip = true,
						id = slot9.equip_id,
						level = slot17,
						prefab_id = slot9.prefab_id
					})
				end
			end
		end

		slot5 = HeroTools.GetHeroEquipSkillAddLevel(slot1)

		for slot9, slot10 in pairs(slot3) do
			slot3[slot9] = slot10 + slot5

			if slot5 ~= 0 then
				table.insert(slot4[slot9], {
					isEquip = false,
					level = slot5
				})
			end
		end

		if not slot2 then
			for slot9, slot10 in pairs(slot3) do
				if EquipSkillCfg[slot9].lvmax < slot10 then
					slot3[slot9] = slot11.lvmax
				end
			end
		end

		return slot3, slot5 > 0, slot4
	end,
	CountEquipAttribute = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = EquipCfg[slot0.prefab_id]
		slot5 = uv0.CountEquipLevel(slot0)
		slot6 = slot0.now_break_level + 1
		slot7 = false
		slot8 = false

		if slot2 and slot0.race ~= 0 then
			if slot0.race == HeroCfg[slot2].race then
				slot7 = true
			end

			if slot0.race == slot2 then
				slot8 = true
			end
		end

		for slot13, slot14 in pairs(slot4.fixed_attributes[slot6]) do
			slot3[slot14[1]] = slot14[2] + slot14[3] * (slot5 - 1)

			if slot7 then
				slot3[slot15] = slot3[slot15] * 1.2
			end

			if slot8 then
				slot3[slot15] = slot3[slot15] * GameSetting.equip_hero_strengthen_num.value[1]
			end
		end

		if slot1 then
			for slot13 = 1, #slot4.effect do
				if slot4.effect[slot13] and slot4.effect_unlock_level[slot13] <= slot5 then
					slot15 = EquipSkillCfg[slot14[1]]
					slot3[slot17] = (slot3[slot15.attribute] or 0) + slot15.upgrade * slot14[2]
				end
			end

			if slot0.enchant then
				for slot13, slot14 in pairs(slot0.enchant) do
					for slot18, slot19 in ipairs(slot14) do
						if slot19 and slot19.id then
							slot20 = EquipSkillCfg[slot19.id]
							slot3[slot22] = (slot3[slot20.attribute] or 0) + slot20.upgrade * slot19.num
						end
					end
				end
			end
		end

		return slot3
	end,
	CountEquipMaxLv = function (slot0)
		return EquipCfg[slot0.prefab_id].max_level[slot0.now_break_level + 1]
	end,
	CountEquipLevel = function (slot0)
		slot1 = slot0.exp or 0

		for slot8 = 1, uv0.CountEquipMaxLv(slot0) - 1 do
			if slot1 < EquipExpCfg[slot8]["exp" .. EquipCfg[slot0.prefab_id].starlevel] then
				return slot8
			end

			slot1 = slot1 - slot9
		end

		return slot2
	end,
	CountSingleEquipAttribute = function (slot0, slot1)
		for slot9, slot10 in ipairs(EquipCfg[slot0.prefab_id].fixed_attributes[slot0.now_break_level + 1]) do
			if slot10[1] == slot1 then
				return slot10[2] + slot10[3] * (uv0.CountEquipLevel(slot0) - 1)
			end
		end

		return 0
	end,
	CalHeroVirtualEquipAttribute = function (slot0, slot1, slot2)
		slot3 = {
			0,
			0,
			0,
			0
		}

		for slot7, slot8 in pairs(slot0) do
			if slot8.prefab_id ~= 0 then
				slot13 = slot8

				for slot12, slot13 in pairs(uv0.CountEquipAttribute(slot13, false, slot1.id)) do
					if slot3[slot12] == nil then
						slot3[slot12] = 0
					end

					slot3[slot12] = slot3[slot12] + slot13
				end
			end
		end

		if not slot2 then
			for slot8, slot9 in pairs(uv0.CountHeroTotalSkill(slot0, slot1)) do
				slot10 = EquipSkillCfg[slot8]
				slot3[slot12] = (slot3[slot10.attribute] or 0) + slot10.upgrade * slot9
			end
		end

		return slot3
	end,
	GetHeroEquipS = function (slot0)
		for slot6, slot7 in pairs(HeroData:GetHeroList()[slot0].equip) do
			-- Nothing
		end

		return {
			[slot7.pos] = EquipData:GetEquipList()[slot7.equip_id]
		}
	end,
	GetEquipDataList = function (slot0)
		slot1 = {}

		for slot5 = 1, 6 do
			slot6 = nil

			if slot0[slot5].equip_id ~= 0 then
				slot6 = EquipData:GetEquipData(slot0[slot5].equip_id)
			end

			slot1[slot5] = slot6
		end

		return slot1
	end,
	GetEffectS = function (slot0, slot1)
		slot2 = {}
		slot3 = false

		if slot1 then
			slot3 = HeroTools.GetIsSuitNumCut(slot1)
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot0) do
			if slot4[EquipCfg[slot9.prefab_id].suit] == nil then
				slot4[slot11] = 0
			end

			slot4[slot11] = slot4[slot11] + 1
		end

		for slot8, slot9 in pairs(slot4) do
			for slot14, slot15 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot8]) do
				slot16 = EquipSuitCfg[slot15]

				if uv0.GetSuitNeedNum(slot15, slot3) <= slot9 and slot16.suit_effect then
					for slot21, slot22 in pairs(slot16.suit_effect) do
						slot2[slot22] = true
					end
				end
			end
		end

		return slot2
	end,
	GetDecomposeRewardItem = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			slot9 = (slot7.exp * 0.8 or 0) + uv0.CountBreakExp(slot7) + GameSetting.base_exp_equip_star.value[EquipCfg[slot7.prefab_id].starlevel]
			slot10 = GameSetting.equip_exp_props_id_list.value

			for slot15 = 1, #{
				slot10[3],
				slot10[2],
				slot10[1]
			} do
				if ItemCfg[slot11[slot15]].param[1] <= slot9 then
					slot18 = math.floor(slot9 / slot17)
					slot1[slot16] = (slot1[slot16] or 0) + slot18
					slot9 = slot9 - slot17 * slot18
				end
			end

			for slot17, slot18 in pairs(EquipData:GetEquipData(slot6):GetBreakCostReturn()) do
				slot19 = slot18[1] or 0
				slot1[slot19] = (slot1[slot19] or 0) + (slot18[2] or 0)
			end
		end

		for slot6, slot7 in pairs(slot1) do
			if slot7 > 0 then
				table.insert(slot2, {
					id = slot6,
					number = slot7
				})
			end
		end

		return slot2
	end,
	CountNeedExp = function (slot0, slot1, slot2)
		for slot9 = 1, slot1 - 1 do
			slot3 = 0 + EquipExpCfg[slot9]["exp" .. EquipCfg[slot0.prefab_id].starlevel]
		end

		return slot3
	end,
	GetLockedEquipS = function ()
		slot0 = {}

		for slot5, slot6 in pairs(EquipData:GetEquipList()) do
			if slot6.is_lock and slot6.is_lock == 1 then
				table.insert(slot0, slot6.equip_id)
			end
		end

		return slot0
	end,
	GetHeroUsedEquipS = function ()
		slot0 = {}

		for slot5, slot6 in pairs(HeroData:GetHeroList()) do
			if slot6.equip then
				for slot10, slot11 in pairs(slot6.equip) do
					if slot11.equip_id ~= 0 then
						table.insert(slot0, slot11.equip_id)
					end
				end
			end
		end

		return slot0
	end,
	GetSuitEquipNum = function (slot0, slot1, slot2, slot3)
		for slot9, slot10 in pairs(EquipData:GetEquipList()) do
			if not (slot3 and HeroData:GetEquipMap()[slot10.equip_id]) and (slot2 == 0 or slot2 == nil or EquipCfg[slot10.prefab_id].pos == slot2) and (not slot1 or not table.keyof(slot1, slot10.equip_id)) and slot11.suit == slot0 then
				slot5 = 0 + 1
			end
		end

		return slot5
	end,
	GetEquipSkillNum = function (slot0, slot1, slot2, slot3)
		slot5 = 0

		for slot9, slot10 in pairs(EquipData:GetEquipList()) do
			slot15 = false

			if not (slot3 and HeroData:GetEquipMap()[slot10.equip_id]) and (slot2 == 0 or slot2 == nil or EquipCfg[slot10.prefab_id].pos == slot2) and (not slot1 or not table.keyof(slot1, slot10.equip_id)) then
				for slot19, slot20 in ipairs(slot11.effect) do
					if slot20 and slot20[1] and slot20[1] == slot0 then
						slot15 = true

						break
					end
				end

				if not slot15 then
					for slot19, slot20 in pairs(slot10.enchant) do
						for slot24, slot25 in ipairs(slot20) do
							if slot25 and slot25.id and slot25.id == slot0 then
								slot15 = true

								break
							end
						end
					end
				end

				if slot15 then
					slot5 = slot5 + 1
				end
			end
		end

		return slot5
	end,
	GetEquipInfoById = function (slot0)
		return EquipData:GetEquipList()[slot0]
	end,
	CountAddExp = function (slot0, slot1)
		for slot6, slot7 in pairs(slot0) do
			slot2 = 0 + ItemCfg[slot6].param[1] * slot7
		end

		for slot6, slot7 in pairs(slot1) do
			slot2 = slot2 + (slot7.equip_info.exp * 0.8 or 0) + uv0.CountBreakExp(slot7) + GameSetting.base_exp_equip_star.value[EquipCfg[slot7.id].starlevel]
		end

		return slot2
	end,
	CountBreakExp = function (slot0)
		return 0
	end,
	QuickSelectList = function (slot0, slot1)
		slot2 = EquipData:GetEquipList()
		slot3 = {}
		slot7 = ItemConst.ITEM_TYPE.MATERIAL

		for slot7, slot8 in ipairs(ItemCfg.get_id_list_by_type[slot7]) do
			slot9 = ItemTools.getItemNum(slot8)

			if ItemCfg[slot8].sub_type == MaterialConst.MATERIAL_TYPE.EQUIP_LEVEL_UP and slot9 > 0 then
				table.insert(slot3, {
					id = slot8,
					add = slot10.param[1],
					num = slot9
				})
			end
		end

		slot5 = {}
		slot6 = {}
		slot7 = slot0 - 0

		for slot12 = 1, #slot3 do
			slot13 = slot3[slot12].add

			if slot7 - ({
				[slot12] = math.max(math.min(math.ceil(slot7 / slot13), slot3[slot12].num), 0)
			})[slot12] * slot13 < 0 and slot12 > 1 then
				slot14 = -slot7

				for slot18 = slot12 - 1, 1, -1 do
					slot19 = slot3[slot18].add
					slot20 = math.modf(slot14 / slot19)
					slot8[slot18] = math.max(0, slot8[slot18] - slot20)
					slot22 = math.min(slot8[slot18], slot20)
					slot14 = slot14 - slot19 * slot22
					slot7 = slot7 + slot19 * slot22
				end
			end

			if slot7 <= 0 then
				break
			end
		end

		for slot12 = 1, #slot3 do
			if slot8[slot12] == nil then
				slot8[slot12] = 0
			end

			slot4 = slot4 + slot8[slot12] * slot3[slot12].add
			slot5[slot3[slot12].id] = slot8[slot12]
		end

		if slot7 > 0 then
			slot9, slot10 = EquipData:GetEquipListComplex(ItemConst.SORT_TYPE.UP, EquipConst.EQUIP_SORT.RARE)
			slot11 = HeroTools.GetEquipMap(HeroData:GetHeroList())
			slot12 = ProposalData:GetEquipMap()

			for slot17 = 1, #slot10 do
				slot19 = slot2[slot10[slot17]]

				if slot0 - slot4 <= 0 then
					break
				end

				slot20 = EquipCfg[slot19.prefab_id]

				if slot11[slot10[slot17]] == nil and slot19.exp == 0 and slot19.now_break_level == 0 and slot19.star < 5 and not slot19.is_lock and not slot12[slot19.equip_id] and not table.indexof(slot1, slot19.equip_id) then
					slot6[slot10[slot17]] = {
						isEquiped = false,
						number = 1,
						type = ItemConst.ITEM_TYPE.EQUIP,
						id = slot19.prefab_id,
						equip_id = slot19.equip_id,
						equip_info = slot19,
						equip_star = getItemStar(slot19.prefab_id),
						equip_lv = uv0.CountEquipLevel(slot19)
					}
					slot4 = slot4 + GameSetting.base_exp_equip_star.value[slot19.star]
				end
			end
		end

		return slot5, slot6
	end,
	CountRestAddExp = function (slot0, slot1)
		for slot6 = slot1, 1, -1 do
			slot2 = 0 + slot0[slot6].add * slot0[slot6].num
		end

		return slot2
	end,
	QuickMaterialList = function (slot0, slot1)
		slot4 = 0

		for slot8, slot9 in ipairs(slot1) do
			if slot0 - slot4 > 0 then
				slot11 = ItemCfg[slot9.id].param[1]
				slot4 = slot4 + math.min(math.ceil(slot10 / slot11), slot9.num) * slot11
			else
				slot3[slot8] = 0
			end
		end

		return {
			[slot9.id] = slot12
		}, {
			[slot8] = slot12
		}
	end,
	QuickEquipList = function (slot0, slot1, slot2)
		slot4 = 0

		for slot8, slot9 in ipairs(slot1) do
			slot12 = EquipCfg[equip.prefab_id].starlevel

			if slot0 - slot4 > 0 and slot12 <= slot2 then
				slot4 = slot4 + uv0.GetEquipInfoById(slot9).exp + GameSetting.base_exp_equip_star.value[slot12]
			end
		end

		return {
			[slot9] = slot11
		}
	end,
	GetEquipSuitEffect = function (slot0)
		slot1 = {}
		slot1 = deepClone(EquipSuitCfg.get_id_list_by_suit[EquipCfg[slot0.prefab_id].suit])

		table.sort(slot1, function (slot0, slot1)
			return EquipSuitCfg[slot0].need < EquipSuitCfg[slot1].need
		end)

		return slot1
	end,
	CountSuitEffect = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot7] = 1 + (slot1[EquipCfg[slot6.prefab_id].suit] or 0)
		end

		slot2 = {}

		for slot6, slot7 in pairs(slot1) do
			for slot12, slot13 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot6]) do
				if EquipSuitCfg[slot13].need <= slot7 then
					table.insert(slot2, slot13)
				end
			end
		end

		return slot2
	end,
	Filt = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			if not slot1[EquipCfg[slot7.prefab_id].pos] then
				slot2[slot6] = nil
			end
		end

		return slot2
	end,
	MutiFilt = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			for slot11, slot12 in pairs(slot1) do
				if not slot12[EquipCfg[slot7.prefab_id][slot11]] then
					slot2[slot6] = nil
				end
			end
		end

		return slot2
	end,
	FiltByPos = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			if not slot1[EquipCfg[slot7.prefab_id].pos] then
				slot2[slot6] = nil
			end
		end

		return slot2
	end,
	FiltBySuit = function (slot0, slot1)
		for slot6, slot7 in pairs(deepClone(slot0)) do
			if not slot1[EquipCfg[slot7.prefab_id].suit] then
				slot2[slot6] = nil
			end
		end

		return slot2
	end,
	EquipSort = function (slot0, slot1, slot2)
		for slot7, slot8 in pairs(slot0) do
			table.insert({}, slot8)
		end

		slot5 = slot1 or 0

		function slot6(slot0, slot1)
			if uv0 == ItemConst.SORT_TYPE.DOWN then
				return slot1 < slot0
			else
				return slot0 < slot1
			end
		end

		if (slot2 or 0) == EquipConst.EQUIP_SORT.LEVEL then
			table.sort(slot3, function (slot0, slot1)
				if slot0:GetLevel() ~= slot1:GetLevel() then
					return uv0(slot0:GetLevel(), slot1:GetLevel())
				elseif slot0.now_break_level ~= slot1.now_break_level then
					return uv0(slot0.now_break_level, slot1.now_break_level)
				elseif slot0.star ~= slot1.star then
					return uv0(slot0.star, slot1.star)
				elseif slot0:GetSuit() ~= slot1:GetSuit() then
					return slot0:GetSuit() < slot1:GetSuit()
				elseif slot0.prefab_id and slot1.prefab_id and slot0.prefab_id ~= slot1.prefab_id then
					return slot0.prefab_id < slot1.prefab_id
				elseif slot0.equip_id ~= slot1.equip_id then
					return uv0(slot0.equip_id, slot1.equip_id)
				end

				return false
			end)
		elseif slot4 == EquipConst.EQUIP_SORT.RARE then
			table.sort(slot3, function (slot0, slot1)
				if slot0.star ~= slot1.star then
					return uv0(slot0.star, slot1.star)
				elseif slot0:GetLevel() ~= slot1:GetLevel() then
					return uv0(slot0:GetLevel(), slot1:GetLevel())
				elseif slot0.now_break_level ~= slot1.now_break_level then
					return uv0(slot0.now_break_level, slot1.now_break_level)
				elseif slot0:GetSuit() ~= slot1:GetSuit() then
					return slot0:GetSuit() < slot1:GetSuit()
				elseif slot0.prefab_id and slot1.prefab_id and slot0.prefab_id ~= slot1.prefab_id then
					return slot0.prefab_id < slot1.prefab_id
				elseif slot0.equip_id ~= slot1.equip_id then
					return uv0(slot0.equip_id, slot1.equip_id)
				end

				return false
			end)
		else
			table.sort(slot3, function (slot0, slot1)
				if slot0.equip_id ~= slot1.equip_id then
					return uv0(slot0.equip_id, slot1.equip_id)
				end

				return false
			end)
			print("EquipSort Fucntion cant find current sort Type")
		end

		return slot3
	end,
	GetEffectDesc = function (slot0)
		if not EquipEffectCfg[slot0] then
			print("装备效果 id" .. slot0 .. "没有配置")
		end

		if slot1.desc and slot1.desc ~= "" then
			return GetCfgDescription(slot1.desc[1], 1)
		end

		return ""
	end,
	GetEffectDescOld = function (slot0)
		if slot0 == nil then
			return ""
		end

		slot1 = EquipEffectCfg[slot0]
		slot2 = slot1.desc
		slot3 = {}
		slot7 = "@{.-}"

		for slot7 in string.gmatch(slot1.desc, slot7) do
			slot10 = string.split(string.sub(slot7, 3, -2), "_")
			slot3[#slot3 + 1] = 0 + tonumber(EquipEffectCfg[tonumber(slot10[1])].param[tonumber(slot10[2])])
		end

		for slot7 = 1, #slot3 do
			slot2 = string.gsub(slot2, "@{.-}", slot3[slot7], 1)
		end

		return slot2
	end,
	GetSkillDescWithoutHero = function (slot0, slot1, slot2)
		slot3 = EquipSkillCfg[slot0]
		slot4 = ""
		slot5 = GameSetting.exclusive_skill_cd_type.value
		slot6 = GameSetting.exclusive_skill_level_up_type.value
		slot7 = GameSetting.exclusive_skill_damage_type.value

		if not false then
			for slot12, slot13 in ipairs(slot5) do
				if slot0 == slot13[1] then
					slot8 = slot13[2]
				end
			end
		end

		if not slot8 then
			for slot12, slot13 in ipairs(slot6) do
				if slot0 == slot13[1] then
					slot8 = slot13[2]
				end
			end
		end

		if not slot8 then
			for slot12, slot13 in ipairs(slot7) do
				if slot0 == slot13[1] then
					slot8 = slot13[2]
				end
			end
		end

		slot9 = ""

		return GetCfgDescriptionWithValue(slot3.desc[1], (slot1 ~= 0 or EquipTools.Calculate(slot3.upgrade / slot3.percent * 1, slot0)) and (slot1 < slot3.lvmax and (slot2 and EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0) or EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(slot3.upgrade / slot3.percent * (slot1 + 1), slot0))) or EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0)))
	end,
	GetSkillDesc = function (slot0, slot1, slot2)
		slot3 = EquipSkillCfg[slot0]
		slot4 = HeroCfg[slot2]
		slot5 = ""
		slot6 = GameSetting.exclusive_skill_cd_type.value
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot8 = GameSetting.exclusive_skill_damage_type.value

		if not false then
			for slot13, slot14 in ipairs(slot6) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot7) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot8) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if slot9 then
			slot5 = HeroSkillCfg[slot4.skills[slot9]].name
		end

		slot10 = ""

		return GetCfgDescriptionWithValue(slot3.desc[1], (slot1 ~= 0 or EquipTools.Calculate(slot3.upgrade / slot3.percent * 1, slot0)) and (slot1 < slot3.lvmax and EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0) .. string.format(GetTips("EQUIP_HERO_SKILL_NEXT_LEVEL"), EquipTools.Calculate(slot3.upgrade / slot3.percent * (slot1 + 1), slot0)) or EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0)))
	end,
	GetSkillDescWithoutNext = function (slot0, slot1, slot2)
		slot3 = EquipSkillCfg[slot0]
		slot4 = HeroCfg[slot2]
		slot5 = ""
		slot6 = GameSetting.exclusive_skill_cd_type.value
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot8 = GameSetting.exclusive_skill_damage_type.value

		if not false then
			for slot13, slot14 in ipairs(slot6) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot7) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if not slot9 then
			for slot13, slot14 in ipairs(slot8) do
				if slot0 == slot14[1] then
					slot9 = slot14[2]
				end
			end
		end

		if slot9 then
			slot5 = HeroSkillCfg[slot4.skills[slot9]].name
		end

		slot10 = ""

		return GetCfgDescriptionWithValue(slot3.desc[1], (slot1 ~= 0 or EquipTools.Calculate(slot3.upgrade / slot3.percent * 1, slot0)) and EquipTools.Calculate(slot3.upgrade / slot3.percent * slot1, slot0))
	end,
	Calculate = function (slot0, slot1)
		if table.indexof(GameDisplayCfg.equip_hero_skill_int.value, slot1) then
			return slot0
		else
			return string.format("%.1f%%", slot0)
		end
	end,
	GetIsHide = function (slot0)
		hideList = HideInfoData:GetEquipSuitHideList()

		return hideList[EquipCfg[slot0].suit] or false
	end,
	GetSuitTotalNum = function ()
		for slot5, slot6 in ipairs(EquipSuitCfg.all) do
			if not HideInfoData:GetEquipSuitHideList()[slot6] then
				slot1 = 0 + 1
			end
		end

		return slot1
	end
}
