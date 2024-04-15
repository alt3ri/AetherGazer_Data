slot0 = class("ActivityPtScrollPopView", ReduxView)

function slot0.UIName(slot0)
	return ActivityPtScrollTools.GetBuffPopUIName(slot0.params_.mainActivityID)
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityPtScrollPopItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(ActivityPtScrollData:GetAffixInfo(slot0.activityID_, slot0.list_[slot1]), slot0.contentRect_, slot0.viewRect_.rect.height)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.mainActivityID

	slot0:RefreshData()
	slot0:RefreshList()
end

function slot0.RefreshData(slot0)
	slot0.list_ = {}
	slot1 = ActivityPtScrollData:GetAffixList(slot0.activityID_)

	table.insertto(slot0.list_, slot1)
	table.insertto(slot0.list_, slot1)

	slot0.chooseIndex_ = #slot1 + (#slot1 - 1) / 2 + 1
end

function slot0.RefreshList(slot0)
	if slot0.params_.isScroll then
		slot0.params_.isScroll = false

		manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_pt1_rotate", "")
		slot0.scrollHelper_:StartScroll(#slot0.list_, slot0.chooseIndex_, true, true, 3.5)
	else
		manager.audio:PlayEffect("minigame_activity_2_6", "minigame_activity_2_6_pt1_platform", "")
		slot0.scrollHelper_:StartScroll(#slot0.list_, slot0.chooseIndex_, true)
	end
end

function slot0.OnExit(slot0)
	slot0.scrollHelper_:RemoveTween()
	slot0.scrollHelper_:SetScrolledPosition(Vector2.one)

	for slot4, slot5 in pairs(slot0.scrollHelper_.itemOfInstanceID_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
