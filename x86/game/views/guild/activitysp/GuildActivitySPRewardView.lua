slot0 = class("GuildActivitySPRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPRewardPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.receiveHandler_ = handler(slot0, slot0.OnGuildActivityReceiveRateReward)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, GuildActivitySPRewardItem)
end

function slot0.OnEnter(slot0)
	GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true
	slot0.activityID_ = slot0.params_.activityID
	slot0.rateIDList_ = GuildActivitySPData:GetSortedRateIDList(slot0.activityID_)

	slot0.scrollHelper_:StartScroll(#slot0.rateIDList_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rateIDList_[slot1], slot0.activityID_)
	slot2:setReceiveCallBack(slot0.receiveHandler_)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnGuildActivityReceiveRateReward(slot0)
	slot0.rateIDList_ = GuildActivitySPData:GetSortedRateIDList(slot0.activityID_)

	GuildActivitySPAction.UpdataHadAwardRedPoint(slot0.activityID_)
	slot0.scrollHelper_:StartScroll(#slot0.rateIDList_)
end

return slot0
