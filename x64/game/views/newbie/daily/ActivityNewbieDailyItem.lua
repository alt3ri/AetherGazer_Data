slot0 = class("ActivityNewbieDailyItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = slot0.controllerExCollection_:GetController("state")
	slot0.lockTroller_ = ControllerUtil.GetController(slot0.transform_, "conName")
	slot0.countDownController_ = ControllerUtil.GetController(slot0.transform_, "countDown")
	slot0.parentWidth_ = slot0.transformParent_.rect.width / 2
	slot0.itemWidth_ = slot0.transform_.rect.width / 2
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
	uv0.super.Dispose(slot0)

	slot0.itemData_ = nil

	if slot0.rewardItem_ then
		slot0.rewardItem_:Dispose()

		slot0.rewardItem_ = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RegistListener(slot0, slot1)
	slot0.func_ = slot1
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.buttonReceive_, nil, function ()
		slot1 = AssignmentCfg[uv0.taskID_]

		if TaskData2:GetTask(uv0.taskID_) then
			if slot0.complete_flag >= 1 then
				return
			elseif slot0.progress < slot1.need then
				JumpTools.JumpToPage2(slot1.source)
			else
				TaskAction:SubmitTask(uv0.taskID_)
			end
		end
	end)

	slot0.onSubmitTaskResponseHandle_ = handler(slot0, slot0.onSubmitTaskResponse)

	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, slot0.onSubmitTaskResponseHandle_)
end

function slot0.onSubmitTaskResponse(slot0)
	slot0.controller_:SetSelectedState("2")

	if slot0.func_ then
		slot0.func_()
	end
end

function slot0.RefreshCountDown(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot3 = TaskData2:GetTask(AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][slot0.index_ - 1])

	if not TaskData2:GetTask(slot0.taskID_) and slot3 and slot3.complete_flag == 1 then
		slot0.countdownText_.text = tostring(manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime()))

		slot0.countDownController_:SetSelectedState("true")

		slot0.timer_ = Timer.New(function ()
			slot0 = manager.time:GetNextFreshTime() - manager.time:GetServerTime()
			uv0.countdownText_.text = tostring(manager.time:DescCDTime(slot0))

			if slot0 <= 0 then
				uv0:RefreshUI(uv0.index_)
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.countDownController_:SetSelectedState("false")
	end
end

function slot0.RefreshUI(slot0, slot1)
	slot0.index_ = slot1

	if slot1 < 10 then
		slot0.textDay_.text = string.format("0<color=#3D3D3D>%s</color>", slot1)
	else
		slot0.textDay_.text = string.format("<color=#3D3D3D>%s</color>", slot1)
	end

	slot2 = AssignmentCfg.get_id_list_by_type[TaskConst.TASK_TYPE.DAILY_OFFER][slot1]

	if not slot0.itemData_ then
		slot0.itemData_ = clone(ItemTemplateData)

		function slot0.itemData_.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	end

	slot4 = AssignmentCfg[slot2].reward[1]
	slot0.itemData_.id = slot4[1]
	slot0.itemData_.number = slot4[2]

	if slot0.rewardItem_ == nil then
		slot0.rewardItem_ = CommonItemPool.New(slot0.itemParent_, slot0.itemData_)
	else
		slot0.rewardItem_:SetData(slot0.itemData_)
	end

	slot0.taskID_ = slot2
	slot5 = slot3.desc
	slot6 = nil
	slot7 = 0

	if TaskData2:GetTask(slot2) then
		if slot3.need < slot8.progress then
			slot7 = slot3.need
		end

		if slot8.complete_flag == 0 then
			if slot3.need <= slot7 then
				slot0.controller_:SetSelectedState("receive")
			else
				slot0.controller_:SetSelectedState("go")
			end
		else
			slot0.controller_:SetSelectedState("complete")

			slot7 = slot3.need
		end

		slot6 = string.format("%s/%s", slot7, slot3.need)

		slot0.lockTroller_:SetSelectedState("0")
	else
		slot0.controller_:SetSelectedState("0")
		slot0.lockTroller_:SetSelectedState("1")

		slot5 = ""
		slot6 = ""
	end

	slot0.textDesc_.text = slot5
	slot0.textProgress_.text = slot6

	slot0:RefreshCountDown()
end

function slot0.RefreshAlpha(slot0)
	slot0.canvasGroup_.alpha = 1 - math.abs(slot0.parentWidth_ - slot0.transformParent_:InverseTransformPoint(slot0.transform_:TransformPoint(Vector3.zero)).x - slot0.itemWidth_) / slot0.parentWidth_ * 0.5
end

return slot0
