slot0 = class("ActivityMemoryTaskItem", ReduxView)

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

	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.cfg_.activity_jump_id).startTime then
			ShowTips("SOLO_NOT_OPEN")

			return
		end

		JumpTools.OpenPageByJump("activityMemoryPop", {
			activityId = uv0.activityID_,
			id = uv0.id_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot1
	slot0.activityID_ = slot2
	slot0.taskActivityID_ = ActivityMemoryTools.GetTaskActivityID(slot0.activityID_)
	slot0.cfg_ = SpringFestivalMemoryCfg[slot0.id_]
	slot0.taskID_ = slot0.cfg_.task_id
end

function slot0.RefreshUI(slot0)
	if not TaskData2:GetTask(slot0.taskID_) or slot2.progress < AssignmentCfg[slot0.taskID_].need then
		slot0.stateCon_:SetSelectedState("lock")
	elseif slot2.complete_flag < 1 then
		slot0.stateCon_:SetSelectedState("get")
	else
		slot0.stateCon_:SetSelectedState("normal")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
