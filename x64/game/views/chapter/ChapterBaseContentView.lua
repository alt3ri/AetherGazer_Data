slot0 = class("ChapterBaseContentView", ReduxView)
slot0.CIRCLE_RADIUS = 1425
slot0.ELLIPSE_A = 1425
slot0.ELLIPSE_B = 1425
slot0.ELLIPSE_SQUARE_A = slot0.ELLIPSE_A * slot0.ELLIPSE_A
slot0.ELLIPSE_SQUARE_B = slot0.ELLIPSE_B * slot0.ELLIPSE_B

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterToggle_ = slot2
	slot0.itemList_ = {}

	slot0:InitUI()

	slot0.ChangeSelectChapterHandler_ = handler(slot0, slot0.ChangeSelectChapter)
	slot0.layoutGroup_.padding.left = slot0.scrollTf_.rect.width / 2
	slot0.layoutGroup_.padding.right = slot0.scrollTf_.rect.width / 2
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(CHANGE_DUNGEON, slot0.ChangeSelectChapterHandler_)
	slot0:RefreshData()
	slot0:RefreshUI()
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
end

function slot0.OnExit(slot0)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	slot4 = CHANGE_DUNGEON
	slot5 = slot0.ChangeSelectChapterHandler_

	manager.notify:RemoveListener(slot4, slot5)

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5.virtualItem:OnExit()
		slot5.renderItem:OnExit()
	end

	slot0:StopMoveTimer()
	slot0:StopScrollTimer()
end

function slot0.Dispose(slot0)
	slot0.ChangeSelectChapterHandler_ = nil

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5.virtualItem:Dispose()
		slot5.renderItem:Dispose()
	end

	slot0.itemList_ = nil
	slot0.scrollView_ = nil
	slot0.mapItem_ = nil
	slot0.itemParent_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.lockController_ = slot0.btnControllerEx_:GetController("lock")
	slot0.selectController_ = slot0.controllerEx_:GetController("select")
end

function slot0.AddListeners(slot0)
	slot0:AddToggleListener(slot0.scrollView_, function (slot0)
		uv0:RefreshItemPosition()
	end)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:GetSelectItem().renderItem:InvokeBtn()
	end)
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	slot0:StopMoveTimer()
	slot0:StopScrollTimer()
	slot0.scrollView_:OnBeginDrag(slot2)
	slot0.selectController_:SetSelectedState("false")
	slot0:PlayAnimatorExit()
end

function slot0.EndDragFun(slot0, slot1, slot2)
	slot0.scrollView_:OnEndDrag(slot2)
	slot0:AddScrollTimer()
end

function slot0.AddScrollTimer(slot0)
	slot0:StopScrollTimer()

	slot0.scrollTimer_ = nil
	slot0.scrollTimer_ = FrameTimer.New(function ()
		if math.abs(uv0.scrollView_.velocity.x) <= 100 then
			uv0.scrollTimer_:Stop()
			uv0:AdjustItem()
		end
	end, 1, -1)

	slot0.scrollTimer_:Start()
end

function slot0.StopScrollTimer(slot0)
	if slot0.scrollTimer_ then
		slot0.scrollTimer_:Stop()

		slot0.scrollTimer_ = nil
	end
end

function slot0.AdjustItem(slot0)
	BattleFieldData:SetCacheChapterClient(slot0.chapterToggle_, slot0:GetNearestItem().renderItem:GetChapterClientID())
	slot0:ChangeSelectChapter(true)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 then
		slot0:RefreshItemPosition()
		slot0:PlayAnimatorEnter()
	end
end

function slot0.RefreshData(slot0)
	slot0.selectClientID_ = BattleFieldData:GetCacheChapterClient(slot0.chapterToggle_)
end

function slot0.RefreshUI(slot0)
	slot0:RefreshMapItems()

	for slot4, slot5 in pairs(slot0.itemList_) do
		slot5.virtualItem:OnEnter()
		slot5.renderItem:OnEnter()
	end

	slot0:RefreshSortItem()
	FrameTimer.New(function ()
		uv0:OverMoveAction()
		uv0:RefreshItemPosition()
	end, 1, 1):Start()
end

function slot0.RefreshChapterUI(slot0)
	slot1 = ChapterClientCfg[slot0.selectClientID_]
	slot0.nameText_.text = GetI18NText(slot1.name)

	SetSpriteWithoutAtlasAsync(slot0.mapImage_, SpritePathCfg.ChapterPaint.path .. slot1.chapter_paint)

	slot3 = slot0:GetSelectItem().renderItem:GetLockState()

	slot0.lockController_:SetSelectedState(tostring(slot3))

	if slot3 then
		slot0.lockText_.text = slot2.renderItem:GetLockTips(slot0.lockTips_)
	end

	if slot0.gameObject_.activeInHierarchy then
		slot0.bgAnimator_:Play("Fx_base_cx", 0, 0)
	end

	slot0:PlayAnimatorEnter()
