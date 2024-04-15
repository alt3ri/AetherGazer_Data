slot0 = import("game.views.activity.Submodule.Xh3.water.programTasks.XH3rdWaterDialogTask")
slot1 = class("XH3rdWaterSelectAssistantView", ReduxView)
slot2 = 44

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPPlayUI"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.OnCtor(slot0)
end

function slot1.Init(slot0)
	slot0.dialogTask_ = uv0.New()

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.roleStatusController_ = ControllerUtil.GetController(slot0.characterContainer_, "roleStatus")
	slot0.btnStatusController_ = ControllerUtil.GetController(slot0.btnGo_.transform, "status")
	slot0.stageController_ = ControllerUtil.GetController(slot0.stageGo_.transform, "middle")
	slot0.backSelectController_ = ControllerUtil.GetController(slot0.notSelectBackGo_.transform, "select")
	slot0.frontSelectController_ = ControllerUtil.GetController(slot0.notSelectFrontGo_.transform, "select")
	slot0.haveSelectController_ = ControllerUtil.GetController(slot0.selectBtnGo_.transform, "select")
	slot0.contributeView_ = XH3rdWaterSelfContributeItemView.New(slot0.contributeGo_)
	slot0.rewardItems_ = {
		XH3rdWaterMainRewardItemView.New(slot0.reward1Go_),
		XH3rdWaterMainRewardItemView.New(slot0.reward2Go_),
		XH3rdWaterMainRewardItemView.New(slot0.reward3Go_),
		XH3rdWaterMainRewardItemView.New(slot0.reward4Go_)
	}
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.backSelectController_:GetSelectedState() == "none" then
			return
		end

		slot1, slot2 = nil

		if slot0 == "left" then
			slot1 = ActivityWaterData:GetCurrentCompetition(uv0.activityId_, 1).competition_id
			slot2 = ActivityWaterData:GetCurrentCompetition(uv0.activityId_, 2).competition_id
		else
			slot1 = ActivityWaterData:GetCurrentCompetition(uv0.activityId_, 2).competition_id
			slot2 = ActivityWaterData:GetCurrentCompetition(uv0.activityId_, 1).competition_id
		end

		slot4 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot1].hero_id].hero_id]
		slot6 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot2].hero_id].hero_id]
		slot7 = ActivityWaterData:GetCurrentSchedule(uv0.activityId_)

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("ACTIVITY_WATER_TIP_OPPOSITE_ROLE"), string.format("%s·%s", slot4.name, slot4.suffix), string.format("%s·%s", slot6.name, slot6.suffix)),
			OkCallback = function ()
				ActivityWaterAction.SelectAssistantRole(uv0.schedule_id, uv1)
			end
		})
	end)
	slot0:AddBtnListener(slot0.character1Btn_, nil, function ()
		if not ActivityWaterData:HaveSelectAssistantRole(uv0.activityId_) then
			uv0.dialogTask_:Disturb()
			uv0:UpdateSelect("left")
		else
			uv0.dialogTask_:NextSelectTalk()
		end
	end)
	slot0:AddBtnListener(slot0.character2Btn_, nil, function ()
		if not ActivityWaterData:HaveSelectAssistantRole(uv0.activityId_) then
			uv0.dialogTask_:Disturb()
			uv0:UpdateSelect("right")
		else
			uv0.dialogTask_:NextSelectTalk()
		end
	end)
	slot0:AddBtnListener(slot0.inviteBtn_, nil, function ()
		if manager.time:GetServerHour() < GameSetting.activity_water_online_open.value[1] or GameSetting.activity_water_online_open.value[2] <= slot0 then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
		})
	end)
	slot0:AddBtnListener(slot0.reviewBtn_, nil, function ()
		JumpTools.OpenPageByJump("/xH3rdWaterReview", {
			activityID = uv0.activityId_
		})
	end)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		JumpTools.GoToSystem("/activityShop", {
			shopId = uv0,
			showShops = {
				uv0
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, function ()
		if manager.time:GetServerHour() < GameSetting.activity_water_online_open.value[1] or GameSetting.activity_water_online_open.value[2] <= slot0 then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			slot2 = ActivityWaterData:GetCurrentScheduleActivityId(uv0.activityId_)
			slot3 = ActivityWaterData:GetOnlineStageId(uv0.activityId_)

			CooperationAction.StartMatching(slot3, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, slot3, slot2)
			}, slot2)
		end

		uv0:ShowMatching()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:HideMatching()
	end)
	slot0:AddBtnListener(slot0.roomBtn_, nil, function ()
		if manager.time:GetServerHour() < GameSetting.activity_water_online_open.value[1] or GameSetting.activity_water_online_open.value[2] <= slot0 then
			ShowTips("ACTIVITY_WATER_ONLINE_OPEN")

			return
		end

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			slot1 = ActivityWaterData:GetCurrentScheduleActivityId(uv0.activityId_)
			slot2 = ActivityWaterData:GetOnlineStageId(uv0.activityId_)

			CooperationAction.CreateRoom(slot2, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, {
				CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION, slot2, slot1)
			}, slot1)
		end
	end)
	slot0:AddBtnListener(slot0.assistanceBtn_, nil, function ()
		uv0.dialogTask_:Disturb()

		slot0 = ActivityWaterData:GetCurrentAssistantRoleStageId(uv0.activityId_)
		slot1 = XH3rdWaterSingleRoomProxy.New(slot0, BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER, ActivityWaterData:GetCurrentScheduleActivityId(uv0.activityId_))

		JumpTools.OpenPageByJump("/sectionSelectHero", {
			roomProxy = nil,
			section = slot0,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER,
			activityID = ActivityWaterData:GetCurrentScheduleActivityId(uv0.activityId_),
			mainActivityID = uv0.activityId_
		})
	end)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0.dialogTask_:Disturb()
	end)
	slot0.dialogTask_:SetOnDialogHandler(handler(slot0, slot0.OnSinglePlayerDialog), handler(slot0, slot0.OnSinglePlayerStop), handler(slot0, slot0.OnMultiPlayerDialog), handler(slot0, slot0.OnMultiPlayerStop))
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(ACTIVITY_WATER_COMPETITION_UPDATE, function (slot0)
		uv0:UpdateView()
	end)
	slot0:RegistEventListener(ACTIVITY_WATER_CLIENT_PROGRESS_UPDATE, function (slot0)
		if slot0 == uv0.activityId_ and ActivityWaterData:GetCurrentAssistantRole(uv0.activityId_) ~= nil and slot1 > 0 then
			uv0:UpdateSelectView()
		end
	end)
