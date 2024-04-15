slot1 = import("game.const.HeroConst")

return {
	GetAstrolabeDescByServant = function (slot0, slot1)
		if not AstrolabeEffectCfg[slot0] then
			print("id" .. slot0 .. "没有配置")
		end

		if slot2 and slot2.desc and type(slot2.desc) == "table" then
			if not slot2.desc[1] then
				print("id" .. slot0 .. "等级溢出" .. 1)

				return ""
			end

			slot3 = slot2.desc[1]

			if slot1 ~= 0 and slot2.equip_orange_desc and type(slot2.equip_orange_desc) == "table" then
				for slot7, slot8 in ipairs(slot2.equip_orange_desc) do
					if slot8[1] == slot1 then
						slot3 = slot8[2]
					end
				end
			end

			return GetCfgDescription(slot3, 1)
		end

		return ""
	end,
	GetHeroIDBySkillID = function (slot0)
		slot1 = nil

		while slot0 > 9999 do
			slot0 = slot0 / 10
		end

		return math.modf(slot0)
	end,
	GetIsDodgeSkill = function (slot0)
		return slot0 % 1000 == 305
	end,
	GetIsPassiveSkill = function (slot0)
		return slot0 % 1000 == 999
	end,
	GetIsMelee = function (slot0)
		return slot0 % 1000 < 200
	end,
	GetMainHeroId = function (slot0)
		return math.floor(slot0 / 1000)
	end,
	GetSkillIdIndex = function (slot0)
		return table.indexof(HeroCfg[uv0.GetMainHeroId(slot0)].skills, slot0)
	end,
	GetIsCanUp = function (slot0, slot1)
		if uv0.GetIsPassiveSkill(slot0) or slot1 == uv1.MAX_SKILL_LEVEL or uv0.GetIsDodgeSkill(slot0) then
			return false
		end

		slot2 = uv0.GetMainHeroId(slot0)

		if HeroData:GetHeroData(slot2).break_level < SkillCfg[slot1]["skill_limit" .. table.indexof(HeroCfg[slot2].skills, slot0)] then
			return false
		end

		slot7 = SkillCfg[slot1]["skill_cost" .. slot5][1]

		return slot7[2] < ItemTools.getItemNum(slot7[1])
	end,
	GetIsCanUpNew = function (slot0, slot1, slot2)
		if SkillTools.GetIsDodgeSkill(slot0) then
			return false
		end

		slot6 = slot1
		slot7 = SkillTools.GetSkillIdIndex(slot3)
		slot8 = nil

		if not slot2 then
			if HeroData:GetHeroData(uv0.GetMainHeroId(slot3)).break_level < SkillCfg[slot6]["skill_limit" .. slot7] or uv1.MAX_SKILL_LEVEL <= slot6 then
				return false
			end

			slot8 = SkillCfg[slot6]["skill_cost" .. slot7]
		else
			if slot6 < uv1.MAX_SKILL_LEVEL then
				return false
			end

			if HeroTools.GetSkillAttrLv(slot5.id, slot7) == uv1.MAX_SKILL_ATTR_LEVEL then
				return false
			end

			if (uv0.GetSkillAttrCfg(slot5.id, slot7, slot9 + 1) and slot10.cost or nil) == nil or slot8 and #slot8 == 0 then
				return false
			end
		end

		slot9 = true

		for slot13 = 1, 2 do
			if slot8 and slot8[slot13] and ItemTools.getItemNum(slot8[slot13][1]) < slot8[slot13][2] then
				slot9 = false

				break
			end
		end

		return slot9
	end,
	GetSkillUpCostNum = function (slot0, slot1, slot2)
		slot4 = {}

		for slot8 = 1, slot2 do
			slot9 = SkillCfg[slot1 + slot8 - 1]["skill_cost" .. SkillTools.GetSkillIdIndex(slot0)][1]
			slot4[slot9[1]] = (slot4[slot9[1]] or 0) + slot9[2]
		end

		return slot4
	end,
	GetRealSkillIdByWeaponServantId = function (slot0, slot1, slot2)
		slot4 = slot2

		for slot8, slot9 in pairs(HeroCfg[slot0].equip_orange_skill) do
			if slot9[1] == slot2 and slot1 == slot9[2] then
				slot4 = slot9[3]
			end
		end

		return slot4
	end,
	GetAttr = function (slot0)
		slot2 = nil

		return PublicAttrCfg[slot0[1]].name, (PublicAttrCfg[slot0[1]].percent ~= 1 or string.format("%.2f%%", slot0[2] / 10)) and string.format("%d", slot0[2]), getSprite("Atlas/SystemCommonAtlas", PublicAttrCfg[slot0[1]].icon)
	end,
	GetSkillModuleDes = function (slot0)
		slot2 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
		slot4 = nil

		for slot8, slot9 in pairs(HeroCfg[uv0.GetHeroIDBySkillID(getSkillIDOrServantID(slot0))].skills) do
			if slot9 == slot1 then
				slot4 = HeroCfg[slot3].skill_subhead[slot8]

				break
			end
		end

		return string.format(slot2, slot4, HeroSkillCfg[slot1].name, uv0.GetSkillRate(HeroSkillCfg[slot1].desc[1]), uv0.GetSkillRate(HeroSkillCfg[slot1].strengthen_desc[2]))
	end,
	GetServantSkillModuleDes = function (slot0)
		slot2 = GetTips("WEAPON_MODULE_SKILL_TIP_TEMPLATE_2")
		slot3 = uv0.GetHeroIDBySkillID(getSkillIDOrServantID(slot0))
		slot5 = nil

		for slot9, slot10 in pairs(HeroCfg[slot3].skills) do
			if slot10 == HeroCfg[slot3].equip_orange_skill[1][1] then
				slot5 = HeroCfg[slot3].skill_subhead[slot9]

				break
			end
		end

		return string.format(slot2, slot5, HeroSkillCfg[slot1].name, uv0.GetSkillRate(HeroSkillCfg[slot1].desc[1]), uv0.GetSkillRate(HeroSkillCfg[slot1].strengthen_desc[2]))
	end,
	GetSkillRate = function (slot0)
		if not DescriptionCfg[slot0] then
			return ""
		end

		slot2 = nil

		if slot1.type == 1 and #slot1.param >= 1 then
			for slot7, slot8 in ipairs(slot3) do
				slot11 = slot8[4]
				slot12 = slot8[1] % 1 == 0 and string.format("%.0f", slot12) .. slot11 or string.format("%.1f", slot12) .. slot11

				if slot8[3] then
					slot2 = slot2 == nil and slot12 or slot12 .. "/" .. slot12
				end
			end
		end

		return slot2 or ""
	end,
	CanUseComboSkill = function (slot0, slot1)
		if slot0 == 0 then
			return true
		end

		for slot6, slot7 in ipairs(ComboSkillCfg[slot0].cooperate_role_ids) do
			if not table.keyof(slot1, slot7) then
				return false
			end
		end

		return true
	end,
	GetSkillAttrCfg = function (slot0, slot1, slot2)
		slot3 = nil

		if HeroSkillElementCfg[tonumber((slot2 >= 10 or string.format("%s0%s", slot0, slot2)) and string.format("%s%s", slot0, slot2))] then
			return {
				cost = slot4["skill_element_cost" .. slot1],
				attr = slot4["skill_element_attr" .. slot1]
			}
		end

		return nil
	end,
	GetSkillAttrCost = function (slot0, slot1, slot2, slot3)
		slot4 = {}

		for slot8 = 1, slot3 do
			if uv0.GetSkillAttrCfg(slot0, slot1, slot2 + slot8 - 1) then
				slot10 = slot9.cost
				slot4[slot10[1]] = (slot4[slot10[1]] or 0) + slot10[2]
			end
		end

		return slot4
	end
}
