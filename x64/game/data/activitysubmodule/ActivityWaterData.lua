slot0 = singletonClass("ActivityWaterData")
slot1 = {}
slot2 = {}
slot3 = {}

function slot0.Init(slot0)
	uv0 = {}
end

function slot0.ParseCompetitionData(slot0, slot1)
	return {
		competition_id = slot1.competition_id,
		assistance_process = slot1.assistance_process
	}
end

function slot0.ParseHistoryScheduleData(slot0, slot1)
	slot2 = {
		schedule_id = slot1.schedule_id,
		competition_list = {},
		selected_contestant_id = slot1.selected_contestant_id,
		is_success = slot1.is_success,
		got_process_reward_id_list = {},
		is_got_success_reward = slot1.is_got_success_reward
	}

	for slot6, slot7 in ipairs(slot1.competition_list) do
		table.insert(slot2.competition_list, slot0:ParseCompetitionData(slot7))
	end

	table.insertto(slot2.got_process_reward_id_list, slot1.got_process_reward_id_list, 1)

	return slot2
end

function slot0.ParseCurrentScheduleData(slot0, slot1)
	slot2 = {
		schedule_id = slot1.schedule_id,
		competition_list = {},
		is_click = slot1.is_click,
		selected_contestant_id = slot1.selected_contestant_id,
		got_process_reward_id_list = {}
	}

	for slot6, slot7 in ipairs(slot1.competition_list) do
		table.insert(slot2.competition_list, slot0:ParseCompetitionData(slot7))
	end

	table.insertto(slot2.got_process_reward_id_list, slot1.got_process_reward_id_list, 1)

	return slot2
end

function slot0.InitFromServerData(slot0, slot1)
	slot5 = slot1.open_online_stage_id
	uv0[slot1.activity_id] = {
		activity_id = slot1.activity_id,
		contribution_value = slot1.contribution_value,
		got_contribution_reward_id_list = {},
		current_schedule = slot0:ParseCurrentScheduleData(slot1.current_schedule),
		history_schedule_list = {},
		history_schedule_dic = {},
		open_stage_id = slot1.open_stage_id,
		open_online_stage_id = slot5
	}

	for slot5, slot6 in ipairs(slot1.history_schedule_list) do
		slot7 = slot0:ParseHistoryScheduleData(slot6)

		table.insert(uv0[slot1.activity_id].history_schedule_list, slot7)

		uv0[slot1.activity_id].history_schedule_dic[slot6.schedule_id] = slot7
	end

	table.insertto(uv0[slot1.activity_id].got_contribution_reward_id_list, slot1.got_contribution_reward_id_list)
end

function slot0.GetHistoryList(slot0, slot1, slot2)
	if not uv0[slot1] then
		return {}
	end

	slot3 = clone(uv0[slot1].history_schedule_list)

	if slot2 and uv0[slot1].current_schedule ~= nil and uv0[slot1].current_schedule.schedule_id ~= 0 then
		table.insert(slot3, uv0[slot1].current_schedule)
	end

	return slot3
end

function slot0.GetHistoryData(slot0, slot1)
	if not uv0[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[slot1].activity_id][1]] then
		return nil
	end

	return uv0[slot4].history_schedule_dic[slot1]
end

function slot0.GetCurrentSchedule(slot0, slot1)
	if not uv0[slot1] then
		return nil
	end

	return slot2.current_schedule
end

function slot0.GetCurrentScheduleActivityId(slot0, slot1)
	if not uv0[slot1] then
		return nil
	end

	return ActivityWaterCfg[slot2.current_schedule.schedule_id].activity_id
end

function slot0.OnChallengeSuccess(slot0, slot1, slot2)
	if not uv0[slot1] then
		uv0[slot1] = {}
	end

	for slot6, slot7 in ipairs(slot2) do
		slot8 = {
			uid = slot7.uid,
			dataDic = {}
		}

		for slot12, slot13 in ipairs(slot7.data_list) do
			slot8.dataDic[slot13.key] = slot13.value
		end

		uv0[slot1][tostring(slot7.uid)] = slot8
	end
end

function slot0.GetSettlePlayer(slot0, slot1, slot2)
	if not uv0[slot1] then
		return nil
	end

	return uv1[slot1][tostring(slot2)]
end

function slot0.IsFirstEnter(slot0, slot1)
	if not uv0[slot1] then
		return false
	end

	if uv0[slot1].current_schedule.schedule_id == 0 then
		return false
	end

	return not uv0[slot1].current_schedule.is_click
end

function slot0.OnClickEnd(slot0, slot1)
	uv0[slot1].current_schedule.is_click = true
end

function slot0.OnStageRefresh(slot0, slot1, slot2, slot3)
	uv0[slot1].open_stage_id = slot2
	uv0[slot1].open_online_stage_id = slot3
end

function slot0.OnSelectAssistantRole(slot0, slot1, slot2)
	uv0[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[slot1].activity_id][1]].current_schedule.selected_contestant_id = slot2

	manager.notify:Invoke(ACTIVITY_WATER_COMPETITION_UPDATE, slot2)
end

function slot0.OnGetSelfAssistantReward(slot0, slot1, slot2)
	table.insertto(uv0[slot1].got_contribution_reward_id_list, slot2)
	manager.notify:Invoke(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, {})
end

function slot0.OnGetTotalAssistantReward(slot0, slot1, slot2, slot3)
	table.insertto(uv0[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[slot1].activity_id][1]].current_schedule.got_process_reward_id_list, slot3)
	manager.notify:Invoke(ACTIVITY_WATER_TOTAL_ASSISTANT_REWARD_UPDATE, {})
end

