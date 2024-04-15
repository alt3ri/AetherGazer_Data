slot0 = class("PushSnowBallTeamTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itemList__, CommonItem)
	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "state")
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

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		TaskAction:SubmitTask(uv0.cfg_.id)
	end)
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
	slot0.rewardCfg_ = slot0.cfg_.reward

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)

	slot0.progress_.text = math.min(slot0.data_.progress, AssignmentCfg[slot0.cfg_.id].need) .. "/" .. AssignmentCfg[slot0.cfg_.id].need
	slot0.descText_.text = slot0.cfg_.desc
	slot0.slider_.value = TaskData2:GetTaskProgress(slot0.cfg_.id)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(formatReward(slot0.rewardCfg_[slot1]))
	slot2:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0)
	end)
end

function slot0.RefreshState(slot0)
	slot1 = slot0.data_.complete_flag >= 1

	if not (AssignmentCfg[slot0.cfg_.id].need <= slot0.data_.progress) then
		slot0.rewardState_:SetSelectedState("unfinished")
	elseif not slot1 then
		slot0.rewardState_:SetSelectedState("complete")
	else
		slot0.rewardState_:SetSelectedState("rewarded")
	end
end

function slot0.Dispose(slot0)
	if slot0.itemList_ then
		slot0.itemList_:Dispose()

		slot0.itemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
