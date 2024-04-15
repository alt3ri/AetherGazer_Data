slot0 = class("XH3rdWaterMainItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.typeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.commonItem_ = CommonItem.New(slot0.rewardItem_)
end

function slot0.AddUIListener(slot0)
	slot0.commonItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityId_) then
			return
		end

		TaskAction:SubmitTask(uv0.assignmentId_)
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.assignmentId_ = slot2
	slot0.assignmentCfg_ = AssignmentCfg[slot2]
	slot0.activityId_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeController_:SetSelectedState("daily")
	elseif slot0.assignmentCfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE then
		slot0.typeController_:SetSelectedState("challenge")
	else
		slot0.typeController_:SetSelectedState("daily")
	end

	slot0.desc_.text = slot0.assignmentCfg_.desc
	slot2 = 0

	if TaskData2:GetTask(slot0.assignmentId_) then
		slot2 = slot1.progress
	end

	if slot0.assignmentCfg_.need < slot2 then
		slot2 = slot0.assignmentCfg_.need
	end

	slot0.slider_.value = math.min(1, slot2 / slot0.assignmentCfg_.need)
	slot0.progress_.text = slot2 .. "/" .. slot0.assignmentCfg_.need

	slot0.commonItem_:RefreshData(rewardToItemTemplate(formatReward(slot0.assignmentCfg_.reward[1])))

	if not ActivityData:GetActivityIsOpen(slot0.activityId_) then
		slot0.statusController_:SetSelectedState("gray")
	elseif slot1 ~= nil and TaskData2:GetTaskComplete(slot0.assignmentId_) then
		slot0.statusController_:SetSelectedState("received")
	elseif slot0.assignmentCfg_.need <= slot2 then
		slot0.statusController_:SetSelectedState("complete")
	else
		slot0.statusController_:SetSelectedState("unfinish")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
