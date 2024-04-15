slot0 = class("SkinDrawInfoView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetDrawInfoUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.mainRewardItems_ = {}
	slot0.baseRewardItems_ = {}
	slot0.rewardItems_ = {}
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.poolID_ = slot0.params_.poolID
	slot0.activityID_ = slot0.params_.poolActivityID
	slot1 = ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[slot0.poolID_]
	slot2 = {}
	slot3 = {}
	slot8 = slot0.poolID_

	for slot8, slot9 in ipairs(ActivityLimitedDrawPoolListCfg[slot8].main_icon_info) do
		table.insert({}, slot9[1])
	end

	for slot8, slot9 in ipairs(slot1) do
		if ActivityLimitedDrawPoolCfg[slot9].minimum_guarantee == 1 then
			table.insert(slot2, slot9)
		elseif slot11 == 2 and not table.indexof(slot4, slot9) then
			table.insert(slot3, slot9)
		end
	end

	slot0:RefreshMainReward(slot4)
	slot0:RefreshBaseReward(slot3)
	slot0:RefreshOtherReward(slot2)

	slot0.desc_.text = ActivityLimitedDrawPoolListCfg[slot0.poolID_].detail_note

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content1_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content2_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content3_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content4_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.content_)
end

function slot0.RefreshMainReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = ActivityLimitedDrawPoolCfg[slot6]
		slot8 = slot7.reward[1][1]
		slot9 = slot7.reward[1][2]

		if not slot0.mainRewardItems_[slot5] then
			slot0.mainRewardItems_[slot5] = SkinDrawInfoItem.New(Object.Instantiate(slot0.template_, slot0.content1_))
		end

		slot0.mainRewardItems_[slot5]:RefreshData(slot8, slot9)

		slot10 = slot7.total

		slot0.mainRewardItems_[slot5]:SetBottomText((ActivitySkinDrawData:GetDrawInfo(slot0.activityID_, slot6) and slot11.num or slot10) .. "/" .. slot10)
		SetActive(slot0.mainRewardItems_[slot5].gameObject_, true)
	end

	for slot5 = #slot1 + 1, #slot0.mainRewardItems_ do
		SetActive(slot0.mainRewardItems_[slot5].gameObject_, false)
	end
end

function slot0.RefreshBaseReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = ActivityLimitedDrawPoolCfg[slot6]
		slot8 = slot7.reward[1][1]
		slot9 = slot7.reward[1][2]

		if not slot0.baseRewardItems_[slot5] then
			slot0.baseRewardItems_[slot5] = SkinDrawInfoItem.New(Object.Instantiate(slot0.template_, slot0.content2_))
		end

		slot0.baseRewardItems_[slot5]:RefreshData(slot8, slot9)

		slot10 = slot7.total

		slot0.baseRewardItems_[slot5]:SetBottomText((ActivitySkinDrawData:GetDrawInfo(slot0.activityID_, slot6) and slot11.num or slot10) .. "/" .. slot10)
		SetActive(slot0.baseRewardItems_[slot5].gameObject_, true)
	end

	for slot5 = #slot1 + 1, #slot0.baseRewardItems_ do
		SetActive(slot0.baseRewardItems_[slot5].gameObject_, false)
	end
end

function slot0.RefreshOtherReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = ActivityLimitedDrawPoolCfg[slot6]
		slot8 = slot7.reward[1][1]
		slot9 = slot7.reward[1][2]

		if not slot0.rewardItems_[slot5] then
			slot0.rewardItems_[slot5] = SkinDrawInfoItem.New(Object.Instantiate(slot0.template_, slot0.content3_))
		end

		slot0.rewardItems_[slot5]:RefreshData(slot8, slot9)

		slot10 = slot7.total

		slot0.rewardItems_[slot5]:SetBottomText((ActivitySkinDrawData:GetDrawInfo(slot0.activityID_, slot6) and slot11.num or slot10) .. "/" .. slot10)
		SetActive(slot0.rewardItems_[slot5].gameObject_, true)
	end

	for slot5 = #slot1 + 1, #slot0.rewardItems_ do
		SetActive(slot0.rewardItems_[slot5].gameObject_, false)
	end
end

function slot0.OnExit(slot0)
	for slot4 = 1, #slot0.mainRewardItems_ do
		slot0.mainRewardItems_[slot4]:OnExit()
	end

	for slot4 = 1, #slot0.baseRewardItems_ do
		slot0.baseRewardItems_[slot4]:OnExit()
	end

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4 = 1, #slot0.mainRewardItems_ do
		slot0.mainRewardItems_[slot4]:Dispose()
	end

	for slot4 = 1, #slot0.baseRewardItems_ do
		slot0.baseRewardItems_[slot4]:Dispose()
	end

	for slot4 = 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:Dispose()
	end

	slot0.super.Dispose(slot0)
end

return slot0
