local var_0_0 = {}

function var_0_0.IsFinishPreChapter(arg_1_0)
	local var_1_0 = ChapterCfg[arg_1_0]

	if var_1_0 == nil then
		return false, arg_1_0
	end

	local var_1_1 = var_1_0.pre_chapter
	local var_1_2 = var_1_0.activity_id

	if var_1_0.unlock_activity_id ~= 0 and not ActivityData:GetActivityIsOpen(var_1_0.unlock_activity_id) then
		return false, -2
	end

	if ActivityData:GetActivityIsOpen(var_1_2) then
		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			if var_1_2 == ChapterCfg[iter_1_1].activity_id and var_0_0.IsClearChapter(iter_1_1) == false then
				return false, iter_1_1
			end
		end

		if GameSetting.activity_main_plot_unlock_level.value[1] > PlayerData:GetPlayerInfo().userLevel then
			return false, -1
		end

		return true
	end

	return var_0_0.IsFinishAllPreChapter(arg_1_0)
end

function var_0_0.IsFinishAllPreChapter(arg_2_0)
	local var_2_0 = ChapterCfg[arg_2_0].pre_chapter

	if var_2_0 == "" then
		return true
	end

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_1 = ChapterCfg[iter_2_1]

		if type(var_2_1.pre_chapter) ~= "table" then
			return true
		end

		if not var_0_0.IsFinishPreChapterWithoutActivity(iter_2_1) then
			return false, iter_2_1
		end

		local var_2_2 = var_2_1.section_id_list[#var_2_1.section_id_list]
		local var_2_3 = BattleStageData:GetStageData()[var_2_2]

		if var_2_3 == nil or var_2_3.clear_times <= 0 then
			return false, iter_2_1
		end
	end

	return true
end

function var_0_0.IsFinishPreChapterWithoutActivity(arg_3_0)
	if ChapterCfg[arg_3_0] == nil then
		return false, arg_3_0
	end

	return var_0_0.IsFinishAllPreChapter(arg_3_0)
end

function var_0_0.GetChapterLockText(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == -1 then
		return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1])
	end

	if arg_4_1 == -2 then
		local var_4_0 = ChapterCfg[arg_4_0]
		local var_4_1 = ActivityData:GetActivityData(var_4_0.unlock_activity_id)

		return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_4_1.startTime))
	end

	local var_4_2 = ChapterCfg[arg_4_1]

	if var_4_2.difficulty == 1 and not arg_4_2 then
		return "NEED_FINISH_PRE_NORMAL_STAGE"
	end

	local var_4_3 = ChapterClientCfg[var_4_2.clientID]

	return string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[var_4_2.difficulty]), GetI18NText(var_4_3.desc))
end

function var_0_0.GetOptimalChapterClientID(arg_5_0)
	if arg_5_0 and GameSetting.activity_main_plot_unlock_level.value[1] > PlayerData:GetPlayerInfo().userLevel then
		return var_0_0.GetClearMaxChapterClientID(), 0
	end

	local var_5_0 = getChapterClientList()[1]

	for iter_5_0 = #var_5_0, 1, -1 do
		local var_5_1 = var_5_0[iter_5_0]
		local var_5_2, var_5_3 = var_0_0.IsOpenChapterClientID(var_5_1)

		if var_5_2 then
			return var_5_1, var_5_3
		end
	end

	return var_0_0.GetClearMaxChapterClientID(), 0
end

function var_0_0.IsOpenChapterClientID(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(ChapterClientCfg[arg_6_0].chapter_list) do
		local var_6_0 = ChapterCfg[iter_6_1].activity_id

		if var_6_0 ~= 0 and ActivityData:GetActivityIsOpen(var_6_0) then
			return true, var_6_0
		end
	end

	return false
end

function var_0_0.GetClearMaxChapterClientID()
	local var_7_0 = getChapterClientList()[1]
	local var_7_1 = var_7_0[1]

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_2 = ChapterClientCfg[iter_7_1].chapter_list[1]
		local var_7_3 = ChapterCfg[var_7_2].section_id_list[1]

		if BattleStageData:GetStageData()[var_7_3] and var_0_0.IsClearChapterClient(var_7_1) and var_0_0.IsUnlockChapter(var_7_2) then
			var_7_1 = iter_7_1
		else
			return var_7_1
		end
	end

	return var_7_0[#var_7_0]
end

function var_0_0.GetChapterTotalStarCnt(arg_8_0)
	if ChapterCfg[arg_8_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		return #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]
	end

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(ChapterCfg[arg_8_0].section_id_list) do
		var_8_0 = var_8_0 + #BattleChapterStageCfg[iter_8_1].three_star_need
	end

	return var_8_0
end

function var_0_0.GetChapterStarCnt(arg_9_0)
	if ChapterCfg[arg_9_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		local var_9_0 = 0

		for iter_9_0, iter_9_1 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]) do
			local var_9_1 = AssignmentCfg[iter_9_1]
			local var_9_2 = TaskData2:GetTask(iter_9_1)

			if var_9_2 and var_9_2.progress >= var_9_1.need then
				var_9_0 = var_9_0 + 1
			end
		end

		return var_9_0
	end

	return BattleStageData:GetChapterStarCnt(arg_9_0)
end

function var_0_0.GetChapterStarPercentage(arg_10_0)
	local var_10_0 = var_0_0.GetChapterTotalStarCnt(arg_10_0)

	return var_0_0.GetChapterStarCnt(arg_10_0) / var_10_0
end

function var_0_0.GetChapterClientTotalStarCnt(arg_11_0)
	local var_11_0 = ChapterClientCfg[arg_11_0]
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0.chapter_list) do
		var_11_1 = var_11_1 + var_0_0.GetChapterTotalStarCnt(iter_11_1)
	end

	return var_11_1
end

function var_0_0.GetChapterClientStarCnt(arg_12_0)
	local var_12_0 = ChapterClientCfg[arg_12_0]
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_0.chapter_list) do
		var_12_1 = var_12_1 + var_0_0.GetChapterStarCnt(iter_12_1)
	end

	return var_12_1
