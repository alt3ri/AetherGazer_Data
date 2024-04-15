GuildActivityRankStruct = class("GuildActivityRankStruct")

function GuildActivityRankStruct.Ctor(slot0, slot1)
	slot0.score = slot1.damage
	slot0.user_id = slot1.uid
	slot0.nick = slot1.base_info.nick
	slot0.icon = slot1.base_info.icon
	slot0.icon_frame = slot1.base_info.icon_frame
	slot0.time_stamp = slot1.timestamp
	slot0.select_hero_id_list = {}

	for slot5, slot6 in ipairs(slot1.hero_list or {}) do
		table.insert(slot0.select_hero_id_list, slot6)
	end
end

slot0 = singletonClass("GuildActivitySPData")
slot1 = {}
slot2 = {}
slot3 = {}
slot4 = {}
slot5 = 0
slot6 = nil

function slot0.Init(slot0)
	uv0 = 0
	uv1 = {}
	uv2 = {
		benchmark_time = 0,
		last_receive_time = 0,
		current_grid = 0,
		is_init_hero_list = 0,
		spawn_id_list = {},
		grid_list = {},
		talent_list = {},
		grid_dic = {},
		hero_list = {},
		max_node_id = GuildActivitySPData:GetMaxNodeId()
	}
end

function slot0.InitActivityID(slot0, slot1)
	uv0 = slot1

	if not uv0 or uv0 == 0 then
		uv0 = ActivityConst.GUILD_ACTIVITY_SP_2_8
	end
end

