slot0 = class("ChaperSelectBaseView", ReduxView)
slot0.MAX_DRAG_LENGTH = 1500
slot0.MIN_DRAG_LENGTH = 200
slot0.SWITCH_STAGE_TIME = 0.8

function slot0.UIName(slot0)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.hardController_ = slot0.controllerEx_:GetController("isSubPlot")
	slot0.activityController_ = slot0.controllerEx_:GetController("isActivity")
	slot0.chapterSelectTitleView_ = ChapterSelectTitleView.New(slot0.titleGo_)
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
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.chapterSelectTitleView_:OnExit()
	slot0:StopAllTimer()
	slot0:StopLeanTween()
end

function slot0.Dispose(slot0)
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
end

function slot0.AddMoveTimer(slot0, slot1)
	slot0:StopMoveTimer()

	slot0.moveTimer_ = FrameTimer.New(function ()
		slot2 = uv0.contentTf_.anchoredPosition

		if uv0.scrollTf_.rect.width / 2 >= uv0.contentTf_.rect.width / 2 + uv1:GetLocalPosition().x * -1 then
			slot3 = slot1 - slot0
		elseif slot1 >= slot0 - slot3 then
			slot3 = slot0 - slot1
		end

		uv0.contentTf_.anchoredPosition = Vector2.Lerp(slot2, Vector2.New(slot3, slot2.y), 3 * math.pow(uv0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(slot2.x - slot3) <= 1 then
			uv0.contentTf_.anchoredPosition = Vector2(slot3, slot2.y)

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
end

return slot0