end

function var_0_0.GetChapterClientStarPercentage(arg_13_0)
	local var_13_0 = var_0_0.GetChapterClientTotalStarCnt(arg_13_0)

	return var_0_0.GetChapterClientStarCnt(arg_13_0) / var_13_0
end

function var_0_0.GetSubPlotFinishPercentage(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = BattleStageData:GetStageData()

	for iter_14_0, iter_14_1 in ipairs(ChapterClientCfg[arg_14_0].chapter_list) do
		local var_14_3 = ChapterCfg[iter_14_1]

		var_14_0 = var_14_0 + #var_14_3.section_id_list

		for iter_14_2, iter_14_3 in ipairs(var_14_3.section_id_list) do
			if var_14_2[iter_14_3] and var_14_2[iter_14_3].clear_times > 0 then
				var_14_1 = var_14_1 + 1
			end
		end
	end

	local var_14_4 = WarchessLevelCfg.get_id_list_by_chapter_tag[arg_14_0]

	if var_14_4 ~= nil then
		for iter_14_4, iter_14_5 in pairs(var_14_4) do
			var_14_0 = var_14_0 + 1

			if ChessTools.GetChapterProgress(iter_14_5) >= 100 then
				var_14_1 = var_14_1 + 1
			end
		end
	end

	return var_14_1 / var_14_0
end

function var_0_0.GetChapterClientFinishPercentage(arg_15_0)
	local var_15_0 = ChapterClientCfg[arg_15_0]

	if var_15_0.toggle == BattleConst.TOGGLE.PLOT then
		return var_0_0.GetChapterClientStarPercentage(arg_15_0)
	elseif var_15_0.toggle == BattleConst.TOGGLE.SUB_PLOT then
		return var_0_0.GetSubPlotFinishPercentage(arg_15_0)
	else
		return 0
	end
end

function var_0_0.GetChapterByActivityID(arg_16_0)
	local var_16_0 = ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if ChapterCfg[iter_16_1].activity_id == arg_16_0 then
			table.insert(var_16_1, iter_16_1)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		if not var_0_0.IsClearChapter(iter_16_3) then
			return iter_16_3
		end
	end

	return var_16_1[1]
end

function var_0_0.IsClearChapterClient(arg_17_0)
	local var_17_0 = ChapterClientCfg[arg_17_0].chapter_list
	local var_17_1 = var_17_0[#var_17_0]

	return var_0_0.IsClearChapter(var_17_1)
end

function var_0_0.IsClearChapter(arg_18_0)
	if ChapterCfg[arg_18_0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
		local var_18_0 = ChapterMapCfg.get_id_list_by_chapter_id[arg_18_0]
		local var_18_1 = ChapterMapCfg[#var_18_0].location_list

		for iter_18_0, iter_18_1 in ipairs(locationlist) do
			for iter_18_2, iter_18_3 in ipairs(ChapterLocationCfg[iter_18_1].stage_list) do
				if not var_0_0.IsClearStage(iter_18_3) then
					return false
				end
			end
		end

		return true
	end

	local var_18_2 = ChapterCfg[arg_18_0].section_id_list
	local var_18_3 = var_18_2[#var_18_2]

	return var_0_0.IsClearStage(var_18_3)
end

function var_0_0.IsClearFirstStage(arg_19_0)
	local var_19_0 = ChapterCfg[arg_19_0].section_id_list[1]

	return var_0_0.IsClearStage(var_19_0)
end

function var_0_0.IsClearStage(arg_20_0)
	local var_20_0 = BattleStageData:GetStageData()[arg_20_0]

	if var_20_0 == nil or var_20_0.clear_times <= 0 then
		return false
	end

	return true
end

function var_0_0.HasChapterStage(arg_21_0)
	local var_21_0 = ChapterClientCfg[arg_21_0].chapter_list[1]

	return #ChapterCfg[var_21_0].section_id_list > 0
end

function var_0_0.IsUnlockChapter(arg_22_0)
	local var_22_0 = ChapterCfg[arg_22_0]
	local var_22_1 = var_22_0.sub_type
	local var_22_2 = var_22_0.unlock_activity_id

	if var_22_0.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		var_22_2 = var_22_0.activity_id

		if var_22_2 ~= 0 then
			local var_22_3 = ActivityData:GetActivityRefreshTime(var_22_2)
			local var_22_4 = manager.time:GetServerTime()

			if ActivityTools.GetActivityStatus(var_22_2) == 1 and var_22_3 ~= 0 and var_22_4 < var_22_3 then
				return false
			end
		end
	elseif var_22_2 ~= 0 then
		local var_22_5 = ActivityData:GetActivityData(var_22_2)

		if manager.time:GetServerTime() < var_22_5.startTime then
			return false
		end
	end

	if var_22_1 == 13 and arg_22_0 == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
		return false
	end

	return true
end

function var_0_0.GetChapterIDByClient(arg_23_0)
	local var_23_0 = ChapterClientCfg[arg_23_0]
	local var_23_1 = var_23_0.chapter_list[1]

	for iter_23_0, iter_23_1 in ipairs(var_23_0.chapter_list) do
		if not ChapterTools.IsUnlockChapter(iter_23_1) then
			return var_23_1
		end

		local var_23_2 = table.keyof(var_23_0.chapter_list, iter_23_1)

		if var_23_2 > 1 then
			local var_23_3 = var_23_0.chapter_list[var_23_2 - 1]

			if not ChapterTools.IsClearChapter(var_23_3) then
				return var_23_1
			end
		end

		if #ChapterCfg[iter_23_1].section_id_list <= 0 then
			return var_23_1
		end

		var_23_1 = iter_23_1
	end

	return var_23_1
end

function var_0_0.GetNeighborClientID(arg_24_0, arg_24_1)
	local var_24_0 = ChapterClientCfg[arg_24_0]
	local var_24_1 = {}

	if var_24_0.toggle == BattleConst.TOGGLE.PLOT then
		local var_24_2 = var_24_0.difficulty

		var_24_1 = getChapterClientList()[var_24_2]
	elseif var_24_0.toggle == BattleConst.TOGGLE.SUB_PLOT then
		var_24_1 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]
	end

	local var_24_3 = table.keyof(var_24_1, arg_24_0)

	if arg_24_1 and var_24_3 < #var_24_1 then
		var_24_3 = var_24_3 + 1
	elseif not arg_24_1 and var_24_3 > 1 then
		var_24_3 = var_24_3 - 1
	end

	return var_24_1[var_24_3]
end

function var_0_0.GetUnclearStageCnt(arg_25_0)
	local var_25_0 = ChapterCfg[arg_25_0]
	local var_25_1 = #var_25_0.section_id_list

	for iter_25_0, iter_25_1 in ipairs(var_25_0.section_id_list) do
		local var_25_2 = BattleStageData:GetStageData()[iter_25_1]

		if var_25_2 and var_25_2.clear_times > 0 then
			var_25_1 = var_25_1 - 1
		else
			return var_25_1
		end
	end

	return var_25_1
end

function var_0_0.GetOpenStageList(arg_26_0, arg_26_1)
	local var_26_0 = BattleStageData:GetStageData()
	local var_26_1 = ChapterCfg[arg_26_0].section_id_list
	local var_26_2 = {}

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		if var_26_0[iter_26_1] then
			if table.keyof(var_26_2, iter_26_1) or iter_26_1 == GameSetting.travel_skuld_new_ending_stage_id.value[1] and var_26_0[iter_26_1].clear_times < 1 then
				-- block empty
			else
				table.insert(var_26_2, iter_26_1)
			end

			if var_26_0[iter_26_1].clear_times > 0 then
				local var_26_3 = arg_26_1[iter_26_1].next_show_id_list

				if var_26_3 == "" then
					var_26_3 = {}
				end

				for iter_26_2, iter_26_3 in ipairs(var_26_3) do
					if not table.keyof(var_26_2, iter_26_3) then
						if iter_26_3 == GameSetting.travel_skuld_new_ending_stage_id.value[1] then
							if not var_26_0[iter_26_3] or var_26_0[iter_26_3] and var_26_0[iter_26_3].clear_times < 1 then
								-- block empty
							else
								table.insert(var_26_2, iter_26_3)
							end
						else
							table.insert(var_26_2, iter_26_3)
						end
					end
				end
			end
		end
	end

	return var_26_2
end

function var_0_0.GetActivityChapterIndex(arg_27_0)
	local var_27_0
	local var_27_1
	local var_27_2
	local var_27_3 = 1

	for iter_27_0 = #arg_27_0, 1, -1 do
		local var_27_4 = arg_27_0[iter_27_0]
		local var_27_5, var_27_6, var_27_7 = var_0_0.GetDeltaTime(var_27_4[2])

		if var_27_0 == nil then
			var_27_0, var_27_1, var_27_2 = var_27_5, var_27_6, var_27_7
			var_27_3 = iter_27_0
		elseif var_27_7 == true and var_27_2 == false then
			var_27_0 = var_27_5
			var_27_1 = var_27_6
			var_27_2 = var_27_7
			var_27_3 = iter_27_0
		elseif var_27_7 == false and var_27_2 == true then
			-- block empty
		elseif var_27_2 == true and var_27_7 == true then
			if var_27_1 > 0 and var_27_6 > 0 and var_27_6 < var_27_1 then
				var_27_0 = var_27_5
				var_27_1 = var_27_6
				var_27_2 = var_27_7
				var_27_3 = iter_27_0
			end
		elseif var_27_0 < 0 and var_27_5 < 0 and var_27_1 > 0 and var_27_6 > 0 then
			var_27_0 = var_27_5
			var_27_1 = var_27_6
			var_27_2 = var_27_7
			var_27_3 = iter_27_0
		elseif var_27_0 > 0 and var_27_5 > 0 and var_27_1 < 0 and var_27_6 < 0 then
			-- block empty
		elseif var_27_5 > 0 then
			var_27_0 = var_27_5
			var_27_1 = var_27_6
			var_27_2 = var_27_7
			var_27_3 = iter_27_0
		end
	end

	return var_27_3
end

function var_0_0.GetDeltaTime(arg_28_0)
	local var_28_0 = ActivityData:GetActivityData(arg_28_0)
	local var_28_1 = manager.time:GetServerTime()
	local var_28_2 = var_28_1 - var_28_0.startTime
	local var_28_3 = var_28_0.stopTime - var_28_1

	return var_28_2, var_28_3, var_28_1 >= var_28_0.startTime and var_28_1 <= var_28_0.stopTime
end

function var_0_0.GotoChapterStagePage(arg_29_0)
	local var_29_0 = arg_29_0[var_0_0.GetActivityChapterIndex(arg_29_0)]
	local var_29_1 = var_29_0[3]

	if var_29_0[1] == 1 then
		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_29_1)
		gameContext:Go("/chapterMapContent", {
			chapterToggle = BattleConst.TOGGLE.PLOT
		})
	else
		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, var_29_1)
		gameContext:Go("/chapterSubPlotContent")
	end
end

function var_0_0.GotoMaxChapterClient()
	local var_30_0 = var_0_0.GetClearMaxChapterClientID()

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, var_30_0)
	gameContext:Go("/chapterMapContent")
end

function var_0_0.GotoChapterSection(arg_31_0)
	local var_31_0 = ChapterCfg[arg_31_0].clientID
	local var_31_1 = ChapterClientCfg[var_31_0]

	if #var_31_1.chapter_list > 1 and var_31_1.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 then
		local var_31_2 = var_31_1.chapter_list[2]
		local var_31_3 = ChapterCfg[var_31_2].section_id_list[1]

		if BattleStageData:GetStageData()[var_31_3] or var_31_0 == ChapterConst.CHAPTER_CLIENT_16 or var_31_0 == ChapterConst.CHAPTER_CLIENT_17 or var_31_0 == ChapterConst.CHAPTER_CLIENT_18 then
			JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_31_1.id), {
				chapterClientID = var_31_1.id
			})

			return
		end
	end

	if not ChapterTools.IsUnlockChapter(arg_31_0) then
		local var_31_4 = ChapterCfg[arg_31_0].unlock_activity_id
		local var_31_5 = ActivityData:GetActivityData(var_31_4)

		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_31_5.startTime)))

		return
	end

	local var_31_6 = table.keyof(var_31_1.chapter_list, arg_31_0)

	if var_31_6 > 1 then
		local var_31_7 = var_31_1.chapter_list[var_31_6 - 1]

		if not ChapterTools.IsClearChapter(var_31_7) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", ChapterCfg[var_31_7].subhead))

			return
		end
	end

	if arg_31_0 == ChapterConst.CHAPTER_CLIENT_19 then
		JumpTools.OpenPageByJump(var_0_0.GetChapterBranchURL(var_31_1.id), {
			chapterID = arg_31_0
		})

		return
	end

	JumpTools.OpenPageByJump("/chapterSection", {
		chapterID = arg_31_0
	})
