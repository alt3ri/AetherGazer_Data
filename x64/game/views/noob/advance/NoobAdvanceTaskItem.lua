slot0 = class("NoobAdvanceTaskItem", ReduxView)
slot1 = {
	"receive",
	"go",
	"lock",
	"complete"
}

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.btnController_ = slot0.allBtnController_:GetController("all")
	slot0.rewardItems_ = {}
	slot0.itemDataList_ = {}
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if uv0.curState_ ~= uv1[2] then
			return
		end

		JumpTools.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.curState_ ~= uv1[1] then
			return
		end

		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.taskID_ = slot1
	slot0.maxRewardNum_ = slot2

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

	slot0.progressText_.text = string.format("%s/%s", slot3, slot2)
	slot0.progressBar_.value = slot3 / slot2
end

function slot0.RefreshReward(slot0, slot1)
	for slot6 = 1, 3 do
		slot7 = AssignmentCfg[slot1].reward[slot6]

		if not slot0.itemDataList_[slot6] then
			slot0.itemDataList_[slot6] = clone(ItemTemplateData)

			slot0.itemDataList_[slot6].clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot8 = true

		if slot7 then
			slot0.itemDataList_[slot6].id = slot7[1]
			slot0.itemDataList_[slot6].number = slot7[2]
			slot0.itemDataList_[slot6].grayFlag = slot0.curState_ == uv0[4]
			slot8 = false
		end

		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot6)])
		end

		slot0.rewardItems_[slot6]:Show(true)

		if not slot8 then
			slot0.rewardItems_[slot6]:SetData(slot0.itemDataList_[slot6])
		else
			slot0.rewardItems_[slot6]:SetData(nil)
		end
	end

	for slot6 = slot0.maxRewardNum_ + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.RefreshState(slot0)
	slot0.btnController_:SetSelectedState(slot0:GetItemState())
end

function slot0.GetItemState(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot3 = TaskData2:GetTask(slot0.taskID_).progress or 0

	if slot2.complete_flag >= 1 then
		slot0.curState_ = uv0[4]
	elseif slot3 < slot1.need then
		slot0.curState_ = uv0[2]
	else
		slot0.curState_ = uv0[1]
	end

	return slot0.curState_
end

return slot0
