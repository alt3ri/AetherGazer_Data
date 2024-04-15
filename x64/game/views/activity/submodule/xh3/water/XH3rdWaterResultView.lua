slot0 = class("XH3rdWaterResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPResult"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.leftSelectController_ = ControllerUtil.GetController(slot0.leftGo_.transform, "select")
	slot0.leftWinController_ = ControllerUtil.GetController(slot0.leftGo_.transform, "win")
	slot0.rightSelectController_ = ControllerUtil.GetController(slot0.rightGo_.transform, "select")
	slot0.rightWinController_ = ControllerUtil.GetController(slot0.rightGo_.transform, "win")
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		slot2 = {}

		for slot6, slot7 in ipairs(ActivityCfg[uv0.params_.activityID].sub_activity_list) do
			if ActivityCfg[slot7].activity_template == ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE then
				slot0 = 0 + 1

				table.insert(slot2, slot7)
			end
		end

		if table.indexof(slot2, ActivityWaterCfg[uv0.data_.schedule_id].activity_id) then
			if slot4 == #slot2 then
				JumpTools.OpenPageByJump("/activityMain_2_2", {
					activityID = ActivityCfg.get_id_list_by_sub_activity_list[uv0.params_.activityID][1],
					subActivityID = uv0.params_.activityID
				})
			else
				JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
					activityID = uv0.params_.activityID
				})
			end
		else
			JumpTools.OpenPageByJump("/cooperationBlank/xH3rdWaterSelectAssistant", {
				activityID = uv0.params_.activityID
			})
		end
	end)
	manager.windowBar:RegistHomeCallBack(function ()
		gameContext:Go("/home", nil, , true)
	end)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.historyDataList_ = ActivityWaterData:GetHistoryList(slot0.params_.activityID)

	table.sort(slot0.historyDataList_, function (slot0, slot1)
		return slot1.schedule_id < slot0.schedule_id
	end)

	slot0.data_ = slot0.historyDataList_[1]

	slot0:UpdateView()

	slot2 = 0

	if ActivityWaterData:GetCurrentSchedule(slot0.params_.activityID) then
		slot2 = slot1.schedule_id
	end

	if slot2 ~= 0 then
		ActivityWaterAction.RequestCurrentSchedule(slot2)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateView(slot0)
	slot1 = slot0.data_
	slot3 = slot1.competition_list[1]
	slot4 = slot1.competition_list[2]
	slot9 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot3.competition_id].hero_id].hero_id]
	slot10 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot4.competition_id].hero_id].hero_id]
	slot0.titleLabel_.text = string.format(GetTips("ACTIVITY_WATER_END_TITLE"), ActivityWaterCfg[slot0.data_.schedule_id].schedule_name)
	slot0.nameLabel1_.text = string.format("%s·%s", slot9.name, slot9.suffix)
	slot0.nameLabel2_.text = string.format("%s·%s", slot10.name, slot10.suffix)
	slot0.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(slot3.competition_id)

	slot0.roleImage1_:SetNativeSize()

	slot0.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(slot4.competition_id)

	slot0.roleImage2_:SetNativeSize()

	slot11, slot12 = nil

	if slot0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(slot0.params_.activityID) then
		slot13 = ActivityWaterData:GetClientProgress(slot0.params_.activityID)
		slot11 = slot13[1]
		slot12 = slot13[2]
	else
		slot11 = slot3.assistance_process
		slot12 = slot4.assistance_process
	end

	slot0.progressLabel1_.text = NumberTools.FormatNumberWithThousandsSeparator(slot11)
	slot0.progressLabel2_.text = NumberTools.FormatNumberWithThousandsSeparator(slot12)
	slot13 = math.max(slot5.process_reward[#slot5.process_reward][1], slot6.process_reward[#slot6.process_reward][1])

	slot0.progressBar1_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * slot11 / slot13 + 20)
	slot0.progressBar2_:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, 320 * slot12 / slot13 + 20)

	if slot1.is_success and slot1.is_success > 0 then
		slot16 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot1.selected_contestant_id].hero_id].hero_id]
		slot0.tipLabel_.text = string.format(GetTips("ACTIVITY_WATER_END_TIP"), PlayerData:GetPlayerInfo().nick, string.format("%s·%s", slot16.name, slot16.suffix))
	else
		slot0.tipLabel_.text = ""
	end

	if slot1.selected_contestant_id == slot3.competition_id then
		slot0.leftSelectController_:SetSelectedState("yes")
		slot0.rightSelectController_:SetSelectedState("no")
	elseif slot1.selected_contestant_id == slot3.competition_id then
		slot0.leftSelectController_:SetSelectedState("no")
		slot0.rightSelectController_:SetSelectedState("yes")
	else
		slot0.leftSelectController_:SetSelectedState("no")
		slot0.rightSelectController_:SetSelectedState("no")
	end

	if slot0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(slot0.params_.activityID).schedule_id then
		slot0.leftWinController_:SetSelectedState("no")
		slot0.rightWinController_:SetSelectedState("no")
	elseif slot12 < slot11 then
		slot0.leftWinController_:SetSelectedState("yes")
		slot0.rightWinController_:SetSelectedState("no")
	elseif slot11 == slot12 then
		slot0.leftWinController_:SetSelectedState("draw")
		slot0.rightWinController_:SetSelectedState("draw")
	else
		slot0.leftWinController_:SetSelectedState("no")
		slot0.rightWinController_:SetSelectedState("yes")
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
