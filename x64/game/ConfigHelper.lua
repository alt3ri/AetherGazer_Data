for slot4, slot5 in pairs({
	{
		ItemCfg,
		ItemCfg2
	},
	{
		ShopCfg,
		ShopCfg2
	}
}) do
	setmetatable(slot5[1], {
		__index = function (slot0, slot1)
			for slot5, slot6 in ipairs(uv0) do
				if rawget(slot6, slot1) then
					return slot7
				end
			end
		end
	})
end

for slot4, slot5 in ipairs(ChapterClientCfg.all) do
	if ChapterClientCfg[slot5].not_chapter_id == false then
		for slot9, slot10 in ipairs(ChapterClientCfg[slot5].chapter_list) do
			ChapterCfg[slot10].clientID = slot5
			ChapterClientCfg[slot5].difficulty = ChapterCfg[slot10].difficulty
		end
	else
		for slot9, slot10 in ipairs(ChapterClientCfg[slot5].chapter_list) do
			ChapterClientCfg[slot10].parentToggle = ChapterClientCfg[slot5].toggle

			for slot14, slot15 in ipairs(ChapterClientCfg[slot10].chapter_list) do
				ChapterCfg[slot15].toggle = ChapterClientCfg[slot10].toggle
			end
		end
	end
end

slot1 = {}

for slot5, slot6 in pairs(ChapterCfg.all) do
	for slot11, slot12 in ipairs(ChapterCfg[slot6].section_id_list) do
		if not slot1[slot12] then
			slot1[slot12] = slot6
		end
	end
end

slot2 = {}
slot6 = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT

for slot6, slot7 in ipairs(ChapterCfg.get_id_list_by_type[slot6]) do
	slot8 = ChapterCfg[slot7]
	slot2[slot8.sub_type] = slot2[slot8.sub_type] or {}
	slot2[slot8.sub_type][slot8.difficulty] = slot2[slot8.sub_type][slot8.difficulty] or {}

	table.insert(slot2[slot8.sub_type][slot8.difficulty], slot7)
end

function getChapterNumList(slot0)
	return uv0[slot0]
end

function getChapterList()
	return uv0
end

slot3 = {}
slot7 = BattleConst.TOGGLE.PLOT

for slot7, slot8 in ipairs(ChapterClientCfg.get_id_list_by_toggle[slot7]) do
	slot3[slot10] = slot3[ChapterCfg[ChapterClientCfg[slot8].chapter_list[1]].difficulty] or {}

	if #ChapterCfg[slot9].section_id_list > 0 then
		table.insert(slot3[slot10], slot8)
	end
end

function getChapterClientList()
	return uv0
end

for slot9, slot10 in pairs({
	BattleChapterStageCfg,
	BattleDailyStageCfg,
	BattleActivityStoryStageCfg
}) do
	function (slot0)
		for slot4, slot5 in ipairs(slot0.all) do
			if type(slot0[slot5].next_show_id_list) == "table" then
				for slot9, slot10 in ipairs(slot0[slot5].next_show_id_list) do
					slot0[slot10].pre_show_id_list = slot0[slot10].pre_show_id_list or {}

					table.insert(slot0[slot10].pre_show_id_list, slot5)
				end
			end

			if type(slot0[slot5].next_unlock_id_list) == "table" then
				for slot9, slot10 in ipairs(slot0[slot5].next_unlock_id_list) do
					slot0[slot10].pre_unlock_id_list = slot0[slot10].pre_unlock_id_list or {}

					table.insert(slot0[slot10].pre_unlock_id_list, slot5)
				end
			end
		end
	end(slot10)
end

for slot12, slot13 in ipairs(string.split(GameSetting.guide_map.value2, ",")) do
	if string.split(slot13, "=")[1] and slot14[2] then
		-- Nothing
	end
end

GameSetting.guide_map.value2 = {
	[tonumber(slot14[1])] = tonumber(slot14[2])
}
slot9 = {}

for slot13, slot14 in pairs(WarchessHexCfg) do
	if slot14.id then
		slot15 = GridConfig.New()
		slot15.id = slot14.id
		slot15.walkable = slot14.move
		slot15.interact = slot14.interact
		slot15.explode = slot14.explode
		slot15.stonecanmove = slot14.stonecanmove
		slot15.stonecaninteract = slot14.stonecaninteract

		table.insert(slot9, slot15)
	end
