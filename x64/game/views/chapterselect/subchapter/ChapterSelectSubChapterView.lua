slot0 = class("ChapterSelectSubChapterView", ReduxView)
slot0.MAX_DRAG_LENGTH = 1500
slot0.MIN_DRAG_LENGTH = 200
slot0.SWITCH_STAGE_TIME = 0.8

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationSideUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.chapterSelectTitleView_ = ChapterSelectTitleView.New(slot0.titleGo_)
	slot0.changeSelectChapterHandler_ = handler(slot0, slot0.ChangeSelectChapterID)
	slot0.lockController_ = slot0.controllerEx_:GetController("lock")
	slot0.chapterToggleItemList_ = {}
	slot0.groupDataList_ = ChapterTools.GetChapterGroupList(BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT))
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INVITE_BAR
	})
	slot0:RefreshData()
	slot0:InitImage()
	slot0:RefreshUI()
	slot0.chapterSelectTitleView_:OnEnter(slot0.selectChapterClientID_)

	slot4 = CHANGE_PLOT_SELECT_CHAPTER
	slot5 = slot0.changeSelectChapterHandler_

	manager.notify:RegistListener(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.chapterToggleItemList_) do
		slot5:OnEnter()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.chapterSelectTitleView_:OnExit()

	slot4 = CHANGE_PLOT_SELECT_CHAPTER
	slot5 = slot0.changeSelectChapterHandler_

	manager.notify:RemoveListener(slot4, slot5)
	slot0:StopAllTimer()
	slot0:StopLeanTween()

	for slot4, slot5 in ipairs(slot0.chapterToggleItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0.changeSelectChapterHandler_ = nil
	slot0.chapterBehindImage_ = nil

	for slot4, slot5 in ipairs(slot0.chapterToggleItemList_) do
		slot5:Dispose()
	end

	slot0.chapterToggleItemList_ = nil

	slot0.chapterSelectTitleView_:Dispose()

	slot0.chapterSelectTitleView_ = nil

	slot0:RemoveListeners()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.DragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handler(slot0, slot0.PointerUpFun)))
	slot0.toggleEventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginToggleDragFun)))
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	slot0:StopLeanTween()
end

function slot0.DragFun(slot0, slot1, slot2)
	if ChapterTools.GetNeighborClientID(slot0.selectChapterClientID_, slot2.position.x - slot2.pressPosition.x < 0) == slot0.selectChapterClientID_ then
		return
	end

	if slot0.nextChapterClientID_ ~= slot4 then
		getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[slot4].chapter_paint, function (slot0)
			if uv0.chapterBehindImage_ then
				uv0.chapterBehindImage_.sprite = slot0
			end
		end)

		slot0.nextChapterClientID_ = slot4
	end

	slot5 = math.min(math.max(0, math.abs(slot3)), uv0.MAX_DRAG_LENGTH) / uv0.MAX_DRAG_LENGTH
	slot0.chapterFrontCanvasGroup_.alpha = 1 - slot5
	slot0.chapterBehindCanvasGroup_.alpha = slot5
end

function slot0.EndDragFun(slot0, slot1, slot2)
	if ChapterTools.GetNeighborClientID(slot0.selectChapterClientID_, slot2.position.x - slot2.pressPosition.x < 0) == slot0.selectChapterClientID_ then
		return
	end

	if uv0.MIN_DRAG_LENGTH < math.abs(slot3) then
		slot0.selectChapterClientID_ = slot0.nextChapterClientID_
		slot0.nextChapterClientID_ = nil

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT, slot0.selectChapterClientID_)
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

	if slot0.isLock_ and manager.time:GetServerTime() < ActivityData:GetActivityRefreshTime(slot0:GetActivityID()) then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot4)))

		return
	end

	JumpTools.Jump2SubPlot(slot0.selectChapterClientID_, false, true)
end

function slot0.BeginToggleDragFun(slot0, slot1, slot2)
	slot0:StopMoveTimer()
	slot0.scrollView_:OnBeginDrag(slot2)
end

function slot0.RemoveListeners(slot0)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	slot0.toggleEventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
end

function slot0.SwitchImageOver(slot0)
	slot0.chapterFrontImage_ = slot0.chapterBehindImage_
	slot0.chapterBehindImage_ = slot0.chapterFrontImage_
	slot0.chapterFrontCanvasGroup_ = slot0.chapterBehindCanvasGroup_
	slot0.chapterBehindCanvasGroup_ = slot0.chapterFrontCanvasGroup_
end

