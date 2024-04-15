return {
	SortChipManager = function (slot0)
		slot2 = {}
		slot3 = {}
		slot4 = {}

		for slot9, slot10 in pairs(ChipData:GetChipManagerList()) do
			if slot9 ~= slot0 then
				if table.keyof(ChipData:GetUnlockChipManagerIDList(), slot9) then
					table.insert(slot2, slot9)
				elseif IsConditionAchieved(ChipCfg[slot9].new_condition) then
					table.insert(slot3, slot9)
				else
					table.insert(slot4, slot9)
				end
			end
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.sort(slot3, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.sort(slot4, function (slot0, slot1)
			return slot0 < slot1
		end)
		table.insertto(slot2, slot3)
		table.insertto(slot2, slot4)

		if slot0 ~= 0 then
			table.insert(slot2, 1, slot0)
		end

		if manager.guide:IsPlaying() and table.indexof(slot2, 6) then
			table.remove(slot2, slot6)
			table.insert(slot2, 1, 6)
		end

		return slot2
	end,
	SortChip = function (slot0, slot1)
		return uv0.SortChipList(ChipData:GetChipManagerList()[slot1], slot0, slot1)
	end,
	SortChipList = function (slot0, slot1, slot2, slot3)
		slot4 = {}
		slot5 = {}
		slot6 = {}
		slot7 = {}
		slot8 = nil

		for slot12, slot13 in pairs(slot1) do
			if not table.keyof(slot0, slot13) then
				if table.keyof((not slot3 or ChipData:GetUnlockHeroChipIDList()) and ChipData:GetUnlockChipIDList(), slot13) then
					table.insert(slot5, slot13)
				else
					slot14 = nil

					if (ChipCfg[slot13].new_condition <= 0 or (ChipCfg[slot13].spec_char <= 0 or IsConditionAchieved(ChipCfg[slot13].new_condition, {
						heroId = ChipCfg[slot13].spec_char
					})) and IsConditionAchieved(ChipCfg[slot13].new_condition)) and (ChipCfg[slot13].cost_condition[1][1] <= ItemTools.getItemNum(ChipCfg[slot13].cost_condition[1][1]) and true or false) then
						table.insert(slot6, slot13)
					else
						table.insert(slot7, slot13)
					end
				end
			else
				table.insert(slot4, slot13)
			end
		end

		uv0.SortRegular(slot5)
		uv0.SortRegular(slot6)
		uv0.SortRegular(slot7)
		table.insertto(slot4, slot5)
		table.insertto(slot4, slot6)
		table.insertto(slot4, slot7)

		return slot4
	end,
	GetChipCanLocked = function (slot0)
		if not ChipCfg[slot0] then
			return false
		end

		return IsConditionAchieved(ChipCfg[slot0].new_condition)
	end,
	SortRegular = function (slot0)
		table.sort(slot0, function (slot0, slot1)
			if ChipCfg[slot0].spec_char ~= 0 and ChipCfg[slot1].spec_char == 0 then
				return false
			end

			return slot0 < slot1
		end)
	end,
	FormatChipByRoleType = function (slot0)
		if type(slot0) ~= "table" then
			return {}
		end

		for slot5, slot6 in ipairs(slot0) do
			slot1[ChipCfg[slot6].role_type_id] = slot6
		end

		return slot1
	end,
	GetChipTypeList = function (slot0)
		slot1 = {
			-1,
			0
		}
		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			if not table.keyof(slot2, ChipCfg[slot7].spec_char) and slot8 ~= 0 then
				table.insert(slot2, slot8)
			end
		end

		table.insertto(slot1, HeroTools.SortHero(slot2))

		return slot1
	end,
	GetChipTypeCntList = function (slot0)
		slot1 = {
			[-1] = {}
		}

		for slot5, slot6 in ipairs(slot0) do
			slot1[slot7] = slot1[ChipCfg[slot6].spec_char] or {}

			table.insert(slot1[slot7], slot6)
			table.insert(slot1[-1], slot6)
		end

		return slot1
	end,
	SortScheme = function (slot0)
		slot3 = {
			{
				id = 0,
				name = GetTips(slot7),
				chipList = ChipData:GetChipManagerList()[slot0]
			}
		}

		for 
		-- Decompilation error in this vicinity:
		"CURRENT_SCHEME", slot8 in pairs(ChipData:GetSchemeList()) do
			slot9 = #slot1 == #slot8.chipList

			for slot13, slot14 in ipairs(slot8.chipList) do
				if not table.keyof(slot1, slot14) then
					slot9 = false

					break
				end
			end

			if slot9 then
				slot3[1] = clone(slot8)
			else
				table.insert(slot3, clone(slot8))
			end
		end

		for slot8 = #slot3 + 1, GameSetting.ai_chip_proposal_num_max.value[1] + (slot3[1].id == 0 and 1 or 0) do
			table.insert(slot3, {
				id = -1
			})
		end

		return slot3
	end,
	InsertChip = function (slot0, slot1, slot2)
		slot3, slot4 = uv0.InternalInsertChip(slot0, slot1)

		if slot3 == true then
			if slot2 then
				slot2(slot0)
			end

			ShowTips("CHIP_USE_SUCCESS")
			manager.notify:Invoke(ENABLED_CHIP)
		elseif slot4 then
			ShowTips(slot4)
		end
	end,
	RemoveChip = function (slot0, slot1, slot2)
		slot3, slot4 = uv0.InternalRemoveChip(slot0, slot1)

		if slot3 == true then
			if slot2 then
				slot2(slot0)
			end

			ShowTips("CHIP_UNLOAD_SUCCESS")
			manager.notify:Invoke(ENABLED_CHIP)
		elseif slot4 then
			ShowTips(slot4)
		end
	end,
	InternalInsertChip = function (slot0, slot1)
		slot2 = true
		slot3 = nil
		slot4 = false
		slot5 = 0

		for slot11, slot12 in ipairs(slot0) do
			if ChipCfg[slot12].spec_char ~= 0 and table.keyof(ChipCfg.get_id_list_by_spec_char[ChipCfg[slot1].spec_char], slot12) and slot12 ~= slot1 then
				slot4 = true
				slot5 = slot12

				break
			end
		end

		if not table.indexof(slot0, slot1) and not slot4 and GameSetting.ai_secondary_chip_equip_num.value[1] <= #slot0 then
			return false, "CHIP_CNT_MORE_THEN_MAX"
		end

		if slot4 and table.indexof(slot0, slot5) then
			table.remove(slot0, slot8)
		end

		table.insert(slot0, slot1)

		return slot2, slot3
	end,
	InternalRemoveChip = function (slot0, slot1)
		if table.indexof(slot0, slot1) then
			table.remove(slot0, slot2)
		end

		return true
	end,
	GetChipManagerIcon = function (slot0)
		if not ChipCfg[slot0] then
			Debug.Log(string.format("<color=ff0000>ChipCfg has no ID(%d)</color>", slot0))

			return
		end

		return getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. slot1.picture_id)
	end
}