end

WarchessHexCfg.AllGridConfig = slot9
slot10 = {}

for slot14, slot15 in pairs(WarchessLevelCfg.all) do
	if type(WarchessLevelCfg[slot15].trial_stage_list) == "table" then
		for slot20, slot21 in pairs(slot16.trial_stage_list) do
			slot10[slot21] = slot16.id_level
		end
	end
end

function GetChessLevelIDByStageID(slot0)
	return uv0[slot0]
end

slot11 = {}

for slot15, slot16 in pairs(BackHomeCfg) do
	if slot16.id then
		slot17 = DormMapCfg.New()
		slot17.id = slot16.id
		slot17.name = slot16.scene
		slot17.previewParams = DormCameraParams.New()
		slot17.editParams = DormCameraParams.New()
		slot18 = DormCameraCfg[slot16.camera_preview]
		slot17.previewParams.value = Vector2.New(slot18.value[1], slot18.value[2])
		slot17.previewParams.topRig = Vector2.New(slot18.toprig[1], slot18.toprig[2])
		slot17.previewParams.middleRig = Vector2.New(slot18.middlerig[1], slot18.middlerig[2])
		slot17.previewParams.bottomRig = Vector2.New(slot18.bottomrig[1], slot18.bottomrig[2])
		slot17.previewParams.topRigInterval = Vector2.New(slot18.toprig_interval[1], slot18.toprig_interval[2])
		slot19 = DormCameraCfg[slot16.camera_edit]
		slot17.editParams.value = Vector2.New(slot19.value[1], slot19.value[2])
		slot17.editParams.topRig = Vector2.New(slot19.toprig[1], slot19.toprig[2])
		slot17.editParams.middleRig = Vector2.New(slot19.middlerig[1], slot19.middlerig[2])
		slot17.editParams.bottomRig = Vector2.New(slot19.bottomrig[1], slot19.bottomrig[2])
		slot17.editParams.topRigInterval = Vector2.New(slot19.toprig_interval[1], slot19.toprig_interval[2])

		table.insert(slot11, slot17)
	end
end

BackHomeCfg.AllMapCfg = slot11
slot12 = {}

for slot16, slot17 in pairs(BackHomeFurniture) do
	if slot17.id and not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot17.id) then
		slot18 = FurnitureConfig.New()
		slot18.id = slot17.id
		slot18.prefab = slot17.model
		slot18.type = {
			slot17.display_type,
			slot17.sub_type or 0
		}
		slot18.width = slot17.title[1]
		slot18.height = slot17.title[2]
		slot18.depth = slot17.title[3] or 0

		table.insert(slot12, slot18)
	end
end

BackHomeFurniture.AllFurnitureConfig = slot12
slot13 = {
	[slot19.strengthen_desc[1]] = slot18
}

for slot17, slot18 in pairs(HeroSkillCfg.all) do
	if type(HeroSkillCfg[slot18].strengthen_desc) == "table" and slot19.strengthen_desc[1] then
		-- Nothing
	end
end

for slot17, slot18 in pairs(WeaponEffectCfg.all) do
	slot19 = WeaponEffectCfg[slot18]

	if slot18 > 0 and type(slot19.strengthen_description) == "table" and slot19.strengthen_description[1] then
		slot13[slot19.strengthen_description[1]] = WeaponServantCfg.get_id_list_by_effect[slot18][1]
	end
end

function getSkillIDOrServantID(slot0)
	return uv0[slot0]
end

slot14 = {}

for slot18, slot19 in pairs(AstrolabeEffectCfg.all) do
	if type(AstrolabeEffectCfg[slot19].equip_orange_desc) == "table" then
		for slot24, slot25 in pairs(slot20.equip_orange_desc) do
			if slot14[slot25[3]] == nil then
				slot14[slot25[3]] = {}
			end

			slot14[slot25[3]][slot25[1]] = slot20.id
		end
	end
end

function getAstrolabeID(slot0, slot1)
	if uv0[slot0] == nil then
		print("配置错误！检查AstrolabeEffectCfg和WeaponModuleEffectCfg")

		return
	end

	return uv0[slot0][slot1]
