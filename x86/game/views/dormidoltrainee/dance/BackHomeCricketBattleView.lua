slot0 = class("BackHomeCricketBattleView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.leanTweenAni = {}
end

function slot1(slot0, slot1)
	slot2 = slot1.transform:GetComponent("ControllerExCollection")

	table.insert(slot0, {
		state = slot2:GetController("state"),
		effect = slot2:GetController("effect")
	})
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.buffList = {}
	slot0.leftBuffList = {}
	slot0.rightBuffList = {}
	slot0.playerBuffList = LuaList.New(handler(slot0, slot0.indexPlayerItem), slot0.playerListGo_, BackHomeCricketBuffItem)
	slot0.enemyBuffList = LuaList.New(handler(slot0, slot0.indexEnemyItem), slot0.enemyListGo_, BackHomeCricketBuffItem)
	slot0.modeController_ = slot0.mainControllerEx_:GetController("mode")
	slot0.gameStateController_ = slot0.mainControllerEx_:GetController("gameState")
	slot0.showBuffDetailController_ = slot0.mainControllerEx_:GetController("showBuffDetail")
	slot0.style1Item_ = EnterBattleStyleListItem.New(slot0.style1Go_)
	slot0.style2Item_ = EnterBattleStyleListItem.New(slot0.style2Go_)
	slot0.bubbleTimerList_ = {}
	slot0.stateBlueController_ = slot0.mainControllerEx_:GetController("stateBlue")
	slot0.stateRedController_ = slot0.mainControllerEx_:GetController("stateRed")
	slot0.skillBlueController_ = slot0.mainControllerEx_:GetController("skillBlue")
	slot0.skillRedController_ = slot0.mainControllerEx_:GetController("skillRed")
	slot0.AttrBlueController_ = slot0.mainControllerEx_:GetController("AttrBlue")
	slot0.AttrRedController_ = slot0.mainControllerEx_:GetController("AttrRed")
	slot0.crownController_ = slot0.mainControllerEx_:GetController("crown")
	slot0.bubbleControllerList_ = {
		slot0.stateBlueController_,
		slot0.stateRedController_,
		slot0.skillBlueController_,
		slot0.skillRedController_,
		slot0.AttrBlueController_,
		slot0.AttrRedController_
	}
	slot0.actionBtnControllers = {}

	uv0(slot0.actionBtnControllers, slot0.flowerBtn_)
	uv0(slot0.actionBtnControllers, slot0.fireworkBtn_)
	uv0(slot0.actionBtnControllers, slot0.cheerBtn_)

	slot0.buttonMaskList = {
		slot0.maskImg1_,
		slot0.maskImg2_,
		slot0.maskImg3_
	}
	slot0.danmakuSubview = DanceGameDanmakuSubView.New(slot0.danmakuView_)
end

function slot0.OnDanceGameStart(slot0)
	slot0.gameStateController_:SetSelectedState("start")

	slot1 = DormCharacterActionManager.frameTaskRunner:NewTask()

	slot1:WaitUntil(function ()
		return uv0.gameStartAni_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1
	end, true):Then(function ()
		Dorm.storage:RecordData("dance.flags", "start", true)
		uv0.gameStateController_:SetSelectedState("game")
	end)
	slot1:Start()
end

function slot0.OnDanceGameFinish(slot0)
	slot0.gameStateController_:SetSelectedState("end")
end

function slot0.GetStageEffect(slot0, slot1)
	return string.format("IdolTrainee/StageVfx/%s/%s", slot0.stage, slot1)
end

function slot0.ResetDanmakuAmount(slot0)
	slot0.danmakuSubview:SetExpectDanmakuAmount(GameDisplayCfg.dorm_idol_stage_bullet_comment_normal.value[1])
end

function slot0.StartDanmakuClimax(slot0)
	slot0:InterruptDanmakuClimax(false)

	slot0.climaxTimer = Timer.New(function ()
		uv0:InterruptDanmakuClimax(true)
	end, GameDisplayCfg.dorm_idol_stage_bullet_comment_high_time.value[1], false)

	slot0.danmakuSubview:SetExpectDanmakuAmount(GameDisplayCfg.dorm_idol_stage_bullet_comment_high.value[1])
	slot0.danmakuSubview:SetDanmakuFilter(2)
	slot0.climaxTimer:Start()
end

function slot0.InterruptDanmakuClimax(slot0, slot1)
	if slot0.climaxTimer then
		slot0.climaxTimer:Stop()

		slot0.climaxTimer = nil

		if slot1 then
			slot0:ResetDanmakuAmount()
			slot0.danmakuSubview:SetDanmakuFilter(1)
		end
	end
end

function slot0.AddListeners(slot0)
	slot1 = nil

	slot0:AddBtnListener(slot0.flowerBtn_, nil, function ()
		if not uv0:CooldownFinish() then
			return
		end

		slot0 = "flower"

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, uv0:GetStageEffect(slot0), 6)
		uv0:StartCooldownAndEffect(uv1, 1)
		uv0:StartDanmakuClimax()
		Dorm.storage:RecordData(slot1, slot0, (Dorm.storage:GetData(DanceGame.actionCountNamespace, slot0) or 0) + 1)
	end)
	slot0:AddBtnListener(slot0.fireworkBtn_, nil, function ()
		if not uv0:CooldownFinish() then
			return
		end

		slot0 = "firework"

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, uv0:GetStageEffect(slot0), 6)
		uv0:StartCooldownAndEffect(uv1, 2)
		uv0:StartDanmakuClimax()
		Dorm.storage:RecordData(slot1, slot0, (Dorm.storage:GetData(DanceGame.actionCountNamespace, slot0) or 0) + 1)
	end)
	slot0:AddBtnListener(slot0.cheerBtn_, nil, function ()
		if not uv0:CooldownFinish() then
			return
		end

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, uv0:GetStageEffect("cheer"), 6)
		uv0:StartCooldownAndEffect(uv1, 3)
		uv0:StartDanmakuClimax()
		Dorm.storage:RecordData(slot1, slot0, (Dorm.storage:GetData(DanceGame.actionCountNamespace, "cheer") or 0) + 1)
	end)
	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		DanceGame.GetInstance():SkipShow()
	end)
