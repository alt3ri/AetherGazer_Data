slot0 = class("LuaScroller")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.uiScrollerGo_ = slot2
	slot0.itemClass_ = slot3
	slot0.itemRenderer_ = slot1
	slot0.itemOfInstanceID_ = {}
	slot0.itemOfIndex_ = {}

	slot0:InitUI()
	slot0:AddListeners()

	if not slot0.ctored_ then
		ReduxFactory.GetInstance():OnManagedObjCtor(slot0)
	end

	slot0.ctored_ = true
end

function slot0.InitUI(slot0)
	slot0.uiScroller_ = slot0.uiScrollerGo_:GetComponent("UIScroller")
	slot0.emptyController_ = ControllerUtil.GetController(slot0.uiScrollerGo_.transform, "empty")
end

function slot0.AddListeners(slot0)
	if slot0.uiScroller_ ~= nil then
		slot0.uiScroller_:SetItemRenderer(handler(slot0, slot0.ItemRenderer))
	end
end

function slot0.RemoveListeners(slot0)
	if slot0.uiScroller_ ~= nil then
		slot0.uiScroller_:SetItemRenderer(nil)
	end
end

function slot0.ItemRenderer(slot0, slot1, slot2)
	slot3 = slot1 + 1
	slot5 = nil

	if slot0.itemOfInstanceID_[slot2:GetInstanceID()] then
		slot5 = slot0.itemOfInstanceID_[slot4]
	else
		slot0.itemOfInstanceID_[slot4] = slot0.itemClass_.New(slot2)
	end

	slot0.itemOfIndex_[slot1 + 1] = slot5

	if slot0.itemRenderer_ then
		slot0.itemRenderer_(slot3, slot5)
	end
end

function slot0.GetItemByIndex(slot0, slot1)
	slot2, slot3 = slot0:GetHeadAndTail()

	if slot2 == 0 then
		return
	end

	if slot1 < slot2 or slot3 < slot1 then
		return nil
	end

	return slot0.itemOfIndex_[slot1]
end

function slot0.RemoveTween(slot0)
	slot0.uiScroller_:RemoveTween()
end

function slot0.GetItemList(slot0)
	slot1 = {}
	slot2, slot3 = slot0:GetHeadAndTail()

	if slot2 == 0 then
		return {}
	end

	for slot7 = slot2, slot3 do
		slot1[slot7] = slot0.itemOfIndex_[slot7]
	end

	return slot1
end

function slot0.GetHeadAndTail(slot0)
	slot1 = slot0.uiScroller_:GetHeadAndTail()

	return slot1.x + 1, slot1.y + 1
end

function slot0.StartScroll(slot0, slot1, slot2, slot3, slot4)
	slot0:UpdateUIList(slot1)

	slot0.num_ = slot1

	if (slot2 or 0) - 1 >= 0 then
		slot0.uiScroller_:ScrollToIndex(slot5, slot3, slot4)
	end
end

function slot0.ScrollToIndex(slot0, slot1, slot2, slot3, slot4)
	slot0.uiScroller_:ScrollToIndex(slot1 - 1, slot2 or false, slot3 or false, slot4 or 0.2)
end

function slot0.StartScrollWithoutAnimator(slot0, slot1, slot2)
	slot0.num_ = slot1

	slot0.uiScroller_:SetNumItems(slot1, true)

	if slot2 then
		slot0.uiScroller_:SetScrolledPosition(slot2)
	end
end

function slot0.Refresh(slot0)
	slot1, slot2 = slot0:GetHeadAndTail()

	if slot1 == 0 then
		return
	end

	for slot6 = slot1, slot2 do
		if slot0.itemRenderer_ and slot0.itemOfIndex_[slot6] then
			slot0.itemRenderer_(slot6, slot7)
		end
	end
end

function slot0.SetScrolledPosition(slot0, slot1)
	slot0.uiScroller_:SetScrolledPosition(slot1)
end

function slot0.GetScrolledPosition(slot0)
	return slot0.uiScroller_:GetScrolledPosition()
end

function slot0.StartScrollByPosition(slot0, slot1, slot2)
	slot0.num_ = slot1

	slot0:UpdateUIList(slot1)
	slot0:SetScrolledPosition(slot2)
end

function slot0.UpdateUIList(slot0, slot1)
	slot0.uiScroller_:SetNumItems(slot1)

	if slot0.emptyController_ ~= nil then
		slot0.emptyController_:SetSelectedState(slot1 == 0 and "true" or "false")
	end
end

function slot0.StopRender(slot0)
	if slot0.uiScroller_ then
		slot0.uiScroller_:StopRender()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	if slot0.uiScroller_ ~= nil then
		slot0.uiScroller_:StopRender()

		slot0.uiScroller_ = nil
	end

	if slot0.itemOfInstanceID_ then
		for slot4, slot5 in pairs(slot0.itemOfInstanceID_) do
			slot5:Dispose()
		end

		slot0.itemOfInstanceID_ = nil
	end

	slot0.pageChangeHandler_ = nil

	ReduxFactory.GetInstance():OnManagedObjDisposed(slot0)
end

function slot0.GetNum(slot0)
	return slot0.num_
end

return slot0