end

function var_0_0.GetChapterBranchURL(arg_32_0)
	if arg_32_0 == ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM then
		return "/chapterVariantEmptyDream"
	elseif arg_32_0 == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_3 then
		return "/chapterVariantXuHengPart3"
	elseif arg_32_0 == ChapterConst.CHAPTER_CLIENT_16 then
		return "/chapterVariant16"
	elseif arg_32_0 == ChapterConst.CHAPTER_CLIENT_17 then
		return "/chapterVariant17"
	elseif arg_32_0 == ChapterConst.CHAPTER_CLIENT_18 then
		return "/chapterVariant18"
	elseif arg_32_0 == ChapterConst.CHAPTER_CLIENT_19 then
		return "/chapterPlot19Main"
	else
		print("未实现对应的篇章选择界面")

		return "/chapterVariantXuHengPart3"
	end
end

function var_0_0.GetSubPlotUrl(arg_33_0, arg_33_1)
	local var_33_0
	local var_33_1

	if arg_33_0 == 6010101 then
		var_33_0 = "/osirisStoryRemastered"
	elseif arg_33_0 == 6010102 or arg_33_0 == 6010103 or arg_33_0 == 6010104 then
		var_33_0 = "/hellaStoryRemastered"
	elseif arg_33_0 == 6010105 then
		var_33_0 = "/hellaStoryRemastered"
	elseif arg_33_0 == 6010106 or arg_33_0 == 6010107 then
		if arg_33_1 then
			var_33_0 = "/summerStoryMainRemastered"
		elseif arg_33_0 == 6010106 then
			var_33_0 = "/summerStoryRemastered"
		elseif arg_33_0 == 6010107 then
			local var_33_2 = ChapterCfg[arg_33_0]

			var_33_1 = BattleStageData:GetStageData()[var_33_2.section_id_list[1]] == nil

			if var_33_1 then
				var_33_0 = "/summerStoryMainRemastered"

				ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")
			else
				var_33_0 = "/summerSeabedStoryRemastered"
			end
		end
	else
		var_33_0 = arg_33_0 == 6010109 and "/subPlotHera" or (arg_33_0 == 6010110 or arg_33_0 == 6010111 or arg_33_0 == 6010112) and "/activityFactoryStoryStage" or arg_33_0 == 6010113 and "/subPlotTyr" or (arg_33_0 == 6010116 or arg_33_0 == 6010117) and "/subPlotLuWuAndZhiMing" or (arg_33_0 == 6010118 or arg_33_0 == 6010119) and (arg_33_1 and "/chapterVariantThoth" or "/subPlotSection") or "/subPlotSection"
	end

	return var_33_0, var_33_1
