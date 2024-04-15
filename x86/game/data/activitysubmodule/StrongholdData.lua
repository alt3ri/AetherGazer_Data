slot0 = singletonClass("StrongholdData")
slot1 = {}
slot2 = nil
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
	uv1 = nil
	uv2 = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.activity_id
	slot3 = {
		[slot8.id] = slot8.level
	}

	for slot7, slot8 in ipairs(slot1.skill_list) do
		-- Nothing
	end

	slot4 = {
		[slot9.id] = slot9.use_times
	}

	for slot8, slot9 in ipairs(slot1.stronghold_manual) do
		-- Nothing
	end

	for slot9, slot10 in ipairs(slot1.reward_id) do
		table.insert({}, slot10)
	end

	for slot10, slot11 in ipairs(slot1.exp_list) do
		-- Nothing
	end

	uv0[slot2] = {
		increase_dir = slot3,
		atlas_dir = slot4,
		reward_list = slot5,
		exp_weekly_dir = {
			[slot11.type] = slot11.exp
		}
	}
end

function slot0.InitStrongholdResultData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.player_list) do
		slot7 = tonumber(slot6.user_id)
		uv0[slot7] = {
			select_effect_num = slot6.select_effect_num
		}
	end

	if uv1[slot1.main_activity] then
		for slot7, slot8 in ipairs(slot1.exp_list) do
			-- Nothing
		end

		uv1[slot2].exp_weekly_dir = {
			[slot8.type] = slot8.exp
		}
	end
end

function slot0.GetStrongholdResultData(slot0, slot1)
	return uv0[slot1]
end

function slot0.GetStrongholdResultMaxEffectNum(slot0)
	for slot5, slot6 in pairs(uv0) do
		slot1 = math.max(0, slot6.select_effect_num)
	end

	return slot1
end

function slot0.UpgradeIncreaseLevel(slot0, slot1, slot2)
	if uv0[slot1] then
		slot3[slot2] = (uv0[slot1].increase_dir[slot2] or 0) + 1
	end
end

function slot0.GetIncreaseLevel(slot0, slot1, slot2)
	if uv0[slot1] then
		return uv0[slot1].increase_dir[slot2] or 0
	end

	return 0
end

function slot0.GetAllIncreaseLevel(slot0, slot1)
	if uv0[slot1] then
		for slot7, slot8 in pairs(uv0[slot1].increase_dir) do
			slot2 = 0 + slot8
		end

		return slot2
	end

	return 0
end

function slot0.ClearRoomExt(slot0)
	uv0 = nil
end

function slot0.InitRoomExt(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot1.stronghold_info) do
		slot9 = slot8.user_id
		slot10 = {}

		for slot14, slot15 in ipairs(slot8.skill_list) do
			table.insert(slot10, {
				id = slot15.id,
				level = slot15.level
			})
		end

		slot2[slot9] = {
			increase_list = slot10,
			room_skill_type = slot8.skill_type_id
		}
	end

	uv0 = {
		room_id = slot1.room_id,
		player_ext_list = slot2
	}
end

function slot0.GetRoomSkillTypes(slot0, slot1)
	if not uv0 or slot1 ~= uv0.room_id then
		return {}
	end

	slot2 = {}

	for slot6, slot7 in pairs(uv0.player_ext_list) do
		if slot7.room_skill_type ~= 0 then
			if not slot2[slot8] then
				slot2[slot8] = 1
			else
				slot2[slot8] = slot2[slot8] + 1
			end
		end
	end

	return slot2
end

function slot0.GetSelfRoomSkillType(slot0, slot1)
	if not uv0 or slot1 ~= uv0.room_id then
		return 0
	end

	return uv0.player_ext_list[PlayerData:GetPlayerInfo().userID] and uv0.player_ext_list[slot2].room_skill_type or 0
end

function slot0.GetRoomPlayerIncreaseList(slot0, slot1, slot2)
	if not uv0 or slot1 ~= uv0.room_id then
		return {}
	end

	return uv0.player_ext_list[slot2].increase_list
end

function slot0.GetStrongholdLevel(slot0, slot1)
	slot2 = 0

	if slot1 == 1 then
		slot2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_1)
	elseif slot1 == 2 then
		slot2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_2)
	elseif slot1 == 3 then
		slot2 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_STRONGHOLD_EXP_3)
	end

	slot4 = 1
	slot5 = #ActivityStrongholdLevelCfg.get_id_list_by_type[slot1]
	slot6 = -1

	while slot4 <= slot5 do
		if slot2 < ActivityStrongholdLevelCfg[slot3[slot4 + math.floor((slot5 - slot4) / 2)]].exp then
			slot5 = slot7 - 1
		else
			slot6 = slot7
			slot4 = slot7 + 1
		end
	end

	slot7 = slot3[slot6]
	slot8 = ActivityStrongholdLevelCfg[slot7]

	return slot7, slot8.level, slot2 - slot8.exp, slot8.point
