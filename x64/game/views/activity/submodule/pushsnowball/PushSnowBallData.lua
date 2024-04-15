slot1 = 222581
slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9 = nil
slot10 = {}
slot11 = {}
slot12 = {}
slot13, slot14, slot15, slot16 = nil
PushSnowBallRankTemplate = class("PushSnowBallRankTemplate")

function PushSnowBallRankTemplate.Ctor(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.score = slot1.score
	slot0.difficulty = slot1.difficulty
	slot0.rank = slot1.rank
	slot0.timestamp = slot1.timestamp
	slot0.team_list = {}

	for slot5, slot6 in ipairs(slot1.team_info) do
		slot7 = {}

		for slot11, slot12 in ipairs(slot6.hero_info_list) do
			table.insert(slot7, {
				id = slot12.hero_id,
				skin_id = slot12.skin_id
			})
		end

		table.insert(slot0.team_list, slot7)
	end

	if PlayerData:GetPlayerInfo() and tonumber(slot0.user_id) == slot2.userID then
		slot0.nick = slot2.nick
		slot0.icon = slot2.portrait
		slot0.icon_frame = slot2.icon_frame
	else
		slot0.nick = slot1.nick
		slot0.icon = slot1.portrait
		slot0.icon_frame = slot1.frame
	end
end

slot18 = ({
	ALL = 1,
	GUILD = 2
}).ALL

return {
	SetGoViewStr = function (slot0, slot1)
		uv0 = slot1
	end,
	GetGoViewStr = function (slot0)
		return uv0
	end,
	GetActivityID = function (slot0)
		return uv0
	end,
	InitFromServer = function (slot0, slot1)
		uv0 = slot1.activity_id
		uv1 = slot1.equip
		uv2 = {}
		slot6 = slot1.unlock_equip

		for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
			table.insert(uv2, slot6)
		end

		slot6 = slot1.activity_point_list

		for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
			uv3[slot6.activity_id] = slot6.point
			uv4[slot6.activity_id] = {}
			slot11 = slot6.reward_list

			for slot10, slot11 in ipairs(cleanProtoTable(slot11)) do
				table.insert(uv4[slot6.activity_id], slot11)
			end
		end

		uv5 = ActivityCfg[uv0].sub_activity_list[1]
		uv6 = ActivityCfg[uv0].sub_activity_list[2]
		slot2 = slot0:GetSingleModelActivityIDByModelAndLevel(1, 1)
		uv7 = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[slot2][1]].hero_backhome
		uv8 = PushSnowBallCfg[PushSnowBallCfg.get_id_list_by_activityId[slot2][1]].hero_list
	end,
	OnUnlockDevice = function (slot0, slot1)
		uv0 = {}

		for slot5, slot6 in pairs(slot1.unlock_equip_list) do
			table.insert(uv0, slot6)
		end
	end,
	GetUnlockDeviceList = function (slot0)
		return uv0
	end,
	GetIsDeviceUnlockByID = function (slot0, slot1)
		for slot5, slot6 in ipairs(uv0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end,
	GetSingleActivityID = function (slot0)
		return uv0
	end,
	GetTeamActivityID = function (slot0)
		return uv0
	end,
	GetSingleModelActivityIDByModelAndLevel = function (slot0, slot1, slot2)
		return ActivityCfg[uv0].sub_activity_list[2 * ((slot1 or 1) - 1) + (slot2 or 1)]
	end,
	GetSingleDescTipsByModelAndSubModel = function (slot0, slot1)
		return GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_" .. slot1 + 1)
	end,
	GetTeamDescTipsByModelAndSubModel = function (slot0, slot1)
		return GetTips("ACTIVITY_SNOWBALL_PUSH_DESC_" .. 4 + slot1)
	end,
	GetSingleWeeklyTaskIDList = function (slot0)
		slot1 = {}
		slot5 = uv0

		for slot5, slot6 in ipairs(ActivityCfg[slot5].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == 4 then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	GetTeamRankActivtyID = function (slot0)
		slot1 = 0
		slot5 = uv0

		for slot5, slot6 in ipairs(ActivityCfg[slot5].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == 271 then
				slot1 = slot6
			end
		end

		return slot1
	end,
	GetTeamModelActivityIDByModel = function (slot0, slot1)
		return ActivityCfg[uv0].sub_activity_list[slot1]
	end,
	GetTeamTaskIDList = function (slot0)
		slot1 = {}
		slot5 = uv0

		for slot5, slot6 in ipairs(ActivityCfg[slot5].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == 4 then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	GetTeamRankActivityID = function (slot0)
		slot4 = uv0

		for slot4, slot5 in ipairs(ActivityCfg[slot4].sub_activity_list) do
			if ActivityCfg[slot5].activity_template == ActivityTemplateConst.ACTIVITY_PUSH_SNOW_BALL_RANK then
				return slot5
			end
		end
	end,
	GetDeviceDataList = function (slot0)
		return uv0
	end,
	GetHeroDataList = function (slot0)
		return uv0
	end,
	GetHeroInfoByHeroID = function (slot0, slot1)
		return DormData:GetHeroInfo(DormData:GetHeroArchiveID(slot1))
	end,
	SetSelectedHeroIndex = function (slot0, slot1)
		saveData("pushsnowball", "selectHeroIndex", slot1)

		uv0 = slot1
	end,
	GetSelectedHeroIndex = function (slot0)
		return uv0 or getData("pushsnowball", "selectHeroIndex") or 1
	end,
	GetSelectedHeroID = function (slot0)
		return uv0[slot0:GetSelectedHeroIndex()]
	end,
	GetSelectedBattleModelID = function (slot0)
		return uv0[slot0:GetSelectedHeroIndex()]
	end,
	SetSelectedDeviceID = function (slot0, slot1)
		uv0 = slot1
	end,
	GetSelectedDeviceID = function (slot0)
		return uv0 or 0
	end,
	GetNormalTaskListByType = function (slot0, slot1)
		return ActivityPointRewardCfg.get_id_list_by_activity_id[slot0:GetSingleModelActivityIDByModelAndLevel(slot1, 1)]
	end,
	GetHardTaskListByType = function (slot0, slot1)
		return ActivityPointRewardCfg.get_id_list_by_activity_id[slot0:GetSingleModelActivityIDByModelAndLevel(slot1, 2)]
	end,
	GetScoreTaskIsCompleteById = function (slot0, slot1)
		return slot2.need <= (uv0[ActivityPointRewardCfg[slot1].activity_id] or 0)
	end,
	GetScoreByActivityID = function (slot0, slot1)
		return uv0[slot1] or 0
	end,
	GetScoreTaskIsRewardedById = function (slot0, slot1)
		if not uv0[ActivityPointRewardCfg[slot1].activity_id] then
			return false
		end

		slot6 = slot2.activity_id

		for slot6, slot7 in pairs(uv0[slot6]) do
			if slot7 == slot1 then
				return true
			end
		end

		return false
	end,
	ReceiveScoreReward = function (slot0, slot1)
		if not uv0[ActivityPointRewardCfg[slot1].activity_id] then
			uv0[slot2.activity_id] = {}
		end

		table.insert(uv0[slot2.activity_id], slot1)
	end,
	GetScoreTaskIDListByModel = function (slot0, slot1)
		return ActivityPointRewardCfg.get_id_list_by_activity_id[slot0:GetTeamModelActivityIDByModel(slot1)]
	end,
	GetWeeklyTaskList = function (slot0)
		if not slot0:GetSingleWeeklyTaskIDList() then
			return {}
		end

		for slot5, slot6 in ipairs(slot1) do
			if manager.time:GetServerTime() < ActivityData:GetActivityData(slot6).stopTime then
				return TaskTools:GetActivityTaskList(slot6)
			end
		end

		return {}
	end,
	GetRefreshTimeStamp = function (slot0)
		slot2 = {}

		if not slot0:GetSingleWeeklyTaskIDList() then
			return {}
		end

		for slot6, slot7 in ipairs(slot1) do
			if manager.time:GetServerTime() < ActivityData:GetActivityData(slot7).startTime then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end,
	GetTeamWinTaskList = function (slot0)
		if not slot0:GetTeamTaskIDList() then
			return {}
		end

		return TaskTools:GetActivityTaskList(slot1[2])
	end,
	GetTeamParticipateTaskList = function (slot0)
		slot2 = {}

		if not slot0:GetTeamTaskIDList() then
			return {}
		end

		if not TaskTools:GetActivityTaskList(slot1[1]) then
			return {}
		end

		for slot7, slot8 in pairs(slot3) do
			table.insert(slot2, slot8)
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.id < slot1.id
		end)

		return slot2
	end,
	GetHasCompeletedWeeklyTask = function (slot0)
		slot2 = {}

		if not slot0:GetWeeklyTaskList() then
			return false
		end

		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, slot7)
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.id < slot1.id
		end)

		if not slot2[1] then
			return false
		end

		slot4 = AssignmentCfg[slot3.id]

		if AssignmentCfg[slot3.id].need <= TaskData2:GetTaskProgress(slot3.id) and not TaskData2:GetTaskComplete(slot3.id) then
			return true
		end

		return false
	end,
	GetHasCompeletedScoreTaskByModel = function (slot0, slot1)
		if not PushSnowBallData:GetNormalTaskListByType(slot1) and not PushSnowBallData:GetHardTaskListByType(slot1) then
			return false
		end

		for slot7, slot8 in ipairs(slot2) do
			if not PushSnowBallData:GetScoreTaskIsRewardedById(slot8) and PushSnowBallData:GetScoreTaskIsCompleteById(slot8) then
				return true
			end
		end

		for slot7, slot8 in ipairs(slot3) do
			if not PushSnowBallData:GetScoreTaskIsRewardedById(slot8) and PushSnowBallData:GetScoreTaskIsCompleteById(slot8) then
				return true
			end
		end

		return false
	end,
	GetHasCompeletedWinTaskByID = function (slot0, slot1)
		if not slot0:GetTeamWinTaskList() then
			return false
		end

		for slot6, slot7 in pairs(slot2) do
			if slot1 == slot7.id then
				if AssignmentCfg[slot7.id].need <= slot7.progress and not (slot7.complete_flag >= 1) then
					return true
				end
			end
		end

		return false
	end,
	GetHasCompeletedTeamTask = function (slot0)
		if not slot0:GetTeamParticipateTaskList() then
			return false
		end

		for slot5, slot6 in pairs(slot1) do
			if AssignmentCfg[slot6.id].need <= slot6.progress and not (slot6.complete_flag >= 1) then
				return true
			end
		end

		return false
	end,
	GetCompeletedTeamTaskNum = function (slot0)
		if not slot0:GetTeamParticipateTaskList() then
			return 0
		end

		for slot6, slot7 in pairs(slot1) do
			if AssignmentCfg[slot7.id].need <= slot7.progress then
				slot2 = slot2 + 1
			end
		end

		return slot2
	end,
	GetHasAllRewardedTeamTask = function (slot0)
		if not slot0:GetTeamParticipateTaskList() then
			return false
		end

		for slot5, slot6 in pairs(slot1) do
			slot7 = slot6.complete_flag == 0

			return false
		end

		return true
	end,
	GetIsNewLevelUnLock = function (slot0, slot1)
		if ActivityData:GetActivityData(slot0:GetSingleModelActivityIDByModelAndLevel(slot1, 2)).startTime < manager.time:GetServerTime() then
			return true
		end

		return false
	end,
	OnReceviedSingleBattleResult = function (slot0, slot1)
		uv0 = slot1.score
		uv1 = slot1.use_seconds
		uv2[slot1.activity_id] = math.max(uv2[slot1.activity_id] or 0, slot1.score)
	end,
	OnReceviedTeamBattleResult = function (slot0, slot1)
		uv0 = {}
		slot6 = slot1.battle_result.battle_record

		for slot5, slot6 in pairs(cleanProtoTable(slot6)) do
			slot7 = slot6.user_id
			slot8, slot9, slot10 = nil
			slot15 = slot6.battle_record

			for slot14, slot15 in pairs(cleanProtoTable(slot15)) do
				if slot15.id == 66 then
					slot8 = slot15.value
				end

				if slot15.id == 67 then
					slot9 = slot15.value % 2
					slot10 = slot15.value < 2 and 1 or 0
				end
			end

			table.insert(uv0, {
				user_id = slot7,
				score = slot8,
				type = slot9,
				result = slot10
			})
		end

		slot6 = slot1.battle_result.player_list

		for slot5, slot6 in pairs(cleanProtoTable(slot6)) do
			for slot15, slot16 in ipairs(uv0) do
				if slot16.user_id == slot6.player_id then
					slot16.nick = slot6.player_battle_info.nick
					slot16.hero_id = slot6.player_battle_info.hero_list[1].hero_id
					slot16.icon = slot6.player_battle_info.icon
					slot16.frame = slot6.player_battle_info.frame
				end
			end
		end
	end,
	GetTeamBattleResultInfo = function (slot0)
		return uv0
	end,
	GetBattleResultScore = function (slot0)
		return uv0 or 0
	end,
	GetBattleResultSecond = function (slot0)
		return uv0 or 0
	end,
	SetPlayerList = function (slot0, slot1)
		uv0 = {}
		slot6 = slot1.client_player_list

		for slot5, slot6 in ipairs(cleanProtoTable(slot6)) do
			table.insert(uv0, {
				uid = slot6.user_id,
				heroID = slot6.hero_id
			})
		end
	end,
	GetPlayerList = function (slot0)
		return uv0
	end,
	GetCurActivityID = function (slot0)
		return slot0:GetTeamRankActivityID()
	end,
	GetRankTypeConst = function (slot0)
		return uv0
	end,
	GetCurRankType = function (slot0)
		return uv0
	end,
	SetCurRankType = function (slot0, slot1)
		uv0 = slot1
	end,
	GetRankVersion = function (slot0)
		return rank_version
	end,
	GetRankTotalPeople = function (slot0)
		return rank_total_people
	end,
	InitCurRank = function (slot0, slot1)
		cur_rank = PushSnowBallRankTemplate.New(slot1.my_rank)
		rank_total_people = slot1.total
	end,
	InitRankData = function (slot0, slot1)
		rank_list = {}

		for slot5, slot6 in ipairs(slot1.rank_list) do
			table.insert(rank_list, PushSnowBallRankTemplate.New(slot6))
		end

		table.sort(rank_list, function (slot0, slot1)
			return slot0.rank < slot1.rank
		end)

		cur_rank = PushSnowBallRankTemplate.New(slot1.my_rank)
		rank_total_people = slot1.total
		rank_version = slot1.version

		manager.notify:Invoke(ADVANCE_TEST_RANK_UPGRADE)
	end,
	InitGuildRankData = function (slot0, slot1)
		GuildAction.RequiredGuildMemberList(function ()
			guild_rank_list = {}

			for slot3, slot4 in ipairs(uv0.rank_list) do
				if GuildData:GetGuildMemberData(slot4.user_id) then
					table.insert(guild_rank_list, PushSnowBallRankTemplate.New(slot4))
				end
			end

			table.sort(guild_rank_list, function (slot0, slot1)
				return slot0.rank < slot1.rank
			end)

			guild_cur_rank = nil

			for slot5, slot6 in ipairs(guild_rank_list) do
				slot6.rank = slot5

				if tonumber(slot6.user_id) == PlayerData:GetPlayerInfo().userID then
					guild_cur_rank = slot6
				end
			end

			manager.notify:Invoke(ADVANCE_TEST_RANK_UPGRADE)
		end)
	end,
	ResetGuildRankData = function (slot0)
		guild_rank_list = {}
		guild_cur_rank = nil
	end,
	GetRankList = function (slot0)
		return rank_list
	end,
	GetCurRank = function (slot0)
		return cur_rank
	end,
	GetGuildRankList = function (slot0)
		return guild_rank_list
	end,
	GetGuildCurRank = function (slot0)
		return guild_cur_rank
	end
}
