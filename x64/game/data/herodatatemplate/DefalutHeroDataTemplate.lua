slot0 = class("DefaultHeroDataTemplate", BaseHeroDataTemplate)

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
	slot0.timeValid_skin = {}
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
	slot0.servant_uid = tonumber(slot2.weapon.servant_uid) or 0
	slot0.transition = slot0:InitTransition(slot2.exclusive_skill_list or {})
	slot0.unlock = slot1.unlock
	slot0.equip = cleanProtoTable(slot1.equip, {
		"pos",
		"equip_id"
	})
	slot0.clear_mission_list = cleanProtoTable(slot1.clear_mission_list)
	slot0.clear_times = slot1.clear_times or 0
	slot0.moduleAssignment = slot1.weapon_module_assignment
	slot0.unlocked_skin = cleanProtoTable(slot1.unlocked_skin, {
		"skin_id",
		"time"
	})
	slot0.trust = {
		level = slot1.trust.level,
		exp = slot1.trust.exp,
		mood = slot1.trust.mood
	}
	slot3 = HeroTrustRelationNet.New(slot2.id)

	slot3:InitData(slot1.trust.relation)

	slot0.relation = slot3
end

function slot0.ModifyHero(slot0, slot1)
	slot0:Init(slot1)
end

function slot0.GetServantInfo(slot0)
	return WeaponServantData.GetWeaponServantList()[slot0.servant_uid] or {
		id = 0,
		uid = 0,
		lock = true,
		stage = 1
	}
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
	return HeroConst.HERO_DATA_TYPE.DEFAULT
end

function slot0.SetPicece(slot0, slot1)
	slot0.piece = slot1
end

return slot0
