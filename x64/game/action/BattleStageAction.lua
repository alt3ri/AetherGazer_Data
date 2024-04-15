manager.net:Bind(24009, function (slot0)
	slot4 = slot0.user_chapter_list

	BattleStageData:InitPlotData(slot4)

	for slot4, slot5 in ipairs(slot0.user_chapter_list) do
		slot6 = slot5.id
		slot7 = getChapterIDByStageID(slot6)
		slot8 = ChapterCfg[slot7]
		slot9 = BattleStageTools.GetStageCfg(ChapterCfg[slot7].type, slot6)

		if slot5.clear_times > 0 and StageTools.GetStageArchiveID(slot6) and slot10 ~= 0 and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + slot10) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, slot10), 1)
		end

		uv0.CheckStageRedPoint(slot6)
	end

	TaskRedPoint:UpdateDailyTaskRedTip()
	uv0.UpdateRedPoint()
	uv0.UpdateSubPlotRedPoint()
end)
manager.net:Bind(24017, function (slot0)
	BattleStageData:InitChapterStarReward(slot0.gain_list)
	uv0.UpdateRedPoint()
end)

slot1 = nil

manager.net:Bind(24029, function (slot0)
	BattleStageData:InitMapLocation(slot0)
end)
manager.net:Bind(24033, function (slot0)
	if isSuccess(slot0.result) then
		slot1 = slot0.clue_location.location_id

		BattleStageData:UpdateClueLocationData(slot0.map_id, slot1, slot0.clue_location.clue_id)
		manager.notify:Invoke(CHAPTER_GET_CLUE, slot1)
	else
		ShowTips(slot0.result)
	end
end)