end

HERO_FRAGMENT_VALUE = 10000
slot18 = ItemConst.ITEM_TYPE.HERO

for slot18, slot19 in pairs(ItemCfg.get_id_list_by_type[slot18]) do
	ItemCfg[slot19].fragment = slot19 + HERO_FRAGMENT_VALUE
end

slot18 = ItemConst.ITEM_TYPE.HERO_PIECE

for slot18, slot19 in pairs(ItemCfg.get_id_list_by_type[slot18]) do
	ItemCfg[slot19].hero_id = slot19 - HERO_FRAGMENT_VALUE
end

for slot18, slot19 in pairs(ActivityPtCfg.all) do
	ItemCfg[ActivityPtCfg[slot19].item_id].activity_id = slot19
end

ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId = {}

for slot18, slot19 in ipairs(ActivityPtRepeatCfg.all) do
	if not ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[ActivityPtRepeatCfg[slot19].activity_id] then
		ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[slot20.activity_id] = {}
	end

	ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[slot20.activity_id][slot20.stage_id] = slot20
end

ActivityPt2Cfg.GetCfgFromActivityIdAndStageId = {}

for slot18, slot19 in ipairs(ActivityPt2Cfg.all) do
	if not ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[ActivityPt2Cfg[slot19].activity_id] then
		ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[slot20.activity_id] = {}
	end

	ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[slot20.activity_id][slot20.stage_id] = slot20
end

ShopListCfg.get_id_list_by_system_and_group = {}

for slot18, slot19 in pairs(ShopListCfg.get_id_list_by_system) do
	slot20 = {}

	for slot24, slot25 in ipairs(slot19) do
		if not slot20[ShopListCfg[slot25].display_group] then
			slot20[slot26.display_group] = {}
		end

		table.insert(slot20[slot26.display_group], slot26)
	end

	ShopListCfg.get_id_list_by_system_and_group[slot18] = slot20
end

function UpdateShopCfg(slot0)
	slot1 = slot0.shop_id

	for slot6, slot7 in ipairs(slot0.goods_list) do
		slot8 = {}

		for slot12, slot13 in ipairs(slot7.give_back_list or {}) do
			table.insert(slot8, {
				id = slot13.id,
				num = slot13.num
			})
		end

		ShopCfg[slot7.goods_id] = {
			taken_down = 0,
			position = 0,
			shop_refresh = 3,
			goods_id = slot7.goods_id,
			shop_id = slot1,
			shop_sort = slot7.shop_sort,
			give_id = slot7.give_id,
			description = slot7.description,
			give = slot7.give,
			cost_type = slot7.cost_type,
			cost_id = slot7.cost_id,
			cost = slot7.cost,
			cheap_cost_id = slot7.cheap_cost_id,
			cheap_cost = slot7.cheap_cost,
			discount = slot7.discount,
			limit_num = slot7.limit_num,
			level_limit = cleanProtoTable(slot7.level_limit),
			limit_display = slot7.limit_display,
			pre_goods_id = cleanProtoTable(slot7.pre_goods_id),
			refresh_cycle = slot7.refresh_cycle,
			open_time = {},
			close_time = {},
			is_limit_time_discount = slot7.is_limit_time_discount,
			cheap_open_time = {},
			cheap_close_time = {},
			tag = slot7.tag,
			backhome_tag = slot7.backhome_tag,
			next_goods_id = cleanProtoTable(slot7.next_goods_id),
			give_back_list = slot8,
			dlc = slot7.dlc
		}

		if slot7.open_time and slot7.open_time.year ~= 0 then
			slot9 = slot7.open_time
			ShopCfg[slot7.goods_id].open_time = {
				{
					slot9.year,
					slot9.month,
					slot9.day
				},
				{
					slot9.hour,
					slot9.minute,
					slot9.second
				}
			}
		end

		if slot7.close_time and slot7.close_time.year ~= 0 then
			slot9 = slot7.close_time
			ShopCfg[slot7.goods_id].close_time = {
				{
					slot9.year,
					slot9.month,
					slot9.day
				},
				{
					slot9.hour,
					slot9.minute,
					slot9.second
				}
			}
		end

		if slot7.cheap_open_time and slot7.cheap_open_time.year ~= 0 then
			slot9 = slot7.cheap_open_time
			ShopCfg[slot7.goods_id].cheap_open_time = {
				{
					slot9.year,
					slot9.month,
					slot9.day
				},
				{
					slot9.hour,
					slot9.minute,
					slot9.second
				}
			}
		end

		if slot7.cheap_close_time and slot7.cheap_close_time.year ~= 0 then
			slot9 = slot7.cheap_close_time
			ShopCfg[slot7.goods_id].cheap_close_time = {
				{
					slot9.year,
					slot9.month,
					slot9.day
				},
				{
					slot9.hour,
					slot9.minute,
					slot9.second
				}
			}
		end

		ShopCfg.get_id_list_by_shop_id[slot1] = ShopCfg.get_id_list_by_shop_id[slot1] or {}

		if not table.indexof(ShopCfg.get_id_list_by_shop_id[slot1]) then
			table.insert(ShopCfg.get_id_list_by_shop_id[slot1], slot7.goods_id)
		end

		ShopCfg.get_id_list_by_cost_id[slot7.cost_id] = ShopCfg.get_id_list_by_cost_id[slot7.cost_id] or {}

		if not table.indexof(ShopCfg.get_id_list_by_cost_id[slot7.cost_id]) then
			table.insert(ShopCfg.get_id_list_by_cost_id[slot7.cost_id], slot7.goods_id)
		end
	end
