slot0 = class("ActivityQuizSceneMainView", ReduxView)
slot1 = import("game.quiz.QuizFunction")

function slot0.UIName(slot0)
	return ActivityQuizTools.GetActivitySceneUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.rankIndexCon_ = ControllerUtil.GetController(slot0.transform_, "rank")
	slot0.rankTypeCon_ = ControllerUtil.GetController(slot0.transform_, "rankType")
	slot0.quizChoiceCon_ = ControllerUtil.GetController(slot0.quizInfoRect_, "choicebg")
	slot0.quizResultCon_ = ControllerUtil.GetController(slot0.quizInfoRect_, "result")
	slot0.quizStateCon_ = ControllerUtil.GetController(slot0.quizInfoRect_, "next")
	slot0.quizAnsCon_ = ControllerUtil.GetController(slot0.quizInfoRect_, "ans")
	slot0.quizHitCon_ = ControllerUtil.GetController(slot0.quizInfoRect_, "hit")
	slot0.heroScrollHelper_ = LuaList.New(handler(slot0, slot0.HeroIndexItem), slot0.heroListGo_, ActivityQuizHeroItem)
	slot0.rankScrollHelper_ = LuaList.New(handler(slot0, slot0.RankIndexItem), slot0.rankListGo_, ActivityQuizRankItem)
	slot0.snapView_ = HeroDisplaySnapView.New(slot0.goSnapPanel_)
	slot0.shareView_ = QuizSceneShareView.New(slot0.goSharePanel_)
	slot0.chatStickerView_ = ChatStickerView.New(slot0.goSticker_)
	slot0.heroActionView_ = HeroActionView.New(slot0.goAction_)
	slot0.stickerBubbleView_ = StickerBubbleView.New(slot0.goBubble_)

	slot0.shareView_:ExitViewCallBack(function ()
		uv0:SetShareItem(true)
	end)
	QuizGameManager:InitSticker(slot0.stickerGo_)
end

function slot0.HeroIndexItem(slot0, slot1, slot2)
	slot0.curHeroID_ = uv0:GetCurHeroID()

	slot2:RefreshSelect(slot0.heroList_[slot1] == slot0.curHeroID_)
	slot2:RefreshUI(slot3)
end