function slot0.InitMainDataFromServer(slot0, slot1)
	uv0 = {
		current_grid = slot1.stay_id,
		last_receive_time = slot1.last_receive_time,
		is_init_hero_list = slot1.is_init_hero_list,
		benchmark_time = slot1.benchmark_time,
		hero_list = {},
		hero_dic = {}
	}

	for slot5, slot6 in ipairs(slot1.hero_list) do
		slot7 = {
			id = slot6.id,
			fatigue = slot6.fatigue,
			last_update_time = slot6.last_update_time
		}
		uv0.hero_dic[slot6.id] = slot7

		table.insert(uv0.hero_list, slot7)
	end

	uv0.spawn_id_list = {}

	for slot5, slot6 in ipairs(slot1.spawn_id_list) do
		if not table.indexof(uv0.spawn_id_list, slot6) then
			table.insert(uv0.spawn_id_list, slot6)
		end
	end

	function slot5(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(uv0.spawn_id_list, slot5)

	uv0.grid_dic = {}

	for slot5, slot6 in ipairs(slot1.grid_list) do
		slot7 = {
			id = slot6.id,
			is_occupied = slot6.is_occupied,
			dispatch_cat_id = slot6.dispatch_cat_id or 0,
			dispatch_time = slot6.dispatch_time or 0,
			elite_health_rate = slot6.elite_health_rate
		}
		uv0.grid_dic[slot7.id] = slot7
	end

	uv0.talent_list = {}

	for slot5, slot6 in ipairs(slot1.talent_list) do
		uv0.talent_list[slot6.id] = {}
		uv0.talent_list[slot6.id] = {
			id = slot6.id,
			level = slot6.level
		}
	end

	slot0:RefreshAffixRedPoint()

	uv0.receive_list = {}

	for slot5, slot6 in ipairs(slot1.receive_list) do
		table.insert(uv0.receive_list, slot6)
	end
end

function slot0.InitGridsDataFromServer(slot0, slot1)
	uv0 = {}
	slot2 = slot0:CreateDefaultDataList()
	slot3 = {
		[slot8.id] = slot8
	}

	for slot7, slot8 in ipairs(slot1) do
		-- Nothing
	end

	if ActivityClubSPCfg.get_id_list_by_activity[slot0:GetCurRunActivityID()] then
		for slot9, slot10 in ipairs(slot5) do
			if ActivityClubSPCfg[slot10].type ~= 0 then
				slot13 = nil
				slot13 = (not slot3[slot10] or {
					id = slot10,
					occupied_num = slot12.occupied_num,
					health = slot12.health or slot11.boss_score,
					dispatch_num = slot12.dispatch_num
				}) and {
					dispatch_num = 0,
					occupied_num = 0,
					id = slot10,
					health = slot11.boss_score
				}
				uv0[slot13.id] = slot13
				slot14 = slot0:CreateNodeData(slot13.id)
				slot14.occupied_num = slot13.occupied_num
				slot14.health = math.floor(slot13.health / 100)

				if slot14.health == 0 and slot13.health > 0 then
					slot14.health = 1
				end

				if uv1.grid_dic[slot13.id] and uv1.grid_dic[slot13.id].is_occupied > 0 then
					slot14.is_occupied = uv1.grid_dic[slot13.id].is_occupied
				else
					slot14.is_occupied = 0
				end

				if uv1.grid_dic[slot13.id] and uv1.grid_dic[slot13.id].elite_health_rate > 0 then
					slot14.eliteHealthRate = uv1.grid_dic[slot13.id].elite_health_rate
				else
					slot14.eliteHealthRate = 0
				end

				if uv1.grid_dic[slot13.id] and uv1.grid_dic[slot13.id].dispatch_cat_id > 0 then
					slot14.myDispatchCatId = uv1.grid_dic[slot13.id].dispatch_cat_id
				else
					slot14.myDispatchCatId = 0
				end

				if uv1.grid_dic[slot13.id] and uv1.grid_dic[slot13.id].dispatch_time > 0 then
					slot14.myDispatchTime = uv1.grid_dic[slot13.id].dispatch_time
				else
					slot14.myDispatchTime = 0
				end

				slot14.dispatch_num = slot13.dispatch_num

				slot2.dataList:Add(slot14)
			end
		end

		manager.notify:Invoke(INIT_GUILD_ACTIVITY_SP_MAIN_DATA, {})
		slot0:UpdateBigBossStatus(slot2)

		if GuildActivitySPLuaBridge.GetManager() then
			GuildActivitySPLuaBridge.GetManager():UpdateNodeData(slot2, true)
		end
	end
end

function slot0.InitFightRecordFromServer(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(uv0, {
			uid = slot6.uid,
			icon = slot6.icon,
			icon_frame = slot6.icon_frame,
			name = slot6.name,
			damage = slot6.damage,
			hero_list = slot6.hero_list,
			timestamp = slot6.timestamp
		})
	end

	table.sort(uv0, function (slot0, slot1)
		return slot1.damage < slot0.damage
	end)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_FIGHT_RECORD_GET, {})
end

function slot0.UpdateSelfGridDataFromServer(slot0, slot1)
	if slot1.spawn_id_list ~= nil and #slot1.spawn_id_list > 0 then
		for slot5, slot6 in ipairs(slot1.spawn_id_list) do
			if not table.indexof(uv0.spawn_id_list, slot6) then
				table.insert(uv0.spawn_id_list, slot6)
			end
		end

		table.sort(uv0.spawn_id_list, function (slot0, slot1)
			return slot0 < slot1
		end)
		manager.notify:Invoke(GUILD_ACTIVITY_SP_SPAWN_ID_UPDATE, {})
	end

	slot2 = slot0:CreateDefaultDataList()
	slot4 = {}

	for slot8, slot9 in ipairs(slot1.grid_list) do
		table.insert(slot4, slot9.id)

		if slot1.type == 1 then
			if ({
				id = slot9.id,
				is_occupied = slot9.is_occupied,
				dispatch_cat_id = slot9.dispatch_cat_id or 0,
				dispatch_time = slot9.dispatch_time or 0,
				elite_health_rate = slot9.elite_health_rate
			}).id == 21128 then
				CustomLog.Log(debug.traceback(string.format("21128 is occupied = %d", slot10.is_occupied)))
			end

			uv0.grid_dic[slot9.id] = slot10

			if uv1[slot9.id] then
				slot12 = slot0:CreateNodeData(slot9.id)
				slot12.occupied_num = slot11.occupied_num
				slot12.health = math.floor(slot11.health / 100)

				if slot12.health == 0 and slot11.health > 0 then
					slot12.health = 1
				end

				if uv0.grid_dic[slot9.id] and uv0.grid_dic[slot9.id].is_occupied > 0 then
					slot12.is_occupied = uv0.grid_dic[slot9.id].is_occupied
				else
					slot12.is_occupied = 0
				end

				if uv0.grid_dic[slot9.id] and uv0.grid_dic[slot9.id].elite_health_rate > 0 then
					slot12.eliteHealthRate = uv0.grid_dic[slot9.id].elite_health_rate
				else
					slot12.eliteHealthRate = 0
				end

				if uv0.grid_dic[slot9.id] and uv0.grid_dic[slot9.id].dispatch_cat_id > 0 then
					slot12.myDispatchCatId = uv0.grid_dic[slot9.id].dispatch_cat_id
				else
					slot12.myDispatchCatId = 0
				end

				if uv0.grid_dic[slot9.id] and uv0.grid_dic[slot9.id].dispatch_time > 0 then
					slot12.myDispatchTime = uv0.grid_dic[slot9.id].dispatch_time
				else
					slot12.myDispatchTime = 0
				end

				slot12.dispatch_num = slot11.dispatch_num

				slot2.dataList:Add(slot12)
			end
		else
			uv0.grid_dic[slot9.id] = nil

			if uv1[slot9.id] then
				slot11 = slot0:CreateNodeData(slot9.id)
				slot11.is_occupied = 0
				slot11.eliteHealthRate = 0
				slot11.occupied_num = slot10.occupied_num
				slot11.health = slot10.health
				slot11.myOccupiedTimestamp = 0
				slot11.processingType = 0
				slot11.myProcessingTimestamp = 0
				slot11.dispatch_num = 0
				slot11.myDispatchCatId = 0
				slot11.myDispatchTime = 0

				slot2.dataList:Add(slot11)
			end
		end
	end

	slot0:UpdateBigBossStatus(slot2)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, slot4)

	if GuildActivitySPLuaBridge.GetManager() then
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(slot2)
	end