function slot0.OnGetWinReward(slot0, slot1)
	if not slot0:GetHistoryData(slot1) then
		return
	end

	slot2.is_got_success_reward = true

	manager.notify:Invoke(ACTIVITY_WATER_WIN_REWARD_UPDATE, {})
end

function slot0.HaveGotHistoryReward(slot0, slot1)
	if not slot0:GetHistoryData(slot1) then
		return false
	end

	return slot2.is_got_success_reward
end

function slot0.GetContributionValue(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return slot2.contribution_value
end

function slot0.GetCurrentContributeIndex(slot0, slot1)
	if not uv0[slot1] then
		return 1, false
	end

	for slot8, slot9 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[slot1]) do
		if not table.indexof(slot2.got_contribution_reward_id_list, slot9) then
			return slot8, false
		end
	end

	return #slot4, true
end

function slot0.GetCurrentContributeCfg(slot0, slot1)
	slot2, slot3 = slot0:GetCurrentContributeIndex(slot1)

	return ActivityPointRewardCfg.get_id_list_by_activity_id[slot1][slot2], slot3
end

function slot0.GetCurrentCompetition(slot0, slot1, slot2)
	if not uv0[slot1] then
		return 0
	end

	return slot3.current_schedule.competition_list[slot2]
end

function slot0.HaveSelectAssistantRole(slot0, slot1)
	return slot0:GetCurrentAssistantRole(slot1) > 0
end

function slot0.GetCurrentAssistantRole(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return slot2.current_schedule.selected_contestant_id
end

function slot0.GetCurrentAssistantRoleProcess(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	for slot7, slot8 in ipairs(slot2.current_schedule.competition_list) do
		if slot8.competition_id == slot0:GetCurrentAssistantRole(slot1) then
			return slot8.assistance_process
		end
	end

	return 0
end

function slot0.GetCurrentAssistantIndex(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	for slot7, slot8 in ipairs(slot2.current_schedule.competition_list) do
		if slot8.competition_id == slot0:GetCurrentAssistantRole(slot1) then
			return slot7
		end
	end

	return 0
end

function slot0.GetCurrentAssistantRoleStageId(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return slot2.open_stage_id
end

function slot0.GetOnlineStageId(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return slot2.open_online_stage_id
end

function slot0.GetTrialHeroList(slot0, slot1)
	return uv0[slot0:GetCurrentAssistantRole(slot1)] or {
		0,
		0,
		0
	}
end

function slot0.SetHeroTeam(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.IsOppositeRole(slot0, slot1, slot2)
	return slot2 == slot0:GetOppositeHeroId(slot1, slot2), slot3
end

function slot0.GetOppositeHeroId(slot0, slot1)
	if not uv0[slot1] then
		return 0
	end

	return ActivityWaterCompetitionCfg[slot2.current_schedule.competition_list[3 - slot0:GetCurrentAssistantIndex(slot1)].competition_id].hero_id
end

function slot0.GetCanUseTrialList(slot0, slot1)
	return ActivityWaterCfg[slot0:GetCurrentSchedule(slot1).schedule_id].activity_id, ActivityWaterCompetitionCfg[slot0:GetCurrentAssistantRole(slot1)].camp_hero_id_list
end

function slot0.HaveGetTotalProgressReward(slot0, slot1, slot2)
	if not uv0[slot1] then
		return false
	end

	if table.indexof(slot3.current_schedule.got_process_reward_id_list, slot2) then
		return true
	end

	return false
end

function slot0.HaveGetSelfProgressReward(slot0, slot1, slot2)
	if not uv0[slot1] then
		return false
	end

	if table.indexof(slot3.got_contribution_reward_id_list, slot2) then
		return true
	end

	return false
end

function slot0.GetCompetitionImage(slot0, slot1)
	return getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot1].hero_id].hero_id)
end

function slot0.GetMaxSelfProgress(slot0)
	return GameSetting.activity_water_upper_limit.value[1]
end

function slot0.GetCurrentSelfProgress(slot0, slot1)
	if not slot0:GetCurrentSchedule(slot1) or slot2.schedule_id == 0 then
		return 0
	end

	return ItemTools.getItemNum(ActivityWaterCfg[slot2.schedule_id].assistance_coin_id)
end

function slot0.GetScheduleActivities(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(ActivityCfg[slot1].sub_activity_list) do
		if ActivityCfg[slot7].activity_template == ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetClientProgress(slot0, slot1)
	if not uv0[slot1] then
		return {
			0,
			0
		}
	end

	return {
		uv0[slot1].current_schedule.competition_list[1].assistance_process or 0,
		slot2[2].assistance_process or 0
	}
end

function slot0.IsAllScheduleOver(slot0, slot1)
	if not uv0[slot1] then
		return true
	end

	for slot6, slot7 in ipairs(slot0:GetScheduleActivities(slot1)) do
		if ActivityData:GetActivityIsOpen(slot7) then
			return false
		end
	end

	return true
end

function slot0.OnVoteUpdate(slot0, slot1)
	if not uv0[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[slot1.schedule_id].activity_id][1]] then
		return
	end

	if uv0[slot3].current_schedule.competition_list[1].competition_id == slot1.competition_list[1].competition_id then
		slot4[1].assistance_process = slot1.competition_list[1].assistance_process
		slot4[2].assistance_process = slot1.competition_list[2].assistance_process
	else
		slot4[1].assistance_process = slot1.competition_list[2].assistance_process
		slot4[2].assistance_process = slot1.competition_list[1].assistance_process
	end

	manager.notify:Invoke(ACTIVITY_WATER_CLIENT_PROGRESS_UPDATE, slot3)
end

return slot0