function slot0.RankIndexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.rankList_[slot1], slot0.rankIndexList_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		uv0:SetShareItem(false)
		uv0.snapView_:Snap(function ()
			uv0.shareView_:OnSnape(true)
		end)
	end)
	slot0:AddBtnListener(slot0.stickerBtn_, nil, function ()
		if uv0.isStickering_ then
			return
		end

		if uv0.isStickerOn_ then
			uv0:HidePanel()
		elseif uv0.isActionOn_ then
			uv0:HidePanel()
			SetActive(uv0.hideGo_, true)
			uv0.chatStickerView_:Show(true)

			uv0.isStickerOn_ = true
		else
			SetActive(uv0.hideGo_, true)
			uv0.chatStickerView_:Show(true)

			uv0.isStickerOn_ = true
		end
	end)
	slot0:AddBtnListener(slot0.actionBtn_, nil, function ()
		if uv0.isActioning_ then
			return
		end

		if uv0.isActionOn_ then
			uv0:HidePanel()
		elseif uv0.isStickerOn_ then
			uv0:HidePanel()
			SetActive(uv0.hideGo_, true)
			uv0.heroActionView_:Show(true)

			uv0.isActionOn_ = true
		else
			SetActive(uv0.hideGo_, true)
			uv0.heroActionView_:Show(true)

			uv0.isActionOn_ = true
		end
	end)
	slot0:AddBtnListener(slot0.hideBtn_, nil, function ()
		uv0:HidePanel()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = PlayerData:GetPlayerInfo()
	slot0.userID_ = tostring(slot1.userID)
	slot0.nick_.text = slot1.nick
	slot0.activityID_ = slot0.params_.activityId
	slot0.cfg_ = ActivityQuizCfg[ActivityQuizCfg.get_id_list_by_activity_id[slot0.activityID_][1]]
	slot0.isStickering_ = false
	slot0.isActioning_ = false
	slot0.isStickerOn_ = false
	slot0.isActionOn_ = false
	slot0.sendStickerHandler_ = handler(slot0, slot0.OnSendSticker)

	manager.notify:RegistListener(CHAT_SEND_STICKER, slot0.sendStickerHandler_)
	slot0.shareView_:OnEnter()
	slot0.heroActionView_:OnEnter()
	slot0.chatStickerView_:OnEnter()
	slot0.stickerBubbleView_:OnEnter()

	slot0.hitCnt_ = 0

	slot0:RefreshWait()
end

function slot0.RefreshWait(slot0)
	SetActive(slot0.rankGo_, false)
	slot0:RefreshHeroList()
	slot0:StartWait()
end

function slot0.RefreshHeroList(slot0)
	slot0.heroList_ = slot0.cfg_.character_list

	slot0.heroScrollHelper_:StartScroll(#slot0.heroList_)
end

function slot0.StartWait(slot0)
	slot0:StopAllStateTimer()
	slot0.stateCon_:SetSelectedState("wait")
	slot0.quizHitCon_:SetSelectedState("false")

	slot0.waitCnt_.text = string.format(GetTips("ACTIVITY_QUIZ_SELECT"), uv0:GetCurStateEndTime() - manager.time:GetServerTime())
	slot0.waitTimer_ = Timer.New(function ()
		uv0 = uv1 - manager.time:GetServerTime()
		uv2.waitCnt_.text = string.format(GetTips("ACTIVITY_QUIZ_SELECT"), uv0)

		if uv0 <= 0 then
			uv2:StopWaitTimer()
		end
	end, 0.5, -1)

	slot0.waitTimer_:Start()
end

function slot0.OnQuizStartPrologue(slot0)
	slot0:StopAllStateTimer()
	slot0.stateCon_:SetSelectedState("prologue")

	slot0.prologue_.text = GetTips("ACTIVITY_QUIZ_PROLOGUE")
	slot0.prologueTime_.text = math.max(uv0:GetCurStateEndTime() - manager.time:GetServerTime() - 1, 0) .. "s"
	slot0.prologueTimer_ = Timer.New(function ()
		uv0 = uv1 - manager.time:GetServerTime()
		uv2.prologueTime_.text = math.max(uv0 - 1, 0) .. "s"

		if uv0 == 1 then
			uv2.stateCon_:SetSelectedState("afterPrologue")
		elseif uv0 <= 0 then
			uv2:StopPrologueTimer()
		end
	end, 0.5, -1)

	slot0.prologueTimer_:Start()
end

function slot0.OnQuizRefreshQuestion(slot0)
	slot0:StopAllStateTimer()
	slot0.stateCon_:SetSelectedState("answer")
	slot0.quizChoiceCon_:SetSelectedState("none")
	slot0.quizResultCon_:SetSelectedState("none")
	slot0.quizStateCon_:SetSelectedState("now")
	slot0.quizAnsCon_:SetSelectedState("none")
	slot0.quizAppearAni_:Play("Fx_answertext_cx", -1, 0)

	if slot0.hitCnt_ <= 1 then
		slot0.quizHitCon_:SetSelectedState("false")
	else
		slot0.hitAni_:Play("Fx_ComboBonus_xs", -1, 0)
	end

	SetActive(slot0.rankGo_, true)
	slot0:RefreshTitle()
	slot0:RefreshRank()
	slot0:RefreshQuizTime()
end

function slot0.RefreshTitle(slot0)
	slot2 = uv0:GetCurQuizIndex()
	slot3 = ActivityQuizTableCfg[uv0:GetCurQuizID()]
	slot4 = slot0.cfg_.quiz_zone[#slot0.cfg_.quiz_zone][1]
	slot0.index_.text = "<color=#FFD084>" .. slot2 .. "</color>" .. "/" .. slot4

	uv0:ResetRandSeed(uv0:GetRandSeed())
	uv0:SetRandList(#slot3.ans)

	slot6 = uv0:GetAnsList()
	slot0.ans_1.text = "A." .. slot3.ans[slot6[1]]
	slot0.ans_2.text = "B." .. slot3.ans[slot6[2]]
	slot0.quizDesc_.text = slot3.title
	slot0.score_.text = slot3.point
	slot0.textAni_.text = slot3.point

	if slot4 - slot2 < 3 then
		slot0.doubleAni_:Play("Fx_textScore_cx", -1, 0)
	end
end

function slot0.RefreshRank(slot0)
	slot0.rankList_ = uv0:GetPlayerList()

	slot0:SortRank()
	slot0.rankTypeCon_:SetSelectedState(#slot0.rankList_ > 1 and "multiplayer" or "solo")

	slot1 = table.indexof(slot0.rankList_, slot0.userID_)
	slot0.rankIndex_.text = slot0.rankIndexList_[slot1]
	slot0.rankScore_.text = uv0:GetRankData(slot0.userID_).score

	if slot0.rankIndexList_[slot1] > 3 then
		slot0.rankIndexCon_:SetSelectedState("other")
	else
		slot0.rankIndexCon_:SetSelectedState(slot0.rankIndexList_[slot1])
	end
end

function slot0.SortRank(slot0)
	table.sort(slot0.rankList_, function (slot0, slot1)
		return uv0:GetRankData(slot1).score < uv0:GetRankData(slot0).score
	end)

	slot1 = 1
	slot0.rankIndexList_ = {}

	for slot6, slot7 in ipairs(slot0.rankList_) do
		if uv0:GetRankData(slot7).score < uv0:GetRankData(slot0.rankList_[1]).score then
			slot2 = slot8.score
			slot1 = slot6
		end

		table.insert(slot0.rankIndexList_, slot1)
	end

	slot0.rankScrollHelper_:StartScroll(#slot0.rankList_)
end

function slot0.RefreshQuizTime(slot0)
	slot0.quizTime_.text = math.max(uv0:GetCurStateEndTime() - manager.time:GetServerTime(), 0) .. "s"
	slot0.quizTimer_ = Timer.New(function ()
		uv0 = uv1 - manager.time:GetServerTime()
		uv2.quizTime_.text = math.max(uv0, 0) .. "s"

		if uv0 <= 0 then
			uv2:StopQuizTimer()
		end
	end, 0.5, -1)

	slot0.quizTimer_:Start()
end

function slot0.OnRefreshAnswer(slot0)
	slot0:StopAllStateTimer()

	if uv0:GetCurQuizIndex() < slot0.cfg_.quiz_zone[#slot0.cfg_.quiz_zone][1] then
		slot0.stateCon_:SetSelectedState("answer")
	else
		slot0.stateCon_:SetSelectedState("beforeResult")
	end

	slot0.quizStateCon_:SetSelectedState("next")
	slot0.heroActionView_:RefreshList(uv0:GetCurResult())
	slot0.quizChoiceCon_:SetSelectedState(table.indexof(uv0:GetAnsList(), uv0:GetCurChoose()) == 1 and "A" or "B")

	if slot3 == 1 then
		slot0.hitCnt_ = slot0.hitCnt_ + 1

		slot0.quizResultCon_:SetSelectedState("correct")
		slot0.quizAnsCon_:SetSelectedState(slot6 == 1 and "A" or "B")
	else
		slot0.hitCnt_ = 0

		slot0.quizResultCon_:SetSelectedState("error")
		slot0.quizAnsCon_:SetSelectedState(slot6 == 1 and "B" or "A")
	end

	slot0:RefreshRank()
	slot0:RefreshHit()
	slot0:RefreshAnsTime()
end

function slot0.OnQuizChooseChange(slot0, slot1)
	if uv0:GetState() == 3 then
		slot0.quizChoiceCon_:SetSelectedState(slot1 == 1 and "A" or "B")
	end
end

function slot0.RefreshAnsTime(slot0)
	slot0.ansTime_.text = math.max(uv0:GetCurStateEndTime() - manager.time:GetServerTime(), 0) .. "s"
	slot0.ansTimer_ = Timer.New(function ()
		uv0 = uv1 - manager.time:GetServerTime()
		uv2.ansTime_.text = math.max(uv0, 0) .. "s"

		if uv0 <= 0 then
			uv2:StopAnsTimer()
		end
	end, 0.5, -1)

	slot0.ansTimer_:Start()
end

function slot0.RefreshHit(slot0)
	if slot0.hitCnt_ > 0 then
		manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_dadui_" .. (slot0.hitCnt_ > 5 and 5 or slot0.hitCnt_))
	end

	if slot0.hitCnt_ <= 1 then
		return
	end

	slot0.quizHitCon_:SetSelectedState("true")
	slot0.hitAni_:Play("Fx_correct_cx", -1, 0)

	slot0.hitTxt_.text = "x" .. slot0.hitCnt_ - 1
	slot0.addTxt_.text = "+" .. (GameSetting.combo_reward.value[slot0.hitCnt_ - 1] or slot1[#slot1])
end

function slot0.OnQuizFinishGame(slot0)
	gameContext:Go("/activityQuizSceneResult", {
		activityId = slot0.activityID_
	})
end

function slot0.OnSendSticker(slot0, slot1)
	slot0:HidePanel()
	slot0:StartStickerTimer()
	QuizGameManager:PlayLocalEmoji(slot1)
end

function slot0.StartStickerTimer(slot0)
	slot0:StopStickerTimer()
	SetActive(slot0.stickerCDGo_, true)

	slot0.isStickering_ = true
	slot1 = GameSetting.talk_time.value[1]
	slot0.stickerCD_.text = math.ceil(slot1) .. "s"
	slot0.stickerCDIcon_.fillAmount = slot1 / GameSetting.talk_time.value[1]
	slot0.stickerTimer_ = Timer.New(function ()
		uv0 = uv0 - 0.05
		uv1.stickerCD_.text = math.ceil(uv0) .. "s"
		uv1.stickerCDIcon_.fillAmount = uv0 / GameSetting.talk_time.value[1]

		if uv0 <= 0 then
			SetActive(uv1.stickerCDGo_, false)

			uv1.isStickering_ = false

			uv1:StopStickerTimer()
		end
	end, 0.05, -1)

	slot0.stickerTimer_:Start()
end

function slot0.OnQuizSendAction(slot0, slot1)
	slot0:HidePanel()
	slot0:StartActionTimer()
	QuizGameManager:PlayLocalGesture(slot1)
end

function slot0.StartActionTimer(slot0)
	slot0:StopActionTimer()
	SetActive(slot0.actionCDGo_, true)

	slot0.isActioning_ = true
	slot1 = GameSetting.action_time.value[1]
	slot0.actionCD_.text = math.ceil(slot1) .. "s"
	slot0.actionCDIcon_.fillAmount = slot1 / GameSetting.action_time.value[1]
	slot0.actionTimer_ = Timer.New(function ()
		uv0 = uv0 - 0.05
		uv1.actionCD_.text = math.ceil(uv0) .. "s"
		uv1.actionCDIcon_.fillAmount = uv0 / GameSetting.talk_time.value[1]

		if uv0 <= 0 then
			SetActive(uv1.actionCDGo_, false)

			uv1.isActioning_ = false

			uv1:StopActionTimer()
		end
	end, 0.05, -1)

	slot0.actionTimer_:Start()
end

function slot0.OnPlaySticker(slot0, slot1, slot2)
	slot0.stickerBubbleView_:RefreshBubbleView(slot1, slot2)
end

function slot0.HidePanel(slot0)
	SetActive(slot0.hideGo_, false)
	slot0.chatStickerView_:Show(false)
	slot0.heroActionView_:Show(false)

	slot0.isStickerOn_ = false
	slot0.isActionOn_ = false
end

function slot0.StopWaitTimer(slot0)
	if slot0.waitTimer_ then
		slot0.waitTimer_:Stop()

		slot0.waitTimer_ = nil
	end
end

function slot0.StopPrologueTimer(slot0)
	if slot0.prologueTimer_ then
		slot0.prologueTimer_:Stop()

		slot0.prologueTimer_ = nil
	end
end

function slot0.StopQuizTimer(slot0)
	if slot0.quizTimer_ then
		slot0.quizTimer_:Stop()

		slot0.quizTimer_ = nil
	end
end

function slot0.StopAnsTimer(slot0)
	if slot0.ansTimer_ then
		slot0.ansTimer_:Stop()

		slot0.ansTimer_ = nil
	end
end

function slot0.StopAllStateTimer(slot0)
	slot0:StopWaitTimer()
	slot0:StopPrologueTimer()
	slot0:StopQuizTimer()
	slot0:StopAnsTimer()
end

function slot0.StopStickerTimer(slot0)
	if slot0.stickerTimer_ then
		slot0.stickerTimer_:Stop()

		slot0.stickerTimer_ = nil
	end
end

function slot0.StopActionTimer(slot0)
	if slot0.actionTimer_ then
		slot0.actionTimer_:Stop()

		slot0.actionTimer_ = nil
	end
end

function slot0.OnQuizChangeHero(slot0)
	slot0.heroScrollHelper_:Refresh()
end

function slot0.OnQuizQuitPlayer(slot0)
	slot0:RefreshRank()
end

function slot0.SetShareItem(slot0, slot1)
	if slot1 then
		slot0:SetDefaultBar()
		SetActive(slot0.shareBtn_.gameObject, true)
	else
		manager.windowBar:HideBar()
		SetActive(slot0.shareBtn_.gameObject, false)
	end
end

function slot0.SetDefaultBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(ActivityQuizTools.GetHelpKey(slot0.activityID_))
	manager.windowBar:RegistBackCallBack(function ()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_QUIZ_QUIT"),
			OkCallback = function ()
				ActivityQuizAction.ExitRoom()
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.OnTop(slot0)
	slot0:SetShareItem(true)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(CHAT_SEND_STICKER, slot0.sendStickerHandler_)
	slot0.snapView_:OnExit()
	slot0.shareView_:OnExit()
	slot0.heroActionView_:OnExit()
	slot0.chatStickerView_:OnExit()
	slot0.stickerBubbleView_:OnExit()
	slot0:StopStickerTimer()
	slot0:StopAllStateTimer()
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.snapView_:Dispose()

	slot0.snapView_ = nil

	slot0.shareView_:Dispose()

	slot0.shareView_ = nil

	slot0.heroActionView_:Dispose()

	slot0.heroActionView_ = nil

	slot0.chatStickerView_:Dispose()

	slot0.chatStickerView_ = nil

	slot0.stickerBubbleView_:Dispose()

	slot0.stickerBubbleView_ = nil

	slot0.heroScrollHelper_:Dispose()
	slot0.rankScrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