end

function slot0.UpdateGridsDataFromServer(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = {
			id = slot7.id,
			occupied_num = slot7.occupied_num,
			health = slot7.health or ActivityClubSPCfg[slot7.id].boss_score,
			dispatch_num = slot7.dispatch_num
		}

		table.insert(slot2, slot8.id)

		uv0[slot8.id] = slot8
	end

	manager.notify:Invoke(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, slot2)

	if GuildActivitySPLuaBridge.GetManager() then
		slot3 = slot0:CreateDefaultDataList()

		for slot7, slot8 in ipairs(slot1) do
			slot9 = slot0:CreateNodeData(slot8.id)
			slot9.occupied_num = slot8.occupied_num
			slot9.health = math.floor(slot8.health / 100)

			if slot9.health == 0 and slot8.health > 0 then
				slot9.health = 1
			end

			if uv1.grid_dic[slot8.id] and uv1.grid_dic[slot8.id].is_occupied > 0 then
				slot9.is_occupied = uv1.grid_dic[slot8.id].is_occupied
			else
				slot9.is_occupied = 0
			end

			if uv1.grid_dic[slot8.id] and uv1.grid_dic[slot8.id].elite_health_rate > 0 then
				slot9.eliteHealthRate = uv1.grid_dic[slot8.id].elite_health_rate
			else
				slot9.eliteHealthRate = 0
			end

			if uv1.grid_dic[slot8.id] and uv1.grid_dic[slot8.id].dispatch_cat_id > 0 then
				slot9.myDispatchCatId = uv1.grid_dic[slot8.id].dispatch_cat_id
			else
				slot9.myDispatchCatId = 0
			end

			if uv1.grid_dic[slot8.id] and uv1.grid_dic[slot8.id].dispatch_time > 0 then
				slot9.myDispatchTime = uv1.grid_dic[slot8.id].dispatch_time
			else
				slot9.myDispatchTime = 0
			end

			slot9.dispatch_num = slot8.dispatch_num

			slot3.dataList:Add(slot9)
		end

		slot0:UpdateBigBossStatus(slot3)
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(slot3)
	end
end

function slot0.GetSpawnIdList(slot0)
	return uv0.spawn_id_list
end

function slot0.GetFightRecords(slot0)
	return uv0
end

function slot0.CreateNodeData(slot0, slot1)
	slot2 = GuildActivitySPNodeData.New()
	slot3 = ActivityClubSPCfg[slot1]
	slot2.id = slot1
	slot2.map_id = slot3.map_id
	slot2.type = slot3.type
	slot2.level = slot3.level
	slot2.stage_id = slot3.stage_id
	slot2.vitality_cost = slot3.vitality_cost
	slot2.token_get = slot3.token_get
	slot2.boss_score = math.floor(slot3.boss_score / 100)
	slot2.boss_stage_hp = slot3.boss_stage_hp
	slot2.boss_name = slot3.boss_name

	return slot2
end

function slot0.UpdateBigBossStatus(slot0, slot1)
	for slot5, slot6 in pairs(ActivityClubSPCfg.get_id_list_by_map_id) do
		if slot0:IsAllLittleBossPass(slot5) > 0 then
			slot1.selfData.bigBossUnlockMapList:Add(slot5)
		end
	end
end

function slot0.CreateDefaultDataList(slot0)
	slot1 = GuildActivitySPNodeDataList.New()
	slot1.selfData.benchmark_time = uv0.benchmark_time
	slot1.selfData.coinRefreshMinutes = GameSetting.activity_club_sp_coin_calculate_time.value[1]
	slot1.selfData.curNode = uv0.current_grid
	slot1.selfData.mapCount = #ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()]
	slot1.selfData.myLastReceiveTimestamp = uv0.last_receive_time
	slot5 = GuildActivitySPData
	slot7 = slot5
	slot1.selfData.maxNodeId = slot5.GetMaxNodeId(slot7)

	for slot7, slot8 in ipairs(uv0.spawn_id_list) do
		slot1.selfData.spawnNodeIdList:Add(slot8)
	end

	for slot8, slot9 in pairs(ActivityClubSPCfg.get_id_list_by_map_id) do
		slot13 = ActivityClubSPCfg.get_id_list_by_map_id[slot8]
	end

	for slot8, slot9 in ipairs({
		[table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], slot8)] = slot13[#slot13]
	}) do
		slot1.selfData.bossIdList:Add(slot9)
	end

	return slot1
