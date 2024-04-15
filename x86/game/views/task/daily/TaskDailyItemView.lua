slot0 = class("TaskDailyItemView", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isShow_ = true

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.ReEnter(slot0, slot1)
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
	slot0.greyController = slot0.greyController_:GetController("grey")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "goBtn")
		uv1.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "receiveBtnBtn")
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

	for slot6, slot7 in ipairs(slot1.reward or {}) do
		slot8 = formatReward(slot7)
		slot9 = slot0.itemData[slot6]
		slot10 = false

		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot6)])

			slot0.rewardItems_[slot6].ResetTransform = function ()
			end

			slot10 = true
		end

		slot9.id = slot8.id
		slot9.number = slot8.num
		slot9.timeValid = slot7.timeValid or 0
		slot9.grayFlag = slot0.taskComplete_
		slot9.clickFun = handler(slot0, slot0.OnClickCommonItem)

		slot0.rewardItems_[slot6]:SetData(slot9)
	end

	for slot6 = #slot1.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:SetData(nil)
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

	if slot0.taskComplete_ then
		slot0.greyController:SetSelectedState("true")
	else
		slot0.greyController:SetSelectedState("false")
	end
end

function slot0.RefreshComplete(slot0)
end

function slot0.SetSibling(slot0, slot1)
	slot2 = AssignmentCfg[slot0.taskID_]
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
	OperationRecorder.Record("task", "task_item")
end

return slot0
