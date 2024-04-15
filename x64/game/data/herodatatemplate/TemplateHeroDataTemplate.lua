slot0 = class("TemplateHeroDataTemplate", BaseHeroDataTemplate)

function slot0.Ctor(slot0, slot1)
	TemplateHeroDataTemplate.super.Ctor(slot0, slot1)

	slot0.piece = 0
	slot0.unlocked_skin = {}
end

function slot0.Init(slot0, slot1)
	slot0.tempID = slot1.id
	slot0.id = SkinCfg[slot1.skin_id].hero
	slot0.exp = LvTools.LevelToExp(slot1.hero_lv, "hero_level_exp1")
	slot0.level = slot1.hero_lv
	slot0.star = slot1.star_lv
	slot0.unlock = 1
	slot0.skill = slot0:GetSkillTable(slot0.id, slot1.skill_lv)
	slot0.skillAttrList = slot0:GetSkillAttrTable(slot1.skill_element)
	slot0.unlocked_astrolabe = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1.astrolabe_suit_id] or {}
	slot0.using_astrolabe = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot1.astrolabe_suit_id] or {}
	slot0.equip = slot0:GetEquipTable(slot1.equip_list)
	slot0.equip_list = slot0:GetConstructVirtualEquips(slot1.id)
	slot0.clear_mission_list = {}
	slot0.clear_times = 0
	slot0.break_level = slot1.hero_break
	slot0.weapon_info = {
		level = slot1.weapon_level,
		exp = GameLevelSetting[slot1.weapon_level].weapon_lv_exp_sum,
		breakthrough = slot1.weapon_break
	}
	slot0.transition = HeroTools.InitTransitionByCfg(slot1.equip_exclusive_id_list, slot1.equip_exclusive_lv_list)
	slot0.servant_uid = slot1.weapon_key
	slot0.servantInfo = {
		uid = 0,
		locked = true,
		id = slot1.weapon_key,
		stage = slot1.weapon_stage
	}
	slot0.moduleLevel = slot1.weapon_module_level
	slot0.using_skin = slot1.skin_id
	slot0.weapon_module_level = slot1.weapon_module_level
end

function slot0.ModifyHero(slot0, slot1)
	slot0:Init(slot1)
end

function slot0.GetServantInfo(slot0)
	return slot0.servantInfo
end

function slot0.GetWeaponInfo(slot0)
	return slot0.weapon_info
end

function slot0.GetEquipInfoList(slot0)
	return slot0.equip
end

function slot0.GetSkillInfoList(slot0)
	return slot0.skill
end

function slot0.GetTransitionInfoList(slot0)
	return slot0.transition
end

function slot0.GetType(slot0)
	return HeroConst.HERO_DATA_TYPE.TRIAL
end

function slot0.GetSkillTable(slot0, slot1, slot2)
	slot3 = {
		[slot8] = {}
	}

	for slot8, slot9 in ipairs(HeroCfg[slot1].skills) do
		slot3[slot8].skill_id = slot9
		slot3[slot8].skill_level = slot2

		if slot9 == HeroCfg[slot1].avoid[1] then
			slot3[slot8].skill_level = 1
		end
	end

	return slot3
end

function slot0.GetSkillAttrTable(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2, {
			index = slot6,
			level = slot7
		})
	end

	return slot2
end

function slot0.GetEquipTable(slot0, slot1)
	slot2 = {
		[slot6] = {}
	}

	for slot6 = 1, 6 do
		slot2[slot6].pos = slot6
		slot2[slot6].prefab_id = slot1[slot6] and slot1[slot6] or 0
	end

	return slot2
end

function slot0.GetConstructVirtualEquips(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(HeroStandardSystemCfg[slot1].equip_list) do
		slot10 = EquipStruct.New(0, slot8)
		slot10.equip_id = 1
		slot10.prefab_id = slot8
		slot10.exp = EquipExpCfg[slot3.equip_lv]["exp_sum_" .. EquipCfg[slot8].starlevel]
		slot10.race = slot3.hero_id
		slot10.now_break_level = slot3.break_lv - 1
		slot10.enchant = {}

		for slot14, slot15 in ipairs(slot3.equip_pool_list[slot7] or {}) do
			for slot19, slot20 in ipairs(EquipSkillPoolCfg[slot15].skill_id) do
				table.insert(slot10.enchant, {
					{
						id = slot20[1],
						num = slot20[2]
					}
				})
			end
		end

		table.insert(slot2, slot10)
	end

	return slot2
end

return slot0
