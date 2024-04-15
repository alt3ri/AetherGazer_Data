local var_0_0 = {
	{
		ItemCfg,
		ItemCfg2
	},
	{
		ShopCfg,
		ShopCfg2
	}
}

for iter_0_0, iter_0_1 in pairs(var_0_0) do
	setmetatable(iter_0_1[1], {
		__index = function(arg_1_0, arg_1_1)
			for iter_1_0, iter_1_1 in ipairs(iter_0_1) do
				local var_1_0 = rawget(iter_1_1, arg_1_1)

				if var_1_0 then
					return var_1_0
				end
			end
		end
	})
end

for iter_0_2, iter_0_3 in ipairs(ChapterClientCfg.all) do
	if ChapterClientCfg[iter_0_3].not_chapter_id == false then
		for iter_0_4, iter_0_5 in ipairs(ChapterClientCfg[iter_0_3].chapter_list) do
			ChapterCfg[iter_0_5].clientID = iter_0_3
			ChapterClientCfg[iter_0_3].difficulty = ChapterCfg[iter_0_5].difficulty
		end
	else
		for iter_0_6, iter_0_7 in ipairs(ChapterClientCfg[iter_0_3].chapter_list) do
			ChapterClientCfg[iter_0_7].parentToggle = ChapterClientCfg[iter_0_3].toggle

			for iter_0_8, iter_0_9 in ipairs(ChapterClientCfg[iter_0_7].chapter_list) do
				ChapterCfg[iter_0_9].toggle = ChapterClientCfg[iter_0_7].toggle
			end
		end
	end
end

local var_0_1 = {}

for iter_0_10, iter_0_11 in pairs(ChapterCfg.all) do
	local var_0_2 = ChapterCfg[iter_0_11]

	for iter_0_12, iter_0_13 in ipairs(var_0_2.section_id_list) do
		if not var_0_1[iter_0_13] then
			var_0_1[iter_0_13] = iter_0_11
		end
	end
end

local var_0_3 = {}

for iter_0_14, iter_0_15 in ipairs(ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]) do
	local var_0_4 = ChapterCfg[iter_0_15]

	var_0_3[var_0_4.sub_type] = var_0_3[var_0_4.sub_type] or {}
	var_0_3[var_0_4.sub_type][var_0_4.difficulty] = var_0_3[var_0_4.sub_type][var_0_4.difficulty] or {}

	table.insert(var_0_3[var_0_4.sub_type][var_0_4.difficulty], iter_0_15)
end

function getChapterNumList(arg_2_0)
	return var_0_3[arg_2_0]
end

function getChapterList()
	return var_0_3
end

local var_0_5 = {}

for iter_0_16, iter_0_17 in ipairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.PLOT]) do
	local var_0_6 = ChapterClientCfg[iter_0_17].chapter_list[1]
	local var_0_7 = ChapterCfg[var_0_6].difficulty

	var_0_5[var_0_7] = var_0_5[var_0_7] or {}

	if #ChapterCfg[var_0_6].section_id_list > 0 then
		table.insert(var_0_5[var_0_7], iter_0_17)
	end
end

function getChapterClientList()
	return var_0_5
end

local function var_0_8(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.all) do
		if type(arg_5_0[iter_5_1].next_show_id_list) == "table" then
			for iter_5_2, iter_5_3 in ipairs(arg_5_0[iter_5_1].next_show_id_list) do
				arg_5_0[iter_5_3].pre_show_id_list = arg_5_0[iter_5_3].pre_show_id_list or {}

				table.insert(arg_5_0[iter_5_3].pre_show_id_list, iter_5_1)
			end
		end

		if type(arg_5_0[iter_5_1].next_unlock_id_list) == "table" then
			for iter_5_4, iter_5_5 in ipairs(arg_5_0[iter_5_1].next_unlock_id_list) do
				arg_5_0[iter_5_5].pre_unlock_id_list = arg_5_0[iter_5_5].pre_unlock_id_list or {}

				table.insert(arg_5_0[iter_5_5].pre_unlock_id_list, iter_5_1)
			end
		end
	end
