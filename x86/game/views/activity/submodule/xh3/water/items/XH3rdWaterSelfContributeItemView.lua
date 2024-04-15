slot0 = class("XH3rdWaterSelfContributeItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:AddEventListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveGetController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveGet")
	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0, slot1 = ActivityWaterData:GetCurrentContributeCfg(uv0.activityId_)

		if not slot1 and ActivityPointRewardCfg[slot0].need <= ActivityWaterData:GetCurrentSelfProgress(uv0.activityId_) then
			ActivityWaterAction.GetSelfAssistantReward(uv0.activityId_, {
				slot0
			}, ActivityPointRewardCfg[slot0].reward_item_list)
		else
			JumpTools.OpenPageByJump("xH3rdWaterExchange", {})
		end
	end)
	slot0.commonItem_:RegistCallBack(function (slot0)
		slot1, slot2 = ActivityWaterData:GetCurrentContributeCfg(uv0.activityId_)

		if not slot2 and ActivityPointRewardCfg[slot1].need <= ActivityWaterData:GetCurrentSelfProgress(uv0.activityId_) then
			ActivityWaterAction.GetSelfAssistantReward(uv0.activityId_, {
				slot1
			}, ActivityPointRewardCfg[slot1].reward_item_list)
		else
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, function ()
		uv0:UpdateView()
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.activityId_ = slot1

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1, slot2 = ActivityWaterData:GetCurrentContributeCfg(slot0.activityId_)
	slot3 = ActivityWaterData:GetCurrentSelfProgress(slot0.activityId_)

	if slot2 then
		slot0.haveGetController_:SetSelectedState("true")
	elseif ActivityPointRewardCfg[slot1].need <= slot3 then
		slot0.haveGetController_:SetSelectedState("canGet")
	else
		slot0.haveGetController_:SetSelectedState("false")
	end

	slot0.contributeValueText_.text = slot3 .. "/" .. ActivityPointRewardCfg[slot1].need

	slot0.commonItem_:RefreshData(rewardToItemTemplate(formatReward(ActivityPointRewardCfg[slot1].reward_item_list[1])))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.gameObject_.transform)
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
	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
