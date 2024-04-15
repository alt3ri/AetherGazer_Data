slot0 = class("IndiaPuzzleNewTaskItem", ReduxView)
slot1 = import("game.tools.JumpTools")

function slot0.OnCtor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot2
	slot0.taskID_ = slot1
	slot0.taskProgress = TaskData2:GetTaskProgress(slot1)
	slot0.taskComplete_ = TaskData2:GetTaskComplete(slot1)

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTaskList({
			uv0.taskID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot0.desc_.text = AssignmentCfg[slot0.taskID_].desc

	slot0:RefreshReward()
	slot0:RefreshType()
	slot0:RefreshProgress()
end

function slot0.RefreshReward(slot0)
	slot0.rewardCfg_ = AssignmentCfg[slot0.taskID_].reward[1]

	if slot0.commonItem_ == nil then
		go = Object.Instantiate(slot0.rewardItem_, slot0.rewardParent_)
		slot0.commonItem_ = CommonItem.New(go)
	end

	slot0.commonItem_:RefreshData(formatReward(slot0.rewardCfg_))
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.rewardCfg_)
	end)
	slot0.commonItem_:Show(true)
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.slider_.value = slot2 / slot1.need
	slot0.progress_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ == true then
		slot0.controller_:SetSelectedState("received")
	elseif slot3 then
		slot0.controller_:SetSelectedState("complete")
	else
		slot0.controller_:SetSelectedState("unfinish")
	end
end

function slot0.RefreshType(slot0)
	if AssignmentCfg[slot0.taskID_].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeController_:SetSelectedState("normal")
	else
		slot0.typeController_:SetSelectedState("challenge")
	end
end

return slot0