end

function slot0.RefreshMapItems(slot0)
end

function slot0.GetToggleID(slot0)
end

function slot0.RefreshSortItem(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.itemList_) do
		if slot7.renderItem:GetLockState() then
			table.insert(slot2, slot7)
		else
			table.insert(slot1, slot7)
		end
	end

	slot6 = slot2

	table.insertto(slot1, slot6)

	for slot6, slot7 in ipairs(slot1) do
		slot7.virtualItem:SetSiblingIndex(slot6)
	end
end

function slot0.ChangeSelectChapter(slot0, slot1)
	if not slot1 then
		slot0:PlayAnimatorExit()
	end

	slot0:RefreshData()
	slot0:Scroll2SelectItem()
end

function slot0.Scroll2SelectItem(slot0)
	slot4 = "false"

	slot0.selectController_:SetSelectedState(slot4)

	for slot4, slot5 in ipairs(slot0.itemList_) do
		if slot5.renderItem:GetChapterClientID() == slot0.selectClientID_ then
			slot0:AddMoveTimer(slot5)
		end
	end
end

function slot0.RefreshItemPosition(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot8 = 0
		slot9 = -1 * uv0.CIRCLE_RADIUS
		slot10 = (slot5.virtualItem:GetLocalPosition().x + slot0.contentTf_.localPosition.x) * math.pi / 3600

		slot5.renderItem:SetPosition(math.cos(slot10) * slot8 - math.sin(slot10) * slot9 - slot0.contentTf_.localPosition.x, uv0.CIRCLE_RADIUS + math.cos(slot10) * slot9 + math.sin(slot10) * slot8 + 220, 1)
	end
end

function slot0.GetEllipseYValue(slot0, slot1)
	if uv0.ELLIPSE_SQUARE_B - uv0.ELLIPSE_SQUARE_B / uv0.ELLIPSE_SQUARE_A * slot1 * slot1 < 0 then
		slot2 = 0
	end

	return math.sqrt(slot2)
end

function slot0.GetCircleYValue(slot0, slot1)
	if uv0.CIRCLE_RADIUS < math.abs(slot0.contentTf_.localPosition.x + slot1) then
		slot1 = slot2
	end

	return math.sqrt(slot2 * slot2 - slot1 * slot1)
end

function slot0.GetSelectItem(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		if slot5.renderItem:GetChapterClientID() == slot0.selectClientID_ then
			return slot5
		end
	end

	return slot0.itemList_[1]
end

function slot0.GetNearestItem(slot0)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.itemList_) do
		if math.abs(slot0.contentTf_.localPosition.x + slot7.virtualItem:GetLocalPosition().x) < 9999 then
			slot1 = slot8
			slot2 = slot7
		end
	end

	return slot2
end

function slot0.OverMoveAction(slot0)
	slot0.selectController_:SetSelectedState("true")

	slot1 = slot0.contentTf_.localPosition
	slot0.contentTf_.localPosition = Vector3(slot0:GetSelectItem().virtualItem:GetLocalPosition().x * -1, slot1.y, slot1.z)

	slot0:RefreshChapterUI()
end

function slot0.PlayAnimatorEnter(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		if slot5.renderItem:GetChapterClientID() == slot0.selectClientID_ then
			slot5.renderItem:PlayAnimatorEnter()
		end
	end
end

function slot0.PlayAnimatorExit(slot0)
	for slot4, slot5 in ipairs(slot0.itemList_) do
		if slot5.renderItem:GetChapterClientID() == slot0.selectClientID_ then
			slot5.renderItem:PlayAnimatorExit()
		end
	end
end

function slot0.AddMoveTimer(slot0, slot1)
	slot0:StopMoveTimer()

	slot2 = slot0.contentTf_.localPosition
	slot0.moveTimer_ = FrameTimer.New(function ()
		slot0 = uv0.contentTf_.rect.width / 2
		slot1 = uv0.scrollTf_.rect.width / 2
		slot2 = uv0.contentTf_.localPosition

		if math.abs(slot2.x - Vector3.Lerp(slot2, Vector3.New(uv1.virtualItem:GetLocalPosition().x * -1, slot2.y, slot2.z), GameSetting.challenge_velocity_times.value[1] * math.pow(uv0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime).x) < GameSetting.challenge_scroll_min_length.value[1] then
			if slot6 < math.abs(slot3 - slot2.x) then
				slot7 = slot6 * slot7 / math.abs(slot7)
			end

			slot5.x = slot5.x + slot7
		end

		uv0.contentTf_.localPosition = slot5

		if math.abs(uv0.contentTf_.localPosition.x - slot3) <= GameSetting.challenge_stop_min_length.value[1] then
			uv0.scrollView_:StopMovement()
			uv0:StopMoveTimer()
			uv0:OverMoveAction()
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

return slot0
