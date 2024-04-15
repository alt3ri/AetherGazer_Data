slot0 = class("SailIslandRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesRewardPopUI"
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

	slot0.rewardItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiList_, SailIslandRewardItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0.rewardItemList_:Dispose()

	slot0.rewardItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	slot0.sortTaskList_ = SailGameData:GetSortTaskList(slot0.activityID_)

	slot0.rewardItemList_:StartScroll(#slot0.sortTaskList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.sortTaskList_[slot1], slot0.activityID_)
end

function slot0.OnReceiveSailTask(slot0)
	slot0:RefreshUI()
end

return slot0
