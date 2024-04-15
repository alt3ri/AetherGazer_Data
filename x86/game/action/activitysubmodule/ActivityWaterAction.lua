manager.net:Bind(68011, function (slot0)
	ActivityWaterData:InitFromServerData(slot0)

	if ActivityWaterData:HaveSelectAssistantRole(slot0.activity_id) then
		slot3 = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(slot0.activity_id).schedule_id].activity_id
		slot5, slot6 = ActivityWaterData:GetCanUseTrialList(ActivityCfg.get_id_list_by_sub_activity_list[slot3][1])

		BattleTeamData:SetHeroTrial(slot3, slot6)
		CooperationTools.RegisterInvitationValidation(slot3, function (slot0, slot1)
			if ActivityWaterData:GetCurrentAssistantRole(uv0) == 0 then
				return false
			end

			if #slot1 > 0 and slot2 == slot1[1].data then
				return true
			end

			return false
		end)
	end

	uv0.UpdateRedPoint()
end)
manager.net:Bind(68023, function (slot0)
	ActivityWaterData:OnChallengeSuccess(slot0.main_activity_id, slot0.settle_player_list)
end)
manager.net:Bind(65041, function (slot0)
	ActivityWaterData:OnVoteUpdate(slot0)
end)
manager.net:Bind(68025, function (slot0)
	manager.notify:CallUpdateFunc(XH3RD_WATER_RESULT, slot0.main_activity_id)
end)
manager.net:Bind(68027, function (slot0)
	ActivityWaterData:OnStageRefresh(slot0.activity_id, slot0.open_stage_id, slot0.open_online_stage_id)
end)

slot1 = nil

