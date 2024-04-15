slot0 = class("AdvanceTestRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/AdvancetestingUI/ATestingRankRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, AdvanceTestRewardItemView)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = nil

	slot2:SetData(slot1 == 1 and 1 or ActivityPointRewardCfg[slot0.taskIdList[slot1 - 1]].need + 1, slot0.taskIdList[slot1])
end

function slot0.OnTop(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID = slot0.params_.activityID
	slot0.taskIdList = ActivityPointRewardCfg.get_id_list_by_activity_id[slot0.activityID]

	slot0.uiList_:StartScroll(#slot0.taskIdList)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
