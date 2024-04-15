slot0 = class("PuzzleNewPiece", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform
	slot0.parentTrans_ = slot1
	slot0.index_ = slot3
	slot0.correctID_ = slot4

	slot0:Init()
	SetActive(slot0.gameObject_, true)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.DragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
end

function slot0.Dispose(slot0)
	slot0.transform_ = nil
	slot0.gameObject_ = nil
	slot0.endDragCallback_ = nil

	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	slot0.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.lastID_ = slot0.curID_
	slot0.curID_ = slot1
	slot0.activityID_ = slot2

	slot0:RefreshUI()

	if slot3 and slot0.lastID_ ~= slot0.curID_ and slot0:IsRightSide() then
		slot0:PlayAnim()
	else
		slot0:StopAnim()
	end
end

function slot0.SetRegionID(slot0, slot1)
	slot0.regionID_ = slot1
end

function slot0.GetRegionID(slot0)
	return slot0.regionID_
end

function slot0.SetSelectCallBack(slot0, slot1)
	slot0.selectCallBack_ = slot1
end

function slot0.RefreshUI(slot0)
	if slot0.curID_ ~= 0 then
		slot1 = PuzzleNewCfg[slot0.activityID_]
		slot0.icon_.sprite = getSpriteWithoutAtlas(slot1.path .. slot1.picture_fragment_id[PuzzleNewTools.GetPuzzlePosDic(slot0.activityID_)[slot0.curID_]])
	end

	SetActive(slot0.gameObject_, slot0.curID_ ~= 0)
	slot0:Recover()
end

function slot0.Recover(slot0)
	if slot0.originPos_ then
		slot0.transform_.localPosition = slot0.originPos_
	end

	slot0.originPos_ = nil

	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	if slot0.curID_ ~= 0 then
		if not slot0:IsRightSide() then
			slot0.stateController_:SetSelectedState("wrong")
		else
			slot0.stateController_:SetSelectedState("correct")
		end
	else
		slot0.stateController_:SetSelectedState("normal")
	end
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

function slot0.RegistEndDragCallback(slot0, slot1)
	slot0.endDragCallback_ = slot1
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	slot0.originPos_ = slot0.transform_.localPosition

	slot0.transform_:SetAsLastSibling()
	slot0.stateController_:SetSelectedState("normal")
end

function slot0.DragFun(slot0, slot1, slot2)
	slot4, slot0.transform_.localPosition = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0.parentTrans_, slot2.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)
end

function slot0.EndDragFun(slot0, slot1, slot2)
	if slot0.endDragCallback_ then
		slot0.endDragCallback_(slot0.index_, slot2)
	end
end

function slot0.PlayAnim(slot0)
	SetActive(slot0.correctAnim_.gameObject, true)
	manager.audio:PlayEffect("minigame_activity_2_5", "minigame_activity_2_5_Puzzle_complete2", "")
end

function slot0.StopAnim(slot0)
	SetActive(slot0.correctAnim_.gameObject, false)
end

return slot0
