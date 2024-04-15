slot0 = class("SpringWelfareTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.rewardList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rewardListGo_, SpringWelfareTaskRewardItem)
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		if uv0.handler_ then
			uv0:handler_(uv0.taskID_)
		end
	end)
end

function slot0.OnTaskListChange(slot0)
	slot0:RefreshUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.cfg_.reward[slot1])
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.handler_ = slot1
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.taskID_ = slot1
	slot0.activityID_ = slot2
	slot0.cfg_ = AssignmentCfg[slot1]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
	slot0:RefreshTask()
end

function slot0.RefreshReward(slot0)
	slot0.rewardList_:StartScroll(#slot0.cfg_.reward)
end

function slot0.RefreshTask(slot0)
	slot0.descText_.text = slot0.cfg_.desc
	slot2 = slot0.cfg_.need < TaskData2:GetTask(slot0.taskID_).progress and slot0.cfg_.need or slot1.progress
	slot0.progressText_.text = string.format("%d/%d", slot2, slot0.cfg_.need)
	slot0.slider_.value = slot2 / slot0.cfg_.need

	if slot0.cfg_.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY then
		slot0.typeCon_:SetSelectedState("normal")
	else
		slot0.typeCon_:SetSelectedState("challenge")
	end

	slot4 = slot0.cfg_.need <= slot1.progress

	if slot1.complete_flag >= 1 then
		slot0.stateCon_:SetSelectedState("received")
	elseif slot4 then
		slot0.stateCon_:SetSelectedState("complete")
	else
		slot0.stateCon_:SetSelectedState("unfinish")
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.rewardList_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
