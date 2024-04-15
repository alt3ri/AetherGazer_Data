return {
	GetHeroSkillInfo = function (slot0, slot1)
		slot2 = {
			[slot8.skill_id] = slot8.skill_level
		}

		for slot7, slot8 in ipairs(slot0:GetHeroData(slot1).skill) do
			-- Nothing
		end

		slot4 = {}

		for slot8, slot9 in ipairs(HeroCfg[slot1].skills) do
			slot10 = HeroTools.GetHeroSkillAddLevel(slot3, slot9)

			if SkillTools.GetIsDodgeSkill(slot9) then
				slot10 = 0
			end

			table.insert(slot4, {
				id = slot9,
				heroId = slot1,
				lv = slot2[slot9],
				isCanStarUp = SkillTools.GetIsCanUpNew(slot9, slot2[slot9], false),
				isCanAttrUp = SkillTools.GetIsCanUpNew(slot9, slot2[slot9], true),
				addSkillLv = slot10,
				addEquipSkillLv = slot0:GetTransitionAddLevel(slot1, slot9)
			})
		end

		if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			for slot8, slot9 in ipairs(slot4) do
				slot9.lv = 1
				slot9.isCanUp = false
				slot9.addSkillLv = 0
			end
		elseif slot0.viewDataType == HeroConst.HERO_DATA_TYPE.FORIEGN then
			for slot8, slot9 in ipairs(slot4) do
				slot9.isCanUp = false
			end
		elseif slot0.viewDataType == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
			for slot8, slot9 in ipairs(slot4) do
				slot9.isCanUp = false
			end
		elseif slot0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
			for slot8, slot9 in ipairs(slot4) do
				slot9.isCanUp = false
			end
		end

		return slot4
	end,
	GetSkillLv = function (slot0, slot1, slot2)
		if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return 1
		else
			for slot7, slot8 in ipairs(slot0:GetHeroSkillInfoList(slot1)) do
				if slot8.skill_id == slot2 then
					return slot8.skill_level
				end
			end
		end

		return 0
	end,
	GetRealSkillId = function (slot0, slot1, slot2)
		slot3 = HeroCfg[slot1]
		slot4 = slot0:GetHeroData(slot1)
		slot5 = slot2
		slot6 = 0

		if slot0:GetHeroServantInfo(slot1) then
			slot6 = slot7.id
		end

		for slot11, slot12 in pairs(slot3.equip_orange_skill) do
			if slot12[1] == slot2 and slot6 == slot12[2] then
				slot5 = slot12[3]
			end
		end

		for slot11, slot12 in pairs(slot3.astrolabe_skill) do
			if slot12[1] == slot2 then
				for slot16, slot17 in pairs(slot4.using_astrolabe) do
					if slot12[2] == slot17 then
						slot5 = slot12[3]
					end
				end
			end
		end

		return slot5
	end,
	GetTransitionAddLevel = function (slot0, slot1, slot2)
		slot3 = slot0:GetHeroData(slot1)

		if not table.indexof(HeroCfg[slot1].skills, slot2) then
			return 0
		end

		slot6 = HeroTools.GetHeroEquipSkillAddLevel(slot3)
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot10 = 0
		slot11 = 0

		for slot15, slot16 in ipairs(slot3:GetTransitionInfoList()) do
			if slot0:GetEquipDataList(slot1)[slot16.slot_id].equip_id ~= 0 and GameSetting.exclusive_open_need.value[1] <= slot18:GetLevel() then
				for slot23, slot24 in ipairs(slot16.skill_list) do
					slot25 = slot24.skill_id

					for slot29, slot30 in ipairs(slot7) do
						if slot25 == slot30[1] and slot30[2] == slot5 then
							slot11 = slot11 + slot24.skill_level
							slot10 = slot25
						end
					end
				end
			end
		end

		if slot10 ~= 0 then
			slot12 = EquipSkillCfg[slot10]

			return slot12.upgrade / slot12.percent * (slot11 + slot6)
		end

		return 0
	end,
	GetSkillAttrLv = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(slot0:GetHeroData(slot1).skillAttrList or {}) do
			if slot8.index == slot2 then
				return slot8.level
			end
		end

		return 0
	end,
	GetSkillAtrrProgressValue = function (slot0, slot1, slot2, slot3)
		if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
			return 0
		end

		if (slot3 or slot0:GetSkillAttrLv(slot1, slot2)) / HeroConst.MAX_SKILL_ATTR_LEVEL > 1 then
			slot5 = 1
		end

		return slot5
	end,
	GetAdditionShowTextByType = function (slot0, slot1, slot2, slot3)
		slot4 = true
		slot5 = slot0:GetHeroData(slot2)

		if (slot3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT or slot3 == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE) and not SkillAdditionCfg[slot1] then
			return nil, false
		end

		slot7 = {}

		if slot3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONSERVANT then
			slot7 = slot0:GetWeaponServantData(slot5, slot6)
		elseif slot3 == HeroConst.HERO_SKILL_ADD_TYPE.WEAPONMODULE then
			slot7 = slot0:GetWeaponModuleData(slot2, slot1)
		elseif slot3 == HeroConst.HERO_SKILL_ADD_TYPE.ASTROLABE then
			slot7 = slot0:GetAstrolabeData(slot6, slot5)
		elseif slot3 == HeroConst.HERO_SKILL_ADD_TYPE.ATTRIBUTE then
			slot7 = {}
		end

		if not slot7 or not next(slot7) then
			slot4 = false
		end

		return slot7, slot4
	end,
	GetWeaponServantData = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = nil

		if WeaponServantCfg[slot1:GetServantInfo().id] then
			slot8 = slot7.effect
			slot9 = false

			for slot13, slot14 in pairs(slot2.weapon_servant_id or {}) do
				for slot18, slot19 in pairs(slot8) do
					if slot14 == slot19 then
						slot9 = true
					end
				end
			end

			if slot9 then
				table.insert(slot3, {
					titleName = ItemCfg[slot6].name,
					showDesc = slot0:GetServantEffect(slot6, slot5.stage + (HeroTools.GetHeroWeaponAddLevel(slot1) or 0))
				})
			end
		end

		return slot3
	end,
	GetWeaponModuleData = function (slot0, slot1, slot2)
		slot3 = {}
		slot5 = {}
		slot6 = true

		if slot0:GetHeroData(slot1).moduleLevel > 0 then
			slot7 = {}

			for slot11, slot12 in pairs(HeroTools:GetModulePowersByHeroIDAndLevel(slot1, slot4)) do
				if getSkillIDOrServantID(slot12) == slot2 then
					table.insert(slot7, slot12)
				end
			end

			slot8, slot9, slot10, slot11 = HeroTools.GetModuleAllDes(slot7, slot1)

			if slot9 then
				table.insert(slot3, {
					titleName = WeaponModuleCfg[slot1].name,
					showDesc = slot9
				})
			else
				slot6 = false
			end
		end

		return slot3, slot6
	end,
	GetAstrolabeData = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in pairs(slot1.astrolabe_id or {}) do
			for slot13, slot14 in pairs(slot2.using_astrolabe) do
				if slot14 == slot9 then
					table.insert(slot4, slot14)
				end
			end
		end

		for slot8, slot9 in pairs(slot4) do
			if HeroAstrolabeCfg[slot9] and AstrolabeEffectCfg[slot9] then
				if DescriptionCfg[AstrolabeEffectCfg[slot9] and AstrolabeEffectCfg[slot9].desc[1] or nil] then
					table.insert(slot3, {
						titleName = string.format("%s·%s", slot10.suit_name, slot10.name),
						showDesc = slot0:GetAstrolabeDesc(slot9, slot2.id)
					})
				end
			end
		end

		return slot3
	end,
	GetSkillAttrData = function (slot0, slot1, slot2)
		if SkillTools.GetIsDodgeSkill(slot1) then
			return {}
		end

		for slot9 = 1, slot0:GetSkillAttrLv(slot2, SkillTools.GetSkillIdIndex(slot1)) do
			if SkillTools.GetSkillAttrCfg(slot2, slot4, slot9) then
				slot11 = {
					titleName = string.format("%s%s", GetTips("LEVEL"), slot15)
				}
				showDesc = ""

				for slot9, slot16 in pairs(slot10.attr) do
					showDesc = string.format("%s%s<color=#F48800>%s%%</color>\n", showDesc, PublicAttrCfg[slot16[1]] and PublicAttrCfg[slot17].name or "", slot16[2] / 10)
				end

				slot11.showDesc = showDesc

				table.insert(slot3, slot11)
			end
		end

		return slot3
	end,
	GetSkillDesc = function (slot0, slot1, slot2, slot3)
		if not HeroSkillCfg[slot1] then
			print("技能 id" .. slot1 .. "没有配置")
		end

		slot2 = slot2 or 1
		slot5 = ""
		slot6 = SkillTools.GetHeroIDBySkillID(slot1)

		if slot4 and slot4.desc and type(slot4.desc) == "table" then
			slot7 = slot4.desc[1]

			if slot4.strengthen_desc and slot4.strengthen_desc[1] and table.indexof(HeroTools:GetModulePowersByHeroIDAndLevel(slot6, slot0:GetHeroData(slot6).moduleLevel), slot4.strengthen_desc[1]) then
				slot7 = slot4.strengthen_desc[2]
			end

			slot5 = GetCfgDescription(slot7, slot2)
		end

		if slot3 then
			return string.gsub(slot5, "%(" .. GetTips("SKILL_NEXT_LEVEL") .. ".-%)", "")
		end

		return string.gsub(slot5, "下一级", GetTips("SKILL_NEXT_LEVEL"))
	end,
	CheckIsSelf = function (slot0)
		return slot0.isSelf == true
	end
}