return {
	GetChapterStarReward = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(24014, {
			id = slot0,
			treasure_id = slot1
		}, 24015, function (slot0)
			uv0(slot0)
			uv1.UpdateChapterRedPoint(uv2)
		end)
	end,
	ClientModifyThreeStar = function (slot0, slot1)
		if GameSetting.newbie_unlock_level_id.value[1] == slot0 and BattleStageData:GetStageData()[slot0].clear_times <= 1 then
			ActivityNewbieData:SetNewbieOpenTime(manager.time:GetServerTime())
		end

		BattleStageData:ClientModifyThreeStar(slot0, slot1)
		uv0.UpdateChapterRedPoint(getChapterAndSectionID(slot0))
	end,
	ClickChapterArchive = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_CHAPTER_ARCHIVE, slot0), 0)

		if not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + slot0) then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_STAGE_ARCHIVE_RANGE + slot0)
		end
	end,
	UpdateRedPoint = function ()
		slot2 = BattleStageData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetChapterStarList(slot4)) do
			uv0.UpdateChapterRedPoint(slot3)
		end

		TaskRedPoint:UpdateChapterPlot19RedTip()
	end,
	UpdateActivityRedPoint = function ()
		slot2 = BattleStageData
		slot4 = slot2

		for slot3, slot4 in pairs(slot2.GetStageData(slot4)) do
			uv0.CheckStageRedPoint(slot3)
		end
	end,
	CheckStageRedPoint = function (slot0)
		if BattleStageData:GetStageData()[slot0].clear_times <= 0 then
			slot4 = nil
			slot5 = true

			if ((ChapterCfg[getChapterIDByStageID(slot0)].unlock_activity_id == 0 or slot3.unlock_activity_id) and slot3.activity_id) == 0 or ActivityTools.GetActivityStatus(slot4) ~= 1 then
				slot5 = false
			end

			if table.keyof(slot3.section_id_list, slot0) == 1 and slot5 and slot4 and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + slot4) and ChapterTools.IsFinishPreChapter(slot2) then
				manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(slot3.activity_id), slot4), 1)
			else
				manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(slot3.activity_id), slot4), 0)
			end
		end
	end,
	UpdateSubPlotRedPoint = function ()
		if PlayerData:GetPlayerInfo().userLevel < GameSetting.sub_plot_unlock_level.value[1] then
			return
		end

		for slot4, slot5 in pairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT] or {}) do
			for slot10, slot11 in pairs(ChapterClientCfg[slot5].chapter_list) do
				if not ChapterTools.IsClearChapter(slot11) then
					if not ChapterTools.IsClearFirstStage(slot11) and BattleStageData:GetSubPlotRedPointFlag(slot11) ~= 1 and BattleStageData:GetStageData()[ChapterCfg[slot11].section_id_list[1]] then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot11), 1)

						slot13 = ChapterCfg[slot11].activity_id
						slot14 = ActivityData:GetActivityRefreshTime(slot13)

						if slot13 ~= 0 and ActivityTools.GetActivityStatus(slot13) == 1 and (slot14 == 0 or manager.time:GetServerTime() <= slot14) and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + slot13) then
							manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot13) .. slot13, 1)

							break
						end
					end

					if slot13 ~= 0 then
						manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot13) .. slot13, 0)
					end

					break
				end
			end

			uv0.UpdateExtraStoryRedPoint(slot5)
		end
	end,
	UpdateExtraStoryRedPoint = function (slot0)
		if ChapterClientCfg[slot0].extra_story_unlock_condition ~= "" and isMeetAllCondition(slot1.extra_story_unlock_condition) and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, slot0), 1)
		end
	end,
	ClickSubPlot = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, slot0), 0)

		if ChapterCfg[slot0].activity_id ~= 0 then
			RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + slot2)
			manager.redPoint:setTip(ActivityTools.GetRedPointKey(slot2) .. slot2, 0)
		end

		BattleStageData:SetSubPlotRedPointFlag(slot0)
	end,
	ClickSubPlotExtraStory = function (slot0)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_EXTRA_STORY, slot0), 0)

		if ChapterClientCfg[slot0].extra_story_unlock_condition ~= "" and isMeetAllCondition(slot2.extra_story_unlock_condition) and not RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + slot0) then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_EXTRA_STORY_RANGE + slot0)
		end
	end,
	UpdateChapterRedPoint = function (slot0)
		if not ChapterTools.IsFinishPreChapter(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot0), 0)

			return
		end

		if getChapterClientCfgByChapterID(slot0) == nil then
			return
		end

		if getChapterToggle(slot1.id) == BattleConst.TOGGLE.PLOT then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot0), BattleStageData:GetChapterRedPointNotice(slot0) and 1 or 0)
		end
	end,
	AddActivityTimer = function ()
		uv0.UpdateRedPoint()

		slot1 = {
			[slot7] = ActivityData:GetActivityData(slot7):IsActivitying()
		}

		for slot5, slot6 in ipairs(ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]) do
			if ChapterCfg[slot6].activity_id ~= 0 then
				-- Nothing
			end
		end

		uv1 = Timer.New(function ()
			slot0 = false

			for slot4, slot5 in pairs(uv0) do
				if slot5 ~= ActivityData:GetActivityData(slot4):IsActivitying() then
					uv0[slot4] = slot7
					slot0 = true
				end
			end

			if slot0 then
				uv1.UpdateRedPoint()
			end
		end, 1, -1)

		uv1:Start()
	end,
	RemoveActivityTimer = function ()
		if uv0 then
			uv0:Stop()

			uv0 = nil
		end
	end,
	ScanClueLocation = function (slot0, slot1)
		manager.net:SendWithLoadingNew(24030, {
			map_id = slot0
		}, 24031, function (slot0)
			if isSuccess(slot0.result) then
				for slot4, slot5 in ipairs(slot0.location_id_list) do
					BattleStageData:ScanClueLocationData(uv0, slot5)
				end

				uv1(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	GetClueLocation = function (slot0)
		manager.net:Push(24032, {
			location_id = slot0
		})
	end,
	UpdateLocationEvent = function (slot0)
		if BattleStageData:HasReadLocationEvent(slot0) then
			return
		end

		manager.net:Push(24034, {
			event_id = slot0
		})
		BattleStageData:UpdateLocationEvent(slot0)
	end,
	OperateChapterDay = function (slot0, slot1, slot2)
		manager.net:Push(24036, {
			detector_info = {
				status = 1,
				chapter_id = slot0,
				day = slot1
			}
		})
		BattleStageData:SetOperateChapterDay(slot0, slot1)
		slot2()
	end,
	ReadLoacationClue = function (slot0, slot1, slot2)
		if ChapterTools.IsReadClue(slot0, slot1) then
			return
		end

		manager.net:Push(24038, {
			clue_id = slot2
		})
		BattleStageData:UpdateClueLocationData(slot0, slot1, slot2)
	end
}
