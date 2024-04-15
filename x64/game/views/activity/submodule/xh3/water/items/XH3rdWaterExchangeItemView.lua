slot0 = class("XH3rdWaterExchangeItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.commonItem_ = CommonItem.New(slot0.rewardItem_)
end

function slot0.AddUIListener(slot0)
	slot0.commonItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, slot0)
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		if uv0.stateController_:GetSelectedState() == "complete" then
			ActivityWaterAction.GetSelfAssistantReward(uv0.activityId_, {
				uv0.taskId_
			}, ActivityPointRewardCfg[uv0.taskId_].reward_item_list)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.taskId_ = slot1
	slot0.activityId_ = slot2
	slot0.rewardCfg_ = ActivityPointRewardCfg[slot0.taskId_].reward_item_list[1]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.commonItem_:RefreshData(rewardToItemTemplate(formatReward(slot0.rewardCfg_)))

	slot0.text_.text = string.format(GetTips("ACTIVITY_WATER_SELF_PROGRESS"), ActivityPointRewardCfg[slot0.taskId_].need)

	if ActivityWaterData:GetCurrentSelfProgress(slot0.activityId_) < ActivityPointRewardCfg[slot0.taskId_].need then
		slot0.stateController_:SetSelectedState("uncomplete")
	elseif ActivityWaterData:HaveGetSelfProgressReward(slot0.activityId_, slot0.taskId_) then
		slot0.stateController_:SetSelectedState("received")
	else
		slot0.stateController_:SetSelectedState("complete")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
