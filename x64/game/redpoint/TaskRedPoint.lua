return {
	InitRedUpdater = function (slot0)
		if not slot0.redUpdater then
			slot0.redUpdater = {
				[TaskConst.TASK_TYPE.ALPHA] = handler(slot0, slot0.UpdateNewbieTaskRedPoint),
				[TaskConst.TASK_TYPE.DAILY_OFFER] = handler(slot0, slot0.UpdateNewbieDailyTaskRedTip),
				[TaskConst.TASK_TYPE.NOOB] = handler(slot0, slot0.UpdateNoobTaskRedPoint),
				[TaskConst.TASK_TYPE.NOOB_ADVANCE] = handler(slot0, slot0.UpdateNoobAdvanceTaskRedPoint),
				[TaskConst.TASK_TYPE.NOOB_3_0] = handler(slot0, slot0.UpdateNoobTaskRedPoint),
				[TaskConst.TASK_TYPE.NOOB_ADVANCE_3_0_1] = handler(slot0, slot0.UpdateNoobAdvanceTaskRedPoint),
				[TaskConst.TASK_TYPE.NOOB_ADVANCE_3_0_2] = handler(slot0, slot0.UpdateNoobAdvanceTaskRedPoint),
				[TaskConst.TASK_TYPE.NOOB_ADVANCE_3_0_3] = handler(slot0, slot0.UpdateNoobAdvanceTaskRedPoint),
				[TaskConst.TASK_TYPE.DAILY] = handler(slot0, slot0.UpdateDailyTaskRedTip),
				[TaskConst.TASK_TYPE.PLOT] = handler(slot0, slot0.UpdatePlotTaskRedTip),
				[TaskConst.TASK_TYPE.CLUB_TASK] = handler(slot0, slot0.UpdateClubTaskRedTip),
				[TaskConst.TASK_TYPE.WEEK] = handler(slot0, slot0.UpdateWeekTaskRedTip),
				[TaskConst.TASK_TYPE.CHAPTER_PLOT_19] = handler(slot0, slot0.UpdateChapterPlot19RedTip),
				[TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY] = handler(slot0, slot0.UpdateIdolTraineeDayAndWeekRedTip),
				[TaskConst.TASK_TYPE.IDOL_TRAINEE_WEEKLY] = handler(slot0, slot0.UpdateIdolTraineeDayAndWeekRedTip),
				[TaskConst.TASK_TYPE.IDOL_TRAINEE_CHAPTER] = handler(slot0, slot0.UpdateIdolTraineeChapterRedTip)
			}
		end
	end,
	StartUpdateRedPointPhase = function (slot0, slot1)
		slot0:InitRedUpdater()

		slot2 = {}
		slot3 = {}

		for slot7, slot8 in ipairs(slot1) do
			if AssignmentCfg[slot8.id] == nil then
				Debug.LogError("TaskCfg没有对应ID:" .. slot8.id)
			elseif slot9.activity_id and slot9.activity_id ~= 0 then
				slot3[slot9.activity_id] = slot3[slot9.activity_id] or {}

				table.insert(slot3[slot9.activity_id], slot8.id)
			else
				slot2[slot9.type] = slot2[slot9.type] or {}

				table.insert(slot2[slot9.type], slot8.id)
			end
		end

		for slot7, slot8 in pairs(slot2) do
			if slot0.redUpdater[slot7] then
				slot9(slot8)
			end
		end

		slot0:UpdateActivityRed(slot3)
		slot0:UpdatePassportTaskRedTip()
	end,
	UpdateActivityRed = function (slot0, slot1)
		for slot5, slot6 in pairs(slot1) do
			slot8 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot5)
			slot9 = 0

			for slot13, slot14 in pairs(TaskData2:GetActivityTaskSortList(slot5)) do
				if AssignmentCfg[slot14.id].need <= slot14.progress and slot14.complete_flag < 1 then
					slot9 = 1

					break
				end
			end

			manager.redPoint:setTip(slot8, slot9)
		end
	end,
	UpdatePassportTaskRedTip = function (slot0)
		if not (PassportData:IsOpen() and PassportData:IsUnlock()) then
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_7, 0)
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_8, 0)
			manager.redPoint:setTip(RedPointConst.PASSPORT_TASK_BONUS_9, 0)
		else
			slot2 = GameSetting.battlepass_exp_limit_weekly.value[1] <= PassportData:GetExpWeekly()
			slot4 = PassportData:GetLevel() >= #BattlePassCfg.get_id_list_by_type[BattlePassListCfg[PassportData:GetId()].battlepass_type]
			slot6 = manager.time:GetServerTime()

			for slot10, slot11 in ipairs({
				TaskConst.TASK_TYPE.PASSPORT_DAILY,
				TaskConst.TASK_TYPE.PASSPORT_WEEKLY
			}) do
				for slot17, slot18 in ipairs(TaskTools:GetFinishTaskIds(slot11)) do
					if (TaskData2:GetTask(slot18).expired_timestamp or 0) > 0 and slot20 - slot6 > 0 or slot20 == 0 then
						slot12 = 0 + 1
					end
				end

				manager.redPoint:setTip(RedPointConst["PASSPORT_TASK_BONUS_" .. slot11], slot12 > 0 and not slot2 and not slot4 and 1 or 0)
			end

			for slot11, slot12 in ipairs({
				TaskConst.TASK_TYPE.PASSPORT_CHALLENGE
			}) do
				for slot18, slot19 in ipairs(TaskTools:GetFinishTaskIds(slot12)) do
					if (TaskData2:GetTask(slot19).expired_timestamp or 0) > 0 and slot21 - slot6 > 0 or slot21 == 0 then
						slot13 = 0 + 1
					end
				end

				manager.redPoint:setTip(RedPointConst["PASSPORT_TASK_BONUS_" .. slot12], slot13 > 0 and not slot4 and 1 or 0)
			end
		end
	end,
	UpdateWeekTaskRedTip = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_WEEK) then
			manager.redPoint:setTip(RedPointConst.TASK_WEEK, 0)

			return false
		end

		for slot5, slot6 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.WEEK)) do
			slot7 = TaskData2:GetTask(slot5)

			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_WEEK, 1)

				return true
			end
		end

		for slot6 = 1, #ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].target do
			if slot2.target[slot6] <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_WEEK_ACTIVITY_PT) and not ActivityPtData:GetDailyGetRewardList()[ActivityPtConst.TASK_WEEK_ACTIVITY_PT][slot2.target[slot6]] then
				manager.redPoint:setTip(RedPointConst.TASK_WEEK, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_WEEK, 0)

		return false
	end,
	UpdateClubTaskRedTip = function (slot0)
		slot1 = GuildData:GetGuildInfo()

		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CLUB_TASK) or slot1 == nil or slot1.id == nil then
			manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)

			return false
		end

		for slot6, slot7 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.CLUB_TASK)) do
			slot8 = TaskData2:GetTask(slot6)

			if AssignmentCfg[slot8.id].need <= slot8.progress and slot8.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.CLUB_TASK, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)

		return false
	end,
	UpdatePlotTaskRedTip = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_PLOT) then
			manager.redPoint:setTip(RedPointConst.TASK_PLOT, 0)

			return false
		end

		for slot5, slot6 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.PLOT)) do
			slot7 = TaskData2:GetTask(slot5)

			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_PLOT, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_PLOT, 0)

		return false
	end,
	UpdateDailyTaskRedTip = function (slot0)
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TASK_DAILY) then
			manager.redPoint:setTip(RedPointConst.TASK_DAILY, 0)

			return false
		end

		for slot5, slot6 in pairs(TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.DAILY)) do
			if TaskData2:GetTask(slot5) and AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.TASK_DAILY, 1)

				return true
			end
		end

		for slot6 = 1, #ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].target do
			if slot2.target[slot6] <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) and not ActivityPtData:GetDailyGetRewardList()[ActivityPtConst.TASK_DAILY_ACTIVITY_PT][slot2.target[slot6]] then
				manager.redPoint:setTip(RedPointConst.TASK_DAILY, 1)

				return true
			end
		end

		manager.redPoint:setTip(RedPointConst.TASK_DAILY, 0)

		return false
	end,
	UpdateNewbieTaskRedPoint = function (slot0)
		for slot6, slot7 in pairs(TaskTools:GetNewbieTaskSortList(TaskData2:GetAssignmentPhase())) do
			if AssignmentCfg[slot7.id].need <= slot7.progress and slot7.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

				return
			end
		end

		if TaskTools:GetNewbiePhaseTask()[slot1] and AssignmentCfg[slot3.id] and slot4.need <= slot3.progress and slot3.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

			return
		end

		manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 0)
	end,
	UpdateNewbieDailyTaskRedTip = function (slot0)
		for slot5, slot6 in pairs(TaskData2:GetTypedTaskSortList(TaskConst.TASK_TYPE.DAILY_OFFER)) do
			if AssignmentCfg[slot6.id].need <= slot6.progress and slot6.complete_flag < 1 then
				manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 0)
	end,
	UpdateNoobTaskRedPoint = function (slot0, slot1)
		slot2 = nil
		slot3 = {}

		for slot7, slot8 in ipairs(slot1) do
			if AssignmentCfg[slot8] == nil then
				print("TaskCfg没有对应ID:" .. slot8)
			else
				slot2 = slot9.type
				slot3[slot9.phase] = true
			end
		end

		for slot7, slot8 in pairs(slot3) do
			slot0:UpdateNoobTaskRed(slot2, slot7)
		end
	end,
	UpdateNoobTaskRed = function (slot0, slot1, slot2)
		slot8 = slot2

		for slot8, slot9 in pairs(TaskTools:GetNoobTaskSortList(slot1, slot8)) do
			if AssignmentCfg[slot9.id].phase <= ActivityNoobData:GetUnlockPhase() and AssignmentCfg[slot9.id].need <= slot9.progress and slot9.complete_flag < 1 then
				manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot2), 1)

				return
			end
		end

		manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, slot2), 0)
	end,
	UpdateNoobTaskRedFull = function (slot0, slot1)
		for slot6 = 1, ActivityNoobData:GetUnlockPhase() do
			slot0:UpdateNoobTaskRed(slot1, slot6)
		end
	end,
	UpdateNoobAdvanceTaskRedPoint = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			if AssignmentCfg[slot7] == nil then
				print("TaskCfg没有对应ID:" .. slot7)
			else
				slot2[slot8.type] = slot2[slot8.type] or {}
				slot2[slot8.type][slot8.phase] = true
			end
		end

		for slot6, slot7 in pairs(slot2) do
			if ActivityNewbieTools.IsDataInited() and ActivityNewbieTools.CheckAdvanceTaskTypeOpen(slot6) then
				for slot11, slot12 in pairs(slot7) do
					slot0:UpdateNoobAdvanceTaskRed(slot6, slot11)
				end
			end
		end
	end,
	UpdateNoobAdvanceTaskRed = function (slot0, slot1, slot2)
		slot3 = ActivityNewbieTools.GetAdvanceTaskCfg(slot1)

		for slot9, slot10 in ipairs(NoobAdvanceTaskPhaseListCfg[NoobVersionCfg[slot3.versionID].noob_advance_task_phase[slot3.index]].phase_list) do
			for slot14, slot15 in ipairs(slot10[2]) do
				if slot15[1] == slot2 then
					slot16 = slot9
					slot21 = slot2

					for slot21, slot22 in pairs(TaskTools:GetNoobAdvanceTaskSortList(slot1, slot21)) do
						if AssignmentCfg[slot22.id].need <= slot22.progress and slot22.complete_flag == 0 then
							manager.redPoint:setTip(string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, slot1, slot16, slot2), 1)

							return
						end
					end

					manager.redPoint:setTip(string.format("%s_%d_%d_%d", RedPointConst.NOOB_ADVANCE, slot1, slot16, slot2), 0)

					return
				end
			end
		end
	end,
	UpdateChapterPlot19RedTip = function (slot0)
		if ChapterTools.IsFinishPreChapter(ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_19].chapter_list[1]) then
			for slot5, slot6 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19] or {}) do
				if not TaskData2:GetTaskComplete(slot6) and AssignmentCfg[slot6].need <= TaskData2:GetTaskProgress(slot6) then
					manager.redPoint:setTip(RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR, 1)

					return
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR, 0)
	end,
	UpdateIdolTraineeDayAndWeekRedTip = function (slot0)
		for slot4, slot5 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY] or {}) do
			if not TaskData2:GetTaskComplete(slot5) and AssignmentCfg[slot5].need <= TaskData2:GetTaskProgress(slot5) then
				manager.redPoint:setTip(RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK, 1)

				return
			end
		end

		for slot4, slot5 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.IDOL_TRAINEE_WEEKLY] or {}) do
			if not TaskData2:GetTaskComplete(slot5) and AssignmentCfg[slot5].need <= TaskData2:GetTaskProgress(slot5) then
				manager.redPoint:setTip(RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK, 1)

				return
			end
		end

		manager.redPoint:setTip(RedPointConst.IDOL_TRAINEE_DAY_AND_WEEK_TASK, 0)
	end,
	UpdateIdolTraineeChapterRedTip = function (slot0)
		slot1 = false

		for slot5, slot6 in ipairs(IdolTraineeChapterCfg.all) do
			slot1 = false

			for slot11, slot12 in ipairs(IdolTraineeChapterCfg[slot6].section_id_list) do
				if slot1 then
					break
				end

				for slot17, slot18 in ipairs(IdolTraineePveBattleCfg[slot12].taskIDList) do
					if slot1 then
						break
					end

					if not TaskData2:GetTaskComplete(slot18) and AssignmentCfg[slot18].need <= TaskData2:GetTaskProgress(slot18) then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, slot6), 1)

						slot1 = true
					end
				end
			end

			if not slot1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.IDOL_TRAINEE_CHAPTER_TASK, slot6), 0)
			end
		end
	end
}
