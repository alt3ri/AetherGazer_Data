PolyhedronConst = {
	HERO_ATTRIBUTE_ICON_PATH = "TextureConfig/PolyhedronItem/Attribute/",
	ARTIFACT_ICON_PATH = "TextureConfig/PolyhedronItem/Artifact/",
	TERMINAL_ICON_PATH = "TextureConfig/PolyhedronItem/Terminal/",
	EFFECT_ATTRIBUTE_ICON_PATH = "TextureConfig/PolyhedronItem/Effect/",
	BEACON_ICON_PATH = "TextureConfig/PolyhedronItem/Beacon/",
	SAVE_POINT_TYPE = {
		OPTION = 3,
		REWARD = 2,
		UNDEFINED = 0,
		BATTLE = 1
	},
	STATE_TYPE = {
		SETTLEMENT = 3,
		STARTED = 2,
		NOTSTARTED = 1
	},
	ITEM_TYPE = {
		BLOOD = 7,
		ARTIFACT_UP_LEVEL = 5,
		BUFF = 4,
		COIN = 1,
		HERO = 3,
		ARTIFACT = 6
	},
	REWARD_TYEP = {
		TEAMMATE = 2,
		ARTIFACT_1 = 3001,
		ARTIFACT_2 = 3002,
		ARTIFACT_4 = 3004,
		CURRENCY = 1,
		ARTIFACT_3 = 3003,
		ARTIFACT_SPEC = 3007,
		ARTIFACT_6 = 3006,
		EMPTY = 6,
		ARTIFACT_5 = 3005,
		SHOP = 5,
		ARTIFACT_STRENGTH = 7,
		HERO_ATTRIBUTE = 4,
		ARTIFACT = 3
	},
	ENLIST_TYPE = {
		GIVE_UP = 0,
		PAY = 2,
		FREE = 3,
		BATTLE = 1
	},
	RANK_TYPE = {
		ALL = 1,
		GUILD = 2
	},
	RANK_SUB_TYPE = {
		SCORE = 1,
		HERO = 2
	},
	EFFECT_ACTION = {
		AFFIX = 4,
		ATTRIBUTE_MULTIPLE_ARTIFACT_NUM = 5,
		ATTRIBUTE = 2
	},
	EFFECT_MOMENT = {
		FOREVER = 2
	},
	AFFIX_TYPE = {
		MATRIX_BEACON = 806
	},
	REVIVE_COIN_EFFECT = {
		BEACON = {
			[5.0] = true
		},
		TERMINAL = {
			[1101.0] = true
		}
	},
	POLYHEDRON_SETTING_ID = {
		SHOP_RECOVER = 15
	},
	SPECIAL_ATTR_DESC = {}
}

for slot4, slot5 in ipairs(GameSetting.polyhedron_difficulty_affixes.value) do
	PolyhedronConst.SPECIAL_ATTR_DESC[slot5[1]] = slot5
end

