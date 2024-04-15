slot0 = class("SubPlotChessView", ReduxView)

function slot0.UIName(slot0)
	return WarChessTools.GetSubPlotViewName(slot0.params_.tag)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
end

function slot0.InitBtns(slot0)
	if not slot0.chessView_ then
		slot0.chessView_ = {}

		for slot4, slot5 in ipairs(WarchessLevelCfg.get_id_list_by_tag[slot0.params_.tag]) do
			slot0.chessView_[slot5] = slot0:GetChessItemView().New(slot0[string.format("goStage%s_", slot4)], slot5)
		end
	end
end

function slot0.GetChessItemView(slot0)
	return SubPlotChessItem
end

function slot0.OnEnter(slot0)
	slot4 = HOME_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		slot4
	})
	slot0:InitBtns()

	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:OnEnter()
	end

	if slot0.params_.chapterClientID == ChessConst.SUBPLOT_TAG.HELLA then
		SetActive(slot0.timeGo_, false)
		SetActive(slot0.buttonBtn_.gameObject, false)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:Dispose()
	end

	slot0.chessView_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
