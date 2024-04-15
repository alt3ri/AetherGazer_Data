slot0 = singletonClass("AbyssData")
slot1, slot2, slot3 = nil

function slot0.Init(slot0)
	uv0 = {
		refresh_timestamp = 0,
		layer_reset_time = 0,
		history_max_layer = 1,
		stage_reset_time = 0,
		is_back = false,
		activity_id = 142021,
		last_version_max_unlock_layer = 1,
		got_layer_reward_list = {},
		layer_info_dic = {}
	}
	uv1 = {}
	uv2 = 1
end

function slot0.InitFromServer(slot0, slot1)
	uv0 = {
		is_back = slot1.is_back,
		history_max_layer = slot1.history_max_layer,
		layer_reset_time = slot1.layer_reset_time,
		stage_reset_time = slot1.stage_reset_time,
		refresh_timestamp = slot1.refresh_timestamp,
		last_version_max_unlock_layer = slot1.last_version_max_unlock_layer,
		got_layer_reward_list = {},
		layer_info_dic = {},
		activity_id = slot1.activity_id
	}

	for slot5, slot6 in ipairs(slot1.got_layer_reward_list) do
		table.insert(uv0.got_layer_reward_list, slot6)
	end

	for slot5, slot6 in ipairs(slot1.layer_info_list) do
		uv0.layer_info_dic[slot6.layer_id] = slot0:DecodeServerLayerInfo(slot6)
	end
end

function slot0.GetRefreshTimestamp(slot0)
	return uv0.refresh_timestamp
end

function slot0.DecodeServerLayerInfo(slot0, slot1)
	slot2 = {
		layer_id = slot1.layer_id,
		stage_info_list = {},
		stage_info_dic = {},
		boss_stage_info_list = {},
		boss_stage_info_dic = {}
	}

	for slot6, slot7 in ipairs(slot1.stage_info_list) do
		slot8 = {
			stage_id = slot7.stage_id,
			is_completed = slot7.is_completed
		}

		table.insert(slot2.stage_info_list, slot8)

		slot2.stage_info_dic[slot7.stage_id] = slot8
	end

	for slot6, slot7 in ipairs(slot1.boss_stage_info_list) do
		slot8 = {
			stage_id = slot7.stage_id,
			is_completed = slot7.is_completed,
			score = slot7.score,
			phase = slot7.phase,
			boss_hp_rate = slot7.boss_hp_rate
		}

		table.insert(slot2.boss_stage_info_list, slot8)

		slot2.boss_stage_info_dic[slot7.stage_id] = slot8
	end

	return slot2
end

function slot0.UpdateResetTime(slot0, slot1)
	uv0.layer_reset_time = slot1.layer_reset_time
	uv0.stage_reset_time = slot1.stage_reset_time
end

function slot0.UpdateBossInfo(slot0, slot1)
	slot2 = slot1.boss_stage_info
	slot4 = uv0.layer_info_dic[slot1.layer].boss_stage_info_dic[slot2.stage_id]
	slot4.score = slot2.score
	slot4.phase = slot2.phase
	slot4.boss_hp_rate = slot2.boss_hp_rate
	slot4.is_completed = slot2.is_completed
end

function slot0.CompleteNormalStage(slot0, slot1, slot2)
	uv0.layer_info_dic[slot1].stage_info_dic[slot2].is_completed = true
end

function slot0.UpdateLayerUnlock(slot0, slot1)
	uv0.history_max_layer = slot1.history_max_layer
	slot2 = slot0:DecodeServerLayerInfo(slot1.layer_info)
	uv0.layer_info_dic[slot2.layer_id] = slot2
end

function slot0.GetStageData(slot0, slot1, slot2)
	if not uv0.layer_info_dic[slot1] then
		return nil
	end

	if AbyssData:GetAbyssCfg(slot1).stage_list[slot2][1] == 3 then
		if slot3.boss_stage_info_dic[slot5[2]] ~= nil then
			return slot3.boss_stage_info_dic[slot5[2]]
		end
	elseif slot3.stage_info_dic[slot5[2]] ~= nil then
		return slot3.stage_info_dic[slot5[2]]
	end

	return nil
end

function slot0.IsLayerBonusGet(slot0, slot1)
	if table.indexof(uv0.got_layer_reward_list, slot1) then
		return true
	end

	return false
end

function slot0.IsLayerComplete(slot0, slot1)
	if not uv0.layer_info_dic[slot1] then
		return false
	end

	slot3 = AbyssData:GetAbyssCfg(slot1).stage_list

	for slot9, slot10 in pairs(slot2.stage_info_list or {}) do
		if slot10.is_completed then
			slot4 = 0 + 1
		end
	end

	for slot10, slot11 in pairs(slot2.boss_stage_info_list or {}) do
		if slot11.is_completed then
			slot4 = slot4 + 1
		end
	end

	return slot4 >= #slot3