PolyhedronTools = {
	PolyhedronPolicyExpToLevel = function ()
		if (ActivityCfg[PolyhedronData:GetActivityID()] and ActivityCfg[slot0].policy_activity_id) == nil then
			return 0, 0
		end

		slot2 = PolyhedronPolicyCfg.get_id_list_by_activity_id[slot1]
		slot3 = #slot2
		slot5 = 0
		slot6 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_SHIFTING_EXP)

		for slot10, slot11 in ipairs(slot2) do
			if slot4 < PolyhedronPolicyCfg[slot11].exp then
				return slot5, slot6
			else
				slot5 = slot10

				if slot10 < slot3 then
					slot6 = slot4 - PolyhedronPolicyCfg[slot11].exp
				end
			end
		end

		return slot5, slot6
	end,
	PolyhedronTerminalExpToLevel = function (slot0)
		slot2 = 1
		slot3 = #PolyhedronTerminalLevelCfg.all
		slot4 = -1

		while slot2 <= slot3 do
			if slot0 < PolyhedronTerminalLevelCfg[slot1[slot2 + math.floor((slot3 - slot2) / 2)]].exp then
				slot3 = slot5 - 1
			else
				slot4 = slot5
				slot2 = slot5 + 1
			end
		end

		return slot1[slot4], slot0 - PolyhedronTerminalLevelCfg[slot1[slot4]].exp
	end,
	GetRaceEffect = function (slot0)
		slot1 = {}
		slot2 = 0
		slot3 = false
		slot4 = 3

		for slot10, slot11 in ipairs(PolyhedronData:GetPolyhedronInfo():GetTotalAffix()) do
			if slot11[1] == PolyhedronConst.AFFIX_TYPE.MATRIX_BEACON then
				slot4 = 2
			end
		end

		for slot10, slot11 in pairs(slot0) do
			if slot11 ~= 0 then
				slot1[slot12] = (slot1[HeroCfg[slot11].race] or 0) + 1

				if slot1[slot12] == 2 then
					slot2 = slot12
				end

				if slot4 <= slot1[slot12] then
					slot3 = true
				end
			end
		end

		return slot2, slot3, slot1[slot2] or 1
	end,
	GetBeaconIsUnlockCondition = function (slot0)
		if PolyhedronBeaconCfg[slot0] and slot1.condition ~= 0 then
			return IsConditionAchieved(slot1.condition)
		end

		return true
	end,
	CalPolyhedronDifficultyAttr = function (slot0, slot1)
		for slot5 = 1, slot1 do
			for slot10, slot11 in ipairs(PolyhedronDifficultyCfg[slot5].params) do
				if slot11[1] == 2 then
					slot13 = slot11[2]
					slot0[slot13] = HeroTools.AttributeAdd(slot13, slot0[slot13], slot11[3])
				end
			end
		end

		return slot0
	end,
	GetPolyhedronDifficultyAffixDir = function (slot0)
		slot1 = {}

		for slot5 = 1, slot0 do
			for slot10, slot11 in ipairs(PolyhedronDifficultyCfg[slot5].params) do
				if slot11[1] == 1 then
					slot13 = slot11[2]
					slot1[slot13] = {
						slot13,
						slot11[3],
						slot11[4]
					}
				end
			end
		end

		return slot1
	end,
	GetPolyhedronTerminalClassifyDes = function (slot0)
		return GetTips("POLYHEDRON_TERMINAL_CLASSIFY_" .. slot0)
	end,
	GetPolyhedronArtifactSubTypeDes = function (slot0)
		return GetTips("POLYHEDRON_ARTIFACT_SUB_TYPE_" .. slot0)
	end,
	GetGateCfg = function (slot0, slot1)
		for slot6, slot7 in ipairs(PolyhedronGateCfg.all) do
			if (PolyhedronGateCfg[slot7].event_type == 0 or PolyhedronEventCfg[slot0].event_type == slot8.event_type) and (slot8.reward_type == 0 or slot1 == slot8.reward_type) then
				return slot8
			end
		end

		print("polyhedron error cant find gate index by" .. slot0 .. ":" .. slot1)

		return {
			reward_type = 0,
			gate_index = 999,
			event_type = 0,
			gate_des = ""
		}
	end,
	getAffixUpLvDes = function (slot0, slot1, slot2)
		if AffixTypeCfg[slot0] == nil then
			-- Nothing
		end

		if not DescriptionCfg[slot3.description[1]] then
			return ""
		end

		function slot6(slot0, slot1)
			if slot1 then
				return math.floor(slot0 * 10^slot1 + 0.5) / 10^slot1
			else
				return math.floor(slot0 + 0.5)
			end
		end

		slot7 = GetI18NText(slot5.description)

		if slot5.type == 1 then
			if slot5.maxLv < slot2 or slot2 < 1 then
				return ""
			end

			if slot5.maxLv < slot1 or slot1 < 1 then
				return ""
			end

			if #slot5.param >= 1 then
				slot9 = {
					"0"
				}

				for slot13, slot14 in ipairs(slot8) do
					slot17 = slot14[4]

					if (slot6(slot14[1] + slot14[2] * (slot1 - 1), 1) % 1 == 0 and string.format("%.0f", slot18) .. slot17 or string.format("%.1f", slot18) .. slot17) ~= (slot6(slot15 + slot16 * (slot2 - 1), 1) % 1 == 0 and string.format("%.0f", slot19) .. slot17 or string.format("%.1f", slot19) .. slot17) then
						table.insert(slot9, slot18 .. "->" .. slot19)
					else
						table.insert(slot9, slot18)
					end
				end

				return LuaExchangeHelper.GetDescription(slot7, slot9)
			else
				return slot7
			end
		else
			if not slot5.param[slot1] or not slot5.param[slot2] then
				return ""
			end

			slot10 = {}

			for slot15 = 1, #slot8 do
				slot16 = nil

				table.insert(slot10, slot8[slot15] ~= slot9[slot15] and slot8[slot15] .. "->" .. slot9[slot15] or slot8[slot15])
			end

			if #slot10 > 1 then
				return LuaExchangeHelper.GetDescription(slot7, slot10)
			else
				return slot7
			end
		end
	end,
	ArtifactSubTypeSorter = function (slot0, slot1)
		if slot0 == 3007 or slot1 == slot2 then
			return slot0 == slot2
		end

		return slot1 < slot0
	end
}
PolyhedronTemplate = class("PolyhedronProcessTemplate")

