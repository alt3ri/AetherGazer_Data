slot0 = class("SPHeroChallengeBarbuceView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBarbuceUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
	slot0.game = require("game.dorm.minigame.Include").Barbuce.New(function ()
		if not nullable(uv0, "startGameFlag") then
			return slot0, DormRhythmGameTools:GetGameResult(DormRhythmGameData:GetRunTimeData(), DormRhythmGameData:GetLevelIDByDiff(uv0.diff, uv0.activityID), uv0.activityID)
		end

		return slot0
	end)
	slot0.heroEID = slot0.game.heroEID
	slot0.heroID = ActivityHeroChallengeCfg[SPHeroChallengeData:GetActivityID()].hero_id or 1084
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:ResetTimer()

	slot0.goData = {
		itemGo = slot0.itemGo,
		parentTrs = slot0.itemParentTrs,
		deterGo = slot0.deterGo_
	}
	slot0.judgeEffectController = ControllerUtil.GetController(slot0.deterGo_.transform, "effect")
	slot0.judgeAnimator = slot0.deterGo_:GetComponent("Animator")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.viewController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.countDownController = ControllerUtil.GetController(slot0.gameObject_.transform, "countDown")
	slot0.batterController = ControllerUtil.GetController(slot0.gameObject_.transform, "batter")
	slot0.scoreController = ControllerUtil.GetController(slot0.settlementpanelGo_.transform, "score")
	slot0.shareController = ControllerUtil.GetController(slot0.settlementpanelGo_.transform, "share")
	slot0.awardList = LuaList.New(handler(slot0, slot0.RefreshAward), slot0.uilistGo_, CommonItemView)

	slot0:InitAnimationController()
end

function slot0.InitAnimationController(slot0)
	slot0.batterAniamtor = slot0.batterGo:GetComponent("Animator")
	slot0.countAnimator = slot0.countGo:GetComponent("Animator")
	slot0.settleAnimator = slot0.settlementpanelGo_:GetComponent("Animator")
end

function slot0.ShareExitCallBack(slot0)
	slot0.shareController:SetSelectedState("false")
end

function slot0.OnEnter(slot0)
	slot0.info = SPHeroChallengeData:GetCurActivityInfo()
	slot0.activityID = SPHeroChallengeData:GetActivityID()

	slot0:RegisterEvents()
	slot0:ResetStartView()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_STOP_RHYTHM_GAME, function (slot0, slot1)
		if slot0 then
			SDKTools.SendMessageToSDK("backhome_mg_result", {
				result = 1,
				activity_id = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].barbuceActiVityID
			})
			uv0:RefreshSettleView(slot1)
		else
			SDKTools.SendMessageToSDK("backhome_mg_result", {
				result = 2,
				activity_id = slot3
			})
			uv0:ResetStartView()
		end
	end)
	slot0:RegistEventListener(DORM_REFRESH_BATTER_NUM, function (slot0, slot1)
		if ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(uv0.diff, uv0.activityID)].fail_max <= DormRhythmGameData:GetRunTimeData().mistakeNum then
			uv0:SettlementRhythmGame()

			return
		end

		if DormRhythmGameTools:GetEffectRank(DormRhythmGameTools:CalGameScore(slot2, slot3, uv0.activityID)) then
			uv0:SetDormGameEffect(slot6)
		end

		uv0:UpdataBatterNum(slot0, slot6, slot1)
	end)
	slot0:RegistEventListener(BREAK_GAME_LAST_SUCCESS, function ()
		uv0:SettlementRhythmGame()
	end)
	slot0:RegistEventListener(BREAK_GAME_REFRESH_VIEW, function ()
		uv0:RefreshStartAwardInfo()
	end)
end

function slot0.SettlementRhythmGame(slot0)
	slot0:StopGame()
	SPHeroChallengeAction:SettleBarbecueGame({
		result = 1,
		stage_id = ActivityHeroChallengeBarbecueCfg.get_id_list_by_difficult[slot0.diff][1],
		index = DormRhythmGameTools:GetRank(DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), DormRhythmGameData:GetLevelIDByDiff(slot0.diff, slot0.activityID), slot0.activityID)),
		hero_id = slot0.heroID
	})
