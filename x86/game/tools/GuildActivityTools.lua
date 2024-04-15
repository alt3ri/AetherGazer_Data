slot1 = {}

return {
	IsConditionAchieved = function (slot0, slot1)
		if ConditionCfg[slot0] == nil then
			return true, 0, 0
		end

		slot3 = false
		slot4 = HistoryData:GetHistoryData(slot2.id) or 0
		slot5 = slot2.params[1]

		if slot2.type == 9001 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot2.params[1] <= slot4, slot4, slot2.params[1]
		elseif slot2.type == 9002 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot2.params[1] <= slot4, slot4, slot2.params[1]
		elseif slot2.type == 9003 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot2.params[1] <= slot4, slot4, slot2.params[1]
		elseif slot2.type == 9004 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot4 >= 1, slot4, 1
		elseif slot2.type == 9005 then
			slot4 = HistoryData:GetHistoryData(slot2.id) or 0

			return slot4 >= 1, slot4, 1
		end

		return slot3, slot4, slot5
	end,
	GetGuildSpConditionDesc = function (slot0)
		if not ConditionCfg[slot0] then
			return ""
		end

		if slot1.type == 9011 then
			slot2 = string.format(slot1.desc, slot1.params[1], slot1.params[2], GetTips(GuildActivitySPConst.NodeType[slot1.params[3]]))
		elseif slot1.type == 9012 then
			slot2 = string.format(slot1.desc, slot1.params[2])
		elseif slot1.type == 9013 then
			slot2 = string.format(slot1.desc, slot1.params[1], slot1.params[2])
		elseif slot1.type == 9014 then
			slot2 = slot1.desc
		elseif slot1.type == 9015 then
			slot2 = string.format(slot1.desc, slot1.params[1])
		elseif slot1.type == 9016 then
			slot2 = string.format(slot1.desc, slot1.params[1])
		elseif slot1.type == 9017 then
			slot2 = string.format(slot1.desc, slot1.params[2])
		end

		return slot2
	end,
	PlayGuildActivitySpStoryList = function (slot0, slot1, slot2, slot3)
		for slot7, slot8 in ipairs(GuildActivitySPConst.StoryPriorty) do
			if GuildActivityTools:PlayGuildActivityStory(slot8, slot1, slot3) then
				return true
			end
		end

		if slot1 then
			slot1(slot2)
		end

		uv0 = {}
	end,
	CheckCanPlayStory = function (slot0, slot1)
		if GuildActivitySPData:GetCurMainActivityID() == ActivityConst.GUILD_ACTIVITY_SP_2_4 then
			for slot6, slot7 in ipairs(GuildActivitySPConst.StoryPriorty) do
				if uv0:GetCanPlatStory(slot7, slot1) and not manager.story:IsStoryPlayed(slot8) and not uv1[slot8] then
					return true
				end
			end
		end
	end,
	GetCanPlatStory = function (slot0, slot1, slot2)
		slot3 = nil

		if slot2 == 1 then
			if slot1 == GuildActivitySPConst.StoryType.FirstEnter then
				slot3 = GameSetting.activity_club_sp_start_plot.value[1]
			elseif slot1 == GuildActivitySPConst.StoryType.Condition then
				for slot8, slot9 in ipairs(GameSetting.activity_club_sp_middle_plot.value[1]) do
					if IsConditionAchieved(slot9[1]) and not manager.story:IsStoryPlayed(slot9[2]) and not uv0[slot9[2]] then
						slot3 = slot9[2]

						break
					end
				end
			end
		elseif slot2 == 2 then
			if slot1 == GuildActivitySPConst.StoryType.Condition then
				for slot8, slot9 in ipairs(GameSetting.activity_club_sp_middle_plot.value[2]) do
					if IsConditionAchieved(slot9[1]) and not manager.story:IsStoryPlayed(slot9[2]) and not uv0[slot9[2]] then
						slot3 = slot9[2]

						break
					end
				end
			elseif slot1 == GuildActivitySPConst.StoryType.Level1BossPass then
				if uv1:GetSpActivityStage() == GuildActivitySPConst.StageType.First and uv1:CheckBigBossDead(2) then
					slot3 = GameSetting.activity_club_sp_success_complete_plot.value[1]
				end
			elseif slot1 == GuildActivitySPConst.StoryType.Level1BossNoPass then
				if uv1:GetSpActivityStage() == GuildActivitySPConst.StageType.Second and not uv1:CheckBigBossDead(2) then
					slot3 = GameSetting.activity_club_sp_fail_plot.value[1]
				end
			elseif slot1 == GuildActivitySPConst.StoryType.Level2BossPass and uv1:GetSpActivityStage() == GuildActivitySPConst.StageType.Second and uv1:CheckBigBossDead(2) then
				slot3 = GameSetting.activity_club_sp_success_plot.value[1]
			end
		end

		return slot3
	end,
	PlayGuildActivityStory = function (slot0, slot1, slot2, slot3)
		if uv0:GetCanPlatStory(slot1, slot3) and not manager.story:IsStoryPlayed(slot4) and not uv1[slot4] then
			uv1[slot4] = true

			LeanTween.cancel(manager.ui.mainCamera.transform.gameObject)
			manager.story:StartStoryById(slot4, function (slot0)
				uv0:PlayGuildActivitySpStoryList(uv1, true, uv2)
			end)

			return true
		end
	end,
	GetSpActivityStage = function (slot0)
		slot3 = ActivityData:GetActivityData(GuildActivitySPData:GetCurRunActivityID())
		slot6 = slot3.stopTime

		if slot3.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
			return GuildActivitySPConst.StageType.Second
		else
			return GuildActivitySPConst.StageType.First
		end
	end,
	CheckBigBossDead = function (slot0, slot1)
		if GuildActivitySPData:GetMaxNodeId() and GuildActivitySPData:GetNodeData(slot2).health <= 0 then
			return true
		end
	end,
	IsLastBossDefeated = function (slot0, slot1)
		if slot1 == ActivityClubCfg.all[#ActivityClubCfg.all] and GuildActivityData:GetNodeData(slot1).health <= 0 then
			return true
		end

		return false
	end
}