end

function slot1.OnCoopreationInvitUpdate(slot0)
	slot0:UpdateInvite()
end

function slot1.OnSinglePlayerDialog(slot0, slot1, slot2)
	SetActive(slot0.selfChatGo_, true)

	slot0.selfChatLabel_.text = ActivityWaterDialogCfg[slot2].dialog_content
end

function slot1.OnMultiPlayerDialog(slot0, slot1)
	if ActivityWaterDialogCfg[slot1].role_id == ActivityWaterCompetitionCfg[ActivityWaterData:GetCurrentSchedule(slot0.activityId_).competition_list[1].competition_id].hero_id then
		SetActive(slot0.chatGo1_, true)
		SetActive(slot0.chatGo2_, false)

		slot0.dialogText1_.text = slot2.dialog_content
	else
		SetActive(slot0.chatGo1_, false)
		SetActive(slot0.chatGo2_, true)

		slot0.dialogText2_.text = slot2.dialog_content
	end
end

function slot1.OnSinglePlayerStop(slot0)
	SetActive(slot0.selfChatGo_, false)
end

function slot1.OnMultiPlayerStop(slot0)
	SetActive(slot0.chatGo1_, false)
	SetActive(slot0.chatGo2_, false)
end

function slot1.OnTop(slot0)
	slot0:UpdateBar()

	if slot0.matchingTimer_ ~= nil then
		SetActive(slot0.popGo_, true)
	end
end

function slot1.OnBehind(slot0)
	manager.windowBar:HideBar()

	if slot0.matchingTimer_ ~= nil then
		SetActive(slot0.popGo_, false)
	end
