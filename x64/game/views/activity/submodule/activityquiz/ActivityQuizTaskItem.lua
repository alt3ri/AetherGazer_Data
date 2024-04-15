slot0 = class("ActivityQuizTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.lockCon_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = AssignmentCfg[uv0.taskID_]

		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.info_ = slot1
	slot0.taskID_ = slot1.id
	slot0.activityID_ = slot2
	slot0.cfg_ = AssignmentCfg[slot0.taskID_]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
	slot0:RefreshTask()
	slot0:RefreshState()
end

function slot0.RefreshReward(slot0)
	for slot5, slot6 in ipairs(slot0.cfg_.reward) do
		if not slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

			slot0.rewardItems_[slot5]:UpdateCommonItemAni()
		end

		slot0.rewardItems_[slot5]:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot5]:Show(false)
	end
end

function slot0.RefreshTask(slot0)
	slot0.desc_.text = slot0.cfg_.desc
	slot1 = slot0.cfg_.need < slot0.info_.progress and slot0.cfg_.need or slot0.info_.progress
	slot0.progress_.text = slot1 .. "/" .. slot0.cfg_.need
	slot0.slider_.value = slot1 / slot0.cfg_.need

	if slot0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeCon_:SetSelectedState("daily")
	else
		slot0.typeCon_:SetSelectedState("challenge")
	end

	slot0.startTime_ = ActivityData:GetActivityData(slot0.cfg_.activity_id).startTime
end

function slot0.RefreshState(slot0)
	if slot0.info_.complete_flag >= 1 then
		slot0.stateCon_:SetSelectedState("received")
	elseif slot0.cfg_.need <= slot0.info_.progress then
		slot0.stateCon_:SetSelectedState("completed")
	else
		slot0.stateCon_:SetSelectedState("uncomplete")
	end
end

function slot0.RefreshTime(slot0, slot1)
	if slot0.startTime_ <= slot1 then
		slot0.lockCon_:SetSelectedState("false")

		return
	end

	slot0.lockCon_:SetSelectedState("true")

	slot0.timeLable_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot0.startTime_))
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.OnExit(slot0)
	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
