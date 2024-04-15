slot0 = class("SPHeroChallengeMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.scheduleList = {}

	for slot4 = 1, SpHeroChallengeConst.scheduleNum do
		slot0.scheduleList[slot4] = SPHeroChallengeScheduleItem.New(slot0["scheduleitem" .. slot4 .. "Btn_"].gameObject)
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitController()

	slot0.timeLine1 = slot0.gameObject_:GetComponent("PlayableDirector")
	slot0.timeLine2 = slot0.canvasGo_:GetComponent("PlayableDirector")
end

function slot0.FinPlayable(slot0)
	if slot0.timeLine1 then
		slot0.timeLine1:Stop()
	end

	if slot0.timeLine2 then
		slot0.timeLine2:Stop()
	end
end

function slot0.InitController(slot0)
	slot0.entrustController = {}
	slot3 = SPHeroChallengeTools
	slot5 = slot3

	for slot5 = 1, slot3.GetMaxStartEntrustPosNum(slot5, SPHeroChallengeData:GetActivityID()) do
		slot0.entrustController[slot5] = slot0["entrust" .. slot5 .. "Con"]:GetController("State")
	end

	slot0.spAwardController = slot0.spAwardCon:GetController("chipState")
	slot0.scheduleController = slot0.scheduleCon:GetController("Finish")
	slot0.bossOpenController = slot0.bossopenCon:GetController("bossOpen")
	slot0.animator = slot0.middleGo_:GetComponent("Animator")
	slot0.scheduleSelectController = slot0.scheduleCon:GetController("Select")
	slot0.miniGameSelectController = slot0.entrustCon:GetController("Select")
	slot0.scheduleAniamtor = slot0.scheduleShowCon:GetComponent("Animator")
	slot0.miniGameAniamtor = slot0.miniGameCon:GetComponent("Animator")
end

function slot0.OnEnter(slot0)
	slot0.activityID = SPHeroChallengeData:GetActivityID()
	slot0.activityInfo = SPHeroChallengeData:GetCurActivityInfo()

	if slot0.activityInfo then
		slot0.scheduleInfo = slot0.activityInfo.curScheduleList
	end

	slot0.curButtonState = slot0.curButtonState or SPHeroChallengeData:GetPageState() or "schedule"
	slot0.isOpenFlag = true

	slot0:StartTimeLine()
	slot0:RegisterEvents()
	slot0:RefreshView()
	slot0:RefreshAutoInfo()
	slot0:RefreshBar()
	slot0:BindRedPonit()
	slot0:StartEnterTimer()
	slot0:RefreshSelectState()
end

function slot0.OnTop(slot0)
end

function slot0.StartTimeLine(slot0)
	if slot0.curButtonState == "schedule" then
		slot0.timeLine1:Play()
	else
		slot0.timeLine2:Play()
	end
end

function slot0.BindRedPonit(slot0)
	manager.redPoint:bindUIandKey(slot0.entrustBtn_.transform, RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST)
	manager.redPoint:bindUIandKey(slot0.heroChipBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroChipActivityID))
	manager.redPoint:bindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].taskActivityID))
end

