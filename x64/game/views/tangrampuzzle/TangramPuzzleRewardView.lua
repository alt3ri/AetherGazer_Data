slot0 = class("TangramPuzzleRewardView", ReduxView)

function slot0.UIName(slot0)
	return TangramPuzzleTools.GetRewardViewUIName(slot0.params_.activityID)
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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	if slot0.activityID_ ~= slot0.params_.activityID then
		slot0:DispawnRegion()
		slot0:SpawnRegion(slot0.params_.activityID)
	end

	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:DispawnRegion()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot1 = TangramPuzzleCfg[slot0.activityID_]

	for slot5, slot6 in pairs(slot0.regionList_) do
		slot6:SetData(slot0.activityID_, slot5)
	end
end

function slot0.SpawnRegion(slot0, slot1)
	slot0.regionList_ = slot0.regionList_ or {}

	for slot8 = 1, slot0.regionContentTrans_.childCount do
		if not slot0.regionList_[TangramPuzzleCfg[slot1].reward_area_list[slot8][1]] then
			slot0.regionList_[slot10] = TangramRegionRewardItem.New(slot0.regionContentTrans_:GetChild(slot8 - 1))
		end
	end
end

function slot0.DispawnRegion(slot0)
	if slot0.regionList_ then
		for slot4, slot5 in pairs(slot0.regionList_) do
			slot5:Dispose()
		end

		slot0.regionList_ = nil
	end

	slot0.maskList_ = nil
end

return slot0
