return {
	GetTotalAddAttribute = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			if slot6.astrolabe_id ~= 0 then
				for slot11, slot12 in ipairs(HeroAstrolabeCfg[slot6.astrolabe_id].ability) do
					if slot1[slot12[1]] == nil then
						slot1[slot12[1]] = slot12[2]
					else
						slot1[slot12[1]] = slot1[slot12[1]] + slot12[2]
					end
				end
			end
		end

		return slot1
	end,
	GetTotalEffect = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot6)
		end

		return slot1
	end,
	GetAcitveEffect = function (slot0, slot1)
		if slot1 == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			if slot7 ~= 0 then
				if slot2[HeroAstrolabeCfg[slot7].hero_astrolabe_suit_id] == nil then
					slot2[slot9] = {
						num = 1,
						id = slot9
					}
				else
					slot2[slot9].num = slot2[slot9].num + 1
				end
			end
		end

		slot3 = {}

		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot8)
		end

		return slot3
	end,
	GetLastIsUnlock = function (slot0, slot1)
		slot4 = HeroData:GetHeroData(slot1)

		if HeroAstrolabeCfg[slot0].pre_astrolabe_id == 0 then
			return true
		end

		if HeroAstrolabeCfg[slot3] then
			return uv0.GetIsUnlock(slot4.unlocked_astrolabe, slot3)
		end

		return false
	end,
	GetLastIsEquiped = function (slot0, slot1)
		slot4 = HeroData:GetHeroData(slot1)

		if HeroAstrolabeCfg[slot0].pre_astrolabe_id == 0 then
			return true
		end

		if HeroAstrolabeCfg[slot3] then
			return uv0.GetIsEquiped(slot4.using_astrolabe, slot3)
		end

		return false
	end,
	GetNextIsEquiped = function (slot0, slot1)
		slot3 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[slot0] or {}

		if HeroAstrolabeCfg[slot0].pos == 3 then
			return false
		end

		slot4 = HeroData:GetHeroData(slot1)

		for slot8, slot9 in ipairs(slot3) do
			if not HeroAstrolabeCfg[slot9] then
				return false
			else
				return uv0.GetIsEquiped(HeroData:GetHeroData(slot1).using_astrolabe, slot9)
			end
		end

		return false
	end,
	GetNextSPNodeIsEquiped = function (slot0, slot1)
		slot3 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[slot0] or {}

		if HeroAstrolabeCfg[slot0].pos == 3 then
			return false
		end

		slot4 = HeroData:GetHeroData(slot1)

		for slot8, slot9 in ipairs(slot3) do
			if not HeroAstrolabeCfg[slot9] then
				return false
			elseif slot10.pos == 1 then
				return uv0.GetIsEquiped(HeroData:GetHeroData(slot1).using_astrolabe, slot9)
			end
		end

		return false
	end,
	GetIsUnlock = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0 or {}) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end,
	GetIsEquiped = function (slot0, slot1)
		for slot5, slot6 in pairs(slot0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end,
	GetIsHaveCanUnlock = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
			return false
		end

		for slot6, slot7 in ipairs(HeroCfg[HeroData:GetHeroData(slot0).id].astrolabe) do
			for slot11, slot12 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot7]) do
				slot13 = uv0.GetIsUnlock(slot2.unlocked_astrolabe, slot12)

				if HeroTools.IsSpHero(slot0) then
					if uv0.GetSpAstrolabeNodeCanEquiped(slot12, slot0) then
						return slot14
					end
				elseif not slot13 and uv0.GetIsCanUnlock(slot12, slot0) then
					return true
				end
			end
		end

		return false
	end,
	GetIsCanUnlock = function (slot0, slot1)
		if not HeroTools.IsSpHero(slot1) and uv0.GetIsUnlock(HeroData:GetHeroData(slot1).unlocked_astrolabe, slot0) then
			return false
		end

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < HeroAstrolabeCfg[slot0].unlock[1][2] then
			return false
		end

		if not uv0.GetLastIsUnlock(slot0, slot1) then
			return false
		end

		return IsConditionAchieved(slot4.unlock_condition, {
			heroId = slot1
		})
	end,
	GetAstrolabeModuleDes = function (slot0, slot1)
		slot3 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_3")
		slot4 = nil

		for slot8, slot9 in pairs(AstrolabeEffectCfg[getAstrolabeID(slot0, slot1)].equip_orange_desc) do
			if slot9[1] == slot1 and slot9[3] == slot0 then
				slot4 = slot9[2]
			end
		end

		return string.format(slot3, HeroAstrolabeCfg[slot2].suit_name, HeroAstrolabeCfg[slot2].name, GetCfgDescription(slot4, 1))
	end,
	GetAstrolabePrafabName = function (slot0)
		slot1 = 1

		if HeroCfg[slot0] then
			slot1 = slot2.race
		end

		if not HeroTools.IsSpHero(slot0) then
			return string.format("TX_GodHood_0%s", slot1)
		else
			return string.format("TX_GodHood_SP_0%s", slot1)
		end
	end,
	GetHeroAstrolabeS = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(HeroCfg[slot0.id].astrolabe) do
			slot8 = {
				suitId = slot7,
				astrolabe = {}
			}

			for slot12, slot13 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot7]) do
				slot14 = false
				slot15 = false

				if HeroTools.IsSpHero(slot0.id) then
					slot14 = AstrolabeTools.GetIsUnlock(slot13, slot0.id)
				else
					slot14 = AstrolabeTools.GetIsUnlock(slot0.unlocked_astrolabe, slot13)
					slot15 = AstrolabeTools.GetIsCanUnlock(slot13, slot0.id) and slot0.unlock == 1
				end

				if slot1 == AstrolabeConst.VIEW_TYPE.ISPREVIEW then
					-- Nothing
				elseif slot1 == AstrolabeConst.VIEW_TYPE.ISPOLYHEDRON then
					slot16.isUnlock = true
					slot16.isCanLock = false
				end

				table.insert(slot8.astrolabe, {
					id = slot13,
					heroId = slot0.id,
					isUnlock = slot14,
					isEquiped = AstrolabeTools.GetIsEquiped(slot0.using_astrolabe, slot13),
					isCanLock = slot15,
					posX = slot6,
					posY = slot12,
					isUnlock = true,
					isEquiped = true,
					isCanLock = false
				})
			end

			table.insert(slot2, slot8)
		end

		return slot2
	end,
	GetAstrolabeItemPos = function (slot0, slot1)
		slot4 = 1

		for slot8, slot9 in ipairs(HeroCfg[slot1] and HeroCfg[slot1].astrolabe or {}) do
			if slot9 == (HeroAstrolabeCfg[slot0] and HeroAstrolabeCfg[slot0].hero_astrolabe_suit_id) then
				slot4 = slot8
			end
		end

		return slot4
	end,
	GetSpAstrolabeNodeCanEquiped = function (slot0, slot1)
		return uv0.GetLastIsEquiped(slot0, slot1) and AstrolabeTools.GetIsUnlock(slot3 and slot3.unlocked_astrolabe, slot0) and not AstrolabeTools.GetIsEquiped(HeroData:GetHeroData(slot1) and slot3.using_astrolabe or {}, slot0)
	end,
	GetSpAstrolabeNodeBySurpass = function (slot0, slot1)
		slot2 = 0

		if HeroTools.IsSpHero(slot0) then
			slot3 = HeroCfg[slot0]

			for slot8, slot9 in ipairs(HeroCfg[slot0].astrolabe or {}) do
				for slot14, slot15 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot9] or {}) do
					if HeroAstrolabeCfg[slot15] and ConditionCfg[slot16.unlock_condition].type == 1024 and slot1 == (slot17.params and slot17.params[1] or 0) then
						return slot15
					end
				end
			end
		end

		return 0
	end
}