end

function var_0_0.GetOpenSubPlotClient()
	local var_34_0 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]

	for iter_34_0 = #var_34_0, 1, -1 do
		local var_34_1 = var_34_0[iter_34_0]

		for iter_34_1, iter_34_2 in ipairs(ChapterClientCfg[var_34_1].chapter_list) do
			if var_0_0.IsOpenSubPlotByTime(iter_34_2) then
				return var_34_1
			end
		end
	end

	return var_34_0[#var_34_0]
end

function var_0_0.IsUnlockSubPlotClient(arg_35_0)
	local var_35_0 = ChapterCfg[arg_35_0].clientID
	local var_35_1 = ChapterClientCfg[var_35_0].chapter_list[1]
	local var_35_2, var_35_3 = var_0_0.IsOpenSubPlotByTime(var_35_1)

	if not var_35_2 then
		local var_35_4 = GetTips("OPEN_TIME")

		return false, string.format(var_35_4, manager.time:GetLostTimeStr(var_35_3))
	end

	return true
end

function var_0_0.GetSubPlotMaxStageID(arg_36_0)
	local var_36_0 = ChapterCfg[arg_36_0].clientID
	local var_36_1 = ChapterClientCfg[var_36_0]
	local var_36_2 = var_36_1.chapter_list[1]
	local var_36_3 = ChapterCfg[var_36_2].section_id_list[1]
	local var_36_4 = BattleStageData:GetStageData()

	for iter_36_0, iter_36_1 in ipairs(var_36_1.chapter_list) do
		if var_0_0.IsOpenSubPlotByTime(iter_36_1) then
			for iter_36_2, iter_36_3 in ipairs(ChapterCfg[iter_36_1].section_id_list) do
				if var_36_4[iter_36_3] then
					var_36_3 = iter_36_3
					var_36_2 = iter_36_1
				else
					return var_36_2, var_36_3
				end
			end
		end
	end

	return var_36_2, var_36_3
end

function var_0_0.IsOpenSubPlotByTime(arg_37_0)
	local var_37_0 = ChapterCfg[arg_37_0].activity_id
	local var_37_1 = ActivityData:GetActivityRefreshTime(var_37_0)

	if var_37_1 == 0 or var_37_1 < manager.time:GetServerTime() then
		return true, var_37_1
	end

	return false, var_37_1
end

function var_0_0.DoReadyBattle(arg_38_0, arg_38_1)
	local var_38_0 = BattleStageTools.GetStageCfg(arg_38_0, arg_38_1)

	if BattleConst.BATTLE_TAG.STORY == var_38_0.tag then
		BattleController.GetInstance():LaunchStoryBattle(arg_38_0, arg_38_1, 0)
	else
		gameContext:Go("/sectionSelectHero", {
			section = arg_38_1,
			sectionType = arg_38_0
		})
	end
end

function var_0_0.GetChapterChallengeLnkList()
	local var_39_0 = {}
	local var_39_1 = PlayerData:GetPlayerInfo().userLevel
	local var_39_2 = GameLevelSetting[var_39_1].challenge_lnk_id_list

	for iter_39_0, iter_39_1 in ipairs(var_39_2) do
		if not ChapterTools.IsChapterSystemLock(iter_39_1) then
			table.insert(var_39_0, iter_39_1)
		end
	end

	return var_39_0
end

function var_0_0.SortChapterLnk(arg_40_0, arg_40_1)
	table.sort(arg_40_0, function(arg_41_0, arg_41_1)
		local var_41_0 = arg_41_0
		local var_41_1 = arg_41_1
		local var_41_2 = 0
		local var_41_3 = 0

		if arg_40_1 then
			var_41_2 = var_0_0.GetChallengeNextRefreshTimeStamp(var_41_0)
			var_41_3 = var_0_0.GetChallengeNextRefreshTimeStamp(var_41_1)
		end

		if var_41_2 == var_41_3 then
			return arg_41_0 < arg_41_1
		elseif var_41_2 ~= 0 and var_41_3 ~= 0 then
			return var_41_2 < var_41_3
		else
			return var_41_2 ~= 0
		end
	end)

	return arg_40_0
end

function var_0_0.GetChallengeNextRefreshTimeStamp(arg_42_0)
	local var_42_0 = ChapterClientCfg[arg_42_0].chapter_list[1]
	local var_42_1 = ChapterCfg[var_42_0]

	if var_42_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		return BattleBossChallengeData:GetNextRefreshTime()
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		return MythicData:GetNextRefreshTime()
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		local var_42_2 = PolyhedronData:GetActivityID()

		return ActivityData:GetActivityData(var_42_2).stopTime
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or var_42_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		-- block empty
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		return AbyssData:GetRefreshTimestamp()
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		return SoloHeartDemonData:GetDataByPara("remainTime")
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
		return EquipSeizureData:NextRefreshTimestamp()
	elseif var_42_1.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
		return CoreVerificationData:GetRefreshTime()
	end

	return 0
end

function var_0_0.GetRedPoint(arg_43_0)
	local var_43_0 = ChapterClientCfg[arg_43_0].chapter_list[1]
	local var_43_1 = ChapterCfg[var_43_0]

	if var_43_1.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
		return RedPointConst.EQUIP_SEIZURE
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
		return RedPointConst.BATTLE_EQUIP
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		return RedPointConst.BOSS_CHALLENGE
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		if MythicData:GetDifficulty() == MythicData:GetFinalId() then
			return RedPointConst.MYTHIC_FINAL_AWARD
		else
			return RedPointConst.MYTHIC_TIMES_AWARD
		end
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		return RedPointConst.POLYHEDRON
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING then
		return RedPointConst.TEACH
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		return RedPointConst.ABYSS
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		return RedPointConst.WARCHESS
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		return RedPointConst.TOWER
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		return RedPointConst.SOLO_HEART_DEMON
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
		return RedPointConst.CORE_VERIFICATION
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 then
		return RedPointConst.SP_HERO_CHALLENGE_3_1
	elseif var_43_1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY then
		return table.concat({
			RedPointConst.STAGE_TYPE_DAILY,
			"_",
			var_43_0
		})
	end

	return RedPointConst.COMBAT_UNLL
end

function var_0_0.HasStageIDByDay(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_44_0][arg_44_1]

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		for iter_44_2, iter_44_3 in ipairs(ChapterMapCfg[iter_44_1].location_list) do
			if table.keyof(ChapterLocationCfg[iter_44_3].stage_list, arg_44_2) then
				return true
			end
		end
	end

	return false
end

function var_0_0.IsNeedOperateFirstDayWatch(arg_45_0, arg_45_1)
	local var_45_0 = GameSetting.chapter19_activate.value[1]
	local var_45_1 = BattleStageData:GetStageData()[var_45_0]

	return var_45_1 and var_45_1.clear_times >= 1 and not BattleStageData:GetOperateChapterDay(arg_45_0, arg_45_1) and var_0_0.HasStageIDByDay(arg_45_0, arg_45_1, var_45_0)
end

function var_0_0.IsNeedOperateLastDayWatch(arg_46_0, arg_46_1)
	local var_46_0 = var_0_0.GetChapterDayList(arg_46_0)

	if #var_46_0 >= GameSetting.chapter19_timeline.value[1] and arg_46_1 ~= var_46_0[#var_46_0 - 1] then
		return false
	end

	local var_46_1 = GameSetting.chapter19_exit.value[1]
	local var_46_2 = BattleStageData:GetStageData()[var_46_1]

	return var_46_2 and var_46_2.clear_times >= 1 and not BattleStageData:GetOperateChapterDay(arg_46_0, var_46_0[GameSetting.chapter19_timeline.value[1]])
end

function var_0_0.IsUnlockScan()
	local var_47_0 = GameSetting.chapter19_scan_unlock.value[1]
	local var_47_1 = BattleStageData:GetStageData()[var_47_0]

	return var_47_1 and var_47_1.clear_times >= 1
end

function var_0_0.HasUnscanClue(arg_48_0)
	if not var_0_0.IsUnlockScan() then
		return false
	end

	local var_48_0 = ChapterMapCfg[arg_48_0]

	for iter_48_0, iter_48_1 in ipairs(var_48_0.location_list) do
		local var_48_1 = ChapterLocationCfg[iter_48_1]
		local var_48_2 = var_48_1.type

		if var_48_1.need_scan == 1 and BattleStageData:GetMapLocationData(arg_48_0)[iter_48_1] == nil then
			return true
		end
	end

	return false
end

function var_0_0.HasClueLocation(arg_49_0)
	if not var_0_0.IsUnlockScan() then
		return false
	end

	local var_49_0 = ChapterMapCfg[arg_49_0]

	for iter_49_0, iter_49_1 in ipairs(var_49_0.location_list) do
		local var_49_1 = ChapterLocationCfg[iter_49_1]
		local var_49_2 = var_49_1.type

		if var_49_1.need_scan == 1 and var_49_2 == BattleConst.LOCATION_TYPE.CLUE or var_49_2 == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
			return true
		end
	end

	return false
end

function var_0_0.GetChapterClueCnt(arg_50_0)
	local var_50_0 = 0
	local var_50_1 = 0

	for iter_50_0, iter_50_1 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id[arg_50_0]) do
		local var_50_2 = BattleStageData:GetMapLocationData(iter_50_1)

		for iter_50_2, iter_50_3 in ipairs(ChapterMapCfg[iter_50_1].location_list) do
			local var_50_3 = ChapterLocationCfg[iter_50_3]

			if var_50_3.type == BattleConst.LOCATION_TYPE.CLUE or var_50_3.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
				var_50_0 = var_50_0 + 1

				if var_50_2[iter_50_3] and var_50_2[iter_50_3] ~= 0 then
					var_50_1 = var_50_1 + 1
				end
			end
		end
	end

	return var_50_1, var_50_0