function PolyhedronTemplate.Ctor(slot0, slot1)
	slot0:UpdateGame(slot1)
end

function PolyhedronTemplate.UpdateGame(slot0, slot1)
	slot0.state = slot1.state
	slot2 = slot1.start_info
	slot0.leader = PolyhedronSnapShotTemplate.New(slot2.leader)
	slot0.beacon_id_list = {}

	for slot6, slot7 in ipairs(slot2.beacon_id_list) do
		table.insert(slot0.beacon_id_list, slot7)
	end

	slot0.difficulty = slot2.difficulty
	slot0.terminal_id_list = {}

	for slot6, slot7 in ipairs(slot2.terminal_id_list) do
		table.insert(slot0.terminal_id_list, slot7)
	end

	slot0:UpdatePocess(slot1.progress)
end

function PolyhedronTemplate.UpdatePocess(slot0, slot1)
	slot0.tier_id = slot1.tier_id
	slot0.event = PolyhedronEventTemplate.New(slot1.event)
	slot0.stage = PolyhedronStageTemplate.New(slot1.stage)
	slot0.hero_list = {}

	for slot5, slot6 in ipairs(slot1.hero_list) do
		slot0.hero_list[slot6.hero_id] = PolyhedronHeroTemplate.New(slot6)
	end

	slot0.fight_hero_id_list = {}

	for slot5, slot6 in ipairs(slot1.fight_hero_id_list) do
		table.insert(slot0.fight_hero_id_list, slot6)
	end

	slot0.artifact_list = {}

	for slot5, slot6 in ipairs(slot1.artifact_list) do
		table.insert(slot0.artifact_list, {
			id = slot6.id,
			level = slot6.level
		})
	end

	slot0.effect_list = {}

	for slot5, slot6 in ipairs(slot1.effect_list) do
		table.insert(slot0.effect_list, {
			id = slot6.id
		})
	end

	slot0.attribute_list = {}

	for slot5, slot6 in ipairs(slot1.attribute_list) do
		slot0.attribute_list[slot6.id] = slot6.value
	end

	slot0.stackable_item_list = {}

	for slot5, slot6 in ipairs(slot1.stackable_item_list) do
		slot0.stackable_item_list[slot6.id] = slot6.num
	end
end

function PolyhedronTemplate.GetState(slot0)
	return slot0.state
end

function PolyhedronTemplate.GetTierId(slot0)
	return slot0.tier_id
end

function PolyhedronTemplate.GetDifficulty(slot0)
	return slot0.difficulty
end

function PolyhedronTemplate.GetArtifact(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.artifact_list) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function PolyhedronTemplate.GetBeaconList(slot0)
	return slot0.beacon_id_list
end

function PolyhedronTemplate.GetArtifactList(slot0)
	return slot0.artifact_list
end

function PolyhedronTemplate.GetTerminalIdList(slot0)
	return slot0.terminal_id_list
end

function PolyhedronTemplate.GetSavePoint(slot0)
	return slot0.stage.save_point
end

function PolyhedronTemplate.GetStageId(slot0)
	return slot0.stage.stage_id
end

function PolyhedronTemplate.GetGateData(slot0, slot1)
	return slot0.stage.gate_list[slot1]
end

function PolyhedronTemplate.GetRewardList(slot0)
	return slot0.stage:GetRewardList()
