BattleTeamPlayerTemplate = class("BattleTeamHeroTemplate")

function BattleTeamPlayerTemplate.Ctor(slot0, slot1)
	slot0.playerID = slot1.player_id
	slot2 = slot1.player_battle_info
	slot0.nick = slot2.nick
	slot0.level = slot2.level
	slot0.channel = slot2.channel
	slot0.server = slot2.server
	slot0.heroList = {}

	for slot6, slot7 in ipairs(slot2.hero_list) do
		slot8 = slot7.hero_base_info
		slot10 = slot8.using_skin
		slot11 = 0

		if slot7.hero_type == 2 then
			slot9 = HeroStandardSystemCfg[slot8.id].hero_id
			slot11 = slot8.id
		end

		slot12 = {
			id = slot9,
			skin = slot10,
			trialID = slot11,
			star = slot8.star,
			exp = slot8.exp,
			level = HeroTools.CheckExp(1, slot8.exp),
			equip_list = {},
			using_astrolabe = {},
			skill = {},
			skillAttrList = {},
			break_level = slot8.break_level,
			weapon_info = {
				exp = slot8.weapon.exp,
				breakthrough = slot8.weapon.breakthrough
			},
			transition = {},
			weapon_module_level = slot8.weapon_module_level,
			dormLevel = slot7.dorm_level,
			servantInfo = {
				id = slot8.servant.id,
				stage = slot8.servant.stage
			},
			relation = slot13
		}

		if slot8.servant then
			-- Nothing
		else
			slot12.servantInfo = {}
		end

		if slot7.equip_list then
			for slot16, slot17 in ipairs(slot7.equip_list) do
				slot18 = {}
				slot19 = {}

				if slot17.enchant_slot_list then
					for slot23, slot24 in ipairs(slot17.enchant_slot_list) do
						slot25 = slot24.id
						slot27 = {}

						for slot31, slot32 in ipairs(slot24.effect_list) do
							table.insert(slot27, {
								id = slot32.id,
								num = slot32.level
							})
						end

						if #slot27 > 0 then
							slot18[slot23] = slot27
						end

						table.insert(slot19, {
							id = slot25,
							effect_list = cleanProtoTable(slot24.effect_list, {
								"id",
								"level"
							}),
							preview_list = {}
						})
					end
				end

				slot12.equip_list[slot16] = {
					equip_id = slot17.equip_id,
					prefab_id = slot17.prefab_id,
					exp = slot17.exp,
					now_break_level = slot17.now_break_level or 0,
					enchant = slot18,
					race = slot17.race,
					enchant_slot_list = slot19
				}
			end
		end

		if slot8.using_astrolabe then
			for slot16, slot17 in ipairs(slot8.using_astrolabe) do
				slot12.using_astrolabe[slot16] = slot17
			end
		end

		if slot8.skill then
			for slot16, slot17 in ipairs(slot8.skill) do
				slot12.skill[slot16] = {
					skill_id = slot17.skill_id,
					skill_level = slot17.skill_level
				}
			end
		end

		if slot8.skill_intensify_attribute_list then
			for slot16, slot17 in ipairs(slot8.skill_intensify_attribute_list) do
				slot12.skillAttrList[slot16] = {
					index = slot17.index,
					level = slot17.level
				}
			end
		end

		if slot8.exclusive_skill_list then
			for slot18, slot19 in ipairs(slot8.exclusive_skill_list) do
				slot20 = slot19.slot_id

				for slot24, slot25 in ipairs(slot19.skill_list) do
					table.insert(slot13[slot20], slot25.skill_id)
					table.insert(slot14[slot20], slot25.skill_level)
				end
			end

			slot12.transition = HeroTools.InitTransitionByCfg({
				[slot20] = {}
			}, {
				[slot20] = {}
			})
		end

		HeroTrustRelationNet.New(slot7.hero_id):InitData(slot7.trust.relation)
		table.insert(slot0.heroList, slot12)

		slot12.trust = {
			level = slot7.trust.level,
			exp = slot7.trust.exp,
			mood = slot7.trust.mood
		}
	end

	slot0:UpdateRoomData(slot1.player_room_info)
end

function BattleTeamPlayerTemplate.UpdateRoomData(slot0, slot1)
	slot0.is_ready = slot1.is_ready
	slot0.is_master = slot1.is_master
	slot0.be_liked_uids = {}

	for slot5, slot6 in ipairs(slot1.be_liked_uids) do
		table.insert(slot0.be_liked_uids, slot6)
	end
end

function BattleTeamPlayerTemplate.ParseHeroViewData(slot0, slot1)
	if slot1 == nil then
		slot1 = 1
	end

	slot2 = slot0.heroList[slot1]
	slot3 = {
		id = slot2.id,
		exp = slot2.exp,
		level = slot2.level,
		star = slot2.star,
		piece = 0,
		unlock = 1,
		using_skin = slot2.skin,
		break_level = slot2.break_level,
		transition = {}
	}

	for slot7, slot8 in pairs(slot2.transition) do
		table.insert(slot3.transition, {
			talent_points = 0,
			slot_id = slot7,
			skill_list = slot8
		})
	end

	slot3.dormLevel = slot2.dormLevel
	slot3.unlocked_astrolabe = slot2.unlock_astrolabe
	slot3.using_astrolabe = slot2.using_astrolabe
	slot3.weapon_info = {
		level = WeaponTools.ExpToLv(slot2.weapon_info.exp),
		exp = slot2.weapon_info.exp,
		breakthrough = slot2.weapon_info.breakthrough
	}

	if slot2.servantInfo.id == nil or slot2.servantInfo.id == 0 then
		slot3.servantInfo = nil
	else
		slot3.servantInfo = {
			uid = 1,
			locked = true,
			id = slot2.servantInfo.id,
			stage = slot2.servantInfo.stage
		}
	end

	slot3.servant_uid = 1
	slot3.moduleLevel = slot2.weapon_module_level
	slot3.moduleAssignment = 0
	slot3.equip = {
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
	slot3.equip_struct_list = {}

	for slot7, slot8 in ipairs(slot2.equip_list) do
		slot10 = slot8.prefab_id
		slot12 = EquipCfg[slot10].pos
		slot3.equip[slot12].equip_id = slot10
		slot13 = {
			race_preview = 0,
			is_lock = 0,
			equip_id = slot8.equip_id,
			prefab_id = slot10,
			exp = slot8.exp,
			hero_id = slot2.id,
			now_break_level = slot8.now_break_level,
			enchant_slot_list = slot8.enchant_slot_list,
			race = slot8.race
		}
		slot14 = EquipStruct.New(slot13.equip_id, slot13.prefab_id)

		slot14:ParseServerData(slot13)

		slot3.equip_struct_list[slot12] = slot14
	end

	slot3.skillAttrList = slot2.skillAttrList
	slot3.skill = {}

	for slot7, slot8 in ipairs(slot2.skill) do
		table.insert(slot3.skill, {
			skill_id = slot8.skill_id,
			skill_level = math.max(1, slot8.skill_level - HeroTools.GetHeroSkillAddLevel(slot3, slot8.skill_id))
		})
	end

	return slot3, slot3.servantInfo
end
