slot0 = class("SnowballQuestItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.typeController = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:AddBtnListenerScale(slot0.btn_, nil, handler(slot0, slot0.SubmitQuest))

	if slot0:UseUIListForRewards() then
		slot0.rewardItems = LuaList.New(handler(slot0, slot0.RenderRewardListItem), slot0.rewardListGo_, CommonItem)
	else
		slot0.rewardItems = {}
	end
end

function slot0.UseUIListForRewards(slot0)
	return slot0.rewardListGo_ ~= nil
end

function slot0.SubmitQuest(slot0)
	TaskAction:SubmitTask(slot0.taskID)
end

function slot0.RenderRewardListItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.cfg.reward[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
		OperationRecorder.Record(RewardItem.__cname, "open_pop_item")
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.taskID = slot1
	slot0.taskActivityID = slot2
	slot0.info = TaskData2:GetTask(slot1)
	slot0.cfg = AssignmentCfg[slot1]

	slot0:RefreshReward()
	slot0:RefreshTask()

	if slot0.typeController then
		slot0.typeController:SetSelectedState(slot0.cfg.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY and "normal" or "challenge")
	end
end

function slot0.RefreshReward(slot0)
	if slot0:UseUIListForRewards() then
		slot0.rewardItems:StartScroll(#slot0.cfg.reward)
	else
		slot2 = #slot1

		for slot6, slot7 in ipairs(slot1) do
			if not slot0.rewardItems[slot6] then
				slot0.rewardItems[slot6] = RewardItem.New(slot0.rewardItem_, slot0.rewardParent_)

				slot0.rewardItems[slot6]:UpdateCommonItemAni()
			end

			slot0.rewardItems[slot6]:SetData(slot7)
		end

		for slot6 = slot2 + 1, #slot0.rewardItems do
			slot0.rewardItems[slot6]:Show(false)
		end
	end
end

function slot0.RefreshTask(slot0)
	slot0.desc_.text = slot0.cfg.desc
	slot1 = 0
	slot1 = (slot0.cfg.need > slot0.info.progress or slot0.cfg.need) and slot0.info.progress
	slot0.progress_.text = slot1 .. "/" .. slot0.cfg.need
	slot0.slider_.value = slot1 / slot0.cfg.need

	if slot0.info.complete_flag >= 1 then
		slot0.stateController:SetSelectedState("received")
	elseif slot0.cfg.need <= slot1 then
		slot0.stateController:SetSelectedState("complete")
	else
		slot0.stateController:SetSelectedState("unfinish")
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0:UseUIListForRewards() then
		slot0.rewardItems:Dispose()
	else
		for slot4 = 1, #slot0.rewardItems do
			slot0.rewardItems[slot4]:Dispose()
		end
	end

	slot0.rewardItems = nil

	slot0.super.Dispose(slot0)
end

return slot0
