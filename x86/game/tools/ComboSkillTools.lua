slot1 = nil

return {
	InitComboList = function ()
		uv0 = {}

		for slot3, slot4 in ipairs(ComboSkillCfg.all) do
			slot5 = ComboSkillCfg[slot4]

			if not uv1.GetIsHide(slot4) then
				for slot9, slot10 in ipairs(slot5.cooperate_role_ids) do
					uv0[slot10] = uv0[slot10] or {}

					table.insert(uv0[slot10], slot5.id)
				end
			end
		end

		for slot3, slot4 in ipairs(uv0) do
			table.sort(slot4, uv1.RuleSort)
		end
	end,
	GetIsHide = function (slot0)
		for slot5, slot6 in ipairs(ComboSkillCfg[slot0].cooperate_role_ids) do
			if HeroTools.GetIsHide(slot6) then
				return true
			end
		end

		return false
	end,
	GetHeroComboSkill = function (slot0)
		if uv0 == nil then
			uv1.InitComboList()
		end

		return uv0[slot0]
	end,
	GetComboSkillLevel = function (slot0)
		slot2 = GameSetting.hero_combo_skill_relate.value[1]
		slot3 = 0

		for slot7, slot8 in ipairs(ComboSkillCfg[slot0].cooperate_role_ids) do
			if HeroData:GetHeroList()[slot8].unlock == 0 then
				break
			end

			slot3 = slot3 + HeroTools.GetTotalSkillLv(slot8, HeroCfg[slot8].skills[slot2])
		end

		return math.floor(slot3 / #slot1.cooperate_role_ids) > 0 and slot3 or 1
	end,
	GetMatrixComboSkillLevel = function (slot0, slot1)
		slot3 = GameSetting.hero_combo_skill_relate.value[1]

		for slot8, slot9 in ipairs(ComboSkillCfg[slot0].cooperate_role_ids) do
			slot4 = 0 + HeroStandardSystemCfg[MatrixData:GetHeroData(slot9):GetStandardId()].skill_lv
		end

		return math.floor(slot4 / #slot2.cooperate_role_ids) > 0 and slot4 or 1
	end,
	GetComboSkillList = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in ipairs(slot0) do
			for slot14, slot15 in ipairs(uv0.GetHeroComboSkill(slot9) or {}) do
				if uv0.IsAllMatch(slot15, slot0) then
					if not table.keyof(slot3, slot15) then
						table.insert(slot3, slot15)
					end
				elseif slot1 and not table.keyof(slot4, slot15) then
					table.insert(slot4, slot15)
				end
			end
		end

		table.sort(slot3, function (slot0, slot1)
			if slot0 == slot1 then
				return false
			end

			if #ComboSkillCfg[slot0].cooperate_role_ids == #ComboSkillCfg[slot1].cooperate_role_ids then
				if table.keyof(ComboSkillCfg[slot0].cooperate_role_ids, uv0[1]) then
					if table.keyof(ComboSkillCfg[slot0].cooperate_role_ids, uv0[2]) then
						return true
					end

					return false
				else
					return false
				end
			end

			return slot3 < slot2
		end)
		table.insertto(slot2, slot3)
		table.insertto(slot2, slot4)
		table.insert(slot2, 0)

		return slot2, slot3
	end,
	RuleSort = function (slot0, slot1)
		return #ComboSkillCfg[slot0].cooperate_role_ids > #ComboSkillCfg[slot1].cooperate_role_ids
	end,
	IsAllMatch = function (slot0, slot1)
		for slot6, slot7 in ipairs(ComboSkillCfg[slot0].cooperate_role_ids) do
			if not table.keyof(slot1, slot7) then
				return false
			end
		end

		return true
	end,
	GetRecommendSkillID = function (slot0, slot1)
		slot2, slot3 = uv0.GetComboSkillList(slot0, slot1)

		return slot3[1] or 0
	end,
	CheckError = function (slot0, slot1, slot2)
		if slot0 == 0 then
			return 0
		end

		if not slot0 or not uv0.IsAllMatch(slot0, slot1) then
			return uv0.GetRecommendSkillID(slot1, slot2)
		end

		return slot0
	end,
	GetMaxComboSkillLevel = function (slot0)
		return 3
	end,
	CheckComboSkillUpContion = function (slot0, slot1)
		slot2 = ComboSkillLevelCfg[slot0]
		slot3 = slot2.target

		if slot2.condition_type == 1 then
			slot5 = nil

			for slot9, slot10 in ipairs(ComboSkillCfg[slot1].cooperate_role_ids) do
				slot12 = HeroTools.GetTotalSkillLv(slot10, HeroCfg[slot10].skills[GameSetting.hero_combo_skill_relate.value[1]])

				if slot5 == nil or slot12 < slot5 then
					slot5 = slot12
				end
			end

			return slot3 <= slot5, math.min(slot5, slot3), slot3
		else
			slot4 = ComboSkillData:GetComboSkillUpConditionProcess(slot1, slot0)

			return slot3 <= slot4, math.min(slot4, slot3), slot3
		end
	end
}