end

function slot0.AddUIListener(slot0)
	slot4 = slot0.startBtn

	slot0:AddBtnListener(slot4, nil, function ()
		uv0:StartGame()
	end)

	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0["level" .. slot4 .. "Tgl"], function (slot0)
			if slot0 then
				uv0:ChoiceDiff(uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.leftBtn_, nil, function ()
		if not DormRhythmGameData:GetGameRunFlag() then
			return
		end

		DormRhythmGameData:ClickDetermination(DormConst.DORM_RHYTHM_BUTTON_TYPE.left)
	end)
	slot0:AddBtnListener(slot0.rightBtn_, nil, function ()
		if not DormRhythmGameData:GetGameRunFlag() then
			return
		end

		DormRhythmGameData:ClickDetermination(DormConst.DORM_RHYTHM_BUTTON_TYPE.right)
	end)
	slot0:AddBtnListener(slot0.exitGame, nil, function ()
		uv0:ResetStartView()
	end)
	slot0:AddBtnListener(slot0.reStartBtn, nil, function ()
		uv0:ResetStartView()
		uv0:StartGame()
	end)
	slot0:AddBtnListener(slot0.shareBtn, nil, function ()
		manager.share:Share(function ()
			uv0.shareController:SetSelectedState("true")
		end, function ()
			uv0.shareController:SetSelectedState("false")
		end, function ()
		end, nil, {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 2,
			cardPos = 3,
			cardShow = true
		})
	end)
	slot0:AddBtnListener(slot0.pauseBtn, nil, function ()
		DormRhythmGameData:SetPauseFlag(true)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("DORM_MG_LEAVE_CONFIRM"),
			OkCallback = function ()
				uv0:StopGame()
				uv0:ResetStartView()
				SDKTools.SendMessageToSDK("backhome_mg_result", {
					result = 3,
					activity_id = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].barbuceActiVityID
				})
			end,
			CancelCallback = function ()
				DormRhythmGameData:SetPauseFlag(false)
			end,
			MaskCallback = function ()
				DormRhythmGameData:SetPauseFlag(false)
			end
		})
	end)
end

function slot0.StartGame(slot0)
	if slot0.diff then
		slot0.startGameFlag = true

		slot0.game:Start()
		slot0:ResetGameView()
	else
		print("未选择游戏难度")
	end
end

function slot0.ChoiceDiff(slot0, slot1)
	slot0.diff = slot1
end

function slot0.ResetTimer(slot0)
	if uv0.timer then
		for slot4, slot5 in pairs(uv0.timer) do
			slot5:Stop()
		end
	end

	uv0.timer = {}

	slot0.countDownController:SetSelectedState("true")

	slot0.countDownText.text = GameDisplayCfg.dorm_mg_start_time.value[1]
	uv0.timer.startTimer = Timer.New(function ()
		uv0.countAnimator:Play("batter", 0, 0)

		uv1 = uv1 - 1

		if uv1 <= 0 then
			slot0 = uv0.diff or 1

			uv0.countDownController:SetSelectedState("false")
			DormRhythmGameData:StartGame({
				diff = slot0,
				heroID = uv0.heroID,
				stageID = ActivityHeroChallengeBarbecueCfg.get_id_list_by_difficult[slot0][1],
				goInfo = uv0.goData,
				activityID = uv0.activityID
			})
			uv2.timer.startTimer:Stop()
		end

		uv0.countDownText.text = uv1
	end, 1, -1)
end

function slot0.ResetStartView(slot0)
	slot0:ResetTimer()
	slot0:RefreshBar()
	slot0.viewController:SetSelectedState("start")

	if not slot0.diff then
		slot0.diff = 1
		slot0.level1Tgl.isOn = true
	else
		slot0["level" .. slot0.diff .. "Tgl"].isOn = true
	end

	slot0.costFatigueText.text = "x" .. tostring(slot0:GetGameNeedFatigue())

	slot0:RefreshStartAwardInfo()
	slot0.game:PlayStartAnim()