end

function slot1.UpdateBar(slot0)
	slot2 = ShopListCfg[uv0].cost_id[1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot2
	})
	manager.windowBar:SetBarCanAdd(slot2, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function slot1.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
	slot0:UpdateTimer()
end

function slot1.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot1.UpdateTimer(slot0)
	slot0.lastdayText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.activityId_).stopTime)

	if ShopListCfg[uv0] then
		slot0.lastdaylabelText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot4.activity_id).stopTime)
	else
		slot0.lastdaylabelText_.text = slot3
	end

	slot0.assistlastdayText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(slot0.activityId_).schedule_id].activity_id).stopTime)
end

function slot1.ShowMatching(slot0)
	SetActive(slot0.popGo_, true)

	if slot0.matchingTimer_ == nil then
		slot0.matchingTimer_ = Timer.New(function ()
			uv0:OnMatchingTimer()
		end, 1, -1)
	end

	slot0.curMatchingSeconds_ = 0

	slot0.matchingTimer_:Start()

	slot0.secondLabel_.text = "0s"
end

function slot1.HideMatching(slot0)
	if slot0.matchingTimer_ then
		slot0.matchingTimer_:Stop()

		slot0.matchingTimer_ = nil
	end

	slot0.curMatchingSeconds_ = 0

	CooperationAction.CancelMatching()
	SetActive(slot0.popGo_, false)
end

function slot1.OnMatchingTimer(slot0)
	slot0.curMatchingSeconds_ = slot0.curMatchingSeconds_ + 1
	slot0.secondLabel_.text = slot0.curMatchingSeconds_ .. "s"
end

function slot1.OnEnter(slot0)
	slot0.activityId_ = slot0.params_.activityID
	slot4 = slot0.activityId_

	slot0.dialogTask_:Init(slot4)

	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:OnEnter()
	end

	slot0:AddEventListeners()
	slot0:UpdateView()
	slot0:UpdateInvite()

	if not ActivityWaterData:HaveSelectAssistantRole(slot0.activityId_) then
		slot0:UpdateSelect("none")
	end

	slot0:StartTimer()
	slot0.dialogTask_:OnEnter()

	if #ActivityWaterData:GetHistoryList(slot0.params_.activityID) > 0 and ActivityWaterData:IsFirstEnter(slot0.params_.activityID) then
		JumpTools.OpenPageByJump("/xH3rdWaterResult", {
			activityID = slot0.params_.activityID
		})
	end

	manager.redPoint:bindUIandKey(slot0.reviewBtn_.transform, RedPointConst.ACTIVITY_WATER_WIN_REWARD)
end

function slot1.OnExit(slot0)
	slot4 = slot0.reviewBtn_.transform
	slot5 = RedPointConst.ACTIVITY_WATER_WIN_REWARD

	manager.redPoint:unbindUIandKey(slot4, slot5)
	slot0.dialogTask_:OnExit()

	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:OnExit()
	end

	slot0:HideMatching()
	slot0:StopTimer()
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot1.OnWaterResult(slot0, slot1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = slot1
	})
end

function slot1.UpdateView(slot0)
	slot1 = ActivityWaterData:GetCurrentSchedule(slot0.activityId_)
	slot2 = slot1.competition_list[1]
	slot3 = slot1.competition_list[2]
	slot8 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot2.competition_id].hero_id].hero_id]
	slot9 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot3.competition_id].hero_id].hero_id]
	slot0.nameLabel1_.text = string.format("%s·%s", slot8.name, slot8.suffix)
	slot0.nameLabel2_.text = string.format("%s·%s", slot9.name, slot9.suffix)
	slot0.unselectNameLabel1_.text = string.format("%s·%s", slot8.name, slot8.suffix)
	slot0.unselectNameLabel2_.text = string.format("%s·%s", slot9.name, slot9.suffix)
	slot0.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(slot2.competition_id)

	slot0.roleImage1_:SetNativeSize()

	slot0.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(slot3.competition_id)

	slot0.roleImage2_:SetNativeSize()

	if ActivityWaterData:HaveSelectAssistantRole(slot0.activityId_) then
		slot0.contributeView_:SetData(slot0.activityId_)
		slot0.btnStatusController_:SetSelectedState("assistance")
		slot0.stageController_:SetSelectedState("select")
		slot0:UpdateSelectView()
	else
		slot0.btnStatusController_:SetSelectedState("select")
		slot0.stageController_:SetSelectedState("notselect")
	end
