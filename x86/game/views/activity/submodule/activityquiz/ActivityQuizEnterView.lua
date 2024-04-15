slot0 = class("ActivityQuizEnterView", ReduxView)

function slot0.UIName(slot0)
	return ActivityQuizTools.GetEnterUIName(slot0.params_.activityID)
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
	slot0.clearCon_ = ControllerUtil.GetController(slot0.transform_, "clear")
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityQuizTaskItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1], slot0.activityID_)
	slot2:RefreshTime(manager.time:GetServerTime())
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if uv0:IsActivitying() and uv0:IsOpenTime() then
			ActivityQuizAction.StartMarch()
		end
	end)
	slot0:AddBtnListener(slot0.allReceiveBtn_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.list_) do
			if slot5.complete_flag < 1 and AssignmentCfg[slot5.id].need <= slot5.progress then
				table.insert(slot0, slot6)
			end
		end

		TaskAction:SubmitTaskList(slot0)
	end)
	slot0:AddBtnListener(slot0.tipBtn_, nil, function ()
		if ActivityQuizTools.GetHelpKey(uv0.activityID_) ~= "" then
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
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshTask))

	if slot0:IsOpenTime() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_QUIZ_OPEN .. "_" .. slot0.activityID_, 0)
		saveData("activity_quiz_enter", tostring(slot0.activityID_), manager.time:GetServerTime())
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshActivityData()
	slot0:RefreshTime()
	slot0:RefreshTask()
end

function slot0.RefreshActivityData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
	slot1 = GameSetting.activity_quiz_open_time.value
	slot0.closeTbl_ = slot1[2]
	slot0.openTbl_ = slot1[1]
	slot0.dayOpen_.text = string.format("%02d:%02d-%02d:%02d", slot0.openTbl_[1], slot0.openTbl_[2], slot0.closeTbl_[1], slot0.closeTbl_[2])
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.stateCon_:SetSelectedState("close")

		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			if uv0.startTime_ <= manager.time:GetServerTime() then
				uv0:StopTimer()
				uv0:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot1 < slot0.stopTime_ then
		slot0.stateCon_:SetSelectedState(slot0:IsOpenTime() and "unlock" or "close")

		slot0.timeLable_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()

			if uv1.stopTime_ <= uv0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			else
				uv1.stateCon_:SetSelectedState(uv1:IsOpenTime() and "unlock" or "close")

				uv1.timeLable_.text = manager.time:GetLostTimeStr2(uv1.stopTime_)
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLable_.text = GetTips("TIME_OVER")

		slot0.stateCon_:SetSelectedState("close")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshTask(slot0)
	slot1 = ActivityQuizTools.GetTaskActivityID(slot0.activityID_)
	slot3 = ActivityData:GetActivityData(slot1).subActivityIdList
	slot0.list_ = {}
	slot5 = {}

	for slot10, slot11 in pairs(TaskTools:GetActivityTaskList(slot1) or {}) do
		table.insert({}, slot11)
	end

	for slot10, slot11 in ipairs(slot3) do
		if ActivityData:GetActivityData(slot11):IsActivitying() then
			for slot17, slot18 in pairs(TaskTools:GetActivityTaskList(slot11) or {}) do
				table.insert(slot4, slot18)
			end
		else
			for slot17, slot18 in ipairs(AssignmentCfg.get_id_list_by_activity_id[slot11]) do
				table.insert(slot5, TaskData2:ParserData({
					complete_flag = 0,
					progress = 0,
					id = slot18
				}))
			end
		end
	end

	slot7 = {}
	slot8 = {}
	slot9 = {}

	for slot13, slot14 in pairs(slot4) do
		slot16 = AssignmentCfg[slot14.id]

		if slot14.complete_flag >= 1 then
			table.insert(slot9, slot14)
		elseif slot16.need <= slot14.progress then
			table.insert(slot7, slot14)
		else
			table.insert(slot8, slot14)
		end
	end

	function slot10(slot0, slot1)
		if AssignmentCfg[slot0.id].type ~= AssignmentCfg[slot1.id].type then
			return slot2.type < slot3.type
		end

		return slot0.id < slot1.id
	end

	table.sort(slot7, slot10)
	table.sort(slot8, slot10)
	table.sort(slot9, slot10)
	table.sort(slot5, slot10)
	table.insertto(slot0.list_, slot7)
	table.insertto(slot0.list_, slot8)
	table.insertto(slot0.list_, slot9)
	table.insertto(slot0.list_, slot5)
	slot0.scrollHelper_:StartScroll(#slot0.list_)

	if #slot7 > 0 then
		slot0.clearCon_:SetSelectedState("true")
	else
		slot0.clearCon_:SetSelectedState("false")
	end

	slot0:StartTaskTimer()
end

function slot0.StartTaskTimer(slot0)
	slot0:StopTaskTimer()

	slot0.taskTimer_ = Timer.New(function ()
		for slot4, slot5 in ipairs(uv0.scrollHelper_:GetItemList()) do
			slot5:RefreshTime(manager.time:GetServerTime())
		end
	end, 1, -1)

	slot0.taskTimer_:Start()
end

function slot0.StopTaskTimer(slot0)
	if slot0.taskTimer_ then
		slot0.taskTimer_:Stop()

		slot0.taskTimer_ = nil
	end
end

function slot0.IsActivitying(slot0)
	if manager.time:GetServerTime() < slot0.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot0.startTime_, nil, true)))

		return false
	end

	if slot0.stopTime_ <= slot1 then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function slot0.IsOpenTime(slot0)
	slot1 = manager.time:GetServerTime()
	slot2 = tonumber(manager.time:STimeDescS(slot1, "!%Y"))
	slot3 = tonumber(manager.time:STimeDescS(slot1, "!%m"))
	slot4 = tonumber(manager.time:STimeDescS(slot1, "!%d"))

	if manager.time:Table2ServerTime({
		year = slot2,
		month = slot3,
		day = slot4,
		hour = slot0.openTbl_[1],
		min = slot0.openTbl_[2],
		sec = slot0.openTbl_[3]
	}) <= slot1 and slot1 < manager.time:Table2ServerTime({
		year = slot2,
		month = slot3,
		day = slot4,
		hour = slot0.closeTbl_[1],
		min = slot0.closeTbl_[2],
		sec = slot0.closeTbl_[3]
	}) then
		return true
	end

	return false
end

function slot0.OnActivityQuizStartMarch(slot0)
	ActivityQuizTools.SetCurActivityID(slot0.activityID_)
	JumpTools.OpenPageByJump("activityQuizMatchPop", {
		activityId = slot0.activityID_
	})
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	slot0:StopTaskTimer()

	for slot4, slot5 in pairs(slot0.scrollHelper_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in pairs(slot0.scrollHelper_:GetItemList()) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