end

function var_0_0.GetChapterCollectClueList(arg_51_0)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id[arg_51_0]) do
		local var_51_1 = BattleStageData:GetMapLocationData(iter_51_1)

		for iter_51_2, iter_51_3 in ipairs(ChapterMapCfg[iter_51_1].location_list) do
			local var_51_2 = ChapterLocationCfg[iter_51_3]

			if (var_51_2.type == BattleConst.LOCATION_TYPE.CLUE or var_51_2.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE) and var_51_1[iter_51_3] and var_51_1[iter_51_3] ~= 0 then
				table.insert(var_51_0, var_51_1[iter_51_3])
			end
		end
	end

	table.sort(var_51_0, function(arg_52_0, arg_52_1)
		return arg_52_0 < arg_52_1
	end)

	return var_51_0
end

function var_0_0.GetChapterAudioIDList(arg_53_0)
	local var_53_0 = ChapterMapCfg[arg_53_0].audio_id
	local var_53_1 = {}

	for iter_53_0 = #var_53_0, 1, -1 do
		local var_53_2 = var_53_0[iter_53_0]
		local var_53_3 = ChapterAudioCfg[var_53_2]

		if var_53_3.unlock_by_stage_id ~= 0 then
			local var_53_4 = BattleStageData:GetStageData()[var_53_3.unlock_by_stage_id]

			if var_53_4 and var_53_4.clear_times > 0 then
				return {
					var_53_2
				}
			end
		else
			table.insert(var_53_1, 1, var_53_2)
		end
	end

	return var_53_1