end

local var_0_9 = {
	BattleChapterStageCfg,
	BattleDailyStageCfg,
	BattleActivityStoryStageCfg
}

for iter_0_18, iter_0_19 in pairs(var_0_9) do
	var_0_8(iter_0_19)
end

local var_0_10 = GameSetting.guide_map.value2
local var_0_11 = string.split(var_0_10, ",")
local var_0_12 = {}

for iter_0_20, iter_0_21 in ipairs(var_0_11) do
	local var_0_13 = string.split(iter_0_21, "=")

	if var_0_13[1] and var_0_13[2] then
		var_0_12[tonumber(var_0_13[1])] = tonumber(var_0_13[2])
	end
end

GameSetting.guide_map.value2 = var_0_12

local var_0_14 = {}

for iter_0_22, iter_0_23 in pairs(WarchessHexCfg) do
	if iter_0_23.id then
		local var_0_15 = GridConfig.New()

		var_0_15.id = iter_0_23.id
		var_0_15.walkable = iter_0_23.move
		var_0_15.interact = iter_0_23.interact
		var_0_15.explode = iter_0_23.explode
		var_0_15.stonecanmove = iter_0_23.stonecanmove
		var_0_15.stonecaninteract = iter_0_23.stonecaninteract

		table.insert(var_0_14, var_0_15)
	end
end

WarchessHexCfg.AllGridConfig = var_0_14

local var_0_16 = {}

for iter_0_24, iter_0_25 in pairs(WarchessLevelCfg.all) do
	local var_0_17 = WarchessLevelCfg[iter_0_25]

	if type(var_0_17.trial_stage_list) == "table" then
		for iter_0_26, iter_0_27 in pairs(var_0_17.trial_stage_list) do
			var_0_16[iter_0_27] = var_0_17.id_level
		end
	end
end

function GetChessLevelIDByStageID(arg_6_0)
	return var_0_16[arg_6_0]
end

local var_0_18 = {}

for iter_0_28, iter_0_29 in pairs(BackHomeCfg) do
	if iter_0_29.id then
		local var_0_19 = DormMapCfg.New()

		var_0_19.id = iter_0_29.id
		var_0_19.name = iter_0_29.scene
		var_0_19.previewParams = DormCameraParams.New()
		var_0_19.editParams = DormCameraParams.New()

		local var_0_20 = DormCameraCfg[iter_0_29.camera_preview]

		var_0_19.previewParams.value = Vector2.New(var_0_20.value[1], var_0_20.value[2])
		var_0_19.previewParams.topRig = Vector2.New(var_0_20.toprig[1], var_0_20.toprig[2])
		var_0_19.previewParams.middleRig = Vector2.New(var_0_20.middlerig[1], var_0_20.middlerig[2])
		var_0_19.previewParams.bottomRig = Vector2.New(var_0_20.bottomrig[1], var_0_20.bottomrig[2])
		var_0_19.previewParams.topRigInterval = Vector2.New(var_0_20.toprig_interval[1], var_0_20.toprig_interval[2])

		local var_0_21 = DormCameraCfg[iter_0_29.camera_edit]

		var_0_19.editParams.value = Vector2.New(var_0_21.value[1], var_0_21.value[2])
		var_0_19.editParams.topRig = Vector2.New(var_0_21.toprig[1], var_0_21.toprig[2])
		var_0_19.editParams.middleRig = Vector2.New(var_0_21.middlerig[1], var_0_21.middlerig[2])
		var_0_19.editParams.bottomRig = Vector2.New(var_0_21.bottomrig[1], var_0_21.bottomrig[2])
		var_0_19.editParams.topRigInterval = Vector2.New(var_0_21.toprig_interval[1], var_0_21.toprig_interval[2])

		table.insert(var_0_18, var_0_19)
	end
