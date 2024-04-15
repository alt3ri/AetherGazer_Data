slot0 = class("RegressionTaskNewItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.rewardItems_ = {}
	slot0.itemDataList_ = {}
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isShow_ = true

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.ReEnter(slot0, slot1, slot2)
	slot0.taskID_ = slot1
	slot0.maxRewardNum_ = slot2
	slot0.taskProgress = TaskData2:GetTaskProgress(slot1)
	slot0.taskComplete_ = TaskData2:GetTaskComplete(slot1)

	slot0:RefreshUI()
	slot0:RefreshProgress()

	slot0.isShow_ = true
end

function slot0.OnExit(slot0)
	slot0.isShow_ = false

	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	slot0.itemDataList_ = nil

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "goBtn")
		JumpTools.JumpToPage2(AssignmentCfg[uv0.taskID_].source)
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		OperationRecorder.Record(uv0.class.__cname, "receiveBtnBtn")
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.goBtn_.onClick:RemoveAllListeners()
	slot0.receiveBtn_.onClick:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot0.titleText_.text = GetI18NText(AssignmentCfg[slot0.taskID_].desc)

	slot0:RefreshReward()
end

function slot0.RefreshReward(slot0)
	for slot6 = 1, 3 do
		slot7 = (AssignmentCfg[slot0.taskID_].reward or {})[slot6]

		if not slot0.itemDataList_[slot6] then
			slot0.itemDataList_[slot6] = clone(ItemTemplateData)

			slot0.itemDataList_[slot6].clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot8 = true

		if slot7 then
			slot0.itemDataList_[slot6].id = slot7[1]
			slot0.itemDataList_[slot6].number = slot7[2]
			slot8 = false
		end

		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = CommonItemPool.New(slot0.goRewardPanel_, nil, true)
		end

		slot0.rewardItems_[slot6]:Show(true)

		if not slot8 then
			slot0.rewardItems_[slot6]:SetData(slot0.itemDataList_[slot6])
		else
			slot0.rewardItems_[slot6]:SetData(nil)
		end
	end

	for slot6 = slot0.maxRewardNum_ + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.progressBar_.value = slot2 / slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.controller_:SetSelectedState("2")
	elseif slot3 then
		slot0.controller_:SetSelectedState("1")
	else
		slot0.controller_:SetSelectedState("0")
	end
end

function slot0.SetSibling(slot0, slot1)
	if AssignmentCfg[slot0.taskID_].condition == GameSetting.task_top_type.value[1] and slot2.additional_parameter[1] == TaskConst.TASK_TYPE.DAILY then
		slot0.transform_:SetSiblingIndex(0)
	else
		slot0.transform_:SetSiblingIndex(slot1)
	end
end

return slot0