end

function slot0.GetFirstLockLayer(slot0)
	for slot4, slot5 in ipairs(AbyssData:GetCurrentIdList()) do
		if not slot0:IsLayerUnlock(AbyssCfg[slot5].level) then
			return slot6
		end
	end

	return 1
end

function slot0.IsLayerChallenging(slot0, slot1)
	if not uv0.layer_info_dic[slot1] then
		return false
	end

	for slot7, slot8 in ipairs(slot2.stage_info_list or {}) do
		if slot8.is_completed then
			return true
		end
	end

	for slot8, slot9 in ipairs(slot2.boss_stage_info_list or {}) do
		if slot9.is_completed then
			return true
		else
			return #AbyssTools.GetStageBanHeroList(slot1, slot0:GetStageIndex(slot1, slot9.stage_id)) > 0
		end
	end

	return false
end

function slot0.IsLayerUnlock(slot0, slot1)
	if slot1 == 1 then
		return true
	end

	if uv0.last_version_max_unlock_layer > 1 and slot1 <= uv0.last_version_max_unlock_layer then
		return true
	end

	if uv0.layer_info_dic[slot1] ~= nil then
		return true
	end

	return false
end

function slot0.GetLayerStatus(slot0, slot1)
	if slot0:IsLayerComplete(slot1) then
		return 3
	end

	if slot0:IsLayerChallenging(slot1) then
		return 2
	end

	if slot0:IsLayerUnlock(slot1) then
		return 1
	end

	return 0
end

function slot0.GetStageScore(slot0, slot1, slot2)
	if not uv0.layer_info_dic[slot1] then
		return 0
	end

	slot5 = AbyssData:GetAbyssCfg(slot1).stage_list[slot2]

	if slot5[1] == 3 then
		if not slot3.boss_stage_info_dic[slot5[2]] then
			return 0
		end

		return slot7.score or 0
	else
		if not slot3.stage_info_dic[slot6] then
			return 0
		end

		slot8 = nil

		return (not slot7.is_completed or slot5[3]) and 0
	end
end

function slot0.GetLayerScore(slot0, slot1)
	for slot7, slot8 in ipairs(AbyssData:GetAbyssCfg(slot1).stage_list) do
		slot3 = 0 + slot0:GetStageScore(slot1, slot7)
	end

	return slot3
end

function slot0.GetCurrentLayer(slot0)
	for slot4 = #AbyssData:GetCurrentIdList(), 1, -1 do
		if slot0:IsLayerUnlock(AbyssCfg[AbyssData:GetCurrentIdList()[slot4]].level) then
			return slot6
		end
	end

	return 1
end

function slot0.GetLayerResetTime(slot0)
	return uv0.layer_reset_time
end

function slot0.GetLayerResetLimit(slot0)
	return GameSetting.abyss_layer_reset_time.value[1]
end

function slot0.GetStageResetTime(slot0)
	return uv0.stage_reset_time
end

function slot0.GetStageResetLimit(slot0)
	return GameSetting.abyss_stage_reset_time.value[1]
end

function slot0.GetAbyssUnlockLevel(slot0)
	return GameSetting.abyss_unlock_level.value[1]
end

function slot0.IsHeroInAbandonList(slot0, slot1, slot2)
	if table.indexof(slot2, slot1) then
		return slot2[slot3]
	end

	return 0
end

function slot0.IsHeroInLockList(slot0, slot1, slot2)
	if table.indexof(slot2, slot1) then
		return slot2[slot3]
	end

	return 0
end

function slot0.GetCanFightHeroList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(HeroData:GetHeroList()) do
		if slot8.unlock == 1 then
			table.insert(slot2, slot8.id)
		end
	end

	return slot2
end

