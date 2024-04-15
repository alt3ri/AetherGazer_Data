slot0 = class("DormLinkGameActivityItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.count = 0
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.rewardBtn_, nil, function ()
		uv0.getAward(uv0.ID)
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.ID = slot1

	if not ConditionCfg[ActivityLinkGameRewardCfg[slot1].condition] then
		return
	end

	slot0.text_.text = DormLinkGameTools:GetAwardDesc(slot1)

	if DormLinkGameData:CheckLevelRewardState(slot1) == DormLinkGameConst.RewardItemState.unComplete then
		slot0.stateController:SetSelectedState("uncomplete")
	elseif slot4 == DormLinkGameConst.RewardItemState.complete then
		slot0.stateController:SetSelectedState("complete")
	elseif slot4 == DormLinkGameConst.RewardItemState.received then
		slot0.stateController:SetSelectedState("received")
	end

	slot0:UpdataReward()
end

function slot0.UpdataReward(slot0)
	if not slot0.rewardList then
		slot0.rewardList = {}
	end

	for slot5, slot6 in ipairs(ActivityLinkGameRewardCfg[slot0.ID].item_list) do
		if slot0.rewardList[slot5] then
			slot0.rewardList[slot5]:SetData(slot6)
		else
			slot0.rewardList[slot5] = RewardPoolItem.New(slot0.rewardParent_, slot6, true)
		end
	end

	for slot5, slot6 in pairs(slot0.rewardList) do
		slot0.rewardList[slot5]:Show(true)
	end
end

function slot0.GetLevelAward(slot0, slot1)
	if slot1 then
		slot0.getAward = slot1
	end
end

function slot0.Dispose(slot0)
	if slot0.rewardList then
		for slot4, slot5 in pairs(slot0.rewardList) do
			slot0.rewardList[slot4]:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