end

function slot0.CooldownFinish(slot0)
	return slot0.cooldownTimer == nil
end

function slot0.StartCooldownAndEffect(slot0, slot1, slot2)
	slot3 = nullable(GameSetting, "dorm_idol_dance_support_cooldown", "value", 1) or 5
	slot0.startCooldownTime = Time.time
	slot0.cooldownTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
		slot1 = Time.time - uv0.startCooldownTime

		for slot5, slot6 in ipairs(uv0.buttonMaskList) do
			slot6.fillAmount = 1 - slot1 / uv1
		end

		if uv1 < slot1 then
			uv0:StopCooldown()

			if uv2 then
				uv2()
			end
		end
	end, -1, true)

	for slot7, slot8 in pairs(slot0.actionBtnControllers) do
		slot8.state:SetSelectedState("lock")

		if slot7 == slot2 then
			slot8.effect:SetSelectedState("true")
		end
	end
end

function slot0.StopCooldown(slot0)
	if slot0.cooldownTimer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.cooldownTimer)

		slot0.cooldownTimer = nil
	end

	for slot4, slot5 in ipairs(slot0.buttonMaskList) do
		slot5.fillAmount = 1
	end

	for slot4, slot5 in pairs(slot0.actionBtnControllers) do
		slot5.state:SetSelectedState("available")
		slot5.effect:SetSelectedState("false")
	end
end

function slot0.OnEnter(slot0)
	if slot0.params_.stage then
		slot0.stage = slot0.params_.stage
	end

	slot0.rightScore = 0
	slot0.leftScore = 0
	slot0.battleData = BackHomeCricketBattleData:GetSingleBattleData()
	slot0.playerEID = DanceGame.GetInstance():GetPlayerCharaEID()
	slot0.enemyEID = DanceGame.GetInstance():GetOpponentCharaEID()

	slot0.modeController_:SetSelectedState("game")
	slot0:RegisterEvents()
	slot0:RefreshView()
	slot0:UpdateScoreBar()

	if slot0.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		slot0.modeController_:SetSelectedState("record")
	end

	slot0.danmakuSubview:OnEnter()
	slot0.danmakuSubview:SetDanmakuFilter(1)
	slot0:ResetDanmakuAmount()
	slot0:ClearBuffContentDisplay()
end

function slot0.OnTop(slot0)
	slot0:RefreshBar()
end

