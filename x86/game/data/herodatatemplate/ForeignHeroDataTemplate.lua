slot0 = class("ForeignHeroDataTemplate", BaseHeroDataTemplate)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0, slot1)

	slot0.relation = HeroTrustRelationNet.New(slot1)
	slot0.trust = {
		exp = 0,
		mood = 1,
		level = 0
	}
	slot0.clear_mission_list = {}
	slot0.clear_times = 0
	slot0.piece = 0
	slot0.unlocked_skin = {}
	slot0.equipDataList = {}
	slot0.dormLevel = 0
	slot0.equip_list = {}
end

function slot0.Init(slot0, slot1)
	slot2 = slot1.hero_base_info
	slot0.id = slot2.id
	slot0.exp = slot2.exp
	slot0.level = slot2.level
	slot0.star = slot2.star
	slot0.skill = cleanProtoTable(slot2.skill, {
		"skill_id",
		"skill_level"
	})
	slot0.skillAttrList = cleanProtoTable(slot2.skill_intensify_attribute_list, {
		"index",
		"level"
	})
	slot0.unlocked_astrolabe = cleanProtoTable(slot2.unlock_astrolabe)
	slot0.using_astrolabe = cleanProtoTable(slot2.using_astrolabe)
	slot0.break_level = slot2.break_level
	slot0.weapon_info = {
		level = WeaponTools.ExpToLv(slot2.weapon.exp),
		exp = slot2.weapon.exp,
		breakthrough = slot2.weapon.breakthrough
	}
	slot0.using_skin = slot2.using_skin
	slot0.moduleLevel = slot2.weapon_module_level
	slot0.servantInfo = {
		uid = 0,
		locked = true,
		id = slot2.servant.id,
		stage = slot2.servant.stage
	}
	slot0.transition = slot0:InitTransition(slot2.exclusive_skill_list or {})
	slot0.unlock = 1
	slot0.using_hero_chip = cleanProtoTable(slot1.using_hero_chip)
	slot0.equip = slot0:InitHeroEquip(slot2.id, slot1.equip_list)
	slot0.servant_uid = 0
	slot0.moduleAssignment = {}
	slot0.unlocked_skin = {}
	slot0.dormLevel = slot1.dorm_level
	slot0.trust = {
		level = slot1.trust.level,
		exp = slot1.trust.exp,
		mood = slot1.trust.mood
	}
	slot3 = HeroTrustRelationNet.New(slot1.id)

	slot3:InitData(slot1.trust.relation)

	slot0.relation = slot3
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

function slot0.GetSkillAttrList(slot0)
	return slot0.skillAttrList
end

function slot0.GetTransitionInfoList(slot0)
	return slot0.transition
end

function slot0.InitTransition(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		-- Nothing
	end

	return {
		[slot6] = {
			slot_id = slot7.slot_id,
			skill_list = cleanProtoTable(slot7.skill_list, {
				"skill_id",
				"skill_level"
			}),
			talent_points = slot7.talent_points
		}
	}
end

function slot0.GetType(slot0)
	return HeroConst.HERO_DATA_TYPE.FOREIGN
end

function slot0.InitHeroEquip(slot0, slot1, slot2)
	slot3 = {
		{
			pos = 1,
			equip_id = 0
		},
		{
			pos = 2,
			equip_id = 0
		},
		{
			pos = 3,
			equip_id = 0
		},
		{
			pos = 4,
			equip_id = 0
		},
		{
			pos = 5,
			equip_id = 0
		},
		{
			pos = 6,
			equip_id = 0
		}
	}

	for slot7, slot8 in ipairs(slot2) do
		slot9 = slot8.equip_id
		slot3[EquipCfg[slot9].pos].equip_id = slot9
		slot11 = {
			race_preview = 0,
			is_lock = true,
			equip_id = slot7,
			prefab_id = slot9,
			exp = slot8.exp,
			hero_id = slot1,
			now_break_level = slot8.now_break_level,
			enchant_slot_list = slot0:InitEnchantInfo(slot8.enchant_slot_list),
			race = slot8.race
		}
		slot12 = EquipStruct.New(slot11.equip_id, slot11.prefab_id)

		slot12:ParseServerData(slot11)

		slot0.equip_list[slot7] = slot12
	end

	return slot3
end

function slot0.InitEnchantInfo(slot0, slot1)
	for slot6, slot7 in ipairs(slot1) do
		-- Nothing
	end

	return {
		[slot7.id] = {
			id = slot7.id,
			effect_list = cleanProtoTable(slot7.effect_list, {
				"id",
				"level"
			}),
			preview_list = {}
		}
	}
end

return slot0
