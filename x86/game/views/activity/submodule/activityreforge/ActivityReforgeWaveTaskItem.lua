slot0 = class("ActivityReforgeWaveTaskItem", ReduxView)

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
end

function slot0.SetData(slot0, slot1)
	slot0.taskCfg_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.taskDes_.text = slot0.taskCfg_[1]
	slot0.taskRewardNum_.text = slot0.taskCfg_[2]
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