function slot0.OnExit(slot0)
	slot0:StopShowDetailTimer()
	slot0:ClearBuffContentDisplay()
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
	slot0:InterruptDanmakuClimax(true)
	slot0.danmakuSubview:OnExit()
	slot0:StopCooldown()
	slot0:CancelAllLeanTween()

	for slot4 = 1, 6 do
		if slot0.bubbleTimerList_[slot4] then
			slot0.bubbleControllerList_[slot4]:SetSelectedState("false")
			slot0.bubbleTimerList_[slot4]:Stop()

			slot0.bubbleTimerList_[slot4] = nil
		end
	end

	if slot0.countDownTimer_ then
		slot0.countDownTimer_:Stop()

		slot0.countDownTimer_ = nil
	end
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		DanceGame.GetInstance():GotoResultView()
	end)
end

function slot0.RefreshView(slot0)
	slot0:RefreshStageState()

	slot1 = nil
	slot0.curCountTime_ = IdolStageMusicCfg[((not slot0.battleData.enemyID and slot0.battleData.settleType ~= BackHomeCricketConst.ROOM_TYPE.Video or IdolTraineePvpBattleCfg[slot0.battleData.stageID]) and IdolTraineePveBattleCfg[slot0.battleData.stageID]).bgm].round_time
	slot0.countDownText_.text = slot0.curCountTime_ .. GetTips("SECOND")
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(BACKHOME_CRICKET_REFRESH_BUFF, function (slot0)
		uv0.roundCount = slot0

		uv0:RefreshHeroBuffList()
	end)
	slot0:RegistEventListener(BACKHOME_CRICKET_ROUND_END, function (slot0)
		uv0.roundCount = slot0

		uv0:RefreshScore()
	end)
end

function slot0.RefreshStageState(slot0)
end

function slot0.ShowCricketBattleResult(slot0, slot1)
	if slot1.is_success then
		print("战斗胜利")
	else
		print("战斗失败")
	end
end

function slot0.indexPlayerItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.leftBuffList[slot1], slot0.SetBuffContentOnLeft)
end

function slot0.indexEnemyItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.rightBuffList[slot1], slot0.SetBuffContentOnRight)
end

function slot0.RefreshHeroBuffList(slot0)
	slot2 = slot0:FilterBuffList(DormUtils.GetEntityData(slot0.enemyEID).buff)
	slot3 = {
		[slot9.id] = true
	}
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:FilterBuffList(DormUtils.GetEntityData(slot0.playerEID).buff)) do
		-- Nothing
	end

	for slot8, slot9 in ipairs(slot2) do
		slot4[slot9.id] = true
	end

	for slot8, slot9 in ipairs(slot0.leftBuffList) do
		slot3[slot9.id] = nil
	end

	for slot8, slot9 in ipairs(slot0.rightBuffList) do
		slot4[slot9.id] = nil
	end

	for slot8, slot9 in pairs(slot3) do
		slot10, slot11 = IdolTraineeTools:GetSkillEffect(slot8)

		if slot10 then
			slot0.buff1Text_.text = (slot11 > 0 and "+" or "-") .. slot11 .. "%"

			slot0:SetBubblesTimer(1)

			break
		end
	end

	for slot8, slot9 in pairs(slot4) do
		slot10, slot11 = IdolTraineeTools:GetSkillEffect(slot8)

		if slot10 then
			slot0.buff2Text_.text = (slot11 > 0 and "+" or "-") .. slot11 .. "%"

			slot0:SetBubblesTimer(2)

			break
		end
	end

	slot0.leftBuffList = slot0:FilterBuffList(DormUtils.GetEntityData(slot0.playerEID).buff)
	slot0.rightBuffList = slot0:FilterBuffList(DormUtils.GetEntityData(slot0.enemyEID).buff)

	slot0.playerBuffList:StartScroll(#slot0.leftBuffList)
	slot0.enemyBuffList:StartScroll(#slot0.rightBuffList)
end

function slot2(slot0, slot1)
	print(slot1, string.format("特性分=%d", slot0.type), string.format("技能分=%d", slot0.actionScore), string.format("回合总分=%d", slot0.isHit))
end

function slot0.RefreshScore(slot0)
	slot0:ShowScoreBarInfo()
	slot0:ShowBubbleInfo()
end

function slot0.UpdateScoreBar(slot0, slot1, slot2)
	slot3 = nil
	slot1 = slot1 or slot0.leftScore
	slot2 = slot2 or slot0.rightScore
	slot3 = slot1 + slot2 == 0 and 0.5 or Mathf.Clamp(slot1 / (slot1 + slot2), 0.2, 0.8)
	slot0.scoreImg_.fillAmount = slot3
	slot0.barSeperator_.anchoredPosition = Vector3(slot3 * slot0.scoreImg_.transform.rect.width, 0, 0)
	slot0.leftScoreText_.text = string.format("%d", slot1)
	slot0.rightScoreText_.text = string.format("%d", slot2)

	if slot3 > 0.5 then
		slot0.crownController_:SetSelectedState("left")
	elseif slot3 < 0.5 then
		slot0.crownController_:SetSelectedState("right")
	else
		slot0.crownController_:SetSelectedState("equal")
	end
end

function slot3(slot0, slot1, slot2)
	return slot1 * slot2 + slot0 * (1 - slot2)
end

function slot0.UpdateScoreBarAni(slot0, slot1, slot2, slot3, slot4)
	slot8 = slot0.leftScore
	slot9 = slot0.rightScore
	slot10 = LeanTween.value(0, 1, slot3 or 1):setEase(LeanTweenType.easeInOutQuad):setDelay(slot4 or 0.5)

	slot10:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv5:UpdateScoreBar(uv0(uv1, uv2, slot0), uv0(uv3, uv4, slot0))
	end))
	slot10:setOnComplete(System.Action(function ()
		uv0:UpdateScoreBar(uv1, uv2)

		uv0.leanTweenAni[uv3] = nil
	end))

	slot0.leanTweenAni[slot0.scoreImg_] = slot10
	slot0.rightScore = slot2
	slot0.leftScore = slot1
