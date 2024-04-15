slot0 = class("ActivityMemoryInfoView", ReduxView)

function slot0.UIName(slot0)
	return ActivityMemoryTools.GetInfoUIName(slot0.params_.activityId)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.rewardCon_ = {}
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction.SubmitTask(uv0.taskID_)
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot1 = ActivityData:GetActivityData(uv0.cfg_.activity_jump_id)
		slot3 = slot1.stopTime

		if manager.time:GetServerTime() < slot1.startTime then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		if slot3 <= slot4 then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.JumpToPage2(uv0.taskCfg_.source)
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
	slot0:RefreshReward()
	slot0:RefreshState()
	slot0:RegistEventListener(OSIRIS_TASK_UPDATE, handler(slot0, slot0.RefreshState))
end

function slot0.RefreshUI(slot0)
	slot0.id_ = slot0.params_.id
	slot0.activityID_ = slot0.params_.activityId
	slot0.cfg_ = SpringFestivalMemoryCfg[slot0.id_]
	slot0.taskID_ = slot0.cfg_.task_id
	slot0.taskCfg_ = AssignmentCfg[slot0.taskID_]
	slot1 = ActivityMemoryTools.GetTaskActivityID(slot0.activityID_)
	slot0.info_ = TaskData2:GetTask(slot0.taskID_)
	slot0.desc_.text = slot0.cfg_.des
	slot0.taskDes_.text = slot0.taskCfg_.desc
	slot0.icon_.sprite = getSpriteWithoutAtlas(slot0.cfg_.icon)
end

function slot0.RefreshState(slot0)
	if not slot0.info_ then
		slot0.progress_.text = 0 .. "/" .. slot0.taskCfg_.need

		slot0.stateCon_:SetSelectedState("unfinish")
	end

	slot0.progress_.text = (slot0.taskCfg_.need < slot0.info_.progress and slot0.taskCfg_.need or slot0.info_.progress) .. "/" .. slot0.taskCfg_.need

	if slot0.info_.complete_flag >= 1 then
		slot0.stateCon_:SetSelectedState("received")

		for slot5, slot6 in ipairs(slot0.rewardCon_) do
			slot0.rewardCon_[slot5]:SetSelectedState("true")
		end
	elseif slot0.taskCfg_.need <= slot0.info_.progress then
		slot0.stateCon_:SetSelectedState("complete")

		for slot5, slot6 in ipairs(slot0.rewardCon_) do
			slot0.rewardCon_[slot5]:SetSelectedState("false")
		end
	else
		slot0.stateCon_:SetSelectedState("unfinish")
		slot0.animator_:Play("IndiaRecallPopUI")

		for slot5, slot6 in ipairs(slot0.rewardCon_) do
			slot0.rewardCon_[slot5]:SetSelectedState("false")
		end
	end
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.taskCfg_.reward) do
		if not slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

			slot0.rewardItems_[slot5]:UpdateCommonItemAni()

			slot0.rewardCon_[slot5] = ControllerUtil.GetController(slot0.rewardItems_[slot5].transform_, "completed")
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()

	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}
	slot0.rewardCon_ = {}

	slot0.super.Dispose(slot0)
end

return slot0
