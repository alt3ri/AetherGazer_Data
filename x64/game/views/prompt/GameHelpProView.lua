slot0 = class("GameHelpProView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/UIfunctionpopup04"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.m_list, GameHelpProItem)
	slot0.dotList_ = LuaList.New(handler(slot0, slot0.DotIndexItem), slot0.m_dotList, GameHelpProDotItem)
	slot0.hideBgController_ = slot0.m_controller:GetController("hideBg")
end

function slot0.AddUIListeners(slot0)
	slot0.list_:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0:AddBtnListener(slot0.m_preBtn, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ - 1)
	end)
	slot0:AddBtnListener(slot0.m_nextBtn, nil, function ()
		uv0.list_:SwitchToPage(uv0.pageIndex_ + 1)
	end)
	slot0:AddBtnListener(slot0.m_closeBtn, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnPageChange(slot0, slot1)
	slot0.pageIndex_ = slot1

	SetActive(slot0.m_preBtn.gameObject, slot1 > 1)
	SetActive(slot0.m_nextBtn.gameObject, slot1 < #slot0.pages)
	slot0.dotList_:ScrollToIndex(slot1)
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.pages = slot0.params_.pages or {}
	slot0.isPrefab_ = slot0.params_.isPrefab or false
	slot0.hideBg_ = slot0.params_.hideBg or false
	slot0.hideHomeBtn = slot0.params_.hideHomeBtn or nil
	slot1 = slot0.params_.startIndex or 1

	slot0.list_:StartScroll(#slot0.pages, slot1, true, false)
	slot0.dotList_:StartScroll(#slot0.pages, slot1, true, false)
	slot0:OnPageChange(slot1)
	slot0.hideBgController_:SetSelectedState(tostring(slot0.hideBg_))

	slot0.params_.startIndex = nil
end

function slot0.indexItem(slot0, slot1, slot2)
	slot4 = #slot0.pages

	slot2:SetData(slot1, slot0.pages[slot1], slot0.isPrefab_)
end

function slot0.DotIndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.pageIndex_ == slot1)
end

function slot0.OnExit(slot0)
	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", slot0:GetStayTime(), 50103)
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	slot0.dotList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