function slot0.UnBindRedPonit(slot0)
	manager.redPoint:unbindUIandKey(slot0.entrustBtn_.transform, RedPointConst.SP_HERO_CHALLENGE_3_1_ENTRUST)
	manager.redPoint:unbindUIandKey(slot0.heroChipBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].heroChipActivityID))
	manager.redPoint:unbindUIandKey(slot0.taskBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, SPHeroChallengeData.activityCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].taskActivityID))
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_1, true)
	manager.windowBar:SetGameHelpKey(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].helpKey)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UnBindRedPonit()
	slot0:RemoveAllEventListener()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	AnimatorTools.Stop()
	slot0:FinPlayable()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.trainBtn_, nil, function ()
		if not uv0.playAnimation then
			JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
				groupIndex = SpHeroChallengeConst.ChapterType.story
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.shopBtn_, nil, function ()
		if uv0.activityID and not uv0.playAnimation then
			slot0 = SPHeroChallengeData.activityCfg[uv0.activityID].shopID

			JumpTools.GoToSystem("/activityShop", {
				shopId = slot0,
				showShops = {
					slot0
				}
			}, ViewConst.SYSTEM_ID.SHOP)
		end
	end)
	slot0:AddBtnListenerScale(slot0.heroChipBtn_, nil, function ()
		if uv0.activityID and not uv0.playAnimation then
			JumpTools.OpenPageByJump("spHeroChallengeHeroChipTaskView", {
				activityID = SPHeroChallengeData.activityCfg[uv0.activityID].heroChipActivityID
			})
		end
	end)
	slot0:AddBtnListenerScale(slot0.taskBtn_, nil, function ()
		if uv0.activityID and not uv0.playAnimation then
			JumpTools.OpenPageByJump("spHeroChallengeActivityTaskView", {
				activityID = SPHeroChallengeData.activityCfg[uv0.activityID].taskActivityID
			})
		end
	end)

	slot4 = slot0.scheduleBtn_

	slot0:AddBtnListenerScale(slot4, nil, function ()
		if uv0.curButtonState == "schedule" and uv0.activityInfo:CheckCurScheduleFinish() and not uv0.activityInfo:CheckDailyScheduleAwardReceived() then
			SPHeroChallengeAction:GetScheduleAward()

			return
		end

		if not uv0.playAnimation then
			if uv0.curButtonState == "schedule" then
				uv0:ShowBtnList("schedule", not uv0.isOpenFlag)
			else
				uv0:ExchangePosition()
			end
		end
	end)

	for slot4 = 1, SpHeroChallengeConst.scheduleNum do
		if not slot0.playAnimation then
			slot0:AddBtnListener(slot0["scheduleitem" .. slot4 .. "Btn_"], nil, function ()
				uv0:ClickScheduleItem(uv1)
			end)
		end
	end

	slot0:AddBtnListenerScale(slot0.miniGameBtn_, nil, function ()
		if not uv0.playAnimation then
			if uv0.curButtonState == "miniGame" then
				uv0:ShowBtnList("miniGame", not uv0.isOpenFlag)
			else
				uv0:ExchangePosition()
			end
		end
	end)
	slot0:AddBtnListenerScale(slot0.entrustBtn_, nil, function ()
		if not uv0.playAnimation then
			JumpTools.OpenPageByJump("/spHeroChallengeEntrustView")
		end
	end)
	slot0:AddBtnListenerScale(slot0.barbecueBtn_, nil, function ()
		if not uv0.playAnimation then
			SPHeroChallengeTools:JumpSystemByScheduleType(SpHeroChallengeConst.ScheduleSubType.barbuce, nil, uv0.curButtonState)
		end
	end)

	slot5 = nil

	function slot6()
		if not uv0.playAnimation then
			SPHeroChallengeTools:JumpSystemByScheduleType(SpHeroChallengeConst.ScheduleSubType.decode)
		end
	end

	slot0:AddBtnListenerScale(slot0.mysteryBtn_, slot5, slot6)

	for slot5, slot6 in ipairs({
		slot0.scheduleBtn_.gameObject,
		slot0.miniGameBtn_.gameObject,
		slot0.scorllbtnBtn_.gameObject
	}) do
		slot0:AddPressByTimeListener(slot6, 0.2, function ()
		end, function (slot0, slot1, slot2)
			if slot0 == uv0.scheduleBtn_.gameObject and uv0.curButtonState == "miniGame" then
				return
			end

			if slot0 == uv0.miniGameBtn_.gameObject and uv0.curButtonState == "schedule" then
				return
			end

			if not uv0.playAnimation then
				uv0:StartDrag()
			end
		end, function (slot0, slot1, slot2)
			uv0:EndDrag()
		end)
		slot0:AddDragListener(slot6, function ()
		end, function ()
			uv0:OnDrag()
		end, function ()
		end)
	end
end

function slot0.StartDrag(slot0)
	slot0.startPos = Vector2.New(Input.mousePosition.x, Input.mousePosition.y)
end

function slot0.EndDrag(slot0)
	slot0.startPos = nil
end