end

function var_0_0.GetChapterDayList(arg_54_0)
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(ChapterMapCfg.get_id_list_by_chapter_id_day[arg_54_0]) do
		table.insert(var_54_0, iter_54_0)
	end

	table.sort(var_54_0, function(arg_55_0, arg_55_1)
		return arg_55_0 < arg_55_1
	end)

	return var_54_0
end

function var_0_0.IsLastDay(arg_56_0, arg_56_1)
	local var_56_0 = var_0_0.GetChapterDayList(arg_56_0)

	return GameSetting.chapter19_timeline.value[1] == table.keyof(var_56_0, arg_56_1)
end

function var_0_0.IsNeedExpandDay(arg_57_0)
	local var_57_0 = var_0_0.GetChapterDayList(arg_57_0)

	for iter_57_0, iter_57_1 in ipairs(var_57_0) do
		if iter_57_0 ~= 1 and iter_57_0 ~= 2 and iter_57_0 ~= GameSetting.chapter19_timeline.value[1] and var_0_0.IsNeedGuildDay(arg_57_0, iter_57_1) then
			return true
		end
	end

	return false
end

function var_0_0.IsNeedGuildDay(arg_58_0, arg_58_1)
	local var_58_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_58_0][arg_58_1][1]
	local var_58_1 = ChapterMapCfg[var_58_0].location_list[1]
	local var_58_2 = ChapterLocationCfg[var_58_1].stage_list[1]
	local var_58_3 = BattleStageData:GetStageData()[var_58_2]
	local var_58_4 = var_0_0.GetChapterDayList(arg_58_0)
	local var_58_5 = table.keyof(var_58_4, arg_58_1)

	if var_58_5 == 2 or var_58_5 == GameSetting.chapter19_timeline.value[1] then
		return false
	end

	if var_58_3 and var_58_3.clear_times <= 0 and var_0_0.IsUnlockChapterDay(arg_58_0, arg_58_1) and not BattleStageData:GetOperateChapterDay(arg_58_0, arg_58_1) and not var_0_0.IsLastDay(arg_58_0, arg_58_1) then
		return true
	end

	return false
