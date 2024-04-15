require("game.data.SPHeroChallengeDataTemplate")

slot0 = singletonClass("SPHeroChallengeData")
slot1, slot2, slot3, slot4 = nil
slot0.activityCfg = {
	[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1] = {
		bossChapter = 703,
		colorPuzzleActiVityID = 242861,
		bossActivityID = 242851,
		helpKey = "ACTIVITY_HERO_CHALLENGE_HELP",
		operationEntrustNum = "activity_hero_challenge_task_condition",
		trainChapter = 702,
		barbuceActiVityID = 242861,
		enterView = "/spHeroChallengeMainView",
		storyChapter = 701,
		heroChipActivityID = 240045,
		taskActivityID = 240046,
		freeRefreshEntrustTime = GameSetting.activity_hero_challenge_task_free_refresh_num.value[1],
		waitEntrustListOpenCondition = GameSetting.activity_hero_challenge_task_line_num.value,
		shopID = ShopConst.SHOP_ID.SP_HERO_CHALLENGE_1,
		acceleratorTime = GameSetting.activity_hero_challenge_certificate_time.value[1],
		HeroChipTask = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].task_id,
		refreshEntrustCost = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].refresh_cost,
		heroID = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].hero_id
	}
}

function slot0.Init(slot0)
	uv0 = nil
	uv1 = nil
	uv2 = {
		accelerateNum = 0,
		awardNum = 0
	}
	uv3 = nil
end

function slot0.InitEnterData(slot0, slot1)
	uv0 = {}

	if slot1.activity_id then
		uv0[slot1.activity_id] = SPHeroChallengeActivityTemplate.New(slot1)
	end
end

function slot0.RefreshDormDailyZero(slot0)
	if uv0 then
		for slot4, slot5 in ipairs(uv0) do
			slot5:RefreshDormDailyZero()
		end
	end
end

function slot0.SetCurActivityID(slot0, slot1)
	uv0 = slot1
end

function slot0.ExitCurSystem(slot0)
	uv0 = nil
end

function slot0.DisposeActivityInfo(slot0, slot1)
	if uv0 and uv0[slot1] then
		uv0[slot1]:Dispose()

		uv0[slot1] = nil
	end
end

function slot0.GetActivityID(slot0)
	return uv0
end

function slot0.GetTotalInfo(slot0)
	return uv0
end

function slot0.GetActivityData(slot0, slot1)
	if uv0 and uv0[slot1] then
		return uv0[slot1]
	end
end

function slot0.GetCurActivityInfo(slot0)
	if uv0 then
		return uv1[uv0]
	end
end

function slot0.GetBrabuceGameAwardNum(slot0)
	return uv0.awardNum or 0
end

function slot0.InitBarbuceAwardData(slot0, slot1)
	if uv0 then
		uv0.awardNum = slot1
	end
end

function slot0.InitAccelerateData(slot0, slot1)
	if uv0 then
		uv0.accelerateNum = slot1
	end
end

function slot0.GetBarbuceAccelerateNum(slot0)
	slot1 = 0

	if uv0 then
		slot1 = uv0.accelerateNum or 0
	end

	return slot1
end

function slot0.GetAccelerateNum(slot0)
	return ItemTools.getItemNum(SpHeroChallengeConst.accelerateID)
end

function slot0.SavePageState(slot0, slot1)
	uv0 = slot1
end

function slot0.GetPageState(slot0)
	uv0 = nil

	return uv0
end

return slot0
