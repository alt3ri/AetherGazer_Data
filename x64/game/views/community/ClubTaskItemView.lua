slot0 = class("ClubTaskItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rewardItems_ = {}
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.JumpToPage2(uv0.taskCfg_.source)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.taskID_ = slot1
	slot0.info_ = TaskData2:GetTask(slot0.taskID_)
	slot0.taskCfg_ = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = GetI18NText(slot0.taskCfg_.desc)

	slot0:RefreshType()
	slot0:RefreshProgress()
	slot0:RefreshReward()
end

function slot0.RefreshType(slot0)
end

function slot0.RefreshReward(slot0)
end

function slot0.RefreshProgress(slot0)
end

function slot0.OnExit(slot0)
	for slot4 = #slot0.rewardItems_, 1, -1 do
		slot0.rewardItems_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = #slot0.rewardItems_, 1, -1 do
		slot0.rewardItems_[slot4]:Dispose()

		slot0.rewardItems_[slot4] = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
