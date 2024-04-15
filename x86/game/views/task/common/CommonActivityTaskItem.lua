slot0 = class("CommonActivityTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isShow_ = true

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.RefreshTaskItem(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.taskID_ = slot1
	slot0.taskProgress = TaskData2:GetTaskProgress(slot1)
	slot0.taskComplete_ = TaskData2:GetTaskComplete(slot1)

	slot0:RefreshProgress()
	slot0:RefreshUI()

	slot0.isShow_ = true
end

function slot0.OnExit(slot0)
	slot0.isShow_ = false
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		if slot5 then
			slot5:Dispose()
		end
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemData = {
		clone(ItemTemplateData)
	}
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.rewardModule = CommonItemView.New(slot0.rewardItem_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.btn_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.desc_.text = GetI18NText(slot1.desc)

	if (slot1.reward or {})[1] then
		slot4 = formatReward(slot3)
		slot5 = slot0.itemData[1]
		slot6 = false
		slot5.id = slot4.id
		slot5.number = slot4.number
		slot5.timeValid = slot3.time_valid or 0
		slot5.completedFlag = slot0.taskComplete_
		slot5.clickFun = handler(slot0, slot0.OnClickCommonItem)

		slot0.rewardModule:SetData(slot5)
	end

	if slot1.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeCon_:SetSelectedState("normal")
	else
		slot0.typeCon_:SetSelectedState("challenge")
	end
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.slider_.value = slot2 / slot1.need
	slot0.progress_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.controller_:SetSelectedState("received")
	elseif slot3 then
		slot0.controller_:SetSelectedState("complete")
	else
		slot0.controller_:SetSelectedState("unfinish")
	end
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return slot0