end

slot18 = ItemConst.ITEM_TYPE.SKIN_CHANGE

for slot18, slot19 in ipairs(ItemCfg.get_id_list_by_type[slot18]) do
	SkinCfg[ItemCfg[slot19].param[1]].change_item = slot19
end

function getChapterIDByStageID(slot0)
	return uv0[slot0]
end

function getChapterClientCfgByChapterID(slot0)
	return ChapterClientCfg[ChapterCfg[slot0].clientID]
end

function getChapterClientCfgByStageID(slot0)
	return getChapterClientCfgByChapterID(getChapterIDByStageID(slot0))
end

function getChapterAndSectionID(slot0)
	return slot1, ChapterCfg[getChapterIDByStageID(slot0)].section_id_list ~= "" and table.keyof(slot2.section_id_list, slot0) or 1
end

function getChapterToggle(slot0)
	return ChapterClientCfg[slot0].parentToggle or ChapterClientCfg[slot0].toggle
end

function getChapterDifficulty(slot0)
	if not ChapterCfg[BattleStageTools.GetChapterByStageId(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)] then
		error("错误的难度参数")
	end

	if slot2.difficulty == 1 then
		return GetTips("HARDLEVEL_EASY")
	elseif slot3 == 2 then
		return GetTips("HARDLEVEL_HARD_2")
	end
end

function getStageViaStoryID(slot0)
	return StoryCfg[slot0].trigger[2]
end

slot15 = {}

function getChapterListByDifficulty(slot0, slot1)
	slot1 = slot1 or "all"

	if not uv0[slot0] then
		slot2 = {}

		for slot7, slot8 in ipairs(ChapterCfg.get_id_list_by_type[slot0]) do
			slot2[slot10] = slot2[ChapterCfg[slot8].difficulty] or {}
			slot2.all = slot2.all or {}

			table.insert(slot2.all, slot8)
			table.insert(slot2[slot10], slot8)
		end

		uv0[slot0] = slot2
	end

	return uv0[slot0][slot1] or {}
end

slot16 = {}

for slot20, slot21 in pairs(StoryCfg) do
	if slot21.trigger[2] then
		if not slot16[slot22] then
			slot16[slot22] = {}
		end

		slot16[slot22][slot21.trigger[3]] = slot21.id
	end
end

function getStoryViaStageID(slot0, slot1)
	if not uv0[slot0] then
		return false
	end

	return uv0[slot0][slot1]
end

for slot20, slot21 in ipairs(WeaponServantCfg.all) do
	if ServantTools.GetServantSpecHero(slot21) then
		HeroCfg[slot22].spec_servant = slot21
	end
end

slot17 = {
	[ItemCfg[slot22].param[1]] = slot22
}