end

BackHomeCfg.AllMapCfg = var_0_18

local var_0_22 = {}

for iter_0_30, iter_0_31 in pairs(BackHomeFurniture) do
	if iter_0_31.id and not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_0_31.id) then
		local var_0_23 = FurnitureConfig.New()

		var_0_23.id = iter_0_31.id
		var_0_23.prefab = iter_0_31.model
		var_0_23.type = {
			iter_0_31.display_type,
			iter_0_31.sub_type or 0
		}
		var_0_23.width = iter_0_31.title[1]
		var_0_23.height = iter_0_31.title[2]
		var_0_23.depth = iter_0_31.title[3] or 0

		table.insert(var_0_22, var_0_23)
	end
end

BackHomeFurniture.AllFurnitureConfig = var_0_22

local var_0_24 = {}

for iter_0_32, iter_0_33 in pairs(HeroSkillCfg.all) do
	local var_0_25 = HeroSkillCfg[iter_0_33]

	if type(var_0_25.strengthen_desc) == "table" and var_0_25.strengthen_desc[1] then
		var_0_24[var_0_25.strengthen_desc[1]] = iter_0_33
	end
end

for iter_0_34, iter_0_35 in pairs(WeaponEffectCfg.all) do
	local var_0_26 = WeaponEffectCfg[iter_0_35]

	if iter_0_35 > 0 and type(var_0_26.strengthen_description) == "table" and var_0_26.strengthen_description[1] then
		var_0_24[var_0_26.strengthen_description[1]] = WeaponServantCfg.get_id_list_by_effect[iter_0_35][1]
	end
end

function getSkillIDOrServantID(arg_7_0)
	return var_0_24[arg_7_0]
end

local var_0_27 = {}

for iter_0_36, iter_0_37 in pairs(AstrolabeEffectCfg.all) do
	local var_0_28 = AstrolabeEffectCfg[iter_0_37]

	if type(var_0_28.equip_orange_desc) == "table" then
		for iter_0_38, iter_0_39 in pairs(var_0_28.equip_orange_desc) do
			if var_0_27[iter_0_39[3]] == nil then
				var_0_27[iter_0_39[3]] = {}
			end

			var_0_27[iter_0_39[3]][iter_0_39[1]] = var_0_28.id
		end
	end
end

function getAstrolabeID(arg_8_0, arg_8_1)
	if var_0_27[arg_8_0] == nil then
		print("配置错误！检查AstrolabeEffectCfg和WeaponModuleEffectCfg")

		return
	end

	return var_0_27[arg_8_0][arg_8_1]
end

HERO_FRAGMENT_VALUE = 10000

for iter_0_40, iter_0_41 in pairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.HERO]) do
	ItemCfg[iter_0_41].fragment = iter_0_41 + HERO_FRAGMENT_VALUE
end

for iter_0_42, iter_0_43 in pairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.HERO_PIECE]) do
	ItemCfg[iter_0_43].hero_id = iter_0_43 - HERO_FRAGMENT_VALUE
end

for iter_0_44, iter_0_45 in pairs(ActivityPtCfg.all) do
	ItemCfg[ActivityPtCfg[iter_0_45].item_id].activity_id = iter_0_45
end

ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId = {}

for iter_0_46, iter_0_47 in ipairs(ActivityPtRepeatCfg.all) do
	local var_0_29 = ActivityPtRepeatCfg[iter_0_47]

	if not ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[var_0_29.activity_id] then
		ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[var_0_29.activity_id] = {}
	end

	ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[var_0_29.activity_id][var_0_29.stage_id] = var_0_29
end

ActivityPt2Cfg.GetCfgFromActivityIdAndStageId = {}