end

function slot0.RefreshStartAwardInfo(slot0)
	slot1 = GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1]
	slot0.refreshtimeText_.text = SPHeroChallengeTools:GetBarbuceGameAwardRefreshTime()

	slot0:RefreshShowReward()
end

function slot0.ResetGameView(slot0)
	slot0.judgeEffectController:SetSelectedState("none")
	manager.audio:StopEffect()
	slot0.viewController:SetSelectedState("playing")
	manager.windowBar:HideBar()
	slot0.batterController:SetSelectedState("false")
	slot0.timer.startTimer:Start()
	manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_start", "")
	slot0:UpdataMistakeNum()

	slot0.effectLevel = 0
	slot0.curBatterType = nil

	slot0:SetDormGameEffect(0)
end

function slot0.awardIndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.awardList[slot1])
end

function slot0.RefreshSettleView(slot0, slot1)
	slot0.viewController:SetSelectedState("settlement")
	slot0.settleAnimator:Play("settle", -1, 0)
	slot0.settleAnimator:Update(0)

	slot2 = DormRhythmGameData:GetResultInfo()
	slot0.successNum.text = tostring(slot2.successfulNum)
	slot0.mistakeNum.text = tostring(slot2.mistakeNum)
	slot0.maxBatterNum.text = tostring(slot2.maxBatterNum)

	if DormConst.DORM_RHYTHMGAME_RANK[DormRhythmGameTools:GetRank(DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), DormRhythmGameData:GetLevelIDByDiff(slot0.diff, slot0.activityID), slot0.activityID))] then
		slot0.scoreController:SetSelectedState(slot7)
	end

	slot0.awardIcon1.sprite = ItemTools.getItemSprite(ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(slot0.diff, slot0.activityID)].reward_list_coin[1][1])
	slot0.awardIcon2.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)
	slot11 = 0
	slot12 = 0

	if slot1 then
		for slot16, slot17 in ipairs(slot1) do
			if slot9 == slot17.id then
				slot11 = slot17.num
			end

			if slot10 == slot17.id then
				slot12 = slot17.num
			end
		end
	end

	slot0.awardtext1.text = slot11
	slot0.awardtext2.text = slot12

	if SPHeroChallengeData:GetBrabuceGameAwardNum() == GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1] then
		slot0.curAwardText1.text = string.format("<color='#FF000B'>%d</color>", slot13) .. "/" .. slot14
	else
		slot0.curAwardText1.text = slot13 .. "/" .. slot14
	end

	if SPHeroChallengeData:GetBarbuceAccelerateNum() == GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1] then
		slot0.curAwardText2.text = string.format("<color='#FF000B'>%d</color>", slot16) .. "/" .. slot15
	else
		slot0.curAwardText2.text = slot16 .. "/" .. slot15
	end
end

function slot0.GetGameNeedFatigue(slot0)
	if GameSetting.dorm_mg_reward_daily_max.value[1] <= DormitoryData:GetDailyCurrency() then
		return 0
	else
		return GameSetting.dorm_mg_break_cost.value[1]
	end
end

function slot0.UpdataBatterNum(slot0, slot1, slot2, slot3)
	slot4 = false

	if DormRhythmGameData:GetRunTimeData().batterNum > 0 then
		if slot0.curBatterType == slot1 then
			slot4 = true
		end
	elseif slot0.curBatterType == DormConst.DORM_RHYTHM_BUTTON_TYPE.fail then
		slot4 = true
	end

	slot7 = slot0.effectLevel

	if slot2 then
		slot0.effectLevel = slot2
	end

	if slot5 then
		slot0.batterNum.text = string.format(GetTips("DORM_MG_BREAK_COMBO_COUNT"), slot6)

		if slot6 > 0 then
			slot0.batterController:SetSelectedState("true")
			slot0.batterAniamtor:Play("batter", 0, 0)
			slot0.judgeEffectController:SetSelectedState("none")

			if not slot3 then
				slot0.judgeAnimator:Play("New Animation", -1, 0)
				slot0.judgeAnimator:Update(0)

				if slot1 == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit01", "")
					slot0.judgeEffectController:SetSelectedState("blue")

					slot0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.left
				else
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit03", "")
					slot0.judgeEffectController:SetSelectedState("red")

					slot0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.right
				end
			end
		else
			slot0.batterController:SetSelectedState("false")
			slot0:UpdataMistakeItem()

			if not slot3 then
				slot0.judgeAnimator:Play("GameObject_defeated", -1, 0)
				slot0.judgeAnimator:Update(0)
				manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit02", "")

				slot0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.fail
			end
		end
	end
