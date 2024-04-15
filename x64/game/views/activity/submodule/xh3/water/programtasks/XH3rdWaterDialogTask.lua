slot0 = class("XH3rdWaterDialogTask")

function slot0.Init(slot0, slot1)
	slot0.activityId_ = slot1
	slot0.unSelectDialogGroupIndex_ = 0
	slot0.talkGroupIdList_ = {}

	if ActivityWaterData:GetCurrentSchedule(slot0.activityId_) then
		slot0.talkGroupIdList_ = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(slot0.activityId_).schedule_id].groups
	end
end

function slot0.StartDialogTimer(slot0)
	slot0:StopDialogTimer()

	slot0.selectDialogIndex_ = 0
	slot0.unselectDialogIndex_ = 0
	slot0.dialogTimer_ = Timer.New(function ()
		uv0:ShowDialog()
	end, 3, -1)

	slot0.dialogTimer_:Start()
	slot0:ShowDialog()
end

function slot0.StopDialogTimer(slot0)
	if slot0.dialogTimer_ then
		slot0.dialogTimer_:Stop()

		slot0.dialogTimer_ = nil
	end
end

function slot0.StartScheduleTimer(slot0)
	slot0:StopScheduleTimer()

	slot0.scheduleTimer_ = Timer.New(function ()
		if ActivityWaterData:GetCurrentAssistantRole(uv0.activityId_) == 0 then
			uv0.unSelectDialogGroupIndex_ = uv0.unSelectDialogGroupIndex_ % #ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(uv0.activityId_).schedule_id].groups + 1

			uv0:StartDialogTimer()
		end

		uv0:StopScheduleTimer()
	end, 30, 1)

	slot0.scheduleTimer_:Start()
end

function slot0.StopScheduleTimer(slot0)
	if slot0.scheduleTimer_ then
		slot0.scheduleTimer_:Stop()

		slot0.scheduleTimer_ = nil
	end
end

function slot0.SetOnDialogHandler(slot0, slot1, slot2, slot3, slot4)
	slot0.onSinglePlayerDialog_ = slot1
	slot0.onMultiPlayerDialog_ = slot3
	slot0.onSinglePlayerStop_ = slot2
	slot0.onMultiPlayerStop_ = slot4
end

function slot0.ShowDialog(slot0)
	if ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_) == 0 then
		slot0:NextUnSelectTalk()
	end
end

function slot0.NextSelectTalk(slot0)
	if not slot0.selectDialogGroup_ or ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_) ~= slot0.currentCompetitionId_ then
		slot0.currentCompetitionId_ = ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_)
		slot0.selectDialogGroup_ = ActivityWaterCompetitionCfg[slot0.currentCompetitionId_].dialog_group
		slot0.currentSelectDialogIdList_ = ActivityWaterDialogCfg.get_id_list_by_dialog_group[slot0.selectDialogGroup_]
	end

	if slot0.selectTimer_ then
		slot0.selectTimer_:Stop()
	end

	if not slot0.selectDialogIndex_ then
		slot0.selectDialogIndex_ = 0
	end

	slot0.selectDialogIndex_ = slot0.selectDialogIndex_ % #slot0.currentSelectDialogIdList_ + 1

	if slot0.onSinglePlayerDialog_ ~= nil then
		slot0.onSinglePlayerDialog_(ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_), slot0.currentSelectDialogIdList_[slot0.selectDialogIndex_])
	end

	slot0.selectTimer_ = TimeTools.StartAfterSeconds(3, function ()
		if uv0.onSinglePlayerStop_ ~= nil then
			uv0.onSinglePlayerStop_()
		end

		uv0.selectTimer_ = nil
	end, {})
end

function slot0.NextUnSelectTalk(slot0)
	if not slot0.unselectDialogGroup_ then
		slot0.unselectDialogGroup_ = ActivityWaterCfg[ActivityWaterData:GetCurrentSchedule(slot0.activityId_).schedule_id].groups[slot0.unSelectDialogGroupIndex_]
		slot0.currentUnselectDialogIdList_ = ActivityWaterDialogCfg.get_id_list_by_dialog_group[slot0.unselectDialogGroup_]
	end

	if not slot0.unselectDialogIndex_ then
		slot0.unselectDialogIndex_ = 0
	end

	if slot0.unselectDialogIndex_ >= #slot0.currentUnselectDialogIdList_ then
		if slot0.onMultiPlayerStop_ ~= nil then
			slot0.onMultiPlayerStop_()
		end

		slot0.unselectDialogIndex_ = 0

		slot0:StopDialogTimer()
		slot0:StartScheduleTimer()

		return
	end

	slot0.unselectDialogIndex_ = slot0.unselectDialogIndex_ + 1

	if slot0.onMultiPlayerDialog_ ~= nil then
		slot0.onMultiPlayerDialog_(slot0.currentUnselectDialogIdList_[slot0.unselectDialogIndex_])
	end
end

function slot0.OnEnter(slot0)
	if ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_) == 0 then
		slot0:StartScheduleTimer()
	end
end

function slot0.OnExit(slot0)
	if ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_) ~= 0 then
		if slot0.onSinglePlayerStop_ ~= nil then
			slot0.onSinglePlayerStop_()
		end
	elseif slot0.onMultiPlayerStop_ ~= nil then
		slot0.onMultiPlayerStop_()
	end

	slot0:StopDialogTimer()
	slot0:StopScheduleTimer()
end

function slot0.Disturb(slot0)
	if ActivityWaterData:GetCurrentAssistantRole(slot0.activityId_) ~= 0 then
		if slot0.onSinglePlayerStop_ ~= nil then
			slot0.onSinglePlayerStop_()
		end
	elseif slot0.onMultiPlayerStop_ ~= nil then
		slot0.onMultiPlayerStop_()
	end

	slot0:StopDialogTimer()
	slot0:StartScheduleTimer()
end

function slot0.Dispose(slot0)
	slot0:StopDialogTimer()
	slot0:StopScheduleTimer()
end

return slot0
