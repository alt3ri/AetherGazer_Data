return {
	GetJumpDataByEquipSpecialType = function (slot0, slot1)
		if #(SystemLinkActivityCfg.all or {}) == 0 then
			return {}
		end

		print(slot1, "  GetJumpDataByEquipSpecialType")

		for slot6, slot7 in ipairs(slot2) do
			slot8, slot9 = uv0.CheckRouletteHasEquip(slot1, slot7)

			if slot8 then
				return slot9
			end
		end
	end,
	CheckRouletteHasEquip = function (slot0, slot1)
		if ActivityData:GetActivityIsOpen(slot1) then
			for slot6, slot7 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[slot1] or {}) do
				if ActivityPtRouletteStageCfg[slot7] then
					for slot12, slot13 in ipairs(ActivityPtRouletteStageCfg[slot7].roulette_id) do
						if EquipCfg[slot0] and table.indexof(ActivityPtRouletteRandomCfg[slot13] and ActivityPtRouletteRandomCfg[slot13].equip_suit_list or {}, EquipCfg[slot0].suit) then
							return true, SystemLinkActivityCfg[slot1].system_link_data
						end
					end
				end
			end
		end

		return false, {}
	end,
	GetJumpDataByHeroSpecialType = function (slot0)
		slot2 = {
			ViewConst.JUMP_SPECIAL_ID.HERO_NORMAL_SOURCE,
			[3] = ViewConst.JUMP_SPECIAL_ID.HERO_LIMIT_SOURCE,
			[5] = ViewConst.JUMP_SPECIAL_ID.NEW_PLAYER_DRAW,
			[6] = ViewConst.JUMP_SPECIAL_ID.LIMIT_MUST_DRAW,
			[7] = ViewConst.JUMP_SPECIAL_ID.HERO_AGAIN,
			[8] = ViewConst.JUMP_SPECIAL_ID.NEW_PLAYER_DRAW
		}
		slot3 = {}

		for slot7, slot8 in pairs(DrawTools.GetNowAllRolePool()) do
			if DrawPoolCfg[slot8] then
				slot11 = slot9.pool_show_type

				if DrawSettingCfg[slot9.pool_type] and slot12.pool_id ~= "" then
					for slot17, slot18 in pairs(slot13) do
						for slot23, slot24 in ipairs(DrawItemCfg.get_id_list_by_pool_id[slot18] or {}) do
							if (ItemCfg[slot0] and ItemCfg[slot0].hero_id or 0) == (DrawItemCfg[slot24] and DrawItemCfg[slot24].item_id or 0) and not slot3[slot11] and SystemLinkCfg[slot2[slot11]] then
								if slot10 == 8 then
									if not DrawData:GetNewbieChooseDrawFlag() then
										slot3[slot11] = {
											slot2[slot11],
											slot8
										}
									end
								else
									slot3[slot11] = {
										slot2[slot11],
										slot8
									}
								end
							end
						end
					end
				end
			end
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot3) do
			table.insert(slot4, slot9)
		end

		return #slot4 > 0, slot4
	end,
	GetJumpDataByServantSpecialType = function (slot0)
		slot2 = {
			[2] = ViewConst.JUMP_SPECIAL_ID.SERVANT_NORMAL_SOURCE
		}
		slot3 = {}

		for slot7, slot8 in pairs(DrawTools.GetNowAllServantPool()) do
			if DrawPoolCfg[slot8] then
				slot11 = slot9.pool_show_type

				if DrawSettingCfg[slot9.pool_type] and slot12.pool_id ~= "" then
					for slot17, slot18 in pairs(slot13) do
						for slot23, slot24 in ipairs(DrawItemCfg.get_id_list_by_pool_id[slot18] or {}) do
							if DrawItemCfg[slot24] and DrawItemCfg[slot24].item_id == slot0 and not slot3[slot11] and SystemLinkCfg[slot2[slot11]] then
								slot3[slot11] = {
									slot2[slot11],
									slot8
								}
							end
						end
					end
				end
			end
		end

		slot4 = {}

		for slot8, slot9 in pairs(slot3) do
			table.insert(slot4, slot9)
		end

		return #slot4 > 0, slot4
	end
}
