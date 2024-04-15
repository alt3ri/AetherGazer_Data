slot0 = class("XH3rdWaterReviewView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdWaterparkUI/XH3rdWPReviewUI"
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

	slot0.leftSelectController_ = ControllerUtil.GetController(slot0.leftRoleGo_.transform, "select")
	slot0.leftWinController_ = ControllerUtil.GetController(slot0.leftRoleGo_.transform, "win")
	slot0.rightSelectController_ = ControllerUtil.GetController(slot0.rightRoleGo_.transform, "select")
	slot0.rightWinController_ = ControllerUtil.GetController(slot0.rightRoleGo_.transform, "win")
	slot0.receiveController_ = ControllerUtil.GetController(slot0.receiveGo_.transform, "receive")
	slot0.historyList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uilistGo_, XH3rsWaterReviewItemView)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.historyDataList_[slot1], slot0.params_.activityID)
	slot2:RegisterClickListener(function (slot0, slot1)
		uv0:UpdateHistoryView(slot0, slot1)
		uv0.historyList_:Refresh()
	end)
	slot2:SetSelect(slot1 == slot0.curIndex_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityWaterAction.GetWinReward(uv0.data_.schedule_id)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ACTIVITY_WATER_WIN_REWARD_UPDATE, function ()
		if uv0.curIndex_ ~= nil then
			uv0:UpdateHistoryView(uv0.curIndex_, uv0.data_)
		end

		uv0.historyList_:Refresh()
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnWaterResult(slot0, slot1)
	JumpTools.OpenPageByJump("/xH3rdWaterResult", {
		activityID = slot1
	})
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.UpdateBar(slot0)
	slot3 = ShopListCfg[44].cost_id[1]

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		slot3
	})
	manager.windowBar:SetBarCanAdd(slot3, true)
	manager.windowBar:SetGameHelpKey("ACTIVITY_WATER_DESC")
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()

	slot0.historyDataList_ = ActivityWaterData:GetHistoryList(slot0.params_.activityID, true)

	table.sort(slot0.historyDataList_, function (slot0, slot1)
		return slot0.schedule_id < slot1.schedule_id
	end)
	slot0.historyList_:StartScroll(#slot0.historyDataList_)

	if #slot0.historyDataList_ > 0 then
		slot0:UpdateHistoryView(1, slot0.historyDataList_[1])
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.UpdateHistoryView(slot0, slot1, slot2)
	slot0.curIndex_ = slot1
	slot0.data_ = slot2
	slot3 = slot2.competition_list[1]
	slot4 = slot2.competition_list[2]
	slot9 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot3.competition_id].hero_id].hero_id]
	slot10 = HeroCfg[HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot4.competition_id].hero_id].hero_id]
	slot0.nameLabel1_.text = string.format("%s·%s", slot9.name, slot9.suffix)
	slot0.nameLabel2_.text = string.format("%s·%s", slot10.name, slot10.suffix)
	slot0.roleImage1_.sprite = ActivityWaterData:GetCompetitionImage(slot3.competition_id)

	slot0.roleImage1_:SetNativeSize()

	slot0.roleImage2_.sprite = ActivityWaterData:GetCompetitionImage(slot4.competition_id)

	slot0.roleImage2_:SetNativeSize()

	slot11, slot12 = nil

	if slot0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(slot0.params_.activityID).schedule_id then
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

	if slot2.selected_contestant_id == slot3.competition_id then
		slot0.leftSelectController_:SetSelectedState("yes")
		slot0.rightSelectController_:SetSelectedState("no")
	elseif slot2.selected_contestant_id == slot4.competition_id then
		slot0.leftSelectController_:SetSelectedState("no")
		slot0.rightSelectController_:SetSelectedState("yes")
	else
		slot0.leftSelectController_:SetSelectedState("no")
		slot0.rightSelectController_:SetSelectedState("no")
	end

	if slot0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(slot0.params_.activityID).schedule_id then
		SetActive(slot0.receiveGo_, false)
		slot0.leftWinController_:SetSelectedState("no")
		slot0.rightWinController_:SetSelectedState("no")
	else
		SetActive(slot0.receiveGo_, slot2.is_success and slot0.data_.is_success > 0)

		slot14 = nil

		if slot12 < slot11 then
			slot0.leftWinController_:SetSelectedState("yes")
			slot0.rightWinController_:SetSelectedState("no")

			slot14 = string.format("%s·%s", slot9.name, slot9.suffix)
		elseif slot11 == slot12 then
			slot0.leftWinController_:SetSelectedState("draw")
			slot0.rightWinController_:SetSelectedState("draw")

			if slot2.selected_contestant_id == slot3.competition_id then
				slot14 = string.format("%s·%s", slot9.name, slot9.suffix)
			elseif slot2.selected_contestant_id == slot4.competition_id then
				slot14 = string.format("%s·%s", slot10.name, slot10.suffix)
			end
		else
			slot0.leftWinController_:SetSelectedState("no")
			slot0.rightWinController_:SetSelectedState("yes")

			slot14 = string.format("%s·%s", slot10.name, slot10.suffix)
		end

		slot0.rewardTipLabel_.text = string.format(GetTips("ACTIVITY_WATER_TIP_REWARD_FROM"), slot14)

		if ActivityWaterData:HaveGotHistoryReward(slot2.schedule_id) then
			slot0.receiveController_:SetSelectedState("yes")
		else
			slot0.receiveController_:SetSelectedState("no")
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rewardContainer_)
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.historyList_ then
		slot0.historyList_:Dispose()

		slot0.historyList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
