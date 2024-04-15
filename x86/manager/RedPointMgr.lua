slot0 = class("RedPointMgr")

function slot0.Ctor(slot0)
	slot0._redPointHelper = require("manager/redPoint/RedPointController")

	slot0._redPointHelper:Init()
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:addGroup(RedPointConst.BULLETIN_UNREAD, {
		RedPointConst.BULLETIN_UNREAD_101,
		RedPointConst.BULLETIN_UNREAD_102,
		RedPointConst.BULLETIN_UNREAD_104
	})
	slot0:addGroup(RedPointConst.TASK, {
		RedPointConst.TASK_DAILY,
		RedPointConst.TASK_PLOT,
		RedPointConst.TASK_WEEK,
		RedPointConst.EXPLORE_MAIN
	})
	slot0:addGroup(RedPointConst.COMBAT, {
		RedPointConst.COMBAT_PLOT,
		RedPointConst.COMBAT_SUB_PLOT,
		RedPointConst.COMBAT_CHALLENGE,
		RedPointConst.COMBAT_EQUIP,
		RedPointConst.COMBAT_EQUIP,
		RedPointConst.RESOURSE_STAGE
	})

	slot1 = {}
	slot2 = {
		[slot6] = {}
	}

	for slot6 = 1, BattleConst.HARD_CNT do
	end

	for slot6, slot7 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.PLOT]) do
		slot8 = {}
		slot9 = 1

		for slot13, slot14 in pairs(ChapterClientCfg[slot7].chapter_list) do
			table.insert(slot8, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot14))

			slot16 = {
				string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot14)
			}

			if slot2[ChapterCfg[slot14].difficulty] then
				slot9 = slot15.difficulty

				if slot15.sub_type == 13 and slot15.difficulty == 1 then
					slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot14), {
						RedPointConst.TRAVEL_SKULD_CHAPTER .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL
					})
				elseif slot15.clientID == ChapterConst.CHAPTER_CLIENT_19 then
					slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot14), {
						RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR
					})
				end
			end

			slot17 = nil

			if ((slot15.unlock_activity_id == 0 or slot15.unlock_activity_id) and slot15.activity_id) ~= 0 then
				table.insert(slot16, string.format("%s%s", ActivityTools.GetRedPointKey(slot15.activity_id), slot17))
			end

			slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, slot14), slot16)
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot7), slot8)
		table.insert(slot1, string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot7))
		table.insert(slot2[slot9], string.format("%s_%s", RedPointConst.COMBAT_PLOT, slot7))
	end

	slot6 = slot1

	slot0:addGroup(RedPointConst.COMBAT_PLOT, slot6)

	for slot6 = 1, BattleConst.HARD_CNT do
		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_PLOT_LEVEL, slot6), slot2[slot6])
	end

	slot3 = {}

	for slot7, slot8 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT] or {}) do
		slot13 = RedPointConst.COMBAT_SUB_PLOT
		slot14 = slot8

		table.insert(slot3, string.format("%s_%s", slot13, slot14))

		slot9 = {}

		for slot13, slot14 in pairs(ChapterClientCfg[slot8].chapter_list) do
			table.insert(slot9, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot14))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, slot8), slot9)

		slot10 = {
			string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER_LIST, slot8),
			string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, slot8)
		}

		if slot8 == 6010003 then
			table.insert(slot10, string.format("%s_%s", RedPointConst.WAR_CHESS, 71012))
			table.insert(slot10, string.format("%s_%s", RedPointConst.WAR_CHESS, 71011))
			table.insert(slot10, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, slot8), slot10)
	end

	slot0:addGroup(RedPointConst.COMBAT_SUB_PLOT, slot3)
	slot0:addGroup(RedPointConst.BOSS_CHALLENGE, {
		RedPointConst.BOSS_CHALLENGE_NORMAL,
		RedPointConst.BOSS_CHALLENGE_ADVANCE
	})
	slot0:addGroup(RedPointConst.COMBAT_CHALLENGE, {
		RedPointConst.CHALLENGE_COMMON,
		RedPointConst.CHALLENGE_DEMO
	})

	slot4 = {}

	for slot9, slot10 in ipairs(ChapterClientCfg.get_id_list_by_toggle[401]) do
		table.insert(slot4, RedPointConst.TOWER_NEW_LEVEL + slot10)
	end

	slot0:addGroup(RedPointConst.TOWER, slot4)
	slot0:addGroup(RedPointConst.CHALLENGE_COMMON, {
		RedPointConst.MYTHIC_TIMES_AWARD,
		RedPointConst.MYTHIC_FINAL_AWARD,
		RedPointConst.BOSS_CHALLENGE,
		RedPointConst.MATRIX_EXCHANGE_BONUS,
		RedPointConst.POLYHEDRON,
		RedPointConst.ABYSS,
		RedPointConst.TOWER,
		RedPointConst.WARCHESS,
		RedPointConst.TEACH,
		RedPointConst.CORE_VERIFICATION
	})
	slot0:addGroup(RedPointConst.CHALLENGE_DEMO, {
		RedPointConst.COOPERATION_DEMO
	})
	slot0:addGroup(RedPointConst.TEACH, {
		RedPointConst.TEACH_BASE,
		RedPointConst.TEACH_CHARACTER
	})

	slot6 = ChapterTools.GetRedPoint(ChapterConst.DAILY_EQUIP_EXPERIENCE)

	slot0:addGroup(RedPointConst.COMBAT_EQUIP, {
		RedPointConst.BATTLE_EQUIP,
		RedPointConst.EQUIP_SEIZURE,
		slot6,
		RedPointConst.DAILY_EQUIP_ENCHANT
	})
	slot0:addGroup(slot6, {
		GetSystemNewRedKeyByChapter(ChapterConst.DAILY_EQUIP_EXPERIENCE)
	})
	slot0:addGroup(RedPointConst.DAILY_EQUIP_ENCHANT, {
		GetSystemNewRedKeyByChapter(ChapterConst.DAILY_EQUIP_ENCHANT)
	})
	slot0:addGroup(RedPointConst.EQUIP_SEIZURE, {
		RedPointConst.EQUIP_SEIZURE_REWARD,
		RedPointConst.EQUIP_SEIZURE_UNREAD
	})

	slot7 = {}

	for slot11, slot12 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.RESOURCE] or {}) do
		slot13 = ChapterTools.GetRedPoint(slot12)

		table.insert(slot7, slot13)
		slot0:addGroup(slot13, {
			GetSystemNewRedKeyByChapter(slot12)
		})
	end

	slot0:addGroup(RedPointConst.RESOURSE_STAGE, slot7)

	slot8 = {}
	slot9 = {}

	for slot13, slot14 in pairs(HeroCfg.get_id_list_by_private[0]) do
		table.insert(slot9, RedPointConst.HERO_ID .. slot14)

		slot17 = RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot14

		slot0:addGroup(RedPointConst.HERO_WEAPON .. slot14, {
			RedPointConst.HERO_WEAPON_BREAK_ID .. slot14
		})

		slot19 = RedPointConst.HERO_UNLOCK_ID .. slot14
		slot20 = RedPointConst.HERO_PROPERTY_PAGE .. slot14
		slot21 = RedPointConst.HERO_STAR_ID .. slot14
		slot22 = RedPointConst.HERO_SKIN_ID .. slot14
		slot23 = {}

		for slot28, slot29 in pairs(SkinCfg.get_id_list_by_hero[slot14]) do
			table.insert(slot23, RedPointConst.HERO_SKIN_ROUTE_ID .. slot29)
		end

		slot0:addGroup(slot22, slot23)

		slot25 = {}
		slot26 = {}

		for slot30, slot31 in pairs(SkinCfg.get_id_list_by_hero[slot14]) do
			table.insert(slot25, RedPointConst.HERO_SKIN_ID_EXTEND .. slot31)

			if #SkinCfg[slot31].gift > 0 then
				table.insert(slot26, RedPointConst.SKIN_GIFT .. "_" .. slot31)
			end
		end

		slot27 = {}

		table.insertto(slot27, slot25)
		table.insertto(slot27, slot26)
		slot0:addGroup(slot22, slot27)

		slot28 = string.format("%s_%s", RedPointConst.HERO_REALTION, slot14)

		slot0:addGroup(slot28, {
			string.format("%s_%s", RedPointConst.HERO_REALTION_UNLOCK, slot14),
			string.format("%s_%s", RedPointConst.HERO_RELATION_STORY, slot14),
			string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, slot14)
		})
		slot0:addGroup(slot20, {
			slot21,
			slot22,
			slot19,
			slot17
		})
		table.insert(slot8, RedPointConst.HERO_HEART_STORY_ROOT_ID .. slot14)

		slot36 = {
			RedPointConst.HERO_HEARTLINK_ID .. HeroTools.GetHeroOntologyID(slot14),
			string.format("%s_%s", RedPointConst.HERO_TRUST_UP_LEVEL, slot14),
			slot28
		}

		slot0:addGroup(RedPointConst.HERO_ARCHIVE_ID .. slot14, slot36)

		for slot36 = 1, HeroConst.HERO_HEARTLINK_STORY_MAX_COUNT do
			slot0:addGroup(RedPointConst.HERO_HEARTLINK_ID .. slot32, {
				table.concat({
					RedPointConst.HERO_HEARTLINK_ID,
					slot32,
					"_",
					slot36
				})
			})
		end

		slot0:addGroup(slot15, {
			slot21,
			slot22,
			slot19
		})
	end

	slot0:addGroup(RedPointConst.HERO, slot9)
	slot0:addGroup(RedPointConst.HERO_HEART_STORY_ROOT_FULL, slot8)

	slot10 = {
		RedPointConst.SIGN_DAILY,
		RedPointConst.BIG_MONTH_CARD
	}

	for slot15, slot16 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}) do
		table.insert(slot10, string.format("%s_%s", RedPointConst.SIGN_SEVEN_DAY, slot16))
	end

	slot0:addGroup(RedPointConst.SIGN, slot10)

	slot12 = {}

	for slot17, slot18 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN] or {}) do
		table.insert(slot12, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot18))
	end

	slot0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, slot12)

	slot14 = {}

	for slot19, slot20 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_LUWU] or {}) do
		table.insert(slot14, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot20))
	end

	slot0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, slot14)

	slot16 = {}

	for slot21, slot22 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_WORLD_LINE] or {}) do
		table.insert(slot16, string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, slot22))
	end

	slot0:addGroup(RedPointConst.SEVEN_DAY_SIGN_SKIN, slot16)

	for slot22, slot23 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.NORSE_SURPRISE_GIFT_DRAW] or {}) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, slot23), {
			string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW, slot23),
			string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT_RECEIVE, slot23)
		})
	end

	slot0:addGroup(string.format("%s_%s", RedPointConst.SEVEN_DAY_SIGN_SKIN, ActivityConst.ACTIVITY_3_0_SEVEN_DAY_SKIN_SIGN), {
		string.format("%s_%s", RedPointConst.ACTIVITY_3_0_SURPRISE_GIFT, ActivityConst.ACTIVITY_3_0_SURPRISE_GIFT_DRAW)
	})

	slot20 = {}

	for slot26, slot27 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_MANAGER]) do
		table.insert({}, string.format("%s_%s", RedPointConst.CHIP_MANAGER, slot27))
		table.insert({}, string.format("%s_%s", RedPointConst.CHIP_MANAGER, slot27))
	end

	for slot26, slot27 in ipairs(ChipCfg.get_id_list_by_type_id[ChipConst.TYPE_CHIP]) do
		table.insert(slot20, string.format("%s_%s", RedPointConst.CHIP_CHIP, slot27))
		table.insert(slot22, string.format("%s_%s", RedPointConst.CHIP_CHIP, slot27))
	end

	slot0:addGroup(RedPointConst.CHIP_CHIP, slot20)
	slot0:addGroup(RedPointConst.CHIP_MANAGER_CHIP, slot21)

	slot26 = slot22

	slot0:addGroup(RedPointConst.CHIP_MANAGER, slot26)

	for slot26, slot27 in pairs(ChipCfg.get_id_list_by_spec_char) do
		if slot26 > 0 then
			slot28 = RedPointConst.CHIP_HERO_CHIP .. "_" .. slot26
			slot29 = {}
			slot30 = {}

			for slot34, slot35 in pairs(slot27) do
				if slot29[ChipCfg[slot35].role_type_id] then
					table.insert(slot29[ChipCfg[slot35].role_type_id], RedPointConst.CHIP_HERO_CHIP .. "_" .. slot26 .. "_" .. ChipCfg[slot35].role_type_id .. "_" .. slot35)
				else
					slot29[ChipCfg[slot35].role_type_id] = {
						slot36
					}
				end

				if slot30[ChipCfg[slot35].role_type_id] then
					table.insert(slot30[ChipCfg[slot35].role_type_id], RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot26 .. "_" .. ChipCfg[slot35].role_type_id .. "_" .. slot35)
				else
					slot30[ChipCfg[slot35].role_type_id] = {
						slot37
					}
				end
			end

			for slot35, slot36 in pairs(slot29) do
				slot37 = RedPointConst.CHIP_HERO_CHIP .. "_" .. slot26 .. "_" .. slot35

				slot0:addGroup(slot37, slot29[slot35])
				table.insert({}, slot37)
			end

			for slot35, slot36 in pairs(slot30) do
				slot0:addGroup(RedPointConst.CHIP_HERO_CURRENCY_CHIP .. "_" .. slot26 .. "_" .. slot35, slot30[slot35])
			end

			slot0:addGroup(slot28, slot31)
		end
	end

	slot27 = RedPointConst.FRIEND_FRIEND_REQUESTS

	slot0:addGroup(RedPointConst.FRIEND, {
		slot27
	})

	slot23 = {}

	for slot27, slot28 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.SCENE]) do
		if HomeSceneSettingCfg[slot28] and slot29.limit_display == 1 then
			table.insert(slot23, RedPointConst.SCENE .. "_" .. slot28)
		end
	end

	slot0:addGroup(RedPointConst.SCENE, slot23)
	slot0:addGroup(RedPointConst.FORUM_PLATFORM, {
		RedPointConst.FORUM,
		RedPointConst.FORUM_UNREAD
	})
	slot0:addGroup(RedPointConst.MAIN_HOME_FUNC, {
		RedPointConst.CHIP_MANAGER,
		RedPointConst.SETTING_NEW_FUNCTION,
		RedPointConst.WEAPON_SERVANT_MERGE,
		RedPointConst.SIGN,
		RedPointConst.BULLETIN_UNREAD,
		RedPointConst.EXPLORE_MAIN,
		RedPointConst.COOPERATION_INVIT,
		RedPointConst.SCENE,
		RedPointConst.ACHIEVEMENT,
		RedPointConst.ILLU_USER
	})

	slot28 = RedPointConst.MAIN_HOME_SDK

	slot0:addGroup(RedPointConst.MAIN_HOME_MENU, {
		RedPointConst.MAIN_HOME_FUNC,
		slot28
	})

	for slot28, slot29 in pairs(AchievementCfg.get_id_list_by_type_id) do
		table.insert({}, string.format("%s_%s", RedPointConst.ACHIEVEMENT, slot28))
	end

	slot25 = {}

	for slot29, slot30 in pairs(AchievementStoryCfg.all) do
		table.insert(slot25, string.format("%s_%s", RedPointConst.ACHIEVEMENT_STORY, slot30))
	end

	slot0:addGroup(RedPointConst.ACHIEVEMENT_STORY, slot25)
	table.insertto(slot24, slot25)
	slot0:addGroup(RedPointConst.ACHIEVEMENT, slot24)

	slot26 = {}

	for slot30, slot31 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER_BG]) do
		table.insert(slot26, RedPointConst.STICKER_BG .. "_" .. slot31)
	end

	slot0:addGroup(RedPointConst.STICKER_BG, slot26)

	slot27 = {}

	for slot32, slot33 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.STICKER]) do
		table.insert(slot27, RedPointConst.STICKER_UNLOCK .. "_" .. slot33)
	end

	slot0:addGroup(RedPointConst.STICKER, slot27)
	slot0:addGroup(RedPointConst.STICKER_ROOT, {
		RedPointConst.STICKER,
		RedPointConst.STICKER_BG
	})
	slot0:addGroup(RedPointConst.PASSPORT_TASKS, {
		RedPointConst.PASSPORT_TASK_BONUS_7,
		RedPointConst.PASSPORT_TASK_BONUS_8,
		RedPointConst.PASSPORT_TASK_BONUS_9
	})
	slot0:addGroup(RedPointConst.PASSPORT, {
		RedPointConst.PASSPORT_BONUS,
		RedPointConst.PASSPORT_TASKS,
		RedPointConst.PASSPORT_NEW_SEASON
	})
	slot0:addGroup(RedPointConst.SHOP, {
		RedPointConst.HERO_PIECE_EXCHANGE,
		RedPointConst.NEW_SHOP_SHOP
	})
	slot0:addGroup(RedPointConst.CYCLE_BONUS, {
		RedPointConst.CYCLE_BONUS_FREE,
		RedPointConst.CYCLE_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.ACTIVITY_BONUS, {
		RedPointConst.ACTIVITY_BONUS_FREE,
		RedPointConst.ACTIVITY_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.NEWBIE_BONUS, {
		RedPointConst.NEWBIE_BONUS_FREE,
		RedPointConst.NEWBIE_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.NORMAL_BONUS, {
		RedPointConst.NORMAL_BONUS_FREE,
		RedPointConst.NORMAL_BONUS_UNLOCK
	})
	slot0:addGroup(RedPointConst.RECHARGE_BONUS, {
		RedPointConst.ACTIVITY_BONUS,
		RedPointConst.CYCLE_BONUS,
		RedPointConst.NEWBIE_BONUS,
		RedPointConst.NORMAL_BONUS
	})
	slot0:addGroup(RedPointConst.RECHARGE_DOUBLE_AND_NOOB_MONTHLY_RECHARGE_SIGN, {
		RedPointConst.NOOB_MONTHLY_RECHARGE_SIGN,
		RED_POINT_ID.RECHARGE
	})
	slot0:addGroup(RedPointConst.NOOB_RECHARGE, {
		RedPointConst.NOOB_FIRST_RECHARGE,
		RedPointConst.NOOB_MONTHLY_RECHARGE,
		RedPointConst.NOOB_BP_RECHARGE
	})
	slot0:addGroup(RedPointConst.RECHARGE, {
		RedPointConst.RECHARGE_BONUS,
		RedPointConst.TOTAL_CHARGE_BONUS,
		RedPointConst.RECHARGE_DOUBLE_AND_NOOB_MONTHLY_RECHARGE_SIGN,
		RedPointConst.NOOB_RECHARGE,
		RedPointConst.NEW_SHOP_RECHARGE
	})
	slot0:addGroup(RedPointConst.RECHARGE_ENTER, {
		RedPointConst.RECHARGE,
		RedPointConst.SHOP,
		RedPointConst.RECHARGE_RECOMMEND
	})
	slot0:addGroup(RedPointConst.ILLU_ILLUSTRATION, {
		RedPointConst.ILLU_ILLUSTRATION1,
		RedPointConst.ILLU_ILLUSTRATION2,
		RedPointConst.ILLU_ILLUSTRATION3,
		RedPointConst.ILLU_ILLUSTRATION4
	})
	slot0:addGroup(RedPointConst.ILLU_USER, {
		RedPointConst.ILLU_ILLUSTRATION,
		RedPointConst.ILLU_HERO
	})

	slot29 = {}

	for slot34, slot35 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.TAG]) do
		if ItemCfg[slot35].sub_type ~= ItemConst.ITEM_SUB_TYPE.TAG_LIMIT then
			table.insert(slot29, RedPointConst.TAG .. "_" .. slot35)
		end
	end

	slot0:addGroup(RedPointConst.TAG, slot29)

	slot31 = {}

	for slot36, slot37 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CARD_BG]) do
		if ItemCfg[slot37].sub_type ~= ItemConst.ITEM_SUB_TYPE.CARD_BG_LIMIT then
			table.insert(slot31, RedPointConst.CARD_BG .. "_" .. slot37)
		end
	end

	slot0:addGroup(RedPointConst.CARD_BG, slot31)

	slot33 = {}

	for slot38, slot39 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.CHAT_BUBBLE]) do
		if slot39 ~= GameSetting.profile_chat_bubble_default.value[1] then
			table.insert(slot33, string.format("%s_%s", RedPointConst.CHAT_BUBBLE, slot39))
		end
	end

	slot0:addGroup(RedPointConst.CHAT_BUBBLE, slot33)
	slot0:addGroup(RedPointConst.USER_CUSTOM, {
		RedPointConst.CHAT_BUBBLE
	})
	slot0:addGroup(RedPointConst.ILLU_MAIN, {
		RedPointConst.STICKER_ROOT,
		RedPointConst.BRITHDAY,
		RedPointConst.TAG,
		RedPointConst.USER_CUSTOM
	})
	slot0:addGroup(RedPointConst.ILLU_HERO, {
		RedPointConst.HERO_RACE_COLLECT_REWARD
	})
	slot0:addGroup(RedPointConst.NOOB_FIRST_RECHARGE, {
		RedPointConst.NOOB_FIRST_RECHARGE_1,
		RedPointConst.NOOB_FIRST_RECHARGE_2
	})

	slot39 = RedPointConst.NOOB_BP_RECHARGE

	slot0:addGroup(RedPointConst.NEWBIE_POINT, {
		RedPointConst.NEWBIE_SIGN,
		RedPointConst.NEWBIE_TASK,
		RedPointConst.NEWBIE_UPGRADE,
		RedPointConst.NEWBIE_DAILY_TASK,
		RedPointConst.NOOB_FIRST_RECHARGE,
		RedPointConst.NOOB_MONTHLY_RECHARGE,
		slot39
	})

	slot35 = {}

	for slot39, slot40 in ipairs(NoobVersionCfg.all) do
		if type(NoobVersionCfg[slot40].noob_advance_task_type) == "table" then
			for slot46, slot47 in ipairs(slot42) do
				slot35[#slot35 + 1] = string.format("%s_%d", RedPointConst.NOOB_ADVANCE, slot47)
				slot51 = {}

				for slot55, slot56 in ipairs(NoobAdvanceTaskPhaseListCfg[slot41.noob_advance_task_phase[slot46]].phase_list) do
					slot51[#slot51 + 1] = string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, slot47, slot55)
					slot58 = {}

					for slot62, slot63 in ipairs(slot56[2]) do
						slot58[#slot58 + 1] = string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, slot47, slot55, slot63[1])
					end

					slot0:addGroup(slot57, slot58)
				end

				slot0:addGroup(slot48, slot51)
			end

			slot0:addGroup(RedPointConst.NOOB_ADVANCE, slot35)
		end
	end

	slot0:addGroup(RedPointConst.GUILD, {
		RedPointConst.GUILD_REQUEST,
		RedPointConst.CLUB_TASK,
		RedPointConst.CLUB_WELFARE,
		RedPointConst.GUILD_MANAGER,
		RedPointConst.GUILD_BOSS
	})
	slot0:addGroup(RedPointConst.GUILD_MANAGER, {
		RedPointConst.GUILD_IMPEACH,
		RedPointConst.GUILD_REQUEST
	})
	slot0:addGroup(RedPointConst.DORM_MAIN, {
		RedPointConst.DORM_HERO_MOOD,
		RedPointConst.DORM_TOTAL_EARN,
		RedPointConst.DORM_SPECIAL_EVENT
	})

	slot41 = "MATRIX_TERMINAL_GIFT_SHELTER"
	slot40 = RedPointConst[slot41]

	slot0:addGroup(RedPointConst.MATRIX_TERMINAL_GIFT, {
		RedPointConst.MATRIX_TERMINAL_GIFT_STRUGGLE,
		slot40
	})

	slot36 = {}

	for slot40, slot41 in pairs(WarchessLevelCfg.get_id_list_by_type) do
		if slot40 ~= 0 then
			slot42 = {}

			for slot46, slot47 in ipairs(slot41) do
				table.insert(slot42, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, slot40, slot47))
			end

			slot0:addGroup(string.format("%s_%s", RedPointConst.WAR_CHESS, slot40), slot42)
		end
	end

	slot37 = {}
	slot41 = "OSIRIS_DEMON"

	for slot41, slot42 in ipairs(StageGroupCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW[slot41]]) do
		table.insert(slot37, DemonChallengeData:GetRedPointConst(slot41))
	end

	slot41 = slot37

	slot0:addGroup(RedPointConst.OSIRIS_DEMON, slot41)

	for slot41, slot42 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id) do
		slot43 = {}

		for slot47, slot48 in ipairs(slot42) do
			table.insert(slot43, string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot41, slot48))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.HERO_TRIAL, slot41), slot43)
	end

	slot42 = string.format

	slot0:addGroup(RedPointConst.OSIRIS_ACTIVITY, {
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY),
		string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS),
		RedPointConst.OSIRIS_DEMON,
		RedPointConst.OSIRIS_RACE_TRIAL,
		slot42("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
	})

	slot41 = "SKIN_TRIAL"

	for slot41, slot42 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst[slot41]]) do
		slot44 = {}

		for slot48, slot49 in pairs(ActivityCfg[slot42].sub_activity_list) do
			for slot54, slot55 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[slot49]) do
				table.insert(slot44, string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot55))
			end
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot42), slot44)
	end

	for slot42, slot43 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SLAYER] or {}) do
		if #ActivityCfg[slot43].sub_activity_list > 0 then
			slot45 = {}

			for slot49, slot50 in ipairs(slot44) do
				slot0:addGroup(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot50), {
					string.format("%s_%s", RedPointConst.SLAYER_REGIONS_SELECT, slot50),
					string.format("%s_%s", RedPointConst.SLAYER_REGIONS_REWARD, slot50)
				})

				slot45[#slot45 + 1] = string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot50)
			end

			slot0:addGroup(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot43), slot45)
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.SLAYER, slot43), {
			string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot43),
			string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot43)
		})
	end

	for slot43, slot44 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.PARKOUR] or {}) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR, slot44), {
			string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, slot44)
		})

		slot50 = "%s_%s"
		slot51 = RedPointConst.PARKOUR_ENTRUST

		slot0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_ALL, slot44), {
			string.format("%s_%s", RedPointConst.PARKOUR_REWARD, slot44),
			string.format(slot50, slot51, slot44)
		})

		slot46 = {}

		for slot50, slot51 in ipairs(ActivityCfg[slot44].sub_activity_list) do
			table.insert(slot46, string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, slot51))
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.PARKOUR_REWARD, slot44), slot46)
	end

	slot0:addGroup(RedPointConst.REGRESSION, {
		RedPointConst.REGRESSION_SIGN,
		RedPointConst.REGRESSION_SURVEY,
		RedPointConst.REGRESSION_TASK,
		RedPointConst.REGRESSION_BP,
		RedPointConst.REGRESSION_SUPPLY_FREE
	})
	slot0:addGroup(RedPointConst.REGRESSION_TASK, {
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_DAILY),
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_WEEK),
		string.format("%s_%s", RedPointConst.REGRESSION_TASK, TaskConst.TASK_TYPE.REGRESSION_CHALLENGE)
	})
	slot0:addGroup(RedPointConst.GUILD_BOSS, {
		RedPointConst.GUILD_BOSS_PREPOSE_FIRST_BONUS,
		RedPointConst.GUILD_BOSS_PERSONAL_BONUS,
		RedPointConst.GUILD_BOSS_COMMON_BONUS,
		RedPointConst.GUILD_BOSS_PREPOSE_OPEN,
		RedPointConst.GUILD_BOSS_CHALLENGE_OPEN
	})
	slot0:addGroup(RedPointConst.GUILD_BOSS_BOSS_BTN, {
		RedPointConst.GUILD_BOSS_PERSONAL_BONUS,
		RedPointConst.GUILD_BOSS_COMMON_BONUS,
		RedPointConst.GUILD_BOSS_CHALLENGE_OPEN
	})

	for slot44, slot45 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SINGLE_MATRIX] or {}) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX, slot45), {
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_REWARD, slot45),
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, slot45),
			string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_READ, slot45)
		})
	end

	for slot45, slot46 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_MUSIC] or {}) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.MUSIC, slot46), {
			string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot46),
			string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot46)
		})
	end

	slot42 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ZUMA] or {}
	slot43 = {}

	table.insert(slot43, RedPointConst.ZUMA_REWARD)
	table.insert(slot43, RedPointConst.ZUMA_TALENT)

	slot44 = ZumaData:GetZumaCfgData()

	for slot48, slot49 in pairs(ZumaConst.ZUMA_DIFFICULT or {}) do
		slot51 = {}

		for slot55, slot56 in ipairs(slot44[slot49]) do
			table.insert(slot51, string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot56.activity_id))
		end

		slot52 = string.format("%s_%s", RedPointConst.ZUMA_DIFFICULT, slot49)

		slot0:addGroup(slot52, slot51)
		table.insert(slot43, slot52)
	end

	slot0:addGroup(RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA, slot43)

	for slot49, slot50 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STRATEGY_MATRIX] or {}) do
		if StrategyMatrixCfg[slot50].activity_difficulty == 1 then
			slot0:addGroup(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot50), {
				string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot50),
				string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, slot50)
			})
		elseif slot51.pre_condition_args[1] and slot51.pre_condition_args[1][2][1] then
			slot0:addGroup(string.format("%s_%s", RedPointConst.STRATEGY_MATRIX, slot53), {
				string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_OPEN, slot50),
				string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, slot50)
			})
		else
			print("困难模式的肉鸽，无法取到前置活动id,联系活动肉鸽策划")
		end
	end

	for slot50, slot51 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.GUILD_ACTIVITY] or {}) do
		slot56 = string.format
		slot57 = "%s_%s"

		slot0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY, slot51), {
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_RATE, slot51),
			RedPointConst.GUILD_ACTIVITY_UNREGISTER,
			slot56(slot57, RedPointConst.GUILD_ACTIVITY_UNGET_COIN, slot51)
		})

		slot52 = {}

		for slot56, slot57 in pairs(TalentTreeCfg.get_id_list_by_activity_id_and_race[slot51]) do
			slot52[#slot52 + 1] = string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot51, slot56)
			slot59 = {}

			for slot63, slot64 in pairs(slot57) do
				slot59[#slot59 + 1] = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot51, slot56, slot64)
			end

			slot0:addGroup(slot58, slot59)
		end

		slot0:addGroup(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, slot51), slot52)
	end

	for slot51, slot52 in pairs(GuildActivitySPTools:GetActivityState()) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP, slot51), {
			RedPointConst.GUILD_ACTIVITY_SP_UNREGISTER
		})

		slot53 = slot52.start

		slot0:addGroup(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP, slot51), {
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_BONUS, slot53),
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_UNGET_COIN, slot53),
			string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_HERO_FIGHT, slot53)
		})

		slot54 = {}

		if TalentTreeCfg.get_id_list_by_activity_id_and_race[slot53] then
			for slot58, slot59 in pairs(TalentTreeCfg.get_id_list_by_activity_id_and_race[slot53]) do
				slot54[#slot54 + 1] = string.format("%s_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, slot53, slot58)
				slot61 = {}

				for slot65, slot66 in pairs(slot59) do
					slot61[#slot61 + 1] = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, slot53, slot58, slot66)
				end

				slot0:addGroup(slot60, slot61)
			end

			slot0:addGroup(string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, slot53), slot54)
		end
	end

	slot49 = {}

	for slot53, slot54 in ipairs(ActivityCfg[ActivityConst.FACTORY_MARDUK].sub_activity_list) do
		table.insert(slot49, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, slot54))
	end

	slot0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.FACTORY_MARDUK), slot49)

	slot55 = "%s_%d"
	slot56 = RedPointConst.MARDUK_SPECIAL_REWARD

	slot0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL, ActivityConst.FACTORY_MARDUK), {
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.FACTORY_MARDUK),
		string.format(slot55, slot56, ActivityConst.FACTORY_MARDUK)
	})

	slot51 = {}

	for slot55, slot56 in ipairs(ActivityCfg[ActivityConst.ACTIVITY_2_2_SPECIAL].sub_activity_list) do
		table.insert(slot51, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, slot56))
	end

	slot0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.ACTIVITY_2_2_SPECIAL), slot51)
	slot0:addGroup(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL, ActivityConst.ACTIVITY_2_2_SPECIAL), {
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, ActivityConst.ACTIVITY_2_2_SPECIAL),
		string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL)
	})

	for slot56, slot57 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.FIRE_WORK_MAIN] or {}) do
		slot59 = {}

		for slot63, slot64 in ipairs(ActivityCfg[slot57].sub_activity_list) do
			if ActivityCfg[slot64].activity_template == ActivityTemplateConst.FIRE_WORK then
				slot66 = string.format("%s_%s", RedPointConst.FIRE_WORK, slot64)

				slot0:addGroup(slot66, {
					string.format("%s_%s", RedPointConst.FIRE_WORK_OPEN, slot64),
					string.format("%s_%s", RedPointConst.FIRE_WORK_REWARD, slot64)
				})
				table.insert(slot59, slot66)
			end
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.FIRE_WORK_MAIN, slot57), slot59)
	end

	slot0:addGroup(RedPointConst.CANTEEN_DISPATCH, {
		RedPointConst.CANTEEN_DISPATCH_FINISHED,
		RedPointConst.CANTEEN_DISPATCH_NONE,
		RedPointConst.CANTEEN_UNLOCK_ENTRUST
	})
	slot0:addGroup(RedPointConst.CANTEEN, {
		RedPointConst.CANTEEN_DISPATCH,
		RedPointConst.CANTEEN_BUSINESS_STOPPED,
		RedPointConst.CANTEEN_JOB_AVAILABLE,
		RedPointConst.CANTEEN_UPGRADE_AVAILABLE,
		RedPointConst.CANTEEN_UNLOCK_FOOD,
		RedPointConst.CANTEEN_UNLOCK_ENTRUST
	})

	slot58 = "CANTEEN"

	slot0:addGroup(ActivityTools.GetRedPointKey(ActivityConst.SPRING_CANTEEN) .. ActivityConst.SPRING_CANTEEN, {
		RedPointConst[slot58]
	})

	for slot58 = 1, #GameSetting.dorm_canteen_task_unlock.value do
	end

	slot0:addGroup(RedPointConst.CANTEEN_UNLOCK_ENTRUST, {
		[slot58] = string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, tostring(slot58))
	})

	slot56 = 1

	for slot60, slot61 in pairs(DormEnum.FurnitureTypeNum) do
		slot56 = slot56 + 1
	end

	slot60 = {
		[slot56] = string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(slot61))
	}

	slot0:addGroup(RedPointConst.CANTEEN_UNLOCK_FOOD, slot60)

	for slot60, slot61 in pairs(DormEnum.FurnitureTypeNum) do
		slot62 = {}

		for slot66, slot67 in ipairs(BackHomeCanteenFoodCfg.all) do
			if BackHomeCanteenFoodCfg[slot67].cook_type == slot61 then
				table.insert(slot62, string.format("%s_%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, tostring(slot61), slot67))
			end
		end

		slot0:addGroup(string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_FOOD, slot61), slot62)
	end

	slot57 = {}

	for slot61, slot62 in pairs(DormEnum.FurnitureMainType) do
		table.insert(slot57, string.format("%s_%s", RedPointConst.CANTEEN_UPGRADE_AVAILABLE, tostring(slot62)))
	end

	slot0:addGroup(RedPointConst.CANTEEN_UPGRADE_AVAILABLE, slot57)

	slot63 = "DORM_PLACEMENT"
	slot62 = RedPointConst[slot63]

	slot0:addGroup(RedPointConst.DORM, {
		slot62
	})

	slot58 = {}

	for slot62, slot63 in ipairs(BackHomeCfg.all) do
		if BackHomeCfg[slot63].type == 3 then
			table.insert(slot58, RedPointConst.DORM_PLACEMENT_ROOM .. slot63)
		end
	end

	slot0:addGroup(RedPointConst.DORM_PLACEMENT, slot58)

	slot59 = {}

	for slot63 = DormConst.DORM_FUR_TYPE_START, DormConst.DORM_FUR_TYPE_END do
		table.insert(slot59, string.format("%s_%s", RedPointConst.DORM_FURNITURE, tostring(slot63)))
	end

	table.insert(slot59, RedPointConst.DORM_SUIT)
	slot0:addGroup(RedPointConst.DORM_FURNITURE, slot59)

	slot60 = {}
	slot61 = {}

	for slot66, slot67 in ipairs(DormSuitData:GetSuitIDListByType(DormSuitTools.DORM_SUIT_TYPE.FULL_SET)) do
		if BackHomeSuitCfg[slot67].scene_id[1] == DormConst.BACKHOME_TYPE.PublicDorm then
			table.insert(slot61, string.format("%s_%s", RedPointConst.DORM_FULL_PUBLIC_SUIT, tostring(slot67)))
		elseif slot68 == DormConst.BACKHOME_TYPE.PrivateDorm then
			table.insert(slot60, string.format("%s_%s", RedPointConst.DORM_FULL_PRIVATE_SUIT, tostring(slot67)))
		end
	end

	slot0:addGroup(RedPointConst.DORM_FULL_PUBLIC_SUIT, slot61)
	slot0:addGroup(RedPointConst.DORM_FULL_PRIVATE_SUIT, slot60)

	slot63 = {}

	for slot68, slot69 in ipairs(DormSuitData:GetSuitIDListByType(DormSuitTools.DORM_SUIT_TYPE.PART_SET)) do
		table.insert(slot63, string.format("%s_%s", RedPointConst.DORM_PART_SUIT, tostring(slot69)))
	end

	slot0:addGroup(RedPointConst.DORM_PART_SUIT, slot63)

	slot65 = {}

	for slot70, slot71 in ipairs(DormTools:GetAllDormShopIDList()) do
		slot73 = {}

		if #DormSuitTools:GetFurSuitGoodListByShopID(slot71) > 0 then
			for slot77, slot78 in ipairs(slot72) do
				table.insert(slot73, DormRedPointTools.FurnitureItemRedPoint(slot71, slot78))
			end

			slot74 = ShopTools.GetShopRedPointKey(slot71)

			slot0:addGroup(slot74, slot73)
			table.insert(slot65, slot74)
		end
	end

	slot0:addGroup(RedPointConst.DORM_SUIT_SHOP, slot65)
	slot0:addGroup(RedPointConst.BACKHOME, {
		RedPointConst.DORM,
		RedPointConst.CANTEEN
	})

	slot72 = ServerRedPointPrefix
	slot73 = ServerRedPoint.DISORDER_TRAP_NEW_RED

	slot0:addGroup(RedPointConst.ABYSS, {
		RedPointConst.ABYSS_REWARD,
		RedPointConst.ABYSS_CHALLENGE,
		string.format(slot72, slot73, "ROOT")
	})

	slot68 = {}

	for slot72, slot73 in pairs(MailSpecialLetterCfg.get_id_list_by_letter_belongs) do
		table.insert(slot68, RedPointConst.LETTER_SENDER_ID .. slot72)

		slot74 = {}

		for slot78, slot79 in pairs(slot73) do
			table.insert(slot74, RedPointConst.LETTER_ID .. slot79)
		end

		slot0:addGroup(RedPointConst.LETTER_SENDER_ID .. slot72, slot74)
	end

	slot0:addGroup(RedPointConst.LETTER_UNREAD, slot68)
	slot0:addGroup(RedPointConst.MAIL_UNREAD, {
		RedPointConst.LETTER_UNREAD
	})
	slot0:addGroup(RedPointConst.POLYHEDRON, {
		RedPointConst.POLYHEDRON_BEACON_UNLOCK,
		RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD,
		RedPointConst.POLYHEDRON_HERO_UNLOCK,
		RedPointConst.POLYHEDRON_TASK,
		RedPointConst.POLYHEDRON_TERMINAL_GIFT,
		RedPointConst.POLYHEDRON_NEW_SECTION
	})

	slot70 = {}
	slot71 = {}

	for slot75, slot76 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.POLYHEDRON_ACTIVITY]) do
		slot78 = ActivityCfg[slot76].achievement_task_activity_list or {}

		for slot82, slot83 in ipairs(ActivityCfg[slot76].season_task_activity_list or {}) do
			slot70[#slot70 + 1] = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot83)
		end

		for slot82, slot83 in ipairs(slot78) do
			slot71[#slot71 + 1] = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot83)
		end
	end

	slot0:addGroup(RedPointConst.POLYHEDRON_TASK_SEASON, slot70)
	slot0:addGroup(RedPointConst.POLYHEDRON_TASK_ACHIEVEMENT, slot71)
	slot0:addGroup(RedPointConst.POLYHEDRON_TASK, {
		RedPointConst.POLYHEDRON_TASK_SEASON,
		RedPointConst.POLYHEDRON_TASK_ACHIEVEMENT
	})

	slot76 = RedPointConst.RECALL_REWARD

	slot0:addGroup(RedPointConst.RECALL, {
		RedPointConst.RECALL_SIGN,
		RedPointConst.RECALL_TASK,
		slot76
	})

	slot72 = {
		[slot76] = RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. ExploreMeowCfg.all[slot76]
	}

	for slot76 = 1, #ExploreMeowCfg.all do
	end

	for slot77 = 1, #ExploreAreaCfg.all do
	end

	slot0:addGroup(RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT, slot72)
	slot0:addGroup(RedPointConst.EXPLORE_FINISH, {
		[slot77] = RedPointConst.EXPLORE_FINISH .. ExploreAreaCfg.all[slot77]
	})
	slot0:addGroup(RedPointConst.EXPLORE_MAIN, {
		RedPointConst.EXPLORE_REWARD,
		RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT,
		RedPointConst.EXPLORE_FINISH,
		RedPointConst.EXPLORE_QUEUE
	})
	slot0:addGroup(RedPointConst.INVITE_MAIN, {
		RedPointConst.INVITE_DRAW,
		RedPointConst.INVITE_PLOT
	})
	slot0:addGroup(string.format("%s_%d", RedPointConst.ACTIVITY_2_1_LINKGAME, ActivityConst.ACTIVITY_2_1_LINK_GANE), {
		RedPointConst.ACTIVITY_2_1_LINKGAME_LEVEL_REWARD,
		RedPointConst.ACTIVITY_2_1_LINKGAME_UNCOMPLETE_LEVEL,
		RedPointConst.ACTIVITY_TASK .. "_" .. ActivityConst.ACTIVITY_2_1_LINK_GANE_TASK
	})
	slot0:addGroup(RedPointConst.SETTING_SCREEN, {
		RedPointConst.HIGH_FPS_DEVICE_SURRPORT
	})

	slot79 = "SETTING_REMIND"
	slot78 = RedPointConst[slot79]

	slot0:addGroup(RedPointConst.SETTING_NEW_FUNCTION, {
		RedPointConst.SETTING_SCREEN,
		slot78
	})

	slot74 = {}

	for slot78, slot79 in ipairs(RechargeRecommendCfg.all) do
		table.insert(slot74, RedPointConst.RECHARGE_RECOMMEND .. slot79)
	end

	slot0:addGroup(RedPointConst.RECHARGE_RECOMMEND, slot74)

	slot78 = "STRONGHOLD"

	for slot78, slot79 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst[slot78]]) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.STRONGHOLD, slot79), {
			string.format("%s_%s", RedPointConst.STRONGHOLD_REWARD, slot79),
			string.format("%s_%s", RedPointConst.STRONGHOLD_INCREASE, slot79),
			string.format("%s_%s", RedPointConst.STRONGHOLD_TASK, slot79)
		})
	end

	slot80 = "SOLO_HEART_DEMON_REWARD"

	slot0:addGroup(RedPointConst.SOLO_HEART_DEMON, {
		RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW,
		RedPointConst[slot80]
	})

	slot75 = {}
	slot79 = "ACTIVITY_SKIN_DRAW"

	for slot79, slot80 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst[slot79]]) do
		table.insert(slot75, RedPointConst.ACTIVITY_DRAW .. "_" .. slot80)
	end

	slot0:addGroup(RedPointConst.ACTIVITY_DRAW, slot75)

	for slot80, slot81 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA] or {}) do
		slot0:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA, slot81), {
			string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_TASK, slot81),
			string.format("%s_%s", RedPointConst.ACTIVITY_ATTRIBUTE_ARENA_ENTER, slot81)
		})
	end

	slot0:addGroup(RedPointConst.CORE_VERIFICATION, {
		RedPointConst.CORE_VERIFICATION_REWARD,
		RedPointConst.CORE_VERIFICATION_CHALLENGE
	})
	slot0:addGroup(RedPointConst.CORE_VERIFICATION_REWARD, {
		RedPointConst.CORE_VERIFICATION_REWARD1,
		RedPointConst.CORE_VERIFICATION_REWARD2,
		RedPointConst.CORE_VERIFICATION_REWARD3,
		RedPointConst.CORE_VERIFICATION_REWARD4
	})
	slot0:addGroup(RedPointConst.SP_HERO_CHALLENGE_3_1, {
		RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST,
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroChipActivityID),
		string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].taskActivityID)
	})
