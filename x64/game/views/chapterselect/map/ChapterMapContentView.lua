slot0 = class("ChapterMapContentView", ReduxView)
slot0.SWITCH_STAGE_TIME = 0.8

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationMainUI_new"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.itemList_ = {}
	slot0.positionList_ = {}
	slot0.mainPlotChapterToggleList_ = {}

	slot0:InitUI()
	slot0:AddListeners()

	slot0.changeSelectChapterHandler_ = handler(slot0, slot0.ChangeSelectChapterID)
	slot4 = slot0.ChangeSelectHardLevel
	slot0.changeSelectHardLevelHandler_ = handler(slot0, slot4)

	for slot4 = 1, 4 do
		slot0.itemList_[slot4] = ChapterMapItemView.New(slot0.mapItem_, slot0.itemParent_)
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.viewportTransform_ = slot0.mapViewPort_.transform
	slot0.hardLevelView_ = HardLevelChapterView.New(slot0.difficultPanel_)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	slot0.hardLevelView_:OnEnter()
	slot0:RefreshData()
	slot0:RefreshUI()
	manager.notify:RegistListener(CHANGE_PLOT_SELECT_CHAPTER, slot0.changeSelectChapterHandler_)
	manager.notify:RegistListener(CHANGE_PLOT_HARD_LEVEL, slot0.changeSelectHardLevelHandler_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:StopAllTimer()
	manager.notify:RemoveListener(CHANGE_PLOT_SELECT_CHAPTER, slot0.changeSelectChapterHandler_)

	slot4 = CHANGE_PLOT_HARD_LEVEL
	slot5 = slot0.changeSelectHardLevelHandler_

	manager.notify:RemoveListener(slot4, slot5)
	slot0.hardLevelView_:OnExit()

	slot0.viewSelectID_ = nil

	for slot4, slot5 in pairs(slot0.mainPlotChapterToggleList_) do
		slot5:OnExit()
	end

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5:OnExit()
	end

	slot0.isFirstEnter_ = false

	slot0:StopLeanTween()
end

function slot0.Dispose(slot0)
	slot0.changeSelectChapterHandler_ = nil
	slot0.changeSelectHardLevelHandler_ = nil

	slot0.scrollRect_.onValueChanged:RemoveAllListeners()
	slot0.hardLevelView_:Dispose()

	slot0.hardLevelView_ = nil

	for slot4, slot5 in pairs(slot0.mainPlotChapterToggleList_) do
		slot5:Dispose()
	end

	slot0.mainPlotChapterToggleList_ = nil

	slot0:RemoveListeners()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = {}

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.DragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
	slot0.scrollRect_.onValueChanged:AddListener(function ()
		uv0:RefreshItemPosition()
	end)
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	slot0:StopMoveTimer()
	slot0:StopSnapTimer()
	slot0:AddToggleTimer()
end

function slot0.DragFun(slot0, slot1, slot2)
	if GameSetting.chapter_scroll_length_threshold.value[1] < math.abs(slot2.position.x - slot2.pressPosition.x) then
		slot0:RefreshSelectChapter(0)
	end
end

function slot0.EndDragFun(slot0, slot1, slot2)
	manager.audio:PlayUIAudioByVoice("stage_slide")
	slot0:AddSnapTimer()
end

function slot0.StopMoveAction(slot0)
	slot0:RefreshSelectChapter(slot0.selectChapterClientID_)
	slot0:AutoSwitchImage()
end

function slot0.InitImage(slot0)
	getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[slot0.selectChapterClientID_].chapter_paint, function (slot0)
		if uv0.chapterBehindImage_ then
			uv0.chapterBehindImage_.sprite = slot0
		end

		if uv0.chapterFrontImage_ then
			uv0.chapterFrontImage_.sprite = slot0
		end
	end)
end

