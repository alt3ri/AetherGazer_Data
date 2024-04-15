SummerChessView = import("game.views.activity.Submodule.Chess.summer.SummerChessView")
slot0 = class("SummerChessRemasteredView", SummerChessView)

function slot0.GetChessItemView(slot0)
	return SummerChessRemasteredItem
end

function slot0.OnEnter(slot0)
	slot4 = {
		BACK_BAR,
		slot5
	}
	slot5 = HOME_BAR

	manager.windowBar:SwitchBar(slot4)
	slot0:InitBtns()

	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:OnEnter()
	end

	SetActive(slot0.goTime_, false)
end

function slot0.InitBtns(slot0)
	if not slot0.chessView_ then
		slot0.chessView_ = {}
		slot4 = slot0.params_.tag

		for slot4, slot5 in ipairs(WarchessLevelCfg.get_id_list_by_tag[slot4]) do
			slot0.chessView_[slot5] = slot0:GetChessItemView().New(slot0[string.format("goStage%s_", slot4)], slot5)
		end
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.chessView_) do
		slot5:OnExit()
	end
end

return slot0
