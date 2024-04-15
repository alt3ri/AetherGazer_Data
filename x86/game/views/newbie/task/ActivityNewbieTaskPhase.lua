slot0 = class("ActivityNewbieTaskPhase", ReduxView)
slot1 = {
	"lock",
	"receive",
	"received"
}

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:BindCfgUI()
	slot0:AddListener()

	slot0.rewardItemList_ = {}
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot4 = slot0.onSubmitTaskResponseHandle_

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot4)

	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		slot0 = AssignmentCfg[uv0.taskID_]

		if TaskData2:GetAssignmentPhase() ~= slot1 or not (slot0.need <= TaskTools:GetNewbiePhaseTask()[slot0.phase].progress) then
			return
		end

		TaskAction:SubmitTask(uv0.taskID_)
	end)

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
end

function slot0.onSubmitTaskResponse(slot0)
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
	slot0.stateCon_:SetSelectedState("received")

	if TaskData2:GetAssignmentPhase() > #TaskTools:GetNewbiePhaseTask() then
		slot2 = #slot1
	end

	slot3 = 1

	for slot7 = 1, slot2 do
		if slot1[slot7].id then
			slot3 = slot7
		end
	end

	slot0:SetData(slot1[slot3].id)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshState()
	slot0:RefreshReward()
	slot0:RefreshProgress()
end

function slot0.RefreshState(slot0)
	if AssignmentCfg[slot0.taskID_] then
		slot3 = slot1.need <= TaskTools:GetNewbiePhaseTask()[slot1.phase].progress

		if slot2 < TaskData2:GetAssignmentPhase() then
			slot0.stateCon_:SetSelectedState("received")
		elseif TaskData2:GetAssignmentPhase() == slot2 and slot3 then
			slot0.stateCon_:SetSelectedState("receive")
		else
			slot0.stateCon_:SetSelectedState("lock")
		end
	end
end

function slot0.RefreshReward(slot0)
	if not slot0.taskID_ then
		return
	end

	if not AssignmentCfg[slot0.taskID_] then
		return
	end

	for slot6 = 1, 2 do
		slot0[string.format("textRewardCnt%s_", slot6)].text = string.format("x%s", AssignmentCfg[slot0.taskID_].reward[slot6][2])
	end
end

function slot0.RefreshProgress(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]

	if slot1.need < TaskTools:GetNewbiePhaseTask()[slot1.phase].progress then
		slot3 = slot2
	end

	if slot1.phase < TaskData2:GetAssignmentPhase() then
		slot3 = slot2
	end

	slot0.finishTasks_.text = slot3
	slot0.allTasks_.text = "/" .. slot2
end

return slot0
