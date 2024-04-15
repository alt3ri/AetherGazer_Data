return {
	GetSmallStageShow = function (slot0)
		if table.indexof(HeroStarCfg.get_id_list_by_star[HeroStarCfg[slot0].star], slot0) - 1 == 1 then
			return "I"
		elseif slot2 == 2 then
			return "Ⅱ"
		elseif slot2 == 3 then
			return "Ⅲ"
		elseif slot2 == 4 then
			return "Ⅳ"
		end

		return ""
	end,
	UpdateSliImageFill = function (slot0, slot1, slot2)
		for slot8, slot9 in pairs(HeroStarCfg.get_id_list_by_star[slot1]) do
			if HeroStarCfg[slot9].phase > 0 and slot9 <= slot2 then
				slot4 = 0 + 1
			end
		end

		slot0.fillAmount = slot4 / 4
	end,
	GetNextSurpassStarID = function (slot0)
		return HeroStarCfg.all[table.indexof(HeroStarCfg.all, slot0) + 1] or slot0 + 1
	end,
	ChangeIconStarSpirte = function (slot0, slot1)
		slot0.sprite = getSprite("Atlas/Common", "star_" .. slot1)
	end,
	GetStarUpAttrShowDesc = function (slot0, slot1, slot2)
		slot5 = {}

		for slot9, slot10 in ipairs(HeroStarUpTemplateCfg.get_id_list_by_template[slot0.star_up_skill_template]) do
			if HeroStarUpTemplateCfg[slot10].stage == slot1 then
				slot5 = HeroStarSkillCfg[slot11.skill_id]

				break
			end
		end

		slot6 = {}
		slot7 = {}
		slot8 = ""

		if slot5.type == HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP then
			for slot13, slot14 in pairs(slot5.params) do
				slot16 = slot14[2]
				slot18 = PublicAttrCfg[slot14[1]].percent == 1 and string.format("+%.2f", slot16 / 10) .. "%" or string.format("+%.0f", slot16)

				if not slot2 then
					desc = string.format("%s%s", GetI18NText(slot17.name), slot18)

					table.insert(slot7, desc)
				end

				table.insert(slot6, {
					attrId = slot15,
					value = slot18
				})
			end
		elseif slot5.type == HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP then
			if slot5.params[1] then
				slot10 = slot5.params[1]

				table.insert(slot7, string.format(GetI18NText(slot5.desc), GetI18NText(slot0.skill_subhead[slot10[1]]), string.format("<color=#297de0>%s</color>", GetI18NText(HeroSkillCfg[slot0.skills[slot10[1]]].name)), slot10[2]))
			else
				slot8 = GetI18NText(slot5.desc)

				table.insert(slot7, GetI18NText(slot5.desc))
			end
		else
			slot8 = slot5 and GetI18NText(slot5.desc) or ""
		end

		return slot7, slot8, slot5, slot6
	end
}