function slot0.AutoSwitchImage(slot0)
	getSpriteWithoutAtlasAsync(SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[slot0.selectChapterClientID_].chapter_paint, function (slot0)
		if uv0.chapterBehindImage_ then
			uv0.chapterBehindImage_.sprite = slot0
		end
	end)

	slot0.leanTweenHandler_ = LeanTween.value(slot0.chapterFrontImage_.gameObject, slot0.chapterFrontCanvasGroup_.alpha, 0, uv0.SWITCH_STAGE_TIME)

	slot0.leanTweenHandler_:setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.chapterFrontCanvasGroup_.alpha = slot0
		uv0.chapterBehindCanvasGroup_.alpha = 1 - slot0
	end))
	slot0.leanTweenHandler_:setOnComplete(System.Action(function ()
		uv0:SwitchImageOver()
		LeanTween.cancel(uv0.chapterFrontImage_.gameObject)
		uv0.leanTweenHandler_:setOnUpdate(nil):setOnComplete(nil)

		uv0.leanTweenHandler_ = nil
	end))
end

function slot0.RefreshData(slot0)
	slot0.selectChapterClientID_ = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)
	slot0.isLock_ = not ChapterTools.IsUnlockSubPlotClient(ChapterClientCfg[slot0.selectChapterClientID_].chapter_list[1])
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

function slot0.RefreshUI(slot0)
	slot0:RefreshChapterUI()
	slot0:AutoSwitchImage()
end

function slot0.RefreshChapterUI(slot0)
	slot0.chapterSelectTitleView_:OnEnter(slot0.selectChapterClientID_)
	slot0:RefreshGroupToggle()
	slot0:AddActivityTimer()
	slot0:RefreshActivity()
	slot0:RefreshLock()
end

function slot0.RefreshGroupToggle(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.groupDataList_) do
		if slot0.chapterToggleItemList_[slot5] == nil then
			slot0.chapterToggleItemList_[slot5] = ChapterSelectSubChapterToggleItem.New(slot0.chapterToggleItem_, slot0.chapterParentTf_, slot6[2])
		end

		slot7 = slot0.selectChapterClientID_ == slot6[2]

		slot0.chapterToggleItemList_[slot5]:SetSelect(slot7)

		if slot7 then
			slot1 = slot0.chapterToggleItemList_[slot5]
		end
	end

	if slot1 then
		slot0:AddMoveTimer(slot1)
	end
end

function slot0.RefreshActivity(slot0)
end

function slot0.RefreshLock(slot0)
	slot4 = tostring

	slot0.lockController_:SetSelectedState(slot4(slot0.isLock_))

	for slot4, slot5 in ipairs(slot0.chapterToggleItemList_) do
		slot5:RefreshLock()
	end
end

function slot0.RefreshSelectDifficult(slot0)
	slot0.hardLevelView_:SetData(slot0.hardLevel_)
end

function slot0.ChangeSelectChapterID(slot0)
	slot0:StopLeanTween()
	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.GetActivityID(slot0)
	return ChapterCfg[ChapterClientCfg[slot0.selectChapterClientID_].chapter_list[1]].activity_id or 0
end

function slot0.AddActivityTimer(slot0)
	slot0:RemoveActivityTimer()

	slot2 = ChapterClientCfg[slot0.selectChapterClientID_].chapter_list[1]

	if slot0:GetActivityID() == 0 then
		return
	end

	slot5 = ActivityData:GetActivityData(slot3):IsActivitying()
	slot0.activityTimer_ = Timer.New(function ()
		if ActivityData:GetActivityData(uv0):IsActivitying() ~= uv1 then
			uv1 = slot1
			uv2.isLock_ = not ChapterTools.IsUnlockSubPlotClient(uv3)

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

function slot0.AddMoveTimer(slot0, slot1)
	slot0:StopMoveTimer()

	slot0.moveTimer_ = FrameTimer.New(function ()
		slot2 = uv0.chapterParentTf_.anchoredPosition

		if uv0.scrollTf_.rect.width / 2 >= uv0.chapterParentTf_.rect.width / 2 + uv1:GetLocalPosition().x * -1 then
			slot3 = slot1 - slot0
		elseif slot1 >= slot0 - slot3 then
			slot3 = slot0 - slot1
		end

		uv0.chapterParentTf_.anchoredPosition = Vector2.Lerp(slot2, Vector2.New(slot3, slot2.y), 3 * math.pow(uv0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(slot2.x - slot3) <= 1 then
			uv0.chapterParentTf_.anchoredPosition = Vector2(slot3, slot2.y)

			uv0:StopMoveTimer()
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

function slot0.StopLeanTween(slot0)
	if slot0.leanTweenHandler_ then
		LeanTween.cancel(slot0.chapterFrontImage_.gameObject)
		slot0.leanTweenHandler_:callOnCompletes()
	end
end

function slot0.StopAllTimer(slot0)
	slot0:StopMoveTimer()
	slot0:RemoveActivityTimer()
end

return slot0
