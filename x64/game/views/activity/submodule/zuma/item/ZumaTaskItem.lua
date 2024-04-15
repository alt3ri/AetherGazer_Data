slot0 = class("ZumaTaskItem", ReduxView)
slot1 = {
	showState = {
		received = "received",
		name = "state",
		unfinish = "unfinish",
		complete = "complete"
	}
}

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.showStateController = slot0.controllerexcollection_:GetController(uv0.showState.name)

	slot0:AddBtnListener(slot0.btn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskData.id)
	end)

	slot0.rewardItemList = {}
end

function slot0.SetData(slot0, slot1)
	slot0.taskData = slot1

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot1 = slot0.taskData
	slot0.desc_.text = AssignmentCfg[slot1.id].desc

	if slot1.complete_flag == 1 then
		slot0.showStateController:SetSelectedState(uv0.showState.received)
	elseif slot3.need <= slot1.progress then
		slot0.showStateController:SetSelectedState(uv0.showState.complete)
	else
		slot0.showStateController:SetSelectedState(uv0.showState.unfinish)
	end

	slot1.progress = slot1.progress
	slot0.sliderSlr_.value = slot1.progress / slot3.need
	slot0.sliderTxt_.text = string.format("%s/%s", math.min(slot1.progress, slot3.need), slot3.need)

	slot0:RefreshRewardList(slot3.reward)
end

function slot0.RefreshRewardList(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if not slot0.rewardItemList[slot5] then
			slot0.rewardItemList[slot5] = CommonItemView.New(Object.Instantiate(slot0.rewardItem_, slot0.rewardParent_))
		end

		slot7 = clone(ItemTemplateData)
		slot7.id = slot6[1]
		slot7.number = slot6[2]

		function slot7.clickFun()
			ShowPopItem(POP_ITEM, {
				uv0.id
			})
		end

		slot0.rewardItemList[slot5]:SetData(slot7)
		slot0.rewardItemList[slot5]:Show(true)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItemList do
		slot0.rewardItemList[slot5]:Show(false)
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItemList) do
		slot5:Dispose()

		slot5 = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