end

function slot0.OnGetCoin(slot0, slot1)
	uv0.last_receive_time = slot1

	slot0:UpdateBigBossStatus(slot0:CreateDefaultDataList())

	if GuildActivitySPLuaBridge.GetManager() then
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(slot2)
	end
end

function slot0.GetCurMainActivityID(slot0)
	return uv0
end

function slot0.GetCurRunActivityID(slot0)
	if GuildActivitySPTools.GetCurActivityIDInfo(uv0) then
		return slot1.start
	end
end

function slot0.OnSetFightMember(slot0)
	uv0.is_init_hero_list = 1
end

function slot0.GetCurrentGrid(slot0)
	return uv0.current_grid
end

function slot0.SetCurrentGrid(slot0, slot1)
	uv0.current_grid = slot1
end

function slot0.SetIsSignFromServer(slot0, slot1)
	uv0 = slot1
end

function slot0.SignUpSuccess(slot0)
	uv0 = 1
end

function slot0.UpdateGuildActivityHeroes(slot0, slot1)
	uv0.hero_dic = {}
	uv0.hero_list = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			id = slot6.id,
			fatigue = slot6.fatigue,
			last_update_time = slot6.last_update_time
		}
		uv0.hero_dic[slot6.id] = slot7

		table.insert(uv0.hero_list, slot7)
	end

	manager.notify:Invoke(GUILD_ACTIVITY_SP_HERO_LIST_UPDATE, {})
end

function slot0.IsFirstConfigFightRole(slot0)
	return uv0.is_init_hero_list == 0
end

