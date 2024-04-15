slot0 = class("AnniversaryGiftView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0:UpdateItem()

	slot0.onSubmitResponse = handler(slot0, slot0.RefreshBtnState)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitResponse)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitResponse)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.UpdateItem(slot0)
	slot1 = AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_EXTRA_TASK][1]
	slot0.taskID_ = slot1
	slot2 = AssignmentCfg[slot1]

	if TaskData2:GetTask(slot1) == nil then
		return
	end

	slot0.cntText_.text = string.format("%s/%s", slot2.need < slot3.progress and slot2.need or slot3.progress, slot2.need)
	slot0.sliderImage_.fillAmount = slot3.progress / slot2.need

	slot0:RefreshBtnState()
end

function slot0.RefreshBtnState(slot0)
	slot1 = slot0.taskID_

	if TaskData2:GetTask(slot1).complete_flag == 0 then
		if AssignmentCfg[slot1].need <= slot3.progress then
			slot0.controller_:SetSelectedState("complete")
		else
			slot0.controller_:SetSelectedState("uncomplate")
		end
	elseif slot3.complete_flag >= 1 then
		slot0.controller_:SetSelectedState("finish")
	end
end

return slot0
