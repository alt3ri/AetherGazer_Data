slot0 = class("IdolTraineeChapterMainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleChapterView"
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

	slot0.chapterList_ = IdolTraineeChapterCfg.all
	slot0.chapterUIList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.chapterUIList_, IdolTraineeChapterListItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0.chapterUIList_:StartScroll(#slot0.chapterList_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.chapterList_[slot1])
end

function slot0.Dispose(slot0)
	slot0.chapterUIList_:Dispose()

	slot0.chapterUIList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