function slot0.GetMyOccupiedNum(slot0)
	for slot5, slot6 in pairs(uv0.grid_dic) do
		if slot6.is_occupied > 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.GetMaxFightHeroCount(slot0)
	return ActivityClubSPLevelSettingCfg[slot0:GetCurRateID(GuildActivitySPData:GetCurRunActivityID())].max_hero
end

function slot0.GetMaxOccupyCount(slot0)
	return 99999
end

function slot0.GetFightHeroById(slot0, slot1)
	return uv0.hero_dic[slot1]
end

function slot0.GetHeroFatigue(slot0, slot1)
	if slot0:IsFirstConfigFightRole() then
		return GameSetting.activity_club_sp_hero_fatigue_max.value[1]
	end

	slot3 = uv0.benchmark_time

	if uv0.hero_dic[slot1] then
		slot6 = GameSetting.activity_club_sp_hero_fatigue_recovery.value[1] * 60

		return math.min(uv0.hero_dic[slot1].fatigue + math.floor((manager.time:GetServerTime() - slot3) / slot6) - math.floor((uv0.hero_dic[slot1].last_update_time - slot3) / slot6), GameSetting.activity_club_sp_hero_fatigue_max.value[1])
	else
		return 0
	end
end

function slot0.GetFightHeroList(slot0)
	return uv0.hero_list
end

function slot0.GetMaxNodeId(slot0)
	if ActivityClubSPMapCfg.get_id_list_by_activity[slot0:GetCurRunActivityID()] and ActivityClubSPCfg.get_id_list_by_map_id[slot2[#slot2]] then
		for slot8, slot9 in ipairs(slot4) do
			if ActivityClubSPCfg[slot9].type == 4 then
				return slot9
			end
		end
	end
end

function slot0.GetTotalCoinToGet(slot0, slot1)
	for slot6, slot7 in pairs(uv0.grid_dic) do
		if slot7.dispatch_time > 0 then
			slot12 = uv0.benchmark_time
			slot14 = GameSetting.activity_club_sp_coin_calculate_time.value[1] * 60
			slot2 = 0 + (math.floor((manager.time:GetServerTime() - slot12) / slot14) - math.floor((math.max(uv0.last_receive_time, slot7.dispatch_time) - slot12) / slot14)) * ActivityClubSPCfg[slot7.id].token_get / (3600 / slot14)
		end
	end

	return slot2
end

function slot0.GetCoinGain(slot0)
	for slot5, slot6 in pairs(uv0.grid_dic) do
		slot7 = ActivityClubSPCfg[slot6.id]

		if slot6.dispatch_cat_id > 0 and (slot7.type == 1 or slot7.type == 2) then
			slot1 = 0 + slot7.token_get
		end
	end

	return slot1
end

function slot0.GetLastReceiveTimestamp(slot0)
	return uv0.last_receive_time
end

function slot0.GetSelfNodeData(slot0, slot1)
	return uv0.grid_dic[slot1]
end

function slot0.GetNodeData(slot0, slot1)
	return uv0[slot1]
end

function slot0.CanTakeOnFightNum(slot0)
	return ActivityClubSPLevelSettingCfg[slot0:GetCurRateID(uv0:GetCurRunActivityID())].max_hero
end

function slot0.CheckHeroFightIsFull(slot0)
	slot1 = true

	for slot5, slot6 in ipairs(uv0.hero_list) do
		if slot0:GetHeroFatigue(slot6.id) < GameSetting.activity_club_sp_hero_fatigue_max.value[1] then
			slot1 = false

			break
		end
	end

	return slot1
end

function slot0.HaveTakeOnFightNum(slot0)
	return #uv0.hero_list
end

function slot0.IsMyOccupiedNode(slot0, slot1)
	return uv0.grid_dic[slot1] ~= nil and uv0.grid_dic[slot1].is_occupied > 0
end

function slot0.IsNodeCanReach(slot0, slot1)
	return slot0:HandleNode1(slot1, slot1, {}, {})
end

function slot0.HandleNode(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ActivityClubSPCfg[slot2]

	if slot2 == slot1 then
		for slot10 = #slot3, 1, -1 do
			table.insert(slot5, slot3[slot10])
		end

		table.insert(slot5, slot2)

		return true
	end

	if table.indexof(slot3, slot2) then
		return false
	end

	if table.indexof(slot4, slot2) then
		return false
	end

	slot7 = false

	if slot6.type == 0 and table.indexof(uv0.spawn_id_list, slot2) then
		slot7 = true
	elseif slot6.type == 3 then
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], slot6.map_id) < #uv0.spawn_id_list then
			slot7 = true
		end
	elseif uv1[slot2] and uv1[slot2].occupied_num > 0 then
		slot7 = true
	end

	if not slot7 then
		return false
	end

	table.insert(slot3, slot2)

	slot8 = false

	for slot12, slot13 in ipairs(slot6.neighbours) do
		if slot0:HandleNode(slot1, slot13, slot3, slot4, slot5) then
			slot8 = true

			break
		end
	end

	return slot8
end

function slot0.HandleNode1(slot0, slot1, slot2, slot3, slot4)
	slot6 = uv0.grid_dic[slot2] and uv0.grid_dic[slot2].is_occupied > 0

	if ActivityClubSPCfg[slot2].type == 4 then
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], slot5.map_id) < #uv0.spawn_id_list then
			slot6 = true
		end
	elseif slot5.type == 3 and uv1[slot2] and uv1[slot2].health <= 0 then
		slot6 = true
	elseif slot5.type == 0 and table.indexof(uv0.spawn_id_list, slot2) then
		slot6 = true
	end

	if slot6 then
		return true
	end

	if table.indexof(slot3, slot2) then
		return false
	end

	if table.indexof(slot4, slot2) then
		return false
	end

	slot7 = false

	if slot1 == slot2 and slot5.type ~= 0 then
		slot7 = true
	elseif slot5.type == 0 and table.indexof(uv0.spawn_id_list, slot2) then
		slot7 = true
	elseif slot5.type == 4 then
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], slot5.map_id) < #uv0.spawn_id_list then
			return true
		end
	elseif uv0.grid_dic[slot2] and uv0.grid_dic[slot2].is_occupied > 0 then
		slot7 = true
	end

	if not slot7 then
		return false
	end

	table.insert(slot3, slot2)

	slot8 = false

	for slot12, slot13 in ipairs(slot5.neighbours) do
		if slot0:HandleNode1(slot1, slot13, slot3, slot4) then
			slot8 = true

			break
		end
	end

	return slot8
