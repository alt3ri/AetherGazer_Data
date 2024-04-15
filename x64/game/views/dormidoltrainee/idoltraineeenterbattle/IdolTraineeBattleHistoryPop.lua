slot0 = class("IdolTraineeBattleHistoryPop", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleHistoryPopup"
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

	slot0.historyList_ = LuaList.New(handler(slot0, slot0.refreshItem), slot0.questList_, IdolTraineeBattleHistoryItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.dataList = {}

	for slot5, slot6 in pairs(IdolTraineeData:GetHistoryBattleData()) do
		table.insert(slot0.dataList, slot6)
	end

	CommonTools.UniversalSortEx(slot0.dataList, {
		map = function (slot0)
			return slot0.startTime
		end
	})
	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	slot0.historyList_:StartScroll(#slot0.dataList)
end

function slot0.refreshItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.dataList[slot1])
end

function slot0.OnExit(slot0)
	slot0.dataList = nil
end

function slot0.Dispose(slot0)
	if slot0.historyList_ then
		slot0.historyList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
