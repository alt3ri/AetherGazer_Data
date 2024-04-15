slot0 = class("PolyhedronTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot2, slot1)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot0.itemDataList_ = {}
	slot0.rewardState_ = slot0.allBtnController_:GetController("all")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			uv0.taskID_
		})
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.itemDataList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.taskID_ = slot1
	slot0.maxRewardNum_ = slot2
	slot0.activityID_ = AssignmentCfg[slot0.taskID_].activity_id

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshDesc()
	slot0:RefreshItem()
	slot0:RefreshState()
	slot0:Show(true)
end

function slot0.RefreshDesc(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = GetI18NText(slot1.desc)
	slot4 = slot1.need

	if TaskData2:GetTask(slot0.taskID_) and slot3.progress and slot3.progress < slot2 then
		slot4 = slot3.progress
	end

	if slot2 < slot4 then
		slot4 = slot2 or slot4
	end

	slot0.progressBar_.value = slot4 / slot2
	slot0.progressText_.text = string.format("%s/%s", slot4, slot2)
end

function slot0.RefreshItem(slot0)
	slot0.rewardCfg_ = AssignmentCfg[slot0.taskID_].reward

	for slot4 = 1, slot0.maxRewardNum_ do
		slot5 = slot0.rewardCfg_[slot4]

		if not slot0.rewardItemList_[slot4] then
			slot0.rewardItemList_[slot4] = CommonItemView.New(slot0[string.format("awardItem%sObj_", slot4)])
		end

		slot0.rewardItemList_[slot4]:Show(true)

		if not slot0.itemDataList_[slot4] then
			slot0.itemDataList_[slot4] = clone(ItemTemplateData)

			slot0.itemDataList_[slot4].clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot6 = true

		if slot5 then
			slot0.itemDataList_[slot4].id = slot5[1]
			slot0.itemDataList_[slot4].number = slot5[2]
			slot6 = false
		end

		if not slot6 then
			slot0.rewardItemList_[slot4]:SetData(slot0.itemDataList_[slot4])
		else
			slot0.rewardItemList_[slot4]:SetData(nil)
		end
	end

	for slot4 = slot0.maxRewardNum_ + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot4]:Show(false)
	end
end

function slot0.RefreshState(slot0)
	slot4 = AssignmentCfg[slot0.taskID_].need

	if TaskData2:GetTask(slot0.taskID_) and slot3.progress then
		slot4 = slot3.progress
	end

	slot6 = TaskData2:GetTaskComplete(slot0.taskID_)

	if not (slot2 <= slot4) then
		slot0.rewardState_:SetSelectedState("go")
	elseif not slot6 then
		slot0.rewardState_:SetSelectedState("receive")
	else
		slot0.rewardState_:SetSelectedState("complete")
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