return {
	Init = function (slot0)
		uv0.activityId_ = slot0

		manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(slot0), slot0), {
			RedPointConst.ACTIVITY_WATER_OPENED,
			RedPointConst.ACTIVITY_WATER_ASSIGNMENT,
			RedPointConst.ACTIVITY_WATER_SELF_ASSISTANT,
			RedPointConst.ACTIVITY_WATER_TOTAL_ASSISTANT,
			RedPointConst.ACTIVITY_WATER_WIN_REWARD,
			RedPointConst.ACTIVITY_WATER_NEW_SCHEDULE,
			RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN
		})
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_WATER_ENTER_GROUP, {
			RedPointConst.ACTIVITY_WATER_SELF_ASSISTANT,
			RedPointConst.ACTIVITY_WATER_TOTAL_ASSISTANT,
			RedPointConst.ACTIVITY_WATER_NEW_SCHEDULE,
			RedPointConst.ACTIVITY_WATER_MULTIPLE_OPEN
		})
		uv0.UpdateRedPoint()
		uv0.StartTimer()
		manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function ()
			uv0.UpdateAssignmentRedPoint()
		end)
	end,
	StartTimer = function ()
		if uv0.timer_ == nil then
			uv0.timer_ = Timer.New(function ()
			end, 1, -1)
		end

		uv0.timer_:Start()
	end,
	StopTimer = function ()
		if uv0.timer_ then
			uv0.timer_:Stop()

			uv0.timer_ = nil
		end
	end,
	ReadActivityOpen = function ()
		saveData("activity_water_" .. uv0.activityId_, tostring(ActivityData:GetActivityData(uv0.activityId_).startTime), true)
		uv0.UpdateOpenRedPoint()
	end,
	UpdateRedPoint = function ()
		uv0.UpdateOpenRedPoint()
		uv0.UpdateAssignmentRedPoint()
		uv0.UpdateSelfContributeRedPoint()
		uv0.UpdateTotalContributeRedPoint()
		uv0.UpdateWinRedPoint()
		uv0.UpdateNewScheduleRedPoint()
	end,
	UpdateOpenRedPoint = function ()
		if not uv0.activityId_ then
			return
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			return
		end

		slot1 = false

		if ActivityData:GetActivityData(uv0.activityId_) and not getData("activity_water_" .. uv0.activityId_, tostring(slot0.startTime)) then
			slot1 = true
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_OPENED, slot1 and 1 or 0)
	end,
	UpdateAssignmentRedPoint = function ()
		slot0 = false

		for slot6, slot7 in ipairs(AssignmentCfg.get_id_list_by_activity_id[uv0.GetTaskActivityId()]) do
			slot8 = AssignmentCfg[slot7]

			if TaskData2:GetTask(slot7) then
				if slot8.need < TaskData2:GetTask(slot7).progress then
					slot10 = slot8.need
				end

				if TaskData2:GetTaskComplete(slot7) then
					-- Nothing
				elseif slot8.need <= slot10 then
					slot0 = true

					break
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_ASSIGNMENT, slot0 and 1 or 0)
	end,
	UpdateSelfContributeRedPoint = function ()
		slot0 = false
		slot1, slot2 = ActivityWaterData:GetCurrentContributeCfg(uv0.activityId_)

		if not slot2 and ActivityPointRewardCfg[slot1].need <= ActivityWaterData:GetCurrentSelfProgress(uv0.activityId_) then
			slot0 = true
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_SELF_ASSISTANT, slot0 and 1 or 0)
	end,
	UpdateTotalContributeRedPoint = function ()
		slot0 = false

		if ActivityWaterData:GetCurrentAssistantRole(uv0.activityId_) > 0 and ActivityWaterCompetitionCfg[slot1] then
			for slot8, slot9 in ipairs(slot2.process_reward) do
				if not ActivityWaterData:HaveGetTotalProgressReward(uv0.activityId_, slot9[1]) and slot9[1] <= ActivityWaterData:GetCurrentAssistantRoleProcess(uv0.activityId_) then
					slot0 = true
				end
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_TOTAL_ASSISTANT, slot0 and 1 or 0)
	end,
	UpdateWinRedPoint = function ()
		slot0 = false

		for slot5, slot6 in ipairs(ActivityWaterData:GetHistoryList(uv0.activityId_)) do
			if slot6.is_success > 0 and not ActivityWaterData:HaveGotHistoryReward(slot6.schedule_id) then
				slot0 = true
			end
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_WIN_REWARD, slot0 and 1 or 0)
	end,
	UpdateNewScheduleRedPoint = function ()
		if not uv0.activityId_ then
			return
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			return
		end

		slot0 = false

		if #ActivityWaterData:GetHistoryList(uv0.activityId_) > 0 and ActivityWaterData:IsFirstEnter(uv0.activityId_) then
			CustomLog.Log(debug.traceback(string.format("needRedPoint = true")))
		end

		manager.redPoint:setTip(RedPointConst.ACTIVITY_WATER_NEW_SCHEDULE, slot0 and 1 or 0)
	end,
	RequestCurrentSchedule = function (slot0)
		manager.net:SendWithLoadingNew(68012, {
			schedule_id = slot0
		}, 68013, uv0.OnRequestCurrentScheduleCallback)
	end,
	OnRequestCurrentScheduleCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityWaterData:OnClickEnd(ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[slot1.schedule_id].activity_id][1])
			uv0.UpdateNewScheduleRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	SelectAssistantRole = function (slot0, slot1)
		manager.net:SendWithLoadingNew(68014, {
			schedule_id = slot0,
			competition_id = slot1
		}, 68015, uv0.OnSelectAssistantRoleCallback)
	end,
	OnSelectAssistantRoleCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityWaterData:OnSelectAssistantRole(slot1.schedule_id, slot1.competition_id)

			slot2 = ActivityWaterCfg[slot1.schedule_id].activity_id
			slot4, slot5 = ActivityWaterData:GetCanUseTrialList(ActivityCfg.get_id_list_by_sub_activity_list[slot2][1])

			BattleTeamData:SetHeroTrial(slot2, slot5)
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetSelfAssistantReward = function (slot0, slot1, slot2)
		uv0 = slot2

		manager.net:SendWithLoadingNew(68016, {
			activity_id = slot0,
			reward_id_list = slot1
		}, 68017, uv1.OnGetSelfAssistantRewardCallback)
	end,
	OnGetSelfAssistantRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityWaterData:OnGetSelfAssistantReward(slot1.activity_id, slot1.reward_id_list)
			getReward2(slot0.reward_list)
			uv0.UpdateSelfContributeRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end

		uv1 = nil
	end,
	GetTotalAssistantReward = function (slot0, slot1, slot2, slot3)
		uv0 = slot3

		manager.net:SendWithLoadingNew(68018, {
			schedule_id = slot0,
			competition_id = slot1,
			reward_id_list = slot2
		}, 68019, uv1.OnGetTotalAssistantRewardCallback)
	end,
	OnGetTotalAssistantRewardCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityWaterData:OnGetTotalAssistantReward(slot1.schedule_id, slot1.competition_id, slot1.reward_id_list)
			getReward2(slot0.reward_list)
			uv0.UpdateTotalContributeRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end

		uv1 = nil
	end,
	GetWinReward = function (slot0)
		manager.net:SendWithLoadingNew(68020, {
			schedule_id = slot0
		}, 68021, uv0.OnCallback)
	end,
	OnCallback = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivityWaterData:OnGetWinReward(slot1.schedule_id)
			getReward2(slot0.reward_list)
			uv0.UpdateWinRedPoint()
		else
			ShowTips(GetTips(slot0.result))
		end
	end,
	GetTaskActivityId = function ()
		slot0 = nil

		for slot4, slot5 in ipairs(ActivityCfg[uv0.activityId_].sub_activity_list) do
			if ActivityCfg[slot5].activity_template == ActivityTemplateConst.TASK then
				slot0 = slot5

				break
			end
		end

		return slot0
	end
}
