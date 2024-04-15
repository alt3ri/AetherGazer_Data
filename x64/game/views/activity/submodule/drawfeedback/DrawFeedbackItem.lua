slot0 = class("DrawFeedbackItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.SetData(slot0, slot1)
	slot0.taskID_ = slot1
	slot2 = AssignmentCfg[slot1]
	slot0.descText_.text = GetI18NText(slot2.desc)
	slot0.cntText_.text = string.format("%s/%s", slot2.need < TaskData2:GetTask(slot1).progress and slot2.need or slot3.progress, slot2.need)
	slot0.sliderImage_.value = slot3.progress / slot2.need

	if not slot0.rewardItem_ then
		slot0.rewardItem_ = CommonItem.New(slot0.rewardGo_)
	end

	slot0.rewardItem_:RefreshData(formatReward(slot2.reward[1]))
	slot0.rewardItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.reward[1])
	end)
	slot0.rewardItem_:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
	slot0:RefreshBtnState()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.rewardItem_ then
		slot0.rewardItem_:Dispose()

		slot0.rewardItem_ = nil
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
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
