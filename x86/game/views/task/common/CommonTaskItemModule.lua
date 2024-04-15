slot0 = class("CommonTaskItemModule", ReduxView)

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
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	slot0.controller_ = slot0.allBtnController_:GetController("all")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if AssignmentCfg[uv0.taskID_].source then
			JumpTools.JumpToPage2(slot0.source)
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.goBtn_.onClick:RemoveAllListeners()
	slot0.receiveBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = GetI18NText(slot1.desc)

	for slot7, slot8 in ipairs(slot1.reward or {}) do
		if 0 + 1 > 3 then
			break
		end

		slot10 = rewardToItemTemplate(formatReward(slot8), slot0.itemData[slot7])
		slot11 = false

		if slot0.rewardItems_[slot7] == nil then
			slot0.rewardItems_[slot7] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot7)])
			slot11 = true
		end

		slot10.completedFlag = slot0.taskComplete_
		slot10.clickFun = handler(slot0, slot0.OnClickCommonItem)

		slot0.rewardItems_[slot7]:SetData(slot10)
	end

	for slot7 = #slot1.reward + 1, #slot0.rewardItems_ do
		if slot0.rewardItems_[slot7] then
			slot0.rewardItems_[slot7]:SetData(nil)
		end
	end
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.progressBar_.value = slot2 / slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.controller_:SetSelectedState("complete")
	elseif slot3 then
		slot0.controller_:SetSelectedState("receive")
	else
		slot0.controller_:SetSelectedState("go")
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