end

function var_0_0.IsUnlockChapterDay(arg_59_0, arg_59_1)
	if not ChapterTools.IsClearPreChapterDayAllStage(arg_59_0, arg_59_1) then
		return false
	end

	local var_59_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_59_0][arg_59_1][1]
	local var_59_1 = ChapterMapCfg[var_59_0]

	if ActivityTools.GetActivityStatus(var_59_1.activity_id) == 0 then
		return false
	end

	return true
end

function var_0_0.IsClearPreChapterDayAllStage(arg_60_0, arg_60_1)
	local var_60_0 = var_0_0.GetChapterDayList(arg_60_0)
	local var_60_1 = table.keyof(var_60_0, arg_60_1)

	if var_60_1 == 1 then
		return true
	end

	local var_60_2 = var_60_0[var_60_1 - 1]

	return var_0_0.IsClearChapterDayAllStage(arg_60_0, var_60_2)
end

function var_0_0.IsClearChapterDayAllStage(arg_61_0, arg_61_1)
	for iter_61_0, iter_61_1 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id_day[arg_61_0][arg_61_1]) do
		if var_0_0.IsClearMapAllStage(iter_61_1) == false then
			return false
		end
	end

	return true
end

function var_0_0.IsClearMapAllStage(arg_62_0)
	for iter_62_0, iter_62_1 in ipairs(ChapterMapCfg[arg_62_0].location_list) do
		if var_0_0.IsClearLocationAllStage(iter_62_1) == false then
			return false
		end
	end

	return true
end

function var_0_0.IsClearLocationAllStage(arg_63_0)
	for iter_63_0, iter_63_1 in ipairs(ChapterLocationCfg[arg_63_0].stage_list) do
		local var_63_0 = BattleStageData:GetStageData()[iter_63_1]

		if not var_63_0 or not (var_63_0.clear_times > 0) then
			return false
		end
	end

	return true
end

function var_0_0.GetUnclearMainStageLocationID(arg_64_0)
	for iter_64_0, iter_64_1 in ipairs(ChapterMapCfg[arg_64_0].location_list) do
		local var_64_0 = ChapterLocationCfg[iter_64_1].stage_list

		for iter_64_2, iter_64_3 in ipairs(var_64_0) do
			local var_64_1 = BattleStageData:GetStageData()[iter_64_3]

			if var_64_1 and var_64_1.clear_times <= 0 then
				return iter_64_1
			end
		end
	end

	return nil
end