end

function slot0.UpdataMistakeItem(slot0)
	if slot0.mistakeList then
		for slot4, slot5 in ipairs(slot0.mistakeList) do
			if slot5.flag then
				slot5.flag = false

				slot5.controller:SetSelectedState("false")

				break
			end
		end
	end
end

function slot0.UpdataMistakeNum(slot0)
	if slot0.diff then
		slot0.mistakeList = {}

		for slot6 = 1, ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(slot0.diff, slot0.activityID)].fail_max do
			slot7 = Object.Instantiate(slot0.bgpowerGo_, slot0.mistakeTrs)
			slot8 = {
				flag = true,
				index = slot6,
				go = slot7,
				controller = ControllerUtil.GetController(slot7.transform, "state")
			}

			slot8.controller:SetSelectedState("true")

			slot0.mistakeList[slot6] = slot8
		end
	end
end

function slot0.StopGame(slot0)
	DormRhythmGameData:StopGame()

	slot0.startGameFlag = false

	slot0:ResetTimer()

	if slot0.mistakeList then
		for slot4, slot5 in ipairs(slot0.mistakeList) do
			Object.Destroy(slot5.go)
		end

		slot0.mistakeList = nil
	end
end

function slot0.SelDiff(slot0, slot1)
	slot0.diff = slot1
end

function slot0.ExitGame(slot0)
	manager.audio:StopEffect()
	DormRhythmGameData:Dispose()
	slot0.game:Abort()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/spHeroChallengeMainView", {})
end

function slot0.SetDormGameEffect(slot0, slot1)
end

function slot0.RefreshShowReward(slot0)
	slot1 = DormRhythmGameData:GetLevelIDByDiff(slot0.diff, slot0.activityID)
	slot4 = ActivityHeroChallengeBarbecueCfg[slot1].reward_list_ticket[#ActivityHeroChallengeBarbecueCfg[slot1].reward_list_ticket][1]
	slot0.icon1Img_.sprite = ItemTools.getItemSprite(ActivityHeroChallengeBarbecueCfg[slot1].reward_list_coin[1][1])
	slot0.icon2Img_.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	if SPHeroChallengeData:GetBrabuceGameAwardNum() == GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1] then
		slot0.num1Text_.text = string.format("<color='#FF000B'>%d</color>", slot5) .. "/" .. slot6
	else
		slot0.num1Text_.text = slot5 .. "/" .. slot6
	end

	if SPHeroChallengeData:GetBarbuceAccelerateNum() == GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1] then
		slot0.num2Text_.text = string.format("<color='#FF000B'>%d</color>", slot8) .. "/" .. slot7
	else
		slot0.num2Text_.text = slot8 .. "/" .. slot7
	end
end

function slot0.RefreshAward(slot0, slot1, slot2)
	CommonTools.SetCommonData(slot2, {
		id = slot0.showRewardList[slot1][1],
		number = slot0.showRewardList[slot1][2],
		clickFun = function ()
			ShowPopItem(POP_ITEM, {
				uv0.showRewardList[uv1][1]
			})
		end
	})
end

function slot0.Dispose(slot0)
	if slot0.rewardList then
		for slot4, slot5 in pairs(slot0.rewardList) do
			slot5:Dispose()
		end
	end

	if slot0.awardList then
		slot0.awardList:Dispose()
	end

	if uv0.timer then
		for slot4, slot5 in pairs(uv0.timer) do
			slot5:Stop()
		end
	end

	DormRhythmGameData:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