end

function slot0.ShowScoreBarInfo(slot0)
	if slot0.roundCount ~= 0 then
		slot1 = slot0.battleData:GetBattleDataByRound(slot0.roundCount)

		uv0(slot1.myScore, string.format("myScore at Round %d:", slot0.roundCount))
		uv0(slot1.enemyScore, string.format("enemyScore at Round %d:", slot0.roundCount))
		slot0:UpdateScoreBarAni(slot1.myScore.isHit + slot0.leftScore, slot1.enemyScore.isHit + slot0.rightScore)
	else
		slot0:UpdateScoreBar(0, 0)
	end
end

function slot0.ShowBubbleInfo(slot0)
	if slot0.roundCount == 0 then
		return
	end

	slot2 = nil
	slot2 = (not slot0.battleData.enemyID and slot0.battleData.settleType ~= BackHomeCricketConst.ROOM_TYPE.Video or IdolTraineePvpBattleCfg[slot0.battleData.stageID]) and IdolTraineePveBattleCfg[slot0.battleData.stageID] or IdolTraineePvpBattleCfg[slot0.battleData.stageID]

	if slot0.battleData:GetBattleDataByRound(slot0.roundCount).myAction.actionID and slot2.peculiarity_rate[slot3] then
		SetActive(slot0.attr1Sp_, slot2.peculiarity_rate[slot3] > 100)
		slot0.style1Item_:SetData(slot3)
		slot0:StartScoreBubbleAni(slot0.attrNum1Text_, slot1.myScore.isHit, slot1.myScore.type)
		slot0:SetBubblesTimer(5)
	end

	if slot1.enemyAction.actionID and slot2.peculiarity_rate[slot4] then
		SetActive(slot0.attr2Sp_, slot2.peculiarity_rate[slot4] > 100)
		slot0.style2Item_:SetData(slot4)
		slot0:StartScoreBubbleAni(slot0.attrNum2Text_, slot1.enemyScore.isHit, slot1.enemyScore.type)
		slot0:SetBubblesTimer(6)
	end

	if slot1.myAction.skillID and IdolTraineeSkillCfg[slot5] then
		slot0.skill1Img_.sprite = IdolTraineeTools:GetSkillIcon(slot5)

		slot0:SetBubblesTimer(3)
	end

	if slot1.enemyAction.skillID and IdolTraineeSkillCfg[slot6] then
		slot0.skill2Img_.sprite = IdolTraineeTools:GetSkillIcon(slot6)

		slot0:SetBubblesTimer(4)
	end
end

function slot4(slot0)
	return string.format("+%d", slot0)
end

function slot0.StartScoreBubbleAni(slot0, slot1, slot2, slot3)
	if slot0.leanTweenAni[slot1] then
		LeanTween.cancel(slot1.gameObject, slot4.id)
	end

	slot3 = slot3 or 0
	slot1.text = uv0(slot3)
	slot5 = LeanTween.value(slot3, slot2, 0.5):setEase(LeanTweenType.easeInOutQuad):setDelay(0.5)

	slot5:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.text = uv1(math.floor(slot0))
	end))
	slot5:setOnComplete(System.Action(function ()
		uv0.text = uv1(uv2)
		uv3.leanTweenAni[uv0] = nil
	end))

	slot0.leanTweenAni[slot1] = slot5