for slot21, slot22 in pairs(ItemCfg.get_id_list_by_type[14]) do
	-- Nothing
end

function getTicketIDBySkinID(slot0)
	return uv0[slot0]
end

TalentTreeCfg.get_id_list_by_activity_id_and_race = {}

for slot21, slot22 in pairs(TalentTreeCfg.get_id_list_by_activity_id) do
	TalentTreeCfg.get_id_list_by_activity_id_and_race[slot21] = {}
	slot23 = nil

	for slot27, slot28 in ipairs(slot22) do
		if TalentTreeCfg.get_id_list_by_activity_id_and_race[slot21][TalentTreeCfg[slot28].race] == nil then
			TalentTreeCfg.get_id_list_by_activity_id_and_race[slot21][slot23] = {}
		end

		table.insert(TalentTreeCfg.get_id_list_by_activity_id_and_race[slot21][slot23], slot28)
	end
end

slot21 = ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO

for slot21, slot22 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot21]) do
	if ActivityCultivateHeroCfg[slot22] then
		for slot27, slot28 in ipairs(ActivityCultivateHeroCfg[slot22].group) do
			for slot33, slot34 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[slot28]) do
				CultivateHeroTaskCfg[slot34].activity_id = slot22
			end
		end
	end
end

function slot18(slot0, slot1)
	if _G[slot0 .. "_" .. slot1] then
		setmetatable(slot2, {
			__index = _G[slot0]
		})

		_G[slot0] = slot2
	end
end

function DealAreaDifferenceCfg(slot0)
	if slot0 == nil or slot0 == "" or slot0 == "zh_cn" then
		return
	end

	if _G["WordVerifyCfg" .. slot0] then
		WordVerifyCfg = _G["WordVerifyCfg" .. slot0]
		WordVerifyCfg2 = _G["WordVerifyCfg2" .. slot0]
		WordVerifyCfg3 = _G["WordVerifyCfg3" .. slot0]
		WordVerifyCfg4 = _G["WordVerifyCfg4" .. slot0]
		WordVerifyCfg5 = _G["WordVerifyCfg5" .. slot0]
		WordVerifyCfg6 = _G["WordVerifyCfg6" .. slot0]
		WordVerifyCfg7 = _G["WordVerifyCfg7" .. slot0]
		WordVerifyCfg8 = _G["WordVerifyCfg8" .. slot0]
		WordVerifyCfg9 = _G["WordVerifyCfg9" .. slot0]
		WordVerifyCfg10 = _G["WordVerifyCfg10" .. slot0]
	end

	if _G["PaymentCfg" .. slot0] then
		PaymentCfg = _G["PaymentCfg" .. slot0]
	end

	if _G["TotalRechargeCfg" .. slot0] then
		TotalRechargeCfg = _G["TotalRechargeCfg" .. slot0]
	end

	if _G["RechargeCfg" .. slot0] then
		RechargeCfg = _G["RechargeCfg" .. slot0]
	end

	uv0("GameDisplayCfg", slot0)
end

