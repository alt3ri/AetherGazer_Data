slot0 = class("", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.btnController_ = slot0.controllerEx_:GetController("default0")
	slot0.rewardItemList_ = {}

	for slot5 = 1, 3 do
		slot0.rewardItemList_[slot5] = CommonItemView.New(slot0[string.format("rewardItem%s_", slot5)])
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.rewardIndex_ = slot1
	slot0.taskID_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.indexText_.text = string.format("%02d", slot0.rewardIndex_)
	slot0.indexText2_.text = string.format("%02d", slot0.rewardIndex_)
	slot0.progressCntText_.text = GetI18NText(slot1.desc)
	slot2 = TaskData2:GetTaskProgress(slot0.taskID_)
	slot3 = slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot3)
	slot0.progressBar_.value = slot2 / slot3

	if TaskData2:GetTaskComplete(slot0.taskID_) then
		slot0.btnController_:SetSelectedState("received")
	elseif slot3 <= slot2 then
		slot0.btnController_:SetSelectedState("clear")
	else
		slot0.btnController_:SetSelectedState("notclear")
	end

	slot0:RefreshItem(slot4)
end

function slot0.RefreshItem(slot0, slot1)
	for slot6, slot7 in pairs(AssignmentCfg[slot0.taskID_].reward) do
		slot8 = clone(ItemTemplateData)
		slot8.id = slot7[1]
		slot8.number = slot7[2]
		slot8.grayFlag = slot1 == true

		function slot8.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end

		slot0.rewardItemList_[slot6]:SetData(slot8)
	end

	for slot6 = #slot2.reward + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot6]:SetData(nil)
	end
end

return slot0