function slot0.OnDrag(slot0)
	if slot0.startPos and GameDisplayCfg.activity_hero_challenge_slide.value[1] < MathTools.GetDistance(slot0.startPos, Vector2.New(Input.mousePosition.x, Input.mousePosition.y)) then
		slot0.playAnimation = true

		if (slot0.startPos - slot1).y < 0 then
			if slot0.curButtonState == "schedule" then
				slot0.miniGameSelectController:SetSelectedState("closeTrain")
				slot0:ShowBtnList("schedule", false, function ()
					AnimatorTools.PlayAnimatorWithCallback(uv0.animator, "Fx_startScheduleList_counterclockwise", function ()
						uv0:ShowBtnList("miniGame", true)

						uv0.curButtonState = "miniGame"

						uv0:RefreshSelectState()
					end, false)
				end)
			else
				slot0:ShowBtnList("miniGame", false, function ()
					AnimatorTools.PlayAnimatorWithCallback(uv0.animator, "Fx_miniGameList_counterclockwise", function ()
						uv0:ShowBtnList("schedule", true)

						uv0.curButtonState = "schedule"

						uv0:RefreshSelectState()
					end, false)
				end)
			end
		elseif slot0.curButtonState == "schedule" then
			slot0.miniGameSelectController:SetSelectedState("closeTrain")
			slot0:ShowBtnList("schedule", false, function ()
				AnimatorTools.PlayAnimatorWithCallback(uv0.animator, "Fx_miniGameList_clockwise", function ()
					uv0:ShowBtnList("miniGame", true)

					uv0.curButtonState = "miniGame"

					uv0:RefreshSelectState()
				end, false)
			end)
		else
			slot0:ShowBtnList("miniGame", false, function ()
				AnimatorTools.PlayAnimatorWithCallback(uv0.animator, "Fx_startScheduleList_clockwise", function ()
					uv0:ShowBtnList("schedule", true)

					uv0.curButtonState = "schedule"

					uv0:RefreshSelectState()
				end, false)
			end)
		end

		slot0:EndDrag()
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_SCHEDULE, function ()
		uv0:RefreshView()
	end)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_GET_SCHEDULE_AWARD, function ()
		uv0:RefreshScheduleState()
	end)
	slot0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function ()
		uv0:RefreshHeroChipInfo()
	end)
	slot0:RegistEventListener(SP_HERO_CHALLENGE_SCHEDULE_CONFIRM, function ()
		uv0:RefreshView()
	end)
end

function slot0.Dispose(slot0)
	if slot0.scheduleList then
		for slot4, slot5 in pairs(slot0.scheduleList) do
			slot5:Dispose()
		end

		slot0.scheduleList = nil
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	AnimatorTools.Stop()
	slot0:FinPlayable()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshView(slot0)
	slot0:RefreshHeroChipInfo()
	slot0:RefreshButtonLayer()
	slot0:RefreshEntrustState()
	slot0:RefreshScheduleState()
	slot0:RefreshBossOpenState()
end

function slot0.RefreshAutoInfo(slot0)
	if SPHeroChallengeTools:ShowAutoScheduleTips(slot0.activityID) and manager.time:IsToday(getData("SPHeroChallenge", "AutoTime") or manager.time:GetServerTime()) then
		saveData("SPHeroChallenge", "AutoTime", manager.time:GetServerTime())
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_AUTO_TIPS"),
			OkCallback = function ()
				SPHeroChallengeTools:AutoChooseSchedule()
				SPHeroChallengeAction:ConfirmScheduleList(uv0.activityInfo:GetScheduleDailyList())
			end,
			CancelCallback = function ()
			end
		})
	end
end

function slot0.RefreshHeroChipInfo(slot0)
	slot1, slot2, slot3, slot4 = slot0.activityInfo:CheckCanGetHeroChipTaskAward()

	if slot2 then
		slot0.spAwardController:SetSelectedState("received")
	elseif slot4 < slot3 then
		slot0.spAwardController:SetSelectedState("unavaliable")
	else
		slot0.spAwardController:SetSelectedState("obtainable")
	end

	slot0.heroChipText.text = string.format(GetTips("ACTIVITY_HERO_CLUE_COLLECT"), tostring(slot4), tostring(slot3))
end

function slot0.RefreshBossOpenState(slot0)
	if ActivityData:GetActivityIsOpen(SPHeroChallengeData.activityCfg[slot0.activityID].bossActivityID) and slot0.activityInfo.bossStart then
		slot0.bossOpenController:SetSelectedState("open")
	else
		slot0.bossOpenController:SetSelectedState("close")
	end
end

function slot0.RefreshButtonLayer(slot0)
	if slot0.isOpenFlag then
		slot0:RefreshEntrustState()
		slot0:RefreshScheduleList()
	end
end