function slot0.AutoSwitchImage(slot0)
	getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[slot0.selectChapterClientID_].chapter_paint, function (slot0)
		if uv0.chapterBehindImage_ then
			uv0.chapterBehindImage_.sprite = slot0
		end
	end)
	slot0:StopLeanTween()

	slot0.leanTweenHandler_ = LeanTween.value(slot0.chapterFrontImage_.gameObject, slot0.chapterFrontCanvasGroup_.alpha, 0, uv0.SWITCH_STAGE_TIME)

	slot0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.chapterFrontCanvasGroup_.alpha = slot0
		uv0.chapterBehindCanvasGroup_.alpha = 1 - slot0
	end))
	slot0.leanTweenHandler_:setOnComplete(System.Action(function ()
		uv0:SwitchImageOver()
		uv0:StopLeanTween()
	end))
end

function slot0.StopLeanTween(slot0)
	if slot0.leanTweenHandler_ then
		LeanTween.cancel(slot0.chapterFrontImage_.gameObject)
		slot0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		slot0.leanTweenHandler_ = nil
	end
end

function slot0.SwitchImageOver(slot0)
	slot0.chapterFrontImage_ = slot0.chapterBehindImage_
	slot0.chapterBehindImage_ = slot0.chapterFrontImage_
	slot0.chapterFrontCanvasGroup_ = slot0.chapterBehindCanvasGroup_
	slot0.chapterBehindCanvasGroup_ = slot0.chapterFrontCanvasGroup_
end

function slot0.RemoveListeners(slot0)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
end

function slot0.RefreshData(slot0)
	slot0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)
	slot0.hardLevel_ = ChapterClientCfg[slot0.selectChapterClientID_].difficulty
	slot0.chapterList_ = {}

	for slot5, slot6 in ipairs(getChapterClientList()[slot0.hardLevel_]) do
		if ChapterTools.HasChapterStage(slot6) then
			table.insert(slot0.chapterList_, slot6)
		end
	end

	slot0.maxChapterLevel_ = #slot0.chapterList_
end

function slot0.RefreshUI(slot0)
	slot0:InitImage()
	slot0:RefreshViewContent()
	slot0:ChangeSelectChapterID()
	slot0:RefreshSelectDifficult()
	slot0:RefreshSelectChapter(slot0.selectChapterClientID_)
	slot0:RefreshToggle()
end

function slot0.ChangeSelectHardLevel(slot0)
	slot0:RefreshData()
	slot0:RefreshSelectChapter(0)
	slot0:RefreshViewContent()
	slot0:RefreshItemPosition()
	slot0:RefreshSelectDifficult()
	slot0:RefreshToggle()

	slot0.changeLevel_ = true
end

function slot0.RefreshToggle(slot0)
	for slot5, slot6 in ipairs(ChapterMainPlotToggleCfg.get_id_list_by_difficulty[slot0.hardLevel_]) do
		slot7 = slot0.mainPlotChapterToggleList_[slot5] or ChapterMapToggleView.New(slot0.chapterItem_, slot0.chapterParentGo_)
		slot0.mainPlotChapterToggleList_[slot5] = slot7

		slot7:SetData(slot6)
	end

	for slot5 = #slot1 + 1, #slot0.mainPlotChapterToggleList_ do
		slot0.mainPlotChapterToggleList_[slot5]:Show(false)
	end

	slot0:RefreshSelectChapterToggle()
end

function slot0.RefreshSelectChapter(slot0, slot1)
	if slot0.viewSelectID_ == slot1 then
		return
	end

	slot0.viewSelectID_ = slot1

	for slot5, slot6 in ipairs(slot0.itemList_) do
		slot6:SetSelectID(slot1)
	end
end

function slot0.RefreshSelectChapterToggle(slot0)
	slot0.scrollTimer_ = FrameTimer.New(function ()
		slot0, slot1 = uv0:GetToggleIndex()

		if uv0.lastToggleIndx_ == slot0 then
			return
		end

		uv0.lastToggleIndx_ = slot0

		if uv0.viewTf_:InverseTransformPoint(uv0.mainPlotChapterToggleList_[slot0]:GetTransform():TransformPoint(Vector3(0, 0, 0))).x <= 0 or uv0.viewTf_.rect.width <= slot2.x then
			if (slot0 - 1) / ((uv0.contentTf_.rect.width - uv0.viewTf_.rect.width) / (uv0.itemTf_.rect.width + uv0.contentLayout_.spacing)) > 1 then
				slot3 = 1
			elseif slot3 < 0 then
				slot3 = 0
			end

			uv0.scrollView_.horizontalNormalizedPosition = slot3
		end

		for slot6, slot7 in pairs(uv0.mainPlotChapterToggleList_) do
			slot7:SetSelectID(uv0.selectChapterClientID_)
		end
	end, 1, 1)

	slot0.scrollTimer_:Start()