end

function slot0.CancelAllLeanTween(slot0)
	for slot4, slot5 in pairs(slot0.leanTweenAni) do
		LeanTween.cancel(slot5.id)
	end

	slot0.leanTweenAni = {}
end

function slot0.SetBubblesTimer(slot0, slot1)
	slot0.bubbleControllerList_[slot1]:SetSelectedState("true")

	if slot0.bubbleTimerList_[slot1] then
		slot0.bubbleTimerList_[slot1]:Stop()

		slot0.bubbleTimerList_[slot1] = nil
	end

	slot0.bubbleTimerList_[slot1] = Timer.New(function ()
		uv0.bubbleControllerList_[uv1]:SetSelectedState("false")

		if uv0.bubbleTimerList_[uv1] then
			uv0.bubbleTimerList_[uv1]:Stop()

			uv0.bubbleTimerList_[uv1] = nil
		end
	end, 1.5, 1)

	slot0.bubbleTimerList_[slot1]:Start()
end

function slot0.OnStartCountDownTimer(slot0)
	if slot0.countDownTimer_ then
		slot0.countDownTimer_:Stop()

		slot0.countDownTimer_ = nil
	end

	slot1 = nil
	slot0.curCountTime_ = IdolStageMusicCfg[((not slot0.battleData.enemyID and slot0.battleData.settleType ~= BackHomeCricketConst.ROOM_TYPE.Video or IdolTraineePvpBattleCfg[slot0.battleData.stageID]) and IdolTraineePveBattleCfg[slot0.battleData.stageID]).bgm].round_time
	slot0.countDownText_.text = slot0.curCountTime_ .. GetTips("SECOND")
	slot0.countDownTimer_ = Timer.New(function ()
		uv0.curCountTime_ = uv0.curCountTime_ - 1

		if uv0.curCountTime_ < 0 then
			if uv0.countDownTimer_ then
				uv0.countDownTimer_:Stop()

				uv0.countDownTimer_ = nil
			end
		else
			uv0.countDownText_.text = uv0.curCountTime_ .. GetTips("SECOND")
		end
	end, 1, -1)

	slot0.countDownTimer_:Start()
end

function slot0.FilterBuffList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if not slot7.triggerRound or slot7.triggerRound <= slot0.roundCount then
				table.insert(slot2, slot7)
			end
		end
	end

	return slot2
end

function slot0.Dispose(slot0)
	if slot0.playerBuffList then
		slot0.playerBuffList:Dispose()
	end

	if slot0.enemyBuffList then
		slot0.enemyBuffList:Dispose()
	end

	if slot0.style1Item_ then
		slot0.style1Item_:Dispose()
	end

	if slot0.style2Item_ then
		slot0.style2Item_:Dispose()
	end

	slot0:StopCooldown()
	slot0.danmakuSubview:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.StopShowDetailTimer(slot0)
	if slot0.showDetailTimer then
		slot0.showDetailTimer:Stop()

		slot0.showDetailTimer = nil
	end
end

function slot0.StartShowDetailTimer(slot0)
	slot0:StopShowDetailTimer()

	slot0.showDetailTimer = Timer.New(handler(slot0, slot0.ClearBuffContentDisplay), nullable(GameDisplayCfg, "dorm_idol_stage_show_buff_detail_time", "value", 1) or 2.5, false)

	slot0.showDetailTimer:Start()
end

function slot0.OnBuffIconClick(slot0, slot1, slot2)
	if slot2 then
		slot0:StartShowDetailTimer()
		slot2(slot0, slot1)
	end
end

function slot0.SetBuffContentOnLeft(slot0, slot1)
	slot0.leftBuffDetail_.text = IdolTraineeTools:GetBuffDescString(slot1, true, true, true)

	slot0.showBuffDetailController_:SetSelectedState("left")
end

function slot0.SetBuffContentOnRight(slot0, slot1)
	slot0.rightBuffDetail_.text = IdolTraineeTools:GetBuffDescString(slot1, true, true, true)

	slot0.showBuffDetailController_:SetSelectedState("right")
end

function slot0.ClearBuffContentDisplay(slot0)
	slot0.showBuffDetailController_:SetSelectedState("none")
end

return slot0
