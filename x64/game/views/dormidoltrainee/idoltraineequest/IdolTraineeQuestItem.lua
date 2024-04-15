slot0 = class("IdolTraineeQuestItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.rewardItems_ = {}
	slot0.stateController_ = slot0.mainControllerEx_:GetController("state")
	slot0.typeController_ = slot0.mainControllerEx_:GetController("type")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.taskID_ then
			TaskAction:SubmitTask(uv0.taskID_)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1

	slot0.typeController_:SetSelectedState(AssignmentCfg[slot1].type == TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY and "day" or "week")

	slot3 = TaskData2:GetTaskComplete(slot1)

	if slot2.need < TaskData2:GetTaskProgress(slot1) then
		slot4 = slot2.need
	end

	slot0.desc_.text = slot2.desc
	slot0.slider_.value = slot4 / slot2.need
	slot0.progress_.text = string.format("%s/%s", slot4, slot2.need)

	if slot3 then
		slot0.stateController_:SetSelectedState("received")
	elseif slot2.need <= slot4 then
		slot0.stateController_:SetSelectedState("complete")
	else
		slot0.stateController_:SetSelectedState("unfinish")
	end

	for slot9, slot10 in ipairs(slot2.reward or {}) do
		slot11 = formatReward(slot10)
		slot12 = clone(ItemTemplateData)

		if slot0.rewardItems_[slot9] == nil then
			slot0.rewardItems_[slot9] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot9)])

			slot0.rewardItems_[slot9].ResetTransform = function ()
			end
		end

		slot12.id = slot11.id
		slot12.number = slot11.num
		slot12.timeValid = slot10.timeValid or 0
		slot12.completedFlag = slot0.taskComplete_
		slot12.clickFun = handler(slot0, slot0.OnClickCommonItem)

		slot0.rewardItems_[slot9]:SetData(slot12)
	end

	for slot9 = #slot2.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot9]:SetData(nil)
	end
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
	OperationRecorder.Record("task", "task_item")
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