end

function slot0.GetToggleIndex(slot0)
	for slot5, slot6 in ipairs(ChapterMainPlotToggleCfg.get_id_list_by_difficulty[slot0.hardLevel_]) do
		if table.keyof(ChapterMainPlotToggleCfg[slot6].chapter_client_list, slot0.selectChapterClientID_) then
			return slot5, #slot1
		end
	end

	return #slot1, #slot1
end

function slot0.RefreshViewContent(slot0)
	slot1 = slot0.mapItemTf_.rect.width
	slot2 = slot0.layoutGroup_.spacing
	slot3 = slot0.layoutGroup_.padding.left
	slot4 = slot0.layoutGroup_.padding.right

	for slot9, slot10 in ipairs(slot0.chapterList_) do
		slot5 = 0 + 1

		if slot0.positionList_[slot9] == nil then
			slot0.positionList_[slot9] = Vector3(slot3 + (slot1 + slot2) * (slot9 - 1) + slot1 / 2, 0, 0)
		end
	end

	slot0.mapItemParentTf_.sizeDelta = Vector2(slot3 + slot1 * slot5 + slot2 * (slot5 - 1) + slot4 - slot0.viewportTransform_.rect.width, slot0.mapItemParentTf_.sizeDelta.y)
end

function slot0.IsDisplayItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemList_) do
		if slot1 == slot6:GetChapterClientID() then
			return slot5
		end
	end
end

function slot0.RefreshItemPosition(slot0)
	slot1, slot2 = slot0:CalcStartToEndIndex()
	slot4 = {}

	for slot8 = slot1, slot2 do
		if slot0:IsDisplayItem(slot0.chapterList_[slot8]) then
			slot0.itemList_[slot10]:SetChapterClientID(slot0.chapterList_[slot8])
			slot0.itemList_[slot10]:SetLocalPosition(slot0.positionList_[slot8])
			table.insert({}, slot10)
		else
			table.insert(slot4, slot8)
		end
	end

	for slot8, slot9 in ipairs(slot4) do
		for slot13, slot14 in ipairs(slot0.itemList_) do
			if not table.keyof(slot3, slot13) then
				table.insert(slot3, slot13)
				slot14:SetChapterClientID(slot0.chapterList_[slot9])
				slot14:SetLocalPosition(slot0.positionList_[slot9])

				break
			end
		end
	end

	for slot8 = 1, #slot0.itemList_ do
		if not table.keyof(slot3, slot8) then
			slot0.itemList_[slot8]:Show(false)
		end
	end
end

function slot0.CalcStartToEndIndex(slot0)
	slot1 = slot0.viewportTransform_.rect.width
	slot2 = slot0.mapItemTf_.rect.width / 2
	slot3 = 1
	slot4 = 1

	for slot9, slot10 in ipairs(slot0.chapterList_) do
		if slot0.positionList_[slot9].x + slot0.mapItemParentTf_.localPosition.x + slot2 < 0 then
			slot3 = slot9
		end

		if slot12 + slot2 >= 0 and slot1 >= slot12 - slot2 then
			slot4 = slot9
		end
	end

	if slot4 < slot3 then
		slot4 = slot3
	end

	return slot3, slot4
end

function slot0.RefreshSelectDifficult(slot0)
	slot0.hardLevelView_:SetData(slot0.hardLevel_, 0)
end

function slot0.ChangeSelectChapterID(slot0)
	slot0:RefreshData()
	slot0:StopAllTimer()
	slot0.scrollRect_:StopMovement()

	if slot0.changeLevel_ or not slot0.isFirstEnter_ then
		slot2 = slot0.mapItemParentTf_.localPosition
		slot0.mapItemParentTf_.localPosition = Vector3(slot0:GetItemPositionX(slot0.selectChapterClientID_), slot2.y, slot2.z)

		slot0:RefreshItemPosition()
		slot0:StopMoveAction()
	else
		slot0:AddMoveTimer(slot1)
	end

	slot0:RefreshSelectChapterToggle()

	if slot0.changeLevel_ or not slot0.isFirstEnter_ then
		slot0.changeLevel_ = false
		slot0.isFirstEnter_ = true
	else
		slot0:RefreshSelectChapter(0)
	end
