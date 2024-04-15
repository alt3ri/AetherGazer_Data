slot0 = class("HeroClueTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
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

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.taskID_ = slot1
	slot0.taskProgress_ = TaskData2:GetTask(slot1).progress
	slot0.taskComplete_ = TaskData2:GetTaskComplete(slot1)

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
	slot0:RefreshProgress()
	slot0:RefreshType()
	slot0:RefreshDesc()
end

function slot0.RefreshReward(slot0)
	slot2 = AssignmentCfg[slot0.taskID_].reward or {}

	for slot6, slot7 in ipairs(slot2) do
		if not slot0.rewardItems_[slot6] then
			slot8 = Object.Instantiate(slot0.rewardItem_, slot0.rewardParent_)

			SetActive(slot8, true)

			slot0.rewardItems_[slot6] = CommonItem.New(slot8)

			slot0.rewardItems_[slot6]:RegistCallBack(function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end)
		end

		slot0.rewardItems_[slot6]:RefreshData(formatReward(slot7))
	end

	for slot6 = #slot2 + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress_

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress_ then
		slot2 = slot1.need
	end

	if slot0.progressBar_ then
		slot0.progressBar_.value = slot2 / slot1.need
	end

	if slot0.progressText_ then
		slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	end

	slot3 = slot1.need <= slot0.taskProgress_

	if slot0.taskComplete_ == true then
		slot0.statusController_:SetSelectedState("received")
	elseif slot3 then
		slot0.statusController_:SetSelectedState("completed")
	else
		slot0.statusController_:SetSelectedState("uncomplete")
	end
end

function slot0.RefreshType(slot0)
	if slot0.typeController_ then
		if AssignmentCfg[slot0.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
			slot0.typeController_:SetSelectedState("daily")
		else
			slot0.typeController_:SetSelectedState("challenge")
		end
	end
end

function slot0.RefreshDesc(slot0)
	slot0.descText_.text = AssignmentCfg[slot0.taskID_].desc
end

return slot0
