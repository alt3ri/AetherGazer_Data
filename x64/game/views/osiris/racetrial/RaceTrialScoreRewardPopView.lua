slot0 = class("RaceTrialScoreRewardPopView", ReduxView)

function slot0.UIName(slot0)
	return RaceTrialTools.GetScoreRewardUIName(slot0.params_.mainActivityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, slot0:GetRewardItemClass())
end

function slot0.GetRewardItemClass(slot0)
	return RaceTrialScoreRewardItem
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.list_[slot1], slot0.scoreNum_, slot0.params_.mainActivityID)
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
	slot0.list_ = RaceTrialData:GetScoreRewardSortList(slot0.params_.mainActivityID)
	slot0.scoreNum_ = RaceTrialData:GetTotalScore(slot0.params_.mainActivityID)
	slot0.score_.text = slot0.scoreNum_

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnPointReceive(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
