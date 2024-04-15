slot0 = class("PuzzleNewRewardView", ReduxView)

function slot0.UIName(slot0)
	return PuzzleNewTools.GetRewardViewUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
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
	slot1 = PuzzleNewCfg[slot0.activityID_]

	for slot5, slot6 in pairs(slot0.regionList_) do
		slot6:SetData(slot0.activityID_)
	end

	slot2 = PuzzleNewData:GetCurPuzzleList(slot0.activityID_)

	for slot6, slot7 in ipairs(slot0.maskList_) do
		SetActive(slot7, slot2[slot6] == nil or slot2[slot6] ~= slot1.correct_array[slot6])
	end
end

function slot0.SpawnRegion(slot0, slot1)
	slot2 = PuzzleNewCfg[slot1]
	slot0.regionList_ = slot0.regionList_ or {}

	for slot11 = 1, slot0.regionContentTrans_.childCount do
		slot13 = tonumber(slot0.regionContentTrans_:GetChild(slot11 - 1).name)
		slot14 = PuzzleNewTools.GetRegionPosDic(slot1)[slot13]
		slot16 = slot2.area_fragment_list[slot14][2]

		if not slot0.regionList_[slot13] then
			slot0.regionList_[slot13] = PuzzleNewRegionItem.New(slot12, slot15, PuzzleNewTools.GetPuzzlePosDic(slot1), slot2.reward_area_list[slot14][2])
		end
	end

	slot0.maskList_ = slot0.maskList_ or {}

	for slot12 = 1, slot0.maskPanelTrans_.childCount do
		slot0.maskList_[slot12] = slot0.maskPanelTrans_:GetChild(slot12 - 1)
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
