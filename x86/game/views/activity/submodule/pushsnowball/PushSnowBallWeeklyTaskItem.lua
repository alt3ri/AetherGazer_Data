slot0 = class("PushSnowBallWeeklyTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.cfg_ = AssignmentCfg[slot2.id]

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.SetCheckCallBack(slot0, slot1)
	slot0.checkCallBack_ = slot1
end

function slot0.RefreshUI(slot0)
	slot0:RefreshItem()
	slot0:RefreshState()
end

function slot0.RefreshItem(slot0)
	slot0.titleText_.text = slot0.cfg_.name
	slot0.descText_.text = slot0.cfg_.desc
	slot0.processText_.text = math.min(slot0.data_.progress, AssignmentCfg[slot0.cfg_.id].need) .. "/" .. AssignmentCfg[slot0.cfg_.id].need
end

function slot0.RefreshState(slot0)
	if not (slot0.cfg_.need <= slot0.data_.progress) then
		slot0.rewardState_:SetSelectedState("normal")
	else
		slot0.rewardState_:SetSelectedState("complete")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
