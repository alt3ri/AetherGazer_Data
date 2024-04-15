slot0 = class("NewWarChessTestLevelView", ReduxView)

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
	slot2:SetData(NewWarChessLevelCfg.all[slot1])
	slot2:SetEventListener()
end

function slot0.AddUIListener(slot0)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_NEWWARCHESS_MOVEPOINT_PACKAGE
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_NEWWARCHESS_MOVEPOINT_PACKAGE, true)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.newChessList_:StartScroll(#NewWarChessLevelCfg.all)

	slot0.tipsText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_RECOVER"), NewChessTools.GetNewWarChessGameSetting("new_warchess_recover")[1])
end

function slot0.OnNewWarChessLevelInfoUpdate(slot0)
	slot0.newChessList_:Refresh()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot5, slot6 in pairs(slot0.newChessList_:GetItemList()) do
		slot6:RemoveEventListener()
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
