slot0 = class("ActivityNoobTaskItem", ReduxView)
slot1 = {
	"lock",
	"receive",
	"go",
	"complete"
}

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.rewardItems_ = {}
end

function slot0.Dispose(slot0)
	slot4 = slot0.onSubmitTaskResponseHandle_

	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot4)

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
end

function slot0.onSubmitTaskResponse(slot0)
	ActivityNoobAction.RefreshAccumulateRedPoint()
	manager.notify:Invoke(NEWBIE_TASK_UPDATE)
	SendMessageManagerToSDK("task_finish", {
		taskId = slot0.taskID_
	})
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1

	slot0:RefreshTitle()
	slot0:RefreshProgress()
	slot0:RefreshState()
	slot0:RefreshReward(slot1)
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = GetI18NText(AssignmentCfg[slot0.taskID_].desc)
end

function slot0.RefreshProgress(slot0)
	if AssignmentCfg[slot0.taskID_].need < (TaskData2:GetTask(slot0.taskID_).progress or 0) then
		slot3 = slot2
	end

	slot0.needText_.text = string.format("/%s", slot2)
	slot0.progressText_.text = slot3
	slot0.progressSlider_.value = slot3 / slot2
end

function slot0.RefreshReward(slot0, slot1)
	for slot6, slot7 in ipairs(AssignmentCfg[slot1].reward) do
		slot8 = clone(ItemTemplateData)
		slot8.id = slot7[1]
		slot8.number = slot7[2]

		function slot8.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end

		if slot0.rewardItems_[slot6] == nil then
			slot9 = Object.Instantiate(slot0.itemGo_, slot0.rewardParent_)

			SetActive(slot9, true)

			slot0.rewardItems_[slot6] = CommonItemView.New(slot9)
		end

		slot0.rewardItems_[slot6]:SetData(slot8)
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.RefreshState(slot0)
	slot0.stateCon_:SetSelectedState(slot0:GetItemState())
end

function slot0.GetItemState(slot0)
	slot4 = TaskData2:GetTask(slot0.taskID_).progress or 0

	if ActivityNoobData:GetUnlockPhase() < AssignmentCfg[slot0.taskID_].phase then
		slot0.curState_ = uv0[1]
	elseif slot3.complete_flag >= 1 then
		slot0.curState_ = uv0[4]
	elseif slot4 < slot1.need then
		slot0.curState_ = uv0[3]
	else
		slot0.curState_ = uv0[2]
	end

	return slot0.curState_
end

return slot0