end

function slot0.GetMySpawnNodeId(slot0, slot1)
	return uv0.spawn_id_list[slot1]
end

function slot0.HaveRegister(slot0)
	return uv0 > 0
end

function slot0.OnGridGiveUp(slot0, slot1)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_ON_GRID_CANCEL_OCCUPYING, slot1)
end

function slot0.OnGridCancelOccupy(slot0, slot1)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_ON_GRID_CANCEL_OCCUPYING, slot1)
end

function slot0.HaveBossBeKilled(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[slot1]) do
		if ActivityClubSPCfg[slot7].type == 3 and uv0[slot7] and uv0[slot7].occupied_num > 0 then
			return true
		end
	end

	return false
end

function slot0.HaveBigBossBeKilled(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[slot1]) do
		if ActivityClubSPCfg[slot7].type == 4 and uv0[slot7] and uv0[slot7].occupied_num > 0 then
			return true
		end
	end

	return false
end

function slot0.GetBigBossNode(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[slot1]) do
		if ActivityClubSPCfg[slot7].type == 4 then
			return slot7, uv0[slot7]
		end
	end

	return 0, nil
end

function slot0.GetCurRateID(slot0, slot1, slot2)
	slot3 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[slot1]
	slot4 = slot3[1]

	for slot8 = 2, #slot3 do
		slot10 = true

		for slot14, slot15 in ipairs(ActivityClubSPLevelSettingCfg[slot3[slot8]].condition) do
			if not IsConditionAchieved(slot15) then
				break
			end
		end

		if not slot10 then
			break
		end

		slot4 = slot3[slot8]
	end

	slot0.curRateID_ = slot4

	if slot2 == true and slot0.preRateID_ == nil then
		slot0.preRateID_ = slot4
	end

	return slot0.curRateID_, slot0.preRateID_
