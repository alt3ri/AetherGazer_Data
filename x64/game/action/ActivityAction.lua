manager.net:Bind(11001, function (slot0)
	ActivityData:InitActivityData(slot0)
	uv0.DealWithAllActivityData()
	ActivityRedPoint:OnActivityUpdate(slot0.activity_list or {})
end)
manager.net:Bind(11003, function (slot0)
	ActivityData:UpdateActivityData(slot0.activity)
	ActivityRedPoint:OnActivityUpdate({
		slot0.activity
	})
end)
manager.net:Bind(64031, function (slot0)
	ActivityData:RefreshActivityTime(slot0)
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	uv0.UpdateRedPoint(slot0)
end)

return {
	DealWithAllActivityData = function ()
		for slot4, slot5 in pairs(ActivityData:GetAllActivityData()) do
			uv0.DealWithActivityData(slot5)
		end

		uv0.AfterDealWithActivityData()
	end,
	DealWithActivityData = function (slot0)
		if ActivityTemplateConst.MAIN_ACTIVITY == ActivityTools.GetActivityType(slot0.id) then
			uv0.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.DEMON == slot1 then
			SubDemonChallengeAction.Init()
			SubDemonChallengeAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.NEW_DEMON == slot1 then
			NewDemonChallengeAction.Init()
			NewDemonChallengeAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.TALENT_TREE == slot1 then
			TalentTreeAction.Init()
		elseif ActivityTemplateConst.BATTLE_FIRST_PASS == slot1 then
			BattleFirstPassAction.Init()
			BattleFirstPassAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.STORY == slot1 then
			uv0.InitStoryRedPoint(slot0.id)
		elseif ActivityTemplateConst.SOLO_CHALLENGE == slot1 then
			SoloChallengeAction.InitRedPoint(slot0.id)
		elseif ActivityTemplateConst.FISHING == slot1 then
			FishingAction.Init()
		elseif ActivityTemplateConst.LIMITED_CALCULATION == slot1 then
			LimitedCalculationAction.Init()
			LimitedCalculationAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.SKIN_EXCHANGE == slot1 then
			SkinExchangeAction.Init()
			SkinExchangeAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.SUMMER_ACTIVITY_PT == slot1 then
			SummerActivityPtAction.Init()
		elseif ActivityTemplateConst.ACTIVITY_PUZZLE == slot1 then
			PuzzleAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.COWBOY == slot1 then
			CowboyAction.Init()
			CowboyAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_RACE == slot1 then
			ActivityRaceAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.GUILD_ACTIVITY == slot1 then
			GuildActivityAction.Init()
		elseif ActivityTemplateConst.GUILD_ACTIVITY_SP == slot1 then
			GuildActivitySPAction.Init()
		elseif ActivityTemplateConst.XH1ST_SEAL == slot1 then
			XH1stSealAction.Init()
			XH1stSealAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.RACE_TRIAL == slot1 then
			RaceTrialAction.Init(slot0.id)
			RaceTrialAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.INFINITY_POOL_TASK == slot1 then
			uv0.InitInfinityPoolTaskRedPoint(slot0.id)
		elseif ActivityTemplateConst.MARDUK_SPECIAL == slot1 then
			MardukSpecialAction.Init(slot0.id)
		elseif ActivityTemplateConst.SURVIVE_SOLO == slot1 then
			SurviveSoloAction.Init(slot0.id)
			SurviveSoloAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.PAPER_CUT == slot1 then
			PaperCutAction.Init(slot0.id)
		elseif ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET == slot1 then
			AntitheticalCoupletAction.Init()
			AntitheticalCoupletAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.VALENTINE_GAME == slot1 or ActivityTemplateConst.INDIA_VALENTINE_GAME_V2 == slot1 then
			ValentineGameAction.Init()
			ValentineGameAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_AFFIX_SELECT == slot1 then
			ActivityAffixSelectAction.Init()
			ActivityAffixSelectAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO == slot1 then
			CultivateHeroAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_PT_2 == slot1 then
			ActivityPt2Action.Init()
			ActivityPt2Action.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_SET == slot1 then
			uv0.InitActivitySetRedPoint(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_RECALL == slot1 then
			ActivityRecallAction.Init()
		elseif ActivityTemplateConst.SAIL_GAME == slot1 then
			SailGameAction.UpdateRedPoint(slot0.id)
		elseif ActivityTemplateConst.CHESS_ACTIVITY_CHINESE_ZONE == slot1 then
			RedPointData:UpdateRedPoint(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_2_2_WATER == slot1 then
			ActivityWaterAction.Init(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_FLIP_CARD == slot1 then
			XH3rdFlipCardAction:InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_SKIN_DRAW == slot1 then
			ActivitySkinDrawAction.Init()
			ActivitySkinDrawAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.JAPAN_SOLO_HEART_DEMON == slot1 then
			-- Nothing
		elseif ActivityTemplateConst.ACTIVITY_INVITE == slot1 then
			InviteAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.DESTROY_BOX_GAME == slot1 then
			DestroyBoxGameAction.InitRedPoint(slot0.id)
		elseif ActivityTemplateConst.KAGUTSUCHI_ACTIVITY_PT_SCROLL == slot1 then
			ActivityPtScrollAction.Init()
			ActivityPtScrollAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_QUIZ == slot1 then
			ActivityQuizAction.Init()
			ActivityQuizAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_MEMORY == slot1 then
			ActivityMemoryAction.Init(slot0.id)
			ActivityMemoryAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.ACTIVITY_PUSH_BOX == slot1 then
			ActivityPushBoxAction.Init()
			ActivityPushBoxAction.InitRedPointKey(slot0.id)
		elseif ActivityTemplateConst.HERO_LETTER == slot1 then
			ActivityHeroLetterAction.Init()
			ActivityHeroLetterAction.InitRedPointKey(slot0.id)
		end
	end,
	AfterDealWithActivityData = function ()
		SkuldTravelData:InitRedPointGroup()
	end,
	UpdateRedPoint = function (slot0)
		if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_PUZZLE then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				for slot8, slot9 in ipairs(ActivityCfg[slot0].sub_activity_list) do
					manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, slot3, slot9), 0)
					manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, slot3, slot9), 0)
				end
			end
		elseif slot0 == ActivityConst.MOONBO then
			MoonBoData:FreshTime()
		elseif slot1 == ActivityTemplateConst.HERO_TRIAL then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				-- Nothing
			end
		elseif slot1 == ActivityTemplateConst.SKIN_TRIAL then
			SkinTrialAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.SUMMER_ACTIVITY_PT then
			SummerActivityPtAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.COWBOY then
			CowboyAction:CloseActivity(slot0)
		elseif slot1 == ActivityTemplateConst.ACTIVITY_RACE then
			ActivityRaceAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.GUILD_ACTIVITY then
			GuildActivityAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.GUILD_ACTIVITY_SP then
			GuildActivitySPAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.DEMON then
			SubDemonChallengeAction.RefreshRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.RACE_TRIAL then
			RaceTrialAction.UpdateRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.STORY then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				uv0.ClearRedPoint(slot0)
				manager.redPoint:updateKey(ActivityTools.GetRedPointKey(slot0) .. slot0)
			elseif #(manager.redPoint:getchildKeys(slot3) or {}) <= 0 then
				uv0.InitStoryRedPoint(slot0)
				manager.redPoint:updateKey(slot3)
			end

			TaskRedPoint:UpdateChapterPlot19RedTip()
		elseif slot1 == ActivityTemplateConst.STORY_STAGE then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				ActivityStoryAction.UpdateRedPoint(slot0, 0)
			end
		elseif slot1 == ActivityTemplateConst.MAIN_STORY then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() then
				for slot6, slot7 in ipairs(ActivityCfg[slot0].sub_activity_list) do
					manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(slot7), slot7), 0)
				end
			end

			BattleStageAction.UpdateActivityRedPoint()
		elseif slot1 == ActivityTemplateConst.SUB_PLOT then
			BattleStageAction.UpdateSubPlotRedPoint()
		elseif slot1 == ActivityTemplateConst.ENDLESS then
			BattleStageAction.UpdateActivityRedPoint()
		elseif slot1 == ActivityTemplateConst.MARDUK_SPECIAL then
			if slot0 == ActivityConst.FACTORY_MARDUK then
				MardukSpecialAction.UpdateRedPoint(slot0)
			end

			if slot0 == ActivityConst.ACTIVITY_2_2_SPECIAL then
				MardukSpecialAction.UpdateRedPoint(slot0)
			end
		elseif slot1 == ActivityTemplateConst.SEQUENTIAL_BATTLE_SUB then
			SequentialBattleAction.StopRedPoint(slot0)
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, slot0), 0)
		elseif slot1 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, slot0))
		elseif slot0 == ActivityConst.ACTIVITY_1_6 then
			SkuldTravelAction:CheckUnBindActivitySkuld()
			SkuldTravelAction:CheckUnBindChapterKey()
		elseif slot0 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
			RedPointData:UpdateRedPoint(slot0)
		elseif ActivityTemplateConst.ACTIVITY_PROMOTINAL == slot1 then
			uv0.UpdatePromotinalRedPoint(slot0)
		elseif ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE == slot1 or ActivityTemplateConst.ACTIVITY_2_2_WATER == slot1 then
			ActivityWaterAction.UpdateOpenRedPoint()
			ActivityWaterAction.UpdateNewScheduleRedPoint()
		elseif ActivityTemplateConst.LIMITED_CALCULATION == slot1 then
			LimitedCalculationAction:RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.SOLO_CHALLENGE == slot1 then
			SoloChallengeAction.CloseRedPoint(slot0)
		elseif ActivityTemplateConst.ABYSS == slot1 then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() + 1 and AbyssData:GetRefreshTimestamp() <= slot3 then
				AbyssAction.UpdateRedPoints()
			end
		elseif ActivityTemplateConst.POLYHEDRON_ACTIVITY == slot1 then
			if ActivityData:GetActivityData(slot0).stopTime <= manager.time:GetServerTime() + 1 and ActivityData:GetActivityData(PolyhedronData:GetActivityID()).stopTime <= slot3 then
				PolyhedronAction.RefreshPolicyRedPoint()
				PolyhedronAction.CheckBeaconRedPoint()
				PolyhedronAction.CheckTerminalRedPoint()
				PolyhedronAction.RefreshHeroesRedPoint()
			end

			manager.notify:Invoke(MATRIX_UPDATE)
		elseif ActivityTemplateConst.MOON_CAKE_MAKE == slot1 then
			if not ActivityData:GetActivityIsOpen(slot0) then
				MoonCakeAction.CloseCakeStageRedPoint(slot0)
			end
		elseif ActivityTemplateConst.MOON_CAKE_PARTY == slot1 then
			if not ActivityData:GetActivityIsOpen(slot0) then
				MoonCakeAction.ClosePartytageRedPoint(slot0)
			end
		elseif ActivityTemplateConst.DESTROY_BOX_GAME == slot1 then
			DestroyBoxGameAction.UpdateMainActivityRedPoint(slot0)
		elseif ActivityTemplateConst.DESTROY_BOX_GAME_STAGE == slot1 then
			DestroyBoxGameAction.UpdateRedPoint(slot0)
		elseif ActivityTemplateConst.KAGUTSUCHI_ACTIVITY_PT_SCROLL == slot1 then
			ActivityPtScrollAction.RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.VALENTINE_GAME_LEVEL == slot1 or ActivityTemplateConst.INDIA_VALENTINE_GAME_V2_SUBACTIVITY == slot1 then
			ValentineGameAction:RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.ACTIVITY_QUIZ == slot1 then
			ActivityQuizAction.RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.ACTIVITY_MEMORY == slot1 then
			ActivityMemoryAction.RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.SURVIVE_SOLO == slot1 then
			SurviveSoloAction:RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO == slot1 then
			CultivateHeroAction.RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.ACTIVITY_PUSH_BOX == slot1 then
			ActivityPushBoxAction.RefreshRedPoint(slot0)
		elseif ActivityTemplateConst.HERO_LETTER == slot1 then
			ActivityHeroLetterAction.RefreshRedPoint(slot0)
		end

		if SpringPreheatAction then
			SpringPreheatAction:RefreshRedPoint()
		end

		if HeroTrialData then
			HeroTrialData:RefreshRedData()
		end

		uv0.UpdateShopRedPoint(slot0)
	end,
	InitRedPointKey = function (slot0)
		slot1 = nil
		slot2 = {}

		if not ActivityCfg[slot0].sub_activity_list or #slot3 == 0 then
			return
		end

		if slot0 == ActivityConst.OSIRIS_ACTIVITY then
			manager.redPoint:addGroup(string.format("%s%s", RedPointConst.MAIN_ACTIVITY, slot0), {
				string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY),
				string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS),
				RedPointConst.OSIRIS_DEMON,
				RedPointConst.OSIRIS_RACE_TRIAL,
				string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
			})

			return
		end

		for slot7, slot8 in ipairs(slot3) do
			table.insert(slot2, ActivityTools.GetRedPointKey(slot8) .. slot8)
		end

		manager.redPoint:addGroup(RedPointConst.MAIN_ACTIVITY .. slot0, slot2)
	end,
	InitSubRedPoint = function (slot0)
		if #ActivityCfg[slot0].sub_activity_list <= 0 then
			return
		end

		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			uv0.InitSubRedPoint(slot7)
			table.insert(slot2, ActivityTools.GetRedPointKey(slot7) .. slot7)
		end

		manager.redPoint:addGroup(ActivityTools.GetRedPointKey(slot0) .. slot0, slot2)
	end,
	InitStoryRedPoint = function (slot0)
		slot1 = {}

		if ActivityCfg[slot0] == nil then
			return
		end

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == ActivityTemplateConst.STORY_STAGE or ActivityCfg[slot6].activity_template == ActivityTemplateConst.SUB_PLOT or ActivityCfg[slot6].activity_template == ActivityTemplateConst.MAIN_STORY then
				table.insert(slot1, ActivityTools.GetRedPointKey(slot6) .. slot6)
				uv0.InitSubRedPoint(slot6)
			elseif ActivityCfg[slot6].activity_template == ActivityTemplateConst.CHESS then
				table.insert(slot1, string.format("%s_%s", RedPointConst.WAR_CHESS, slot6))
			end
		end

		if ActivityCfg[slot0].activity_theme == ActivityConst.THEME.SUMMER then
			slot8 = "%s_%s"

			table.insert(slot1, string.format(slot8, RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[slot0].activity_theme))

			slot3 = {}
			slot7 = ActivityCfg[slot0].activity_theme

			for slot7, slot8 in ipairs(ActivityStoryCollect[slot7].story_id) do
				table.insert(slot3, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot2, slot8))
			end

			manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, slot2), slot3)
			table.insert(slot1, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, 6010003))
		end

		manager.redPoint:addGroup(ActivityTools.GetRedPointKey(slot0) .. slot0, slot1)
	end,
	ClearRedPoint = function (slot0)
		manager.redPoint:addGroup(ActivityTools.GetRedPointKey(slot0) .. slot0, {}, true)
	end,
	InitInfinityPoolTaskRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
				table.insert(slot1, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot6))
			end
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.INFINITY_POOL_TASK, slot0), slot1)
	end,
	InitActivitySetRedPoint = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(ActivityCfg[slot0].sub_activity_list) do
			if ActivityCfg[slot6].activity_template == ActivityTemplateConst.TASK then
				table.insert(slot1, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, slot6))
			elseif ActivityCfg[slot6].activity_template == ActivityTemplateConst.ACTIVITY_SHOP then
				table.insert(slot1, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, slot6))
			end
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_SET, slot0), slot1)
	end,
	InitLoginShopRedPoint = function ()
		slot3 = ActivityTemplateConst.ACTIVITY_SHOP

		for slot3, slot4 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot3]) do
			if ActivityData:GetActivityIsOpen(slot4) and ActivityData:GetActivityData(slot4).stopTime <= manager.time:GetServerTime() + 259200 and ActivityShopCfg[slot4] then
				for slot12, slot13 in ipairs(ShopListCfg[ActivityShopCfg[slot4].shop_id].cost_id or {}) do
					if ItemTools.getItemNum(slot13) > 0 then
						manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, slot4), 1)

						break
					end
				end
			end
		end
	end,
	UpdateShopRedPoint = function (slot0)
		if ActivityCfg[slot0] == nil then
			print("no exist activity config :", acitvityID)

			return
		end

		if slot1.activity_template == ActivityTemplateConst.ACTIVITY_SHOP and not ActivityData:GetActivityIsOpen(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, slot0), 0)
		end
	end,
	UpdatePromotinalRedPoint = function (slot0)
		if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + slot0) and ActivityTools.GetActivityStatus(slot0) == 1 then
			manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(slot0), slot0), 1)
		else
			manager.redPoint:setTip(slot1, 0)
		end
	end,
	OnLogin = function (slot0)
	end,
	OnLogout = function ()
		PaperCutTool:OnLogout()
		SailGameTools.ShutDown()
	end,
	ReceivePointReward = function (slot0)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = slot0
		}, 60055, uv0.OnReceivePointReward)
	end,
	OnReceivePointReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			for slot5, slot6 in ipairs(slot1.point_reward_id_list) do
				if ActivityTemplateConst.LIMITED_CALCULATION == ActivityTools.GetActivityType(ActivityPointRewardCfg[slot6].activity_id) then
					LimitedCalculationAction:OnReceivePointReward(slot7.activity_id, slot7.id)
				elseif ActivityTemplateConst.SUB_SINGLE_MATRIX == slot8 then
					ActivityMatrixAction.OnReceivePointReward(slot7.activity_id, slot7.id)
				end
			end

			getReward2(mergeReward2(slot0.reward_list))
			manager.notify:Invoke(ACTIVITY_REWARD_GET, {
				point_reward_id_list = slot1.point_reward_id_list
			})
			manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, slot1.point_reward_id_list)
		else
			ShowTips(slot0.result)
		end
	end,
	GetBonus = function (slot0)
		manager.net:SendWithLoadingNew(60054, {
			point_reward_id_list = slot0
		}, 60055, uv0.OnGetBonusCallback)
	end,
	OnGetBonusCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward2(mergeReward2(slot0.reward_list))
			manager.notify:Invoke(ACTIVITY_REWARD_GET, {
				point_reward_id_list = slot1.point_reward_id_list
			})
		else
			ShowTips(GetTips(slot0.result))
		end
	end
}
