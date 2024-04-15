slot1 = import("game.const.BattleConst")
slot2 = import("game.tools.BattleInstance")
slot3 = import("game.const.ViewConst")
slot4 = {}

return {
	GetName = function (slot0)
		if SystemLinkCfg[slot0[1]].id == uv0.JUMP_SPECIAL_ID.BATTLE_MAIN then
			return uv1.GetMapName(slot0[3]), slot1.text_display_1
		elseif slot1.id == uv0.JUMP_SPECIAL_ID.BATTLE_ASTROLABE or slot1.id == uv0.JUMP_SPECIAL_ID.BATTLE_EQUIP then
			return ChapterCfg[slot0[2]].subhead, slot1.text_display_1
		else
			return slot1.text_display_2, slot1.text_display_1
		end
	end,
	OpenPageUntilLoaded = function (slot0, slot1, slot2)
		if LuaExchangeHelper.GetSceneIsHanding() then
			gameContext:SetUrlAndParams(slot0, slot1)
		else
			CheckManagers()
			uv0.OpenPageByJump(slot0, slot1, slot2)
		end
	end,
	OpenPageUntilLoadedByTable = function (slot0, slot1)
		slot2, slot3 = uv0.GetLinkAndParams(slot0)

		uv0.OpenPageUntilLoaded(slot2, slot3, slot1)
	end,
	IS_OPENING_PAGE = false,
	JumpToPage = function (slot0)
		uv0.JumpToPage2(slot0)
	end,
	JumpToPage2 = function (slot0)
		slot1 = SystemLinkCfg[slot0[1]]

		if uv0.GetSystemActivityID(slot0) and slot2 ~= 0 then
			slot3, slot4, slot5 = uv0.GetActivityTime(slot2)

			if manager.time:GetServerTime() < slot3 then
				ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(slot3)))

				return
			end

			if slot4 <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")

				return
			end

			if ActivityEntraceCfg[slot2] and slot6.story_id ~= 0 and not manager.story:IsStoryPlayed(slot6.story_id) then
				manager.notify:Invoke(MUTE_MAIN_AUDIO)

				if JumpTools.GetLinkIsLocked(slot0) then
					slot7, slot8 = JumpTools.GetSystemLockedText(slot0)

					ShowTips(slot8)

					return
				end

				manager.story:StartStoryById(slot6.story_id, function ()
					PlayerData:StoryModify(uv0.story_id)
					uv1.JumpToPage2(uv2)
				end)

				return
			end

			if slot0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(slot2) then
				if ActivityCfg[slot2].unlock_condition[1] == 100 then
					ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot8[2][1]].name, BattleActivityStoryStageCfg[slot8[2][2]].name))

					return
				elseif slot8[1] == 101 then
					slot10 = ChapterClientCfg[ChapterCfg[slot8[2][1]].clientID]

					if slot8[2][1] == 12113 then
						ShowTips(string.format(GetTips("NEED_FINISH_PRE_CHAPTER_STAGE"), GetTips(uv1.HARD_LANGUAGE[slot9.difficulty]), GetI18NText(slot10.desc), GetI18NText(slot10.name)))
					else
						ShowTips(string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(uv1.HARD_LANGUAGE[slot9.difficulty]), GetI18NText(slot10.desc)))
					end

					return
				end
			end

			if not slot5 then
				ShowTips("ERROR_ACTIVITY_NOT_EXIST")

				return
			end

			if slot0[1] == uv2.JUMP_SPECIAL_ID.BATTLE_MAIN and PlayerData:GetPlayerInfo().userLevel < GameSetting.activity_main_plot_unlock_level.value[1] then
				ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.activity_main_plot_unlock_level.value[1]))

				return
			end
		end

		if slot0[1] == uv2.JUMP_SPECIAL_ID.BATTLE_MAIN then
			slot3, slot4 = nil
			slot5 = ChapterCfg[slot0[2]].section_id_list

			if slot0[3] == nil then
				slot0[3] = slot5[#slot5]
			end

			slot3, slot4 = getMaxOpenSection(slot0[3])

			if ChapterCfg[slot0[2]].unlock_activity_id ~= 0 and manager.time:GetServerTime() < ActivityData:GetActivityData(slot6).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot7.startTime)))

				return
			end

			if slot0[2] == 11112 then
				if ChapterTools.IsClearChapter(10112) == false then
					uv0.JumpToPage2({
						slot0[1],
						10112
					})

					return
				end

				if not SkuldTravelData:IsCollectAllPhoto() then
					ShowTips(GetTips("TRAVEL_SKULD_COLLECT_ALL_PHOTO"))

					return
				end
			elseif slot0[2] == 12112 and BattleStageData:GetStageData()[slot5[1]] == nil then
				uv0.JumpToPage2({
					slot0[1],
					11112
				})

				return
			end

			uv0.OpenPageByJump(uv0.GetLinkAndParams({
				slot0[1],
				slot4,
				slot3
			}))

			return
		elseif slot0[1] == uv2.SYSTEM_ID.BUY_FATIGUE and slot0[2] == 2 then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			if GameSetting.fatigue_max_buy_time.value[1] <= CurrencyData:GetFatigueBuyTimes() then
				ShowTips("ERROR_ITEM_DIAMOND_FATIGUE_TIMES_OVER_LIMIT")

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.MATRIX then
			uv0.GoToMatrix()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.CLUB_TASK then
			uv0.GoToGuildTask()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.BOSS_CHALLENGE then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			BattleBossChallengeAction.EnterBossChallenge()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.STRATEGY_MATRIX then
			StrategyMatrixAction.GotoStrategyMatrix(slot1.params[1])

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.THOR_MATRIX then
			StrategyMatrixAction.GotoStrategyMatrix(slot1.params[1])

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.POLYHEDRON then
			uv0.GoToPolyhedron()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.BATTLE_EQUIP_BREAK_THROUGH_MATERIAL then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.MYTHIC then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			else
				if MythicData:GetDifficulty() == MythicData:GetFinalId() then
					JumpTools.GoToSystem("/mythicUltimateView", nil, uv2.SYSTEM_ID.MYTHIC)
				else
					JumpTools.GoToSystem("/mythic", nil, uv2.SYSTEM_ID.MYTHIC)
				end

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.CANTEEN_MAP then
			if JumpTools.IsSystemLocked(uv2.SYSTEM_ID.DORM) then
				ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.DORM, slot3))

				return nil
			else
				BackHomeTools:GotoBackHomeRoom(DormConst.CANTEEN_ID)

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.DORM_MAP then
			if JumpTools.IsSystemLocked(uv2.SYSTEM_ID.DORM) then
				ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.DORM, slot3))

				return nil
			else
				BackHomeTools:GotoBackHomeRoom(DormConst.PUBLIC_DORM_ID)

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.BACKHOME_MAP then
			if JumpTools.IsSystemLocked(uv2.SYSTEM_ID.DORM) then
				ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.DORM, slot3))

				return nil
			else
				JumpTools.OpenPageByJump("/dormChooseRoomView")

				return
			end
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.HERO_TEACH then
			if slot0[2] ~= nil then
				if HeroData:GetHeroData(slot3).unlock ~= 1 then
					ShowTips("ERROR_HERO_NOT_UNLOCK")

					return
				end

				if HeroCfg[slot3] and slot5.study_stage and slot5.study_stage[1] then
					JumpTools.OpenPageByJump("/teachStage", {
						switchType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
						heroID = slot3
					})
					JumpTools.OpenPageByJump("teachSectionInfo", {
						sectionType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
						section = slot5.study_stage[1]
					})
				end
			else
				JumpTools.OpenPageByJump("/teachStage", {
					switchType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
				})
			end

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.CLUB_FOUNDED then
			GuildAction.EnterGuild()

			return
		elseif slot1.system_id == uv2.SYSTEM_ID.BATTLE_SUB_PLOT then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			uv0.GotoSubPlot(slot0)

			return
		elseif slot0[1] == uv2.SYSTEM_ID.SKIN_DRAW then
			slot3, slot4 = ActivitySkinDrawData:GetNotReadStoryID()

			if slot3 and ActivityData:GetActivityData(slot3):IsActivitying() then
				if not JumpTools.IsSystemLocked(uv2.SYSTEM_ID.SKIN_DRAW) then
					if slot4 and slot4.isRead == 0 then
						manager.story:StartStoryById(ActivityLimitedSkinStoryCfg[slot4.activityID].story_id, function ()
							manager.loadScene:ForceSetShouldLoadSceneName("home", function ()
								ActivitySkinDrawAction.FinishStory(uv0.activityID)
								JumpTools.GoToSystem("/activityskinDraw", {
									activityID = uv1
								}, uv2.SYSTEM_ID.SKIN_DRAW)
							end)
						end)
					else
						JumpTools.GoToSystem("/activityskinDraw", {
							activityID = slot3
						}, uv2.SYSTEM_ID.SKIN_DRAW)
					end
				else
					ShowTips(JumpTools.GetSystemLockedTip(uv2.SYSTEM_ID.SKIN_DRAW, JumpTools.IsSystemLocked(uv2.SYSTEM_ID.SKIN_DRAW)))
				end
			else
				ShowTips("SOLO_NOT_OPEN")
			end

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.MOON_CAKE then
			if tostring(slot0[2]) == USER_ID then
				JumpTools.OpenPageByJump("/moonCakeParty", {
					activityID = slot4,
					mainActivityID = MoonCakeTools.GetMainActivityID(SystemLinkCfg[slot0[1]].activity_id),
					partyOwnerUID = USER_ID
				})
			else
				MoonCakeAction.VisitParty(slot4, slot3, MoonCakeConst.VISIT_WAY.SHARE)
			end

			return
		elseif slot0[1] == uv2.SYSTEM_ID.SERVANT_SHOP then
			slot4 = SystemLinkCfg[slot0[1]].params[1]
			slot5 = ShopTools.GetGoodsIDListByItemID(slot4, slot0[2])
			slot6 = {}
			slot7 = {}

			for slot12, slot13 in pairs(ShopTools.FilterShopDataList(slot4)) do
				if slot13.id == slot5[1] then
					slot7 = slot13
				end
			end

			if getShopCfg(slot5[1]) then
				slot6 = getShopCfg(slot5[1])
			end

			if JumpTools.GetLinkIsLocked(slot0) then
				slot9, slot10 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot10)
			else
				JumpTools.GoToSystem("/shop", {
					shopId = slot4
				}, uv2.SYSTEM_ID.SHOP)

				if ItemCfg[getShopCfg(slot7.id, slot4).give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
					if ShopTools.HaveSkin(slot9.give_id) then
						return
					end
				elseif slot9.limit_num then
					if slot9.limit_num ~= -1 and slot9.limit_num <= slot7.buyTime then
						return
					end

					slot11, slot12 = ShopTools.JudgeIsLvLimit(slot9.level_limit)

					if slot11 then
						return
					end
				end

				JumpTools.OpenPopUp("shopBuy", {
					goodInfo = slot7
				})
			end

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.WEAPON_SERVANT_MERGE then
			slot3 = slot0[2]
			slot5 = {
				guideForce = true,
				openTab = "callName",
				race = WeaponServantCfg[slot3].race,
				servantID = slot3
			}

			manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, slot5)
			JumpTools.OpenPageByJump("/weaponServant", slot5)

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_BARBECUE then
			SPHeroChallengeAction:OnEnterBarbuceScene()

			return
		elseif slot0[1] == uv2.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_MAIN_VIEW or slot0[1] == uv2.JUMP_SPECIAL_ID.SP_HERO_CHALLENGE_MAIN_VIEW_RESOURCE then
			if SystemLinkCfg[slot0[1]] then
				SPHeroChallengeTools:EnterSystem(SystemLinkCfg[slot0[1]].activity_id)
			end

			return
		elseif uv2.SYSTEM_ID.HERO <= slot1.system_id and slot1.system_id <= uv2.SYSTEM_ID.TRANSITION then
			if uv0.GetLinkIsLocked(slot0) then
				slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

				ShowTips(slot4)

				return
			end

			slot3, slot4, slot5 = uv0.GetLinkAndParams(slot0)
			slot4.isEnter = true

			uv0.OpenPageByJump(slot3, slot4, slot5)

			return
		elseif uv0.GetLinkIsLocked(slot0) then
			slot3, slot4 = JumpTools.GetSystemLockedText(slot0)

			ShowTips(slot4)

			return
		end

		uv0.OpenPageByJump(uv0.GetLinkAndParams(slot0))
	end,
	GoToMatrix = function ()
		if MatrixData:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS or slot0 == MatrixConst.STATE_TYPE.FAIL then
			OpenPageUntilLoaded("/matrixBlank/matrixOver")
		else
			JumpTools.GoToSystem("/matrixBlank/matrixPrepare", nil, uv0.SYSTEM_ID.MATRIX)
		end
	end,
	GoToPolyhedron = function ()
		if not PolyhedronData:GetPolyhedronInfo() then
			ShowTips("TIME_OVER")

			return
		end

		if not ActivityData:GetActivityIsOpen(PolyhedronData:GetActivityID()) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.GoToSystem("/polyhedronBlank/polyhedronLobby", nil, uv0.SYSTEM_ID.MATRIX)
	end,
	GoToGuildTask = function ()
		if JumpTools.IsSystemOperationStoped(uv0.SYSTEM_ID.GUILD) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		if JumpTools.IsSystemLocked(uv0.SYSTEM_ID.GUILD) then
			ShowTips(JumpTools.GetSystemLockedTip(uv0.SYSTEM_ID.GUILD, slot0))

			return
		end

		if GuildData:GetGuildInfo().id == nil then
			GuildAction.EnterGuild()
		else
			JumpTools.OpenPageByJump("/communityTask")
		end
	end,
	Jump2SubPlot = function (slot0, slot1, slot2)
		if not table.keyof(ChapterClientCfg[slot0].chapter_list, BattleFieldData:GetCacheChapter(slot0)) then
			slot4 = slot3.chapter_list[1]

			BattleFieldData:SetCacheChapterClient(slot3.toggle, slot0)
			BattleFieldData:SetCacheChapter(slot0, slot4)
			BattleStageAction.ClickSubPlot(slot4)
		end

		if LuaExchangeHelper.GetSceneIsHanding() then
			gameContext:SetUrlAndParams(ChapterTools.GetSubPlotUrl(slot4, slot2), {
				chapterClientID = slot0
			})
		else
			CheckManagers()
			JumpTools.OpenPageByJump(slot5, slot6, nil, slot1)
		end
	end,
	Jump2SubPlotByChapterID = function (slot0, slot1)
		if not ChapterTools.IsUnlockChapter(slot0) then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityRefreshTime(ChapterCfg[slot0].activity_id))))

			return
		end

		if table.keyof(getChapterClientCfgByChapterID(slot0).chapter_list, slot0) > 1 and not ChapterTools.IsClearChapter(slot2.chapter_list[slot3 - 1]) then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", ChapterCfg[slot4].subhead))

			return
		end

		BattleStageAction.ClickSubPlot(slot0)

		if slot1 then
			JumpTools.OpenPageByJump(ChapterTools.GetSubPlotUrl(slot0, isEntrace), {
				chapterClientID = slot2.id,
				chapterID = slot0
			})
		else
			manager.notify:Invoke(CHANGE_CHAPTER, slot0)
		end
	end,
	GotoSubPlot = function (slot0)
		slot1 = SystemLinkCfg[slot0[1]]
		slot2 = slot0[2]
		slot3 = slot0[3]
		slot5, slot6 = ChapterTools.GetSubPlotUrl(slot2, false)
		slot7 = {
			chapterClientID = ChapterCfg[slot2].clientID
		}

		if slot3 and BattleStageData:GetStageData()[slot3] and not slot6 and not StageTools.IsLockSubChapterStage(slot2, slot3) then
			slot5 = slot5 .. "/subPlotSectionInfo"
			slot7 = {
				chapterClientID = slot4,
				section = slot3,
				chapterID = slot2,
				sectionType = uv0.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
			}

			if slot2 then
				BattleFieldData:SetCacheStage(slot2, slot3)
				BattleFieldData:SetCacheChapter(slot4, slot2)
				BattleStageAction.ClickSubPlot(slot2)
			end
		else
			slot9, slot10 = ChapterTools.GetSubPlotMaxStageID(slot2)

			BattleFieldData:SetCacheStage(slot9, slot10)
			BattleFieldData:SetCacheChapter(slot4, slot9)
			BattleStageAction.ClickSubPlot(slot9)
		end

		CheckManagers()
		gameContext:Go(slot5, slot7)
	end,
	GetActivityTime = function (slot0)
		slot1 = ActivityData:GetActivityData(slot0)

		return slot1.startTime, slot1.stopTime, slot1:GetStateBool()
	end,
	GetLinkAndParams = function (slot0)
		slot2 = {}

		if SystemLinkCfg[slot0[1]].paramName and type(slot1.paramName) == "table" then
			slot3 = 0
			slot4 = #slot1.paramName

			if slot1.params and type(slot1.params) == "table" then
				slot3 = #slot1.params
			end

			slot5 = 2

			for slot9 = 1, slot4 do
				if slot9 <= slot3 then
					slot2[slot1.paramName[slot9]] = slot1.params[slot9]
				else
					slot2[slot1.paramName[slot9]] = slot0[slot5]
					slot5 = slot5 + 1
				end
			end
		end

		for slot6, slot7 in pairs(slot0) do
			if type(slot6) == "string" then
				slot2[slot6] = slot7
			end
		end

		if slot0[1] == uv0.JUMP_SPECIAL_ID.BATTLE_MAIN then
			slot2.sectionType = uv1.STAGE_TYPE_NEW.STAGE_TYPE_PLOT
		end

		return slot1.link, slot2, slot1.system_id
	end,
	GetLinkIsLocked = function (slot0)
		if uv0.IsSystemLocked(SystemLinkCfg[slot0[1]].system_id) then
			return true
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_MAIN and not BattleStageData:GetStageData()[slot0[2]] then
			return true
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_DAILY then
			return PlayerData:GetPlayerInfo().userLevel < BattleDailyStageCfg[ChapterCfg[slot0[2]].section_id_list[1]].level
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_ASTROLABE and not BattleStageData:IsOpenChapter(slot0[2]) then
			return true
		end

		if slot1.id == uv1.JUMP_SPECIAL_ID.BATTLE_EQUIP and not BattleStageData:IsOpenChapter(slot0[2]) then
			return true
		end

		if uv0.GetSystemActivityID(slot0) and slot3 ~= 0 then
			slot4, slot5, slot6 = uv0.GetActivityTime(slot3)

			if manager.time:GetServerTime() < slot4 then
				return true
			end

			if slot5 <= manager.time:GetServerTime() then
				return true
			end

			if slot0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(slot3) then
				return true
			end

			if not slot6 then
				return true
			end
		end

		if slot1.system_id == uv1.SYSTEM_ID.BATTLE_SUB_PLOT and not ChapterTools.IsUnlockSubPlotClient(slot0[2]) then
			return true
		end

		return false
	end,
	GetSystemLockedText = function (slot0)
		if SystemCfg[SystemLinkCfg[slot0[1]].system_id] and slot2.open_condition then
			for slot6, slot7 in ipairs(slot2.open_condition) do
				if slot7[1] == uv0.SYSTEM_LOCK_TYPE.LOCK then
					return true, GetTips("SYSTEM_LOCK")
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.LEVEL then
					if PlayerData:GetPlayerInfo().userLevel < slot7[2] then
						return true, string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot7[2])
					end
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.BATTLE then
					if BattleStageData:GetStageData()[slot7[2]] and slot10.clear_times > 0 then
						return false, ""
					elseif BattleChapterStageCfg[slot9] == nil then
						return true, "未知的关卡ID" .. slot9
					else
						slot14, slot15 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot9).toggle, slot9)

						return true, string.format(GetTips("MISSION_PROGRESS_UNLOCK"), GetI18NText(getChapterDifficulty(slot9)), GetI18NText(slot14), GetI18NText(slot15))
					end
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
					if ArchiveData:GetArchive(slot7[2]).lv < slot7[3] then
						return true, string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), HeroRecordCfg[slot7[2]].name, slot7[3])
					end
				elseif slot7[1] == uv0.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
					return true, string.format(GetTips("ANY_FAVORABILITY_UNLOCK"), slot7[2])
				else
					print("未实现的系统解锁判断方式:", slot7[1])
				end
			end
		end

		if uv1.GetSystemActivityID(slot0) and slot3 ~= 0 then
			slot4, slot5, slot6 = uv1.GetActivityTime(slot3)

			if manager.time:GetServerTime() < slot4 then
				return true, string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot4))
			end

			if slot5 <= manager.time:GetServerTime() then
				return true, GetTips("TIME_OVER")
			end

			if slot0[1] ~= 11001 and not ActivityTools.IsUnlockActivity(slot3) then
				if ActivityCfg[slot3].unlock_condition[1] == 100 then
					return true, string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[slot8[2][1]].name, BattleActivityStoryStageCfg[slot8[2][2]].name)
				elseif slot8[1] == 101 then
					slot9 = ChapterCfg[slot8[2][1]]

					return true, string.format(GetTips("NEED_FINISH_PRE_STAGE"), GetTips(uv2.HARD_LANGUAGE[slot9.difficulty]), GetI18NText(ChapterClientCfg[slot9.clientID].desc))
				elseif slot8[1] == 102 then
					return ChapterTools.IsClearStage(slot8[2][2]), string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[slot8[2][1]].subhead, BattleActivityStoryStageCfg[slot8[2][2]].name)
				end
			end

			if not slot6 then
				return true, GetTips("TIME_OVER")
			end
		end

		if SystemLinkCfg[slot1].system_id == uv0.SYSTEM_ID.BATTLE_SUB_PLOT then
			slot4, slot5 = ChapterTools.IsUnlockSubPlotClient(slot0[2])

			if not slot4 then
				return true, slot5
			end
		end

		if slot2 and not SystemData:GetSystemIsOpen(SystemLinkCfg[slot1].system_id) then
			return true, GetTips("SYSTEM_LOCK")
		end

		if uv1.CustomLock(slot1) then
			return true, GetTips(slot4[1])
		end

		return false, ""
	end,
	GetSystemActivityID = function (slot0)
		if uv0.GetSystemParamActivityID(slot0, "subActivityID") and slot1 ~= 0 then
			return slot1
		end

		if uv0.GetSystemParamActivityID(slot0, "activityId") and slot1 ~= 0 then
			return slot1
		end

		if uv0.GetSystemParamActivityID(slot0, "activityID") and slot1 ~= 0 then
			return slot1
		end
	end,
	GetSystemParamActivityID = function (slot0, slot1)
		slot3 = SystemLinkCfg[slot0[1]]
		slot4 = slot3.activity_id

		if type(slot3.paramName) == "table" and table.keyof(slot3.paramName, slot1) then
			slot4 = (type(slot3.params) ~= "table" or not slot3.params[slot5] or slot3.params[slot5]) and slot0[slot5 + 1]
		end

		return slot4
	end,
	IsSystemOperationStoped = function (slot0)
		if slot0 == nil then
			return false
		end

		if not SystemCfg[slot0] then
			return false
		end

		if slot1.operation_stop_id ~= 0 then
			if OperationData:IsFunctionStoped(slot1.operation_stop_id) then
				return true
			end

			return false
		end
	end,
	IsSystemLocked = function (slot0)
		if SystemCfg[slot0] and slot1.open_condition then
			for slot5, slot6 in ipairs(slot1.open_condition) do
				if uv0.IsConditionLocked(slot6) then
					return slot7
				end
			end
		end

		if slot1 and slot1.system_hide == 1 then
			return {
				"server_lock"
			}
		end

		if slot1 and not SystemData:GetSystemIsOpen(slot0) then
			return {
				"server_lock"
			}
		end

		return uv0.CustomLock(slot0)
	end,
	IsConditionLocked = function (slot0)
		if slot0[1] == uv0.SYSTEM_LOCK_TYPE.LOCK then
			return slot0
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.LEVEL then
			if PlayerData:GetPlayerInfo().userLevel < slot0[2] then
				return slot0
			end
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.BATTLE then
			if BattleStageData:GetStageData()[slot0[2]] and slot2.clear_times > 0 then
				return false
			else
				return slot0
			end
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
			if ArchiveData:GetArchive(slot0[2]).lv < slot0[3] then
				return slot0
			end
		elseif slot0[1] == uv0.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
			slot3 = false

			for slot7, slot8 in pairs(HeroData:GetHeroList()) do
				if HeroTools.GetHeroIsUnlock(slot7) and slot0[2] <= ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot7][1]).lv then
					slot3 = true

					break
				end
			end

			if not slot3 then
				return slot0
			end
		else
			print("未实现的系统解锁判断方式:", slot0[1])
		end
	end,
	SetSystemOpenCheck = function (slot0, slot1)
		uv0[slot0] = slot1
	end,
	GoToSystem = function (slot0, slot1, slot2, slot3)
		if uv0.IS_OPENING_PAGE then
			return
		end

		if ShopTools.IsPC() and slot1 and slot1.shopId and ShopConst.PC_LOCK_SHOP[slot1.shopID] then
			ShowTips("PC_SHOP_TIPS1")

			return
		end

		if ShopTools.IsPC() and slot1 and slot1.childShopIndex and ShopConst.PC_LOCK_RECHARGE[slot1.childShopIndex .. "_" .. slot1.page] then
			ShowTips("PC_SHOP_TIPS1")

			return
		end

		if uv0.IsSystemOperationStoped(slot2) then
			ShowTips("ERROR_FUNCTION_STOP")

			return nil
		end

		slot4 = uv0.IsSystemLocked(slot2)

		if slot2 and slot4 then
			ShowTips(uv0.GetSystemLockedTip(slot2, slot4))

			return nil
		end

		if uv1[slot2] then
			slot5, slot6 = uv1[slot2](slot1)

			if not slot5 then
				ShowTips(slot6)

				return nil
			end
		end

		gameContext:Go(slot0, slot1, slot3, true)
	end,
	GetSystemLockedTip = function (slot0, slot1)
		if slot0 and slot1 then
			if slot1[1] == uv0.SYSTEM_LOCK_TYPE.LEVEL then
				return string.format(GetTips("PLAYER_LEVEL_UNLOCK"), slot1[2])
			elseif slot1[1] == uv0.SYSTEM_LOCK_TYPE.BATTLE then
				slot2 = slot1[2]
				slot5, slot6 = BattleStageTools.GetChapterSectionIndex(getChapterClientCfgByStageID(slot2).toggle, slot2)

				return string.format(GetTips("MISSION_PROGRESS_UNLOCK"), getChapterDifficulty(slot2), GetI18NText(slot5), GetI18NText(slot6))
			elseif slot1[1] == uv0.SYSTEM_LOCK_TYPE.HERO_FAVORABILITY then
				return string.format(GetTips("HERO_FAVORABILITY_UNLOCK"), GetI18NText(HeroRecordCfg[slot1[2]].name), slot1[3])
			elseif slot1[1] == uv0.SYSTEM_LOCK_TYPE.ANY_HERO_FAVORABILITY then
				return string.format(GetTips("ANY_FAVORABILITY_UNLOCK"), slot1[2])
			elseif slot1[1] == "TIME_OVER" then
				return GetTips("TIME_OVER")
			end
		end

		return GetTips("SYSTEM_LOCK")
	end,
	Back = function (slot0, slot1)
		gameContext:Back(slot0, slot1)
		GlobalCall.register("AfterGo", function ()
			uv0.RefreshGaussianBg()
		end)
		uv0.RefreshGaussianBg()
	end,
	OpenPageByJump = function (slot0, slot1, slot2, slot3)
		if uv0.IS_OPENING_PAGE then
			return
		end

		if ShopTools.IsPC() and slot1 and slot1.shopId and ShopConst.PC_LOCK_SHOP[slot1.shopID] then
			ShowTips("PC_SHOP_TIPS1")

			return
		end

		if ShopTools.IsPC() and slot1 and slot1.childShopIndex and ShopConst.PC_LOCK_RECHARGE[slot1.childShopIndex .. "_" .. slot1.page] then
			ShowTips("PC_SHOP_TIPS1")

			return
		end

		slot6 = nil
		slot6 = (not (string.char(string.byte(slot0)) == "/") or string.split(string.sub(slot0, 2, #slot0), "/")) and string.split(slot0, "/")

		GlobalCall.register("AfterGo", function ()
			uv0.RefreshGaussianBg()
		end)
		uv0.GoToSystem(slot0, slot1, slot2, slot3)
	end,
	OpenPopUp = function (slot0, slot1, slot2, slot3)
		GlobalCall.register("AfterGo", function ()
			uv0.RefreshGaussianBg()

			if uv1 then
				uv1()
			end
		end)
		uv0.GoToSystem(slot0, slot1, slot2)
	end,
	GetRealPageName = function (slot0)
		if string.char(string.byte(slot0)) == "/" then
			return string.sub(slot0, 2, #slot0)
		else
			return slot0
		end
	end,
	RefreshGaussianBg = function ()
		slot2 = false

		for slot6 = #gameContext:GetAllOpenRoute(), 1, -1 do
			if uv0.NEED_GAUSSIAN_POPUP[slot0[slot6]] then
				uv1.SetGaussionBg(slot7, true)

				slot2 = true
			else
				uv1.SetGaussionBg(url, false)
			end
		end

		manager.ui:SetUISeparateRender(slot2)
	end,
	SetGaussionBg = function (slot0, slot1)
		if gameContext:GetOpenPageHandler(slot0) then
			slot2:SetGaussionBg(slot1)
		end
	end,
	JudgeIsHaveGaussian = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if uv0.NEED_GAUSSIAN_POPUP[slot5] then
				return true
			end
		end

		return false
	end,
	IsActivityOpen = function (slot0)
		if uv0.GetSystemActivityID(slot0) and slot1 ~= 0 then
			slot2, slot3, slot4 = uv0.GetActivityTime(slot1)

			if manager.time:GetServerTime() < slot2 or slot3 <= manager.time:GetServerTime() then
				return false
			end
		end

		return true
	end,
	NeedHide = function (slot0, slot1)
		if SystemLinkCfg[slot0[1]].need_hide ~= 1 then
			return false
		end

		if uv0.IsActivityOpen(slot0) == false then
			return true
		end

		if slot2.system_id == uv1.SYSTEM_ID.SHOP_ENTER then
			slot3, slot4 = uv0.GetLinkAndParams(slot0)

			if slot4.shopId and ShopTools.IsGoodCanExchange(slot5, ShopTools.GetGoodsIDListByItemID(slot5, slot1)) == false then
				return true
			end
		end

		return false
	end,
	CustomLock = function (slot0)
		if slot0 == uv0.SYSTEM_ID.BATTLE_ABYSS then
			if AbyssData:GetRefreshTimestamp() <= manager.time:GetServerTime() + 1 then
				return {
					"TIME_OVER"
				}
			end
		elseif slot0 == uv0.SYSTEM_ID.MATRIX and ActivityData:GetActivityData(PolyhedronData:GetActivityID()).stopTime <= manager.time:GetServerTime() + 1 then
			return {
				"TIME_OVER"
			}
		end

		return false
	end
}