end

function slot0.CheckRateUpgrade(slot0, slot1)
	slot2, slot3 = slot0:GetCurRateID(slot1, true)

	if slot2 ~= ActivityClubSPLevelSettingCfg.get_id_list_by_activity[slot1][1] and slot2 ~= slot3 then
		slot0.preRateID_ = slot2

		return true, slot2
	end

	return false
end

function slot0.GetSortedRateIDList(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot6 = {}

	for slot10 = 2, #ActivityClubSPLevelSettingCfg.get_id_list_by_activity[slot1] do
		slot6[#slot6 + 1] = slot5[slot10]
	end

	for slot13, slot14 in ipairs(slot6) do
		if ActivityClubSPLevelSettingCfg[slot14].user_level <= ActivityClubSPLevelSettingCfg[slot0:GetCurRateID(slot1)].user_level and table.keyof({}, ActivityClubSPLevelSettingCfg[slot14].user_level) == nil then
			table.insert(slot2, slot14)
		elseif slot9 < ActivityClubSPLevelSettingCfg[slot14].user_level then
			table.insert(slot3, slot14)
		elseif table.keyof(slot7, ActivityClubSPLevelSettingCfg[slot14].user_level) ~= nil then
			table.insert(slot4, slot14)
		end
	end

	table.insertto(slot2, slot3)
	table.insertto(slot2, slot4)

	return slot2
end

function slot0.SetReceivedList(slot0, slot1, slot2)
	table.insert(uv0.receive_list, ActivityClubSPLevelSettingCfg[slot2].user_level)
	slot0:RefreshRateRedPoint(slot1)
end

function slot0.GetReceivedList(slot0)
	return uv0.receive_list
end

function slot0.RefreshRateRedPoint(slot0, slot1)
	slot5 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_RATE, slot1)
	slot6 = nil

	for slot10 = 2, #ActivityClubSPLevelSettingCfg.get_id_list_by_activity[slot1] do
		if ActivityClubSPLevelSettingCfg[slot2[slot10]].user_level <= ActivityClubSPLevelSettingCfg[slot0:GetCurRateID(slot1)].user_level then
			manager.redPoint:setTip(slot5, 1)

			return
		end
	end

	manager.redPoint:setTip(slot5, 0)
end

function slot0.GetSelectRaceID(slot0, slot1)
	return getData("Guild_Activity_SelectRaceID", tostring(slot1))
end

function slot0.SetSelectRaceID(slot0, slot1, slot2)
	saveData("Guild_Activity_SelectRaceID", tostring(slot1), slot2)
end

function slot0.GetSelectAffixID(slot0, slot1, slot2)
	return getData(string.format("Guild_Activity_%d_SelectAffixID", slot1), tostring(slot2))
end

function slot0.SetSelectAffixID(slot0, slot1, slot2, slot3)
	saveData(string.format("Guild_Activity_%d_SelectAffixID", slot1), tostring(slot2), slot3)
end

function slot0.GetUnLockAffixList(slot0)
	return uv0.talent_list
end

function slot0.UpgradeAffix(slot0, slot1, slot2)
	if uv0.talent_list[slot2] == nil then
		uv0.talent_list[slot2] = {
			level = 1,
			id = slot2
		}
	else
		uv0.talent_list[slot2].level = uv0.talent_list[slot2].level + 1 <= TalentTreeCfg[slot2].max_level and slot3 or slot4
	end

	slot0:RefreshAffixRedPoint()
end

function slot0.RefreshAffixRedPoint(slot0)
	if TalentTreeCfg.get_id_list_by_activity_id[GuildActivitySPTools.GetCurActivityIDInfo(uv0).start] then
		slot6, slot7, slot8 = nil
		slot9 = false

		for slot13, slot14 in ipairs(slot2) do
			slot6 = uv1.talent_list[slot14] and uv1.talent_list[slot14].level + 1 or 1

			if ((TalentTreeCfg[slot14].cost[slot6] == nil or TalentTreeCfg[slot14].cost[slot6][2]) and -1) ~= -1 and slot7 <= (ItemTools.getItemNum(TalentTreeCfg[slot2[1]].cost[1][1]) or 0) then
				manager.redPoint:setTip(string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, slot1, TalentTreeCfg[slot14].race, slot14), 1)

				slot9 = true
			else
				manager.redPoint:setTip(slot8, 0)
			end
		end

		return slot9
	end