function GetCfgDescription(slot0, slot1, slot2, slot3)
	if slot2 == nil then
		slot2 = 1
	end

	function slot4(slot0, slot1)
		if slot1 then
			return math.floor(slot0 * 10^slot1 + 0.5) / 10^slot1
		else
			return math.floor(slot0 + 0.5)
		end
	end

	if not DescriptionCfg[slot0] then
		print("错误, 找不到对应id的描述配置 " .. slot0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. slot0 .. " description.csv 表"
	end

	slot6 = GetI18NText(slot5.description)

	if slot1 == nil then
		slot1 = 1
	end

	if slot3 == nil then
		slot3 = slot5.maxLv
	end

	if slot5.type == 1 then
		if slot5.maxLv < slot1 or slot1 < 1 then
			print("错误, 找不到对应等级的描述配置 id = " .. slot0 .. " description.csv 表 level = " .. slot1)

			return "错误, 找不到对应等级的描述配置 id = " .. slot0 .. " description.csv 表 level = " .. slot1
		end

		if #slot5.param >= 1 then
			slot8 = {
				"0"
			}

			for slot12, slot13 in ipairs(slot7) do
				slot17 = slot13[4]
				slot19 = slot4(slot13[1] + slot13[2] * (slot1 - 1), slot2) % 1 == 0 and string.format("%.0f", slot18) .. slot17 or string.format("%." .. slot2 .. "f", slot18) .. slot17

				if slot13[3] and slot1 < slot3 then
					slot19 = GetTipsF("DESCRIPTION_NEXT_LEVEL", slot18, slot4(slot14 + slot15 * slot1, slot2) % 1 == 0 and string.format("%.0f", slot20) .. slot17 or string.format("%." .. slot2 .. "f", slot20) .. slot17)
				end

				table.insert(slot8, slot19)
			end

			return LuaExchangeHelper.GetDescription(slot6, slot8)
		else
			return slot6
		end
	else
		if not slot5.param[slot1] then
			print("错误, 找不到对应等级的描述配置 id = " .. slot0 .. " description.csv 表 level = " .. slot1)

			return "错误, 找不到对应等级的描述配置 id = " .. slot0 .. " description.csv 表 level = " .. slot1
		end

		if #slot7 > 1 then
			return LuaExchangeHelper.GetDescription(slot6, slot7)
		else
			return slot6
		end
	end
end

function GetCfgDescriptionWithValue(slot0, slot1)
	if not DescriptionCfg[slot0] then
		print("错误, 找不到对应id的描述配置 " .. slot0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. slot0 .. " description.csv 表"
	end

	slot3 = GetI18NText(slot2.description)

	if type(slot1) ~= "table" then
		table.insert({
			""
		}, slot1)
	else
		table.insertto(slot4, slot1)
	end

	return LuaExchangeHelper.GetDescription(slot3, slot4)
end

for slot23, slot24 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.POLYHEDRON_ACTIVITY] or {}) do
	ActivityCfg[slot24].policy_activity_id = slot24
	slot26 = {}
	slot27 = {}

	for slot31, slot32 in ipairs(ActivityCfg[slot24].sub_activity_list) do
		if ActivityCfg[slot32].activity_template == ActivityTemplateConst.TASK then
			if AssignmentCfg[AssignmentCfg.get_id_list_by_activity_id[slot32][1]].type == TaskConst.TASK_TYPE.POLYHEDRON_SEASON then
				slot26[#slot26 + 1] = slot32
			elseif AssignmentCfg[slot34[1]].type == TaskConst.TASK_TYPE.POLYHEDRON_ACHIEVEMENT then
				slot27[#slot27 + 1] = slot32
			end
		end
	end

	ActivityCfg[slot24].season_task_activity_list = slot26
	ActivityCfg[slot24].achievement_task_activity_list = slot27
end

ActivityReprintExCfg = {}

for slot23, slot24 in ipairs(ActivityReprintCfg.all) do
	for slot28, slot29 in pairs(ActivityReprintCfg[slot24]) do
		if slot28 ~= "id" then
			ActivityReprintExCfg[slot29] = {
				originActivityID = slot24
			}
		end
	end
end

HeroStarUpTemplateCfg.template_dic = {}

for slot23, slot24 in pairs(HeroStarUpTemplateCfg.get_id_list_by_template) do
	slot25 = {}

	for slot29, slot30 in ipairs(slot24) do
		slot25[slot33] = slot25[HeroStarSkillCfg[HeroStarUpTemplateCfg[slot30].skill_id].type] or {}
		slot25[slot33].stage_dic = slot25[slot33].stage_dic or {}
		slot25[slot33].stage_dic[HeroStarUpTemplateCfg[slot30].stage] = slot31
	end

	for slot29, slot30 in pairs(slot25) do
		slot31 = {}

		for slot36, slot37 in pairs(slot30.stage_dic) do
			slot31[#slot31 + 1] = slot36
		end

		table.sort(slot31)

		slot25[slot29].stage_list = slot31
	end

	HeroStarUpTemplateCfg.template_dic[slot23] = slot25
end

function HeroVoiceDescCfg.Get(slot0, slot1)
	return nullable(HeroVoiceDescCfg, nullable(HeroVoiceDescCfg.get_id_list_by_chara_id_subtitle_id, slot0, slot1, 1), "content")
end

function ConfigHelper_GetCfg(slot0, slot1, slot2)
	return _G[slot0][slot1][slot2]
end
