function slot1(slot0, slot1)
	if SPHeroChallengeData.activityCfg[slot1] then
		slot3 = GameSetting[slot2.operationEntrustNum].value

		if slot0 <= slot3[#slot3][1] then
			if slot0 <= uv0:GetCanOperationEntrustNum(slot1) then
				return true
			end
		else
			return uv0:CheckEntrustWaitListOpen(slot1, slot0)
		end
	end
end

function slot2(slot0, slot1)
	slot2 = {}

	if slot0 and slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if slot7[1] <= slot0 then
				table.insert(slot2, slot7[2])
			end
		end
	end

	return slot2
end

return {
	CloseActivity = function (slot0, slot1)
		SPHeroChallengeData:ExitCurSystem()
		SPHeroChallengeData:DisposeActivityInfo(slot1)
	end,
	CheckActivityCanClose = function (slot0, slot1)
		slot2 = true

		for slot6, slot7 in ipairs(GameSetting.activity_hero_challenge_close_condition.value) do
			if not IsConditionAchieved(slot7) then
				slot2 = false

				break
			end
		end

		return slot2
	end,
	CheckActivityCloseWithTips = function (slot0)
		if slot0:CheckActivityCanClose(SPHeroChallengeData:GetActivityID()) then
			ShowTips("TIME_OVER")
		end

		return slot0:CheckActivityCanClose(slot1)
	end,
	GetOpenActivityID = function (slot0)
		slot2 = {}

		if SPHeroChallengeData:GetTotalInfo() then
			for slot6, slot7 in pairs(slot1) do
				table.insert(slot2, slot6)
			end
		end

		return slot2
	end,
	CheckActivityIsOpen = function (slot0, slot1)
		if slot1 then
			return table.indexof(slot0:GetOpenActivityID(), slot1)
		end
	end,
	EnterSystem = function (slot0, slot1)
		if slot0:CheckActivityIsOpen(slot1) then
			if slot0:CheckActivityCanClose(slot1) then
				ShowTips("ACTIVITY_COMBINE_GAME_DRAW_POOL_FINISH")

				return
			end

			if SPHeroChallengeData.activityCfg[slot1] then
				SPHeroChallengeData:SetCurActivityID(slot1)
				JumpTools.OpenPageByJump(slot3.enterView)
			end
		else
			ShowTips("SOLO_NOT_OPEN")
		end
	end,
	JumpSystemByScheduleType = function (slot0, slot1, slot2, slot3)
		if not slot0:CheckActivityCloseWithTips() then
			if slot1 == SpHeroChallengeConst.ScheduleSubType.story then
				JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
					groupIndex = 1,
					isDetailJump = slot2
				})
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.train1 then
				JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
					playAnimation = true,
					trainType = slot1
				})
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.train2 then
				JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
					playAnimation = true,
					trainType = slot1
				})
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.train3 then
				JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
					playAnimation = true,
					trainType = slot1
				})
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.boss then
				JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
					groupIndex = 3
				})
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.decode then
				JumpTools.OpenPageByJump("/colorPuzzleSelectLevel", {
					isDetailJump = slot2
				})
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.barbuce then
				SPHeroChallengeAction:OnEnterBarbuceScene()
				SPHeroChallengeData:SavePageState(slot3)
			elseif slot1 == SpHeroChallengeConst.ScheduleSubType.entrust then
				JumpTools.OpenPageByJump("/spHeroChallengeEntrustView")
			end
		end
	end,
	AutoChooseSchedule = function (slot0)
		SPHeroChallengeData:GetCurActivityInfo():ClearScheduleDailyList()

		slot4 = GameSetting.activity_hero_challenge_schedule_limit.value[1]
		slot5 = {}
		slot6 = {
			0.5,
			0.25,
			0.25
		}

		for slot10, slot11 in ipairs(slot0:GetCanChooseSchedule(SPHeroChallengeData:GetActivityID())) do
			if not slot5[ActivityHeroChallengeScheduleCfg[slot11].type] then
				slot5[ActivityHeroChallengeScheduleCfg[slot11].type] = {}
			end

			table.insert(slot5[ActivityHeroChallengeScheduleCfg[slot11].type], slot11)
		end

		for slot10, slot11 in pairs(slot5) do
			CommonTools.UniversalSortEx(slot11, {
				ascend = true,
				map = function (slot0)
					return ActivityHeroChallengeScheduleCfg[slot0].priority
				end
			})
		end

		for slot10, slot11 in pairs(slot5) do
			slot12 = 0

			for slot17 = slot10, #slot6 do
				slot13 = slot6[slot17] + 0
			end

			slot14 = math.ceil(slot4 * slot6[slot10] / slot13)

			for slot18, slot19 in ipairs(slot11) do
				while true do
					if slot0:CheckScheduleCanAddInlist(slot19) then
						slot1:AddScheduleInDailyList(slot19)

						slot4 = slot4 - 1

						if slot14 - 1 <= 0 then
							break
						end
					else
						break
					end
				end

				if slot14 <= 0 then
					break
				end
			end

			if slot4 <= 0 then
				break
			end
		end
	end,
	ShowAutoScheduleTips = function (slot0, slot1)
		slot2 = true

		for slot6 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
			slot8, slot9 = SPHeroChallengeData:GetCurActivityInfo():GetTrainNumByType(slot6)

			if slot8 < slot9 then
				slot2 = false

				return
			end
		end

		slot3, slot4 = slot0:GetScheduleProgress(SpHeroChallengeConst.ScheduleID.Decode)

		if slot3 < slot4 then
			slot2 = false
		end

		return slot2
	end,
	GetCanChooseSchedule = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(ActivityHeroChallengeScheduleCfg.all) do
			if slot0:CheckScheduleCanAddInlist(slot8) then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end,
	GetScheduleProgress = function (slot0, slot1, slot2)
		slot3 = SPHeroChallengeData:GetCurActivityInfo()

		if slot1 == SpHeroChallengeConst.ScheduleID.Entrust or slot1 == SpHeroChallengeConst.ScheduleID.Barbecue or slot1 == SpHeroChallengeConst.ScheduleID.Boss then
			return -1, -1
		elseif slot1 == SpHeroChallengeConst.ScheduleID.Awake then
			slot4 = #slot3.storyFinStageList
			slot6 = #ChapterCfg[SPHeroChallengeData.activityCfg[slot3.activityID].storyChapter].section_id_list
			slot7 = 0

			if slot2 then
				slot7 = slot0:GetSameScheduleNum(slot1)
			end

			return slot4 + slot7, slot6
		elseif slot1 == SpHeroChallengeConst.ScheduleID.Endurance or slot1 == SpHeroChallengeConst.ScheduleID.Deter or slot1 == SpHeroChallengeConst.ScheduleID.Explode then
			return -1, -1
		elseif slot1 == SpHeroChallengeConst.ScheduleID.Decode then
			slot4 = #ActivityHeroChallengeColor.all
			slot5 = ColorPuzzleData:GetClearedLevelCount() or 0
			slot6 = 0

			if slot2 then
				slot6 = slot0:GetSameScheduleNum(slot1)
			end

			return slot5 + slot6, slot4
		end

		return 0, 100
	end,
	CheckScheduleIsUnlock = function (slot0, slot1)
		if ActivityHeroChallengeScheduleCfg[slot1] then
			slot3 = true

			for slot7, slot8 in ipairs(slot2.pre_condition) do
				if not IsConditionAchieved(slot8) then
					return false, SPHeroChallengeTools:GetConditionDesc(slot8)
				end
			end

			return true
		else
			Debug.LogError("未获取到日程配置" .. slot1)
		end
	end,
	CheckScheduleIsRemove = function (slot0, slot1)
		if ActivityHeroChallengeScheduleCfg[slot1] then
			slot3 = true

			if slot2.remove_condition then
				if not next(slot2.remove_condition) then
					slot3 = false
				end

				for slot7, slot8 in ipairs(slot2.remove_condition) do
					if not IsConditionAchieved(slot8) then
						return false, SPHeroChallengeTools:GetConditionDesc(slot8)
					end
				end
			end

			return slot3
		else
			Debug.LogError("未获取到日程配置" .. slot1)
		end
	end,
	GetSameScheduleNum = function (slot0, slot1)
		for slot8, slot9 in ipairs(SPHeroChallengeData:GetCurActivityInfo():GetScheduleDailyList()) do
			if slot9 == slot1 then
				slot4 = 0 + 1
			end
		end

		return slot4
	end,
	CheckScheduleCanAddInlist = function (slot0, slot1)
		slot2 = true
		slot3 = ""
		slot4 = "unlock"

		if not slot0:CheckScheduleIsUnlock(slot1) then
			slot2 = false
			slot3 = SPHeroChallengeTools:GetConditionDesc(ActivityHeroChallengeScheduleCfg[slot1].pre_condition[1])
			slot4 = "lock"
		end

		if not ActivityData:GetActivityIsOpen(ActivityHeroChallengeScheduleCfg[slot1].activity_id) then
			slot3 = GetTips("SOLO_NOT_OPEN")
			slot4 = "lock"
		end

		if slot1 == SpHeroChallengeConst.ScheduleID.Boss and not SPHeroChallengeData:GetCurActivityInfo().bossStart then
			slot2 = false
			slot3 = GetTips("SOLO_NOT_OPEN")
			slot4 = "lock"
		end

		slot6, slot7 = slot0:GetScheduleProgress(slot1, true)

		if slot6 >= 0 and slot7 <= slot6 then
			slot2 = false
			slot3 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
			slot4 = "finish"
		end

		if slot0:CheckScheduleIsRemove(slot1) then
			slot2 = false
			slot4 = "finish"
			slot3 = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_FINISH")
		end

		return slot2, slot3, slot4
	end,
	GetNextCanBattleStageID = function (slot0, slot1)
		if slot1 == SpHeroChallengeConst.ScheduleSubType.story then
			return SPHeroChallengeData:GetCurActivityInfo():GetNextStoryStageIDList()
		elseif slot1 == SpHeroChallengeConst.ScheduleSubType.decode then
			return ColorPuzzleData:GetNextStage()
		end
	end,
	GetEntrustPosState = function (slot0, slot1, slot2)
		if slot0:CheckActivityIsOpen(slot1) then
			if not uv0(slot2, slot1) then
				return SpHeroChallengeConst.EntrustPosState.lock
			end

			if not SPHeroChallengeData:GetActivityData(slot1):GetEntrustInfoByIndex(slot2) or not next(slot4) then
				return SpHeroChallengeConst.EntrustPosState.empty
			end

			if slot3:GetEntrustEndTime(slot2) then
				return SpHeroChallengeConst.EntrustPosState.fin
			else
				return SpHeroChallengeConst.EntrustPosState.start
			end
		end
	end,
	GetCanWaitEntrustNum = function (slot0, slot1)
		slot3 = 0

		if SPHeroChallengeData.activityCfg[slot1] then
			for slot8, slot9 in ipairs(slot2.waitEntrustListOpenCondition) do
				if IsConditionAchieved(slot9[2]) then
					slot3 = slot3 + 1
				end
			end
		end

		return slot3
	end,
	GetCanOperationEntrustNum = function (slot0, slot1)
		if SPHeroChallengeData.activityCfg[slot1] then
			for slot8, slot9 in ipairs(GameSetting[slot2.operationEntrustNum].value) do
				if IsConditionAchieved(slot9[2]) then
					slot4 = math.max(1, slot9[1])
				else
					break
				end
			end

			return slot4
		else
			Debug.LogError("未获取到对应活动的配置数据" .. slot1)
		end
	end,
	CheckCanStartEntrust = function (slot0, slot1, slot2)
		slot3 = true
		slot4 = nil

		if ActivityHeroChallengeTaskCfg[slot1] then
			if slot0:GetCanStartEntrustNum(slot2) <= 0 then
				slot3 = false
				slot4 = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FULL")
			end

			for slot9, slot10 in ipairs(slot5.cost) do
				if (ItemTools.getItemNum(slot10[1]) or 0) < slot10[2] then
					slot3 = false
					slot4 = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_NONE_MATERIAL")

					break
				end
			end

			return slot3, slot4
		end
	end,
	GetEntrustLockDesc = function (slot0, slot1)
		slot3 = SPHeroChallengeData:GetCurActivityInfo()

		if slot0:GetCanOperationEntrustNum(SPHeroChallengeData:GetActivityID()) < slot1 then
			for slot9, slot10 in ipairs(GameSetting.activity_hero_challenge_task_condition.value) do
				if slot1 == slot10[1] then
					if IsConditionAchieved(slot10[2]) then
						return true
					else
						return false, slot0:GetConditionDesc(slot10[2])
					end
				end
			end
		end
	end,
	GetCanStartEntrustNum = function (slot0)
		slot1 = SPHeroChallengeData:GetActivityID()

		return math.max(slot0:GetCanWaitEntrustNum(slot1) + slot0:GetCanOperationEntrustNum(slot1) - SPHeroChallengeData:GetCurActivityInfo():GetReceiveEntrustNum(), 0)
	end,
	GetAcceleratorNumByIndex = function (slot0, slot1)
		slot3, slot4 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(slot1)
		slot5 = 0

		if not slot3 then
			slot5 = math.ceil(slot4 / 3600)
		end

		return slot5
	end,
	CheckEntrustWaitListOpen = function (slot0, slot1, slot2)
		if SPHeroChallengeData.activityCfg[slot1] then
			slot5 = GameSetting[slot3.operationEntrustNum].value

			for slot10, slot11 in ipairs(slot3.waitEntrustListOpenCondition) do
				if slot11[1] == slot2 - slot5[#slot5][1] then
					return IsConditionAchieved(slot11[2])
				end
			end

			return false
		end
	end,
	GetOpenWaitEntrustListNum = function (slot0, slot1)
		slot3 = 0

		if SPHeroChallengeData.activityCfg[slot1] then
			for slot8, slot9 in ipairs(slot2.waitEntrustListOpenCondition) do
				if IsConditionAchieved(slot9[2]) then
					slot3 = slot3 + 1
				end
			end
		end

		return slot3
	end,
	GetMaxStartEntrustPosNum = function (slot0, slot1)
		if SPHeroChallengeData.activityCfg[slot1] then
			slot3 = GameSetting[slot2.operationEntrustNum].value

			return slot3[#slot3][1]
		end
	end,
	GetMaxWaitEntrustPosNum = function (slot0, slot1)
		if SPHeroChallengeData.activityCfg[slot1] then
			return #slot2.waitEntrustListOpenCondition
		end
	end,
	GetMaxTotleEntrustPosNum = function (slot0, slot1)
		if SPHeroChallengeData.activityCfg[slot1] then
			return slot0:GetMaxStartEntrustPosNum(slot1) + slot0:GetMaxWaitEntrustPosNum(slot1)
		end
	end,
	GetUnlockAffix = function (slot0)
		slot2 = SPHeroChallengeData:GetCurActivityInfo()
		slot3 = {}

		for slot7 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
			table.merge(slot3, uv0(slot2:GetTrainNumByType(slot7), ActivityHeroChallengeCfg[SPHeroChallengeData:GetActivityID()]["affix_group_" .. slot7 - 1]))
		end

		return slot3
	end,
	GetUnlockChapterAffix = function (slot0)
		slot1 = {}

		for slot6 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
			if slot0:CheckBattleRouteIsOpen(slot6) then
				table.insert(slot1, ActivityHeroChallengeCfg[SPHeroChallengeData:GetActivityID()].affix_unlock[slot6 - 1])
			end
		end

		return slot1
	end,
	CheckStageIsOpen = function (slot0, slot1)
		if BattleVerthandiExclusiveCfg[slot1] then
			slot3 = false
			slot4 = ""

			if ChapterCfg[SpHeroChallengeConst.chapterID[slot2.sub_type]].unlock_activity_id > 0 and not ActivityData:GetActivityIsOpen(slot7) then
				slot3 = true
				slot4 = (not ActivityData:GetActivityData(slot7) or manager.time:GetServerTime() >= slot8.startTime or GetTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot8.startTime)))) and GetTips("TIME_OVER")
			end

			for slot11, slot12 in ipairs(BattleVerthandiExclusiveCfg.all) do
				if slot1 == BattleVerthandiExclusiveCfg[slot12].next_unlock_id_list[1] and not slot0:IsClearStage(slot12) then
					slot3 = true
					slot4 = GetTips("ERROR_ACTIVITY_ZM_GAME_PRE_MISSION_UNLOCK")
				end
			end

			if slot5 ~= SpHeroChallengeConst.BattleSubType.story then
				slot9, slot4 = slot0:CheckScheduleIsUnlock(SpHeroChallengeConst.scheduleIndex[slot2.sub_type])

				if not slot9 then
					slot3 = true
				end
			end

			return slot3, slot4
		else
			Debug.LogError("未获取到关卡配置信息" .. slot1)
		end
	end,
	CheckStoryStageCanBattle = function (slot0, slot1)
		if BattleVerthandiExclusiveCfg[slot1] then
			slot3 = false
			slot4 = ""

			if slot2.sub_type == SpHeroChallengeConst.BattleSubType.story and not slot0:IsClearStage(slot1) then
				slot7, slot8 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(slot2.sub_type)

				if slot7 <= slot8 then
					slot3 = true
					slot4 = GetTips("ACTIVITY_HERO_CHALLENGE_TIME_NULL")
				end
			end

			return slot3, slot4
		end
	end,
	CheckScheduleNeedCostTime = function (slot0, slot1)
		if BattleVerthandiExclusiveCfg[slot1] then
			slot3 = false
			slot4 = ""

			if slot2.sub_type == SpHeroChallengeConst.BattleSubType.story then
				return slot0:IsClearStage(slot1)
			else
				return false
			end
		end
	end,
	IsClearStage = function (slot0, slot1)
		if BattleVerthandiExclusiveCfg[slot1] then
			if slot2.sub_type == SpHeroChallengeConst.ScheduleSubType.story then
				return table.indexof(SPHeroChallengeData:GetCurActivityInfo().storyFinStageList, slot1)
			elseif slot2.sub_type == SpHeroChallengeConst.ScheduleSubType.train1 or slot2.sub_type == SpHeroChallengeConst.ScheduleSubType.train2 or slot2.sub_type == SpHeroChallengeConst.ScheduleSubType.train3 then
				if slot3.trainInfo[slot2.sub_type] then
					return table.indexof(slot3.trainInfo[slot2.sub_type].passStageList, slot1)
				else
					return false
				end
			end

			return true
		else
			Debug.LogError("未获取到关卡配置信息" .. slot1)
		end
	end,
	CalStageScore = function (slot0, slot1, slot2, slot3)
		return GameSetting.activity_hero_challenge_boss_basescore.value[1] - math.max(GameSetting.activity_hero_challenge_boss_timescore.value[2] - GameSetting.activity_hero_challenge_boss_timescore.value[1] * slot3, 0)
	end,
	GetTrainTypeName = function (slot0, slot1)
		return GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TYPE_" .. slot1)
	end,
	GetTrainPercentByStage = function (slot0, slot1, slot2)
		slot3 = BattleVerthandiExclusiveCfg[slot1].sub_type

		if SPHeroChallengeData:GetCurActivityInfo() then
			slot5 = slot0:GetTrainScoreByStage(slot1, slot2)
			slot6 = 0

			return slot5, math.ceil(slot5 / GameSetting.activity_hero_challenge_base_num.value[1] * 100)
		end
	end,
	GetTrainScoreByStage = function (slot0, slot1, slot2)
		slot3 = GameSetting["activity_hero_challenge_train_num_" .. slot2].value

		if SPHeroChallengeData:GetCurActivityInfo() then
			slot7 = -1

			for slot11, slot12 in ipairs(slot3) do
				if slot5:GetTrainNumByType(BattleVerthandiExclusiveCfg[slot1].sub_type) <= slot12[1] then
					slot7 = slot12[2]

					break
				end
			end

			if slot7 < 0 then
				slot7 = slot3[#slot3][2]
			end

			return slot7
		end
	end,
	GetChapterIsOpen = function (slot0, slot1)
		if ChapterCfg[slot1] then
			if slot2.unlock_activity_id and slot3 > 0 and not ActivityTools.GetActivityIsOpenWithTip(slot3, false) then
				return false, "SOLO_NOT_OPEN"
			end

			if SPHeroChallengeData:GetActivityID() and slot3 == SPHeroChallengeData.activityCfg[slot4].bossActivityID and not SPHeroChallengeData:GetCurActivityInfo().bossStart then
				return false, "SOLO_NOT_OPEN"
			end

			slot5 = {}

			if slot2.group == SpHeroChallengeConst.ChapterType.story then
				slot5 = ActivityHeroChallengeScheduleCfg[SpHeroChallengeConst.ScheduleID.Awake].pre_condition
			elseif slot6 == SpHeroChallengeConst.ChapterType.train then
				slot5 = ActivityHeroChallengeScheduleCfg[SpHeroChallengeConst.ScheduleID.Endurance].pre_condition
			elseif slot6 == SpHeroChallengeConst.ChapterType.boss then
				slot5 = ActivityHeroChallengeScheduleCfg[SpHeroChallengeConst.ScheduleID.Boss].pre_condition
			end

			slot7 = true
			slot8 = ""

			for slot12, slot13 in ipairs(slot5) do
				if not IsConditionAchieved(slot13) then
					return false, slot0:GetConditionDesc(slot13)
				end
			end

			return true
		else
			Debug.LogError("未获取到章节配置" .. slot1)
		end
	end,
	CheckBattleRouteIsOpen = function (slot0, slot1)
		if ActivityHeroChallengeScheduleCfg.get_id_list_by_server_type[slot1][1] then
			slot5 = true
			slot6 = ""

			for slot10, slot11 in ipairs(ActivityHeroChallengeScheduleCfg[slot2[1]].pre_condition) do
				if not IsConditionAchieved(slot11) then
					return false, slot0:GetConditionDesc(slot11)
				end
			end

			return slot5
		else
			Debug.LogError("未获取到战斗类型对应的日程" .. slot1)
		end
	end,
	GetStoryOpenStageList = function (slot0, slot1, slot2)
		slot4 = SPHeroChallengeData:GetCurActivityInfo().storyFinStageList or {}

		table.insert({}, ChapterCfg[slot1].section_id_list[1])

		for slot10, slot11 in ipairs(slot5) do
			if slot2[slot11].next_show_id_list == "" then
				slot13 = {}
			end

			if table.indexof(slot4, slot11) then
				table.insert(slot6, slot11)

				for slot17, slot18 in ipairs(slot13) do
					if not table.keyof(slot6, slot18) then
						table.insert(slot6, slot18)
					end
				end
			end
		end

		return slot6
	end,
	GetConditionDesc = function (slot0, slot1, slot2)
		if ConditionCfg[slot1] then
			if slot3.type == 11200 or slot3.type == 11201 or slot3.type == 11202 or slot3.type == 11204 or slot3.type == 11205 then
				return slot3.desc
			elseif slot3.type == 11203 then
				slot4 = BattleVerthandiExclusiveCfg[slot3.params[1]].name

				return string.format(GetI18NText(slot3.desc), slot3.params[2])
			elseif slot3.type == 11206 then
				return string.format(slot3.desc, slot3.params[2]), slot3.params[1], slot3.params[2]
			end
		end
	end,
	GetScheduleIcon = function (slot0, slot1)
		return getSpriteViaConfig("ActivityHeroChallengeScheduleIcon", slot1)
	end,
	GetScheduleTypeName = function (slot0, slot1)
		slot2 = nil

		if slot1 == 1 then
			slot2 = SpHeroChallengeConst.ScheduleTypeName.Battle
		elseif slot1 == 2 then
			slot2 = SpHeroChallengeConst.ScheduleTypeName.MiniGame
		elseif slot1 == 3 then
			slot2 = SpHeroChallengeConst.ScheduleTypeName.Entrust
		end

		if slot2 then
			return GetTips(slot2)
		end
	end,
	GetTrainNameAndIcon = function (slot0, slot1)
		slot1 = slot1 - 1

		return GetTips("ACTIVITY_HERO_CHALLENGE_TRAIN_NAME_" .. slot1), getSpriteViaConfig("ActivityHeroChallengeTrain", "heroChallenge_icon_potential" .. slot1)
	end,
	GetBarbuceGameAwardRefreshTime = function (slot0)
		return string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:GetLostTimeStrWith2Unit(manager.time:GetNextFreshTime()))
	end,
	GetBarbuceStageIDByDiff = function (slot0, slot1, slot2)
		for slot6, slot7 in ipairs(ActivityHeroChallengeBarbecueCfg.all) do
			if ActivityHeroChallengeBarbecueCfg[slot7].difficult == slot1 and slot2 == slot8.activity_id then
				return slot7
			end
		end
	end,
	GetBarbecueAwardIndex = function (slot0, slot1, slot2)
		if ActivityHeroChallengeBarbecueCfg[slot1] then
			slot4 = 0

			for slot8, slot9 in ipairs(slot3.reward_list_coin) do
				if slot2 <= slot9[2] then
					slot4 = slot8
				end
			end

			if slot4 == 0 then
				slot4 = #slot3.reward_list_coin
			end

			return slot4
		else
			Debug.LogError("未获取到烤肉关卡配置信息" .. slot1)
		end
	end,
	CheckBossActivityIsOpen = function (slot0)
		slot1 = SPHeroChallengeData:GetActivityID()

		if slot1 then
			if ActivityTools.GetActivityIsOpenWithTip(SPHeroChallengeData.activityCfg[slot1].bossActivityID, false) and SPHeroChallengeData:GetCurActivityInfo().bossStart then
				return true
			end
		end
	end
}