for iter_0_48, iter_0_49 in ipairs(ActivityPt2Cfg.all) do
	local var_0_30 = ActivityPt2Cfg[iter_0_49]

	if not ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[var_0_30.activity_id] then
		ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[var_0_30.activity_id] = {}
	end

	ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[var_0_30.activity_id][var_0_30.stage_id] = var_0_30
end

ShopListCfg.get_id_list_by_system_and_group = {}

for iter_0_50, iter_0_51 in pairs(ShopListCfg.get_id_list_by_system) do
	local var_0_31 = {}

	for iter_0_52, iter_0_53 in ipairs(iter_0_51) do
		local var_0_32 = ShopListCfg[iter_0_53]

		if not var_0_31[var_0_32.display_group] then
			var_0_31[var_0_32.display_group] = {}
		end

		table.insert(var_0_31[var_0_32.display_group], var_0_32)
	end

	ShopListCfg.get_id_list_by_system_and_group[iter_0_50] = var_0_31
end

function UpdateShopCfg(arg_9_0)
	local var_9_0 = arg_9_0.shop_id
	local var_9_1 = arg_9_0.goods_list

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = {}

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.give_back_list or {}) do
			table.insert(var_9_2, {
				id = iter_9_3.id,
				num = iter_9_3.num
			})
		end

		ShopCfg[iter_9_1.goods_id] = {
			taken_down = 0,
			position = 0,
			shop_refresh = 3,
			goods_id = iter_9_1.goods_id,
			shop_id = var_9_0,
			shop_sort = iter_9_1.shop_sort,
			give_id = iter_9_1.give_id,
			description = iter_9_1.description,
			give = iter_9_1.give,
			cost_type = iter_9_1.cost_type,
			cost_id = iter_9_1.cost_id,
			cost = iter_9_1.cost,
			cheap_cost_id = iter_9_1.cheap_cost_id,
			cheap_cost = iter_9_1.cheap_cost,
			discount = iter_9_1.discount,
			limit_num = iter_9_1.limit_num,
			level_limit = cleanProtoTable(iter_9_1.level_limit),
			limit_display = iter_9_1.limit_display,
			pre_goods_id = cleanProtoTable(iter_9_1.pre_goods_id),
			refresh_cycle = iter_9_1.refresh_cycle,
			open_time = {},
			close_time = {},
			is_limit_time_discount = iter_9_1.is_limit_time_discount,
			cheap_open_time = {},
			cheap_close_time = {},
			tag = iter_9_1.tag,
			backhome_tag = iter_9_1.backhome_tag,
			next_goods_id = cleanProtoTable(iter_9_1.next_goods_id),
			give_back_list = var_9_2,
			dlc = iter_9_1.dlc
		}

		if iter_9_1.open_time and iter_9_1.open_time.year ~= 0 then
			local var_9_3 = iter_9_1.open_time

			ShopCfg[iter_9_1.goods_id].open_time = {
				{
					var_9_3.year,
					var_9_3.month,
					var_9_3.day
				},
				{
					var_9_3.hour,
					var_9_3.minute,
					var_9_3.second
				}
			}
		end

		if iter_9_1.close_time and iter_9_1.close_time.year ~= 0 then
			local var_9_4 = iter_9_1.close_time

			ShopCfg[iter_9_1.goods_id].close_time = {
				{
					var_9_4.year,
					var_9_4.month,
					var_9_4.day
				},
				{
					var_9_4.hour,
					var_9_4.minute,
					var_9_4.second
				}
			}
		end

		if iter_9_1.cheap_open_time and iter_9_1.cheap_open_time.year ~= 0 then
			local var_9_5 = iter_9_1.cheap_open_time

			ShopCfg[iter_9_1.goods_id].cheap_open_time = {
				{
					var_9_5.year,
					var_9_5.month,
					var_9_5.day
				},
				{
					var_9_5.hour,
					var_9_5.minute,
					var_9_5.second
				}
			}
		end

		if iter_9_1.cheap_close_time and iter_9_1.cheap_close_time.year ~= 0 then
			local var_9_6 = iter_9_1.cheap_close_time

			ShopCfg[iter_9_1.goods_id].cheap_close_time = {
				{
					var_9_6.year,
					var_9_6.month,
					var_9_6.day
				},
				{
					var_9_6.hour,
					var_9_6.minute,
					var_9_6.second
				}
			}
		end

		ShopCfg.get_id_list_by_shop_id[var_9_0] = ShopCfg.get_id_list_by_shop_id[var_9_0] or {}

		if not table.indexof(ShopCfg.get_id_list_by_shop_id[var_9_0]) then
			table.insert(ShopCfg.get_id_list_by_shop_id[var_9_0], iter_9_1.goods_id)
		end

		ShopCfg.get_id_list_by_cost_id[iter_9_1.cost_id] = ShopCfg.get_id_list_by_cost_id[iter_9_1.cost_id] or {}

		if not table.indexof(ShopCfg.get_id_list_by_cost_id[iter_9_1.cost_id]) then
			table.insert(ShopCfg.get_id_list_by_cost_id[iter_9_1.cost_id], iter_9_1.goods_id)
		end
	end
