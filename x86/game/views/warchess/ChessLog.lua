slot0 = class("WarChessLog", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/WarChess_Battle/WarChessLog"
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

	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.viewportGo_, ChessLogItem)
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}

	for slot4, slot5 in ipairs(WarChessData:GetLogs()) do
		slot0.itemList_[slot4] = slot5.log
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot1, slot0.itemList_[slot1])
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0:UpdateData()
	slot0.scrollHelper:StartScroll(#slot0.itemList_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
