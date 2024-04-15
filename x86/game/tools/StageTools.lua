return {
	GetBossChallengeNextIndex = function (slot0)
		if BattleBossChallengeNormalData:GetBossChallengeCfg().level_amount < BattleBossChallengeNormalData:GetFinishIndex(slot0) then
			return slot2.level_amount
		end

		return slot1
	end,
	GetAutoChapter = function (slot0, slot1)
		if BattleStageData:GetStageData()[slot1].clear_times == 1 then
			return uv0.GetNextChapter(slot0, slot1)
		end

		return slot0
	end,
	GetNextChapter = function (slot0, slot1)
		slot3 = ChapterCfg[slot0].section_id_list

		if slot3[#slot3] == slot1 then
			slot4 = getChapterListByDifficulty(slot2.type, slot2.difficulty)

			if table.keyof(slot4, slot0) < #slot4 and ChapterTools.IsFinishPreChapter(slot4[slot5 + 1]) and ChapterTools.IsUnlockChapter(slot6) then
				return slot6
			end
		end

		return slot0
	end,
	GetChapterNextStageID = function (slot0, slot1)
		slot3 = ChapterCfg[slot0].section_id_list

		if table.keyof(slot3, slot1) < #slot3 then
			if slot3[slot4 + 1] == GameSetting.travel_skuld_new_ending_stage_id.value[1] and BattleStageData:GetStageData()[slot5].clear_times < 1 then
				return
			end

			return slot5
		end
	end,
	GetActivityStoryNextStageID = function (slot0, slot1)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(ActivityStoryChapterCfg[slot0].activity_id).startTime or slot4.stopTime < slot5 then
			return
		end

		if slot3 == ActivityConst.OSIRIS_STROY then
			return uv0.GetOsirisNextStage(slot0, slot1)
		end
	end,
	GetOsirisNextStage = function (slot0, slot1, slot2)
		if StoryStageActivityData:GetStageData(slot1)[slot2] then
			slot4 = nil

			for slot8, slot9 in pairs(GameSetting.activity_plot_unlock.value) do
				if slot9[1][1] == slot1 and slot9[1][2] == slot2 then
					slot4 = slot9[2][1]
				end
			end

			slot5 = 100

			if slot4 then
				slot5 = ChessTools.GetChapterProgress(slot4)
			end

			if slot5 < 100 then
				return
			end

			slot7 = ActivityStoryChapterCfg[slot1].stage_list

			if table.keyof(slot7, slot2) < #slot7 then
				return slot7[slot8 + 1]
			end
		end
	end,
	CalcBossChallengeStar = function ()
		slot0 = 0

		for slot4, slot5 in pairs(BattleBossChallengeNormalData:GetThreeStarList()) do
			for slot9, slot10 in ipairs(slot5) do
				if slot10 == 1 then
					slot0 = slot0 + 1
				end
			end
		end

		return slot0
	end,
	NeedShowContinueBattleWindow = function (slot0, slot1)
		if BattleStageTools.GetStageCfg(slot0, slot1).auto_next_stage_group == 0 then
			return false
		end

		slot3, slot4 = uv0.GetContinueBattleCost(slot0, slot1)

		if slot4 <= 1 then
			return false
		end

		if slot2.auto_next_stage_group <= 10 then
			return true
		elseif ItemTools.getItemNum(slot3[1].id) < slot3[1].num then
			return true
		end

		return false
	end,
	GetContinueBattleCost = function (slot0, slot1)
		slot2 = uv0.GetContinueBattleStageList(slot0, slot1)

		if type(BattleStageTools.GetStageCfg(slot0, slot1).extra_cost) == "table" and slot4.extra_cost[1] then
			table.insert({}, {
				slot4.extra_cost[1],
				0
			})
		else
			table.insert(slot3, {
				CurrencyConst.CURRENCY_TYPE_VITALITY,
				0
			})
		end

		for slot8, slot9 in ipairs(slot2) do
			slot4 = BattleStageTools.GetStageCfg(slot0, slot9)

			if not BattleStageData:GetStageData()[slot9] or slot10.clear_times <= 0 then
				if type(slot4.extra_cost) == "table" and slot4.extra_cost[1] then
					table.insert(slot3, clone(slot4.extra_cost))
				else
					table.insert(slot3, {
						CurrencyConst.CURRENCY_TYPE_VITALITY,
						slot4.cost
					})
				end
			end
		end

		return mergeReward(formatRewardCfgList(slot3)), #slot2
	end,
	GetContinueBattleStageList = function (slot0, slot1)
		slot3 = slot1
		slot4 = {}
		slot5 = BattleStageTools.GetStageCfg(slot0, slot1).auto_next_stage_group

		while slot5 ~= 0 and slot2.auto_next_stage_group == slot5 do
			table.insert(slot4, slot3)

			if uv0.GetChapterNextStageID(getChapterIDByStageID(slot3), slot3) then
				slot2 = BattleStageTools.GetStageCfg(slot0, slot3)
			else
				break
			end
		end

		return slot4
	end,
	HasStageCost = function (slot0, slot1)
		slot2 = BattleStageTools.GetStageCfg(slot0, slot1)
		slot4 = 0
		slot5 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if not BattleStageData:GetStageData()[slot1] or slot3.clear_times <= 0 then
			if type(slot2.extra_cost) == "table" and slot2.extra_cost[1] then
				return slot2.extra_cost[2] <= ItemTools.getItemNum(slot2.extra_cost[1])
			else
				return slot2.cost <= slot5
			end
		end

		return true
	end,
	IsLockStage = function (slot0, slot1)
		if not ChapterTools.IsFinishPreChapter(slot0) then
			return true
		end

		if slot1 then
			if not ActivityData:GetActivityIsOpen(ChapterCfg[slot0].activity_id) then
				return PlayerData:GetPlayerInfo().userLevel < BattleStageTools.GetStageCfg(ChapterCfg[slot0].type, slot1).level
			end
		end

		return false
	end,
	IsLockSubChapterStage = function (slot0, slot1)
		slot2 = false

		for slot6, slot7 in pairs(GameSetting.sub_plot_unlock.value) do
			if slot7[1][1] == slot0 and slot7[1][2] == slot1 then
				for slot11, slot12 in ipairs(slot7[2]) do
					if ChessTools.GetChapterProgress(slot12) < 100 then
						return true
					end
				end

				return false
			end
		end

		return false
	end,
	GetStageArchiveID = function (slot0)
		if StageArchiveCfg.get_id_list_by_unlock_by_stage_id[slot0] then
			return slot1[1]
		else
			return 0
		end
	end
}
