return {
	IsFinishPreChapter = function (slot0)
		if ChapterCfg[slot0] == nil then
			return false, slot0
		end

		slot2 = slot1.pre_chapter
		slot3 = slot1.activity_id

		if slot1.unlock_activity_id ~= 0 and not ActivityData:GetActivityIsOpen(slot1.unlock_activity_id) then
			return false, -2
		end

		if ActivityData:GetActivityIsOpen(slot3) then
			for slot7, slot8 in pairs(slot2) do
				if slot3 == ChapterCfg[slot8].activity_id and uv0.IsClearChapter(slot8) == false then
					return false, slot8
				end
			end

			if PlayerData:GetPlayerInfo().userLevel < GameSetting.activity_main_plot_unlock_level.value[1] then
				return false, -1
			end

			return true
		end

		return uv0.IsFinishAllPreChapter(slot0)
	end,
	IsFinishAllPreChapter = function (slot0)
		if ChapterCfg[slot0].pre_chapter == "" then
			return true
		end

		for slot6, slot7 in pairs(slot2) do
			if type(ChapterCfg[slot7].pre_chapter) ~= "table" then
				return true
			end

			if not uv0.IsFinishPreChapterWithoutActivity(slot7) then
				return false, slot7
			end

			if BattleStageData:GetStageData()[slot8.section_id_list[#slot8.section_id_list]] == nil or slot11.clear_times <= 0 then
				return false, slot7
			end
		end

		return true
	end,
	IsFinishPreChapterWithoutActivity = function (slot0)
		if ChapterCfg[slot0] == nil then
			return false, slot0
		end

		return uv0.IsFinishAllPreChapter(slot0)
	end,
	GetChapterLockText = function (slot0, slot1, slot2)
		if slot1 == -1 then
			return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1])
		end

		if slot1 == -2 then
			return string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterCfg[slot0].unlock_activity_id).startTime))
		end

		if ChapterCfg[slot1].difficulty == 1 and not slot2 then
			return "NEED_FINISH_PRE_NORMAL_STAGE"
		end

		return string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(BattleConst.HARD_LANGUAGE[slot3.difficulty]), GetI18NText(ChapterClientCfg[slot3.clientID].desc))
	end,
	GetOptimalChapterClientID = function (slot0)
		if slot0 and PlayerData:GetPlayerInfo().userLevel < GameSetting.activity_main_plot_unlock_level.value[1] then
			return uv0.GetClearMaxChapterClientID(), 0
		end

		for slot5 = #getChapterClientList()[1], 1, -1 do
			slot7, slot8 = uv0.IsOpenChapterClientID(slot1[slot5])

			if slot7 then
				return slot6, slot8
			end
		end

		return uv0.GetClearMaxChapterClientID(), 0
	end,
	IsOpenChapterClientID = function (slot0)
		for slot4, slot5 in ipairs(ChapterClientCfg[slot0].chapter_list) do
			if ChapterCfg[slot5].activity_id ~= 0 and ActivityData:GetActivityIsOpen(slot7) then
				return true, slot7
			end
		end

		return false
	end,
	GetClearMaxChapterClientID = function ()
		slot0 = getChapterClientList()[1]

		for slot5, slot6 in ipairs(slot0) do
			if BattleStageData:GetStageData()[ChapterCfg[ChapterClientCfg[slot6].chapter_list[1]].section_id_list[1]] and uv0.IsClearChapterClient(slot0[1]) and uv0.IsUnlockChapter(slot7) then
				slot1 = slot6
			else
				return slot1
			end
		end

		return slot0[#slot0]
	end,
	GetChapterTotalStarCnt = function (slot0)
		if ChapterCfg[slot0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
			return #AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]
		end

		for slot5, slot6 in ipairs(ChapterCfg[slot0].section_id_list) do
			slot1 = 0 + #BattleChapterStageCfg[slot6].three_star_need
		end

		return slot1
	end,
	GetChapterStarCnt = function (slot0)
		if ChapterCfg[slot0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
			for slot5, slot6 in ipairs(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.CHAPTER_PLOT_19]) do
				if TaskData2:GetTask(slot6) and AssignmentCfg[slot6].need <= slot8.progress then
					slot1 = 0 + 1
				end
			end

			return slot1
		end

		return BattleStageData:GetChapterStarCnt(slot0)
	end,
	GetChapterStarPercentage = function (slot0)
		return uv0.GetChapterStarCnt(slot0) / uv0.GetChapterTotalStarCnt(slot0)
	end,
	GetChapterClientTotalStarCnt = function (slot0)
		for slot6, slot7 in ipairs(ChapterClientCfg[slot0].chapter_list) do
			slot2 = 0 + uv0.GetChapterTotalStarCnt(slot7)
		end

		return slot2
	end,
	GetChapterClientStarCnt = function (slot0)
		for slot6, slot7 in ipairs(ChapterClientCfg[slot0].chapter_list) do
			slot2 = 0 + uv0.GetChapterStarCnt(slot7)
		end

		return slot2
	end,
	GetChapterClientStarPercentage = function (slot0)
		return uv0.GetChapterClientStarCnt(slot0) / uv0.GetChapterClientTotalStarCnt(slot0)
	end,
	GetSubPlotFinishPercentage = function (slot0)
		slot2 = 0
		slot3 = BattleStageData:GetStageData()

		for slot7, slot8 in ipairs(ChapterClientCfg[slot0].chapter_list) do
			slot9 = ChapterCfg[slot8]
			slot1 = 0 + #slot9.section_id_list

			for slot13, slot14 in ipairs(slot9.section_id_list) do
				if slot3[slot14] and slot3[slot14].clear_times > 0 then
					slot2 = slot2 + 1
				end
			end
		end

		if WarchessLevelCfg.get_id_list_by_chapter_tag[slot0] ~= nil then
			for slot8, slot9 in pairs(slot4) do
				slot1 = slot1 + 1

				if ChessTools.GetChapterProgress(slot9) >= 100 then
					slot2 = slot2 + 1
				end
			end
		end

		return slot2 / slot1
	end,
	GetChapterClientFinishPercentage = function (slot0)
		if ChapterClientCfg[slot0].toggle == BattleConst.TOGGLE.PLOT then
			return uv0.GetChapterClientStarPercentage(slot0)
		elseif slot1.toggle == BattleConst.TOGGLE.SUB_PLOT then
			return uv0.GetSubPlotFinishPercentage(slot0)
		else
			return 0
		end
	end,
	GetChapterByActivityID = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]) do
			if ChapterCfg[slot7].activity_id == slot0 then
				table.insert(slot2, slot7)
			end
		end

		for slot6, slot7 in ipairs(slot2) do
			if not uv0.IsClearChapter(slot7) then
				return slot7
			end
		end

		return slot2[1]
	end,
	IsClearChapterClient = function (slot0)
		slot1 = ChapterClientCfg[slot0].chapter_list

		return uv0.IsClearChapter(slot1[#slot1])
	end,
	IsClearChapter = function (slot0)
		if ChapterCfg[slot0].clientID == ChapterConst.CHAPTER_CLIENT_19 then
			slot2 = ChapterMapCfg[#ChapterMapCfg.get_id_list_by_chapter_id[slot0]].location_list

			for slot6, slot7 in ipairs(locationlist) do
				for slot11, slot12 in ipairs(ChapterLocationCfg[slot7].stage_list) do
					if not uv0.IsClearStage(slot12) then
						return false
					end
				end
			end

			return true
		end

		slot1 = ChapterCfg[slot0].section_id_list

		return uv0.IsClearStage(slot1[#slot1])
	end,
	IsClearFirstStage = function (slot0)
		return uv0.IsClearStage(ChapterCfg[slot0].section_id_list[1])
	end,
	IsClearStage = function (slot0)
		if BattleStageData:GetStageData()[slot0] == nil or slot1.clear_times <= 0 then
			return false
		end

		return true
	end,
	HasChapterStage = function (slot0)
		return #ChapterCfg[ChapterClientCfg[slot0].chapter_list[1]].section_id_list > 0
	end,
	IsUnlockChapter = function (slot0)
		slot1 = ChapterCfg[slot0]
		slot2 = slot1.sub_type
		slot3 = slot1.unlock_activity_id

		if slot1.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
			if slot1.activity_id ~= 0 then
				slot4 = ActivityData:GetActivityRefreshTime(slot3)

				if ActivityTools.GetActivityStatus(slot3) == 1 and slot4 ~= 0 and manager.time:GetServerTime() < slot4 then
					return false
				end
			end
		elseif slot3 ~= 0 and manager.time:GetServerTime() < ActivityData:GetActivityData(slot3).startTime then
			return false
		end

		if slot2 == 13 and slot0 == 11112 and not SkuldTravelData:IsCollectAllPhoto() then
			return false
		end

		return true
	end,
	GetChapterIDByClient = function (slot0)
		slot1 = ChapterClientCfg[slot0]

		for slot6, slot7 in ipairs(slot1.chapter_list) do
			if not ChapterTools.IsUnlockChapter(slot7) then
				return slot1.chapter_list[1]
			end

			if table.keyof(slot1.chapter_list, slot7) > 1 and not ChapterTools.IsClearChapter(slot1.chapter_list[slot8 - 1]) then
				return slot2
			end

			if #ChapterCfg[slot7].section_id_list <= 0 then
				return slot2
			end

			slot2 = slot7
		end

		return slot2
	end,
	GetNeighborClientID = function (slot0, slot1)
		slot3 = {}

		if ChapterClientCfg[slot0].toggle == BattleConst.TOGGLE.PLOT then
			slot3 = getChapterClientList()[slot2.difficulty]
		elseif slot2.toggle == BattleConst.TOGGLE.SUB_PLOT then
			slot3 = ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]
		end

		slot4 = table.keyof(slot3, slot0)

		if slot1 and slot4 < #slot3 then
			slot4 = slot4 + 1
		elseif not slot1 and slot4 > 1 then
			slot4 = slot4 - 1
		end

		return slot3[slot4]
	end,
	GetUnclearStageCnt = function (slot0)
		slot1 = ChapterCfg[slot0]

		for slot6, slot7 in ipairs(slot1.section_id_list) do
			if BattleStageData:GetStageData()[slot7] and slot8.clear_times > 0 then
				slot2 = #slot1.section_id_list - 1
			else
				return slot2
			end
		end

		return slot2
	end,
	GetOpenStageList = function (slot0, slot1)
		slot2 = BattleStageData:GetStageData()
		slot4 = {}

		for slot8, slot9 in ipairs(ChapterCfg[slot0].section_id_list) do
			if slot2[slot9] then
				if not table.keyof(slot4, slot9) then
					if slot9 ~= GameSetting.travel_skuld_new_ending_stage_id.value[1] or slot2[slot9].clear_times >= 1 then
						table.insert(slot4, slot9)
					end
				end

				if slot2[slot9].clear_times > 0 then
					if slot1[slot9].next_show_id_list == "" then
						slot11 = {}
					end

					for slot15, slot16 in ipairs(slot11) do
						if not table.keyof(slot4, slot16) then
							if slot16 == GameSetting.travel_skuld_new_ending_stage_id.value[1] then
								if slot2[slot16] then
									if not slot2[slot16] or slot2[slot16].clear_times >= 1 then
										table.insert(slot4, slot16)
									end
								end
							else
								table.insert(slot4, slot16)
							end
						end
					end
				end
			end
		end

		return slot4
	end,
	GetActivityChapterIndex = function (slot0)
		slot1, slot2, slot3 = nil
		slot4 = 1

		for slot8 = #slot0, 1, -1 do
			slot1, slot2, slot3 = uv0.GetDeltaTime(slot0[slot8][2])

			if slot1 == nil then
				slot4 = slot8
			elseif slot12 == true and slot3 == false then
				slot1 = slot10
				slot2 = slot11
				slot3 = slot12
				slot4 = slot8
			elseif slot12 == false and slot3 == true then
				-- Nothing
			elseif slot3 == true and slot12 == true then
				if slot2 > 0 and slot11 > 0 and slot11 < slot2 then
					slot1 = slot10
					slot2 = slot11
					slot3 = slot12
					slot4 = slot8
				end
			elseif slot1 < 0 and slot10 < 0 and slot2 > 0 and slot11 > 0 then
				slot1 = slot10
				slot2 = slot11
				slot3 = slot12
				slot4 = slot8
			elseif slot1 > 0 and slot10 > 0 and slot2 < 0 and slot11 < 0 then
				-- Nothing
			elseif slot10 > 0 then
				slot1 = slot10
				slot2 = slot11
				slot3 = slot12
				slot4 = slot8
			end
		end

		return slot4
	end,
	GetDeltaTime = function (slot0)
		slot1 = ActivityData:GetActivityData(slot0)
		slot2 = manager.time:GetServerTime()

		return slot2 - slot1.startTime, slot1.stopTime - slot2, slot1.startTime <= slot2 and slot2 <= slot1.stopTime
	end,
	GotoChapterStagePage = function (slot0)
		slot2 = slot0[uv0.GetActivityChapterIndex(slot0)]

		if slot2[1] == 1 then
			BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, slot2[3])
			gameContext:Go("/chapterMapContent", {
				chapterToggle = BattleConst.TOGGLE.PLOT
			})
		else
			BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, slot3)
			gameContext:Go("/chapterSubPlotContent")
		end
	end,
	GotoMaxChapterClient = function ()
		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, uv0.GetClearMaxChapterClientID())
		gameContext:Go("/chapterMapContent")
	end,
	GotoChapterSection = function (slot0)
		if #ChapterClientCfg[ChapterCfg[slot0].clientID].chapter_list > 1 and slot2.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 and (BattleStageData:GetStageData()[ChapterCfg[slot2.chapter_list[2]].section_id_list[1]] or slot1 == ChapterConst.CHAPTER_CLIENT_16 or slot1 == ChapterConst.CHAPTER_CLIENT_17 or slot1 == ChapterConst.CHAPTER_CLIENT_18) then
			JumpTools.OpenPageByJump(uv0.GetChapterBranchURL(slot2.id), {
				chapterClientID = slot2.id
			})

			return
		end

		if not ChapterTools.IsUnlockChapter(slot0) then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(ChapterCfg[slot0].unlock_activity_id).startTime)))

			return
		end

		if table.keyof(slot2.chapter_list, slot0) > 1 and not ChapterTools.IsClearChapter(slot2.chapter_list[slot3 - 1]) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", ChapterCfg[slot4].subhead))

			return
		end

		if slot0 == ChapterConst.CHAPTER_CLIENT_19 then
			JumpTools.OpenPageByJump(uv0.GetChapterBranchURL(slot2.id), {
				chapterID = slot0
			})

			return
		end

		JumpTools.OpenPageByJump("/chapterSection", {
			chapterID = slot0
		})
	end,
	GetChapterBranchURL = function (slot0)
		if slot0 == ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM then
			return "/chapterVariantEmptyDream"
		elseif slot0 == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_3 then
			return "/chapterVariantXuHengPart3"
		elseif slot0 == ChapterConst.CHAPTER_CLIENT_16 then
			return "/chapterVariant16"
		elseif slot0 == ChapterConst.CHAPTER_CLIENT_17 then
			return "/chapterVariant17"
		elseif slot0 == ChapterConst.CHAPTER_CLIENT_18 then
			return "/chapterVariant18"
		elseif slot0 == ChapterConst.CHAPTER_CLIENT_19 then
			return "/chapterPlot19Main"
		else
			print("未实现对应的篇章选择界面")

			return "/chapterVariantXuHengPart3"
		end
	end,
	GetSubPlotUrl = function (slot0, slot1)
		slot2, slot3 = nil

		if slot0 == 6010101 then
			slot2 = "/osirisStoryRemastered"
		elseif slot0 == 6010102 or slot0 == 6010103 or slot0 == 6010104 then
			slot2 = "/hellaStoryRemastered"
		elseif slot0 == 6010105 then
			slot2 = "/hellaStoryRemastered"
		elseif slot0 == 6010106 or slot0 == 6010107 then
			if slot1 then
				slot2 = "/summerStoryMainRemastered"
			elseif slot0 == 6010106 then
				slot2 = "/summerStoryRemastered"
			elseif slot0 == 6010107 then
				if BattleStageData:GetStageData()[ChapterCfg[slot0].section_id_list[1]] == nil then
					slot2 = "/summerStoryMainRemastered"

					ShowTips("ACTIVITY_FINISH_ALL_SUMMER_STORY")
				else
					slot2 = "/summerSeabedStoryRemastered"
				end
			end
		else
			slot2 = slot0 == 6010109 and "/subPlotHera" or (slot0 == 6010110 or slot0 == 6010111 or slot0 == 6010112) and "/activityFactoryStoryStage" or slot0 == 6010113 and "/subPlotTyr" or (slot0 == 6010116 or slot0 == 6010117) and "/subPlotLuWuAndZhiMing" or (slot0 == 6010118 or slot0 == 6010119) and (slot1 and "/chapterVariantThoth" or "/subPlotSection") or "/subPlotSection"
		end

		return slot2, slot3
	end,
	GetOpenSubPlotClient = function ()
		for slot4 = #ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT], 1, -1 do
			for slot9, slot10 in ipairs(ChapterClientCfg[slot0[slot4]].chapter_list) do
				if uv0.IsOpenSubPlotByTime(slot10) then
					return slot5
				end
			end
		end

		return slot0[#slot0]
	end,
	IsUnlockSubPlotClient = function (slot0)
		slot4, slot5 = uv0.IsOpenSubPlotByTime(ChapterClientCfg[ChapterCfg[slot0].clientID].chapter_list[1])

		if not slot4 then
			return false, string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot5))
		end

		return true
	end,
	GetSubPlotMaxStageID = function (slot0)
		slot2 = ChapterClientCfg[ChapterCfg[slot0].clientID]
		slot4 = ChapterCfg[slot2.chapter_list[1]].section_id_list[1]
		slot5 = BattleStageData:GetStageData()

		for slot9, slot10 in ipairs(slot2.chapter_list) do
			if uv0.IsOpenSubPlotByTime(slot10) then
				for slot14, slot15 in ipairs(ChapterCfg[slot10].section_id_list) do
					if slot5[slot15] then
						slot4 = slot15
						slot3 = slot10
					else
						return slot3, slot4
					end
				end
			end
		end

		return slot3, slot4
	end,
	IsOpenSubPlotByTime = function (slot0)
		if ActivityData:GetActivityRefreshTime(ChapterCfg[slot0].activity_id) == 0 or slot2 < manager.time:GetServerTime() then
			return true, slot2
		end

		return false, slot2
	end,
	DoReadyBattle = function (slot0, slot1)
		if BattleConst.BATTLE_TAG.STORY == BattleStageTools.GetStageCfg(slot0, slot1).tag then
			BattleController.GetInstance():LaunchStoryBattle(slot0, slot1, 0)
		else
			gameContext:Go("/sectionSelectHero", {
				section = slot1,
				sectionType = slot0
			})
		end
	end,
	GetChapterChallengeLnkList = function ()
		slot0 = {}

		for slot6, slot7 in ipairs(GameLevelSetting[PlayerData:GetPlayerInfo().userLevel].challenge_lnk_id_list) do
			if not ChapterTools.IsChapterSystemLock(slot7) then
				table.insert(slot0, slot7)
			end
		end

		return slot0
	end,
	SortChapterLnk = function (slot0, slot1)
		table.sort(slot0, function (slot0, slot1)
			slot4 = 0
			slot5 = 0

			if uv0 then
				slot4 = uv1.GetChallengeNextRefreshTimeStamp(slot0)
				slot5 = uv1.GetChallengeNextRefreshTimeStamp(slot1)
			end

			if slot4 == slot5 then
				return slot0 < slot1
			elseif slot4 ~= 0 and slot5 ~= 0 then
				return slot4 < slot5
			else
				return slot4 ~= 0
			end
		end)

		return slot0
	end,
	GetChallengeNextRefreshTimeStamp = function (slot0)
		if ChapterCfg[ChapterClientCfg[slot0].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return BattleBossChallengeData:GetNextRefreshTime()
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
			return MythicData:GetNextRefreshTime()
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
			return ActivityData:GetActivityData(PolyhedronData:GetActivityID()).stopTime
		elseif slot2.type ~= BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING then
			if slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
				-- Nothing
			elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
				return AbyssData:GetRefreshTimestamp()
			elseif slot2.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
				return SoloHeartDemonData:GetDataByPara("remainTime")
			elseif slot2.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
				return EquipSeizureData:NextRefreshTimestamp()
			elseif slot2.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
				return CoreVerificationData:GetRefreshTime()
			end
		end

		return 0
	end,
	GetRedPoint = function (slot0)
		if ChapterCfg[ChapterClientCfg[slot0].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
			return RedPointConst.EQUIP_SEIZURE
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
			return RedPointConst.BATTLE_EQUIP
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
			return RedPointConst.BOSS_CHALLENGE
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
			if MythicData:GetDifficulty() == MythicData:GetFinalId() then
				return RedPointConst.MYTHIC_FINAL_AWARD
			else
				return RedPointConst.MYTHIC_TIMES_AWARD
			end
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
			return RedPointConst.POLYHEDRON
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING then
			return RedPointConst.TEACH
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
			return RedPointConst.ABYSS
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
			return RedPointConst.WARCHESS
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
			return RedPointConst.TOWER
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
			return RedPointConst.SOLO_HEART_DEMON
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
			return RedPointConst.CORE_VERIFICATION
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 then
			return RedPointConst.SP_HERO_CHALLENGE_3_1
		elseif slot2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY then
			return table.concat({
				RedPointConst.STAGE_TYPE_DAILY,
				"_",
				slot1
			})
		end

		return RedPointConst.COMBAT_UNLL
	end,
	HasStageIDByDay = function (slot0, slot1, slot2)
		for slot7, slot8 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id_day[slot0][slot1]) do
			for slot12, slot13 in ipairs(ChapterMapCfg[slot8].location_list) do
				if table.keyof(ChapterLocationCfg[slot13].stage_list, slot2) then
					return true
				end
			end
		end

		return false
	end,
	IsNeedOperateFirstDayWatch = function (slot0, slot1)
		return BattleStageData:GetStageData()[GameSetting.chapter19_activate.value[1]] and slot3.clear_times >= 1 and not BattleStageData:GetOperateChapterDay(slot0, slot1) and uv0.HasStageIDByDay(slot0, slot1, slot2)
	end,
	IsNeedOperateLastDayWatch = function (slot0, slot1)
		if GameSetting.chapter19_timeline.value[1] <= #uv0.GetChapterDayList(slot0) and slot1 ~= slot2[#slot2 - 1] then
			return false
		end

		return BattleStageData:GetStageData()[GameSetting.chapter19_exit.value[1]] and slot4.clear_times >= 1 and not BattleStageData:GetOperateChapterDay(slot0, slot2[GameSetting.chapter19_timeline.value[1]])
	end,
	IsUnlockScan = function ()
		return BattleStageData:GetStageData()[GameSetting.chapter19_scan_unlock.value[1]] and slot1.clear_times >= 1
	end,
	HasUnscanClue = function (slot0)
		if not uv0.IsUnlockScan() then
			return false
		end

		for slot5, slot6 in ipairs(ChapterMapCfg[slot0].location_list) do
			slot7 = ChapterLocationCfg[slot6]
			slot8 = slot7.type

			if slot7.need_scan == 1 and BattleStageData:GetMapLocationData(slot0)[slot6] == nil then
				return true
			end
		end

		return false
	end,
	HasClueLocation = function (slot0)
		if not uv0.IsUnlockScan() then
			return false
		end

		for slot5, slot6 in ipairs(ChapterMapCfg[slot0].location_list) do
			slot7 = ChapterLocationCfg[slot6]
			slot8 = slot7.type

			if slot7.need_scan == 1 and slot8 == BattleConst.LOCATION_TYPE.CLUE or slot8 == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
				return true
			end
		end

		return false
	end,
	GetChapterClueCnt = function (slot0)
		slot1 = 0
		slot2 = 0

		for slot6, slot7 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id[slot0]) do
			slot8 = BattleStageData:GetMapLocationData(slot7)

			for slot12, slot13 in ipairs(ChapterMapCfg[slot7].location_list) do
				if ChapterLocationCfg[slot13].type == BattleConst.LOCATION_TYPE.CLUE or slot14.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
					slot1 = slot1 + 1

					if slot8[slot13] and slot8[slot13] ~= 0 then
						slot2 = slot2 + 1
					end
				end
			end
		end

		return slot2, slot1
	end,
	GetChapterCollectClueList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id[slot0]) do
			slot7 = BattleStageData:GetMapLocationData(slot6)

			for slot11, slot12 in ipairs(ChapterMapCfg[slot6].location_list) do
				if (ChapterLocationCfg[slot12].type == BattleConst.LOCATION_TYPE.CLUE or slot13.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE) and slot7[slot12] and slot7[slot12] ~= 0 then
					table.insert(slot1, slot7[slot12])
				end
			end
		end

		table.sort(slot1, function (slot0, slot1)
			return slot0 < slot1
		end)

		return slot1
	end,
	GetChapterAudioIDList = function (slot0)
		slot2 = {}

		for slot6 = #ChapterMapCfg[slot0].audio_id, 1, -1 do
			if ChapterAudioCfg[slot1[slot6]].unlock_by_stage_id ~= 0 then
				if BattleStageData:GetStageData()[slot8.unlock_by_stage_id] and slot9.clear_times > 0 then
					return {
						slot7
					}
				end
			else
				table.insert(slot2, 1, slot7)
			end
		end

		return slot2
	end,
	GetChapterDayList = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(ChapterMapCfg.get_id_list_by_chapter_id_day[slot0]) do
			table.insert(slot1, slot5)
		end

		table.sort(slot1, function (slot0, slot1)
			return slot0 < slot1
		end)

		return slot1
	end,
	IsLastDay = function (slot0, slot1)
		return GameSetting.chapter19_timeline.value[1] == table.keyof(uv0.GetChapterDayList(slot0), slot1)
	end,
	IsNeedExpandDay = function (slot0)
		for slot5, slot6 in ipairs(uv0.GetChapterDayList(slot0)) do
			if slot5 ~= 1 and slot5 ~= 2 and slot5 ~= GameSetting.chapter19_timeline.value[1] and uv0.IsNeedGuildDay(slot0, slot6) then
				return true
			end
		end

		return false
	end,
	IsNeedGuildDay = function (slot0, slot1)
		slot6 = BattleStageData:GetStageData()[ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0][slot1][1]].location_list[1]].stage_list[1]]

		if table.keyof(uv0.GetChapterDayList(slot0), slot1) == 2 or slot8 == GameSetting.chapter19_timeline.value[1] then
			return false
		end

		if slot6 and slot6.clear_times <= 0 and uv0.IsUnlockChapterDay(slot0, slot1) and not BattleStageData:GetOperateChapterDay(slot0, slot1) and not uv0.IsLastDay(slot0, slot1) then
			return true
		end

		return false
	end,
	IsUnlockChapterDay = function (slot0, slot1)
		if not ChapterTools.IsClearPreChapterDayAllStage(slot0, slot1) then
			return false
		end

		if ActivityTools.GetActivityStatus(ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0][slot1][1]].activity_id) == 0 then
			return false
		end

		return true
	end,
	IsClearPreChapterDayAllStage = function (slot0, slot1)
		if table.keyof(uv0.GetChapterDayList(slot0), slot1) == 1 then
			return true
		end

		return uv0.IsClearChapterDayAllStage(slot0, slot2[slot3 - 1])
	end,
	IsClearChapterDayAllStage = function (slot0, slot1)
		for slot5, slot6 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id_day[slot0][slot1]) do
			if uv0.IsClearMapAllStage(slot6) == false then
				return false
			end
		end

		return true
	end,
	IsClearMapAllStage = function (slot0)
		for slot4, slot5 in ipairs(ChapterMapCfg[slot0].location_list) do
			if uv0.IsClearLocationAllStage(slot5) == false then
				return false
			end
		end

		return true
	end,
	IsClearLocationAllStage = function (slot0)
		for slot4, slot5 in ipairs(ChapterLocationCfg[slot0].stage_list) do
			if not BattleStageData:GetStageData()[slot5] or slot6.clear_times <= 0 then
				return false
			end
		end

		return true
	end,
	GetUnclearMainStageLocationID = function (slot0)
		for slot4, slot5 in ipairs(ChapterMapCfg[slot0].location_list) do
			for slot10, slot11 in ipairs(ChapterLocationCfg[slot5].stage_list) do
				if BattleStageData:GetStageData()[slot11] and slot12.clear_times <= 0 then
					return slot5
				end
			end
		end

		return nil
	end,
	NeedShowSwitchMapGuild = function (slot0, slot1, slot2)
		if uv0.GetUnclearMainStageLocationID(slot2) then
			return false
		end

		for slot7, slot8 in ipairs(ChapterMapCfg.get_id_list_by_chapter_id_day[slot0][slot1]) do
			if slot8 ~= slot2 and uv0.GetUnclearMainStageLocationID(slot8) then
				return true
			end
		end

		return false
	end,
	HasNewLocationMainStage = function (slot0)
		for slot5, slot6 in ipairs(ChapterLocationCfg[slot0].stage_list) do
			if BattleStageData:GetStageData()[slot6] and slot7.clear_times <= 0 then
				return true
			end
		end

		return false
	end,
	HasNewLocationStage = function (slot0, slot1)
		for slot6, slot7 in ipairs(ChapterLocationCfg[slot1].sub_stage_list) do
			if BattleStageData:GetStageData()[slot7] and slot8.clear_times <= 0 then
				return true
			end
		end

		for slot6, slot7 in ipairs(slot2.event_list) do
			if uv0.IsUnlockEvent(slot7) and not uv0.HasReadEventID(slot7) then
				return true
			end
		end

		if #slot2.clue > 0 and (BattleStageData:GetMapLocationData(slot0)[slot1] == nil or slot3 == 0) then
			return true
		end

		return false
	end,
	IsReadFirstEvent = function (slot0)
		for slot4, slot5 in ipairs(ChapterStoryCollectCfg.get_id_list_by_chapter_id[slot0]) do
			if uv0.HasReadEvent(slot5) then
				return true
			end
		end

		return false
	end,
	HasReadEvent = function (slot0)
		for slot4, slot5 in ipairs(ChapterStoryCollectCfg[slot0].story_id_list) do
			if uv0.HasReadEventID(slot5) then
				return true
			end
		end

		return false
	end,
	HasReadEventID = function (slot0)
		return BattleStageData:HasReadLocationEvent(slot0)
	end,
	IsUnlockEvent = function (slot0)
		if StageArchiveCfg[slot0].unlock_by_stage_id ~= 0 then
			if not BattleStageData:GetStageData()[slot1.unlock_by_stage_id] or slot2.clear_times <= 0 then
				return false
			end
		end

		return true
	end,
	NeedShowLocation = function (slot0, slot1)
		if ChapterLocationCfg[slot1].unlock_stage_id ~= 0 then
			if not BattleStageData:GetStageData()[slot2.unlock_stage_id] or slot3.clear_times <= 0 then
				return false
			end
		end

		if BattleStageData:GetStageData()[slot2.show_by_stage_id] and slot3.clear_times > 0 then
			return true
		end

		if BattleStageData:GetStageData()[slot2.hide_by_stage_id] and slot4.clear_times > 0 then
			return false
		end

		if slot2.type == BattleConst.LOCATION_TYPE.CLUE or slot2.type == BattleConst.LOCATION_TYPE.BATTLE_CLUE then
			slot5 = BattleStageData:GetMapLocationData(slot0)

			if slot2.need_scan == 1 and (not slot5 or not slot5[slot1]) then
				return false
			else
				return true
			end
		end

		for slot8, slot9 in pairs(slot2.stage_list) do
			if BattleStageData:GetStageData()[slot9] then
				return true
			end
		end

		for slot8, slot9 in pairs(slot2.sub_stage_list) do
			if BattleStageData:GetStageData()[slot9] then
				return true
			end
		end

		for slot8, slot9 in ipairs(slot2.event_list) do
			if uv0.IsUnlockEvent(slot9) then
				return true
			end
		end

		return false
	end,
	IsReadClue = function (slot0, slot1)
		if BattleStageData:GetMapLocationData(slot0) and slot2[slot1] and slot2[slot1] ~= 0 then
			return true
		end

		return false
	end,
	IsEnableLocation = function (slot0)
		if not uv0.IsNeedShowFog() then
			return true
		end

		return ChapterLocationCfg[slot0].can_not_click_until_unlock_fog ~= 1
	end,
	GetChapter19MapState = function (slot0)
		if ChapterMapCfg[slot0].unlock_map_state_by_stage_id == "" then
			return 0
		end

		for slot5, slot6 in ipairs(slot1.unlock_map_state_by_stage_id) do
			if not uv0.IsClearStage(slot6) then
				return slot5 - 1
			end
		end

		return 0
	end,
	IsNeedShowFog = function ()
		if uv0.IsClearStage(GameSetting.chapter19_fog_dissipation.value[1]) then
			return false
		end

		return true
	end,
	NeedPlayFogAnimator = function ()
		if BattleStageData:GetFogAnimatorFlag() or uv0.IsClearStage(BattleChapterStageCfg[GameSetting.chapter19_fog_dissipation.value[1]].next_unlock_id_list) then
			return false
		end

		return true
	end,
	GetChapterGroupList = function (slot0)
		slot2 = {}

		if ChapterClientCfg[slot0].toggle == BattleConst.TOGGLE.PLOT then
			for slot8, slot9 in ipairs(ChapterMainPlotToggleCfg.get_id_list_by_difficulty[slot1.difficulty]) do
				if table.keyof(ChapterMainPlotToggleCfg[slot9].chapter_client_list, slot0) then
					for slot14, slot15 in ipairs(slot10) do
						table.insert(slot2, {
							2,
							slot15
						})
					end
				elseif #slot10 == 1 then
					table.insert(slot2, {
						2,
						slot10[1]
					})
				else
					table.insert(slot2, {
						1,
						slot9
					})
				end
			end
		elseif slot1.toggle == BattleConst.TOGGLE.SUB_PLOT then
			for slot7, slot8 in ipairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.SUB_PLOT]) do
				table.insert(slot2, {
					2,
					slot8
				})
			end
		end

		return slot2
	end,
	IsChapterSystemLock = function (slot0)
		if not ChapterClientCfg[slot0] then
			return false
		end

		slot2 = type(slot1.jump_system) == "table" and slot1.jump_system[1]

		return slot2 and SystemCfg[slot2] and SystemCfg[slot2].system_hide == 1
	end
}
