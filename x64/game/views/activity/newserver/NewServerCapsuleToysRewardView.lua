slot0 = class("NewServerCapsuleToysRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/NewServer/NewServerRewardPreviewPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.coreRewardList_ = {}
	slot0.normalRewardList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(NewServerCfg[slot0.activityID_].gashapon) do
		if NewServerCapsuleToysCfg[slot8].reward_type == 1 then
			slot2[#slot2 + 1] = slot8
		else
			slot3[#slot3 + 1] = slot8
		end
	end

	for slot7, slot8 in ipairs(slot2) do
		if not slot0.coreRewardList_[slot7] then
			slot0.coreRewardList_[slot7] = NewServerCapsuleToysItem.New(Object.Instantiate(slot0.rewardGo_, slot0.coreRewardPanel_))
		end

		slot0.coreRewardList_[slot7]:SetData(slot8)
	end

	for slot7 = #slot2 + 1, #slot0.coreRewardList_ do
		slot0.coreRewardList_[slot7]:Show(false)
	end

	for slot7, slot8 in ipairs(slot3) do
		if not slot0.normalRewardList_[slot7] then
			slot0.normalRewardList_[slot7] = NewServerCapsuleToysItem.New(Object.Instantiate(slot0.rewardGo_, slot0.normalRewardPanel_))
		end

		slot0.normalRewardList_[slot7]:SetData(slot8, slot7)
	end

	for slot7 = #slot3 + 1, #slot0.normalRewardList_ do
		slot0.normalRewardList_[slot7]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.coreRewardPanel_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.coreRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.normalRewardPanel_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.normalRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.coreRewardList_ then
		for slot4, slot5 in ipairs(slot0.coreRewardList_) do
			slot5:Dispose()
		end

		slot0.coreRewardList_ = nil
	end

	if slot0.normalRewardList_ then
		for slot4, slot5 in ipairs(slot0.normalRewardList_) do
			slot5:Dispose()
		end

		slot0.normalRewardList_ = nil
	end
end

return slot0