end

function slot0.InitData(slot0)
	slot0._redPointHelper:InitData()
end

function slot0.Dispose(slot0)
	slot0._redPointHelper:Dispose()
end

function slot0.setTip(slot0, slot1, slot2, slot3)
	return slot0._redPointHelper:setTip(slot1, slot2, slot3)
end

function slot0.getTipValue(slot0, slot1)
	return slot0._redPointHelper:getTipValue(slot1)
end

function slot0.getchildKeys(slot0, slot1)
	return slot0._redPointHelper:getchildKeys(slot1)
end

function slot0.getTipBoolean(slot0, slot1)
	return slot0._redPointHelper:getTipBoolean(slot1)
end

function slot0.addGroup(slot0, slot1, slot2, slot3)
	slot0._redPointHelper:addGroup(slot1, slot2, slot3)
end

function slot0.appendGroup(slot0, slot1, slot2, slot3)
	slot0._redPointHelper:appendToGroup(slot1, slot2, slot3)
end

function slot0.delGroup(slot0, slot1, slot2)
	slot0._redPointHelper:delGroup(slot1, slot2)
end

function slot0.updateKey(slot0, slot1)
	slot0._redPointHelper:updateKey(slot1)
end

function slot0.bindUIandKey(slot0, slot1, slot2, slot3)
	slot0._redPointHelper:bindUIandKey(slot1, slot2, slot3)