end

for iter_0_54, iter_0_55 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.SKIN_CHANGE]) do
	local var_0_33 = ItemCfg[iter_0_55].param[1]

	SkinCfg[var_0_33].change_item = iter_0_55
end

function getChapterIDByStageID(arg_10_0)
	return var_0_1[arg_10_0]
end

function getChapterClientCfgByChapterID(arg_11_0)
	local var_11_0 = ChapterCfg[arg_11_0]

	return ChapterClientCfg[var_11_0.clientID]
end

function getChapterClientCfgByStageID(arg_12_0)
	local var_12_0 = getChapterIDByStageID(arg_12_0)

	return getChapterClientCfgByChapterID(var_12_0)
end

function getChapterAndSectionID(arg_13_0)
	local var_13_0 = getChapterIDByStageID(arg_13_0)
	local var_13_1 = ChapterCfg[var_13_0]
	local var_13_2 = var_13_1.section_id_list ~= "" and table.keyof(var_13_1.section_id_list, arg_13_0) or 1

	return var_13_0, var_13_2
end

function getChapterToggle(arg_14_0)
	return ChapterClientCfg[arg_14_0].parentToggle or ChapterClientCfg[arg_14_0].toggle
end

function getChapterDifficulty(arg_15_0)
	local var_15_0 = BattleStageTools.GetChapterByStageId(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_15_0)
	local var_15_1 = ChapterCfg[var_15_0]

	if not var_15_1 then
		error("错误的难度参数")
	end

	local var_15_2 = var_15_1.difficulty

	if var_15_2 == 1 then
		return GetTips("HARDLEVEL_EASY")
	elseif var_15_2 == 2 then
		return GetTips("HARDLEVEL_HARD_2")
	end
end

function getStageViaStoryID(arg_16_0)
	return StoryCfg[arg_16_0].trigger[2]
end

local var_0_34 = {}