function slot0.ShowBtnList(slot0, slot1, slot2, slot3)
	slot0.playAnimation = true

	if slot1 == "schedule" then
		if slot2 then
			AnimatorTools.PlayAnimatorWithCallback(slot0.scheduleAniamtor, "Fx_activityHeroChallengeScheduleBtn_cx", function ()
				if uv0 then
					uv0()
				else
					uv1.playAnimation = false
				end
			end, false)
		else
			AnimatorTools.PlayAnimatorWithCallback(slot0.scheduleAniamtor, "Fx_activityHeroChallengeScheduleBtn_xs", function ()
				if uv0 then
					uv0()
				else
					uv1.playAnimation = false
				end
			end, false)
		end
	elseif slot1 == "miniGame" then
		if slot2 then
			AnimatorTools.PlayAnimatorWithCallback(slot0.miniGameAniamtor, "Fx_activityHeroChallengeMiniGameBtn_cx", function ()
				if uv0 then
					uv0()
				else
					uv1.playAnimation = false
				end
			end, false)
		else
			AnimatorTools.PlayAnimatorWithCallback(slot0.miniGameAniamtor, "Fx_activityHeroChallengeMiniGameBtn_xs", function ()
				if uv0 then
					uv0()
				else
					uv1.playAnimation = false
				end
			end, false)
		end
	end

	slot0.isOpenFlag = slot2

	slot0:RefreshButtonLayer()
end

function slot0.RefreshScheduleList(slot0)
	if slot0.scheduleList then
		for slot4, slot5 in pairs(slot0.scheduleList) do
			slot5:RefreshUI(slot4)
		end
	end
end

function slot0.RefreshEntrustState(slot0)
	slot1 = nil
	slot3 = SPHeroChallengeTools
	slot5 = slot3

	for slot5 = 1, slot3.GetMaxStartEntrustPosNum(slot5, slot0.activityID) do
		slot6 = SPHeroChallengeTools:GetEntrustPosState(slot0.activityID, slot5)

		if slot0.entrustController and slot0.entrustController[slot5] then
			slot0.entrustController[slot5]:SetSelectedState(slot6)

			if slot6 == SpHeroChallengeConst.EntrustPosState.empty or slot6 == SpHeroChallengeConst.EntrustPosState.fin then
				slot1 = SpHeroChallengeConst.EntrustPosState.empty
			end
		end
	end
end

function slot0.RefreshScheduleState(slot0)
	if slot0.activityInfo:CheckCurScheduleFinish() then
		if slot0.activityInfo:CheckDailyScheduleAwardReceived() then
			slot0.scheduleController:SetSelectedState("recived")
		else
			slot0.scheduleController:SetSelectedState("award")
		end
	else
		slot0.scheduleController:SetSelectedState("none")
	end
end

function slot0.ClickScheduleItem(slot0, slot1)
	if slot0.scheduleInfo and slot0.scheduleInfo[slot1] then
		if slot0.scheduleInfo[slot1].isFinish then
			return
		end

		SPHeroChallengeTools:JumpSystemByScheduleType(ActivityHeroChallengeScheduleCfg[slot0.scheduleInfo[slot1].scheduleID].server_type, true, slot0.curButtonState)
	else
		JumpTools.OpenPageByJump("/spHeroChallengeScheduleView")
	end
end

function slot0.StartEnterTimer(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.playAnimation = true
	slot0.timer = Timer.New(function ()
		uv0.timer:Stop()

		uv0.timer = nil
		uv0.playAnimation = false
	end, 1, 1)

	slot0.timer:Start()
end

function slot0.ExchangePosition(slot0)
	if slot0.curButtonState == "schedule" then
		slot0.miniGameSelectController:SetSelectedState("closeTrain")
		slot0:ShowBtnList("schedule", false, function ()
			uv0.playAnimation = true

			AnimatorTools.PlayAnimatorWithCallback(uv0.animator, "Fx_miniGameList_clockwise", function ()
				uv0:ShowBtnList("miniGame", true)

				uv0.curButtonState = "miniGame"

				uv0:RefreshSelectState()
			end, false)
		end)
	else
		slot0:ShowBtnList("miniGame", false, function ()
			uv0.playAnimation = true

			AnimatorTools.PlayAnimatorWithCallback(uv0.animator, "Fx_startScheduleList_clockwise", function ()
				uv0:ShowBtnList("schedule", true)

				uv0.curButtonState = "schedule"

				uv0:RefreshSelectState()
			end, false)
		end)
	end
end

function slot0.RefreshSelectState(slot0)
	if slot0.curButtonState == "schedule" then
		slot0.scheduleSelectController:SetSelectedState("Selected")

		if SPHeroChallengeTools:CheckBossActivityIsOpen() then
			slot0.miniGameSelectController:SetSelectedState("UnSelected")
		else
			slot0.miniGameSelectController:SetSelectedState("closeTrain")
		end
	else
		slot0.scheduleSelectController:SetSelectedState("UnSelected")
		slot0.miniGameSelectController:SetSelectedState("Selected")
	end
end

return slot0
