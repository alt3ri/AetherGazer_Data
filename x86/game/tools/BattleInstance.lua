slot1 = nil

return {
	OnceMoreBattle = function (slot0)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot0:GetType() or BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot1 then
			if not MythicData:GetIsNew() then
				BattleController.GetInstance():LaunchBattle(slot0)
			else
				ShowTips("MYTHIC_REFRESH")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot1 then
			slot2 = slot0:GetStageId()

			if slot4[(table.indexof(ChapterCfg[getChapterIDByStageID(slot2)].section_id_list, slot2) or 0) + 1] ~= nil then
				BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER, slot4[slot5 + 1]))
			else
				ShowTips("ERROR_BAD_TEMPLATE")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot1 then
			if BattleEquipData:GetBattleEquipData().next_refresh_time < manager.time:GetServerTime() then
				if uv0 ~= nil then
					return
				end

				ShowTips("STAGE_REFRESH_DATA")

				uv0 = Timer.New(function ()
					uv0.QuitBattle(uv1)

					uv2 = nil
				end, 1.2, 1)

				uv0:Start()
			else
				BattleController.GetInstance():LaunchBattle(slot0)
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot1 then
			if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.STARTED then
				BattleController.GetInstance():LaunchBattle(slot0)
			else
				ShowTips("STAGE_REFRESH_DATA")
			end
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot1 then
			slot2 = SequentialBattleData:GetCurrentFinishStageIndex(activityID) + 1
			slot3 = slot0:GetActivityID()

			BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE, SequentialBattleChapterCfg[slot3].stage_id[slot2], slot3, slot3, slot2, {
				activityID = self.activityID_
			}))
		else
			BattleController.GetInstance():LaunchBattle(slot0)
		end
	end,
	TryNextBattle = function (slot0)
		if BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot0:GetType() then
			if slot0.GetNextStage and slot0:GetNextStage() ~= nil and not MythicData:GetIsNew() then
				BattleController.GetInstance():LaunchBattle(slot0:GetNextStage())

				return
			else
				BattleInstance.QuitBattle(slot0)
			end
		end
	end,
	GotoBattleReadyPage = function (slot0, slot1, slot2)
		if whereami == "battleResult" or whereami == "battle" then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
		else
			gameContext:Back()
			BattleFieldData:SetStoryBackFlag(true)
			gameContext:Back()
		end

		if slot2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT then
			gameContext:OverrideUrl("/chapterSection", "/chapterSection", {
				chapterID = slot0,
				section = slot1
			}, "home")
		elseif slot2 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
			BattleFieldData:SetCacheStage(slot0, slot1)
			JumpTools.Jump2SubPlot(getChapterClientCfgByChapterID(slot0).id)
		end

		if ChapterCfg[slot0].cue_sheet ~= "" then
			manager.audio:PlayBGM(slot3.cue_sheet, slot3.cue_name, slot3.awb)
		end

		OpenPageUntilLoaded("/sectionSelectHero", {
			section = slot1,
			sectionType = slot2
		})
	end,
	QuitBattle = function (slot0, slot1, slot2)
		ReleaseBattleResultSnapshot()

		slot4 = slot0:GetStageId()

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot0:GetType() then
			if not slot1 and slot0.GetNextStage and slot0:GetNextStage() ~= nil then
				BattleController.GetInstance():LaunchBattle(slot0:GetNextStage())

				return
			else
				DestroyLua()
				WarChessAction.EnterChessMap()
			end
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY == slot3 then
			StartGuildActivity(slot0:GetNodeId())
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP == slot3 then
			StartGuildActivitySP(slot0:GetNodeId())

			return
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS == slot3 then
			DestroyLua()
			NewWarChessAction.EnterChessMap()

			return
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE == slot3 then
			DestroyLua()
			gameContext:ClearHistoryByName("setting")

			if manager.time:GetServerTime() < ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime then
				gameContext.oldRoutes_ = {}

				PushSnowBallData:SetGoViewStr("/pushSnowBallSingle")
				DormMinigame.Launch("HZ07_tuanxue1")

				_G.OnLoadedCallBack_ = nil
			else
				LuaExchangeHelper.GoToMain()
			end

			return
		elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == slot3 or BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == slot3 then
			DestroyLua()
			gameContext:ClearHistoryByName("setting")

			if slot2 then
				PushSnowBallAction:SendQuitBattle()
			end

			if manager.time:GetServerTime() < ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime then
				gameContext.oldRoutes_ = {}

				PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
				DormMinigame.Launch("HZ07_tuanxue1")

				_G.OnLoadedCallBack_ = nil
			else
				LuaExchangeHelper.GoToMain()
			end

			return
		else
			DestroyLua()
			gameContext:ClearHistoryByName("setting")
			LuaExchangeHelper.GoToMain()
		end

		if BattleController.GetInstance():GetRoomProxy() then
			slot5:OnBattleQuit(slot0, slot1, slot2)
			slot5:Dispose()
			BattleController.GetInstance():ClearRoomProxy()

			return
		end

		if slot0:GetIsCooperation() then
			if CooperationData:GetRoomData() then
				CooperationTools.GotoCooperation()
			else
				CooperationTools.GotoCooperationEntry(slot3, slot0:GetDest(), slot0:GetActivityID())
			end

			return
		end

		slot6 = getChapterIDByStageID(slot4)

		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot3 then
			if ChapterCfg[slot6].clientID == ChapterConst.CHAPTER_CLIENT_19 then
				if ChapterTools.HasNewLocationMainStage(BattleFieldData:GetChapterLocationID(slot6)) then
					OpenPageUntilLoaded("/chapterPlot19Main/chapterPlot19MapLocationInfo", {
						chapterID = slot6,
						locationID = slot7
					})
				else
					OpenPageUntilLoaded("/chapterPlot19Main", {})
				end

				return
			end

			if not slot1 then
				if #getChapterClientCfgByChapterID(slot6).chapter_list > 1 and slot7.id ~= ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 and table.keyof(slot7.chapter_list, slot6) <= #slot7.chapter_list and slot4 == ChapterCfg[slot6].section_id_list[#ChapterCfg[slot6].section_id_list] and BattleStageData:GetStageData()[slot4].clear_times == 1 then
					slot9 = ChapterTools.GetChapterBranchURL(slot7.id)

					gameContext:OverrideUrl("/chapterSection", slot9, nil, "home")
					OpenPageUntilLoaded(slot9, {
						chapterClientID = slot7.id
					})

					return
				end

				slot6 = StageTools.GetAutoChapter(slot6, slot4)
			end

			OpenPageUntilLoaded("/chapterSection", {
				chapterID = slot6
			})
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT == slot3 then
			JumpTools.Jump2SubPlot(getChapterClientCfgByChapterID(slot6).id)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY == slot3 then
			OpenPageUntilLoaded("/daily", {
				chapterID = slot6
			})
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot3 then
			OpenPageUntilLoaded("/tower", {
				showInfo = true,
				chapterId = slot6
			})
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT == slot3 then
			OpenPageUntilLoaded("/enchantment")
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP == slot3 then
			OpenPageUntilLoaded("/equipSection", {
				chapterID = slot6
			})
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL == slot3 then
			if EquipBreakThroughMaterialData:GetSelectModeID() == 0 then
				gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode", nil, "home")
				OpenPageUntilLoaded("/equipBreakThroughMaterialMode")
			else
				OpenPageUntilLoaded("/equipBreakThroughMaterialMap")
			end
		elseif BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE == slot3 then
			OpenPageUntilLoaded("/equipSeizure")
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot3 then
			if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
				if #BattleBossChallengeData:GetOpenModeList() >= 2 then
					gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
					gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
					OpenPageUntilLoaded("/bossMode")
				else
					OpenPageUntilLoaded("/bossSwitch")
				end
			else
				OpenPageUntilLoaded("/bossChallenge")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE == slot3 then
			if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
				gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
				gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
				OpenPageUntilLoaded("/bossMode")
			else
				OpenPageUntilLoaded("/bossAdvanceInfo", {
					bossIndex = slot0:GetBossIndex()
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC == slot3 then
			OpenPageUntilLoaded("/mythic")
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING == slot3 or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING == slot3 then
			if BattleConst.COOPERATION_STRONGHOLD_TEACH_STAGE_ID == slot0:GetStageId() then
				OpenPageUntilLoaded("/cooperationBlank/strongholdMain")
			else
				OpenPageUntilLoaded("/teachStage")
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == slot3 then
			if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS or slot7 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/matrixOver")
			elseif slot7 == MatrixConst.STATE_TYPE.STARTED then
				OpenPageUntilLoaded("/matrixBlank/matrixOrigin")
			else
				OpenPageUntilLoaded("/matrixBlank/matrixPrepare", {
					isTimeOut = true
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS == slot3 then
			OpenPageUntilLoaded("/warHome")
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY == slot3 then
			slot7 = slot0:GetActivityID()
			slot10 = ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot7))

			if ActivityTools.GetOriginActivityID(slot7) == ActivityConst.OSIRIS_STROY then
				OpenPageUntilLoaded("/osirisStoryStage")
			elseif slot8 == ActivityConst.HELLA_STORY_STAGE_HELLA or slot8 == ActivityConst.HELLA_STORY_STAGE_HERMES then
				OpenPageUntilLoaded("/storyStageActivity", {
					theme = slot9,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot7)
				})
			elseif slot8 == ActivityConst.SUMMER_STORY_ISLAND then
				OpenPageUntilLoaded("/summerStageMain", {
					theme = slot9,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot7)
				})
			elseif slot8 == ActivityConst.SUMMER_STORY_SEABED then
				OpenPageUntilLoaded("/summerStageSeabed", {
					theme = slot9,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot7)
				})
			elseif slot8 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
				OpenPageUntilLoaded("/activityAthenaStoryStage", {
					theme = slot9,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot7)
				})
			elseif slot10 == ActivityConst.THEME.FACTORY then
				OpenPageUntilLoaded("/activityFactoryStoryStage", {
					theme = slot9,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot7)
				})
			else
				OpenPageUntilLoaded("/activityStoryStageBase", {
					theme = slot9,
					chapterID = StoryStageActivityData:GetHistoryChapter(slot7)
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON == slot3 then
			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(ActivityTools.GetMainActivityId(DemonChallengeCfg[slot0:GetActivityID()].activity_id))) == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/volumeDemonChallengeMain", {
					activityID = slot9,
					childId = slot8
				})
			elseif slot11 == ActivityConst.THEME.DREAM then
				OpenPageUntilLoaded("/dreamDemonChallengeMain", {
					activityID = slot9,
					childId = slot8
				})
			elseif slot11 == ActivityConst.THEME.ACTIVITY_2_2 then
				OpenPageUntilLoaded("/xuHeng3rddreamDemonChallengeMain", {
					activityID = slot9,
					childId = slot8
				})
			else
				OpenPageUntilLoaded("/demonChallengeMain", {
					activityID = slot9,
					childId = slot8
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.NEW_DEMON == slot3 then
			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(ActivityTools.GetMainActivityId(NewDemonChallengeCfg[slot0:GetActivityID()].activity_id))) == ActivityConst.THEME.DREAM then
				OpenPageUntilLoaded("/newDemonChallengeMain", {
					activityID = slot9,
					childId = slot8
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.HERO_TRIAL == slot3 then
			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0:GetActivityID())) == ActivityConst.THEME.OSIRIS then
				OpenPageUntilLoaded("/heroTrialActivity", {
					activityID = slot7
				})
			elseif slot9 == ActivityConst.THEME.HELLA then
				OpenPageUntilLoaded("/hellaHeroTrialActivity", {
					activityID = slot7
				})
			elseif slot9 == ActivityConst.THEME.SUMMER then
				OpenPageUntilLoaded("/summerHeroTrialActivity", {
					activityID = slot7
				})
			elseif slot9 == ActivityConst.THEME.VOLUME or slot9 == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/thirdVolumeHeroTrial", {
					activityID = slot7
				})
			elseif slot9 == ActivityConst.THEME.FACTORY then
				OpenPageUntilLoaded("/factoryHeroTrial", {
					activityID = slot7
				})
			elseif slot9 == ActivityConst.THEME.DREAM then
				OpenPageUntilLoaded("/dreamHeroTrial", {
					activityID = slot7
				})
			elseif slot9 == ActivityConst.THEME.TYR then
				OpenPageUntilLoaded("/heroTrialView_1_7", {
					activityID = slot7
				})
			else
				slot10, slot11 = ActivityTools.GetActivityMainRouteByTheme(slot9)

				OpenPageUntilLoaded(slot10, slot11)
			end
		elseif BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL == slot3 then
			slot7 = slot0:GetActivityID()

			if SkinTrialData:GetRoute().name == "heroSkin" then
				OpenPageUntilLoaded("/heroSkin", {
					skinID = slot8.skinID,
					heroID = slot8.heroID
				})
			elseif slot9 == "heroSkinPreview" then
				OpenPageUntilLoaded("/heroSkinPreview", {
					skinID = slot8.skinID,
					heroID = slot8.heroID,
					goodId = slot8.goodID
				})
			elseif slot9 == "skinTrialSelect" then
				OpenPageUntilLoaded(string.format("/skinTrialSelect%d", slot0:GetDest()), {
					activityID = slot7,
					skinTrialID = slot0:GetDest()
				})
			elseif slot9 == "skinTrialSelectView_2_0" then
				OpenPageUntilLoaded("/skinTrialSelectView_2_0", {
					activityID = slot7,
					skinTrialID = slot0:GetDest()
				})
			elseif slot9 == "skinTrialSelectView_2_2" then
				OpenPageUntilLoaded("/skinTrialSelectView_2_2", {
					activityID = slot7,
					skinTrialID = slot0:GetDest()
				})
			elseif slot9 == "skinTrialSelectView_3_0" then
				OpenPageUntilLoaded("/skinTrialSelectView_3_0", {
					activityID = slot7,
					skinTrialID = slot0:GetDest()
				})
			else
				print("未配置皮肤界面路径！")
			end
		elseif BattleConst.STAGE_TYPE_NEW.RACE_TRIAL == slot3 then
			slot7 = slot0:GetActivityID()

			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot7)) == ActivityConst.THEME.OSIRIS then
				OpenPageUntilLoaded("/raceTrial", {
					activityID = RaceTrialTools.GetMainActivityID(slot7)
				})
			elseif slot9 == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/volumeRaceTrialMain", {
					activityID = slot10
				})
			else
				slot11, slot12 = ActivityTools.GetActivityMainRouteByTheme(slot9)

				OpenPageUntilLoaded(slot11, slot12)
			end
		elseif BattleConst.STAGE_TYPE_NEW.SLAYER == slot3 then
			slot8 = slot0:GetDest()

			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0:GetActivityID())) == ActivityConst.THEME.HELLA then
				OpenPageUntilLoaded("/hellaSlayer", {
					slayer_activity_id = slot7
				})
			elseif slot10 == ActivityConst.THEME.VOLUME then
				OpenPageUntilLoaded("/volumeSlayer", {
					slayer_activity_id = slot7,
					region_activity_id = slot8
				})
			elseif slot10 == ActivityConst.THEME.TYR then
				OpenPageUntilLoaded("/slayerStageView_1_7", {
					slayer_activity_id = slot7,
					region_activity_id = slot8
				})
			else
				OpenPageUntilLoaded("/slayerStageView_2_4", {
					slayer_activity_id = slot7,
					region_activity_id = slot8
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.PARKOUR == slot3 then
			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0:GetActivityID())) == ActivityConst.THEME.HELLA then
				if ActivityData:GetActivityIsOpen(slot7) then
					OpenPageUntilLoaded("/hellaParkourEntrust", {
						parkour_activity_id = slot7,
						entrust_activity_id = slot0:GetDest()
					})
				else
					OpenPageUntilLoaded("/hellaParkour", {
						parkour_activity_id = slot7
					})
				end
			end
		elseif BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE == slot3 then
			if ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot0:GetActivityID())) == ActivityConst.THEME.HELLA then
				OpenPageUntilLoaded("/battleFirstPass", {
					activityID = ActivityTools.GetParentActivityID(slot7)
				})
			else
				print("未有绑定对应活动！", slot7)
			end
		elseif BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE == slot3 then
			slot7 = slot4
			slot8 = SoloChallengeData:GetActivityID(slot7)
			slot11 = ActivitySoloChallengeCfg[slot8].stage_id[SoloChallengeData:GetDifficultyIndex(slot7)][2]

			if ActivityTools.GetActivityTheme(slot8) == ActivityConst.THEME.SUMMER then
				if not slot1 and slot11[#slot11] == slot7 then
					OpenPageUntilLoaded("/soloChallengeMain", {
						activityID = ActivitySoloChallengeCfg[slot8].main_activity_id or ActivityConst.SUMMER_SOLO_CHALLENGE
					})
				else
					OpenPageUntilLoaded("/soloChallengeSelect", {
						activityID = slot8,
						difficultyIndex = slot9
					})
				end
			elseif slot10 == ActivityConst.THEME.FACTORY then
				if not slot1 and slot12 then
					OpenPageUntilLoaded("/factorySoloChallengeMain", {
						activityID = ActivitySoloChallengeCfg[slot8].main_activity_id
					})
				else
					OpenPageUntilLoaded("/factorySoloChallengeSelect", {
						activityID = slot8,
						difficultyIndex = slot9
					})
				end
			elseif slot10 == ActivityConst.THEME.TYR then
				if not slot1 and slot12 then
					OpenPageUntilLoaded("/soloChallengeMainView_1_7", {
						activityID = ActivitySoloChallengeCfg[slot8].main_activity_id
					})
				else
					OpenPageUntilLoaded("/soloChallengeSelectView_1_7", {
						activityID = slot8,
						difficultyIndex = slot9
					})
				end
			else
				print("未有绑定对应活动！", slot8)
			end
		elseif BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION == slot3 then
			OpenPageUntilLoaded("/limitedCalculation", {
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ARTIFACT == slot3 then
			OpenPageUntilLoaded("/artifactLevel", {
				activityID = ActivityConst.SUMMER_ARTIFACT
			})
		elseif BattleConst.STAGE_TYPE_NEW.LEVIATHAN_GAME == slot3 then
			OpenPageUntilLoaded("/leviathanLittleGame", {
				activityID = ActivityConst.LEVIATHAN_GAME
			})
		elseif BattleConst.STAGE_TYPE_NEW.SKADI_GAME == slot3 then
			OpenPageUntilLoaded("/skadiLittleGame", {
				activityID = ActivityConst.SIKADI_GAME
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_GAME == slot3 then
			OpenPageUntilLoaded("/activityPt", {
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE == slot3 then
			if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
				OpenPageUntilLoaded("/home", {})
			else
				OpenPageUntilLoaded("/guildBossMain", {
					isFailed = slot1 and true or false
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE == slot3 then
			if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
				OpenPageUntilLoaded("/home", {})
			else
				OpenPageUntilLoaded("/guildBossChallenge", {
					isFailed = slot1 and true or false
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == slot3 then
			if ActivityMatrixData:GetGameState(slot0:GetActivityID()) == MatrixConst.STATE_TYPE.SUCCESS or slot8 == MatrixConst.STATE_TYPE.FAIL then
				OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
					matrix_activity_id = slot7
				})
			elseif slot8 == MatrixConst.STATE_TYPE.STARTED then
				OpenPageUntilLoaded("/matrixBlank/activityMatrixOrigin", {
					matrix_activity_id = slot7
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE == slot3 then
			if ActivityTools.GetActivityTheme(slot0:GetActivityID()) == ActivityConst.THEME.VOLUME_DOWN then
				OpenPageUntilLoaded("/activityRaceSwitch", {
					activityID = slot7,
					rankID = ActivityConst.ACTIVITY_RACE_RANK
				})
			else
				OpenPageUntilLoaded("/activityRaceSwitch", {
					activityID = slot7,
					rankID = ActivityConst.ACTIVITY_RACE_RANK
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == slot3 then
			StrategyMatrixAction.GotoAfterBattleMatirx(slot0:GetActivityID())
		elseif BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL == slot3 then
			OpenPageUntilLoaded("/mythicUltimateView")
		elseif BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE == slot3 then
			SequentialBattleData:ResetChapterTeamData(slot0:GetActivityID())

			if slot2 then
				OpenPageUntilLoaded("/sequentialBattleFactoryTeam", {
					activityID = slot7
				})
			else
				OpenPageUntilLoaded("/sequentialBattleFactory")
			end
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_GAME == slot3 then
			OpenPageUntilLoaded("/towerGameView", {})
		elseif BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL == slot3 then
			if ActivityCfg[slot0:GetActivityID()].activity_theme == ActivityConst.THEME.FACTORY then
				OpenPageUntilLoaded("/mardukSpecialMain", {
					activityID = ActivityConst.FACTORY_MARDUK
				})
			elseif ActivityCfg[slot7].activity_theme == ActivityConst.THEME.ACTIVITY_2_2 then
				OpenPageUntilLoaded("/activityMain_2_2", {
					activityID = ActivityConst.ACTIVITY_2_2,
					subActivityID = ActivityConst.ACTIVITY_2_2_SPECIAL
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO == slot3 then
			slot8 = ActivitySoloSlayerCfg[slot0:GetActivityID()].main_activity_id
			slot9 = ActivityCfg[slot8]

			if slot8 == ActivityConst.FACTORY_SURVIVE_SOLO or slot8 == ActivityConst.TYR_SURVIVE_SOLO then
				OpenPageUntilLoaded("/surviveSolo", {
					activityID = slot8
				})
			else
				slot12, slot13 = ActivityTools.GetActivityMainRouteByTheme(ActivityTools.GetOriginActivityTheme(ActivityTools.GetActivityTheme(slot8)))

				OpenPageUntilLoaded(slot12, slot13)
			end
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WORLD_BOSS == slot3 then
			OpenPageUntilLoaded("/nienWorldBoss")
		elseif BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT == slot3 then
			if ActivityTools.GetMainActivityId(slot0:GetActivityID()) == ActivityConst.ACTIVITY_2_4_AFFIX_SELECT then
				OpenPageUntilLoaded("/activityMain_2_4", {
					activityID = ActivityConst.ACTIVITY_2_4,
					subActivityID = slot7
				})
			else
				OpenPageUntilLoaded("/affixSelectMain", {
					activityID = slot7
				})
			end
		elseif BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST == slot3 then
			OpenPageUntilLoaded("/bossCombatSelect", {
				damageTestId = DamageTestCfg.get_id_list_by_stage_id[slot0:GetStageId()][1]
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_NORMAL == slot3 then
			OpenPageUntilLoaded("/activityPt2", {
				mainActivityId = ActivityPt2Tools:GetMainActivityID(slot0:GetActivityID()),
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE == slot3 then
			OpenPageUntilLoaded("/activityPt2", {
				mainActivityId = ActivityPt2Tools:GetMainActivityID(slot0:GetActivityID()),
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_HARD == slot3 then
			OpenPageUntilLoaded("/activityPt2", {
				mainActivityId = ActivityPt2Tools:GetMainActivityID(slot0:GetActivityID()),
				activityID = slot0:GetActivityID()
			})
		elseif BattleConst.STAGE_TYPE_NEW.ABYSS == slot3 then
			OpenPageUntilLoaded("/abyssMain", {})
		elseif BattleConst.STAGE_TYPE_NEW.POLYHEDRON == slot3 then
			if PolyhedronConst.STATE_TYPE.SETTLEMENT == PolyhedronData:GetPolyhedronInfo():GetState() then
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
			else
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER == slot3 then
			OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterSelectAssistant", {
				activityID = slot0:GetMainActivityId()
			})
		else
			if BattleConst.STAGE_TYPE_NEW.SAIL_GAME == slot3 then
				if not ActivityData:GetActivityIsOpen(slot0:GetActivityID()) then
					ShowTips("TIME_OVER")
					OpenPageUntilLoaded("/sailMain", {
						activityID = slot7
					})

					return
				end

				slot8 = nil

				if not slot1 then
					slot8 = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS
				end

				SailGameAction.SetEventEndMark(slot7, slot8)
				OpenPageUntilLoaded("/sailMain", {
					activityID = slot7
				})

				function _G.OnLoadedCallBack_()
					SailGameTools.GoToGameView(uv0)
				end

				return
			end

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST == slot3 then
				OpenPageUntilLoaded("/advanceTestMain")
			elseif BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON == slot3 then
				OpenPageUntilLoaded("/soloHeartDemonMain")
			elseif BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME == slot3 then
				OpenPageUntilLoaded("/destroyBoxGame", {
					activityID = DestroyBoxGameCfg[slot0:GetDest()].main_activity_id
				})
			elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME == slot3 then
				OpenPageUntilLoaded("/kagutsuchiWork", {})
			elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL == slot3 then
				OpenPageUntilLoaded("/activityPtScroll", {
					mainActivityID = slot0:GetActivityID()
				})
			elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA == slot3 then
				OpenPageUntilLoaded("/activityAttributeArena", {
					activityID = slot0:GetActivityID()
				})
			elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_SINGLE == slot3 then
				if not LuaExchangeHelper.GetSceneIsHanding() then
					CheckManagers()

					function _G.OnLoadedCallBack_()
						if manager.time:GetServerTime() < ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime then
							PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
							DormMinigame.Launch("HZ07_xueqiu1")
						end
					end
				end
			elseif BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_BOSS == slot3 or BattleConst.STAGE_TYPE_NEW.PUSH_SNOWBALL_TEAM_SURVIVAL == slot3 then
				if not LuaExchangeHelper.GetSceneIsHanding() then
					CheckManagers()

					function _G.OnLoadedCallBack_()
						if manager.time:GetServerTime() < ActivityData:GetActivityData(PushSnowBallData:GetActivityID()).stopTime then
							PushSnowBallData:SetGoViewStr("/pushSnowBallTeam")
							DormMinigame.Launch("HZ07_xueqiu1")
						end
					end
				end
			elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_INDIA_NIAN == slot3 then
				OpenPageUntilLoaded("/indiaNianMain")
			elseif BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE == slot3 then
				OpenPageUntilLoaded("/activityPushBoxMaterial", {
					activityID = slot0:GetActivityID()
				})
			elseif BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION == slot3 then
				OpenPageUntilLoaded("/coreVerificationInfo", {
					bossType = slot0:GetContID()
				})
			elseif BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 == slot3 then
				OpenPageUntilLoaded("/spHeroChallengeBattleToggleView", {
					stageID = slot0:GetStageId()
				})
			elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_HERO_ENHANCE == slot3 then
				OpenPageUntilLoaded("/activityHeroEnhanceSection", {
					exitFromBattle = true,
					activityID = slot0:GetActivityID(),
					cfgId = slot0:GetHeroEnhanceCfgId()
				})
			elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE == slot3 then
				slot9 = slot0:GetLevelID()

				OpenPageUntilLoaded("/activityReforgeLevelView", {
					activityID = slot0:GetMainActivityID(),
					chapterActivityID = slot0:GetChapterActivityID()
				})
			end
		end
	end,
	hideBattlePanel = function ()
		if GameObject.Find("UICamera/Canvas/UIMain") == nil then
			return
		end

		if slot0.transform:Find("BattlePanel") ~= nil then
			SetActive(slot2.gameObject, false)
		end

		LuaForCursor.SwitchCursor(true)
	end,
	GetToSeverStarList = function (slot0)
		slot1 = {}

		for slot5 = 1, #slot0 do
			if slot0 and slot0[slot5] then
				table.insert(slot1, {
					star_id = slot5 + BattleConst.STAR,
					is_achieve = slot0[slot5].isComplete and 1 or 0
				})
			end
		end

		return slot1
	end,
	CaculateStarMission = function (slot0, slot1)
		slot3 = {}

		if slot0:GetThreeStar() then
			for slot7 = 1, #slot2 do
				table.insert(slot3, uv0.CaculateStar(slot0, slot2[slot7], slot1))
			end
		end

		return slot3
	end,
	CaculateStar = function (slot0, slot1, slot2)
		if ThreeStarConditionCfg[slot1[1]].id == BattleConst.STAR_TYPE.DEAD_NUM then
			-- Nothing
		elseif slot3.id == BattleConst.STAR_TYPE.NO_DEAD then
			slot4.total = 1
			slot4.current = slot2.totalDeadNum > 0 and 0 or 1
			slot4.isComplete = slot4.current == 1
		elseif slot3.id == BattleConst.STAR_TYPE.HITTED_NUM then
			slot4.total = slot1[2]
			slot4.current = slot2.totalHittedNum
			slot4.isComplete = slot2.totalHittedNum <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.USE_TIME then
			slot4.total = slot1[2]
			slot4.current = math.floor(slot2.battleTime)
			slot4.isComplete = slot2.battleTime <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.COMBO then
			slot4.total = slot1[2]
			slot4.current = slot2.maxComboNum
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.SECOND_DAMAGE then
			slot4.total = slot1[3]
			slot4.current = uv0.CaculateSecondData(slot2.damagePerCount, slot1[3] * 2 + 1)
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.SECOND_KILL then
			slot4.total = slot1[3]
			slot4.current = uv0.CaculateSecondData(slot2.enemyKillPerCount, slot1[3] * 2 + 1)
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.SUCCESS then
			slot4.isComplete = whereami ~= "battle"
		elseif slot3.id == BattleConst.STAR_TYPE.INJURED_NUM then
			slot4.total = slot1[2]
			slot4.current = slot2.injuredNum
			slot4.isComplete = slot4.current <= slot4.total
		elseif slot3.id == BattleConst.STAR_TYPE.MY_FALL then
			slot4.total = slot1[2]
			slot4.current = slot2.fallDownNum
			slot4.isComplete = slot4.current <= slot4.total
		elseif slot3.id == BattleConst.STAR_TYPE.ENEMY_FALL then
			slot4.total = slot1[2]
			slot4.current = slot2.knockoutNum
			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.HAVE_HERO then
			slot4.total = 1
			slot4.current = 0

			for slot9, slot10 in ipairs(slot0:GetHeroTeam()) do
				if slot1[2] == slot10 then
					slot4.current = 1
				end
			end

			slot4.isComplete = slot4.current == 1
		elseif slot3.id == BattleConst.STAR_TYPE.RESURGENCE_TIME then
			slot4.total = slot1[2]
			slot4.current = slot2.resurrectTimes
			slot4.isComplete = slot2.resurrectTimes <= slot1[2]
		elseif slot3.id == BattleConst.STAR_TYPE.NO_RESURGENCE then
			slot4.total = 1
			slot4.current = slot2.resurrectTimes > 0 and 0 or 1
			slot4.isComplete = slot4.current == 1
		elseif slot3.id == BattleConst.STAR_TYPE.PROP_MULTI then
			slot4.total = slot1[2]
			slot4.current = 0
			slot6 = slot2.items:GetEnumerator()

			while slot6:MoveNext() do
				if slot6.Current.Key == slot1[3] then
					slot4.current = slot6.Current.Value or 0
				end
			end

			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.PROP_SINGLE then
			slot4.total = 1
			slot4.current = 0
			slot6 = slot2.items:GetEnumerator()

			while slot6:MoveNext() do
				if slot6.Current.Key == slot1[2] then
					slot4.current = slot6.Current.Value or 0
				end
			end

			slot4.isComplete = slot4.total <= slot4.current
		elseif slot3.id == BattleConst.STAR_TYPE.ENEMY_EXCUTE then
			slot4.total = slot1[2]
			slot4.current = LuaExchangeHelper.GetBattleStatisticsData().deathInfos.Count
			slot4.isComplete = slot4.total <= slot4.current
		end

		return {
			isComplete = false,
			total = 0,
			current = 0,
			id = slot1[1],
			xData = slot1[2],
			yData = slot1[3],
			total = slot1[2],
			current = slot2.totalDeadNum,
			isComplete = slot2.totalDeadNum <= slot1[2]
		}
	end,
	GetStarMissionText = function (slot0, slot1, slot2)
		slot3 = ThreeStarConditionCfg[slot0]
		slot5 = slot2

		if slot0 == BattleConst.STAR_TYPE.HAVE_HERO then
			slot4 = ItemTools.getItemName(tonumber(slot1))
		elseif slot0 == BattleConst.STAR_TYPE.PROP_MULTI then
			slot5 = ItemTools.getItemName(tonumber(slot5))
		elseif slot0 == BattleConst.STAR_TYPE.PROP_SINGLE then
			slot4 = ItemTools.getItemName(tonumber(slot4))
		end

		return System.String.Format(GetI18NText(slot3.desc), GetI18NText(slot4), GetI18NText(slot5))
	end,
	RecordThreeStar = function (slot0, slot1, slot2)
		if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0 then
			BattleStageAction.ClientModifyThreeStar(slot1, slot2)
		elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0 and manager.time:GetServerTime() < BattleBossChallengeData:GetNextRefreshTime() then
			BattleBossChallengeAction.ClientModifyThreeStar(slot1, slot2)
		end
	end,
	CaculateSecondData = function (slot0, slot1)
		slot3 = 0
		slot4 = 0

		if slot0.Count <= slot1 then
			for slot8 = 0, slot2 - 1 do
				slot4 = slot0[slot8] + slot4
			end

			return slot4
		else
			for slot8 = 0, slot1 - 1 do
				slot4 = slot0[slot8] + slot4
			end

			slot3 = slot4
		end

		for slot8 = 0, slot2 - slot1 - 1 do
			slot9 = slot4 - slot0[slot8] + slot0[slot1 + slot8]
			slot3 = math.max(slot3, slot9)
			slot4 = slot9
		end

		return slot3
	end,
	GetSumData = function (slot0)
		for slot6 = 0, slot0.Count - 1 do
			slot2 = 0 + slot0[slot6]
		end

		return slot2
	end,
	GetMapName = function (slot0)
		if not BattleChapterStageCfg[slot0] then
			return ""
		end

		slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

		if ChapterCfg[getChapterIDByStageID(slot0)].difficulty == 1 then
			return string.format("%s %s-%s", GetTips("HARDLEVEL_EASY"), GetI18NText(slot2), GetI18NText(slot3))
		elseif slot1.type == 2 then
			return string.format("%s %s-%s", GetTips("HARDLEVEL_HARD_2"), GetI18NText(slot2), GetI18NText(slot3))
		end
	end,
	GetCurrentBattleId = function ()
		for slot5, slot6 in pairs(BattleStageData:GetStageData() or {}) do
			if getChapterClientCfgByStageID(slot5) and getChapterToggle(slot7.id) == BattleConst.TOGGLE.PLOT and BattleChapterStageCfg.all[1] < slot5 then
				slot0 = slot5
			end
		end

		return slot0
	end,
	BattleResultAddHeroExp = function (slot0)
		slot1, slot2 = slot0:GetHeroTeam()
		slot3 = slot0:GetSystemHeroTeam()

		if slot1[2] == 0 then
			table.remove(slot1, 2)
			table.remove(slot2, 2)
			table.insert(slot1, 0)
			table.insert(slot2, 0)
		end

		for slot7 = 1, 3 do
			if slot1[slot7] and slot1[slot7] ~= 0 then
				slot8 = slot0:GetHeroDataByPos(slot7)

				if not slot3[slot7] and slot2[slot7] == 0 and uv0.NeedAddExp(slot0) then
					slot10 = slot8.exp - LvTools.LevelToExp(slot8.level, "hero_level_exp1")

					if LvTools.GetMaxTotalExp("hero_level_exp1") - slot8.exp < 0 then
						slot12 = 0
					end

					slot14 = slot0:GetAddHeroExp() * slot0:GetMultiple()
					slot15 = slot0:GetActivityID()
					slot16 = ActivityData:GetActivityData(slot15)

					if slot15 ~= 0 and (not slot16 or not slot16:IsActivitying()) then
						slot14 = 0
					end

					slot17 = math.min(slot14, slot12)
					slot19, slot20, slot21, slot22, slot23 = LvTools.CheckHeroExp(slot9, slot8.exp + slot17, HeroTools.GetHeroCurrentMaxLevel(slot8))

					HeroAction.AddHeroExpSuccess(slot8.id, slot19, slot8.exp + slot17 - slot23)
				end
			end
		end
	end,
	NeedAddExp = function (slot0)
		if BattleStageData:GetStageData()[slot0:GetStageId()] and slot2.clear_times <= 1 then
			return true
		elseif not slot2 then
			return true
		else
			return false
		end
	end,
	GetHardLevel = function (slot0)
		return slot0 % 10
	end,
	GetEquipStageShowIndex = function (slot0)
		return math.floor(slot0 / 10) % 10
	end
}
