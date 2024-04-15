return {
	CheckRelationUpgradeCondition = function (slot0, slot1)
		if not HeroRelationUpgradeConditionCfg[slot0] then
			return false
		end

		if slot2.type == 1 then
			for slot6, slot7 in ipairs(slot1) do
				if slot2.arg[1] <= HeroData:GetHeroData(slot7).level then
					return true
				end
			end

			return false
		elseif slot2.type == 2 then
			for slot6, slot7 in ipairs(slot1) do
				slot9 = 0

				for slot13, slot14 in ipairs(HeroData:GetHeroData(slot7).skill) do
					slot9 = SkillTools.GetIsDodgeSkill(slot14.skill_id) and slot9 + 1 or slot9 + HeroTools.GetTotalSkillLv(slot7, slot14.skill_id)
				end

				if slot2.arg[1] <= slot9 then
					return true
				end
			end

			return false
		elseif slot2.type == 3 then
			for slot6, slot7 in ipairs(slot1) do
				if slot2.arg[1] <= HeroData:GetHeroData(slot7).weapon_info.level then
					return true
				end
			end

			return false
		elseif slot2.type == 4 then
			for slot6, slot7 in ipairs(slot1) do
				if slot2.arg[1] <= HeroData:GetHeroData(slot7).star then
					return true
				end
			end

			return false
		elseif slot2.type == 5 then
			for slot6, slot7 in ipairs(slot1) do
				if slot2.arg[1] <= HeroTools.GetHeroProficiency(slot7) then
					return true
				end
			end

			return false
		elseif slot2.type == 6 then
			for slot6, slot7 in ipairs(slot1) do
				if HeroData:GetHeroData(slot7) then
					for slot13, slot14 in ipairs(slot8.transition) do
						slot9 = 0 + slot14.talent_points
					end

					if slot2.arg[1] <= slot9 then
						return true
					end
				end
			end
		else
			return false
		end
	end,
	GetRelationUpgradeConditionDes = function (slot0)
		if not HeroRelationUpgradeConditionCfg[slot0] then
			return ""
		end

		if slot1.type == 1 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_1", slot1.arg[1])
		elseif slot1.type == 2 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_2", slot1.arg[1])
		elseif slot1.type == 3 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_3", slot1.arg[1])
		elseif slot1.type == 4 then
			slot2 = slot1.arg[1]
			slot3 = slot2

			if slot2 == 100 then
				slot3 = "B"
			elseif slot2 == 200 then
				slot3 = "A"
			elseif slot2 == 300 then
				slot3 = "S"
			elseif slot2 == 400 then
				slot3 = "SS"
			elseif slot2 == 500 then
				slot3 = "SSS"
			elseif slot2 == 600 then
				slot3 = "Ω"
			end

			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_4", slot3)
		elseif slot1.type == 5 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_5", slot1.arg[1])
		elseif slot1.type == 6 then
			return GetTipsF("HERO_RELATION_UPGRADE_CONDITION_6", slot1.arg[1])
		else
			return ""
		end
	end,
	GetTrustLvDes = function (slot0)
		return GetTips("HERO_TRUST_LEVEL_DES_" .. slot0)
	end,
	GetLikeLvDes = function (slot0)
		return GetTips("HERO_LIKE_LEVEL_DES_" .. slot0)
	end,
	GetRelationConfig = function (slot0, slot1)
		for slot5, slot6 in ipairs(HeroRelationCfg.get_id_list_by_main_hero_id[slot0]) do
			if slot1 == HeroRelationCfg[slot6].relate_hero_id then
				return slot7
			end
		end

		return nil
	end,
	CheckWallPaperIsUnlock = function (slot0)
		if slot0.type == 1 then
			return HeroData:GetHeroData(slot0.id).unlock == 1
		elseif slot0.type == 2 then
			for slot6, slot7 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot0.id].hero)) do
				if slot7 == slot0.id then
					return true
				end
			end

			return false
		elseif slot0.type == 3 then
			return IllustratedData:GetIllustrationInfo()[slot0.id] ~= nil
		end
	end,
	NeedShowArchivePop = function ()
		if manager.time:IsToday(getData("archivePop", "cache") or 0) then
			return false, 0, 0
		end

		slot2, slot3 = nil

		for slot7, slot8 in pairs(HeroData:GetHeroList()) do
			if #HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[slot8.id][1]].super_plot_id > 0 then
				slot12, slot13, slot14 = IsConditionAchieved(GameSetting.hero_super_plot_unlock_condition.value[2], {
					heroId = slot8.id
				})

				if slot12 and #ArchiveData:GetHasViewedSuperHeartList(slot9) < 2 and not getData("archivePop", "popInfo" .. slot9 .. 2) then
					return true, slot8.id, 2
				end
			end
		end

		for slot7, slot8 in pairs(slot1) do
			if #HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[slot8.id][1]].plot_id > 0 then
				if ArchiveData:GetArchive(slot9).lv == 5 and #ArchiveData:GetHasViewedHeartList(slot9) < slot11 - 1 and not getData("archivePop", "popInfo" .. slot9 .. 1) then
					return true, slot8.id, 1
				end
			end
		end

		return false, 0, 0
	end
}