end

function slot0.unbindUIandKey(slot0, slot1, slot2)
	slot0._redPointHelper:unbindUIandKey(slot1, slot2)
end

function slot0.setRedPoint(slot0, slot1, slot2, slot3)
	if slot2 then
		slot0._redPointHelper:ChangeRedStyle(slot1, slot3 or RedPointStyle.NORMAL, nil, , slot2)
	else
		slot0._redPointHelper:ChangeRedStyle(slot1, RedPointStyle.None, nil, , slot2)
	end
end

function slot0.ForceHideRedPoint(slot0, slot1)
	if slot1:Find("notice_img") then
		SetActive(slot2.gameObject, false)
	end
end

function slot0.SetRedPointIndependent(slot0, slot1, slot2, slot3, slot4)
	if slot2 then
		slot0._redPointHelper:ChangeRedStyle({
			display = slot1
		}, slot4 or RedPointStyle.NORMAL, slot3, nil, slot2)
	else
		slot0._redPointHelper:ChangeRedStyle({
			display = slot1
		}, RedPointStyle.None, slot3, nil, slot2)
	end
end

function slot0.ShowRedGraph(slot0, slot1)
	return manager.redPoint._redPointHelper:GetRedGraphWithKey(slot0)
end

function slot0.PrintAllRedNode()
	return {
		data = "HHH"
	}
end

function slot0.PrintAllKey()
	for slot4, slot5 in ipairs(manager.redPoint._redPointHelper:GetAllKey()) do
		slot0 = slot0 .. ","
	end

	return {
		data = table.concat(slot0)
	}
end

function slot0.PrintAllNilKey()
	for slot4, slot5 in ipairs(manager.redPoint._redPointHelper:GetAllKey()) do
		if string.find(slot5, "nil") then
			Debug.LogError(slot5)
		end
	end
end

return slot0
