slot0 = class("ActivityReforgeTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.rewardItems_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	for slot4 = 1, 3 do
		slot0.rewardItems_[slot4] = CommonItemView.New(slot0["rewardItem" .. slot4 .. "_"])
	end

	slot0.statusController_ = slot0.controllerEx_:GetController("status")
	slot0.rewardNumController_ = slot0.controllerEx_:GetController("reward")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.SetData(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.taskID_ = slot1
	slot0.taskProgress = TaskData2:GetTaskProgress(slot1)
	slot0.taskComplete_ = TaskData2:GetTaskComplete(slot1)

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.descText_.text = GetI18NText(slot1.desc)
	slot2 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.statusController_:SetSelectedState("received")
	elseif slot2 then
		slot0.statusController_:SetSelectedState("complete")
	else
		slot0.statusController_:SetSelectedState("unfinish")
	end

	slot0.rewardNumController_:SetSelectedState(#(slot1.reward or {}))

	for slot7 = 1, 3 do
		if slot3[slot7] then
			slot10 = false
			slot11 = rewardToItemTemplate(formatReward(slot8))
			slot11.completedFlag = slot0.taskComplete_
			slot11.clickFun = handler(slot0, slot0.OnClickCommonItem)

			slot0.rewardItems_[slot7]:SetData(slot11)
		end
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
		if slot5 then
			slot5:Dispose()
		end
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
