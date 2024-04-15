slot0 = class("PushBoxReplayItem", ReduxView)

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
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.OpenPageByJump("/pushBox", {
			map_id = uv0.cfg_.param,
			activityID = uv0.cfg_.main_activity,
			id = uv0.id_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1)
	slot0.id_ = slot1
	slot0.cfg_ = ActivityCelebrationOrderCfg[slot0.id_]
	slot0.title_.text = slot0.cfg_.order_title
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
