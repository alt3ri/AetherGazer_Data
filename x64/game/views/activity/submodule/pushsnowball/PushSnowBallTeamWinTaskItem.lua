slot0 = class("PushSnowBallTeamWinTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rewardState_ = ControllerUtil.GetController(slot0.transform_, "stateBtn")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.cfg_ = AssignmentCfg[slot2.id]
	slot0.rewardList_ = slot0.cfg_.reward

	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. slot0.data_.id)
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
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

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.ACTIVITY_PUSH_SNOWBALL_TEAM_WIN .. slot0.data_.id)
end

function slot0.RefreshItem(slot0)
	slot0.commonItem_:RefreshData({
		id = slot0.rewardList_[1][1],
		number = slot0.rewardList_[1][2]
	})
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, {
			uv0.rewardList_[1][1]
		})
	end)
	slot0.commonItem_:SetBottomText(slot0.rewardList_[1][2])

	slot0.descText_.text = slot0.cfg_.desc
end

function slot0.RefreshState(slot0)
	slot1 = TaskData2:GetTaskComplete(slot0.cfg_.id)

	if not (AssignmentCfg[slot0.cfg_.id].need <= TaskData2:GetTask(slot0.cfg_.id).progress) then
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

	slot0.commonItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
