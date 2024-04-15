slot0 = class("StrongholdOperateTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.rewardItemGos_ = {}
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.rewardCountController = ControllerUtil.GetController(slot0.transform_, "rewardCount")
	slot0.typeCountController = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.task_activity_id = slot1
	slot0.taskID_ = slot2
	slot0.taskProgress = TaskData2:GetTask(slot0.taskID_) and slot3.progress or 0
	slot0.taskComplete_ = slot3 and slot3.complete_flag >= 1 or false

	slot0:RefreshUI()
	slot0:RefreshProgress()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = slot1.desc

	slot0.rewardCountController:SetSelectedIndex(math.min(3, #(slot1.reward or {})))

	for slot6, slot7 in ipairs(slot2) do
		if slot0.rewardItems_[slot6] == nil then
			slot0.rewardItems_[slot6] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

			slot0.rewardItems_[slot6]:UpdateCommonItemAni()
			slot0.rewardItems_[slot6].commonItem_:RegistCallBack(function ()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		slot0.rewardItems_[slot6]:SetData(slot7)
	end

	for slot6 = #slot1.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot6]:Show(false)
	end

	if slot1.type == 711 or slot3 == 721 or slot3 == 731 then
		slot0.typeCountController:SetSelectedIndex(0)
	else
		slot0.typeCountController:SetSelectedIndex(1)
	end
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot0.progressBar_.fillAmount = slot2 / slot1.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot1.need)
	slot3 = slot1.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.controller_:SetSelectedIndex(2)
	elseif slot3 then
		slot0.controller_:SetSelectedIndex(1)
	else
		slot0.controller_:SetSelectedIndex(0)
	end

	slot0.m_icon.sprite = getSprite("Atlas/XuHeng3rdUI", ActivityStrongholdTaskIconCfg[slot0.taskID_] and slot4.task_icon or "")
end

function slot0.RefreshComplete(slot0)
	SetActive(slot0.gameObject_, not slot0.taskComplete_)
end

return slot0