function slot0.SetHeroTeam(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetCachedHero(slot0, slot1)
	slot2 = uv0[slot1] or {}

	return {
		slot2[1] or 0,
		slot2[2] or 0,
		slot2[3] or 0
	}
end

function slot0.GetMaxLayer(slot0)
	return uv0.history_max_layer
end

function slot0.GetCanGetLayers(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(AbyssData:GetCurrentIdList()) do
		if slot0:GetBonusStatus(AbyssCfg[slot6].level) == 1 then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.GetBonusStatus(slot0, slot1)
	if slot0:IsLayerBonusGet(slot1) then
		return 3
	elseif slot1 <= slot0:GetMaxLayer() then
		return 1
	else
		return 2
	end
end

function slot0.OnLayerBonusGet(slot0, slot1)
	table.insertto(uv0.got_layer_reward_list, slot1)
	manager.notify:Invoke(ABYSS_LAYER_BONUS_GET, slot1)
end

function slot0.HaveGetBonusNum(slot0)
	return #uv0.got_layer_reward_list
end

function slot0.OnResetStage(slot0, slot1, slot2, slot3)
	uv0.stage_reset_time = uv0.stage_reset_time - 1

	slot0:ResetStageInfo(slot1, slot2)
	slot0:RemoveLayerAbove(slot1)
	manager.notify:Invoke(ABYSS_STAGE_RESET_TIME_UPDATE, slot1, slot3)
end

function slot0.OnResetLayer(slot0, slot1)
	uv0.layer_reset_time = uv0.layer_reset_time - 1

	for slot6, slot7 in ipairs(AbyssData:GetAbyssCfg(slot1).stage_list) do
		slot0:ResetStageInfo(slot1, slot6)
		slot0:ClearTeamCache(slot7[2])
	end

	slot0:RemoveLayerAbove(slot1)
	manager.notify:Invoke(ABYSS_LAYER_RESET_TIME_UPDATE, slot1)
end

function slot0.RemoveLayerAbove(slot0, slot1)
	for slot6 = #AbyssData:GetCurrentIdList(), 1, -1 do
		if slot1 < AbyssCfg[slot2[slot6]].level and uv0.last_version_max_unlock_layer < slot8 then
			uv0.layer_info_dic[slot8] = nil
		end
	end
end

function slot0.ResetStageInfo(slot0, slot1, slot2)
	slot5 = AbyssData:GetAbyssCfg(slot1).stage_list[slot2]

	if slot5[1] == 3 then
		slot7 = uv0.layer_info_dic[slot1].boss_stage_info_dic[slot5[2]]
		slot7.score = 0
		slot7.is_completed = false
		slot7.phase = 1
		slot7.boss_hp_rate = 1000
	else
		slot3.stage_info_dic[slot6].is_completed = false
	end
end

function slot0.ClearTeamCache(slot0, slot1)
	uv0[slot1] = nil
end

function slot0.SetCurrentBossPhase(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCurrentBossPhase(slot0)
	return uv0 or 1
end

function slot0.GetBossTotalHp(slot0, slot1)
	if not AbyssBossHpCfg[slot1] then
		return 1
	end

	for slot7, slot8 in ipairs(slot2.boss_hp) do
		slot3 = 0 + slot8
	end

	return slot3
end

function slot0.GetPhaseBossHp(slot0, slot1, slot2)
	if not AbyssBossHpCfg[slot1] then
		return 1
	end

	return slot3.boss_hp[slot2] or 1
end

function slot0.ConvertPhaseBossHpToTotal(slot0, slot1, slot2, slot3)
	slot4 = slot0:GetPhaseBossHp(slot1, slot2) * slot3 / 1000

	if slot2 ~= #AbyssBossHpCfg[slot1].boss_hp then
		for slot8 = slot2 + 1, #AbyssBossHpCfg[slot1].boss_hp do
			slot4 = slot4 + AbyssBossHpCfg[slot1].boss_hp[slot8]
		end
	end

	return slot4
end

function slot0.OnReadBackFlag(slot0)
	uv0.is_back = false
end

function slot0.NeedTipBack(slot0)
	return uv0.is_back
end

function slot0.GetActivityId(slot0)
	if not uv0.activity_id then
		uv0.activity_id = AbyssCfg[AbyssCfg.all[1]].activity_id
	end

	return uv0.activity_id
end

function slot0.GetAbyssCfg(slot0, slot1)
	if not uv0.activity_id then
		uv0.activity_id = AbyssCfg[AbyssCfg.all[1]].activity_id
	end

	return AbyssCfg[AbyssCfg.get_id_list_by_activity_id[uv0.activity_id][slot1]]
end

function slot0.GetStageIndex(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(slot0:GetAbyssCfg(slot1).stage_list) do
		if slot9[2] == slot2 then
			return slot8
		end
	end

	return 1
end

function slot0.GetCurrentIdList(slot0)
	if not uv0.activity_id then
		uv0.activity_id = AbyssCfg[AbyssCfg.all[1]].activity_id
	end

	return AbyssCfg.get_id_list_by_activity_id[uv0.activity_id]
end

function slot0.HaveUpperLevelChallenging(slot0, slot1)
	for slot5, slot6 in pairs(uv0.layer_info_dic) do
		if slot1 < slot5 and AbyssData:GetLayerStatus(slot5) >= 2 then
			return true
		end
	end

	return false
end

return slot0