end

function PolyhedronTemplate.GetTipsList(slot0)
	return slot0.stage:GetTipsList()
end

function PolyhedronTemplate.GetEnlistHeroList(slot0)
	slot3 = {}

	for slot7 = 1, math.floor(#slot0.stage.params / 2) do
		table.insert(slot3, {
			heroId = slot1[slot7 * 2 - 1],
			enlist_type = slot1[slot7 * 2]
		})
	end

	return slot3
end

function PolyhedronTemplate.GetShopItemList(slot0)
	return slot0.stage.shop_item_list
end

function PolyhedronTemplate.GetShopRefreshTimes(slot0)
	return slot0.stage.refresh_times
end

function PolyhedronTemplate.GetShopRecoverTimes(slot0)
	return slot0.stage.recover_times
end

function PolyhedronTemplate.GetRewardType(slot0)
	return slot0.event.reward_type
end

function PolyhedronTemplate.GetPolyhedronLeader(slot0)
	return slot0.leader
end

function PolyhedronTemplate.GetLeaderHeroId(slot0)
	return slot0.leader:GetHeroId()
end

function PolyhedronTemplate.GetFightHeroList(slot0)
	return slot0.fight_hero_id_list
end

function PolyhedronTemplate.GetHeroList(slot0)
	return table.keys(slot0.hero_list)
end

function PolyhedronTemplate.GetHeroPolyData(slot0, slot1)
	return slot0.hero_list[slot1]
end

function PolyhedronTemplate.GetCoinCount(slot0)
	return slot0.stackable_item_list[1] or 0
end

function PolyhedronTemplate.GetAttribulteValue(slot0, slot1)
	return slot0.attribute_list[PolyhedronAttributeIdCfg[slot1].id]
end

function PolyhedronTemplate.GetReviveCount(slot0)
	for slot5, slot6 in ipairs(slot0.beacon_id_list) do
		if PolyhedronConst.REVIVE_COIN_EFFECT.BEACON[slot6] == true then
			slot1 = 3 + 1
		end
	end

	for slot5, slot6 in ipairs(slot0.terminal_id_list) do
		if PolyhedronConst.REVIVE_COIN_EFFECT.TERMINAL[slot6] == true then
			slot1 = slot1 + 1
		end
	end

	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_LEADER_REBORN_TIMES") or 0, slot1
end

function PolyhedronTemplate.GetReviveHp(slot0)
	if slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_REBORN_HEALTH_PERCENT") then
		return slot1 / 10
	else
		return 100
	end
end

function PolyhedronTemplate.ReviveMaxCount(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_LEADER_REBORN_MAX_TIMES") or 0
end

function PolyhedronTemplate.GetRollGateCount(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_RE_ROLL_GATE_TIMES") or 0
end

function PolyhedronTemplate.GetRollRewardCount(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_RE_ROLL_ARTIFACT_REWARD_TIMES") or 0
end

function PolyhedronTemplate.GetShopFressRefreshTimes(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_FREE_REFRESH_TIME") or 0
end

function PolyhedronTemplate.GetShopMaxRefreshTimes(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_REFRESH_TIME") or 0
end

function PolyhedronTemplate.GetShopRecoverMaxTimes(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_SHOP_RECOVER_TIME") or 0
end

function PolyhedronTemplate.GetRewardGiveUpCoinAdd(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_GIVE_UP_ADD_COIN_NUM") or 0
end

function PolyhedronTemplate.GetTeamateRebornMaxColdDown(slot0)
	return slot0:GetAttribulteValue("GAME_POLYHEDRON_ATTRIBUTE_TEAMMATE_REBORN_MAX_COLD_DOWN") or 0
end

function PolyhedronTemplate.GetPolyhedronCoinId(slot0)
	return 26
end

function PolyhedronTemplate.GetShopRefreshCost(slot0, slot1)
	for slot6, slot7 in ipairs(PolyhedronSettingCfg[14].value) do
		if slot7[1] == slot1 then
			return slot7[2]
		end
	end

	return slot2.value[#slot2.value][2]
end

function PolyhedronTemplate.GetRewardGiveUpCoin(slot0)
	return PolyhedronSettingCfg[21].value[1] + slot0:GetRewardGiveUpCoinAdd()
end

function PolyhedronTemplate.GetShopOriginalPrice(slot0, slot1)
	for slot6, slot7 in ipairs(PolyhedronSettingCfg[13].value) do
		if slot7[1] == slot1 then
			return slot7[2]
		end
	end

	return 0
end

function PolyhedronTemplate.GetTotalAffix(slot0)
	for slot6, slot7 in pairs(PolyhedronTools.GetPolyhedronDifficultyAffixDir(slot0.difficulty)) do
		table.insert({}, slot7)
	end

	for slot6, slot7 in ipairs(slot0.effect_list) do
		if PolyhedronConst.EFFECT_ACTION.AFFIX == PolyhedronEffectCfg[slot7.id].action then
			for slot12, slot13 in ipairs(slot8.params) do
				table.insert(slot1, slot13)
			end
		end
	end

	for slot7, slot8 in ipairs(slot0.artifact_list) do
		if slot8.id >= 70701 and slot9 <= 70750 then
			slot10 = slot8.level * slot0:GetCoinCount()
		end

		slot11 = PolyhedronArtifactCfg[slot9]

		table.insert(slot1, {
			slot11.affix_id,
			slot10,
			slot11.affix_target
		})
	end

	return slot1
end

function PolyhedronTemplate.CalPolyhedronAttribute(slot0, slot1)
	slot2 = {}
	slot3 = #slot0.artifact_list

	for slot7, slot8 in ipairs(slot0.effect_list) do
		if slot8.id == 2014 then
			CustomLog.Log(debug.traceback(string.format("2014")))
		end

		if PolyhedronConst.EFFECT_MOMENT.FOREVER == PolyhedronEffectCfg[slot8.id].moment then
			if PolyhedronConst.EFFECT_ACTION.ATTRIBUTE == slot9.action then
				for slot13, slot14 in ipairs(slot9.params) do
					slot15 = slot14[1]
					slot2[slot15] = HeroTools.AttributeAdd(slot15, slot2[slot15], slot14[2])
				end
			elseif PolyhedronConst.EFFECT_ACTION.ATTRIBUTE_MULTIPLE_ARTIFACT_NUM == slot9.action then
				for slot13, slot14 in ipairs(slot9.params) do
					slot15 = slot14[1]
					slot2[slot15] = HeroTools.AttributeAdd(slot15, slot2[slot15], slot14[2] * slot3)
				end
			end
		end
	end

	if slot0.hero_list[slot1] then
		for slot8, slot9 in ipairs(slot4.difference_attribute_list) do
			slot10 = slot9.id
			slot2[slot10] = HeroTools.AttributeAdd(slot10, slot2[slot10], slot9.value)
		end
	end

	return slot2
end

PolyhedronSnapShotTemplate = class("PolyhedronSnapShotTemplate")

function PolyhedronSnapShotTemplate.Ctor(slot0, slot1)
	slot0.hero_id = slot1.hero_id
	slot0.astrolabe_list = {}

	for slot5, slot6 in ipairs(slot1.astrolabe_list) do
		table.insert(slot0.astrolabe_list, slot6)
	end
end

function PolyhedronSnapShotTemplate.GetHeroId(slot0)
	return slot0.hero_id
end

function PolyhedronSnapShotTemplate.GetVirtualData(slot0)
	slot3 = deepClone(TempHeroData:GetTempHeroDataByTempID(PolyhedronHeroCfg[slot0.hero_id].standard_id))
	slot4 = slot3.equip_list
	slot3.using_astrolabe = slot0.astrolabe_list
	slot8 = slot0.hero_id
	slot3.using_skin = PolyhedronData:GetHeroUsingSkinInfo(slot8).id

	for slot8, slot9 in ipairs(slot3.skill) do
		slot9.skill_level = slot9.skill_level + HeroTools.GetHeroSkillAddLevel(slot3, slot9.skill_id)
	end

	return slot3, slot4
end

PolyhedronHeroTemplate = class("PolyhedronHeroTemplate")

function PolyhedronHeroTemplate.Ctor(slot0, slot1)
	slot0.hero_id = slot1.hero_id
	slot0.template_id = slot1.template_id
	slot0.health = slot1.health
	slot0.max_health = slot1.max_health
	slot0.reborn_cold_down = slot1.reborn_cold_down
	slot0.difference_attribute_list = {}

	for slot5, slot6 in ipairs(slot1.difference_attribute_list) do
		table.insert(slot0.difference_attribute_list, {
			id = slot6.id,
			value = slot6.value
		})
	end

	slot0.injured = slot1.injured
	slot0.heal = slot1.heal
	slot0.damage = slot1.damage
end

function PolyhedronHeroTemplate.IsDead(slot0)
	return slot0.health <= 0
end

function PolyhedronHeroTemplate.GetHeroMaxHP(slot0)
	return slot0.max_health
end

function PolyhedronHeroTemplate.GetHeroHP(slot0)
	return math.ceil(slot0.health)
end

PolyhedronEventTemplate = class("PolyhedronHeroTemplate")

function PolyhedronEventTemplate.Ctor(slot0, slot1)
	slot0.id = slot1.id
	slot0.stage_id = slot1.stage_id
	slot0.reward_type = slot1.reward_type
end

PolyhedronStageTemplate = class("PolyhedronStageTemplate")

function PolyhedronStageTemplate.Ctor(slot0, slot1)
	slot0.stage_id = slot1.stage_id
	slot0.save_point = slot1.save_point

	print("更新保存点" .. slot0.save_point)

	slot2 = slot1.reward
	slot0.rewardRound = slot2.round
	slot0.item_list = {}

	for slot6, slot7 in ipairs(slot2.item_list) do
		slot8 = {}

		for slot12, slot13 in ipairs(slot7.params) do
			table.insert(slot8, slot13)
		end

		table.insert(slot0.item_list, {
			class = slot7.class,
			params = slot8
		})
	end

	slot0.params = {}

	for slot6, slot7 in ipairs(slot1.params) do
		table.insert(slot0.params, slot7)
	end

	slot0.gate_list = {}

	for slot6, slot7 in ipairs(slot1.gate_list) do
		slot0.gate_list[slot7.index] = PolyhedronEventTemplate.New(slot7.event)
	end

	if slot1.shop then
		slot0.refresh_times = slot3.refresh_times
		slot0.recover_times = slot3.recover_times
		slot0.shop_item_list = {}

		for slot7, slot8 in ipairs(slot3.item_list) do
			for slot14, slot15 in ipairs(slot8.item.params) do
				table.insert({}, slot15)
			end

			if slot8.is_available == 1 then
				table.insert(slot0.shop_item_list, {
					class = slot10.class,
					params = slot9,
					price = slot8.price,
					shop_index = slot7
				})
			end
		end
	else
		slot0.refresh_times = 0
		slot0.recover_times = 0
		slot0.shop_item_list = {}
	end

	slot0.attribute_modify_list = {}

	for slot7, slot8 in ipairs(slot1.attribute_modify_list) do
		if slot8.target_id then
			-- Nothing
		end

		if slot8.delta then
			slot9.delta = slot8.delta
		end

		table.insert(slot0.attribute_modify_list, {
			attribute_id = slot8.attribute_id,
			target_id = slot8.target_id
		})
	end
end

function PolyhedronStageTemplate.GetRewardList(slot0)
	if PolyhedronConst.SAVE_POINT_TYPE.REWARD == slot0.save_point then
		return slot0.item_list
	end

	return {}
end

function PolyhedronStageTemplate.GetTipsList(slot0)
	return slot0.attribute_modify_list
end

PolyhedronRankTemplate = class("PolyhedronRankTemplate")

function PolyhedronRankTemplate.Ctor(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp

	if PlayerData:GetPlayerInfo() and slot0.user_id == slot2.userID then
		slot0.nick = slot2.nick
		slot0.icon = slot2.portrait
		slot0.icon_frame = slot2.icon_frame
	else
		slot0.nick = slot1.nick
		slot0.icon = slot1.portrait
		slot0.icon_frame = slot1.frame
	end

	slot0.select_hero_id_list = {}

	for slot7, slot8 in ipairs(slot1.team_info[1] and slot1.team_info[1].hero_info_list or {}) do
		table.insert(slot0.select_hero_id_list, {
			id = slot8.hero_id,
			skin_id = slot8.skin_id
		})
	end
end