function getChapterListByDifficulty(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or "all"

	if not var_0_34[arg_17_0] then
		local var_17_0 = {}
		local var_17_1 = ChapterCfg.get_id_list_by_type[arg_17_0]

		for iter_17_0, iter_17_1 in ipairs(var_17_1) do
			local var_17_2 = ChapterCfg[iter_17_1].difficulty

			var_17_0[var_17_2] = var_17_0[var_17_2] or {}
			var_17_0.all = var_17_0.all or {}

			table.insert(var_17_0.all, iter_17_1)
			table.insert(var_17_0[var_17_2], iter_17_1)
		end

		var_0_34[arg_17_0] = var_17_0
	end

	return var_0_34[arg_17_0][arg_17_1] or {}
end

local var_0_35 = {}

for iter_0_56, iter_0_57 in pairs(StoryCfg) do
	local var_0_36 = iter_0_57.trigger[2]

	if var_0_36 then
		if not var_0_35[var_0_36] then
			var_0_35[var_0_36] = {}
		end

		local var_0_37 = iter_0_57.trigger[3]

		var_0_35[var_0_36][var_0_37] = iter_0_57.id
	end
end

function getStoryViaStageID(arg_18_0, arg_18_1)
	if not var_0_35[arg_18_0] then
		return false
	end

	return var_0_35[arg_18_0][arg_18_1]
end

for iter_0_58, iter_0_59 in ipairs(WeaponServantCfg.all) do
	local var_0_38 = ServantTools.GetServantSpecHero(iter_0_59)

	if var_0_38 then
		HeroCfg[var_0_38].spec_servant = iter_0_59
	end
end

local var_0_39 = {}

for iter_0_60, iter_0_61 in pairs(ItemCfg.get_id_list_by_type[14]) do
	var_0_39[ItemCfg[iter_0_61].param[1]] = iter_0_61
end

function getTicketIDBySkinID(arg_19_0)
	return var_0_39[arg_19_0]
end

TalentTreeCfg.get_id_list_by_activity_id_and_race = {}

for iter_0_62, iter_0_63 in pairs(TalentTreeCfg.get_id_list_by_activity_id) do
	TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_62] = {}

	local var_0_40

	for iter_0_64, iter_0_65 in ipairs(iter_0_63) do
		local var_0_41 = TalentTreeCfg[iter_0_65].race

		if TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_62][var_0_41] == nil then
			TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_62][var_0_41] = {}
		end

		table.insert(TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_62][var_0_41], iter_0_65)
	end
end

for iter_0_66, iter_0_67 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO]) do
	if ActivityCultivateHeroCfg[iter_0_67] then
		local var_0_42 = ActivityCultivateHeroCfg[iter_0_67].group

		for iter_0_68, iter_0_69 in ipairs(var_0_42) do
			local var_0_43 = CultivateHeroTaskCfg.get_id_list_by_group_id[iter_0_69]

			for iter_0_70, iter_0_71 in ipairs(var_0_43) do
				CultivateHeroTaskCfg[iter_0_71].activity_id = iter_0_67
			end
		end
	end
end

local function var_0_44(arg_20_0, arg_20_1)
	local var_20_0 = _G[arg_20_0 .. "_" .. arg_20_1]

	if var_20_0 then
		local var_20_1 = _G[arg_20_0]

		setmetatable(var_20_0, {
			__index = var_20_1
		})

		_G[arg_20_0] = var_20_0
	end
end

function DealAreaDifferenceCfg(arg_21_0)
	if arg_21_0 == nil or arg_21_0 == "" or arg_21_0 == "zh_cn" then
		return
	end

	if _G["WordVerifyCfg" .. arg_21_0] then
		WordVerifyCfg = _G["WordVerifyCfg" .. arg_21_0]
		WordVerifyCfg2 = _G["WordVerifyCfg2" .. arg_21_0]
		WordVerifyCfg3 = _G["WordVerifyCfg3" .. arg_21_0]
		WordVerifyCfg4 = _G["WordVerifyCfg4" .. arg_21_0]
		WordVerifyCfg5 = _G["WordVerifyCfg5" .. arg_21_0]
		WordVerifyCfg6 = _G["WordVerifyCfg6" .. arg_21_0]
		WordVerifyCfg7 = _G["WordVerifyCfg7" .. arg_21_0]
		WordVerifyCfg8 = _G["WordVerifyCfg8" .. arg_21_0]
		WordVerifyCfg9 = _G["WordVerifyCfg9" .. arg_21_0]
		WordVerifyCfg10 = _G["WordVerifyCfg10" .. arg_21_0]
	end

	if _G["PaymentCfg" .. arg_21_0] then
		PaymentCfg = _G["PaymentCfg" .. arg_21_0]
	end

	if _G["TotalRechargeCfg" .. arg_21_0] then
		TotalRechargeCfg = _G["TotalRechargeCfg" .. arg_21_0]
	end

	if _G["RechargeCfg" .. arg_21_0] then
		RechargeCfg = _G["RechargeCfg" .. arg_21_0]
	end

	var_0_44("GameDisplayCfg", arg_21_0)
