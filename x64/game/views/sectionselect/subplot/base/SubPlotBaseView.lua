slot0 = class("SubPlotBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/MardukUI/hera/HeraStoryUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.stageItemList_ = {}
	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)
	slot0.changeChapterHandler_ = handler(slot0, slot0.ChangeChapter)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		if uv0:IsOpenSectionInfo() then
			uv0.isOpenInfoView_ = false
		end

		JumpTools.Back()
	end)
	manager.ui:SetMainCamera("null")
	slot0:RefreshData()
	slot0:RefreshUI()
	manager.notify:RegistListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
	BattleStageAction.ClickSubPlot(slot0.chapterID_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	slot0.scrollMoveView_:OnExit()
	manager.notify:RemoveListener(CHANGE_CHAPTER, slot0.changeChapterHandler_)
end

function slot0.Dispose(slot0)
	slot0.changeChapterHandler_ = nil

	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:Dispose()
	end

	slot0.stageItemList_ = nil

	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
end

function slot0.OnUpdate(slot0)
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.ChangeChapter(slot0, slot1)
	slot2 = getChapterClientCfgByChapterID(slot1)

	if slot0.params_.section == (BattleFieldData:GetCacheStage(slot1) or ChapterCfg[slot1].section_id_list[1]) then
		return
	end

	slot0.params_.chapterID = slot1
	slot0.params_.section = slot3

	BattleFieldData:SetStageByClientID(slot2.id, slot3)
	BattleFieldData:SetCacheChapterClient(getChapterToggle(slot2.id), slot2.id)
	BattleFieldAction.ChangeSelectChapterID(slot1)
	JumpTools.Jump2SubPlot(slot2.id, true)
end

function slot0.RefreshData(slot0)
	slot0.chapterID_ = BattleFieldData:GetCacheChapter(slot0.params_.chapterClientID)
	slot0.stageData_ = BattleStageData:GetStageData()
	slot0.stageList_ = ChapterCfg[slot0.chapterID_].section_id_list
	slot0.selectStageID_ = BattleFieldData:GetCacheStage(slot0.chapterID_) or ChapterCfg[slot0.chapterID_].section_id_list[1]
end

function slot0.RefreshUI(slot0)
	slot6 = slot0:GetScrollPos()

	slot0.scrollMoveView_:RefreshUI(slot6, slot0:GetScrollWidth())

	for slot6 = 1, #slot0.stageItemList_ do
		slot0.stageItemList_[slot6]:Show(false)
	end

	for slot7 = 1, #slot0.stageList_ do
		if slot7 == 1 or BattleStageData:GetStageData()[slot0.stageList_[slot7]] then
			if not slot0.stageItemList_[slot7] then
				slot0.stageItemList_[slot7] = slot0:GetItemClass().New(slot0.sectionItem_, slot0.content_)
			end

			slot0.stageItemList_[slot7]:SetData(slot0.stageList_[slot7], slot0.chapterID_)
		end
	end

	slot0:RefreshSelectItem()
end

function slot0.RefreshSelectItem(slot0)
	for slot4, slot5 in pairs(slot0.stageItemList_) do
		slot5:SelectorItem(slot0.selectStageID_)
	end
end

function slot0.GetItemClass(slot0)
	return SubPlotBaseItem
end

function slot0.GetScrollWidth(slot0)
	slot1 = slot0.stageList_[1]

	for slot5, slot6 in ipairs(slot0.stageList_) do
		if not slot0.stageData_[slot6] then
			break
		end

		slot1 = slot6
	end

	return slot0:GetCfgName()[slot1] and slot2.position[1] or 0
end

function slot0.GetScrollPos(slot0)
	return slot0:GetCfgName()[slot0.selectStageID_] and slot2.position[1] or 0
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("subPlotSectionInfo")
end

function slot0.SwitchBG(slot0)
	if ChapterCfg[slot0.chapterID_].bg ~= "" then
		slot0.bgImage_.sprite = getSpriteWithoutAtlas(slot1.bg)
	end

	SetActive(slot0.bgImage_.gameObject, slot1.bg ~= "")
end

function slot0.GetCfgName(slot0)
	return BattleActivityStoryStageCfg
end

return slot0