function var_0_0.NeedShowSwitchMapGuild(arg_65_0, arg_65_1, arg_65_2)
	if var_0_0.GetUnclearMainStageLocationID(arg_65_2) then
		return false
	end

	local var_65_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_65_0][arg_65_1]

	for iter_65_0, iter_65_1 in ipairs(var_65_0) do
		if iter_65_1 ~= arg_65_2 and var_0_0.GetUnclearMainStageLocationID(iter_65_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasNewLocationMainStage(arg_66_0)
	local var_66_0 = ChapterLocationCfg[arg_66_0]

	for iter_66_0, iter_66_1 in ipairs(var_66_0.stage_list) do
		local var_66_1 = BattleStageData:GetStageData()[iter_66_1]

		if var_66_1 and var_66_1.clear_times <= 0 then
			return true
		end
	end

	return false
end

function var_0_0.HasNewLocationStage(arg_67_0, arg_67_1)
	local var_67_0 = ChapterLocationCfg[arg_67_1]

	for iter_67_0, iter_67_1 in ipairs(var_67_0.sub_stage_list) do
		local var_67_1 = BattleStageData:GetStageData()[iter_67_1]

		if var_67_1 and var_67_1.clear_times <= 0 then
			return true
		end
	end

	for iter_67_2, iter_67_3 in ipairs(var_67_0.event_list) do
		if var_0_0.IsUnlockEvent(iter_67_3) and not var_0_0.HasReadEventID(iter_67_3) then
			return true
		end
	end

	if #var_67_0.clue > 0 then
		local var_67_2 = BattleStageData:GetMapLocationData(arg_67_0)[arg_67_1]

		if var_67_2 == nil or var_67_2 == 0 then
			return true
		end
	end

	return false
end

function var_0_0.IsReadFirstEvent(arg_68_0)
	for iter_68_0, iter_68_1 in ipairs(ChapterStoryCollectCfg.get_id_list_by_chapter_id[arg_68_0]) do
		if var_0_0.HasReadEvent(iter_68_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasReadEvent(arg_69_0)
	for iter_69_0, iter_69_1 in ipairs(ChapterStoryCollectCfg[arg_69_0].story_id_list) do
		if var_0_0.HasReadEventID(iter_69_1) then
			return true
		end
	end

	return false
end

function var_0_0.HasReadEventID(arg_70_0)
	return BattleStageData:HasReadLocationEvent(arg_70_0)
end

function var_0_0.IsUnlockEvent(arg_71_0)
	local var_71_0 = StageArchiveCfg[arg_71_0]

	if var_71_0.unlock_by_stage_id ~= 0 then
		local var_71_1 = BattleStageData:GetStageData()[var_71_0.unlock_by_stage_id]

		if var_71_1 and var_71_1.clear_times > 0 then
			-- block empty
		else
			return false
		end
	end

	return true
end

function var_0_0.NeedShowLocation(arg_72_0, arg_72_1)
	local var_72_0 = ChapterLocationCfg[arg_72_1]

	if var_72_0.unlock_stage_id ~= 0 then
		local var_72_1 = BattleStageData:GetStageData()[var_72_0.unlock_stage_id]

		if var_72_1 and var_72_1.clear_times > 0 then
			-- block empty
		else
			return false
		end
	end

	local var_72_2 = BattleStageData:GetStageData()[var_72_0.show_by_stage_id]

	if var_72_2 and var_72_2.clear_times > 0 then
		return true
	end

	local var_72_3 = BattleStageData:GetStageData()[var_72_0.hide_by_stage_id]

	if var_72_3 and var_72_3.clear_times > 0 then
		return false
	end

	if var_72_0.type == BattleConst.LOCATION_TYPE.CLUE or var_72_0.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
		local var_72_4 = BattleStageData:GetMapLocationData(arg_72_0)

		if var_72_0.need_scan == 1 and (not var_72_4 or not var_72_4[arg_72_1]) then
			return false
		else
			return true
		end
	end

	for iter_72_0, iter_72_1 in pairs(var_72_0.stage_list) do
		if BattleStageData:GetStageData()[iter_72_1] then
			return true
		end
	end

	for iter_72_2, iter_72_3 in pairs(var_72_0.sub_stage_list) do
		if BattleStageData:GetStageData()[iter_72_3] then
			return true
		end
	end

	for iter_72_4, iter_72_5 in ipairs(var_72_0.event_list) do
		if var_0_0.IsUnlockEvent(iter_72_5) then
			return true
		end
	end

	return false
end

function var_0_0.IsReadClue(arg_73_0, arg_73_1)
	local var_73_0 = BattleStageData:GetMapLocationData(arg_73_0)

	if var_73_0 and var_73_0[arg_73_1] and var_73_0[arg_73_1] ~= 0 then
		return true
	end

	return false
end

function var_0_0.IsEnableLocation(arg_74_0)
	if not var_0_0.IsNeedShowFog() then
		return true
	end

	return ChapterLocationCfg[arg_74_0].can_not_click_until_unlock_fog ~= 1
end

function var_0_0.GetChapter19MapState(arg_75_0)
	local var_75_0 = ChapterMapCfg[arg_75_0]

	if var_75_0.unlock_map_state_by_stage_id == "" then
		return 0
	end

	for iter_75_0, iter_75_1 in ipairs(var_75_0.unlock_map_state_by_stage_id) do
		if not var_0_0.IsClearStage(iter_75_1) then
			return iter_75_0 - 1
		end
	end

	return 0
end

function var_0_0.IsNeedShowFog()
	local var_76_0 = GameSetting.chapter19_fog_dissipation.value[1]

	if var_0_0.IsClearStage(var_76_0) then
		return false
	end

	return true
end

function var_0_0.NeedPlayFogAnimator()
	local var_77_0 = GameSetting.chapter19_fog_dissipation.value[1]
	local var_77_1 = BattleChapterStageCfg[var_77_0].next_unlock_id_list

	if BattleStageData:GetFogAnimatorFlag() or var_0_0.IsClearStage(var_77_1) then
		return false
	end

	return true
end

function var_0_0.GetChapterGroupList(arg_78_0)
	local var_78_0 = ChapterClientCfg[arg_78_0]
	local var_78_1 = {}

	if var_78_0.toggle == BattleConst.TOGGLE.PLOT then
		local var_78_2 = var_78_0.difficulty
		local var_78_3 = ChapterMainPlotToggleCfg.get_id_list_by_difficulty[var_78_2]

		for iter_78_0, iter_78_1 in ipairs(var_78_3) do
			local var_78_4 = ChapterMainPlotToggleCfg[iter_78_1].chapter_client_list

			if table.keyof(var_78_4, arg_78_0) then
				for iter_78_2, iter_78_3 in ipairs(var_78_4) do
					table.insert(var_78_1, {
						2,
						iter_78_3
					})
				end
			elseif #var_78_4 == 1 then
				table.insert(var_78_1, {
					2,
					var_78_4[1]
				})
			else
				table.insert(var_78_1, {
					1,
					iter_78_1
				})
			end
		end
	elseif var_78_0.toggle == BattleConst.TOGGLE.SUB_PLOT then
		local var_78_5 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]

		for iter_78_4, iter_78_5 in ipairs(var_78_5) do
			table.insert(var_78_1, {
				2,
				iter_78_5
			})
		end
	end

	return var_78_1
end

function var_0_0.IsChapterSystemLock(arg_79_0)
	local var_79_0 = ChapterClientCfg[arg_79_0]

	if not var_79_0 then
		return false
	end

	local var_79_1 = type(var_79_0.jump_system) == "table" and var_79_0.jump_system[1]

	return var_79_1 and SystemCfg[var_79_1] and SystemCfg[var_79_1].system_hide == 1
end

return var_0_0