end

function slot0.ChangeSelectID(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 == BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT) then
		return
	end

	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, slot1)
	slot0:RefreshSelectChapterToggle()
end

function slot0.SearchNearClientID(slot0)
	slot1 = nil
	slot3 = slot0.viewportTransform_.localPosition.x + slot0.viewportTransform_.rect.width / 2

	for slot7, slot8 in ipairs(slot0.chapterList_) do
		if math.abs(slot0.positionList_[slot7].x + slot0.mapItemParentTf_.localPosition.x - slot0.viewportTransform_.rect.width / 2) <= 200000 then
			slot2 = slot10
			slot1 = slot8
		end
	end

	return slot1
end

function slot0.GetItemPositionX(slot0, slot1)
	slot3 = slot0.mapItemParentTf_.localPosition

	return -slot0.positionList_[table.keyof(slot0.chapterList_, slot1)].x + slot0.viewportTransform_.rect.width / 2
end

function slot0.AddSnapTimer(slot0)
	slot0:StopSnapTimer()

	slot0.snapTimer_ = FrameTimer.New(function ()
		if uv0.scrollRect_.velocity.x > -200 and uv0.scrollRect_.velocity.x < 200 then
			uv0.scrollRect_:StopMovement()

			slot0 = uv0:SearchNearClientID()
			uv0.selectChapterClientID_ = slot0

			uv0:ChangeSelectID(slot0)
			uv0:AddMoveTimer(uv0:GetItemPositionX(slot0))
			uv0:StopSnapTimer()
		end
	end, 1, -1)

	slot0.snapTimer_:Start()
end

function slot0.StopSnapTimer(slot0)
	if slot0.snapTimer_ then
		slot0.snapTimer_:Stop()

		slot0.snapTimer_ = nil
	end
end

function slot0.AddMoveTimer(slot0, slot1)
	slot0:StopMoveTimer()

	slot0.moveTimer_ = FrameTimer.New(function ()
		slot0 = uv0.mapItemParentTf_.localPosition

		if math.abs(slot0.x - Vector3.Lerp(slot0, Vector3.New(uv1, slot0.y, slot0.z), GameSetting.chapter_velocity_times.value[1] * math.pow(uv0.scrollRect_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime).x) < GameSetting.chapter_scroll_min_length.value[1] then
			if slot3 < math.abs(uv1 - slot0.x) then
				slot4 = slot3 * slot4 / math.abs(slot4)
			end

			slot2.x = slot2.x + slot4
		end

		uv0.mapItemParentTf_.anchoredPosition = slot2

		if math.abs(slot0.x - uv1) <= GameSetting.chapter_stop_min_length.value[1] then
			uv0.scrollView_:StopMovement()

			uv0.mapItemParentTf_.anchoredPosition = Vector3(uv1, slot0.y, slot0.z)

			uv0:StopToggleTimer()
			uv0:StopMoveTimer()
			uv0:StopMoveAction()
		end
	end, 1, -1)

	slot0.moveTimer_:Start()
end

function slot0.StopMoveTimer(slot0)
	if slot0.moveTimer_ then
		slot0.moveTimer_:Stop()

		slot0.moveTimer_ = nil
	end
end

function slot0.AddToggleTimer(slot0)
	slot0:StopToggleTimer()

	slot0.toggleTimer_ = FrameTimer.New(function ()
		slot0 = uv0:SearchNearClientID()
		uv0.selectChapterClientID_ = slot0

		uv0:ChangeSelectID(slot0)
	end, 1, -1)

	slot0.toggleTimer_:Start()
end

function slot0.StopToggleTimer(slot0)
	if slot0.toggleTimer_ then
		slot0.toggleTimer_:Stop()

		slot0.toggleTimer_ = nil
	end
end

function slot0.StopAllTimer(slot0)
	slot0:StopMoveTimer()
	slot0:StopSnapTimer()
	slot0:StopToggleTimer()
end

return slot0
