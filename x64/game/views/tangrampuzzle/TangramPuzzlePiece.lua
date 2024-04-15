slot0 = class("PuzzleNewPiece", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.globalIndex_ = slot2
	slot0.correctID_ = slot3

	slot0:Init()
	SetActive(slot0.gameObject_, true)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.icon_.alphaHitTestMinimumThreshold = 1
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.highLightController_ = ControllerUtil.GetController(slot0.transform_, "highLight")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.enterAnimController_ = ControllerUtil.GetController(slot0.transform_, "enterAnim")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.draging_ == true then
			return
		end

		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		manager.audio:PlayEffect("ui_system", "button", "")

		if uv0.clickCallback_ then
			uv0.clickCallback_(uv0.globalIndex_)
		end
	end)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.DragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
end

function slot0.Dispose(slot0)
	slot0.clickCallback_ = nil
	slot0.endDragCallback_ = nil
	slot0.beginDragCallback_ = nil

	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	slot0:StopLeanTween()
	uv0.super.Dispose(slot0)
end

function slot0.OnExit(slot0)
	slot0:StopAnimTimer()
	slot0:StopLeanTween()
	slot0:RecoverTrans()
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.lastID_ = slot0.curID_
	slot0.curID_ = slot1
	slot0.activityID_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.curID_ ~= 0 then
		slot0.icon_.sprite = getSpriteWithoutAtlas(TangramPuzzleCfg[slot0.activityID_].path .. TangramPuzzleTools.GetPuzzlePictureDic(slot0.activityID_)[slot0.curID_])

		slot0.icon_:SetNativeSize()
	end

	SetActive(slot0.gameObject_, slot0.curID_ ~= 0)
	slot0:StopAnimTimer()
	slot0.enterAnimController_:SetSelectedState("false")
end

function slot0.SetRegionID(slot0, slot1, slot2)
	slot0.regionID_ = slot1
	slot0.localIndex_ = slot2
end

function slot0.GetCurRegion(slot0)
	return slot0.regionID_, slot0.localIndex_
end

function slot0.GetGlobalIndex(slot0)
	return slot0.globalIndex_
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.RefreshStatus(slot0)
end

function slot0.SetHighLight(slot0, slot1)
	slot0.highLightController_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.IsRightSide(slot0)
	return slot0.correctID_ == slot0.curID_
end

function slot0.IsEmpty(slot0)
	return slot0.curID_ == 0
end

function slot0.GetCurID(slot0)
	return slot0.curID_
end

function slot0.SetTransParent(slot0, slot1)
	slot0.originParent_ = slot0.transform_.parent

	slot0.transform_:SetParent(slot1)
end

function slot0.RecoverTrans(slot0)
	if slot0.originPos_ then
		slot0.transform_.position = slot0.originPos_
		slot0.originPos_ = nil
	end

	if slot0.originParent_ then
		slot0.transform_:SetParent(slot0.originParent_)

		slot0.originParent_ = nil
	end
end

function slot0.RegistClickCallback(slot0, slot1)
	slot0.clickCallback_ = slot1
end

function slot0.RegistBeginDragCallback(slot0, slot1)
	slot0.beginDragCallback_ = slot1
end

function slot0.RegistEndDragCallback(slot0, slot1)
	slot0.endDragCallback_ = slot1
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	if slot0.beginDragCallback_ and not slot0.beginDragCallback_(slot0.globalIndex_) then
		return
	end

	slot0.draging_ = true
	slot0.originPos_ = slot0.transform_.position
	slot0.canvasRate_ = manager.ui.canvasSize_.x / Screen.width
end

function slot0.DragFun(slot0, slot1, slot2)
	if not slot0.draging_ then
		return
	end

	slot3 = slot2.delta * slot0.canvasRate_

	slot0.transform_:SetLocalPositionDelta(slot3.x, slot3.y, 0)
end

function slot0.EndDragFun(slot0, slot1, slot2)
	slot0.draging_ = false

	if slot0.endDragCallback_ then
		slot0.endDragCallback_(slot0.globalIndex_, slot2)
	end
end

function slot0.UpdatePosition(slot0, slot1, slot2)
	slot0.originPos_ = slot0.transform_.position

	slot0:StopLeanTween()

	slot0.posLeanTween_ = LeanTween.move(slot0.gameObject_, slot1, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0 then
			uv0()
		end

		uv1:StopLeanTween()
	end))
end

function slot0.PlayEnterAnim(slot0, slot1)
	SetActive(slot0.gameObject_, true)
	slot0.enterAnimController_:SetSelectedState("true")
	slot0:PlayAnim(slot0.anim_, "puzzleTemplate_enter", slot1)
end

function slot0.StopAnimTimer(slot0)
	if slot0.animtimer_ then
		slot0.animtimer_:Stop()

		slot0.animtimer_ = nil
	end
end

function slot0.StopLeanTween(slot0)
	if slot0.posLeanTween_ then
		slot0.posLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.posLeanTween_.id)

		slot0.posLeanTween_ = nil
	end
end

function slot0.PlayAnim(slot0, slot1, slot2, slot3)
	if not slot1 then
		if slot3 then
			slot3()
		end

		return
	end

	slot0:StopAnimTimer()

	slot1.enabled = true

	slot1:Play(slot2, -1, 0)
	slot1:Update(0)

	slot0.animtimer_ = Timer.New(function ()
		if uv0:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			uv2:StopAnimTimer()

			uv0.enabled = false

			if uv3 then
				uv3()
			end
		end
	end, 0.033, -1)

	slot0.animtimer_:Start()
end

return slot0
