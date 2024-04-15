ChapterSelectBaseView = import("..ChapterSelectBaseView")
slot0 = class("ChapterSelectView", ChapterSelectBaseView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationMainUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0.changeSelectChapterHandler_ = handler(slot0, slot0.ChangeSelectChapterID)
	slot0.hardLevelView_ = HardLevelChapterView.New(slot0.selectDifficultBtn_)
	slot0.chapterToggleItemList_ = {}
	slot0.groupToggleItemList_ = {}
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.hardLevelView_:OnEnter()
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, slot0.changeSelectChapterHandler_)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, slot0.changeSelectChapterHandler_)
	slot0.hardLevelView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.changeSelectChapterHandler_ = nil

	slot0.hardLevelView_:Dispose()

	slot0.hardLevelView_ = nil

	for slot4, slot5 in ipairs(slot0.groupToggleItemList_) do
		slot5:Dispose()
	end

	slot0.groupToggleItemList_ = nil

	for slot4, slot5 in ipairs(slot0.chapterToggleItemList_) do
		slot5:Dispose()
	end

	slot0.chapterToggleItemList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.EndDragFun(slot0, slot1, slot2)
	if ChapterTools.GetNeighborClientID(slot0.selectChapterClientID_, slot2.position.x - slot2.pressPosition.x < 0) == slot0.selectChapterClientID_ then
		return
	end

	if uv0.MIN_DRAG_LENGTH < math.abs(slot3) then
		slot0.selectChapterClientID_ = slot0.nextChapterClientID_
		slot0.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, slot0.selectChapterClientID_)
		slot0:RefreshData()

		if uv0.MAX_DRAG_LENGTH < math.abs(slot3) then
			slot0:RefreshChapterUI()
			slot0:SwitchImageOver()
		else
			slot0.leanTweenHandler_ = LeanTween.value(slot0.chapterFrontImage_.gameObject, slot0.chapterFrontCanvasGroup_.alpha, 0, (uv0.MAX_DRAG_LENGTH - math.abs(slot3)) / uv0.MAX_DRAG_LENGTH * uv0.SWITCH_STAGE_TIME)

			slot0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function (slot0)
				uv0.chapterFrontCanvasGroup_.alpha = slot0
				uv0.chapterBehindCanvasGroup_.alpha = 1 - slot0
			end))
			slot0.leanTweenHandler_:setOnComplete(System.Action(function ()
				uv0:RefreshChapterUI()
				uv0:SwitchImageOver()
				LeanTween.cancel(uv0.chapterFrontImage_.gameObject)
				uv0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

				uv0.leanTweenHandler_ = nil
			end))
		end
	else
		slot0.leanTweenHandler_ = LeanTween.value(slot0.chapterFrontImage_.gameObject, slot0.chapterFrontCanvasGroup_.alpha, 1, (1 - (uv0.MIN_DRAG_LENGTH - math.abs(slot3)) / uv0.MIN_DRAG_LENGTH) * 0.8)

		slot0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function (slot0)
			uv0.chapterFrontCanvasGroup_.alpha = slot0
			uv0.chapterBehindCanvasGroup_.alpha = 1 - slot0
		end))
		slot0.leanTweenHandler_:setOnComplete(System.Action(function ()
			LeanTween.cancel(uv0.chapterFrontImage_.gameObject)
			uv0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

			uv0.leanTweenHandler_ = nil
		end))
	end
end

function slot0.PointerUpFun(slot0, slot1, slot2)
	if slot2.dragging then
		return
	end

	slot5, slot6 = ChapterTools.IsFinishPreChapter(BattleFieldData:GetCacheChapter(slot0.selectChapterClientID_))

	if not slot5 then
		ShowTips(ChapterTools.GetChapterLockText(slot4, slot6))

		return
	end

	ChapterTools.GotoChapterSection(slot4)
end

function slot0.RefreshData(slot0)
	slot0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	slot0.groupDataList_ = ChapterTools.GetChapterGroupList(slot0.selectChapterClientID_)
	slot0.hardLevel_ = ChapterClientCfg[slot0.selectChapterClientID_].difficulty
end

function slot0.RefreshUI(slot0)
	slot0:RefreshChapterUI()
	slot0:AutoSwitchImage()
	slot0:RefreshSelectDifficult()
end

function slot0.RefreshChapterUI(slot0)
	slot0.chapterSelectTitleView_:OnEnter(slot0.selectChapterClientID_)
	slot0:RefreshGroupToggle()
	slot0:AddActivityTimer()
	slot0:RefreshActivity()
	slot0:RefreshLock()
end

function slot0.RefreshGroupToggle(slot0)
	slot1 = 0
	slot2 = 0
	slot3 = nil

	for slot7, slot8 in ipairs(slot0.groupDataList_) do
		if slot8[1] == 1 then
			if slot0.groupToggleItemList_[slot1 + 1] == nil then
				slot0.groupToggleItemList_[slot1] = ChapterSelectGroupToggleItem.New(slot0.groupToggleItem_, slot0.toggleItemParent_)
			end

			slot0.groupToggleItemList_[slot1]:SetData(slot8[2])
		else
			if slot0.chapterToggleItemList_[slot2 + 1] == nil then
				slot0.chapterToggleItemList_[slot2] = ChapterSelectChapterToggleItem.New(slot0.chapterToggleItem_, slot0.toggleItemParent_)
			end

			slot9 = slot0.selectChapterClientID_ == slot8[2]

			slot0.chapterToggleItemList_[slot2]:SetData(slot8[2], slot9)

			if slot9 then
				slot3 = slot0.chapterToggleItemList_[slot2]
			end
		end
	end

	for slot7 = slot1 + 1, #slot0.groupToggleItemList_ do
		slot0.groupToggleItemList_[slot7]:Show(false)
	end

	for slot7 = slot2 + 1, #slot0.chapterToggleItemList_ do
		slot0.chapterToggleItemList_[slot7]:Show(false)
	end

	if slot3 then
		slot0:AddMoveTimer(slot3)
	end
end

function slot0.RefreshActivity(slot0)
	slot0.activityController_:SetSelectedState(tostring(ActivityData:GetActivityIsOpen(ChapterCfg[ChapterClientCfg[slot0.selectChapterClientID_].chapter_list[1]].activity_id)))
end

function slot0.RefreshLock(slot0)
end

function slot0.RefreshSelectDifficult(slot0)
	slot0.hardLevelView_:SetData(slot0.hardLevel_)
end

function slot0.ChangeSelectChapterID(slot0)
	slot0:StopLeanTween()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.StopAllTimer(slot0)
	uv0.super.StopAllTimer(slot0)
	slot0:RemoveActivityTimer()
end

function slot0.AddActivityTimer(slot0)
	slot0:RemoveActivityTimer()

	if ChapterCfg[ChapterClientCfg[slot0.selectChapterClientID_].chapter_list[1]].activity_id == 0 then
		return
	end

	slot5 = ActivityData:GetActivityData(slot3):IsActivitying()
	slot0.activityTimer_ = Timer.New(function ()
		if ActivityData:GetActivityData(uv0):IsActivitying() ~= uv1 then
			uv1 = slot1
			uv2.isLock_ = not ChapterTools.IsFinishPreChapter(uv3)

			uv2:RefreshLock()
			uv2:RefreshActivity()
		end
	end, 1, -1)

	slot0.activityTimer_:Start()
end

function slot0.RemoveActivityTimer(slot0)
	if slot0.activityTimer_ then
		slot0.activityTimer_:Stop()

		slot0.activityTimer_ = nil
	end
end

return slot0
