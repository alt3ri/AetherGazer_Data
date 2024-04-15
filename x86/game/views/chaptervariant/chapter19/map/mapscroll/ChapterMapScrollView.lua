slot0 = class("ChapterMapScrollView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.parentView_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.windowHalfX_ = slot0.viewPortRect_.rect.width / 2
	slot0.windowHalfY_ = slot0.viewPortRect_.rect.height / 2
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	slot0:RemoveTween()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		uv0:EnabledScroll(true)
		uv0.scrollView_:OnBeginDrag(slot1)
	end))
	slot0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
	end))
	slot0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.parentView_:GetBackCnt() > 0 then
			LeanTween.cancel(uv0.contentRect_.gameObject)
			JumpTools.Back(slot2)
		end
	end))
	slot0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function (slot0, slot1)
	end))
	slot0.scrollViewEvent_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		slot2 = uv0.parentView_:GetBackCnt()

		if not slot1.dragging and slot2 > 0 then
			JumpTools.Back()
		end

		if slot2 <= 1 then
			uv0:EnabledScroll(true)
		else
			uv0:EnabledScroll(false)
		end
	end))
	slot0.scrollView_.onValueChanged:AddListener(function (slot0)
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerDown)
	slot0.scrollViewEvent_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	slot0.scrollView_.onValueChanged:RemoveAllListeners()
end

function slot0.ScrollToPosition(slot0, slot1)
	slot0:RemoveTween()
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentRect_)
	slot0:EnabledScroll(false)

	slot0.tween_ = LeanTween.moveLocal(slot0.contentRect_.gameObject, slot1 * -1, 0.5):setOnComplete(System.Action(function ()
		LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.contentRect_)
		uv0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function slot0.EnabledScroll(slot0, slot1)
	slot0.scrollView_.enabled = slot1
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

return slot0
