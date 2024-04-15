return {
	GetHeroAstrolabeS = function (slot0, slot1)
		if HeroTools.IsSpHero(slot1) then
			return slot0:GetSpHeroAstrolabeS(slot1)
		end

		slot3 = {}
		slot7 = slot0:GetHeroData(slot1).id

		for slot7, slot8 in ipairs(HeroCfg[slot7].astrolabe) do
			slot9 = {
				suitId = slot8,
				astrolabe = {}
			}

			for slot13, slot14 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot8]) do
				slot15 = false
				slot16 = false

				if HeroTools.IsSpHero(slot2.id) then
					slot15 = AstrolabeTools.GetIsUnlock(slot2.unlocked_astrolabe, slot14)
					slot16 = false
				else
					slot15 = AstrolabeTools.GetIsUnlock(slot2.unlocked_astrolabe, slot14)
					slot16 = AstrolabeTools.GetIsCanUnlock(slot14, slot2.id) and slot2.unlock == 1
				end

				if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
					-- Nothing
				elseif slot0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
					slot17.isCanLock = false
				end

				table.insert(slot9.astrolabe, {
					id = slot14,
					heroId = slot2.id,
					isUnlock = slot15,
					isEquiped = AstrolabeTools.GetIsEquiped(slot2.using_astrolabe, slot14),
					isCanLock = AstrolabeTools.GetIsCanUnlock(slot14, slot2.id) and slot2.unlock == 1,
					posX = slot7,
					posY = slot13,
					isUnlock = true,
					isEquiped = false,
					isCanLock = false
				})
			end

			table.insert(slot3, slot9)
		end

		return slot3
	end,
	GetSpHeroAstrolabeS = function (slot0, slot1)
		slot3 = {}
		slot6 = {}

		for slot10, slot11 in ipairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[HeroCfg[slot0:GetHeroData(slot1).id].astrolabe[1]] or {}) do
			if HeroAstrolabeCfg[slot11].pos == 1 then
				table.insert(slot6, slot11)
			end
		end

		for slot10, slot11 in ipairs(slot6) do
			slot12 = {
				suitId = slot4,
				astrolabe = {}
			}
			slot18 = slot11

			table.insert({}, slot18)

			for slot18, slot19 in ipairs(slot5) do
				if slot11 == HeroAstrolabeCfg[slot19].pre_astrolabe_id then
					table.insert(slot13, slot19)

					slot14 = 1 + 1
				end
			end

			for slot18, slot19 in ipairs(slot13) do
				slot20 = HeroAstrolabeCfg[slot19]
				slot21 = false
				slot22 = false

				if HeroTools.IsSpHero(slot2.id) then
					slot21 = AstrolabeTools.GetIsUnlock(slot2.unlocked_astrolabe, slot19)
					slot22 = false
				end

				if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
					-- Nothing
				elseif slot0.viewDataType == HeroConst.HERO_DATA_TYPE.ISPOLYHEDRON then
					slot23.isUnlock = true
					slot23.isCanLock = true
				end

				table.insert(slot12.astrolabe, {
					id = slot19,
					heroId = slot2.id,
					isUnlock = slot21,
					isEquiped = AstrolabeTools.GetIsEquiped(slot2.using_astrolabe, slot19),
					isCanLock = AstrolabeTools.GetIsCanUnlock(slot19, slot2.id) and slot2.unlock == 1,
					posX = slot10,
					posY = slot18,
					isUnlock = true,
					isEquiped = false,
					isCanLock = false
				})
			end

			table.insert(slot3, slot12)
		end

		return slot3
	end,
	GetAcitveEffect = function (slot0, slot1)
		if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
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
	GetUsingAstrolabe = function (slot0, slot1)
		slot2 = slot0:GetHeroData(slot1)

		if slot0:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return {}
		else
			return slot2.using_astrolabe
		end
	end,
	GetAstrolabeDesc = function (slot0, slot1, slot2)
		if not AstrolabeEffectCfg[slot1] then
			print("id:" .. slot1 .. "没有配置")
		end

		if slot3 and slot3.desc and type(slot3.desc) == "table" then
			slot4 = slot3.desc[1]
			slot5 = slot0:GetServantId(slot2)
			slot6 = slot0:GetModuleEffectList(slot2)
			slot7 = false

			if slot3.equip_orange_desc and type(slot3.equip_orange_desc) == "table" then
				for slot11, slot12 in ipairs(slot3.equip_orange_desc) do
					if slot12[1] > 0 and slot12[3] > 0 and slot12[1] == slot5 and table.indexof(slot6, slot12[3]) then
						slot4 = slot12[2]
						slot7 = true
					end
				end

				if not slot7 then
					for slot11, slot12 in ipairs(slot3.equip_orange_desc) do
						if slot12[1] > 0 and slot12[3] == 0 and slot12[1] == slot5 then
							slot4 = slot12[2]
							slot7 = true
						end
					end

					if not slot7 then
						for slot11, slot12 in ipairs(slot3.equip_orange_desc) do
							if slot12[1] == 0 and slot12[3] > 0 and table.indexof(slot6, slot12[3]) then
								slot4 = slot12[2]
								slot7 = true
							end
						end
					end
				end
			end

			return GetCfgDescription(slot4, 1)
		end

		return ""
	end,
	GetServantId = function (slot0, slot1)
		slot2 = 0

		if slot0:GetHeroServantInfo(slot1) then
			slot2 = slot3.id
		end

		return slot2
	end,
	GetModuleEffectList = function (slot0, slot1)
		slot2 = slot0:GetHeroData(slot1)
		slot3 = {}

		return HeroTools:GetModulePowersByHeroIDAndLevel(slot2.id, slot2.moduleLevel)
	end,
	GetAstrolabeAction = function (slot0, slot1)
		slot2 = AstrolabeAction

		if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			slot2 = PolyhedronAction
		end

		return slot2
	end,
	AstrolabeUnlock = function (slot0, slot1, slot2)
		AstrolabeAction.AstrolabeUnlock(slot1, slot2)
	end,
	AstrolabeEquip = function (slot0, slot1, slot2)
		slot0:GetAstrolabeAction().AstrolabeEquip(slot1, slot2)
	end,
	AstrolabeUnload = function (slot0, slot1, slot2)
		slot0:GetAstrolabeAction().AstrolabeUnload(slot1, slot2)
	end,
	AstrolabeEquipAll = function (slot0, slot1, slot2)
		slot0:GetAstrolabeAction().AstrolabeEquipAll(slot1, slot2)
	end,
	AstrolabeUnlock = function (slot0, slot1, slot2)
		AstrolabeAction.AstrolabeUnlock(slot1, slot2)
	end,
	AstrolabeUnloadAll = function (slot0, slot1)
		slot0:GetAstrolabeAction().AstrolabeUnloadAll(slot1)
	end,
	GetNextIsEquiped = function (slot0, slot1, slot2)
		slot4 = HeroAstrolabeCfg.get_id_list_by_pre_astrolabe_id[slot1] or {}

		if HeroAstrolabeCfg[slot1].pos == 3 then
			return false
		end

		slot5 = slot0:GetHeroData(slot2)

		for slot9, slot10 in ipairs(slot4) do
			if not HeroAstrolabeCfg[slot10] then
				return false
			else
				return AstrolabeTools.GetIsEquiped(slot5.using_astrolabe, slot10)
			end
		end

		return false
	end,
	GetLastIsEquiped = function (slot0, slot1, slot2)
		slot5 = slot0:GetHeroData(slot2)

		if HeroAstrolabeCfg[slot1].pre_astrolabe_id == 0 then
			return true
		end

		if HeroAstrolabeCfg[slot4] then
			return AstrolabeTools.GetIsEquiped(slot5.using_astrolabe, slot4)
		end

		return false
	end
}