end

function slot0.SetTempEffectiveAffixList(slot0, slot1)
	slot0.effectiveAffixIDList_ = slot1
end

function slot0.GetTempEffectiveAffixList(slot0, slot1)
	return slot0.effectiveAffixIDList_ or {}
end

function slot0.IsAllAffixMax(slot0, slot1)
	if TalentTreeCfg.get_id_list_by_activity_id[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			if uv0.talent_list[slot7] then
				if uv0.talent_list[slot7].level < TalentTreeCfg[slot7].max_level then
					return false
				end
			else
				return false
			end
		end

		return true
	end
end

function slot0.SetRankData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.records or {}) do
		table.insert(slot2, GuildActivityRankStruct.New(slot7))
	end

	uv0 = {
		rankList = slot2
	}

	function slot6(slot0, slot1)
		if slot0.score == slot1.score then
			if slot0.time_stamp == slot1.time_stamp then
				return slot1.user_id < slot0.user_id
			else
				return slot0.time_stamp < slot1.time_stamp
			end
		else
			return slot1.score < slot0.score
		end
	end

	table.sort(uv0.rankList, slot6)

	for slot6, slot7 in ipairs(uv0.rankList) do
		slot7.rank = slot6
	end
end

function slot0.GetRankList(slot0)
	return uv0.rankList or {}
end

function slot0.OnDispatch(slot0, slot1, slot2)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_DISPATCHED, slot1, slot2)
end

function slot0.GetDispatchCatNum(slot0)
	for slot5, slot6 in pairs(uv0.grid_dic) do
		if slot6.dispatch_cat_id and slot6.dispatch_cat_id ~= 0 then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.OnCancelDispatch(slot0, slot1)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, slot1)
end

function slot0.IsDispatched(slot0, slot1)
	return slot0:GetSelfNodeData(slot1).dispatch_cat_id > 0
end

function slot0.IsDispatchMax(slot0, slot1)
	return slot0:GetNodeData(slot1).dispatch_num >= 10
end

function slot0.GetAllDispatchCatList(slot0)
	return ActivityClubSPLevelSettingCfg[ActivityClubSPLevelSettingCfg.all[#ActivityClubSPLevelSettingCfg.all]].dispatch
end

function slot0.GetCanDispatchCatList(slot0)
	return ActivityClubSPLevelSettingCfg[slot0:GetCurRateID(uv0:GetCurRunActivityID())].dispatch
end

function slot0.IsCatDispatched(slot0, slot1)
	for slot5, slot6 in pairs(uv0.grid_dic) do
		if slot6.dispatch_cat_id == slot1 then
			return true, slot6.id
		end
	end

	return false, 0
end

function slot0.IsAllLittleBossPass(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[slot1]) do
		if ActivityClubSPCfg[slot7].type == 3 then
			if slot0:GetNodeData(slot7) == nil then
				return 0
			end

			if slot0:GetNodeData(slot7).health > 0 then
				return 0
			end
		end
	end

	return 1
end

function slot0.GetNowStage(slot0)
	if uv0:GetCurRunActivityID() and ActivityData:GetActivityIsOpen(slot1) then
		slot3 = ActivityData:GetActivityData(slot1)
		slot6 = slot3.stopTime

		if slot3.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
			return 2
		else
			return 1
		end
	else
		return 0
	end
end

function slot0.GetCatUnlockLevel(slot0, slot1)
	for slot5, slot6 in ipairs(ActivityClubSPLevelSettingCfg.all) do
		if table.indexof(ActivityClubSPLevelSettingCfg[slot6].dispatch, slot1) then
			return slot7.user_level
		end
	end
end

return slot0
