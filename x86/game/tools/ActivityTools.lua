slot1 = {}

return {
	GetCurrentAdvInfo = function ()
		slot0 = {}

		for slot4, slot5 in ipairs(MainAdvinfoCfg.all) do
			if ActivityTools.IsValidAdv(MainAdvinfoCfg[slot5].id) then
				table.insert(slot0, {
					id = slot6.id,
					image = getSpriteWithoutAtlas("TextureConfig/Announcements/" .. (slot6.picture or "activity1") .. SettingData:GetCurrentLanguageKey())
				})
			end
		end

		table.sort(slot0, function (slot0, slot1)
			if MainAdvinfoCfg[slot0.id].order == MainAdvinfoCfg[slot1.id].order then
				return slot0.id < slot1.id
			else
				return slot2 < slot3
			end
		end)

		return slot0
	end,
	IsValidAdv = function (slot0)
		slot1 = MainAdvinfoCfg[slot0]
		slot2 = slot1.activityId

		if slot1.hide_condition and #slot1.hide_condition > 0 then
			slot3 = true

			for slot7, slot8 in ipairs(slot1.hide_condition) do
				if not IsConditionAchieved(slot8) then
					slot3 = false

					break
				end
			end

			if slot3 then
				return false
			end
		end

		if slot2 and slot2 ~= 0 then
			return ActivityData:GetActivityData(slot2) and slot3:IsActivitying() or false
		else
			if not slot1.time[1] or #slot3[1] < 3 or #slot3[2] < 3 then
				return false
			end

			if not slot1.time[2] or #slot4[1] < 3 or #slot4[2] < 3 then
				return false
			end

			return TimeMgr.GetInstance():GetServerTime() < TimeMgr.GetInstance():parseTimeFromConfig(slot1.time[2]) and TimeMgr.GetInstance():parseTimeFromConfig(slot1.time[1]) <= slot7
		end
	end,
	ClickAdv = function (slot0)
		if MainAdvinfoCfg[slot0.id].type == 1 then
			JumpTools.JumpToPage2(slot1.parameter)
		elseif slot1.type == 2 then
			Application.OpenURL(slot1.parameter[1])
		end
	end,
	GetActivityType = function (slot0)
		if ActivityCfg[slot0] then
			return slot1.activity_template
		end

		return ActivityData:GetActivityData(slot0).template
	end,
	GetActivityTheme = function (slot0)
		if ActivityCfg[slot0] then
			return slot1.activity_theme
		end

		return ActivityData:GetActivityData(slot0).theme
	end,
	JumpToSubmodulePage = function (slot0)
		slot4 = uv0.GetOriginActivityID(slot0)

		if ActivityTemplateConst.STORY == uv0.GetActivityType(slot0) then
			if uv0.GetOriginActivityTheme(uv0.GetActivityTheme(slot0)) == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/storyStageActivity", {
					theme = slot2
				})
			elseif slot3 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/summerStoryMainRemastered")
			elseif slot3 == ActivityConst.THEME.FACTORY then
				JumpTools.Jump2SubPlot(6010004)
			elseif slot4 == ActivityConst.TYR_SUB_PLOT then
				JumpTools.Jump2SubPlot(6010006)
			end
		elseif ActivityTemplateConst.STORY_STAGE == slot1 then
			if slot4 == ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT then
				ActivityStoryAction.UpdateRedPoint(slot0, 0)
				JumpTools.OpenPageByJump("/activityAthenaStoryStage", {
					theme = slot3,
					chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[slot0][1]
				})
			else
				print("未知的剧情活动" .. slot0)
				ActivityStoryAction.UpdateRedPoint(slot0, 0)
				JumpTools.OpenPageByJump("/activityStoryStageBase", {
					theme = slot3,
					chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[slot0][1]
				})
			end
		elseif ActivityTemplateConst.DEMON == slot1 then
			if slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeDemonChallengeMain", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.DREAM then
				JumpTools.OpenPageByJump("/dreamDemonChallengeMain", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/demonChallengeMain", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.ACTIVITY_2_2 then
				JumpTools.OpenPageByJump("/xuHeng3rddreamDemonChallengeMain", {
					activityID = slot0
				})
			end
		elseif ActivityTemplateConst.NEW_DEMON == slot1 then
			JumpTools.OpenPageByJump("/newDemonChallengeMain", {
				activityID = slot0
			})
		elseif ActivityConst.SUBMODULE_TYPE.CHESS == slot1 then
			JumpTools.OpenPageByJump("/activityChessView", {
				activityID = slot0
			})
		elseif ActivityTemplateConst.TALENT_TREE == slot1 then
			JumpTools.OpenPageByJump("/talentTree", {
				activityID = slot0
			})
		elseif ActivityTemplateConst.BATTLE_FIRST_PASS == slot1 then
			JumpTools.OpenPageByJump("/battleFirstPass", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.HERO_TRIAL then
			if slot3 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/hellaHeroTrialActivity", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/summerHeroTrialActivity", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.VOLUME or slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/thirdVolumeHeroTrial", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/factoryHeroTrial", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.DREAM then
				JumpTools.OpenPageByJump("/dreamHeroTrial", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.TYR then
				JumpTools.OpenPageByJump("/heroTrialView_1_7", {
					activityID = slot0
				})
			else
				JumpTools.OpenPageByJump("/hellaHeroTrialActivity", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.SKIN_TRIAL then
			if slot3 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/skinTrialActivity", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/summerSkinTrialActivity", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.VOLUME or slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeSkinTrialActivity", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/factorySkinTrialActivity", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.DREAM then
				JumpTools.OpenPageByJump("/dreamSkinTrialActivity", {
					activityID = slot0
				})
			else
				JumpTools.OpenPageByJump("/skinTrialActivity", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.SLAYER then
			if slot3 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/hellaSlayer", {
					slayer_activity_id = slot0
				})
			elseif slot3 == ActivityConst.THEME.VOLUME then
				JumpTools.OpenPageByJump("/volumeSlayerMain", {
					playerAnim = true,
					slayer_activity_id = slot0
				})
			elseif slot3 == ActivityConst.THEME.TYR then
				JumpTools.OpenPageByJump("/slayerMainView_1_7", {
					playerAnim = true,
					slayer_activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.PARKOUR then
			if slot3 == ActivityConst.THEME.HELLA then
				JumpTools.OpenPageByJump("/hellaParkour", {
					parkour_activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.SOLO_CHALLENGE then
			if slot3 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/soloChallengeMain", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/factorySoloChallengeMain", {
					activityID = slot0
				})
			elseif slot3 == ActivityConst.THEME.TYR then
				JumpTools.OpenPageByJump("/soloChallengeMainView_1_7", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.ARTIFACT then
			if slot3 == ActivityConst.THEME.SUMMER then
				JumpTools.OpenPageByJump("/artifact", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.LIMITED_CALCULATION then
			JumpTools.OpenPageByJump("/limitedCalculation", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.SKADI_LITTLE_GAME then
			JumpTools.OpenPageByJump("/skadiLittleGame", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.LEVIATHAN_LITTLE_GAME then
			JumpTools.OpenPageByJump("/leviathanLittleGame", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.FISHING then
			JumpTools.OpenPageByJump("/fishingEnter", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.SKIN_EXCHANGE then
			JumpTools.OpenPageByJump("/skinExchange", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.SUMMER_ACTIVITY_PT then
			JumpTools.OpenPageByJump("/activityPt", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.MAIN_STORY then
			slot5 = ChapterTools.GetChapterByActivityID(slot0)

			BattleFieldData:SetCacheChapterClient(ChapterClientCfg[slot5].toggle, getChapterClientCfgByChapterID(slot5).id)
			JumpTools.OpenPageByJump("/chapterMapContent", {})
		elseif slot1 == ActivityTemplateConst.MOONBO then
			if slot3 == ActivityConst.THEME.VOLUME then
				JumpTools.OpenPageByJump("/moonBoView", {
					activityID = slot0
				})
			else
				JumpTools.OpenPageByJump("/moonBoView", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUZZLE then
			JumpTools.OpenPageByJump("/puzzleMain", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.SINGLE_MATRIX then
			if slot3 == ActivityConst.THEME.VOLUME then
				JumpTools.OpenPageByJump("/matrixBlank/activityMatrix", {
					playerAnim = true,
					main_matrix_activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.COWBOY then
			JumpTools.OpenPageByJump("/cowboy", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_RACE then
			if slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/activityRaceMain", {
					activityID = slot0,
					rankID = ActivityConst.ACTIVITY_RACE_RANK
				})
			end
		elseif slot1 == ActivityTemplateConst.RACE_TRIAL then
			if slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeRaceTrialMain", {
					activityID = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.ACTIVITY_MUSIC then
			if slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeMusicMain", {
					activity_id = slot0
				})
			elseif slot3 == ActivityConst.THEME.VOLUME_DOWN then
				JumpTools.OpenPageByJump("/volumeMusicMain2", {
					activity_id = slot0
				})
			end
		elseif slot1 == ActivityTemplateConst.STRATEGY_MATRIX then
			StrategyMatrixAction.GotoStrategyMatrix(slot0, true)
		elseif slot1 == ActivityTemplateConst.INFINITY_POOL_TASK then
			if slot3 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/infinityTaskFactory", {
					activityType = OsirisConst.ACTIVITY_TYPE.TASK,
					activityTaskID = ActivityConst.FACTORY_INFINITY_TASK,
					activityInfinityID = ActivityConst.FACTORY_INFINITY_POOL
				})
			end
		elseif slot1 == ActivityTemplateConst.SEQUENTIAL_BATTLE then
			if slot3 == ActivityConst.THEME.FACTORY then
				JumpTools.OpenPageByJump("/sequentialBattleFactory")
			end
		elseif slot1 == ActivityTemplateConst.SURVIVE_SOLO then
			JumpTools.OpenPageByJump("/surviveSolo", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.MARDUK_SPECIAL then
			JumpTools.OpenPageByJump("/mardukSpecialMain", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.MARDUK_GAME then
			JumpTools.OpenPageByJump("/towerGameView")
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
			JumpTools.OpenPageByJump("/springFestivalRiddleMain")
		elseif slot1 == ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET then
			JumpTools.OpenPageByJump("/antitheticalCouplet", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.SPRING_CANTEEN then
			JumpTools.GoToCanteen()
		elseif slot1 == ActivityTemplateConst.ACTIVITY_WORLD_BOSS then
			JumpTools.OpenPageByJump("/nienWorldBoss")
		elseif slot1 == ActivityTemplateConst.PAPER_CUT then
			JumpTools.OpenPageByJump("/paperCutMain", {
				activityID = ActivityConst.PAPER_CUT_GAME
			})
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
			JumpTools.OpenPageByJump("springFestivalGreetingEnvelop")
		elseif slot1 == ActivityTemplateConst.FIRE_WORK_MAIN then
			JumpTools.OpenPageByJump("/fireWorkMain")
		elseif slot1 == ActivityTemplateConst.VALENTINE_GAME then
			JumpTools.OpenPageByJump("/valentineGameMain", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_AFFIX_SELECT then
			JumpTools.OpenPageByJump("/affixSelectMain", {
				activityID = ActivityConst.ACTIVITY_1_7_AFFIX_SELECT
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO then
			JumpTools.OpenPageByJump("/activityCultivateHeroMain", {
				activityID = ActivityConst.ACTIVITY_CULTIVATE_HERO
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_MEMORY then
			JumpTools.OpenPageByJump("/activityMemoryEnter", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_QUIZ then
			JumpTools.OpenPageByJump("/activityQuizEnter", {
				activityID = slot0
			})
		elseif slot1 == ActivityTemplateConst.ACTIVITY_INDIA_NIAN then
			JumpTools.OpenPageByJump("/indiaNianMain")
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUSH_SNOW_BALL then
			JumpTools.OpenPageByJump("/pushSnowBallMain")
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_COMBINE_GAME then
			JumpTools.OpenPageByJump("/CombineGameMainView")
		elseif slot1 == ActivityTemplateConst.ACTIVITY_SPRING_WELFARE then
			JumpTools.OpenPageByJump("/springWelfarePrayTree")
		end
	end,
	GetRedPointKey = function (slot0)
		if ActivityTemplateConst.DEMON == uv0.GetActivityType(slot0) then
			return RedPointConst.DEMON_CHALLENGE
		elseif ActivityTemplateConst.NEW_DEMON == slot1 then
			return RedPointConst.NEW_DEMON_CHALLENGE
		elseif ActivityTemplateConst.TALENT_TREE == slot1 then
			return RedPointConst.TALENT_TREE
		elseif ActivityTemplateConst.BATTLE_FIRST_PASS == slot1 then
			return RedPointConst.BATTLE_FIRST_PASS
		elseif ActivityTemplateConst.HERO_TRIAL == slot1 then
			return RedPointConst.HERO_TRIAL .. "_"
		elseif ActivityTemplateConst.SKIN_TRIAL == slot1 then
			return RedPointConst.SKIN_TRIAL .. "_"
		elseif ActivityTemplateConst.SLAYER == slot1 then
			return RedPointConst.SLAYER .. "_"
		elseif ActivityTemplateConst.STORY == slot1 then
			return RedPointConst.ACTIVITY_STORY_STAGE
		elseif ActivityTemplateConst.STORY_STAGE == slot1 then
			return RedPointConst.ACTIVITY_STORY_STAGE
		elseif ActivityTemplateConst.SUB_PLOT == slot1 then
			return RedPointConst.ACTIVITY_STORY_STAGE
		elseif ActivityTemplateConst.PARKOUR == slot1 then
			return RedPointConst.PARKOUR .. "_"
		elseif ActivityTemplateConst.CHESS == slot1 then
			return RedPointConst.WAR_CHESS .. "_"
		elseif ActivityTemplateConst.MAIN_ACTIVITY == slot1 then
			return RedPointConst.MAIN_ACTIVITY
		elseif ActivityTemplateConst.SOLO_CHALLENGE == slot1 then
			return RedPointConst.SOLO_CHALLENGE .. "_"
		elseif ActivityTemplateConst.LIMITED_CALCULATION == slot1 then
			return RedPointConst.LIMITED_CALCULATION
		elseif ActivityTemplateConst.ARTIFACT == slot1 then
			return RedPointConst.ARTIFACT .. "_"
		elseif ActivityTemplateConst.SKADI_LITTLE_GAME == slot1 then
			return RedPointConst.SKADI_LITTLE_GAME .. "_"
		elseif ActivityTemplateConst.LEVIATHAN_LITTLE_GAME == slot1 then
			return RedPointConst.LEVIATHAN_LITTLE_GAME .. "_"
		elseif ActivityTemplateConst.FISHING == slot1 then
			return RedPointConst.FISHING .. "_"
		elseif ActivityTemplateConst.SUMMER_ACTIVITY_PT == slot1 then
			return RedPointConst.SUMMER_ACTIVITY_PT_OPEN .. "_"
		elseif ActivityTemplateConst.SKIN_EXCHANGE == slot1 then
			return RedPointConst.ACTIVITY_SKIN_EXCHANGE .. "_"
		elseif ActivityTemplateConst.MOONBO == slot1 then
			return RedPointConst.MOONBO .. "_"
		elseif ActivityTemplateConst.ACTIVITY_PUZZLE == slot1 then
			return RedPointConst.ACTIVITY_PUZZLE .. "_"
		elseif slot1 == ActivityTemplateConst.SINGLE_MATRIX then
			return RedPointConst.ACTIVITY_MATRIX .. "_"
		elseif slot1 == ActivityTemplateConst.COWBOY then
			return RedPointConst.COWBOY .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_RACE then
			return RedPointConst.ACTIVITY_RACE .. "_"
		elseif slot1 == ActivityTemplateConst.RACE_TRIAL then
			return RedPointConst.ACTIVITY_RACE_TRIAL .. "_"
		elseif slot1 == ActivityTemplateConst.STRATEGY_MATRIX then
			return RedPointConst.STRATEGY_MATRIX .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_MUSIC then
			return RedPointConst.MUSIC .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER then
			return RedPointConst.ZUMA
		elseif slot1 == ActivityTemplateConst.GUILD_ACTIVITY then
			return RedPointConst.GUILD_ACTIVITY .. "_"
		elseif slot1 == ActivityTemplateConst.GUILD_ACTIVITY_SP then
			return RedPointConst.GUILD_ACTIVITY_SP .. "_"
		elseif slot1 == ActivityTemplateConst.INFINITY_POOL_TASK then
			return RedPointConst.INFINITY_POOL_TASK .. "_"
		elseif slot1 == ActivityTemplateConst.SEQUENTIAL_BATTLE then
			return RedPointConst.SEQUENTIAL_BATTLE .. "_"
		elseif slot1 == ActivityTemplateConst.MARDUK_SPECIAL then
			return RedPointConst.MARDUK_SPECIAL .. "_"
		elseif slot1 == ActivityTemplateConst.SURVIVE_SOLO then
			return RedPointConst.SOLO_SURVIVE .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_WORLD_BOSS then
			return RedPointConst.ACTIVITY_WORLD_BOSS .. "_"
		elseif slot1 == ActivityTemplateConst.MARDUK_GAME then
			return RedPointConst.MARDUK_TOWERGAME .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
			return RedPointConst.SPRING_FESTIVAL_GREETING .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
			return RedPointConst.SPRING_FESTIVAL_RIDDLE .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET then
			return RedPointConst.ANTITHETICAL_COUPLET .. "_"
		elseif slot1 == ActivityTemplateConst.PAPER_CUT then
			return RedPointConst.PAPER_CUT .. "_"
		elseif slot1 == ActivityTemplateConst.FIRE_WORK_MAIN then
			return RedPointConst.FIRE_WORK_MAIN .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_CANTEEN then
			return RedPointConst.CANTEEN .. "_"
		elseif slot1 == ActivityTemplateConst.TRAVEL_SKULD then
			return RedPointConst.TRAVEL_SKULD_ACTIVITY
		elseif slot1 == ActivityTemplateConst.VALENTINE_GAME or slot1 == ActivityTemplateConst.INDIA_VALENTINE_GAME_V2 then
			return RedPointConst.VALENTINE_GAME .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_AFFIX_SELECT then
			return RedPointConst.AFFIX_SELECT .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO then
			return RedPointConst.CULTIVATE_HERO .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_2_0_SEAL then
			return RedPointConst.XH1ST_SEAL .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PT_2 then
			return RedPointConst.ACTIVITY_PT_2 .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_SET then
			return RedPointConst.ACTIVITY_SET .. "_"
		elseif slot1 == ActivityTemplateConst.CHESS_ACTIVITY_CHINESE_ZONE then
			return RedPointConst.WARCHESS_CHINESE .. "_"
		elseif slot1 == ActivityTemplateConst.PUZZLE_NEW then
			return RedPointConst.PUZZLE_NEW .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_2_1_LINKGAME then
			return RedPointConst.ACTIVITY_2_1_LINKGAME .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_2_2_WATER then
			return RedPointConst.ACTIVITY_WATER .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_FLIP_CARD then
			return RedPointConst.ACTIVITY_2_2_FLIP_CARD .. "_"
		elseif slot1 == ActivityTemplateConst.SAIL_GAME then
			return RedPointConst.SAIL_GAME .. "_"
		elseif slot1 == ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN then
			return RedPointConst.SEVEN_DAY_SIGN_SKIN .. "_"
		elseif slot1 == ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_LUWU then
			return RedPointConst.SEVEN_DAY_SIGN_SKIN .. "_"
		elseif slot1 == ActivityTemplateConst.SEVEN_DAY_SIGN_SKIN_WORLD_LINE then
			return RedPointConst.SEVEN_DAY_SIGN_SKIN .. "_"
		elseif slot1 == ActivityTemplateConst.STRONGHOLD then
			return RedPointConst.STRONGHOLD .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_SKIN_DRAW then
			return RedPointConst.ACTIVITY_DRAW .. "_"
		elseif slot1 == ActivityTemplateConst.TANGRAM_PUZZLE then
			return RedPointConst.TANGRAM_PUZZLE .. "_"
		elseif slot1 == ActivityTemplateConst.MOON_CAKE then
			return RedPointConst.MOON_CAKE .. "_"
		elseif slot1 == ActivityTemplateConst.JAPAN_SOLO_HEART_DEMON then
			return RedPointConst.SOLO_HEART_DEMON_ACTIVITY .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_INVITE then
			return RedPointConst.INVITE_MAIN .. "_"
		elseif slot1 == ActivityTemplateConst.DESTROY_BOX_GAME then
			return RedPointConst.DESTROY_BOX_GAME .. "_"
		elseif slot1 == ActivityTemplateConst.HERO_CLUE then
			return RedPointConst.HERO_CLUE .. "_"
		elseif slot1 == ActivityTemplateConst.NEW_WARCHESS then
			return RedPointConst.NEW_WARCHESS .. "_"
		elseif slot1 == ActivityTemplateConst.KAGUTSUCHI_ACTIVITY_PT_SCROLL then
			return RedPointConst.ACTIVITY_PT_SCROLL .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA then
			return RedPointConst.ACTIVITY_ATTRIBUTE_ARENA .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUSH_SNOW_BALL then
			return RedPointConst.ACTIVITY_PUSH_SNOW_BALL .. "_"
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_COMBINE_GAME then
			return RedPointConst.ACTIVITY_SPRING_COMBINE_GAME .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUSH_SNOW_BALL_SOLO then
			return RedPointConst.ACTIVITY_PUSH_SNOW_BALL_SOLO .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUSH_SNOW_BALL_TEAM then
			return RedPointConst.ACTIVITY_PUSH_SNOW_BALL_TEAM .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_INDIA_NIAN then
			return RedPointConst.ACTIVITY_INDIA_NIAN .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_MEMORY then
			return RedPointConst.ACTIVITY_MEMORY .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_QUIZ then
			return RedPointConst.ACTIVITY_QUIZ .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_PUSH_BOX then
			return RedPointConst.ACTIVITY_PUSH_BOX .. "_"
		elseif slot1 == ActivityTemplateConst.HERO_LETTER then
			return RedPointConst.ACTIVITY_HERO_LETTER .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_ACCUMULATIVE then
			return RedPointConst.ACTIVITY_ACCUMULATIVE .. "_"
		elseif slot1 == ActivityTemplateConst.ACTIVITY_REFORGE then
			return RedPointConst.ACTIVITY_REFORGE
		else
			return RedPointConst.ACTIVITY_COMMON .. "_"
		end
	end,
	GetMainActivityId = function (slot0)
		for slot5, slot6 in pairs(ActivityData:GetAllActivityData()) do
			if slot6.subActivityIdList then
				for slot10, slot11 in ipairs(slot6.subActivityIdList) do
					if slot11 == slot0 then
						return slot6.id
					end
				end
			end
		end
	end,
	ActivityOpenCheck = function (slot0)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot1.startTime)))

			return false
		end

		if slot1.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")

			return false
		end

		return true
	end,
	ActivityOpenCheckByMessageBox = function (slot0, slot1, slot2)
		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0).startTime then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot3.start_time)),
				OkCallback = slot1
			})

			return false
		end

		if slot3.stopTime <= manager.time:GetServerTime() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				title = GetTips("PROMPT"),
				content = GetTips("TIME_OVER"),
				OkCallback = slot1
			})

			return false
		end

		if slot2 then
			slot2()
		end

		return true
	end,
	GetActivityLostTimeStrWith2Unit = function (slot0)
		slot1, slot2 = ActivityData:GetActivityTime(slot0)

		return manager.time:GetLostTimeStrWith2Unit(slot2)
	end,
	GetUIName = function (slot0)
		if ActivityConst.HELLA_TOWER_DEFENCE == uv0.GetOriginActivityID(slot0) then
			return "UI/VersionUI/HellaUI/HellabatteryUI"
		elseif ActivityConst.HELLA_CHESS == slot0 then
			return "UI/VersionUI/HellaUI/HellaWarChessUI"
		else
			error("未绑定对应预制体" .. slot0)
		end
	end,
	GetGameHelpKey = function (slot0)
		if ActivityConst.HELLA_TOWER_DEFENCE == uv0.GetOriginActivityID(slot0) then
			return "ACTIVITY_HELLA_TOWER_DESCRIPE"
		elseif ActivityConst.SIKADI_GAME == slot0 then
			return "ACTIVITY_CROSSWAVE_DESCRIPE"
		elseif ActivityConst.LEVIATHAN_GAME == slot0 then
			return "ACTIVITY_BUBBLES_DESCRIPE"
		end

		return ""
	end,
	GetSectionType = function (slot0)
		if ActivityConst.HELLA_TOWER_DEFENCE == uv0.GetOriginActivityID(slot0) then
			return BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE
		else
			error("未绑定战斗类型" .. slot0)
		end
	end,
	GetStoryActivityIDList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.STORY_STAGE]) do
			if ActivityCfg[slot6].activity_theme == slot0 then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	IsUnlockActivity = function (slot0)
		if type(ActivityCfg[slot0].unlock_condition) ~= "table" then
			return true
		end

		if slot1[1] == 100 then
			if StoryStageActivityData:GetStageData(slot1[2][1])[slot1[2][2]] == nil or slot4[slot3].clear_times <= 0 then
				return false
			else
				return true
			end
		elseif slot1[1] == 101 then
			return ChapterTools.IsClearChapter(slot1[2][1])
		elseif slot1[1] == 102 then
			return ChapterTools.IsClearStage(slot1[2][2])
		end

		return true
	end,
	GetActivityChessProgress = function (slot0)
		for slot6, slot7 in pairs(WarchessLevelCfg.get_id_list_by_tag[slot0]) do
			slot2 = 0 + ChessTools.GetChapterProgress(slot7)
			slot1 = 0 + 1
		end

		return slot2, slot1
	end,
	GetActivityIsOpenWithTip = function (slot0, slot1)
		if slot1 == nil then
			slot1 = true
		end

		if ActivityData:GetActivityIsOpen(slot0) then
			return true
		elseif slot1 then
			if ActivityData:GetActivityData(slot0) and manager.time:GetServerTime() < slot2.startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot2.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return false
		else
			return false
		end
	end,
	GetActivityStatus = function (slot0)
		if ActivityData:GetActivityIsOpen(slot0) then
			return 1
		elseif ActivityData:GetActivityData(slot0) and manager.time:GetServerTime() < slot1.startTime then
			return 0
		else
			return 2
		end
	end,
	GetTogglePanelView = function (slot0)
		for slot5, slot6 in ipairs(ActivityToggleCfg.get_id_list_by_activity_theme[uv0.GetActivityTheme(slot0)]) do
			if ActivityToggleCfg[slot6].activity_id == slot0 then
				if ActivityToggleCfg[slot6].class_name == nil then
					-- Nothing
				end

				return ActivityToggleCfg[slot6].class_name
			end
		end
	end,
	JumpBackToActivityMainViewByActivityID = function (slot0)
		slot3, slot4 = uv0.GetActivityMainRouteByTheme(ActivityCfg[slot0].activity_theme, slot0)

		JumpTools.OpenPageUntilLoaded(slot3, slot4)
	end,
	JumpBackToActivityMainViewByTheme = function (slot0)
		slot1, slot2 = uv0.GetActivityMainRouteByTheme(slot0)

		JumpTools.OpenPageUntilLoaded(slot1, slot2)
	end,
	GetActivityMainRouteByTheme = function (slot0, slot1)
		slot4 = ActivityEntraceCfg[ActivityEntraceCfg.get_id_list_by_theme[slot0][1]].jump_system[2]

		return SystemLinkCfg[slot3[1]].link, {
			activityID = slot4,
			subActivityID = slot1 or ActivityVersionData:GetSelectActivityID(slot4)
		}
	end,
	GetReprintActivityTheme = function (slot0)
		return uv0.GetReprintActivityID(slot0)
	end,
	GetReprintActivityID = function (slot0)
		if ActivityVersionData:GetReprintField() == "" then
			return slot0
		end

		if ActivityReprintCfg[slot0] and slot2[slot1] then
			return slot2[slot1]
		else
			return slot0
		end
	end,
	GetOriginActivityTheme = function (slot0)
		return ActivityReprintExCfg[slot0] and ActivityReprintExCfg[slot0].originActivityID or slot0
	end,
	GetOriginActivityID = function (slot0)
		return ActivityReprintExCfg[slot0] and ActivityReprintExCfg[slot0].originActivityID or slot0
	end,
	GetParentActivityID = function (slot0)
		for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_theme[ActivityCfg[slot0].activity_theme]) do
			if table.keyof(ActivityCfg[slot6].sub_activity_list, slot0) then
				return slot6
			end
		end
	end,
	GetAllSubActivityByTemplate = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot8].activity_template == slot1 then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end,
	GetAllTaskSubActivityID = function (slot0)
		return uv0.GetAllSubActivityByTemplate(slot0, ActivityTemplateConst.TASK)
	end,
	CreateActivityTimer = function (slot0, slot1, slot2, slot3)
		if uv0[slot0] then
			uv0[slot0]:Stop()

			uv0[slot0] = nil
		end

		uv0[slot0] = Timer.New(function ()
			uv0()
		end, slot2 or 1, slot3 or -1)

		uv0[slot0]:Start()
	end,
	ClearActivityTimer = function (slot0)
		if uv0[slot0] then
			uv0[slot0]:Stop()

			uv0[slot0] = nil
		end
	end,
	ClearAllActivityTimer = function ()
		for slot3, slot4 in pairs(uv0) do
			slot4:Stop()
		end

		uv0 = {}
	end,
	GetActivityIsRootOrSub = function (slot0)
		if not slot0 then
			return false
		end

		if not ActivityTools.activityRootMap then
			ActivityTools.activityRootMap = {
				root = {},
				subRoot = {}
			}

			for slot4, slot5 in ipairs(ActivityEntraceCfg.all) do
				if ActivityCfg[slot5] then
					if slot6.activity_template == ActivityTemplateConst.MAIN_ACTIVITY then
						slot10 = {
							[ActivityToggleCfg[slot15].activity_id] = true
						}

						for slot14, slot15 in ipairs(ActivityToggleCfg.get_id_list_by_activity_theme[slot6.activity_theme] or {}) do
							-- Nothing
						end

						ActivityTools.activityRootMap.root[slot5] = true

						for slot15, slot16 in ipairs(slot6.sub_activity_list or {}) do
							if slot10[slot16] then
								ActivityTools.activityRootMap.subRoot[slot16] = slot5
							end
						end
					end
				end
			end
		end

		if ActivityTools.activityRootMap.root[slot0] then
			return true
		end

		return ActivityTools.activityRootMap.subRoot[slot0] or false
	end,
	CheckMainActivityIsCommon = function (slot0)
		if not ActivityTools.activityCommonMain then
			ActivityTools.activityCommonMain = {}
		end

		if ActivityTools.activityCommonMain[slot0] ~= nil then
			return ActivityTools.activityCommonMain[slot0]
		end

		if ActivityTools.GetActivityIsRootOrSub(slot0) == true then
			if not ActivityEntraceCfg[slot0] or not slot2.jump_system or not slot2.jump_system[1] then
				ActivityTools.activityCommonMain[slot0] = false

				return false
			end

			if not SystemLinkCfg[slot2.jump_system[1]] or not slot4.link then
				ActivityTools.activityCommonMain[slot0] = false

				return false
			end

			slot6, slot7, slot8 = gameContext:ParseUrl(slot4.link)

			if not slot7 or not slot7[1] then
				return false
			end

			if not gameContext:GetRouteCfgFromRouteName(slot7[1]) or not slot9.component then
				return false
			end

			if slot9.component.IsCommonMainActivityPage then
				ActivityTools.activityCommonMain[slot0] = true

				return true
			end
		end

		ActivityTools.activityCommonMain[slot0] = false

		return false
	end
}