end

function slot0.GetStrongholdLevelAndIncreasePoint(slot0, slot1)
	for slot6 = 1, 3 do
		slot7, slot8, slot9, slot10 = slot0:GetStrongholdLevel(slot6)
		slot2 = 0 + slot10
	end

	slot3 = 0

	if uv0[slot1] then
		for slot8, slot9 in pairs(uv0[slot1].increase_dir) do
			slot3 = slot3 + slot9
		end
	end

	return slot3, slot2
end

function slot0.GetUsePoint(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	slot3 = 0

	for slot7, slot8 in pairs(uv0[slot1].increase_dir) do
		for slot13, slot14 in ipairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[slot7]) do
			if ActivityStrongholdIncreaseCfg[slot14].skill_level <= slot8 then
				slot3 = slot3 + slot15.cost
			end
		end
	end

	return slot3
end

function slot0.GetRewardState(slot0, slot1, slot2)
	if table.indexof(uv0[slot1] and uv0[slot1].reward_list or {}, slot2) then
		return 2
	end

	slot4 = ActivityStrongholdRewardCfg[slot2]
	slot7, slot8, slot9, slot10 = slot0:GetStrongholdLevel(slot4.condition)

	if slot4.params[1] <= slot8 then
		return 0
	else
		return 1
	end
end

function slot0.UpdateReward(slot0, slot1, slot2)
	if uv0[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			table.insert(uv0[slot1].reward_list, slot7)
		end
	end
end

function slot0.GetWeeklyExp(slot0, slot1, slot2)
	if uv0[slot1] then
		return uv0[slot1].exp_weekly_dir[slot2] or 0
	else
		return 0
	end
end

function slot0.GetWeeklyMaxExp(slot0, slot1, slot2)
	if GameSetting["activity_stronghold_sequence_" .. slot2] then
		return slot3.value[1]
	else
		return 1000
	end
end

function slot0.GetAtlasUseCount(slot0, slot1, slot2)
	if uv0[slot1] then
		return uv0[slot1].atlas_dir[slot2] or 0
	end

	return 0
end

function slot0.UpgradeAltas(slot0, slot1, slot2)
	if uv0[slot1] and uv0[slot1].atlas_dir then
		if slot3[slot2] then
			slot3[slot2] = slot3[slot2] + 1
		else
			slot3[slot2] = 1
		end
	end
end

function slot0.GetRoomPlayerIncreaseRevive(slot0, slot1)
	slot4 = 0

	for slot8, slot9 in ipairs(slot0:GetRoomPlayerIncreaseList(slot1, PlayerData:GetPlayerInfo().userID)) do
		for slot16, slot17 in ipairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[slot9.id]) do
			if slot9.level == ActivityStrongholdIncreaseCfg[slot17].skill_level and slot18.effect_type == 2 then
				slot4 = slot4 + slot18.effect_params[1]
			end
		end
	end

	return slot4
end

function slot0.GetRoomAffixList(slot0, slot1, slot2)
	for slot8, slot9 in pairs(slot0:GetRoomSkillTypes(slot1)) do
		table.insert({}, slot0:GetSkillAffix(slot8, slot9))
	end

	for slot8, slot9 in ipairs(slot2) do
		slot10 = BattleTools.GetAffixPlayerTargetByPos(slot8)

		for slot16, slot17 in ipairs(slot0:GetRoomPlayerIncreaseList(slot1, slot9.playerID)) do
			for slot24, slot25 in ipairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[slot17.id]) do
				if slot17.level == ActivityStrongholdIncreaseCfg[slot25].skill_level and slot26.effect_type == 1 then
					table.insert(slot4, {
						slot26.effect_params[1],
						slot26.effect_params[2],
						slot10
					})

					break
				end
			end
		end
	end

	return slot4
end

function slot0.GetSkillAffix(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(ActivityStrongholdBuffCfg.get_id_list_by_type[slot1] or {}) do
		if slot2 == ActivityStrongholdBuffCfg[slot8].equip_num then
			return slot9.affix
		end
	end

	return nil
end

function slot0.GetSkillLimitLv(slot0)
	return 5
end

return slot0