end

function GetCfgDescription(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 == nil then
		arg_22_2 = 1
	end

	local function var_22_0(arg_23_0, arg_23_1)
		if arg_23_1 then
			return math.floor(arg_23_0 * 10^arg_23_1 + 0.5) / 10^arg_23_1
		else
			return math.floor(arg_23_0 + 0.5)
		end
	end

	local var_22_1 = DescriptionCfg[arg_22_0]

	if not var_22_1 then
		print("错误, 找不到对应id的描述配置 " .. arg_22_0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. arg_22_0 .. " description.csv 表"
	end

	local var_22_2 = GetI18NText(var_22_1.description)

	if arg_22_1 == nil then
		arg_22_1 = 1
	end

	if arg_22_3 == nil then
		arg_22_3 = var_22_1.maxLv
	end

	if var_22_1.type == 1 then
		if arg_22_1 > var_22_1.maxLv or arg_22_1 < 1 then
			print("错误, 找不到对应等级的描述配置 id = " .. arg_22_0 .. " description.csv 表 level = " .. arg_22_1)

			return "错误, 找不到对应等级的描述配置 id = " .. arg_22_0 .. " description.csv 表 level = " .. arg_22_1
		end

		local var_22_3 = var_22_1.param

		if #var_22_3 >= 1 then
			local var_22_4 = {
				"0"
			}

			for iter_22_0, iter_22_1 in ipairs(var_22_3) do
				local var_22_5 = iter_22_1[1]
				local var_22_6 = iter_22_1[2]
				local var_22_7 = iter_22_1[3]
				local var_22_8 = iter_22_1[4]
				local var_22_9 = var_22_0(var_22_5 + var_22_6 * (arg_22_1 - 1), arg_22_2)

				if var_22_9 % 1 == 0 then
					var_22_9 = string.format("%.0f", var_22_9) .. var_22_8
				else
					var_22_9 = string.format("%." .. arg_22_2 .. "f", var_22_9) .. var_22_8
				end

				local var_22_10 = var_22_9

				if var_22_7 and arg_22_1 < arg_22_3 then
					local var_22_11 = var_22_0(var_22_5 + var_22_6 * arg_22_1, arg_22_2)

					if var_22_11 % 1 == 0 then
						var_22_11 = string.format("%.0f", var_22_11) .. var_22_8
					else
						var_22_11 = string.format("%." .. arg_22_2 .. "f", var_22_11) .. var_22_8
					end

					var_22_10 = GetTipsF("DESCRIPTION_NEXT_LEVEL", var_22_9, var_22_11)
				end

				table.insert(var_22_4, var_22_10)
			end

			return LuaExchangeHelper.GetDescription(var_22_2, var_22_4)
		else
			return var_22_2
		end
	else
		local var_22_12 = var_22_1.param[arg_22_1]

		if not var_22_12 then
			print("错误, 找不到对应等级的描述配置 id = " .. arg_22_0 .. " description.csv 表 level = " .. arg_22_1)

			return "错误, 找不到对应等级的描述配置 id = " .. arg_22_0 .. " description.csv 表 level = " .. arg_22_1
		end

		if #var_22_12 > 1 then
			return LuaExchangeHelper.GetDescription(var_22_2, var_22_12)
		else
			return var_22_2
		end
	end
end

function GetCfgDescriptionWithValue(arg_24_0, arg_24_1)
	local var_24_0 = DescriptionCfg[arg_24_0]

	if not var_24_0 then
		print("错误, 找不到对应id的描述配置 " .. arg_24_0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. arg_24_0 .. " description.csv 表"
	end

	local var_24_1 = GetI18NText(var_24_0.description)
	local var_24_2 = {
		""
	}

	if type(arg_24_1) ~= "table" then
		table.insert(var_24_2, arg_24_1)
	else
		table.insertto(var_24_2, arg_24_1)
	end

	return LuaExchangeHelper.GetDescription(var_24_1, var_24_2)
end

local var_0_45 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.POLYHEDRON_ACTIVITY] or {}

for iter_0_72, iter_0_73 in ipairs(var_0_45) do
	local var_0_46 = ActivityCfg[iter_0_73].sub_activity_list

	ActivityCfg[iter_0_73].policy_activity_id = iter_0_73

	local var_0_47 = {}
	local var_0_48 = {}

	for iter_0_74, iter_0_75 in ipairs(var_0_46) do
		if ActivityCfg[iter_0_75].activity_template == ActivityTemplateConst.TASK then
			local var_0_49 = AssignmentCfg.get_id_list_by_activity_id[iter_0_75]

			if AssignmentCfg[var_0_49[1]].type == TaskConst.TASK_TYPE.POLYHEDRON_SEASON then
				var_0_47[#var_0_47 + 1] = iter_0_75
			elseif AssignmentCfg[var_0_49[1]].type == TaskConst.TASK_TYPE.POLYHEDRON_ACHIEVEMENT then
				var_0_48[#var_0_48 + 1] = iter_0_75
			end
		end
	end

	ActivityCfg[iter_0_73].season_task_activity_list = var_0_47
	ActivityCfg[iter_0_73].achievement_task_activity_list = var_0_48
end

ActivityReprintExCfg = {}

for iter_0_76, iter_0_77 in ipairs(ActivityReprintCfg.all) do
	for iter_0_78, iter_0_79 in pairs(ActivityReprintCfg[iter_0_77]) do
		if iter_0_78 ~= "id" then
			ActivityReprintExCfg[iter_0_79] = {
				originActivityID = iter_0_77
			}
		end
	end
end

HeroStarUpTemplateCfg.template_dic = {}

for iter_0_80, iter_0_81 in pairs(HeroStarUpTemplateCfg.get_id_list_by_template) do
	local var_0_50 = {}

	for iter_0_82, iter_0_83 in ipairs(iter_0_81) do
		local var_0_51 = HeroStarUpTemplateCfg[iter_0_83].skill_id
		local var_0_52 = HeroStarUpTemplateCfg[iter_0_83].stage
		local var_0_53 = HeroStarSkillCfg[var_0_51].type

		var_0_50[var_0_53] = var_0_50[var_0_53] or {}
		var_0_50[var_0_53].stage_dic = var_0_50[var_0_53].stage_dic or {}
		var_0_50[var_0_53].stage_dic[var_0_52] = var_0_51
	end

	for iter_0_84, iter_0_85 in pairs(var_0_50) do
		local var_0_54 = {}
		local var_0_55 = iter_0_85.stage_dic

		for iter_0_86, iter_0_87 in pairs(var_0_55) do
			var_0_54[#var_0_54 + 1] = iter_0_86
		end

		table.sort(var_0_54)

		var_0_50[iter_0_84].stage_list = var_0_54
	end

	HeroStarUpTemplateCfg.template_dic[iter_0_80] = var_0_50
end

function HeroVoiceDescCfg.Get(arg_25_0, arg_25_1)
	return nullable(HeroVoiceDescCfg, nullable(HeroVoiceDescCfg.get_id_list_by_chara_id_subtitle_id, arg_25_0, arg_25_1, 1), "content")
end

function ConfigHelper_GetCfg(arg_26_0, arg_26_1, arg_26_2)
	return _G[arg_26_0][arg_26_1][arg_26_2]
end
