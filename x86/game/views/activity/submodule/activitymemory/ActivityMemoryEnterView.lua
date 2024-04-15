slot0 = class("ActivityMemoryEnterView", ReduxView)

function slot0.UIName(slot0)
	return ActivityMemoryTools.GetEnterUIName(slot0.params_.activityID)
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

	slot0.taskItem_ = {}

	for slot5, slot6 in ipairs(SpringFestivalMemoryCfg.get_id_list_by_activity_id[slot0.params_.activityID]) do
		slot0.taskItem_[slot5] = ActivityMemoryTaskItem.New(slot0["taskItem_" .. slot5])

		slot0.taskItem_[slot5]:SetData(slot6, slot0.params_.activityID)
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.enterStoryBtn_, nil, function ()
		uv0:PlayStory(uv0.enterStoryID_)
	end)
	slot0:AddBtnListener(slot0.activityStoryBtn_, nil, function ()
		uv0:PlayStory(uv0.activityStoryID_)
	end)
	slot0:AddBtnListener(slot0.collectStoryBtn_, nil, function ()
		uv0:PlayStory(uv0.collectStoryID_)
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if ActivityMemoryTools.GetHelpKey(uv0.activityID_) ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(slot0),
				key = slot0
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_MEMORY_OPEN .. "_" .. slot0.activityID_, 0)
	saveData(RedPointConst.ACTIVITY_MEMORY_OPEN, tostring(slot0.activityID_), true)
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshTask))
end

function slot0.RefreshUI(slot0)
	slot0:RefreshData()
	slot0:RefreshTime()
	slot0:RefreshTask()
	slot0:RefreshStory()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot0.enterStoryID_ = ActivityMemoryTools.GetEnterCondition(slot0.activityID_)[2]
	slot0.activityStoryID_ = ActivityMemoryTools.GetActivityCondition(slot0.activityID_)[2]
	slot0.collectStoryID_ = ActivityMemoryTools.GetCollectCondition(slot0.activityID_)[2]
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeLabel_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			if uv0.startTime_ <= manager.time:GetServerTime() then
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot1 < slot0.stopTime_ then
		slot0.timeLabel_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			if uv0.stopTime_ <= manager.time:GetServerTime() then
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLabel_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTask(slot0)
	slot0.progress_ = 0
	slot1 = ActivityMemoryTools.GetTaskActivityID(slot0.activityID_)

	for slot6, slot7 in ipairs(SpringFestivalMemoryCfg.get_id_list_by_activity_id[slot0.activityID_]) do
		slot9 = SpringFestivalMemoryCfg[slot7].task_id

		if TaskData2:GetTask(slot9) and AssignmentCfg[slot9].need <= slot11.progress then
			slot0.progress_ = slot0.progress_ + 1
		end

		slot0.taskItem_[slot6]:RefreshUI()
	end

	slot0.progressTxt_.text = string.format(GetTips("SPRING_FESTIVAL_MEMORY"), slot0.progress_, #slot2)
end

function slot0.RefreshStory(slot0)
	SetActive(slot0.enterStoryBtn_.gameObject, slot0.enterStoryID_ and manager.story:IsStoryPlayed(slot0.enterStoryID_))
	SetActive(slot0.activityStoryBtn_.gameObject, slot0.activityStoryID_ and manager.story:IsStoryPlayed(slot0.activityStoryID_))
	SetActive(slot0.collectStoryBtn_.gameObject, slot0.collectStoryID_ and manager.story:IsStoryPlayed(slot0.collectStoryID_))
end

function slot0.PlayStory(slot0, slot1, slot2)
	manager.story:StartStoryById(slot1, function ()
		if uv0 then
			uv0()
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:RefreshStory()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:RemoveAllEventListener()

	for slot4, slot5 in ipairs(slot0.taskItem_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.taskItem_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
