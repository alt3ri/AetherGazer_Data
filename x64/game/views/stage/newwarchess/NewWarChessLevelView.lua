slot0 = class("NewWarChessLevelView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessEntryUI"
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

	slot0.newChessList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, NewWarChessLevelItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(NewWarChessLevelCfg.get_id_list_by_activity[slot0.subActivityIDList_[slot1]][1])
	slot2:SetEventListener()
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.ActivityID
	slot0.subActivityIDList_ = ActivityCfg[slot0.activityID_].sub_activity_list
	slot1 = {}
	slot5 = ItemConst.ITEM_SUB_TYPE.NEWWARCHESS_MOVEPOINT_PACKAGE

	for slot5, slot6 in pairs(ItemCfg.get_id_list_by_sub_type[slot5]) do
		if ItemCfg[slot6].time[2][1] == slot0.activityID_ then
			table.insert(slot1, slot6)
		end
	end

	slot2 = {
		BACK_BAR,
		HOME_BAR
	}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, slot7)
	end

	slot6 = slot2

	manager.windowBar:SwitchBar(slot6)

	for slot6, slot7 in pairs(slot1) do
		manager.windowBar:SetBarCanAdd(slot7, true)
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.newChessList_:StartScroll(#slot0.subActivityIDList_)

	for slot5, slot6 in pairs(slot0.newChessList_:GetItemList()) do
		slot6:SetEventListener()
		slot6:CreatTimer()
	end

	slot0.tipsText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_RECOVER"), NewChessTools.GetNewWarChessGameSetting("new_warchess_recover", slot0.activityID_)[1])
end

function slot0.OnNewWarChessLevelInfoUpdate(slot0)
	slot0.newChessList_:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot5, slot6 in pairs(slot0.newChessList_:GetItemList()) do
		slot6:RemoveEventListener()
		slot6:StopTimer()
	end
end

function slot0.Dispose(slot0)
	if slot0.newChessList_ then
		slot0.newChessList_:Dispose()

		slot0.newChessList_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