end

function slot1.UpdateClientProgress(slot0)
	slot1 = ActivityWaterData:GetClientProgress(slot0.activityId_)
	slot2 = slot1[1]
	slot3 = slot1[2]
	slot0.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(slot2)
	slot0.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(slot3)
	slot4 = ActivityWaterData:GetCurrentSchedule(slot0.activityId_)
	slot6 = ActivityWaterCompetitionCfg[slot4.competition_list[1].competition_id]
	slot8 = ActivityWaterCompetitionCfg[slot4.competition_list[2].competition_id]
	slot9 = math.max(slot6.process_reward[#slot6.process_reward][1], slot8.process_reward[#slot8.process_reward][1])

	slot0.progressTransform1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * slot2 / slot9 + 20)
	slot0.progressTransform2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * slot3 / slot9 + 20)
end

function slot1.UpdateSelect(slot0, slot1)
	slot0.dialogTask_:Disturb()
	slot0.backSelectController_:SetSelectedState(slot1)
	slot0.frontSelectController_:SetSelectedState(slot1)

	if slot1 == "none" then
		slot0.haveSelectController_:SetSelectedState("no")
		slot0.roleStatusController_:SetSelectedState("noselect_none")
	else
		slot0.haveSelectController_:SetSelectedState("yes")

		if slot1 == "left" then
			slot0.roleStatusController_:SetSelectedState("noselect_left")
		else
			slot0.roleStatusController_:SetSelectedState("noselect_right")
		end
	end
end

function slot1.UpdateSelectView(slot0)
	slot0.openareaText_.text = string.format("%d:00~%d:00", GameSetting.activity_water_online_open.value[1], GameSetting.activity_water_online_open.value[2])
	slot0.teamassisttipText_.text = GetTips("ACTIVITY_WATER_REWARD_MULTIPLE")
	slot0.singleassisttipText_.text = GetTips("ACTIVITY_WATER_REWARD_SINGLE")

	for slot7, slot8 in ipairs(ActivityWaterCompetitionCfg[ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_)].process_reward) do
		slot0.rewardItems_[slot7]:SetData(slot7, slot0.activityId_, slot8)
	end

	if ActivityWaterData:GetCurrentAssistantIndex(slot0.activityId_) == 1 then
		slot0.roleStatusController_:SetSelectedState("select_left")
		slot0.character1Btn_.gameObject.transform:SetAsLastSibling()
	elseif ActivityWaterData:GetCurrentAssistantIndex(slot0.activityId_) == 2 then
		slot0.roleStatusController_:SetSelectedState("select_right")
		slot0.character2Btn_.gameObject.transform:SetAsLastSibling()
	else
		slot0.roleStatusController_:SetSelectedState("noselect_none")
	end

	slot0:UpdateClientProgress()

	slot0.uplimitText_.text = string.format("%d/%d", ActivityWaterData:GetCurrentSelfProgress(slot0.activityId_), ActivityWaterData:GetMaxSelfProgress())
end

function slot1.UpdateInvite(slot0)
end

function slot1.OnMainHomeViewTop(slot0)
end

function slot1.UIBackCount(slot0)
	return 2
end

function slot1.Dispose(slot0)
	slot0:StopTimer()

	if slot0.contributeView_ then
		slot0.contributeView_:Dispose()

		slot0.contributeView_ = nil
	end

	if slot0.dialogTask_ then
		slot0.dialogTask_:Dispose()

		slot0.dialogTask_ = nil
	end

	if slot0.rewardItems_ then
		for slot4, slot5 in pairs(slot0.rewardItems_) do
			slot5:Dispose()
		end

		slot0.rewardItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
