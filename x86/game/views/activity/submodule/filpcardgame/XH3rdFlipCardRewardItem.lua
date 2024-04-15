slot0 = class("XH3rdFlipCardRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rewardListGo_, CommonItemView)
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.SetData(slot0, slot1)
	slot0.taskID = slot1
	slot0.cfg = AssignmentCfg[slot1]
	slot0.rewardCfg = slot0.cfg.reward
	slot0.activityID = slot0.cfg.activity_id

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID) then
			ShowTips("TIME_OVER")

			return
		end

		TaskAction:SubmitTask(uv0.taskID)
	end)

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshState()
	slot0:RefreshItem()
end

function slot0.RefreshState(slot0)
	slot3 = TaskData2:GetTaskComplete(slot0.taskID)

	if not (slot0.cfg.need <= TaskData2:GetTask(slot0.taskID).progress) then
		slot0.rewardState_:SetSelectedState("uncomplete")
	elseif not slot3 then
		slot0.rewardState_:SetSelectedState("complete")
	else
		slot0.rewardState_:SetSelectedState("received")
	end
end

function slot0.RefreshItem(slot0)
	slot1 = TaskData2:GetTask(slot0.taskID)
	slot0.text_.text = slot0.cfg.desc
	slot0.slider_.value = slot1.progress / slot0.cfg.need
	slot2 = nil
	slot0.sliderText_.text = ((slot0.cfg.need > slot1.progress or slot0.cfg.need) and slot1.progress) .. "/" .. slot0.cfg.need

	slot0.itemList_:StartScroll(#slot0.rewardCfg)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.rewardCfg[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3[1]
	slot4.number = slot3[2]

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)

	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	slot0.onReceived_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetReveivedHandler(slot0, slot1)
	slot0.onReceived_ = slot1
end

function slot0.onSubmitTaskResponse(slot0)
	slot0:RefreshState()

	if slot0.onReceived_ ~= nil then
		slot0.onReceived_()
	end
end

return slot0
