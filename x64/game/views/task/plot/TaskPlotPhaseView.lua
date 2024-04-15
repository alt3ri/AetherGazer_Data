slot0 = class("TaskPlotPhaseView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.goRewardParent_ = {
		CommonItemView.New(slot0.goItem1_),
		CommonItemView.New(slot0.goItem2_),
		CommonItemView.New(slot0.goItem3_)
	}
	slot0.goItemTemplate_ = {
		clone(ItemTemplateData),
		clone(ItemTemplateData),
		clone(ItemTemplateData)
	}
	slot0.btnController = slot0.phaseController_:GetController("default0")

	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.awardBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.RefreshUI(slot0)
	slot0.taskID_ = TaskTools:GetPlotPhaseID()

	if slot0.taskID_ == nil then
		return
	end

	slot1 = TaskData2:GetTask(slot0.taskID_)
	slot3 = slot1.progress

	if slot1.complete_flag >= 1 then
		SetActive(slot0.awardBtn_.gameObject, false)
		SetActive(slot0.activeAnimator_, false)

		slot3 = AssignmentCfg[slot0.taskID_].need

		slot0.btnController:SetSelectedState("1")
	elseif slot3 < slot2.need then
		SetActive(slot0.awardBtn_.gameObject, false)
		SetActive(slot0.activeAnimator_, false)
		slot0.btnController:SetSelectedState("1")
	else
		SetActive(slot0.awardBtn_.gameObject, true)
		SetActive(slot0.activeAnimator_, true)

		slot3 = slot2.need

		slot0.btnController:SetSelectedState("2")
	end

	slot0.imageProgress_.value = slot3 / slot2.need
	slot0.textNum_.text = string.format("<color=#FFA456><size=56>%s</size></color>/%s", slot3, slot2.need)
	slot0.textTitle_.text = GetI18NText(slot2.name)
	slot0.textContent_.text = GetI18NText(slot2.desc)

	slot0:RefreshReward(slot2.reward)
end

function slot0.RefreshReward(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot7 = formatReward(slot6)
		slot8 = slot0.goItemTemplate_[slot5]
		slot8.id = slot7.id
		slot8.number = slot7.number
		slot8.timeValid = slot6.timeValid or 0
		slot8.completedFlag = TaskData2:GetTaskComplete(slot0.taskID_)
		slot8.clickFun = handler(slot0, slot0.OnClickCommonItem)

		slot0.goRewardParent_[slot5]:SetData(slot8)
	end

	for slot5 = #slot1 + 1, 3 do
		slot0.goRewardParent_[slot5]:SetData(nil)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.goRewardParent_) do
		slot5:Dispose()
	end

	slot0.goRewardParent_ = nil
end

function slot0.OnClickCommonItem(slot0, slot1)
	ShowPopItem(POP_ITEM, {
		slot1.id,
		slot1.number
	})
end

return slot0
